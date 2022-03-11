// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.12;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "../interfaces/Registry.sol";

contract Twitter is Registry, ChainlinkClient {
    using Chainlink for Chainlink.Request;

    // Temporary
    uint256 private fee = 1**14; // 0.0001 LINK
    address private oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
    bytes32 private jobID = "29fa9aa13bf1468788b7cc4a500a45b8";

    // Mapping of Twitter handle to wallet address
    mapping(bytes32 => address) private records;

    // Mapping of proof Tweet ID to wallet address
    mapping(address => uint128) private proofs;

    // Requires a Chainlink Oracle fee be paid
    modifier oracleFee(uint256 price) {
        require(
            LinkTokenInterface(chainlinkTokenAddress()).transferFrom(
                msg.sender,
                address(this),
                price
            ),
            "ERROR_ORACLE_FEE_NOT_PAID"
        );
        _;
    }

    function _sendChainlinkRequest(uint128 tweetID) private {
        Chainlink.Request memory request = buildChainlinkRequest(
            jobID,
            address(this),
            this.fulfill.selector
        );
        request.addUint("tweetID", uint256(tweetID));
        sendChainlinkRequestTo(oracle, request, fee);
    }

    /// Given an ID for a Tweet, triggers the Chainlink network to start verifying the account
    /// @param tweetID the ID of the Tweet to verify ownership of
    function verify(bytes32 tweetID) external virtual override oracleFee(fee) {
        _sendChainlinkRequest(uint128(uint256(tweetID)));
    }

    /// Disputes a Twitter account that may have been deleted, privatized, or lost ownership
    /// @param twitterHandle the Twitter handle that is being disputed
    function dispute(bytes32 twitterHandle) external virtual override {
        _sendChainlinkRequest(proofs[records[twitterHandle]]);
    }

    /// Chainlink Oracle fulfiller which sets the record owner address to the verified user or 0x0
    /// @dev this method is only called by the Oracle contract
    function fulfill(
        bytes32 _requestId,
        bytes32 _twitterHandle,
        uint128 _proof,
        address _address
    ) external recordChainlinkFulfillment(_requestId) {
        // Protect against malicious callers
        validateChainlinkCallback(_requestId);

        // Set the verification status (sets to address(0) if verification failed)
        records[_twitterHandle] = _address;

        // Set the proof Tweet ID to allow disputes to be filed
        proofs[_address] = _proof;

        emit VerificationSuccessful(
            _address,
            bytes32(uint256(_proof)),
            _twitterHandle
        );
    }

    /// Resolves a Twitter handle to a wallet address
    /// @param twitterHandle the Twitter @ username to resolve
    /// @return 0x0 if the handle is not connected or the owner's address if it is connected
    function resolve(bytes32 twitterHandle)
        external
        view
        virtual
        override
        returns (address)
    {
        return records[twitterHandle];
    }
}

// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.13;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "./interfaces/Registry.sol";

error ChainlinkOnly();

contract Twitter is Registry, ChainlinkClient {
    using Chainlink for Chainlink.Request;

    // Temporary
    address private link;
    uint256 private fee = 1**14; // 0.0001 LINK
    address private oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
    bytes32 private jobID = "29fa9aa13bf1468788b7cc4a500a45b8";

    // Mapping of Twitter handle to wallet address
    mapping(bytes32 => address) private records;

    // Mapping of Chainlink request ID to address
    mapping(bytes32 => address) private requestToAddress;
    // Mapping of Chainlink request ID to Twitter handle
    mapping(bytes32 => bytes32) private requestToHandle;

    constructor(address _link) {
        link = _link;
    }

    // Only the Chainlink Token can call these functions
    modifier chainlink() {
        if (msg.sender != link) revert ChainlinkOnly();
        _;
    }

    /// The data param should be the Tweet ID
    /// https://github.com/ethereum/EIPs/issues/677
    /// @dev this function is called from the LINK Token contract transferAndCall() function
    function onTokenTransfer(
        address from,
        uint256 amount,
        bytes memory data
    ) public chainlink returns (bool success) {
        _sendChainlinkRequest(bytes32(data));
        Chainlink.Request memory request = buildChainlinkRequest(
            jobID,
            address(this),
            this.fulfill.selector
        );
        request.add("tweetID", tweetID);
        requestId = sendChainlinkRequestTo(oracle, request, fee);
        requestToHandle[requestId] = tweedID;

        return true;
    }

    /// Chainlink Oracle fulfiller which sets the record owner address to the verified user or 0x0
    /// @dev this method is only called by the Oracle contract
    function fulfill(bytes32 _requestId, bytes32 _twitterHandle)
        external
        recordChainlinkFulfillment(_requestId)
    {
        // Fulfillment data is broken up as follows:
        // 0x0000000000000000000000000000000000000000000000000000000000000000
        //   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                 - (16 bytes) Twitter handle
        //                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ - (20 bytes) Address

        // Set the verification status (sets to address(0) if verification failed)
        records[_twitterHandle] = _address;

        emit VerificationSuccessful(
            _address,
            bytes32(uint256(_proofTweetId)),
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
        returns (address ownerAddress)
    {
        return records[twitterHandle];
    }
}

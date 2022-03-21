// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.13;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
// import "./interfaces/Registry.sol";

error ChainlinkOnly();
error FeeTooLow();

contract Twitter is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    // Temporary
    address private link;
    uint256 private fee = 1**14; // 0.0001 LINK
    address private oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
    bytes32 private jobID = "29fa9aa13bf1468788b7cc4a500a45b8";

    // Mapping of Twitter handle to wallet address
    mapping(bytes32 => address) private records;

    constructor(address link, address oracle) {
        setChainlinkToken(link);
        setChainlinkOracle(oracle);
    }

    // Only the Chainlink Token contract can call these functions
    modifier chainlink() {
        if (msg.sender != chainlinkTokenAddress()) revert ChainlinkOnly();
        _;
    }

    /// The data param should be the Tweet ID
    /// https://github.com/ethereum/EIPs/issues/677
    /// @dev This function is called from the LINK Token contract transferAndCall() function
    function onTokenTransfer(
        address from,
        uint256 amount,
        bytes memory data
    ) public chainlink returns (bool success) {
        if (amount < fee) revert FeeTooLow();

        // Create a Chainlink request with the Tweet ID to verify
        Chainlink.Request memory request = buildChainlinkRequest(
            jobID,
            address(this),
            this.fulfill.selector
        );
        request.addBytes("tweetID", data);
        sendChainlinkRequestTo(request, fee);

        return true;
    }

    /// Chainlink Oracle fulfiller which sets the record owner address to the verified user or 0x0
    /// @dev this method is only called by the Oracle contract
    function fulfill(
        bytes32 _requestId,
        bytes32 _twitterHandle,
        address _address
    ) external recordChainlinkFulfillment(_requestId) {
        // Set the verification status (sets to address(0) if verification failed)
        records[_twitterHandle] = _address;
    }

    /// Resolves a Twitter handle to a wallet address
    /// @param twitterHandle The Twitter @ username to resolve
    /// @return ownerAddress Returns the null address if the handle is not connected or the owner's address if it is connected
    function resolve(bytes32 twitterHandle)
        external
        view
        virtual
        returns (address ownerAddress)
    {
        return records[twitterHandle];
    }
}

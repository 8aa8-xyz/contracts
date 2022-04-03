// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.13;

import "./interfaces/Registry.sol";
import "./interfaces/Oracle.sol";

contract Twitter is Registry, Oracle {
    // Mapping of resolver to Twitter handle to wallet address
    mapping(address => mapping(bytes32 => address)) private records;

    // Mapping of Oracle address to price in wei
    mapping(address => uint256) private oraclePrices;

    /// Submits a payment to an oracle to run a verification job
    /// @param resolver - the address of the oracle
    /// @param tweetId - bytes32 encoded unique tweet ID that contains a proof
    function submit(address resolver, bytes32 tweetId) external payable {
        if (msg.value <= oraclePrices[resolver]) revert ErrorOracleFeeTooLow();
        payable(resolver).transfer(msg.value);
        emit SubmitProof(resolver, tweetId, msg.sender);
    }

    /// Submit a dispute for a Twitter handle
    /// @param resolver - the address of the Oracle that resolved the Twitter handle
    /// @param twitterHandle - the Twitter @ username to dispute
    function dispute(address resolver, bytes32 twitterHandle) external virtual {
        emit SubmitDispute(resolver, twitterHandle);
    }

    /// Resolves a Twitter handle to a wallet address
    /// @param resolver - the address of the Oracle that resolved the Twitter handle
    /// @param twitterHandle - the Twitter @ username to resolve
    /// @return ownerAddress - the address the Twitter handle belongs to (or 0x0 if none)
    function resolve(address resolver, bytes32 twitterHandle)
        external
        view
        virtual
        returns (address ownerAddress)
    {
        return records[resolver][twitterHandle];
    }

    /// Called by the oracle after it verifies a tweet
    /// @param twitterHandle - the Twitter @ username to verify
    /// @param owner - the address the Twitter handle belongs to (or 0x0 if none)
    function verify(bytes32 twitterHandle, address owner) external {
        records[msg.sender][twitterHandle] = owner;
        emit Verified(msg.sender, owner, twitterHandle);
    }

    /// Called by the oracle to set the price of a verification job
    function setOraclePrice(uint256 priceInWei) external {
        oraclePrices[msg.sender] = priceInWei;
    }
}

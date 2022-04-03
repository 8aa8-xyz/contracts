// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.13;

import "./interfaces/Registry.sol";

contract Twitter is Registry {
    // Mapping of resolver to Twitter handle to wallet address
    mapping(address => mapping(bytes32 => address)) private records;

    /// Submit a proof for a tweet
    /// @param tweetId - bytes32 encoded unique tweet ID that contains a proof
    function submit(bytes32 tweetId) external virtual {
        emit SubmitProof(tweetId, msg.sender);
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
    }
}

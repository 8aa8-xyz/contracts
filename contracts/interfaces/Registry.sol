// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.0;

/// @title Aces and Eights Registry Interface
/// @author hexcowboy <cowboy.dev>
interface Registry {
    /// Logged when an account has requested verification
    /// @param oracle - the address of the resolver oracle
    /// @param proof - the unique identifier to prove
    /// @param requester - the address which submitted the proof
    event SubmitProof(
        address indexed oracle,
        bytes32 indexed proof,
        address indexed requester
    );

    /// Logged when someone disputes the ownership of an address's connected account
    /// @param owner the address of the owner being disputed
    /// @param (2) - the account ID, username, or unique identifier of the account being disputed
    event SubmitDispute(address indexed owner, bytes32 indexed);

    /// Given data, an oracle should be able to use it to verify an external account
    /// @param resolver - the address of the resolver oracle
    /// @param proof - the object data to verify
    ///  Examples include:
    ///   - Twitter: The ID of the Tweet
    ///   - Instagram: The alphanumeric post ID
    /// @notice check your registry's implementation to understand what kind of data to pass as parameters
    function submit(address resolver, bytes32 proof) external payable;

    /// A connection can be disputed if the caller pays the oracle to audit it
    ///  Cases include:
    ///   - An account is banned
    ///   - An account removes their verification post
    ///   - An account's name has changed
    /// @param resolver - the address of the resolver oracle
    /// @param (2) - the account ID, username, or unique identifier that is being disputed
    /// @notice check your registry's implementation to understand what kind of data to pass as parameters
    function dispute(address resolver, bytes32) external payable;

    /// Resolves a record to a wallet (or contract) address
    /// @param resolver - the address of the resolver oracle
    /// @param (2) - the identifier to verify
    ///  Examples include:
    ///   - The username of a verified account
    function resolve(address resolver, bytes32) external view returns (address);
}

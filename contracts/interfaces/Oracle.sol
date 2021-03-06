// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.0;

/// @title Aces and Eights Oracle Interface
/// @author hexcowboy <cowboy.dev>
interface Oracle {
    error ErrorOracleFeeTooLow();
    error BatchParamLengthNotMatching();

    /// Logged when an account has requested verification
    /// @param oracle - the address of the resolver oracle
    /// @param proof - the unique identifier to prove
    event SubmitProof(address indexed oracle, bytes32 indexed proof);

    /// Logged when someone disputes the ownership of an address's connected account
    /// @param owner the address of the owner being disputed
    /// @param (2) - the account ID, username, or unique identifier of the account being disputed
    event SubmitDispute(address indexed owner, bytes32 indexed);

    /// Logged when a resolver has verified an account
    /// @param resolver - the oracle that resolved the account
    /// @param owner - the address of the owner that was verified
    /// @param (3) the identity that was linked to the owner
    ///  Examples include:
    ///   - Twitter: The @ username of the owner
    event Verified(
        address indexed resolver,
        address indexed owner,
        bytes32 indexed
    );

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

    /// Sets the price in wei for a verification job
    /// @param priceInWei - the desired price in wei
    function setOraclePrice(uint256 priceInWei) external;

    /// Verifies an object, usually updating records in a Registry contract
    /// @param proof - the object to be verified
    ///  Examples include:
    ///   - Twitter: The @ username of the owner
    /// @param owner - the address which was verified for the object
    function verify(bytes32 proof, address owner) external;

    /// Verifies an object, usually updating records in a Registry contract
    /// @notice - the array agrument lengths must match
    /// @notice - the array elements must correspend to the same index
    /// @param (1) - the objects to be verified
    ///  Examples include:
    ///   - Twitter: The @ username of the owner
    /// @param owners - the addresses which were verified for the objects
    function batchVerify(bytes32[] memory, address[] memory owners) external;
}

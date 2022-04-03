// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.0;

/// @title Aces and Eights Oracle Interface
/// @author hexcowboy <cowboy.dev>
interface Oracle {
    error ErrorOracleFeeTooLow();

    /// Logged when an account has requested verification
    /// @param resolver - the oracle that resolved the account
    /// @param owner - the address of the owner that was verified
    /// @param (2) the identity that was linked to the owner
    ///  Examples include:
    ///   - Twitter: The @ username of the owner
    event Verified(
        address indexed resolver,
        address indexed owner,
        bytes32 indexed
    );

    /// Verifies an object, usually updating records in a Registry contract
    /// @param proof - the object to be verified
    ///  Examples include:
    ///   - Twitter: The @ username of the owner
    /// @param owner - the address which was verified for the object
    function verify(bytes32 proof, address owner) external;

    /// Sets the price in wei for a verification job
    /// @param priceInWei - the desired price in wei
    function setOraclePrice(uint256 priceInWei) external;
}

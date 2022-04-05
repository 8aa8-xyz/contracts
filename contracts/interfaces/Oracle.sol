// SPDX-License-Identifier: CC-PDDC
pragma solidity ^0.8.0;

/// @title Aces and Eights Oracle Interface
/// @author hexcowboy <cowboy.dev>
interface Oracle {
    error ErrorOracleFeeTooLow();
    error BatchParamLengthNotMatching();

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

    /// Sets the price in wei for a verification job
    /// @param priceInWei - the desired price in wei
    function setOraclePrice(uint256 priceInWei) external;
}

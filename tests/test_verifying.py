from brownie import convert, reverts, web3

from .fixtures import *


# Test a single verification works
def test_verifying(contract, oracle_account, user_account):
    handle_bytes = web3.toBytes(text="hexcowboy")
    handle_bytes32 = convert.to_bytes(handle_bytes, type_str="bytes32")
    transaction = contract.verify(
        handle_bytes32, user_account.address, {"from": oracle_account}
    )
    assert transaction.modified_state
    assert "Verified" in transaction.events


# Test batch verification works
def test_batch_verifying(contract, oracle_account, user_account):
    handle_bytes = web3.toBytes(text="hexcowboy")
    handle_bytes32 = convert.to_bytes(handle_bytes, type_str="bytes32")
    transaction = contract.batchVerify(
        [handle_bytes32] * 3,
        [user_account.address] * 3,
        {"from": oracle_account},
    )
    assert transaction.modified_state
    assert len(transaction.events["Verified"]) == 3


# Test batch verification fails when argument lengths don't match
def test_batch_verifying(contract, oracle_account, user_account):
    handle_bytes = web3.toBytes(text="hexcowboy")
    handle_bytes32 = convert.to_bytes(handle_bytes, type_str="bytes32")
    with reverts("typed error: 0x72a3a930"):
        contract.batchVerify(
            [handle_bytes32] * 3,
            [user_account.address] * 2,
            {"from": oracle_account},
        )


# Test resolve returns correct value after verifying
def test_resolve_returns_expected_value(contract, oracle_account, user_account):
    # First verify the username
    handle_bytes = web3.toBytes(text="hexcowboy")
    handle_bytes32 = convert.to_bytes(handle_bytes, type_str="bytes32")
    contract.verify(handle_bytes32, user_account.address, {"from": oracle_account})

    # Now assert the resolved value is equal
    resolved_value = contract.resolve(oracle_account.address, handle_bytes32)
    assert resolved_value == user_account.address

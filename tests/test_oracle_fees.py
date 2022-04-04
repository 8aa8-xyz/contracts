from .fixtures import *
from brownie import convert, reverts

# Test setting the oracle price updates the contract state
def test_set_oracle_price(contract, oracle_account):
    transaction = contract.setOraclePrice(100, {"from": oracle_account})
    assert transaction.modified_state


# Test the submit fails when oracle payment is too low (with custom error signature 0x991b6571)
def test_submit_oracle_fee_too_low(contract, oracle_account, user_account):
    contract.setOraclePrice(100, {"from": oracle_account})
    with reverts("typed error: 0x991b6571"):
        fake_bytes32 = convert.to_bytes(0, type_str="bytes32")
        contract.submit(oracle_account, fake_bytes32, {"from": user_account})


# Test submit doesn't fail when the minimum amount is exceeded
def test_submit_oracle_fee_when_good(contract, oracle_account, user_account):
    contract.setOraclePrice(100, {"from": oracle_account})
    oracle_starting_balance = oracle_account.balance()
    fake_bytes32 = convert.to_bytes(0, type_str="bytes32")
    transaction = contract.submit(
        oracle_account, fake_bytes32, {"from": user_account, "amount": 100}
    )
    assert "SubmitProof" in transaction.events
    oracle_ending_balance = oracle_account.balance()
    assert oracle_ending_balance == oracle_starting_balance + 100


# Test the dispute fails when oracle payment is too low (with custom error signature 0x991b6571)
def test_dispute_oracle_fee_too_low(contract, oracle_account, user_account):
    contract.setOraclePrice(100, {"from": oracle_account})
    with reverts("typed error: 0x991b6571"):
        fake_bytes32 = convert.to_bytes(0, type_str="bytes32")
        contract.dispute(
            oracle_account, fake_bytes32, {"from": user_account, "amount": 2}
        )


# Test dispute doesn't fail when the minimum amount is exceeded
def test_dispute_oracle_fee_when_good(contract, oracle_account, user_account):
    contract.setOraclePrice(100, {"from": oracle_account})
    oracle_starting_balance = oracle_account.balance()
    fake_bytes32 = convert.to_bytes(0, type_str="bytes32")
    transaction = contract.dispute(
        oracle_account, fake_bytes32, {"from": user_account, "amount": 100}
    )
    assert "SubmitDispute" in transaction.events
    oracle_ending_balance = oracle_account.balance()
    assert oracle_ending_balance == oracle_starting_balance + 100

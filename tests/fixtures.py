import pytest
from brownie import Twitter, accounts


@pytest.fixture
def deployer_account():
    return accounts[0]


@pytest.fixture
def oracle_account():
    return accounts[1]


@pytest.fixture
def user_account():
    return accounts[2]


@pytest.fixture
def contract(deployer_account):
    return deployer_account.deploy(Twitter)

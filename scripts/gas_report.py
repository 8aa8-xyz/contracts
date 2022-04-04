from brownie import Twitter, accounts
from rich import print


def main():
    acct = accounts[0]
    Twitter.deploy({"from": acct})

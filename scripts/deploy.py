from brownie import Twitter, accounts
from rich.console import Console

console = Console()


def deploy(account_name):
    try:
        acct = accounts.load(account_name)
    except FileNotFoundError:
        console.print(f"Couldn't find account named {account_name}", style="red")
        exit(1)
    Twitter.deploy({"from": acct}, publish_source=True)

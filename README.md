# 8aa8 Contracts

## Deployments

> Rinkeby: [`0x08cA8433077C8a96De4c72Fc4970A87140A78ea9`](https://rinkeby.etherscan.io/address/0x08ca8433077c8a96de4c72fc4970a87140a78ea9#code)

## Development

### 🏜 Creating Environment

Create a virtual environment (requires `python3`, recommended `v3.9+`)

```bash
python3 -m venv venv
source venv/bin/activate
```

Installing dependencies (requires `xargs` - `brew install xargs` or `apt install -y xargs`)

```bash
pip install --upgrade pip
cat requirements.txt | xargs pip install
```

### 🛠 Compile Solidity Contracts

```bash
brownie compile
```

### 🧪 Run tests

#### Install ganache

````bash
npm install -g ganace    # npm (boring)
yarn global add ganache  # yarn (fun)
```

#### Run

```bash
brownie test     # run tests as normal
brownie test -G  # show gas reports
```

### 🚀 Deploy Contracts

#### Make a Brownie account

```bash
brownie accounts new deployer_account     # create a new account (will need to fund if on main/testnet)
brownie accounts import deployer_account  # import an account from a private key (be safe here)
```

#### Add environment variables

`.env`

```bash
WEB3_INFURA_PROJECT_ID=...  # required
ETHERSCAN_TOKEN=...         # required
```

#### Run the deploy script

```bash
brownie run scripts/deploy.py deploy deployer_account --network rinkeby  # change network if needed

Running 'scripts/deploy.py::deploy'...
Enter password for "deployer":
Transaction sent: 0x7c743fb832f791fc733d573a8e21493e88aab51559351169ba368c21d125bbc3
  Gas price: 1.158080953 gwei   Gas limit: 556884   Nonce: 696
  Twitter.constructor confirmed   Block: 10443228   Gas used: 506259 (90.91%)
  Twitter deployed at: 0x08cA8433077C8a96De4c72Fc4970A87140A78ea9
```
````

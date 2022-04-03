# 8aa8 Contracts

## Development

### Creating Environment

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

### Compile Solidity Contracts

```bash
brownie compile
```

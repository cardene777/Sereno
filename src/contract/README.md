# Sereno

## 1) Developing Contracts

#### Installing dependencies

```bash
bun install
```

#### Compiling your contracts

```bash
bun compile
```

If you prefer one over the other, you can use the tooling-specific commands:

```bash
bun compile:forge
bun compile:hardhat
```

#### Running tests

```bash
bun test
```

If you prefer one over the other, you can use the tooling-specific commands:

```bash
bun test:forge
bun test:hardhat
```

## 2) Deploying Contracts

Set up deployer wallet/account:

- Rename `.env.example` -> `.env`
- Choose your preferred means of setting up your deployer wallet/account:

```
MNEMONIC="test test test test test test test test test test test junk"
or...
PRIVATE_KEY="0xabc...def"
```

```bash
npx hardhat lz:deploy
```

More information about available CLI arguments can be found using the `--help` flag:

```bash
npx hardhat lz:deploy --help
```

By following these steps, you can focus more on creating innovative omnichain solutions and less on the complexities of cross-chain communication.

<br></br>

<p align="center">
  Join our community on <a href="https://discord-layerzero.netlify.app/discord" style="color: #a77dff">Discord</a> | Follow us on <a href="https://twitter.com/LayerZero_Labs" style="color: #a77dff">Twitter</a>
</p>


## Contract

| Contract | Contract Address | Explorer Link |
| :------: | :--------------: | :-----------: |
| **Sereno** | `0x7Fa86c6BF08D05ab76E1076b129Ca681848fE775` | `https://explorer.testnet.japanopenchain.org/address/0x7Fa86c6BF08D05ab76E1076b129Ca681848fE775` |

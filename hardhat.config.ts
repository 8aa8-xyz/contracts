import "@appliedblockchain/chainlink-plugins-fund-link";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-contract-sizer";
import "hardhat-deploy";
import "hardhat-gas-reporter";
import "solidity-coverage";
import "./tasks";

require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

const MAINNET_RPC_URL: string =
  process.env.MAINNET_RPC_URL! || process.env.ALCHEMY_MAINNET_RPC_URL!;
const RINKEBY_RPC_URL: string = process.env.RINKEBY_RPC_URL!;
const KOVAN_RPC_URL: string = process.env.KOVAN_RPC_URL!;
const PRIVATE_KEY: string = process.env.PRIVATE_KEY!;

// The mainnet block number to fork from
const FORKING_BLOCK_NUMBER: string =
  process.env.FORKING_BLOCK_NUMBER || String(0);

// Your API key for Etherscan, obtain one at https://etherscan.io/
const ETHERSCAN_API_KEY: string = process.env.ETHERSCAN_API_KEY!;
const REPORT_GAS: boolean = process.env.REPORT_GAS === "true" || false;

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      // If you want to do some forking set `enabled` to true
      forking: {
        url: MAINNET_RPC_URL,
        blockNumber: FORKING_BLOCK_NUMBER,
        enabled: false,
      },
      chainId: 31337,
    },
    localhost: {
      chainId: 31337,
    },
    kovan: {
      url: KOVAN_RPC_URL,
      accounts: PRIVATE_KEY !== undefined ? [PRIVATE_KEY] : [],
      //accounts: {
      //     mnemonic: MNEMONIC,
      // },
      saveDeployments: true,
      chainId: 42,
    },
    rinkeby: {
      url: RINKEBY_RPC_URL,
      accounts: PRIVATE_KEY !== undefined ? [PRIVATE_KEY] : [],
      //   accounts: {
      //     mnemonic: MNEMONIC,
      //   },
      saveDeployments: true,
      chainId: 4,
    },
    mainnet: {
      url: MAINNET_RPC_URL,
      accounts: PRIVATE_KEY !== undefined ? [PRIVATE_KEY] : [],
      //   accounts: {
      //     mnemonic: MNEMONIC,
      //   },
      saveDeployments: true,
      chainId: 1,
    },
  },
  etherscan: {
    // yarn hardhat verify --network <NETWORK> <CONTRACT_ADDRESS> <CONSTRUCTOR_PARAMETERS>
    apiKey: {
      rinkeby: ETHERSCAN_API_KEY,
      kovan: ETHERSCAN_API_KEY,
    },
  },
  gasReporter: {
    enabled: REPORT_GAS,
    currency: "USD",
    outputFile: "gas-report.txt",
    noColors: true,
  },
  contractSizer: {
    runOnCompile: false,
    only: [
      "APIConsumer",
      "KeepersCounter",
      "PriceConsumerV3",
      "RandomNumberConsumer",
    ],
  },
  namedAccounts: {
    deployer: {
      default: 0, // by default will take the first account as deployer
      // 1: 0, // change default deployer on mainnet only
    },
    feeCollector: {
      default: 1,
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.13",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  mocha: {
    timeout: 200000, // 200 seconds max for running tests
  },
};

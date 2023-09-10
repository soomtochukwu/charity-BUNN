import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config();

const 
[web3, remix, ETHERSCAN_KEY] = process.env,
config = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },

  defaultNetwork: "sepolia",

  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/uJ6VyGFM0IqVjGXqi0pjDyhbwpp7h58I",
      //@ts-ignore
      accounts:[web3, remix]
    },
  },
  
  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_KEY
    }
  }

};

export default config;
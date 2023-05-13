require("@nomicfoundation/hardhat-toolbox");
// require("@nomiclabs/hardhat-etherscan");
require("hardhat-contract-sizer");
require("solidity-coverage");
const ETHER_SCAN = "F5AWTUB63BI8VYPM9YHEY84F6VTIKDJ6GN"; // api etherscan, please change your api for main net
const INFURA_API_KEY = "110617ac817d4ca98a57cb0cb763b280"; //// IPFS api please change your api for main net
const GOERLI_PRIVATE_KEY =
  "c766e3df5afcea960863cd45e7b172b2dcf542a74f8f48460f7faf23b0fbb09a"; // please change your api for main net
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 2000,
      },
    },
  },
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/${INFURA_API_KEY}`, //please change your ipfs for main net
      accounts: [`0x${GOERLI_PRIVATE_KEY}`],
      // timeout: 200,
    },
  },
  etherscan: {
    // ehterscan API key, obtain from etherscan.io. allow us to connect with our ether scan account.
    apiKey: ETHER_SCAN,
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },
};

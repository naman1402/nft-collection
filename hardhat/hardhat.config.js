require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });
const API = process.env.API_KEY
const PRIVATE_KEY = process.env.POLYGON_AMOY_PRIVATE_KEY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    polygon: {
      url: API,
      accounts: [PRIVATE_KEY],
    }
  }
};

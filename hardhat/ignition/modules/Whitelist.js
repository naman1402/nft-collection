const {buildModule } = require("@nomicfoundation/hardhat-ignition/modules")

module.exports = buildModule("Whitelist", (m) => {
    const maximumAddresses = m.getParameter("_maxAddresses", 10)
    const whitelistContract = m.contract("Whitelist", [maximumAddresses])
    return whitelistContract;
})


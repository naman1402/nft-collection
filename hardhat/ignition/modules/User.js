const WHITELIST_ADDRESS = "0x3B244CD89BDF932662E0D610FE6Ca52DF64C8D65"
const METADATA_URL = "https://nft-collection-sneh1999.vercel.app/api/"

const {buildModule} = require("@nomicfoundation/hardhat-ignition/modules")

module.exports  = buildModule("User", (m) => {
    const baseURI = m.getParameter("baseURI", METADATA_URL)
    const whitelistContract = m.getParameter("whitelistContract", WHITELIST_ADDRESS)
    const user = m.contract("Users", [baseURI, whitelistContract])
    return user;
})


// whitelist contract - "0x3B244CD89BDF932662E0D610FE6Ca52DF64C8D65"
// users contract -  "0x830E1D94De682f50E130D7A87DAB172cE1bF4100"
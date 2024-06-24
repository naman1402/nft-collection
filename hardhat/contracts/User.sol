// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./Whitelist.sol";

interface IWhitelist {
    function addAddressToWhitelist(address) external view returns (bool);
}

contract Users is ERC721Enumerable, Ownable {

    string _baseTokenURI;
    uint256 public _price = 0.01 ether;
    bool public paused;

    uint256 public maxTokenId = 20;
    uint256 public tokenIds;
    IWhitelist whitelist;
    bool public presaleStarted;
    uint256 public presaleEnded;

    modifier notPaused() {
        require(paused, "contract is currently paused");
        _;
    }

    constructor(string memory baseURI, address whitelistContract) ERC721("Crypto Devs", "CD") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }

    function startPresale() public onlyOwner() {
        presaleStarted = true;
        presaleEnded = block.timestamp + 5 minutes;
    }

    function presaleMint() public payable notPaused{
        require(presaleStarted && block.timestamp < presaleEnded);
        require(whitelist.addAddressToWhitelist(msg.sender));
        require(tokenIds < maxTokenId);
        require(msg.value >= _price);
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function mint() public payable notPaused{
        require(presaleStarted && block.timestamp >= presaleEnded);
        require(tokenIds < maxTokenId);
        require(msg.value >= _price);
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    function baseURI() internal view virtual returns (string memory) {
        return _baseTokenURI;
    }

    function pause(bool value) public onlyOwner {
        paused = value;
    }

    function withdraw() public onlyOwner {
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success);
    }

    receive() external payable{}
    fallback() external payable{}
    
}
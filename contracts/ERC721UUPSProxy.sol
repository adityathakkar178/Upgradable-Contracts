// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MyERC721 is Initializable, UUPSUpgradeable,  ERC721Upgradeable, ERC721URIStorageUpgradeable, OwnableUpgradeable{
    uint256 private _tokenIdCounter;
    mapping (string => bool) private _tokenURIs;

    function initialize() initializer public {
        __ERC721_init("MyToken", "MTK");
        __ERC721URIStorage_init();
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    function mint(string memory _tokenName, string memory _tokenURI) public  {
        require(bytes(_tokenName).length > 0 && bytes(_tokenURI).length > 0, "Token name, Token id, Token URI can not be empty");
        require(!_tokenURIs[_tokenURI], "Token URI already exists");
        _tokenURIs[_tokenURI] = true;
        _tokenIdCounter++;
        uint256 tokenId = _tokenIdCounter;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
    }

    function tokenURI(uint256 _tokenId) public view override(ERC721Upgradeable, ERC721URIStorageUpgradeable) returns (string memory) {
        return super.tokenURI(_tokenId);
    }

    function supportsInterface(bytes4 _interfaceId) public view override(ERC721Upgradeable, ERC721URIStorageUpgradeable) returns (bool){
        return super.supportsInterface(_interfaceId);
    }

    function _authorizeUpgrade(address newImplementation) internal onlyOwner override{}

    receive() external payable {}

    fallback() external payable {}

    function tets1() public pure returns (string memory) {
        return "Test1";
    }
}
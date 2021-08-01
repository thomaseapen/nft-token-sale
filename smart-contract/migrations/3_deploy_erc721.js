const ERC721TestNFT = artifacts.require("ERC721TestNFT");

module.exports = function (deployer) {
  deployer.deploy(ERC721TestNFT);
};

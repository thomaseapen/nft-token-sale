const ERC20TestToken = artifacts.require("ERC20TestToken");

module.exports = function (deployer) {
  deployer.deploy(ERC20TestToken);
};

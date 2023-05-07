const holderFactory = artifacts.require("holderFactory");

module.exports = function(deployer) {
    deployer.deploy(holderFactory);
};
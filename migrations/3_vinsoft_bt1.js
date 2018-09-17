var Vinsoft_bt01 = artifacts.require('./Vinsoft_bt01.sol');

module.exports = function(deployer) {
    deployer.deploy(Vinsoft_bt01, 'anlancan', 18);
}
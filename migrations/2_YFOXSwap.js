const YFOXSwap = artifacts.require("YFOXswap.sol");
const YFox = artifacts.require("Yfox.sol");

module.exports = async (deployer) => {
    await deployer.deploy(YFOXSwap); 
    const tokenName = "Yfox";
    const tokenSymbol= "YFX";
    const supply = web3.utils.toWei("20000");
    await deployer.deploy(YFox,tokenName,tokenSymbol,supply);   
}
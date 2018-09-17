var Vinsoft_bt01 = artifacts.require("./Vinsoft_bt01.sol");

contract('Vinsoft_bt01', async(accounts) => {

    it('set name, age owner on development', async() => {
        let instance = await Vinsoft_bt01.deployed();
        let infoOwner = await instance.getInfomation();
        console.log('getInfomation', infoOwner);
    });

    //require owner
    it('modifier infomation, need onwer', async() => {
        let instance = await Vinsoft_bt01.deployed();
        await instance.setMyInfomation('an', 10, {from : accounts[0]});
        let infoOwner = await instance.getInfomation();
        console.log('getInfomation', infoOwner[0], infoOwner[1], infoOwner[2].toNumber());
    });
})
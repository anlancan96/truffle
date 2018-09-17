var DappToken = artifacts.require('./DappToken.sol');

contract('DappToken', function(accounts) {

    it('sets the total supply upon deployment', function() {
        return DappToken.deployed().then(function(instance) {
            tokenInstance = instance;
            return tokenInstance.totalSupply();
        }).then(function(totalSupply) {
            assert.equal(totalSupply.toNumber(), 1000000, 'sets the total supply to 1,000,000');
            return tokenInstance.balanceOf(accounts[0]);
        });
    });

    describe('transfers token ownership', async() => {
        let amount = 250000;
        let totalSupply = 1000000;
        let instance = await DappToken.deployed();
        beforeEach(function(){
            console.log('====================ANLANCAN=============================')
        })
        it('abc' , async() => {
            let receipt = await instance.transfer(accounts[1], amount, {from : accounts[0] });
            assert.equal(receipt.logs.length, 1, 'triggers one event');
            assert.equal(receipt.logs[0].event, 'Transfer', 'should be Transfer');
            assert.equal(receipt.logs[0].args._from, accounts[0], 'logs the account the token are transferred from');
            assert.equal(receipt.logs[0].args._to, accounts[1], 'logs the account the token are tranferred to');
            assert.equal(receipt.logs[0].args._value, amount, 'logs the token');
        })
        
        it('def', async() => {
            let balanceSender = await instance.balanceOf(accounts[0]);
            assert.equal(balanceSender.toNumber(), totalSupply - amount, 'detucts the amount from sender');
        
        })
      
        it('ikl', async() => {
            let balanceRecipent = await instance.balanceOf(accounts[1]);
            assert.equal(balanceRecipent.toNumber(), amount, 'adds the amount to the recipent');
        })
    })
})
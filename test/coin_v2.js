const coin_v2 = artifacts.require('./CoinV1.sol')

console.log("testing v2")

contract('coin_v2', function(accounts) {
  let john_address = accounts[0];
  let jane_address = accounts[1];
  let dave_address = accounts[2];

  it('should assert true', ()=>{
    let token1;
    //deploy tokens and calls total supply
    return coin_v2.deployed().then((instance)=>{
      token1 = instance;
      return token1.totalSupply.call()
    }).then((result)=>{
      console.log("The total initial supply is = ", result.valueOf())
      assert.equal(result.valueOf(), 1000000000, 'Initial Supply NOT Equal to 1000000000')

      //check if transfer is working
      token1.transfer(jane_address, 100, {from: john_address})

      return token1.balanceOf(jane_address)
    }).then((result)=>{
      console.log("janes balance is = ", result.valueOf())
      assert.equal(result.valueOf(), 100, "Not transfered from john to jane ");

    // check johns balance
    return token1.balanceOf(john_address)

    }).then((result)=>{
      console.log("johns balance is = ", result.valueOf())
      assert.equal(result.valueOf(), 999999900, "Johns balance is NOT 999999900")
    })
  })

});

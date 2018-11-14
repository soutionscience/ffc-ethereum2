const coin_v3 = artifacts.require('./CoinV2.sol')
contract('coin_v3', function(accounts) {
  let john_address = accounts[0];
  let jane_address = accounts[1];
  let dave_address = accounts[2];

  it("should assert true", ()=>{
    let token2;

    return coin_v3.deployed().then((instance)=>{
      token2 = instance;
      // transfer to jane
      // approve to jane
      token2.transfer(jane_address, 200, {from: john_address});
      token2.approve(jane_address, 50);
      return token2.allowance.call(john_address, jane_address)

    }).then((result)=>{
      console.log("allowance from john is", result.valueOf())
      assert.equal( result.valueOf(), 50, "Johns allowance to Jane is NOT Equal to 50!!!")
      token2.transferFrom(john_address, dave_address, 5, {from: jane_address})
      return token2.balanceOf(dave_address)

    }).then((result)=>{
    console.log("daves balance is= ", result.valueOf())
    assert.equal(result.valueOf(), 5, "Daves balance is NOT equall to 5!!")
    return token2.allowance.call(john_address, jane_address)
    }).then((result)=>{
      console.log("allowances remaining is ", result.valueOf())
      assert.equal(result.valueOf(), 45, "allowance balance is NOT equall to 45!!")
      return token2.balanceOf(john_address);
    }).then((result)=>{
      console.log("johns balance is = ", result.valueOf());
      assert.equal(result.valueOf(), 999999795, "Johns balance is not equal to 999999795!!")
    })
  })
 
});

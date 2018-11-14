const CoinV1 = artifacts.require('./CoinV1.sol')
const Web3 = require('web3')
let ganache = require('ganache-cli')
let web3 = new Web3(ganache.provider())
contract('CoinV1', function(accounts) {
  
  let john_address = accounts[0];
  let jane_address = accounts[1];
  let dave_address = accounts[2];

  let coin_v1;

  beforeEach(async ()=>{
    coin_v1 = await CoinV1.deployed()
   console.log(coin_v1.methods.totalSupply.call())
   

  })


  it("should assert true", async ()=> {
    // coin_v1 =  await CoinV1.deployed();
    console.log("contract deployed")
    assert.ok(coin_v1)
   
  })
  it("Deploys with initia supply", async ()=>{
   //console.log(coin_v1.totalSupply)
   let initialBalance = await coin_v1.totalSupply.call();
   console.log("balance for main account is = ", initialBalance);
   assert.equal(initialBalance, 1000000000, "initial Balance is NOT EQUALL to 1000000000!!!")

  })
  it("check johns balance ", async ()=>{
    let johnsBalance = await coin_v1.balanceOf.call(john_address)
    assert.equal(johnsBalance, 1000000000, "Johns initial Balance is NOT EQUALL to 1000000000!!!")
  })
  it("can transfer from one account to another", async ()=>{
   // await coin_v1.transfer(jane_address, 100, {from: john_address}).send({from: john_address});
    let JaneBalance = await coin_v1.balanceOf.call(jane_address);
    assert.equal(JaneBalance, 100, "Janes Balance is NOT Equal to 100!!")

  })

});

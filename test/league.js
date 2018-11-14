const compiledFactory = require('../build/contracts/leagueFactory.json');
const compiledLeague = require('../build/contracts/League.json')

let accounts;
let factory;
let leagueAddress;
let league;


beforeEach(async()=>{
  accounts = web3.eth.getAccounts();
  // using the long method that does/skips what migrations does
  factory = await new web3.eth.Contract(JSON.parse(compiledFactory.abi))
            .deploy({data: compiledFactory.bytecode})// deploy need data which is byte code
             .send({from: accounts[0], gas: '1000000'})


             
  await factory.methods.deployLeague().send({
      from: accounts[0],
      gas: '1000000'
    });

  [leagueAddress]=await factory.methods.GetAllLeagues().call();
  
  league = await new web3.eth.Contract(JSON.parse(compiledLeague.interface), leagueAddress)

});
// check if both contracts have been deployed
describe('Leagues', ()=>{
  it('deployes a factory and campaing', ()=>{
    assert.ok(factory.options.address);
    assert.ok(league.options.address);// to check confirm they have addresses
  })
})






contract('league_V1', function(accounts) {
  it("should assert true", function(done) {
    var league__v1 = league_V1.deployed();
    assert.isTrue(true);
    done();
  });
});

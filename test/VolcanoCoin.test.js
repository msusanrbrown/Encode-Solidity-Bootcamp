const { assert, expect } = require("chai")
const { ethers } = require("hardhat")

describe("VolcanoCoin", function () {
  it("test total supply is initially 10000", async function () {
    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    const volcano = await VolcanoCoin.deploy();
    await volcano.deployed();
    assert.equal((await volcano.getSupply()).toNumber(), 10000);
    assert.equal((await volcano.totalSupply()).toNumber(), 10000);

  });

  it("the total supply can be increased in 1000 token steps", async function () {
    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    const volcano = await VolcanoCoin.deploy();
    await volcano.deployed();
    let total = 10000;
    for (let i=1; i<=20; i++){
      total1=i*1000;
      total +=total1

      await volcano.increaseSupply(total1);
      assert.equal((await volcano.getSupply()).toNumber(), total);
      assert.equal((await volcano.totalSupply()).toNumber(), total);

    }
  });

  it("only the owner of the contract can increase the supply", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    const volcano = await VolcanoCoin.deploy();
    await volcano.deployed();

    await volcano.connect(owner).increaseSupply(1000);

    assert.equal((await volcano.getSupply()).toNumber(), 11000);
    assert.equal((await volcano.totalSupply()).toNumber(), 11000);

    // assert.throws(await volcano.connect(addr1).increaseSupply(1000), "");

    expect(volcano.connect(addr1).increaseSupply()).to.be.revertedWith(
      "only owner can change total supply");
   

    assert.equal((await volcano.getSupply()).toNumber(), 11000);
    assert.equal((await volcano.totalSupply()).toNumber(), 11000);

    expect(volcano.connect(addr2).increaseSupply()).to.be.revertedWith(
      "only owner can change total supply");

    assert.equal((await volcano.getSupply()).toNumber(), 11000);
    assert.equal((await volcano.totalSupply()).toNumber(), 11000);
  });
  
   
});
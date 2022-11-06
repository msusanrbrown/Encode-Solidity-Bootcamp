const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VolcanoCoin", function () {
  it("test initial value", async function () {
    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    const volcano = await VolcanoCoin.deploy();
    await volcano.deployed();
    expect((await volcano.retrieve()).toNumber()).to.equal(0);
  });
   
});
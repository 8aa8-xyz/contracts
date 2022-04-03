import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";

async function main() {
  const Twitter = await ethers.getContractFactory("Twitter");
  const twitter = await Twitter.deploy();

  await twitter.deployed();

  console.log("Twitter Registry deployed to:", twitter.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

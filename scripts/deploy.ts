import "@nomiclabs/hardhat-ethers";
import hh, { ethers } from "hardhat";
import { getChainlinkTokenAddress } from "../utils/chainlink";

async function main() {
  const linkAddress = getChainlinkTokenAddress(hh.network.config.chainId);
  const Twitter = await ethers.getContractFactory("Twitter");
  const twitter = await Twitter.deploy(linkAddress);

  await twitter.deployed();

  console.log("Twitter Registry deployed to:", twitter.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

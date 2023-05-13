const hre = require("hardhat");

async function main() {
  const Collection = await hre.ethers.getContractFactory("RiftersCollection");
  const collection = await Collection.deploy();
  await collection.deployed();
  console.log("Collection Contract deployed to:", collection.address);
  // Collection Contract deployed to: 0xFfD1640DB3B08cb1FD99bC489f43FbF5EDd0813c
  //Expoler Address https://goerli.etherscan.io/address/0xFfD1640DB3B08cb1FD99bC489f43FbF5EDd0813c
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

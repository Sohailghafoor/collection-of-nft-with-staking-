const hre = require("hardhat");

async function main() {
  const NFTStaking = await hre.ethers.getContractFactory("NFTStaking");
  const nftStaking = await NFTStaking.deploy(
    "0xFfD1640DB3B08cb1FD99bC489f43FbF5EDd0813c" //new collection Address
  );

  await nftStaking.deployed();

  console.log("NFTStaking Contract deployed to:", nftStaking.address);
}
//NFTStaking Contract deployed to: 0x0eCA68fFAA92f80e4Ea37F8B0A94F5827Dd2473b
//Expoler Address https://goerli.etherscan.io/address/0x0eCA68fFAA92f80e4Ea37F8B0A94F5827Dd2473b

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

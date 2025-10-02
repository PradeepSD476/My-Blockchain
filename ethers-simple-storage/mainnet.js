//we will need abi, private key of mainnet
//third party rpc url  ->  alchemy
//private key of metamask account

require("dotenv").config();
const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY,
    provider
  );
  
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8");
  //contract factory
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying, please wait...");
  const contract = await contractFactory.deploy(); //wait for contract to deploy
  await contract.deploymentTransaction().wait(1);

  const contractAddress = await contract.getAddress();
  console.log(`Contract address: ${contractAddress}`);
  let nonce = await wallet.getNonce();

  const currentFavoriteNumber = await contract.retrieve({nonce: nonce}); //Get Number, view function not cost any gas if called outside contract
  console.log(currentFavoriteNumber);
  nonce = await wallet.getNonce();
  const transactionResponse = await contract.store(7, {nonce: nonce});
  const transactionReceipt = await transactionResponse.wait(1);
  nonce = await wallet.getNonce();
  const updatedFavoriteNumber = await contract.retrieve({nonce: nonce});
  console.log(updatedFavoriteNumber);
}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.log(error);
  process.exit(1);
})
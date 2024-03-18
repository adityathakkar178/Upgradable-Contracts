async function main() {
    let erc721Contract;
    // Deploy proxy contract
    const ERC721 = await ethers.getContractFactory('MyERC721');
    erc721Contract = await ERC721.deploy();
    const Proxy = await ethers.getContractFactory("Proxy");
    const proxy = await Proxy.deploy(erc721Contract.target); 
  
    console.log("Proxy deployed to:", proxy.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
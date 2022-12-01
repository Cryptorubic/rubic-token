/* eslint-disable no-console */
const hre = require('hardhat');
import addresses from './addresses.json';
import amounts from './amounts.json';
import { RubicTokenGOV } from '../typechain';

async function main() {
    const args = [addresses, amounts];

    const factory = await hre.ethers.getContractFactory('RubicTokenGOV');
    const contract = (await factory.deploy(...args)) as RubicTokenGOV;

    await contract.deployed();

    console.log('Contract deployed to:', contract.address);

    await new Promise(r => setTimeout(r, 30000));

    await hre.run('verify:verify', {
        address: contract.address,
        constructorArguments: args
    });
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });

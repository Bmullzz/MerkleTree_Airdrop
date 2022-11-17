# Merkle Tree Address Verification for an Airdrop

This project demonstrates how to use a merkle tree to check for the max amount of NFT's that a whitelisted address is allowed to mint.
Instead of storing a large number of addresses in the contract, we store the root of the Merkle tree which gets initialized in the contructor.

We also have another function checkInWhitelist which takes in a proof and maxAllowanceToMint. maxAllowanceToMint is a variable that keeps track of the number of NFT's a given address can mint.

The value we are actually storing in the Merkle Tree, for this use case, is storing the address of the user along with how many NFTs they are allowed to mint. You can store whatever data you want in Merkle Trees, but this works for our example. The hash of the leaf node on which this address exists can be computed by first encoding the address of the sender and the maxAllowanceToMint into a bytes string which further gets passed down to the keccak256 hash function which requires the hash string to generate the hash.


```shell
npx hardhat test
```

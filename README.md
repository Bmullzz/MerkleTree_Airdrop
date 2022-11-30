# Merkle Tree Address Verification for an Airdrop

## Merkle Trees
* Merkle trees are a fundamental conept in blockchain technology
* They are a special kind of binary tree that is used to encode large chunks of information
* They build from the bottom up and allow you to verify if some values are present without having to loop over every element of the tree.
* More specifically, a Merkle tree if a type of hash tree in which each leaf node is labeled with the cryptographic hash a data block, and each non-leaf node is labeled with cryptographic hash of its child nodes' labels.
* The majority of hash tree implementations are binary (each node has two child nodes), but they can also have many more child nodes.

## Hash Functions
* To turn Transaction A into Hash A is a one-way cryptographic function.
* Once hashed, Hash A cannot be turned into Transaction A.
* Hashes are not reversible.
* Calculating the hash of an input is computationally efficient and fast.
* Hash functions cannot be reverse engineered.
* Hash functions are collision resistant whih means that two different inputs never generate the same output.

## Benefits of Merkle Trees in Blockchains
* Merkle Trees allow for quick verification of data integrity.
* The disk space used up is very little compared to the entire set of transactions. 
* The Merkle Root is included in the block header for this reason.
* One can verify that a block has not been modified by knowing the Merkle Root.

## Use Cases Outside of Blockchain
* IPFS
* Git
* Distributed databases such as AWS DynamoDB and Appache Cassandra use MErkle trees to control discrepancies.

## Verificaton of Presence in Merkle Trees
* Having a verifier loop over every leaf node of a Merkle Tree would be inefficient since they can be quite large.
* For example, given a `Verifier` only has the top-level parent node of the tree known as `Merkle Root` `r`.
* You, as a `Prover`, want to prove the `Verifier` that some value, `K`, exists in the Merkle Tree.
* To accomplish this, you can generate a `Merkle Proof`.
* If you can give the `Verifier` the value of `K`, along with all of the relevant nodes from the tree that get hashed up together to up the root hash, `r`, then the `Verifier` can compare the computed root value against `r`.
* If they are the same hash, it must mean that `K` was in fact present in the Merkle Tree.
* You could not have generated the same Merkle Root hash with different input data.
* It is important to remember that only a certain combination of nodes can generate this unique root `r` because the Merkle Tree is a `collision-resisitant hash function` which means that it is a hash function that when given two different inputs, it is almost impossible to produce the same output.
* This is significantly more efficient than looping over an entire Merkle Tree.
* For a tree with `n` number of elements, you only have to provide roughly `log(n)` elements as part of the proof (one for each 'level' of the tree).
* This means that with a lot of data, Merkle Trees are way more efficient that storing arrays or mappings.

## Use Cases in Smart Contracts
* When ENS launched their token contract, they were airdropping the $ENS token to over 100,000 wallet addresses. They were able to deploy their contract, at a time of extremely high gas fees, for a MUCH lower price than what it would've been had they stored the wallet addresses in an array (where even storing a few hundred addresses could easily exceed gas limits of a block) - https://etherscan.io/tx/0xdfc76788b13ab1c033c7cd55fdb7a431b2bc8abe6b19ac9f7d22f4105bb43bff

* Storing data, such as addresses, in a smart contract is the most expensive thing that you can do in terms of gas expenditure. 
* Instead of storing something like whitelisted addresses directly in the contract, you can build up a Merkle Tree and store the Merkle root, a `bytes32` value, in the contract.
* In this scenario, the contract becomes the `Verifier`, and the users who wish to use their whitelist spot, become the `Provers`.  Proving that they are part of the whitelist.

## Code Walkthrough


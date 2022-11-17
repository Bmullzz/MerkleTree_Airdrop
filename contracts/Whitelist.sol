// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

///@title This contract uses merkle trees to verify the number of NFT's that a given address is allowed to mint
///@author Brian Mullin
///@notice You can use this contract to save a large amount of gas by verifying a whitelist using a merkle tree rather than storing a large array of addresses
///@notice this contract can be cost efficient for Airdrops
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract Whitelist {

    bytes public merkleRoot;

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    ///@notice This function checks for the max amount of NFT's that a given address can mint
    function checkInWhiteList(bytes32[] calldata proof, uint64 maxAllowanceToMint) view public returns (bool) {
        bytes32 leaf = keccak256(abi.encode(msg.sender, maxAllowanceToMint));
        bool verified = MerkleProof.verify(proof, merkleRoot, leaf);
        return verified;
    }

 }
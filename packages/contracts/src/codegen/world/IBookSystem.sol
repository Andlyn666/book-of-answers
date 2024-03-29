// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IBookSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IBookSystem {
  function getRandomness(uint64 subId, bytes32 entityId, uint32 callbackGas) external;

  function fulfillRandomness(bytes32 requestId, uint256 randomness, bytes32 entityId) external;

  function getRandomnessByKey(bytes32 entityId) external returns (uint256 randomness);
}

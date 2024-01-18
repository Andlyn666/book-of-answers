// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";
import { TABLE_ID } from "./constants.sol";
import { Randcast, RandcastData } from "./tables/Randcast.sol";

contract RandcastSystem is System {
  /**
   * Increment and get an entity nonce.
   */
  function getRandomness() public virtual returns (RandcastData memory returnData) {
    returnData.randomness = block.prevrandao;
    returnData.requestId = keccak256(abi.encodePacked(returnData.randomness, block.timestamp, blockhash(block.number - 1)));
    Randcast.set(TABLE_ID, returnData.requestId, returnData.requestId, returnData.randomness);
    return returnData;
  }
}
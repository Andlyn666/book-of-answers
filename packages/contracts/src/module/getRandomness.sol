// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { IRandcastSystem } from "./interfaces/IRandcastSystem.sol";
import { RandcastSystem } from "./RandcastSystem.sol";
import { RandcastData } from "./tables/Randcast.sol";

import { SYSTEM_ID } from "./constants.sol";

function getRandomness(IBaseWorld world) returns (RandcastData memory returnData) {
  return IRandcastSystem(address(world)).randcast_system_getRandomness();
}
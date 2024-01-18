// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { System } from "@latticexyz/world/src/System.sol";
import { RandcastData } from "../module/tables/Randcast.sol";
import { getRandomness } from "../module/getRandomness.sol";
import { IWorld } from "../codegen/world/IWorld.sol";
contract BookSystem is System {
    function getBookPage() public returns (uint256) {
        RandcastData memory randomness = getRandomness(IWorld(_world()));
        return randomness.randomness;
    }
}

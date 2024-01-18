// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { RandcastData } from "../tables/Randcast.sol";

// TODO allow overriding namespace per-system (or a separate config for modules?)
interface IRandcastSystem {
  function randcast_system_getRandomness() external returns (RandcastData memory returnData);
}
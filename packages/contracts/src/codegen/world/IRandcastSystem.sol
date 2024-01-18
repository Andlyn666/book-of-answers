// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

import { RandcastData } from "./../../module/tables/Randcast.sol";

/**
 * @title IRandcastSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IRandcastSystem {
  function getRandomness() external returns (RandcastData memory returnData);
}
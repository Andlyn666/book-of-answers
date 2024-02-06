// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ResourceId } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_TABLE, RESOURCE_SYSTEM, RESOURCE_NAMESPACE } from "@latticexyz/world/src/worldResourceTypes.sol";

bytes14 constant NAMESPACE = bytes14("randcast");
bytes16 constant MODULE_NAME = bytes16("randcast");
bytes16 constant SYSTEM_NAME = bytes16("RandcastSystem");
bytes16 constant TABLE_NAME = bytes16("table");

ResourceId constant NAMESPACE_ID = ResourceId.wrap(bytes32(abi.encodePacked(RESOURCE_NAMESPACE, NAMESPACE)));
ResourceId constant TABLE_ID = ResourceId.wrap(bytes32(abi.encodePacked(RESOURCE_TABLE, NAMESPACE, TABLE_NAME)));
ResourceId constant SYSTEM_ID = ResourceId.wrap((bytes32(abi.encodePacked(RESOURCE_SYSTEM, NAMESPACE, SYSTEM_NAME))));

address constant MUD_CONSUMER_ADDRESS = 0xA15BB66138824a1c7167f5E85b957d04Dd34E468;
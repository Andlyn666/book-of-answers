// SPDX-License-Identifier: MIT
import { System } from "@latticexyz/world/src/System.sol";
import { IRandcastSystem } from "../codegen/world/IRandcastSystem.sol";
import { SystemSwitch } from "@latticexyz/world-modules/src/utils/SystemSwitch.sol";
import { SYSTEM_ID } from "../RandcastModule/constants.sol";

contract BookSystem is System {
    function getRandomness(uint64 subId, bytes32 entityId) external {
        SystemSwitch.call(
            SYSTEM_ID, abi.encodeCall(IRandcastSystem.getRandomNumber, (subId, entityId))
        );
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness, bytes32 entityId) external {
        SystemSwitch.call(
            SYSTEM_ID,
            abi.encodeCall(IRandcastSystem.fulfillRandomness, (requestId, randomness, entityId))
        );
    }

    function getRandomnessByKey(bytes32 entityId) external returns (uint256 randomness) {
        return abi.decode(SystemSwitch.call(
            SYSTEM_ID, abi.encodeCall(IRandcastSystem.getRandomnessByEntityId, (entityId))
        ), (uint256));
    }
}
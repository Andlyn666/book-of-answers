// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { Answers, AnswersData } from "../src/codegen/index.sol";
import { NAMESPACE, TABLE_NAME } from "../src/module/constants.sol";
import { ResourceId, WorldResourceIdLib, WorldResourceIdInstance } from "@latticexyz/world/src/WorldResourceId.sol";
import { RESOURCE_TABLE } from "@latticexyz/world/src/worldResourceTypes.sol";
import { RandcastModule } from "../src/module/RandcastModule.sol";
import { RandcastData } from "../src/module/tables/Randcast.sol";
import { getRandomness } from "../src/module/getRandomness.sol";
contract PostDeploy is Script {
  function run(address worldAddress) external {
    // Specify a store so that you can use tables directly in PostDeploy
    StoreSwitch.setStoreAddress(worldAddress);

    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    IWorld _world = IWorld(worldAddress);
    ResourceId tableId = WorldResourceIdLib.encode({ typeId: RESOURCE_TABLE, namespace: NAMESPACE, name: TABLE_NAME });

    RandcastModule randcastModule = new RandcastModule();
    _world.installModule(randcastModule, new bytes(0));

    Answers.set("0x0", AnswersData({ page: 0, answers: "As certain as the dawn." }));
    Answers.set("0x1", AnswersData({ page: 1, answers: "The stars say no, but the heart says yes." }));
    Answers.set("0x2", AnswersData({ page: 2, answers: "Seek the wisdom of the old oak." }));
    Answers.set("0x3", AnswersData({ page: 3, answers: "A resounding silence gives your answer." }));
    Answers.set("0x4",AnswersData({ page: 4, answers: "Fortune favors the bold." }));
    Answers.set("0x5", AnswersData({ page: 5, answers: "Look to the moon for guidance." }));
    Answers.set("0x6", AnswersData({ page: 6, answers: "The wind whispers 'yes' amidst the leaves." }));
    Answers.set("0x7", AnswersData({ page: 7, answers: "Only when the last petal falls." }));
    Answers.set("0x8", AnswersData({ page: 8, answers: "Ride the wave of uncertainty." }));
    Answers.set("0x9", AnswersData({ page: 9, answers: "Patience will unveil the truth." }));
    Answers.set("0xa", AnswersData({ page: 10, answers: "An echo from the mountains returns with your reply." }));
    Answers.set("0xb", AnswersData({ page: 11, answers: "In the dance of time, the answer will come." }));
    Answers.set("0xc", AnswersData({ page: 12, answers: "The sands of the desert hide your solution." }));
    Answers.set("0xd", AnswersData({ page: 13, answers: "When the phoenix rises, so too will your answer." }));
    Answers.set("0xe", AnswersData({ page: 14, answers: "Ask the stones that line the river's edge." }));
    Answers.set("0xf", AnswersData({ page: 15, answers: "A leap of faith is required." }));
    Answers.set("0x10", AnswersData({ page: 16, answers: "In the stillness between two breaths, listen." }));
    Answers.set("0x11", AnswersData({ page: 17, answers: "The answer lies beyond the horizon." }));
    Answers.set("0x12", AnswersData({ page: 18, answers: "Toss a coin to the wishing well." }));
    Answers.set("0x13", AnswersData({ page: 19, answers: "The butterfly's flight tells a tale." }));

    vm.stopBroadcast();
  }
}

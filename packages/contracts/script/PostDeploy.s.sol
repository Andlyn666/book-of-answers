// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { Answers, AnswersData } from "../src/codegen/index.sol";
contract PostDeploy is Script {
  function run(address worldAddress) external {
    // Specify a store so that you can use tables directly in PostDeploy
    StoreSwitch.setStoreAddress(worldAddress);

    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);


    Answers.set("0x0", AnswersData({ page: 0, answers: "Yes, without a doubt." }));
    Answers.set("0x1", AnswersData({ page: 1, answers: "Proceed with caution." }));
    Answers.set("0x2", AnswersData({ page: 2, answers: "Now is not the right time." }));
    Answers.set("0x3", AnswersData({ page: 3, answers: "Focus on improving yourself first." }));
    Answers.set("0x4", AnswersData({ page: 4, answers: "Consider seeking expert advice." }));
    Answers.set("0x5", AnswersData({ page: 5, answers: "The outcome will be favorable." }));
    Answers.set("0x6", AnswersData({ page: 6, answers: "You already know the answer." }));
    Answers.set("0x7", AnswersData({ page: 7, answers: "Embrace the unknown." }));
    Answers.set("0x8", AnswersData({ page: 8, answers: "Patience will reveal the truth." }));
    Answers.set("0x9", AnswersData({ page: 9, answers: "Take the leap, it's worth the risk." }));
    Answers.set("0xA", AnswersData({ page: 10, answers: "Reevaluate your priorities." }));
    Answers.set("0xB", AnswersData({ page: 11, answers: "Seek a different path." }));
    Answers.set("0xC", AnswersData({ page: 12, answers: "Your efforts will be rewarded." }));
    Answers.set("0xD", AnswersData({ page: 13, answers: "Look closer to home." }));
    Answers.set("0xE", AnswersData({ page: 14, answers: "It's important to act now." }));
    Answers.set("0xF", AnswersData({ page: 15, answers: "Trust in the process." }));
    Answers.set("0x10", AnswersData({ page: 16, answers: "Expect the unexpected." }));
    Answers.set("0x11", AnswersData({ page: 17, answers: "You may need to compromise." }));
    Answers.set("0x12", AnswersData({ page: 18, answers: "Stay true to your values." }));
    Answers.set("0x13", AnswersData({ page: 19, answers: "Success lies in the details." }));


    vm.stopBroadcast();
  }
}

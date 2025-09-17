// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {ChainLuck} from "../src/ChainLuck.sol";

contract ChainLuckScript is Script {
    ChainLuck public chainLuck;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        chainLuck = new ChainLuck();

        vm.stopBroadcast();
    }
}

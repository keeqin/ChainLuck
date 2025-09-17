// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ChainLuck} from "../src/ChainLuck.sol";
import {console} from "forge-std/console.sol";

contract ChainLuckTest is Test {
    ChainLuck public chainLuck;

    address player1 = address(0x1);
    address player2 = address(0x2);
    address player3 = address(0x3);
    address player4 = address(0x4);

    function setUp() public {
        chainLuck = new ChainLuck();

        vm.deal(address(chainLuck), 1000 ether);
        
        vm.deal(player1, 100 ether);
        vm.deal(player2, 100 ether);
        vm.deal(player3, 100 ether);
        vm.deal(player4, 100 ether);
    }

}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ChainLuck} from "../src/ChainLuck.sol";

contract ChainLuckTest is Test {
    ChainLuck public chainLuck;

    address player1 = address(0x1);
    address player2 = address(0x2);
    address player3 = address(0x3);
    address player4 = address(0x4);
    address player5 = address(0x5);
    address player6 = address(0x6);
    address player7 = address(0x7);
    address player8 = address(0x8);
    address player9 = address(0x9);
    address player10 = address(0x10);
    address player11 = address(0x11);
    address player12 = address(0x12);
    address player13 = address(0x13);
    address player14 = address(0x14);
    address player15 = address(0x15);

    function setUp() public {
        chainLuck = new ChainLuck();

        vm.deal(address(chainLuck), 1000 ether);
        
        vm.deal(player1, 100 ether);
        vm.deal(player2, 100 ether);
        vm.deal(player3, 100 ether);
        vm.deal(player4, 100 ether);
        vm.deal(player5, 100 ether);
        vm.deal(player6, 100 ether);
        vm.deal(player7, 100 ether);
        vm.deal(player8, 100 ether);
        vm.deal(player9, 100 ether);
        vm.deal(player10, 100 ether);
        vm.deal(player11, 100 ether);
        vm.deal(player12, 100 ether);
        vm.deal(player13, 100 ether);
        vm.deal(player14, 100 ether);
        vm.deal(player15, 100 ether);
    }

    function testGameFlow() public {
        // Start the game
        chainLuck.startGame();
        assert(chainLuck.currentState() == ChainLuck.GameState.InProgress);
        assert(chainLuck.numberOfPlayers() == 0);

        // Players commit their hashes
        vm.prank(player1);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(1))));
        vm.prank(player2);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(2))));
        vm.prank(player3);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(3))));
        vm.prank(player4);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(4))));
        vm.prank(player5);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(5))));
        vm.prank(player6);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(6))));
        vm.prank(player7);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(7))));
        vm.prank(player8);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(8))));
        vm.prank(player9);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(9))));
        vm.prank(player10);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(10))));
        vm.prank(player11);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(11))));
        vm.prank(player12);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(12))));
        vm.prank(player13);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(13))));
        vm.prank(player14);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(14))));
        vm.prank(player15);
        chainLuck.playGameAndCommitRandom{value: 0.0005 ether}(keccak256(abi.encodePacked(uint256(16))));

        assert(chainLuck.numberOfPlayers() == 15);

        // Transition to reveal state
        chainLuck.revealState();
        assert(chainLuck.currentState() == ChainLuck.GameState.Reveal);
        // Players reveal their numbers
        vm.prank(player1);
        chainLuck.revealRandom(1);
        vm.prank(player2);
        chainLuck.revealRandom(2);
        vm.prank(player3);
        chainLuck.revealRandom(3);
        vm.prank(player4);
        chainLuck.revealRandom(4);
        vm.prank(player5);
        chainLuck.revealRandom(5);
        vm.prank(player6);
        chainLuck.revealRandom(6);
        vm.prank(player7);
        chainLuck.revealRandom(7);
        vm.prank(player8);
        chainLuck.revealRandom(8);
        vm.prank(player9);
        chainLuck.revealRandom(9);
        vm.prank(player10);
        chainLuck.revealRandom(10);
        vm.prank(player11);
        chainLuck.revealRandom(11);
        vm.prank(player12);
        chainLuck.revealRandom(12);
        vm.prank(player13);
        chainLuck.revealRandom(13);
        vm.prank(player14);
        chainLuck.revealRandom(14);
        vm.prank(player15);
        chainLuck.revealRandom(16);

        // End the game and determine the winner
        (uint256 winnerIndex, address winnerAddress) = chainLuck.endGame();
        assert(winnerIndex < chainLuck.numberOfPlayers());
        assert(winnerAddress != address(0));

        // Show winner details
        emit log_named_address("Winner Address", winnerAddress);
        emit log_named_uint("Winner Index", winnerIndex);   
    }

}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ChainLuck {
    struct Player {
        bytes32 commit; // 用户提交的哈希
        uint256 revealed; // 用户揭示的数字
        bool hasRevealed;
    }
    address private owner;
    address[] private playerList;
    mapping(address => Player) private players;

    uint256 public numberOfPlayers;
    uint256 public numberOfCompletedGames;
    uint256 public minimumInvestmentAmount;
    uint256 public winningsMultiplier;
    uint256 public randomNumberSum = 0;
    uint256 constant MAX_PLAYERS = 1000;

    enum GameState {
        NotStarted,  // 未开始
        InProgress,  // 正在进行
        Reveal
    }
    // 声明一个状态变量来存储当前的游戏状态
    GameState public currentState;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner.");
        _;
    }
    constructor() {
        currentState = GameState.NotStarted;
        owner = msg.sender;
        numberOfCompletedGames = 0;
        winningsMultiplier = 100;
        minimumInvestmentAmount = 0.0005 ether;
        numberOfPlayers = 0;
    }

    function startGame() external onlyOwner {
        require(currentState == GameState.NotStarted, "Game is not in not started");
        currentState = GameState.InProgress;
        numberOfPlayers = 0;
    }

    function playGameAndCommitRandom(bytes32 hash) external payable {
        require(players[msg.sender].commit == bytes32(0), "Already committed");
        require(msg.value == minimumInvestmentAmount, "You must send exactly the minimum investment amount to play");
        require(currentState == GameState.InProgress, "Game is not in progress");
        players[msg.sender] = Player(hash, 0, false);
        playerList.push(msg.sender);
        numberOfPlayers++;
        
    }

    // 用户揭示自己的数字
    function revealRandom(uint256 seed) external {
        require(currentState == GameState.Reveal, "Game is not in reveal state");
        Player storage p = players[msg.sender];
        require(p.commit != bytes32(0), "No commit found");
        require(!p.hasRevealed, "Already revealed");
        require(keccak256(abi.encodePacked(seed)) == p.commit, "Invalid reveal");
        p.revealed = seed;
        p.hasRevealed = true;
        randomNumberSum ^= seed;
        randomNumberSum ^= uint256(keccak256(abi.encodePacked(block.timestamp)));
    }

    function revealState() external onlyOwner {
        require(currentState == GameState.InProgress, "Game is not InProgress");
        currentState = GameState.Reveal;
    }

    function endGame() external onlyOwner returns (uint256, address) {
        require(currentState == GameState.Reveal, "Game is not in reveal state");
        require(numberOfPlayers > 0, "No players have joined the game");

        uint256 winnerIndex = randomNumberSum % numberOfPlayers;
        for (uint256 i = 0; i < numberOfPlayers; i++) {
            address playerAddress = playerList[i];
            if (!players[playerAddress].hasRevealed) {
                winnerIndex = (winnerIndex + 1) % numberOfPlayers;
                continue;
            }
            break;
        }
        address winnerAddress = playerList[winnerIndex];

        uint256 transferAmount = minimumInvestmentAmount * winningsMultiplier;
        (bool success, ) = payable(winnerAddress).call{value: transferAmount}("");
        require(success, "Transfer failed");
        currentState = GameState.NotStarted;
        numberOfCompletedGames++;
        return (winnerIndex, winnerAddress);
    }

    function getPlayerAmount() external view returns(uint256){
        return numberOfPlayers;
    }


    function setMinimumInvestmentAmount(uint256 _amount) external onlyOwner {
        minimumInvestmentAmount = _amount;
    }

    function setWinningsMultiplier(uint256 _multiplier) external onlyOwner {
        winningsMultiplier = _multiplier;
    }

    receive() external payable {}
    fallback() external payable {}

}

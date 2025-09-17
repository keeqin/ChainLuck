## Description


实现了一个链上多人参与的“幸运抽奖”游戏，主要功能如下：

玩家参与与承诺（Commit）：玩家通过提交哈希值和支付固定金额参与游戏，哈希用于后续揭示随机数。  

揭示阶段（Reveal）：玩家在揭示阶段提交原始随机数，合约验证哈希匹配后记录玩家的随机数。  

随机数汇总与赢家选取：所有玩家揭示后，合约将所有随机数异或并结合区块时间生成最终随机数，用于选出获胜者。  
 
奖金分配：赢家获得所有玩家投入金额的倍数奖励（可配置）。

游戏状态管理：支持游戏开始、揭示、结束等状态切换，只有合约拥有者可操作关键流程。  

参数配置：合约拥有者可设置最低参与金额和奖金倍数。

整体流程保证了玩家提交的随机数在揭示前无法被预测，提升了游戏的公平性和安全性。

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

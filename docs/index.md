# Guccicoin

## Getting Started
*coming soon*

## Code Repositories
* [**Main Codebase**](https://github.com/guccicoin-project/guccicoin) - The base Guccicoin source code 
* [**Paper Wallet**](https://github.com/guccicoin-project/paper-wallet) - Online Paper Wallet Generator. 
* [**Blockchain Explorer**](https://github.com/guccicoin-project/blockchain-explorer) - A blockchain explorer for Guccicoin.
* [**Web Wallet**](https://github.com/guccicoin-project/gucci-web-wallet) - A web wallet for Guccicoin.
* [**GucciSharp**](https://github.com/guccicoin-project/guccisharp) - A library for Guccicoin which uses the web wallet as a backend.

## Installing

We have compiled binaries that are available for:
* [Windows [v001] (64-bit)](https://drive.google.com/open?id=1Rr8fSQB03DlB65Qa2Oj27UrwS2zR42y0)
* [Linux [v001] (64-bit)](https://drive.google.com/open?id=1Be1C81l0d2QVZhXo21U9xqyxU188eFAA)

## Notes

### Seed Nodes

These nodes are baked into the source code and are used to automatically sync the blockchain onto other nodes. These *should* be up 24 hours a day and have the latest version of the blockchain on.

| IP:Port | Description |
|---------|-------------|
| 195.201.145.173:10179 | Primary Seed Node |
| 195.201.145.173:10178 | Secondary Seed Node |

## Building/Compiling

See the [building/compiling page](building.md).

## Thanks
Cryptonote Developers, Bytecoin Developers, Monero Developers, Forknote Project, TurtleCoin Community, GucciCoin Community

## Copypasta for license when editing files

Hi GucciCoin contributor, thanks for forking and sending back Pull Requests. Extensive docs about contributing are in the works or elsewhere. For now this is the bit we need to get into all the files we touch. Please add it to the top of the files, see [src/CryptoNoteConfig.h](https://github.com/turtlecoin/turtlecoin/commit/28cfef2575f2d767f6e512f2a4017adbf44e610e) for an example.

```
// Copyright (c) 2012-2017, The CryptoNote developers, The Bytecoin developers
// Copyright (c) 2014-2018, The Monero Project
// Copyright (c) 2018, The TurtleCoin Developers
// Copyright (c) 2018, The GucciCoin Developers
// 
// Please see the included LICENSE file for more information.
```
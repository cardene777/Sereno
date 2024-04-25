# Sereno

## 概要

- ステーブルコイン。
- 常に 1 円 ≒ 1sereno にペグしている。
- Chainlink を使用して価格を取得。
  1. Chainlink を使用して円ドル（JPY/USD）の価格を取得。
  2. 他のトークンとは Chainlink を使用して<トークン>/USD を取得。
  - 上記の 2 つの値をもとに発行する sereno トークンを確定。
- Chainlinkを使用するとき、LayerZeroを使用して他チェーンのコントラクトにアクセス。

## アップデート
- 預け入れたトークンの運用を行い、その運用で発生した利益を運営の取り分や保険金として保持。
- ChainLinkに依存しているため、依存先を分散させる。
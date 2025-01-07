# robosys2024_ros
![test](https://github.com/tentoshinz/robosys2024_ros/actions/workflows/test.yml/badge.svg)

ツェラーの公式を用いて曜日を求める ROS 2 パッケージ

## 概要
- この ROS 2 パッケージは、映画サマーウォーズの冒頭で登場するツェラーの公式を用いて曜日を求め、パブリッシュします。
- 曜日を求めるために 年月日 を使用します。

## ノード

### zellers
ツェラーの公式を使用して曜日を計算するノード。

#### サブスクライブするトピック
- date (std_msgs/UInt32)
    - ```yyyymmdd``` 形式の日付を読み込み曜日の計算をする

#### パブリッシュするトピック
- calc_week (std_msgs/Int16)
    - 計算した曜日のデータ
    - 0~6で曜日を表す
        | 日 | 月 | 火 | 水 | 木 | 金 | 土 |
        | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
        | 1 | 2 | 3 | 4 | 5 | 6 | 0 |

- calc_week_str (std_msgs/String)
    - 計算した曜日と日時のデータ


### pubdate
現在の日付から1日ずつ増える ```yyyymmdd``` 形式の日付を、0.5秒ずつパブリッシュする。


#### パブリッシュするトピック
- date (std_msgs/UInt32)
    - ```yyyymmdd```形式の日付

#### listener
テスト用

## テスト環境
- Ubuntu 22.04 LTS
- ROS 2 Humble

## 参考
[Wikipedia ツェラーの公式](https://ja.wikipedia.org/wiki/%E3%83%84%E3%82%A7%E3%83%A9%E3%83%BC%E3%81%AE%E5%85%AC%E5%BC%8F)

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．
- © 2025 tento
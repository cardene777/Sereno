// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import { OApp } from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OApp.sol";
import { MessagingFee, Origin } from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract PriceFeed is OApp {
    mapping(uint16 => AggregatorV3Interface) public chainlinkFeeds;

    constructor(address _endpoint, address _delegate) OApp(_endpoint, _delegate) Ownable(_delegate) {}

    // =============================================================
    //                         EXTERNAL WRITE
    // =============================================================

    function setPriceFeed(uint16 _chainId, address _priceFeed) external {
        chainlinkFeeds[_chainId] = AggregatorV3Interface(_priceFeed);
    }

    function _lzReceive(
        Origin calldata _origin,
        bytes32 _guid,
        bytes calldata _payload,
        address _to,
        bytes calldata
    ) internal override {
        (uint256 mintAmount, uint16 chainId) = abi.decode(_payload, (uint256, uint16));
        int256 price = getLatestPrice(chainId);
        require(price > 0, "Invalid price");
        uint256 adjustedMintAmount = (mintAmount * 1e18) / uint256(price);
        bytes memory payload = abi.encode(adjustedMintAmount);
        _lzSend(_origin.srcEid, payload, bytes(""), MessagingFee(0, 0), payable(address(this)));
    }

    // =============================================================
    //                         EXTERNAL VIEW
    // =============================================================

    function oAppVersion() public pure override returns (uint64 senderVersion, uint64 receiverVersion) {
        return (SENDER_VERSION, RECEIVER_VERSION);
    }

    function getLatestPrice(uint16 _chainId) public view returns (int256) {
        (
            ,
            /*uint80 roundID*/ // roundのid、roundidは毎回記録される
            int256 price, // 最新の価格
            /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/ // どのroundで更新されたか
            ,
            ,

        ) = // roundスタートしたタイムスタンプ
            // data更新のタイムスタンプ
            chainlinkFeeds[_chainId].latestRoundData();
        return price;
    }
}

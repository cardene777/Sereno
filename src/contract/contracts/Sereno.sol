// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { ERC20Burnable } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { ERC20Pausable } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { ERC20Permit } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import { OApp } from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OApp.sol";
import { MessagingFee, Origin } from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";

contract Sereno is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit, OApp {
    // =============================================================
    //                          CONSTRUCTOR
    // =============================================================

    constructor(
        string memory name,
        string memory symbol,
        address _endpoint,
        address _delegate
    ) ERC20(name, symbol) ERC20Permit(name) Ownable(_delegate) OApp(_endpoint, _delegate) {}

    // =============================================================
    //                         EXTERNAL WRITE
    // =============================================================

    /// @notice pause contract
    function pause() public onlyOwner {
        _pause();
    }

    /// @notice unpause contract
    function unpause() public onlyOwner {
        _unpause();
    }

    /// @notice mint sereno token
    /// @dev onlyOwner
    /// @param _dstEid uint32

    function mint(
        uint32 _dstEid,
        string memory _message,
        address _composedAddress,
        bytes calldata _options
    ) external payable {
        bytes memory _payload = abi.encode(_message, _composedAddress);

        _lzSend(_dstEid, _payload, _options, MessagingFee(msg.value, 0), payable(msg.sender));
    }

    // =============================================================
    //                          INTERNAL WRITE
    // =============================================================

    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }

    function _lzReceive(
        Origin calldata _origin,
        bytes32 _guid,
        bytes calldata _payload,
        address _to,
        bytes calldata
    ) internal override {
        uint256 mintAmount = abi.decode(_payload, (uint256));
        _mint(_to, mintAmount);
    }

    // =============================================================
    //                         EXTERNAL VIEW
    // =============================================================

    function oAppVersion() public pure override returns (uint64 senderVersion, uint64 receiverVersion) {
        return (SENDER_VERSION, RECEIVER_VERSION);
    }
}

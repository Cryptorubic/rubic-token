// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {ERC20, ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";

contract RubicToken is ERC20Burnable, Ownable{
    using SafeERC20 for IERC20;

    event SweepTokens(address token, uint256 amount, address recipient);

    constructor() ERC20("RUBIC TOKEN", "RBC") {}

    function sendToken(
        address _token,
        uint256 _amount,
        address _receiver
    ) internal virtual {
        if (_token == address(0)) {
            Address.sendValue(
                payable(_receiver),
                _amount
            );
        } else {
            IERC20(_token).safeTransfer(
                _receiver,
                _amount
            );
        }
    }

    /**
     * @dev A function to rescue stuck tokens from the contract
     * @param _token The token to sweep
     * @param _amount The amount of tokens
     * @param _recipient The recipient
     */
    function sweepTokens(
        address _token,
        uint256 _amount,
        address _recipient
    ) external onlyOwner {
        sendToken(_token, _amount, _recipient);

        emit SweepTokens(_token, _amount, _recipient);
    }

    // TODO: REMOVE

    function mint(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }
}
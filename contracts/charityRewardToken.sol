// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interface/interface.sol";


contract charityRewardToken is ERC20, Ownable {

    address private mintCaller;
    uint256 private MAX_SUPPLY;
    address public Platform;

    constructor() ERC20("charity Token", "CT") {
        MAX_SUPPLY = 10_000_000_000 * (10 ** decimals());
    }

    modifier onlyMintCaller () {
        require (msg.sender == mintCaller || msg.sender == Platform, "Unauthorized Caller");

        _;
    }

    function setMintCaller(address _mintCaller) public {
        require(msg.sender == Platform, "Unauthorized entity");
        mintCaller = _mintCaller;
    }

    function mint(address account, uint256 amount) public onlyMintCaller {
        require(totalSupply() + amount <= MAX_SUPPLY, "MAX SUPPLY EXCEEDED");
        super._mint(account, amount);
    }



    //views
    function decimals() public view override returns (uint8) {
        return 18;
    }

    function getMaxSupply() public views returns (uint256) {
        return MAX_SUPPLY;
    }

}
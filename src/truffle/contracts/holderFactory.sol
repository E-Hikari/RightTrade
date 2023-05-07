// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/utils/TokenTimelock.sol)

pragma solidity ^0.8.0;

import "./holder.sol";
import "./btgdol.sol";

contract holderFactory {
    address public owner;

    mapping(address => address[]) requesters;
    mapping(address => address[]) providers;
    uint256 actualID = 0;
    address[] holderList;

    constructor() {
        owner = msg.sender;
        // owner = 0x94F58085492b8DC50AA4f078Cef8f9be22F69e12;
        // addRequester(0x94F58085492b8DC50AA4f078Cef8f9be22F69e12);
        // addProvider(0x94F58085492b8DC50AA4f078Cef8f9be22F69e12);  
    }

    modifier isOwner() {
        require(owner == msg.sender, "Not owner");
        _;
    }

    // function that adds a requester in the mapping
    function addRequester(address _requesterAddress) public {
        requesters[_requesterAddress].push(address(0));
    }

    function getRequestersHolder(
        address _requesterAdress,
        uint256 _id
    ) public view returns (address) {
        return requesters[_requesterAdress][_id];
    }

    // function that adds a provider in the mapping
    function addProvider(address _providerAddress) public {
        providers[_providerAddress].push(address(0));
    }

    function getProvidersHolder(
        address _providerAddress,
        uint256 _id
    ) public view returns (address) {
        return providers[_providerAddress][_id];
    }

    function getHolder(uint256 _id) public view returns (address) {
        return holderList[_id];
    }

    function createHolder(
        uint256 _amount,
        address _provider
    ) public isOwner returns (ERC20Holder) {
        // require(holderList[_id] == address(0), "Holder already exists!");

        ERC20Holder newHolder = new ERC20Holder(
            BTGDOL(0xC954BaA4E37d295bb648c20F83BC105ac0BDf7E4),
            _amount,
            address(msg.sender),
            _provider,
            owner
        );

        requesters[address(msg.sender)].push(address(newHolder));
        providers[_provider].push(address(newHolder));
        holderList.push(address(newHolder));

        return (newHolder);
    }
}

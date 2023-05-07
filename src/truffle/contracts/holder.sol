// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/utils/TokenTimelock.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./btgdol.sol";

contract ERC20Holder {
    using SafeERC20 for IERC20;

    // Atributes
    BTGDOL private immutable _token;

    uint256 private _amount;

    address private immutable _providerAddress;
    address private immutable _requesterAddress;
    address private immutable _moderator;

    bool private desaprove = false;
    bool private requesterStatus = false;
    bool private providerStatus = false;

    // Construtor
    constructor(
        BTGDOL token_,
        uint256 amount_,
        address requesterAddress_,
        address providerAddress_,
        address moderator_
    ) {
        _token = token_;
        _amount = amount_;
        _requesterAddress = requesterAddress_;
        _providerAddress = providerAddress_;
        _moderator = moderator_;
    }

    // Modifier that allows the moderator some privileges.
    // But it can only act if the service is disapproved by the requester.
    modifier isModerator() {
        require(desaprove == true, "This service is not desaproved!");
        require(msg.sender == _moderator, "Not Moderator!");
        _;
    }

    // Functions
    //----------------------------------------------------------------//

    // Checks if there was a correct transaction for the amount of tokens that the contract contemplates
    function checkAmount() public view returns (bool) {
        return (_amount == getToken().balanceOf(address(this)));
    }

    // Sets the project finalization and approval status.
    function setStatus() public {
        require(
            ((msg.sender == _providerAddress) ||
                (msg.sender == _requesterAddress)),
            "Only requester or provider can interact!"
        );

        if (msg.sender == _providerAddress) {
            providerStatus = true;
        }

        if (msg.sender == _requesterAddress) {
            requesterStatus = true;
        }
    }

    // Get functions
    function getProviderAddress()
        public
        view
        virtual
        isModerator
        returns (address)
    {
        return _providerAddress;
    }

    function getRequesterAddress()
        public
        view
        virtual
        isModerator
        returns (address)
    {
        return _requesterAddress;
    }

    function getToken() public view virtual returns (IERC20) {
        return _token;
    }

    function getAmount() public view virtual returns (uint256) {
        return _amount;
    }

    function getProviderStatus() public view virtual returns (bool) {
        return providerStatus;
    }

    function getRequesterStatus() public view virtual returns (bool) {
        return requesterStatus;
    }

    // Moderator's functions
    // Allows full refund of the contract value
    function refound() public virtual isModerator {
        uint256 amount = getToken().balanceOf(address(this));

        getToken().safeTransfer(getRequesterAddress(), amount);
    }

    // Allows a division agreed between both parties in case there is disapproval by the requester's opinion
    // Remember that the percentage is the refund amount for the requester
    function agreement(uint256 refoundPercentage) public virtual isModerator {
        uint256 amount = getToken().balanceOf(address(this));

        getToken().safeTransfer(
            getRequesterAddress(),
            (refoundPercentage * amount) / 100
        );
        getToken().safeTransfer(
            getProviderAddress(),
            ((100 - refoundPercentage) * amount) / 100
        );
    }

    // Pay function when both parties are satisfied
    function release() public virtual {
        require(
            ((providerStatus == true && requesterStatus == true) ||
                msg.sender == _moderator),
            "Not approved!"
        );

        uint256 amount = getToken().balanceOf(address(this));
        require(amount > 0, "ESC20Holder: no tokens to release");

        getToken().safeTransfer(getProviderAddress(), amount);
    }
}

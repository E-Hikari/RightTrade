// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/utils/TokenTimelock.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./btgdol.sol";

// colocar o tempo de vida do contrato depois do provider falar que entregou o serviço
// colocar o desaprove para o requester
// colocar o amount

contract ERC20Holder {
    using SafeERC20 for IERC20;

    BTGDOL private immutable _token; // código do token BTG DOL

    uint256 private _amount; // atributo que vai receber a quantidade de BTG DOL que o contrato contempla

    address private _moderator; // address da conta que tem privilégios no contrato

    address private immutable _providerAddress; // address da conta que tá prestando o serviço

    address private immutable _requesterAddress; // address da conta que tá recebendo o serviço

    bool private desaprove = false; //

    bool private requesterStatus = false; // status do RECEBIMENTO do serviço

    bool private providerStatus = false; // status da CONCLUSÃO do serviço

    // Construtor
    constructor(
        BTGDOL token_, // BTG DOL
        uint256 amount_, // discutível
        address requesterAddress_, // discutível
        address providerAddress_, // discutível
        address moderator_ // dono da factory
    ) {
        _token = token_;
        _amount = amount_;
        _requesterAddress = requesterAddress_;
        _providerAddress = providerAddress_;
        _moderator = moderator_;
    }

    modifier isModerator() {
        require(desaprove == true, "This service is not desaproved!");
        require(msg.sender == _moderator, "Not Moderator!");
        _;
    }

    function checkAmount() public view returns (bool) {
        return (_amount == getToken().balanceOf(address(this)));
    }

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

    function getToken() public view virtual returns (IERC20) {
        return _token;
    }

    function getAmount() public view virtual returns (uint256) {
        return _amount;
    }

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

    function getProviderStatus() public view virtual returns (bool) {
        return providerStatus;
    }

    function getRequesterStatus() public view virtual returns (bool) {
        return requesterStatus;
    }

    function refound() public virtual isModerator {
        uint256 amount = getToken().balanceOf(address(this));

        getToken().safeTransfer(getRequesterAddress(), amount);
    }

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

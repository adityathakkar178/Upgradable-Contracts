// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Proxy {
    address private _logicContract;
    address private _admin;

    constructor(address _logicalContract) {
        _logicContract = _logicalContract;
        _admin = msg.sender;
    }

    fallback() external payable {
        address impl = _logicContract;
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }

    receive() external payable {}

    function upgrade(address newLogicContract) external {
        require(msg.sender == _admin, "Only admin can call this function");
        require(newLogicContract != address(0), "Invalid address");
        _logicContract = newLogicContract;
    }
}
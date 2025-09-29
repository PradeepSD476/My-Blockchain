//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;
//the above is to declare that any version for solidity above 0.8.7 is okay for this contract
// >=0.8.7 <0.9.0 another method for version 
// for a specific version and all above version : ^0.8.7

//keep saving code(ctrl + s) and look for the green mark on the solidity compiler icon if its red you run into some error
//yellow tells warnings(code can be compiled), red tells error(no compilation)

contract SimpleStorage { //tells compiler next section is a contract
    //boolean, uint, int, address, bytes
    bool hasFavouriteNumber = true;
    uint favoriteNumber = 123;
    uint256 favNum = 5;
    string favText = "Five";
    int256 favInt = -5;
    address MyAddress;
    bytes32 favBytes = "cat"; //bytes32 is max , we will get error on byte64
}

contract SimpleStorage2 {
    uint256 public favoriteNumber; //default initialized value is 0, public is only used in case we want to change visibility of favoriteNumber

    //basic solidity functions
    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber; // if we will do more things here the cost will increase and we will have to pay more gas
    }

    //view, pure -> doesn't spend gas when alone
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
    //if a gas calling function calls a view or pure function - only then will it cost gas
}

//0xd9145CCE52D386f254917e481eB44e9943F39138

contract SimpleStorage3 {
    struct People {
        uint256 favoriteNumber;
        string name;
    } //struct in solidity

    People public person = People({favoriteNumber: 2, name: "pradeep"});

    //array in solidity
    
    People[] public people; //array of People, {dynamic array it is,  as size not given}
    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name}); //memory is used to store the value in memory
        //or People(_favoriteNumber, _name)
        people.push(newPerson);
    }
}

//-> data location <- only for array, struct, mapping types
//calldata, memory, storage
//calldata, memory: variable gonna exist tempororily
//storage: exist outside the function too, can be modified

//calldata: can't be modified, memory can be modified

//basic solidity mappings -> efficient
contract Mapping {
    mapping(string => uint256) public nameToFavoriteNumber;
    function addToMapping(string memory _name, uint256 _favoriteNumber) public {
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

//deploying contract to test net

//EVM, ethereum virtual machine
//avalanche, fantom ,polygon


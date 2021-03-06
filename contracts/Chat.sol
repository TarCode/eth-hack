pragma solidity >=0.4.21 < 0.6.0;

import "./Market.sol";

contract Chat is Market {

    event NewMessage(string message, address to_user, uint timestamp, uint listingId);

    address owner;

    struct Message {
        string message;
        address to_user;
        address from_user;
        uint timestamp;
    }

    mapping(uint => Message[]) listingIdToMessages;

    function getListingMessageCount(uint _listingId) external view returns(uint) {
        return listingIdToMessages[_listingId].length;
    }

    function sendMessage(string calldata _msg, address _to_user, uint _listingId) external {
        Message memory message = Message(_msg, _to_user, msg.sender, block.timestamp);
        listingIdToMessages[_listingId].push(message);
        emit NewMessage(_msg, _to_user, block.timestamp, _listingId);
    }

    function getListingMessageTextByIndex(uint _listingId, uint _index) external view returns(string memory) {
        Message memory message = listingIdToMessages[_listingId][_index];
        return(message.message);
    }

    function getListingMessageSenderByIndex(uint _listingId, uint _index) external view returns(address) {
        Message memory message = listingIdToMessages[_listingId][_index];
        return(message.from_user);
    }

    function getListingMessageTimestampByIndex(uint _listingId, uint _index) external view returns(uint) {
        Message memory message = listingIdToMessages[_listingId][_index];
        return(message.timestamp);
    }

}
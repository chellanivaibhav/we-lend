pragma solidity ^0.4.8;
import "./owned.sol";
import "./mortal.sol";

contract WeLend {
    Loan[] loans;
    mapping(address => Loan[]) userLoans;
    mapping()
    struct Loan {
        uint id;
        address creator;
        address[] guarantors;
        uint community;
        string description;
        uint dueBy;//Months
        uint amount;
        bool bankApproved;
        bool communityApproved;
        bool funded;
        bool canceled;
        bool repayed;
        uint interestRate;
    }
    function WeLend(){

    }

}

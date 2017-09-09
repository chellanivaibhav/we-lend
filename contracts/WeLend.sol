pragma solidity ^0.4.8;
contract WeLend {

    mapping(address => uint) addressMapping;
    uint bankInterestRate = 10;
    uint curr ;
    struct Loan {
    address creator;
    address[] guarantors;
    uint community;
    string desc;
    uint dueBy;//EPOC TIME
    uint amount;
    bool bankApproved;
    bool communityApproved;
    bool funded;
    bool canceled;
    bool repaid;
    uint interestRate;
    }
    Loan[] public loans;

    function WeLend(uint _loans){
        curr = 0;
        loans.length = _loans;
    }

    function createUser(address _user,uint _id){
        addressMapping[_user] = _id;
    }

    function getUser() constant returns(uint _id){
        return addressMapping[_user];
    }

    function createLoan(uint amount,uint dueBy,string desc,uint community){
        loans[curr].amount =  amount;
        loans[curr].dueBy= dueBy;
        loans[curr].desc= desc;
        loans[curr].community= community;
        loans[curr].creator= msg.sender;
        loans[curr].interestRate =  bankInterestRate;
        curr++;
    }


    function getGuarantors(uint _loanid) constant returns(address[]) {
        return loans[_loanid].guarantors;
    }

    function getUserLoansIndex(address _user) constant returns(uint[]){
        uint[] memory data = new uint[](50);
        uint last = 0;
        for(uint i = 0; i < loans.length;i++){
            if(loans[i].creator == _user ){
                data[last] = i;
                last++;
            }
        }
        return data;
    }

    function getLoanByIndex(uint _index) constant returns(address creator,
                                                            address[] guarantors,
                                                            uint community,
                                                            string desc,
                                                            uint dueBy,
                                                            uint amount,
                                                            uint interestRate,
                                                            bool bankApproved,
                                                            bool communityApproved,
                                                            bool funded,
                                                            bool canceled,
                                                            bool repaid){
        Loan storage loan = loans[_index];
        return(loan.creator,
        loan.guarantors,
        loan.community,
        loan.desc,
        loan.dueBy,
        loan.amount,
        loan.interestRate,
        loan.bankApproved,
        loan.communityApproved,
        loan.funded,
        loan.canceled,
        loan.repaid);
    }
}

pragma solidity ^0.4.8;
contract WeLend {

    Loan[] loans;
    uint bankInterestRate = 10;
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

    function createLoan(uint amount,uint dueBy,string desc,uint community) constant returns(bool){
        Loan memory loan = Loan({
        amount: amount,
        dueBy: dueBy,
        desc: desc,
        community: community,
        creator: msg.sender,
        guarantors: new address[](0),
        bankApproved: false,
        communityApproved: false,
        funded: false,
        canceled: false,
    repaid: false,
    interestRate: bankInterestRate
    });
        loans.push(loan);
        //        loan.amount = amount;
        //        loan.dueBy = dueBy;
        //        loan.description = description;
        //        loan.community = community;
        //        loan.creator = msg.sender;
        return true;
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

    function getLoanByIndex(uint _index) constant returns(address,address[],uint,string,uint,uint,uint,bool,bool,bool,bool,bool){
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

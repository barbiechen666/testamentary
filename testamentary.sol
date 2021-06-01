pragma solidity ^0.4.2;

contract Bank{
    mapping(address=>uint) balances;
    string owneremail; 
    string beneficiaryemail;
    string[] beneemail=["one","two"];
    
    function deposit() public payable{
        balances[msg.sender]+=msg.value;
    }
    function withdraw(uint amount) public{
        if(balances[msg.sender]>=amount){
            balances[msg.sender]-=amount;
            msg.sender.transfer(amount*1000000000000000000);
        }
    }
    function getMyBalance() public view returns(uint){
        return balances[msg.sender];
    }
    
    function getBankBalance() public view returns(uint){
        return this.balance;
    }
    
    //簽立遺囑人信箱
    function submitEmail(string memory _email) public {
       owneremail = _email;
    }
    function getEmail() public view returns (string memory) {
        return owneremail;
    }
    
    //受益人信箱
    function submitbeneficiaryEmail(string memory _benemail) public {
       beneficiaryemail = _benemail;
       beneemail.push(beneficiaryemail);
       
    }
    function getbeneficiaryEmail(uint index) public view returns (string memory) {
        //return beneficiaryemail;
        return beneemail[index];
    }
 
    function getlen() public view returns(uint){
        return beneemail.length;
    }
}

pragma solidity ^0.4.2;

contract Bank{
    mapping(address=>uint) balances;
    string owneremail; 
    struct Owner{
        address addr;
        string owneremail;
        mapping(address=>mapping(uint=>Beneficiary)) beneficiarylist;
    }
    struct Beneficiary{
        string beneficiaryemail;
        uint portion;
        bool execute;
    }
    mapping(uint=>Beneficiary) beneficiaryinfo;
    uint[] public beneficiaryids;
    
    //存錢進合約
    function deposit() public payable{
        balances[msg.sender]+=msg.value;
    }
    //領錢出來
    function withdraw(uint amount) public{
        if(balances[msg.sender]>=amount){
            balances[msg.sender]-=amount;
            msg.sender.transfer(amount*1000000000000000000);
        }
    }
    //查看合約的錢
    function getBankBalance() public view returns(uint){
        return this.balance;
    }
//contract testamentaryset{

//}

    //簽立遺囑人信箱
    function submitEmail(string memory _email) public {
       owneremail = _email;
    }
    function getEmail() public view returns (string memory) {
        return owneremail;
    }
    //添加入受益人
    function addbene(uint id,string memory _benemail,uint _distriburate) public{
       Beneficiary storage newbene= beneficiaryinfo[id];
       newbene.beneficiaryemail = _benemail;
       newbene.portion=_distriburate;
       newbene.execute=false;
       beneficiaryids.push(id);
    }
    //查看受益人資訊
    function getBeneficiary(uint id) public view returns (string memory,uint,bool){
        Beneficiary storage s = beneficiaryinfo[id];
        return (s.beneficiaryemail,s.portion,s.execute);
    }
    
    /*function execution(string memory _email)public{
        Beneficiary storage s = beneficiaryinfo[id];
        require(s.execute=false);
    }*/
    
    //受益人信箱
    /*function submitbeneficiaryEmail(string memory _benemail) public {
       beneficiaryemail = _benemail;
       beneemail.push(beneficiaryemail);
       
    }*/
    /*function getbeneficiaryEmail(uint index) public view returns (string memory) {
        //return beneficiaryemail;
        return beneemail[index];
    }*/
    /*function setportion(uint _distriburate) public{
        portion=_distriburate;
        portionli.push(portion);
        
    }
    function getportion(uint index) public view returns (uint){
        return portionli[index];
    }*/
    //function getlen() public view returns(uint){
        //return beneemail.length;
    //}
    /*function uintToString(uint v) constant returns (string str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory s = new bytes(i + 1);
        for (uint j = 0; j <= i; j++) {
            s[j] = reversed[i - j];
        }
        str = string(s);
    }*/
}

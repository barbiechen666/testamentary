pragma solidity ^0.4.2;

contract Bank{
    mapping(address=>uint) balances;
    //string owneremail; 
    /*struct Owner{
        address addr;
        string owneremail;
        mapping(address=>mapping(uint=>Beneficiary)) beneficiarylist;
    }*/
    /*struct Beneficiary{
        string beneficiaryemail;
        uint portion;
        bool execute;
    }*/
    //mapping(uint=>Beneficiary) beneficiaryinfo;
    //uint[] public beneficiaryids;
    
    //存錢進合約
    function deposit() public payable{
        balances[msg.sender]+=msg.value;
    }
    //領錢出來
    function withdraw(uint amount) payable public{
        if(balances[msg.sender]>=amount){
            balances[msg.sender]-=amount;
            msg.sender.transfer(amount*1000000000000000000);
        }
    }
    //查看合約的錢
    function getBankBalance() public view returns(uint){
        return this.balance;
    }
//}
//contract testamentaryset{

//}
//contract settestamentary{
    //mapping(address=>uint) balances;
    string owneremail; 
    uint id;
    address _to;
    /*struct Owner{
        address addr;
        string owneremail;
        mapping(address=>mapping(uint=>Beneficiary)) beneficiarylist;
    }*/
    struct Beneficiary{
        string beneficiaryemail;
        uint portion;
        bool execute;
    }
    mapping(uint=>Beneficiary) beneficiaryinfo;
    uint[]  beneficiaryids;
    mapping(string=>Beneficiary) beneficiaryinfo2;
    string[] beneficiarymails;
    mapping(string=>bool) mailexist;
    mapping(string=>uint) portions;
    //mapping()
    
    //Bank bank;
    /*function settestamentary(address _contractadd) public{
        bank=Bank(_contractadd);
    }*/

    //簽立遺囑人信箱
    function submitEmail(string memory _email) public {
       owneremail = _email;
    }
    function getEmail() public view returns (string memory) {
        return owneremail;
    }
    //添加入受益人
    function addbene(string memory _benemail,uint _distriburate) public{
       require(balances[msg.sender]>0);
       id=beneficiaryids.length+1;
       Beneficiary storage newbene= beneficiaryinfo[id];
       newbene.beneficiaryemail = _benemail;
       newbene.portion=_distriburate;
       newbene.execute=false;
       beneficiaryids.push(id);
       beneficiarymails.push(_benemail);
       mailexist[_benemail]=true;
       portions[_benemail]=_distriburate;
       //benes.push(newbene);
    }
    function returnlen()public view returns(uint){
        return beneficiarymails.length;
    }
    //查看受益人資訊
    function getBeneficiary(uint id) public view returns (string memory,uint,bool){
        Beneficiary storage s = beneficiaryinfo[id];
        return (s.beneficiaryemail,s.portion,s.execute);
    }

    function getbeneficiarybymail(string memory _mail) public view returns(bool){
        return mailexist[_mail];
    }
    function getportion(string memory _mail) public view returns(uint){
        return portions[_mail];
    }
    //修改受益人分配比例
    function modifybene(uint _id,uint _portion)public{
        Beneficiary storage  s =beneficiaryinfo[_id];
        s.portion=_portion;
        
    }
    function submitTransaction(address _to,uint _portion) payable public {
        _to.transfer(address(this).balance/100*_portion);
    }
    
}

contract setpassword{
     Bank bank;
     uint password;
     uint portion;
     uint hashdigits=8;
     uint hashmoduls=10**hashdigits;
     mapping(address=>uint) beneficiarypass;
     mapping(uint=>uint) beneficiaryportion;
     
     function setpassword(address _contractadd) public{
        bank=Bank(_contractadd);
    }
     /*function checkvalid(string memory _emaill)public view returns(string) {
        string memory i;
        if(bank.getbeneficiarybymail(_emaill)==true){
        i="valid";}
        else{i="invalid";}
        return i;
     }*/
     function passnportionset(string memory _mail,string memory _password) public{
         //password=uint((keccak256(abi.encodePacked(_password)))%hashmoduls);
         require(bank.getbeneficiarybymail(_mail)==true);
         password=uint((keccak256(_password)));
         //password=_password;
         beneficiarypass[msg.sender]=password;
         beneficiaryportion[password]=bank.getportion(_mail);
     }

     function getpassword() public view returns(uint){
         return beneficiarypass[msg.sender];
     }
     function getportion(string memory _password) public view returns(uint) {
         password=uint((keccak256(_password)));
         return beneficiaryportion[password];
         
     }

    function execute(string memory _password)public payable{
         require(uint(keccak256(_password))==beneficiarypass[msg.sender]);
         //portion=beneficiaryportion[uint(keccak256(_password))];
         portion=getportion(_password);
         bank.submitTransaction(msg.sender,portion);
         //msg.sender.transfer(bank.getBankBalance()/100*beneficiaryportion[uint(keccak256(_password))]);
     }


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
//}

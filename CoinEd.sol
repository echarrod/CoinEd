pragma solidity ^0.4.0;
import "./Ownable.sol";
import "./SafeMath.sol";
import "./ERC20.sol";

contract CoinEd is Ownable, ERC20{
    
    uint public totalSupply; //if public then getter is automatically created
    uint8 transferLimit;

    modifier RestrictAddresses(){
        require(whitelistedAddresses[msg.sender] == true, "Address is not on the list of allowed addresses");
        _;
    }

    constructor() public{
        totalSupply = 100;
        transferLimit = 50;
        balances[msg.sender] = totalSupply;
        whitelistedAddresses[0xca35b7d915458ef540ade6068dfe2f44e8fa733c] = true;
    }

    mapping (address => mapping (address => uint256)) internal allowed;
    mapping(address => bool) whitelistedAddresses;
    mapping(address => uint) balances;

    function balanceOf(address _owner) view public returns (uint256 ){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) RestrictAddresses public{
        require(_value <= transferLimit, "Transfer limit exceeded");
        require(balances[msg.sender] >= _value, "Not enough CoinEds");
        
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], _value);
        balances[_to] = SafeMath.add(balances[_to], _value);

        emit Transfer(msg.sender, _to, _value);
        emit SourceBalance(msg.sender, balances[msg.sender]);
        emit TargetBalance(_to, balances[_to]);
    }

    function transferFrom(address _from, address _to, uint256 _value) RestrictAddresses public returns (bool success){
        require(_to != address(0));
        require(_value <= balances[_from]);
        
        balances[_from] = SafeMath.sub(balances[_from], _value);
        balances[_to] = SafeMath.add(balances[_to], _value);
        
        allowed[_from][msg.sender] = SafeMath.sub(allowed[_from][msg.sender], _value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }

    function setTransferLimit(uint8 _newTransferLimit) public {
        transferLimit = _newTransferLimit;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event SourceBalance(address _from, uint256 _value);
    event TargetBalance(address _from, uint256 _value);
}
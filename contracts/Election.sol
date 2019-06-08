pragma solidity ^0.5.0;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    address[] public arr;
    // Read/write Candidates
    mapping(address => bool) public eligibleAddresses;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;

    // Store Candidates Count
    uint public candidatesCount;

    // Constructor
    constructor() public {
        initializeMap();
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function initializeMap() private{
        eligibleAddresses[0x322a9BE4b2FA5d44C851e0D6F03eBC7299Eaa748] = true;
        eligibleAddresses[0x2510344f7c98Ad1737d2E3145f5b2f32D4886c8f] = true;
        eligibleAddresses[0xA3Bd30d5b67AB023661E238E95baAbDCAc9382BF] = true;
        eligibleAddresses[0xF0f04eF63C8311092319DCc1f48f0959eAA04815] = true;
        eligibleAddresses[0x4d6b457c33252Cf4d23F4aE0A4583EB44450E9Fb] = true;
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "");
        require(eligibleAddresses[msg.sender],"");
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;
    }
}
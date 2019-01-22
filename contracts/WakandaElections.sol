pragma solidity >=0.4.22 <0.6.0;

contract WakandaElections {
    
    // Candidate Structure
    struct Candidate {
        uint id;
        string name;
        string desc;
        uint voteCount;
    }
    
    constructor () public {
        addCandidate("T'Challa", "T'Challa aka Black Panther is a king and protector of Wakanada");
        addCandidate("Shuri", "She is the daughter of T'Chaka with a genius level intellect");
        addCandidate("N'Jadaka", "He is an enemy of Black Panther and an expert technician");
        addCandidate("W'Kabi", "He is a chief of Wakandan security as well as T'Challa's loyal second-in-command");
    }

    // check if the person as voted
    // input - Persons address
    // output - true/false
    mapping(address => bool) public voters;
    
    // Store & Fetch Candidates
    mapping(uint => Candidate) public candidates;
    
    // number of Wakanada Electoral Candidates
    uint public candidatesCount;

    // trigger event when vote occurs
    event votedEvent (
        uint indexed _candidateId
    );

    function addCandidate (string memory _name, string memory _desc) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, _desc, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
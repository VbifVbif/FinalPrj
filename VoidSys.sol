// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates; //Candidates
    mapping(address => bool) public hasVoted; //Voted check
    uint256 public candidatesCount; //Count of Candidates
    event VotedEvent(uint256 indexed candidateId); //Vote event

     // Constructor of Candidates
    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    // Function for adding new Candidate
    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    //Vote Function
    function vote(uint256 _candidateId) public {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        require(!hasVoted[msg.sender], "You have already voted");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit VotedEvent(_candidateId);
    }

    // Get Winner Function
    function getWinner() public view returns (string memory) {
        uint256 winningVoteCount = 0;
        string memory winnerName;
        for (uint256 i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
    return winnerName;
    }
}

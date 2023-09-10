// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "../interface/interface.sol";
import "../contracts/charityRewardToken.sol";

contract charity {

    using Counters for Counters.Counter;
    IREWARDTOKEN private charityToken;

    Counters.Counter public currentProjectId;

    address public platform;

    struct project {

        address creator;
        address[] contributors;
        string projectName;
        string image;
        string description;
        uint256 goal;
        uint256 currentAmount;
        uint256 starttime;
        uint256 endtime;
        bool isStarted;
        bool isClosed;

    }

    mapping (uint256 => project) public projects;

    uint256 public totalProjects;
    uint256[] public allProjectsArray;
    uint256 public Platformfee = 0.01 ether;

    event projectCreated(uint256 projectId, address creator, uint256 goalAmount);
    event projectFunded (uint256 projectId, address contributor, uint256 amount);
    event projectClosed(uint256 projectId, bool isClosed);
    event Contributionswithdrawn (uint256 projectId, address paidTo, uint256 amount, uint256 platformfee);


    function createProject(string memory _image, string memory _projectname, string memory _description, uint256 _goal, uint256 _starttime, uint256 _endtime) public {

        require(msg.sender != address(0), "address zero not allowed");

        require(_goal > 0, "goal can't be 0");
        require(_starttime >= block.timestamp && _endtime > _starttime, "start time must be a date in the future");

        uint256 _currentProjectId = currentProjectId.current();

        project storage project_ = projects[_currentProjectId];

        project_.creator = msg.sender;
        project_.projectName = _projectname;
        project_.image = _image;
        project_.description = _description;
        project_.goal = _goal;
        project_.starttime = _starttime;
        project_.endtime = _endtime;
        project_.isStarted = true;

        totalProjects = totalProjects + 1;

        allProjectsArray.push(_currentProjectId);

        emit projectCreated(_currentProjectId, msg.sender, _goal);
    }

    function contribute() public {}

    function getAllProjects() public view returns(uint256[] memory) {
        return allProjectsArray;
    }

    function getClosedProjects() public {}

    function receiveContribution() public {}

    function setCharityTokenAddress() public {}
}
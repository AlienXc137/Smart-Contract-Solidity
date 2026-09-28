// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import {FreelancerProfile, EmployerProfile, createJobListingInput, JobListing} from "./types/DeworkTypes.sol";

contract Dework{
    uint256 connectFee;
    address public initialOwner;

    constructor (address _initialOwner) {
        initialOwner=_initialOwner;
    }

    //Freelancer
    FreelancerProfile[] public freelancerProfiles;
    EmployerProfile[] public employerProfiles;

    mapping (uint256=>address) public freelancerIdToAddress;
    mapping(uint256=>address) public employerIdToAddress;

    event FreelancerProfileRegistered(uint256 freelancerId, address caller);
    event EmployerProfileRegistered(uint256 employerId, address caller);

    error Dework_WrongPayment(uint256 expectedPayment, uint256 actualPayment);

    function getTotalFreelancers() public view returns (uint256) {
        return freelancerProfiles.length;
    }

    function registerFreelancer(
        string calldata name,
        uint8 experianceYears,
        uint256 hourlyRateWei
    ) external  {
        uint256 freelancerId= getTotalFreelancers();

        FreelancerProfile memory freelancerProfile=FreelancerProfile({
            id:freelancerId,
            name:name,
            wallet:msg.sender,
            experianceYears:experianceYears,
            available:true,
            hourlyRateWei:hourlyRateWei
        });

        freelancerProfiles.push(freelancerProfile);
        freelancerIdToAddress[freelancerId]=msg.sender;
        emit FreelancerProfileRegistered(freelancerId, msg.sender);
    }

    function getTotalEmployers() public view returns (uint256) {
        return employerProfiles.length;
    }

    function registerEmployer(string calldata name) external  {
        uint256 employerId= getTotalEmployers();

        EmployerProfile memory employerProfile=EmployerProfile({
            id:employerId,
            name:name,
            wallet:msg.sender,
            isHiring:true,
            jobListing: new JobListing[](0)
        });

        employerProfiles.push(employerProfile);
        employerIdToAddress[employerId]=msg.sender;
        emit EmployerProfileRegistered(employerId, msg.sender);
    } 

    function _getEmployerProfile(uint256 employerId) internal view returns (EmployerProfile storage) {
        return employerProfiles[employerId];
    }

    function getCreatedJobList(uint256 employerId) public view returns (uint256) {
        employerProfiles[employerId].jobListing.length;
    }

    function createJobListing(
        uint256 employerId,
        createJobListingInput calldata jobListingInput
    ) external payable {
        uint256 payment=jobListingInput.fixedPayWei;
        if(msg.value!=payment){
            revert Dework_WrongPayment(payment,msg.value);
        }
        EmployerProfile storage employerProfile=_getEmployerProfile(employerId);
        uint256 jobId=getCreatedJobList(employerId);

        JobListing memory newJob=JobListing({
            id:jobId,
            title:jobListingInput.Title,
            description:jobListingInput.jobDescription,
            deadline:jobListingInput.deadline,
            isOpen:true,
            fixedPayWei:jobListingInput.fixedPayWei,
            hiredFreelancerId:0,
            hasHiredFreelancer:false,
            isPaid:false
        });

        employerProfile.jobListing.push(newJob);
    }
}
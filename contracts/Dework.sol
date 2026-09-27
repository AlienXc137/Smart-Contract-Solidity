// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import {FreelancerProfile} from "./types/DeworkTypes.sol";

contract Dework{
    uint256 connectFee;
    address public initialOwner;

    FreelancerProfile[] public freelancerProfiles;

    constructor (address _initialOwner) {
        initialOwner=_initialOwner;
    }

    function getTotalFreelancers() public view returns (uint256) {
        return freelancerProfiles.length;
    }

    function registerFreelancer(
        string calldata name,
        uint8 experianceYears,
        uint256 hourlyRateWei
    ) public {
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
    }
}
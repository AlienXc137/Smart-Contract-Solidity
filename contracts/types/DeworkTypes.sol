// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

struct FreelancerProfile{
    uint256 id;
    string name;
    address wallet;
    uint8 experianceYears;
    bool available;
    uint256 hourlyRateWei; // 1 eth= 10^18
}

struct EmployerProfile{
    uint256 id;
    string name;
    address wallet;
    bool isHiring;
    JobListing[] jobListing;
}

struct createJobListingInput{
    string Title;
    string jobDescription;
    uint256 deadline;
    uint256 fixedPayWei;
}

struct JobListing{
    uint256 id;
    string title;
    string description;
    uint256 deadline;
    bool isOpen;
    uint256 fixedPayWei;
    uint256 hiredFreelancerId;
    bool hasHiredFreelancer;
    bool isPaid;
}
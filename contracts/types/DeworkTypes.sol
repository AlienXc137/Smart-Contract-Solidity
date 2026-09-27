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
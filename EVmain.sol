//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
contract C{
//struct EV{
int dist;
int x_cord;
int y_cord;
int user_preference;
bool fast_charging;
uint public total = 10;
mapping(uint => CS) public Charging_station;
struct CS{
string name;
int loc;
int x_coordinate;
int y_coordinate;
int cost;
int wait_time;
int charging_points;
int rating;
bool fast_charging;
}
constructor() {
Charging_station[0] = CS("A", 0, 10, 20, 120, 30, 2,4, true);
Charging_station[1] = CS("B", 0, 30, 38, 70, 20, 3,3, false);
Charging_station[2] = CS("C", 0, 20, 40, 75, 40, 3,4, false);
Charging_station[3] = CS("D", 0, 42, 30, 150, 30, 4,2, true);
Charging_station[4] = CS("E", 0, 60, 50, 130, 25, 5,5, true);
Charging_station[5] = CS("F", 0, 50, 48, 125, 30, 2,4, true);
Charging_station[6] = CS("G", 0, 35, 36, 70, 20, 3,3, false);
Charging_station[7] = CS("H", 0, 52, 41, 75, 40, 3,4, false);
Charging_station[8] = CS("I", 0, 65, 35, 175, 30, 4,2, true);
Charging_station[9] = CS("J", 0, 25, 39, 160, 25, 5,5, true);
}
function abs(int a) internal returns (int result) {
return (a < 0 ? -a : a);
}
function calculate_distance() public
{
for(uint i =0 ; i< total; i++)
{
Charging_station[i].loc = abs(Charging_station[i].x_coordinate - x_cord) +
abs(Charging_station[i].y_coordinate - y_cord);
}
}
function getItems() public view returns(CS[] memory) {
uint totalMatches = 0;
CS[] memory matches = new CS[](total);
for (uint i = 0; i < total; i++) {
CS memory e = Charging_station[i];
matches[totalMatches] = e;
totalMatches++;
}
return matches;
}
/**
* @dev Returns tuple(uint256,uint256)[]: 3,1, 1,2, 4,3, 5,4, 2,5
*/
function sortByDistance() public view returns(CS[] memory) {
CS[] memory items = getItems();
for (uint i = 0; i < items.length; i++)
for (uint j = 0; j < i; j++)
if (items[i].loc < items[j].loc) {
CS memory x = items[i];
items[i] = items[j];
items[j] = x;
}
return items;
}
function sortByPrice() public view returns(CS[] memory) {
CS[] memory items = getItems();
for (uint i = 0; i < items.length; i++)
for (uint j = 0; j < i; j++)
if (items[i].cost < items[j].cost) {
CS memory x = items[i];
items[i] = items[j];
items[j] = x;
}
return items;
}
function distance(int d,int x , int y, int z, bool fast) public{
dist = d;
x_cord = x;
y_cord = y;
user_preference=z;
fast_charging = fast;
}
function getpreference() public view returns(int){
return user_preference;
}
function getdistance() public view returns(int){
return dist;
}
function getlongitude() public view returns(int){
return x_cord;
}
function getlatitude() public view returns(int){
return y_cord;
}
function getcharging() public view returns(bool){
return fast_charging;
}
function getResult() public view returns(CS[] memory) {
uint k =0;
uint n =0;
CS[] memory result = new CS[](total);
if(user_preference == 1){
CS[] memory distance = sortByDistance();
//CS[] memory result;
//for (uint j = 0; j < distance.length; j++)
//{
// distance[j].loc = distance[j].loc - loc;
//}
for (uint i = 0; i < distance.length; i++)
{
if(distance[i].loc <= dist)
{
k = k+1;
}
}
for (uint i =0 ; i<k;i++)
{
if(distance[i].fast_charging == true && fast_charging == true)
{
result[n] = distance[i];
n=n+1;
}
else if(distance[i].fast_charging == false && fast_charging == false)
{
result[n] = distance[i];
n=n+1;
}
}
}
if(user_preference == 2)
{
CS[] memory cost = sortByPrice();
//CS[] memory result;
for (uint j = 0; j < cost.length; j++)
{
if(cost[j].loc < dist)
{
if(cost[j].fast_charging == true && fast_charging == true)
{
result[n] = cost[j];
n=n+1;
}
else if(cost[j].fast_charging == false && fast_charging == false)
{
result[n] = cost[j];
n=n+1;
}
}
}
}
return result;
}
}
-- MINI PROJECT ANSWER--

-- Questions – Write SQL queries to get data for following requirements:

#1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select*from IPL_BIDDING_DETAILS;
select ibd.bidder_id,truncate(count(case when bid_status='Won' then 1 else null end)/count(ibbd.bidder_id)*100,2) percentage
from ipl_bidder_details ibd join ipl_bidding_details ibbd
on ibd.bidder_id=ibbd.bidder_id
group by ibd.bidder_id
order by percentage desc;

#2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
select stadium_name,city,count(ims.stadium_id) no_of_matches
from ipl_match_schedule ims join ipl_stadium ips
on ims.STADIUM_ID=ips.STADIUM_ID
group by stadium_name,city;

#3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
select*from ipl_match;
select*from ipl_match_schedule;

select ims.stadium_id,stadium_name,
truncate(count(case when toss_winner=match_winner then 1 else null end)/count(ims.stadium_id)*100,2) toss_match_percentage
from ipl_match im join ipl_match_schedule ims
on im.MATCH_ID=ims.MATCH_ID
join ipl_stadium ips
on ims.STADIUM_ID=ips.STADIUM_ID
group by STADIUM_ID;
######################################################################################################################################
select ims.stadium_id,stadium_name,
case
when 
((case when toss_winner=1 then team_id1 else team_id2 end)=(case when match_winner=1 then team_id1 when match_winner=2 then team_id2 else match_winner end))
then count(case when toss_winner=match_winner then 1 else null end) 
else count(case when toss_winner=match_winner then 1 else null end) 
end/count(ims.stadium_id)*100 percentage
from ipl_match im join ipl_match_schedule ims
on im.MATCH_ID=ims.MATCH_ID
join ipl_stadium ips
on ims.STADIUM_ID=ips.STADIUM_ID
group by ims.stadium_id,stadium_name;


#4.	Show the total bids along with bid team and team name.
select*from ipl_bidding_details;
select bid_team,team_name,count(bid_team) Bid_Count
from ipl_bidding_details ibd join ipl_team it
on ibd.BID_TEAM=it.TEAM_ID
group by bid_team,team_name;

#5.	Show the team id who won the match as per the win details.
-- Ans
select match_id, case when match_winner=1 then team_id1 else team_id2 end wining_team_id
from ipl_match;
#########################################################################################
-- For Total wining count of teams (EXTRA)
select it.team_id,
case 
when MATCH_WINNER=1 then count(case when TEAM_ID1=it.TEAM_ID then 1 else null end) 
else count(case when TEAM_ID2=it.TEAM_ID then 1 else null end) end wining_count
from ipl_match im join ipl_team it
group by it.team_id;

#6.	Display total matches played, total matches won and total matches lost by team along with its team name.
select its.team_id,team_name,sum(matches_played) Matches_Played,sum(Matches_Won) Matches_Won,sum(Matches_lost) Matches_Lost
from ipl_team_standings its join ipl_team it
on its.TEAM_ID=it.TEAM_ID
group by its.team_id,team_name;


#7.	Display the bowlers for Mumbai Indians team.
select itp.player_id,player_name,player_role
from ipl_team it join ipl_team_players itp
on it.TEAM_ID=itp.TEAM_ID
join ipl_player ip
on ip.PLAYER_ID=itp.PLAYER_ID
where team_name='Mumbai Indians' and itp.PLAYER_ROLE='Bowler';

#8.	How many all-rounders are there in each team, Display the teams with more than 4 all-rounder in descending order.
select team_name,count(itp.team_id) all_rounder_count
from ipl_team it join ipl_team_players itp
on it.TEAM_ID=itp.TEAM_ID
where itp.PLAYER_ROLE='All-Rounder'
group by team_name
having all_rounder_count>4
order by all_rounder_count desc;

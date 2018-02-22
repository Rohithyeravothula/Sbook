SELECT POSTS.USER_ID FROM 
COMMENTS  LEFT JOIN POSTS 
on COMMENTS.POST_ID=5 AND COMMENTS.COMMENTER_USER_ID  = POSTS.USER_ID;



Query1

INSERT INTO USERS (NAME, GENDER, DATE_OF_BIRTH) VALUES ("HMM", "F", "2012-12-12"), ("MEMM", "F", "2012-12-12"), ("WATER", "F", "2012-12-12");
INSERT INTO COMMENTS (POST_ID, COMMENTER_USER_ID, TEXT) VALUES (5, 101, "RIMBOLA"), (5, 102, "BEWD");


SELECT DISTINCT USERS.USER_ID, USERS.NAME FROM
(SELECT candidates.COMMENTER_USER_ID  FROM 
(SELECT COMMENTER_USER_ID  from COMMENTS WHERE POST_ID=5) candidates 
LEFT JOIN POSTS ON candidates.COMMENTER_USER_ID  = POSTS.USER_ID
WHERE POSTS.USER_ID is null) first
JOIN
USERS
WHERE USERS.USER_ID=first.COMMENTER_USER_ID;

Explanation:

candidates subquery, selects all users who have commented on post with POSTS_ID=5
first subquery selects all users from candidates, who have not made any POSTS
and finally outer select, collects the id and name of the user




Query2

INSERT INTO FRIENDSHIPS (USER_ID, FRIEND_ID) VALUES (1,169);
INSERT INTO FRIENDSHIPS (USER_ID, FRIEND_ID) VALUES (1,85);
INSERT INTO FRIENDSHIPS (USER_ID, FRIEND_ID) VALUES (1,778);
INSERT INTO FRIENDSHIPS (USER_ID, FRIEND_ID) VALUES (1,968);


SELECT DISTINCT first.FRIEND_ID FROM
(SELECT candidates.FRIEND_ID FROM
(SELECT FRIEND_ID FROM FRIENDSHIPS WHERE USER_ID=1) candidates
JOIN USERS
ON 
candidates.FRIEND_ID=USERS.USER_ID AND USERS.GENDER="F") first
JOIN
(SELECT FRIEND_ID FROM FRIENDSHIPS WHERE USER_ID=2) second
ON first.FRIEND_ID=second.FRIEND_ID;

Explanation:
candidates subquery selects user id,  who are firends of user with id=1
first subquery selects all the female users from candidates subquery
second subquery selects all the user id, who are friends of user with id=2
finally outer select and join selects all the female friends of user with id =1 who are 
also friends of user with id =2




Query3

CHECK THIS ONCE AGAIN

SELECT candidates.USER_ID FROM
(SELECT USER_ID FROM FRIENDSHIPS
GROUP BY USER_ID
HAVING COUNT(FRIEND_ID) > 2) candidates
JOIN
(SELECT USERS.USER_ID FROM USERS 
JOIN POSTS
ON USERS.USER_ID=POSTS.USER_ID
GROUP BY USERS.USER_ID
HAVING COUNT(POST_ID) > 1) postcandidates
ON candidates.USER_ID=postcandidates.USER_ID;

Explanation:
candidates subquery selects collects all the user ids, who have more than 2 friends
postcandidates subquery selects all user ids, corresponding to users who have made more that on post
finally outer select, selects all the users who have more than 2 friends and made more that one post



Query4

use unique since repeated USERS might exist



SELECT candidates.FUSER_ID, COUNT(FRIENDSHIPS.FRIEND_ID) AS COUNT FROM
(SELECT DISTINCT femaleusers.USER_ID as FUSER_ID FROM
(SELECT USER_ID FROM USERS WHERE USERS.gender="F" AND USERS.date_of_birth>"19901220") femaleusers
JOIN
(SELECT COMMENTER_USER_ID FROM COMMENTS JOIN POSTS WHERE POSTS.USER_ID=10 AND COMMENTS.POST_ID=POSTS.POST_ID) comment_users
ON femaleusers.USER_ID = comment_users.COMMENTER_USER_ID) candidates
JOIN FRIENDSHIPS
ON 	candidates.FUSER_ID=FRIENDSHIPS.USER_ID
GROUP BY candidates.FUSER_ID;

Explanation:
femaleusers subquery selects all user ids, who are femal and were born after 1990-12-20 date, 
comment_users subquery selects all user ids, who commented on post, made by user with id=10
candidates subquery selects distinct female users, who have were born aftet the date, and commented on post made 
by user with id=10
finally outer select, selects all the female users, and count of friends of female users, that appeared in candidates 
subquery



Query5


INSERT INTO COMMENTS (POST_ID, COMMENTER_USER_ID , text) values (7, 227, "kVOz9jdFapVNqJDht");


SELECT DISTINCT FRIEND_ID FROM 
POSTS JOIN FRIENDSHIPS
ON POSTS.POST_ID=7 AND POSTS.USER_ID=FRIENDSHIPS.USER_ID
JOIN COMMENTS
ON COMMENTS.POST_ID=7 and FRIENDSHIPS.FRIEND_ID=COMMENTS.COMMENTER_USER_ID ;


Explanation:
first join selects all friends of user, who made the post with post id =7
second join selects all the friend ids, who have commented on post, with id = 7
and both joins together will select all friends who commented on post made by users, 
who have posted on post with id=7



Query6

SELECT USERS.USER_ID AS U1, USERS1.USER_ID AS U2, USERS2.USER_ID AS U3 FROM USERS CROSS JOIN USERS AS USERS1 CROSS JOIN USERS AS USERS2 LIMIT 10;




SELECT tuple.U1, tuple.U2, COUNT()
(SELECT USERS.USER_ID AS U1, USERS1.USER_ID AS U2 FROM USERS CROSS JOIN USERS AS USERS1 LIMIT 10) tuple
JOIN 
(SELECT COMMENTER_USER_ID FROM POSTS JOIN COMMENTS WHERE POSTS.POST_ID!=10 AND POSTS.POST_ID=COMMENTS.POST_ID) commenters
ON tuple.U1 == commenters.COMMENTER_USER_ID
GROUP BY 


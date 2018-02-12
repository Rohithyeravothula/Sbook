SELECT Posts.user_id FROM 
Comments  LEFT JOIN Posts 
on Comments.post_id=5 AND Comments.commenter_user_id = Posts.user_id;



Query1

INSERT INTO Users (name, gender, date_of_birth) values ("answer1", "M", "2020-10-21");
INSERT INTO Comments (post_id, commenter_user_id, text) values (5, 1001, "smnhovltskzajqybxjgw");

SELECT Users.user_id, Users.name FROM
	(SELECT candidates.commenter_user_id FROM 
	(SELECT commenter_user_id from Comments WHERE post_id=5) candidates 
	LEFT JOIN Posts ON candidates.commenter_user_id = Posts.user_id
	WHERE Posts.user_id is null) first
	JOIN
	Users
	WHERE Users.user_id=first.commenter_user_id;



Query2

INSERT INTO Friendships (user_id, friend_id) values (2,169);
INSERT INTO Friendships (user_id, friend_id) values (2,85);
INSERT INTO Friendships (user_id, friend_id) values (2,778);
INSERT INTO Friendships (user_id, friend_id) values (2,968);

(SELECT * FROM Friendships WHERE user_id=1) candidates


SELECT first.friend_id FROM
	(SELECT candidates.friend_id FROM
		(SELECT friend_id FROM Friendships WHERE user_id=1) candidates
		JOIN Users 
		ON 
		candidates.friend_id=Users.user_id AND Users.gender="F") first
	JOIN
	(SELECT friend_id FROM Friendships WHERE user_id=2) second
on first.friend_id=second.friend_id;




Query3



SELECT user_id FROM 
Users
JOIN Posts
ON Users.user_id=Posts.user_id






Query5

(SELECT user_id FROM Comments WHERE post_id=7) candidates




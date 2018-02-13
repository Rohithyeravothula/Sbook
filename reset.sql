USE assignment2

drop table Comments;
drop table Friendships;
drop table Posts;
drop table Users;





CREATE TABLE Users ( 
  user_id BIGINT AUTO_INCREMENT NOT NULL, 
  name varchar(30),
  gender char(1),
  date_of_birth DATE,
  PRIMARY KEY (user_id)
  );

CREATE TABLE Friendships(
  user_id BIGINT NOT NULL,
  friend_id BIGINT NOT NULL,
  FOREIGN KEY(user_id) REFERENCES Users(user_id),
  FOREIGN KEY(friend_id) REFERENCES Users(user_id)
); 


CREATE TABLE Posts(
  post_id BIGINT AUTO_INCREMENT NOT NULL,
  user_id BIGINT,
  text varchar(100),
  PRIMARY KEY(post_id),
  FOREIGN KEY(user_id) REFERENCES Users(user_id)
  );

CREATE TABLE Comments(
  comment_id BIGINT AUTO_INCREMENT NOT NULL,
  post_id BIGINT,
  commenter_user_id BIGINT,
  text varchar(100),
  PRIMARY KEY(comment_id),
  FOREIGN KEY(post_id) REFERENCES Posts(post_id),
  FOREIGN KEY(commenter_user_id) REFERENCES Users(user_id) 
);



from random import randint, choice
import datetime
import string

users = 10
friends = int(2.5*users)
posts = int(1.4*users)
comments = int(10*posts)



def get_gender():
    gender = ["M", "F"]
    return gender[randint(0,1)]

def get_text():
    string_domain = string.ascii_letters + string.digits
    return "".join(choice(string_domain) for _ in range(0, randint(10, 20)))


def get_time():
    date = datetime.date(randint(2005, 2025), randint(1, 12), randint(1, 28))
    return "{}-{}-{}".format(date.year, date.month, date.day)

def get_users():
    data = ""
    for i in range(0, users):
        data += "INSERT INTO Users (name, gender, date_of_birth) values " \
                "(\"{}\", \"{}\", \"{}\");".format(get_text(), get_gender(), get_time())
        data += "\n"
    return data

def get_friendships():
    data = ""
    for i in range(0, friends):
        u1 = randint(1, users)
        u2 = randint(1, users)
        data += "INSERT INTO Friendships (user_id, friend_id) values ({},{});".format(u1, u2)
        data += "\n"
    return data

def get_posts():
    data = ""
    for i in range(0, posts):
        u = randint(1, users)
        data += "INSERT INTO Posts (user_id, text) values ({}, \"{}\");".format(u, get_text())
        data += "\n"
    return data

def get_comments():
    data = ""
    for i in range(0, comments):
        u = randint(1, users)
        p = randint(1, posts)
        data += "INSERT INTO Comments (post_id, commenter_user_id, text) values ({}, {}, \"{}\");".format(p, u, get_text())
        data += "\n"
    return data


def get_data():
    data = [get_users(),  get_friendships(),  get_posts(), get_comments()]
    with open("bootstrap.sql", 'w') as f:
        f.write("USE assignment2\n")
        for d in data:
            f.write(d)


get_data()

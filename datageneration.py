from random import randint, choice
import datetime
import string

USERS = 1000
friends = int(2.5*USERS)
POSTS = int(1.4*USERS)
COMMENTS = int(10*POSTS)



def get_GENDER():
    GENDER = ["M", "F"]
    return GENDER[randint(0,1)]

def get_TEXT():
    string_domain = string.ascii_letters + string.digits
    return "".join(choice(string_domain) for _ in range(0, randint(10, 20)))


def get_time():
    date = datetime.date(randint(2005, 2025), randint(1, 12), randint(1, 28))
    return "{}-{}-{}".format(date.year, date.month, date.day)

def get_USERS():
    data = ""
    for i in range(0, USERS):
        data += "INSERT INTO USERS (NAME, GENDER, DATE_OF_BIRTH) values " \
                "(\"{}\", \"{}\", \"{}\");".format(get_TEXT(), get_GENDER(), get_time())
        data += "\n"
    return data

def get_FRIENDSHIPS():
    data = ""
    for i in range(0, friends):
        u1 = randint(1, USERS)
        u2 = randint(1, USERS)
        data += "INSERT INTO FRIENDSHIPS (USER_ID, FRIEND_ID) values ({},{});".format(u1, u2)
        data += "\n"
    return data

def get_POSTS():
    data = ""
    for i in range(0, POSTS):
        u = randint(1, USERS)
        data += "INSERT INTO POSTS (USER_ID, TEXT) values ({}, \"{}\");".format(u, get_TEXT())
        data += "\n"
    return data

def get_COMMENTS():
    data = ""
    for i in range(0, COMMENTS):
        u = randint(1, USERS)
        p = randint(1, POSTS)
        data += "INSERT INTO COMMENTS (POST_ID, COMMENTER_USER_ID, TEXT) values ({}, {}, \"{}\");".format(p, u, get_TEXT())
        data += "\n"
    return data


def get_data():
    data = [get_USERS(),  get_FRIENDSHIPS(),  get_POSTS(), get_COMMENTS()]
    with open("bootstrap.sql", 'w') as f:
        f.write("USE assignment2\n")
        for d in data:
            f.write(d)


get_data()

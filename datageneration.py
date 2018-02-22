from random import randint, choice
import datetime
import string

USERS = 100
friends = int(25*USERS)
POSTS = int(14*USERS)
COMMENTS = int(100*POSTS)



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
    data = "INSERT INTO USERS (NAME, GENDER, DATE_OF_BIRTH) values "
    for i in range(0, USERS):
        data +="(\"{}\", \"{}\", \"{}\")".format(get_TEXT(), get_GENDER(), get_time())
        data += ","
    return data[:-1]+";\n"

def get_FRIENDSHIPS():
    data = "INSERT INTO FRIENDSHIPS (USER_ID, FRIEND_ID) values "
    for i in range(0, friends):
        u1 = randint(1, USERS)
        u2 = randint(1, USERS)
        data += "({},{}),({}, {})".format(u1, u2, u2, u1)
        data += ","
    return data[:-1]+";\n"

def get_POSTS():
    data = "INSERT INTO POSTS (USER_ID, TEXT) values "
    for i in range(0, POSTS):
        u = randint(1, USERS)
        data += "({}, \"{}\")".format(u, get_TEXT())
        data += ","
    return data[:-1]+";\n"

def get_COMMENTS():
    data = "INSERT INTO COMMENTS (POST_ID, COMMENTER_USER_ID, TEXT) values "
    for i in range(0, COMMENTS):
        u = randint(1, USERS)
        p = randint(1, POSTS)
        data += "({}, {}, \"{}\")".format(p, u, get_TEXT())
        data += ","
    return data[:-1]+";\n"


def get_data():
    data = [get_USERS(),  get_FRIENDSHIPS(),  get_POSTS(), get_COMMENTS()]
    with open("bootstrap.sql", 'w') as f:
        f.write("USE assignment2\n")
        for d in data:
            f.write(d)


get_data()

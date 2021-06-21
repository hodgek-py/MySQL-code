CREATE TABLE users (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    photo_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags (
    photo_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);

#### OLDEST USERS
SELECT id, username, created_at FROM users ORDER BY created_at LIMIT 5;

### What day do people sign up on
SELECT DAYNAME(created_at), COUNT(DAYNAME(created_at)) FROM users GROUP BY DAYNAME(created_at) 
ORDER BY COUNT(DAYNAME(created_at)) DESC;

### Users who have never posted
SELECT * FROM users LEFT JOIN photos ON users.id = photos.user_id where image_url IS NULL;

### Most liked photos
SELECT photos.id, photos.image_url, count(likes.user_id) as 'total likes' FROM photos JOIN likes ON likes.photo_id = photos.id 
GROUP BY photos.image_url ORDER BY count(likes.user_id) DESC LIMIT 2;

### How many times does the average user posted
select (SELECT count(*) FROM photos)
/ (SELECT COUNT(*) FROM users);

### top 5 hashtags
SELECT tag_name, count(tag_id) FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id GROUP BY tag_name
ORDER BY count(tag_id) DESC LIMIT 5; 

### bots who have liked every photo
SELECT username, count(user_id) FROM users JOIN likes ON users.id = likes.user_id
GROUP BY user_id
HAVING count(user_id) = (SELECT COUNT(*) FROM photos);
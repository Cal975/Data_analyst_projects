/* The company would like to reward 5 of their users who have been using the platform the longest
This query finds the 5 oldest users in the database*/
SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

/* The company would like to schedule an ad campaign.
This query finds what day of the week has the most new registrations, as they believe this to be the optimal time to schedule their new ad campaign.*/
SELECT 
    DAYNAME(created_at) AS what_day, COUNT(*) AS total
FROM
    users
GROUP BY what_day
ORDER BY total DESC;

/* This query will help target inactive users with an email campaign*/
SELECT 
    username, image_url
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.id IS NULL;
    
/* This query picks out the user with the most liked photo to win a prize*/
SELECT 
    username, photos.id, photos.image_url, COUNT(*) AS total
FROM
    photos
        INNER JOIN
    likes ON likes.photo_id = photos.id
        INNER JOIN
    users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

/* This query answers investors question on what the average number of times a user posts*/
SELECT 
    (SELECT 
            COUNT(*)
        FROM
            photos) / (SELECT 
            COUNT(*)
        FROM
            users) AS average;
            
/* This query helps a brand find the top 5 most commonly used hashtags*/
SELECT 
    tag_name, COUNT(*) AS total
FROM
    photo_tags
        JOIN
    tags ON photo_tags.tag_id = tags.id
GROUP BY tag_name
ORDER BY total DESC
LIMIT 5;

/* This query helps find bot accounts based on these users liking every photo on the platform*/
SELECT 
    username, COUNT(*) AS num_likes
FROM
    users
        INNER JOIN
    likes ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT 
        COUNT(*)
    FROM
        photos);

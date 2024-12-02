
/* Download the files on canvas, and unzip them before following the steps below: */
SET GLOBAL LOCAL_INFILE=TRUE;
SHOW GLOBAL VARIABLES LIKE 'LOCAL_INFILE';

Drop database yelp;
-- first create the database
CREATE DATABASE IF NOT EXISTS yelp;

use yelp;

# now create the business table 

CREATE TABLE business
(
    bid int,
    business_id varchar(100),
    name varchar(100),
    address varchar(150),
    city varchar(100),
    state varchar(100),
    postal_code varchar(50),
    latitude float,
    longitude float,
    stars float,
    review_count int,
    is_open int
);

#upload the business table from the csv file. replace the path with the path in your machine where the file is located

LOAD DATA LOCAL INFILE 'C:/Users/emyne/Downloads/yelp_academic_dataset_business.csv'
INTO TABLE yelp.business
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '/r/n'
IGNORE 1 ROWS
(bid, business_id,name,address,city,state,postal_code,latitude,longitude,stars,review_count,is_open);


#create the user table 

CREATE TABLE user
(
    uid int,
    user_id varchar(100),
    name varchar(100),
    review_count int,
    yelping_since TIMESTAMP  DEFAULT CURRENT_TIMESTAMP NOT NULL, -- note difference from MySQL
    average_stars float,
    useful_votes int,
    funny_votes int,
    cool_votes int,
    fans int,
    compliment_hot int,
    compliment_more int,
    compliment_profile int,
    compliment_cute int,
    compliment_list int,
    compliment_note int,
    compliment_plain int,
    compliment_cool int,
    compliment_funny int,
    compliment_writer int,
    compliment_photos int
);

#upload the user table from the csv file. replace the path with the path in your machine where the file is located

LOAD DATA LOCAL INFILE 'C:/Users/emyne/Downloads/yelp_academic_dataset_user.csv'
INTO TABLE yelp.user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '/r/n'
IGNORE 1 ROWS
(uid,user_id,name,review_count,yelping_since,average_stars,useful_votes,funny_votes,cool_votes,fans,compliment_hot,compliment_more,
 compliment_profile,compliment_cute,compliment_list,compliment_note,compliment_plain,compliment_cool,compliment_funny,compliment_writer,
    compliment_photos);


# now repeat the same for review_notext

CREATE TABLE review_notext
(
    rid int,
    review_id varchar(100),
    business_id varchar(100),
    user_id varchar(100),
    stars int,
    date date,
    userful_votes int,
    funny_votes int,
    cool_votes int
);

LOAD DATA LOCAL INFILE 'C:/Users/emyne/Downloads/yelp_academic_dataset_review_notext.csv'
INTO TABLE yelp.review_notext
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(rid,review_id,business_id,user_id,stars,date,userful_votes,funny_votes,cool_votes);


# repeat the same for category table 

CREATE TABLE category
(
    cid int,
    business_id varchar(100),
    category_name varchar(100)
);


LOAD DATA LOCAL INFILE 'C:/Users/emyne/Downloads/yelp_academic_dataset_category.csv'
INTO TABLE yelp.category
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cid, business_id, category_name);

SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'AB'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'AZ'
    )
ORDER BY 
    b.state ASC;

SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'CA'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'DE'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'FL'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'ID'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'IL'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'IN'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'LA'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'MO'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'NC'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'NJ'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'PA'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'NV'
    )
ORDER BY 
    b.state ASC;
    
SELECT 
    b.name, 
    b.city, 
    b.address, 
    b.state, 
    b.postal_code, 
    b.stars, 
    b.review_count,
    c.category_name
FROM 
    business b
LEFT JOIN 
    category c
ON 
    b.business_id = c.business_id
WHERE 
    b.business_id IN (
        SELECT 
            b_sub.business_id 
        FROM 
            business b_sub
        JOIN 
            category c_sub 
        ON 
            b_sub.business_id = c_sub.business_id
        WHERE 
            c_sub.category_name = 'Restaurants' 
            AND b_sub.state = 'TN'
    )
ORDER BY 
    b.state ASC;

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
 
-- Retrieving all restaurants in FL
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

-- Star and review count for restaurants by city
SELECT 
    b.city,
    b.name,
    b.stars,
    SUM(b.review_count) AS total_reviews,
    AVG(b.stars) AS avg_stars
FROM 
    business b
join category c on b.business_id = c.business_id
WHERE b.state = 'FL' AND c.category_name = 'Restaurants'
Group by b.city, b.name, b.stars
ORDER BY 
    b.city, total_reviews DESC;

-- Star and reviews for restaurants by Restaurant Categories
SELECT 
    c.category_name,
    b.name AS restaurant_name,
    b.stars,
    SUM(b.review_count) AS total_reviews,
    AVG(b.stars) AS avg_stars
FROM 
    business b
JOIN 
    category c ON b.business_id = c.business_id
WHERE b.state = 'FL' AND c.category_name IN (
	'Restaurants', 'Breakfast & Brunch', 'Cafes', 'Food', 'Sandwiches', 'Pizza', 
    'American (Traditional)', 'Bars', 'Pubs', 'Champagne Bars', 
    'Tapas Bars', 'Beer Bar', 'Japanese', 'Steakhouses', 'Sushi Bars', 'American (New)', 'Burgers',
    'Coffee & Tea', 'Fish & Chips', 'Chicken Wings', 'Latin American', 'Peruvian', 
    'Ice Cream & Frozen Yogurt', 'Bagels', 'Hot Dogs', 'Seafood', 'Italian', 'Local Flavor', 
    'Desserts', 'Bakeries', 'Diners', 'Mexican', 'Asian Fusion', 'Chinese', 'Thai', 'Salad', 
    'Cheesesteaks', 'Delis', 'Acai Bowls', 'Vegan', 'Juice Bars & Smoothies', 'Spanish', 'Empanadas',
    'Tacos', 'Fast Food', 'Soup', 'Wine Bars', 'Wine & Spirits', 'Beer', 
    'Specialty Food', 'Barbeque', 'Fruits & Veggies', 'Mediterranean', 'Cocktail Bars', 
    'Caribbean', 'Cajun/Creole', 'Puerto Rican', 'Tex-Mex', 'Gluten-Free', 'Vietnamese', 
    'Noodles', 'Tiki Bars', 'Vegetarian', 'Wraps', 'Cuban', 'Pan Asian', 'Halal', 'Indian', 
    'Comfort Food', 'Food Trucks', 'Chicken Shop', 'Greek', 'Venezuelan', 'Pasta Shops',
    'Tea Rooms', 'Waffles', 'Southern', 'Laotian', 'Buffets', 'Pakistani', 'Country Clubs', 
	'Donuts', 'Middle Eastern', 'Lebanese', 'Live/Raw Food', 
    'Dim Sum', 'Cantonese', 'Street Vendors', 'Falafel', 'Egyptian', 'Tapas/Small Plates', 'Soul Food', 
    'Bubble Tea', 'Hawaiian', 'Poke', 'Polish', 
	'Ethnic Food', 'Taiwanese', 'Turkish', 'Shaved Ice', 'Gastropubs', 'Malaysian', 
    'Breweries', 'Ramen', 'Colombian', 'Wineries', 
    'Beer Gardens', 'Custom Cakes', 'Patisserie/Cake Shop', 'Cupcakes', 'Creperies',
    'Hot Pot', 'Szechuan', 'Coffee Roasteries', 'Gelato', 'Food Court', 'Kebab','British','Trinidadian',
    'French', 'Dive Bars','German', 'Irish', 'Kombucha', 'Irish Pub', 'Whiskey Bars', 
    'Pop-Up Restaurants', 'Bistros', 'Brewpubs', 'Mongolian','Armenian', 'Brazilian', 
	'Themed Cafes', 'Korean', 'New Mexican Cuisine', 'Bed & Breakfast', 'Smokehouse',
    'Fondue', 'Dominican', 'Portuguese', 'Farmers Market', 'Basque',
    'African', 'Pretzels', 'Modern European','Sicilian',
    'Chocolatiers & Shops','Senegalese','Arabic', 'Haitian', 'Moroccan', 
    'Teppanyaki', 'Argentine', 'Russian', 'Kosher', 'Filipino', 'Hungarian', 'Belgian', 
	'Persian/Iranian', 'Syrian', 'Ethiopian', 'Cheese Shops','Burmese','Scottish', 'Public Markets', 
	'Macarons', 'Tuscan', 'Japanese Curry', 'Austrian', 'Izakaya', 'Distilleries', 
    'Shaved Snow', 'Salvadoran', 'Ukrainian', 'Sardinian', 'International', 'Bangladeshi', 'Afghan'
    )
GROUP BY 
    c.category_name, b.name, b.stars
ORDER BY 
    c.category_name, total_reviews DESC;

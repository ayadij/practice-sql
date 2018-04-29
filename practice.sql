-- Sudo mysql.server start
-- Sudo mysql.server stop

-- Mysql.server status 
-- Sudo kill 78001
-- Sudo kill 78101
-- mysql.server start

USE learning_sql;

SELECT *
FROM users;


# ———————————————————————— reverse 
BEGIN;
UPDATE guides
SET guides_title = “Oops”
WHERE guides_users_id = 1;

ROLLBACK;

# —————————————————
SELECT *
FROM guides;

SELECT distinct guides_title
FROM guides;

# ———————————————————— order stuff

SELECT guides_title
FROM guides
ORDER BY guides_title DESC;

SELECT guides_title
FROM guides
ORDER BY guides_title ASC;
  #alphabetical order

SELECT guides_revenue, guides_title
FROM guides
ORDER BY CAST(guides_revenue AS UNSIGNED) DESC;


# ———————————————————— deleting records

SELECT * 
FROM users
WHERE users_id = 199;

    #to remove this user:
BEGIN;
DELETE FROM users
WHERE users_id = 199;

ROLLBACK;


# ———————————————————— ranges

SELECT * 
FROM guides
WHERE guides_revenue BETWEEN 1000 and 5000;

SELECT *
FROM guides
WHERE guides_revenue NOT BETWEEN 1000 and 5000;


# ———————————————————— wildcard search

SELECT *
FROM guides;

SELECT *
FROM guides
WHERE guides_title LIKE '%My%';

SELECT *
FROM guides
WHERE guides_title NOT LIKE '%My%';


# ————————————————— clean where/in command
Multiple entries in the same column

SELECT *
FROM addresses
WHERE addresses_city = 'Queens'
OR addresses_city = 'Manhattan';

-- Is the same as:

SELECT *
FROM addresses
WHERE addresses_city IN ('Queens', 'Manhattan');


—————————————————subqueries 
Nesting searches

SELECT guides_title, guides_revenue
FROM guides
WHERE guides_revenue = (
  SELECT MAX(guides_revenue)
  FROM guides
);



SELECT guides_title, guides_revenue
FROM guides
WHERE guides_revenue = 1500;

SELECT guides_title, guides_revenue
FROM guides
WHERE guides_revenue = (
  SELECT MIN(CAST(guides_revenue AS UNSIGNED))
  FROM guides
);

-- with dynamic data and even collections of data 

SELECT *
FROM addresses
WHERE addresses_city IN ('Manhattan', 'Queens');


# —————————————————

INSERT INTO guides(guides_revenue, guides_title, guides_users_id, guides_qty)
VALUES(
  500,
  'Guide by Jon',
  (SELECT users_id FROM users WHERE users_name = 'Jon' LIMIT 1),
  300);






# ——————————————agrigate functions

# ——————min——————
SELECT MIN(guides_revenue)
FROM guides;
# ——————max——————
SELECT MAX(guides_revenue)
FROM guides;
# ——————sum——————
SELECT SUM(guides_revenue)
FROM guides;
# ——————avg——————
SELECT AVG(guides_revenue)
FROM guides;
# —————count—————— 
SELECT COUNT(*)
FROM users;
# ————specific count————
SELECT COUNT(*)
FROM addresses
WHERE addresses_state = 'NY';


# —————————————— summary reports with group by

# ————— count of each state
SELECT addresses_state, COUNT(addresses_state)
FROM addresses
GROUP BY addresses_state;
# ———————— count of each city
SELECT addresses_city, COUNT(addresses_city)
FROM addresses
GROUP BY addresses_city;
# ———— ground guide user id then sum the revenue per user
SELECT guides_users_id, SUM(guides_revenue)
FROM guides
GROUP BY guides_users_id;


# —————————————— safe mode off

SET SQL_SAFE_UPDATES = 0;

BEGIN;
UPDATE addresses 
SET addresses_city = “Oops”;

ROLLBACK;


# ————————————— custom row and cell names

SELECT 'Email:', users_email, 'Name:', users_name
FROM users;


# —————————— Alias

SELECT
addresses_street_one AS 'Street',
addresses_street_two AS 'Street 2',
addresses_city AS 'City',
addresses_state AS 'State',
addresses_postal_code AS 'Postal Code'
FROM addresses;


# ——————————Alias Table Name

SELECT guides_title, guides_revenue
FROM guides
WHERE guides_revenue > 600;

SELECT g.guides_title, g.guides_revenue
FROM guides g
WHERE g.guides_revenue > 600;



# —————————————— case statements

SELECT
  guides_title,
  CASE
    WHEN guides_revenue > 1000 THEN 'Best Seller'
    WHEN guides_revenue < 600  THEN 'Not Displayed'
    ELSE 'Average Sellers'
  END AS 'status'
FROM guides;

# —————————————— inner join

SELECT *
FROM guides
INNER JOIN users # you can just say join instead of inner join
ON guides.guides_users_id = users.users_id;

SELECT 
g.guides_title, 
g.guides_revenue, 
u.users_name, 
u.users_email
FROM guides g
JOIN users u
on g.guides_users_id  = u.users_id;

SELECT *
FROM guides g
JOIN users u
on g.guides_users_id  = u.users_id
WHERE u.users_name = 'Tiffany';

SELECT *
FROM guides g
JOIN users u
on g.guides_users_id  = u.users_id
WHERE g.guides_revenue > 400
AND u.users_name = 'Kristine'
OR g.guides_revenue > 400
AND u.users_name = 'Tiffany'


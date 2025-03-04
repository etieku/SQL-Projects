USE
	magist;
    
#-------------------------------------------------------------------------------------
#3.1-Range of dates for data in the database = from 4 Sept 2016 to 17 Oct 2018
#-------------------------------------------------------------------------------------
SELECT
	MIN(order_purchase_timestamp), 	#'2016-09-04 23:15:19'
    MAX(order_purchase_timestamp) 	#'2018-10-17 19:30:18'
FROM
	orders;
#-------------------------------------------------------------------------------------    
#Looking at all the categories in the database
#-------------------------------------------------------------------------------------
SELECT 
	product_category_name as Original,
    product_category_name_english as English_translation
FROM 
	product_category_name_translation
ORDER BY 
	English_translation ASC;
#----------------------------------- #There are 74 categories in the database    
SELECT 
	COUNT(DISTINCT(product_category_name))
FROM 
	product_category_name_translation;


#-------------------------------------------------------------------------------------
#3.1-"Tech" categories (long version of WHERE...OR)
#-------------------------------------------------------------------------------------
SELECT 
    product_category_name_english as Categories
FROM 
	product_category_name_translation
WHERE
	product_category_name_english= 'audio' OR
    product_category_name_english= 'auto' OR
    product_category_name_english= 'books_technical' OR
    product_category_name_english= 'cine_photo' OR
	product_category_name_english= 'computers' OR
	product_category_name_english= 'computers_accessories' OR
	product_category_name_english= 'consoles_games'OR
	product_category_name_english= 'electronics'OR
	product_category_name_english= 'pc_gamer'OR
    product_category_name_english= 'security_and_services' OR
	product_category_name_english= 'signaling_and_security'OR
	product_category_name_english= 'tablets_printing_image' OR
    product_category_name_english= 'telephony' OR
ORDER BY 
	Categories ASC;

#-------------------------------------------------------------------------------------
#3.1-"Tech" categories (short version of WHERE...IN)
#-------------------------------------------------------------------------------------
SELECT 
    product_category_name_english as Categories
FROM 
	product_category_name_translation
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
ORDER BY 
	Categories ASC;
    
#-------------------------------------------------------------------------------------
#3.1-"Tech" items sold (count by "tech" categories) =
#-------------------------------------------------------------------------------------
SELECT
    COUNT(order_item_id), #table order_items
    product_category_name_english #table product_category_name_translation;
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio', #364
    'auto', #4,235
    'books_technical', #267
    'cine_photo', #72
    'computers', #203
    'computers_accessories', #7,827
    'consoles_games', #1,137
    'electronics', #2,767
    'pc_gamer', #9
    'security_and_services', #2
    'signaling_and_security', #199
    'tablets_printing_image', #83
    'telephony') #4,545
GROUP BY
	product_category_name_english
ORDER BY
	product_category_name_english ASC;
    
#-------------------------------------------------------------------------------------
#3.1-"Tech" items sold (total amount of all "tech" categories sold)
#-------------------------------------------------------------------------------------
SELECT
    SUM(order_item_id) #table order_items= 25,638
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
    
#-------------------------------------------------------------------------------------
#Total number of items in the database to calculate percentage  
#-------------------------------------------------------------------------------------  
SELECT
    SUM(order_item_id) #table order_items= 134,936
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name;
    
#-------------------------------------------------------------------------------------
#3.1-Percentage "tech" products sold from all items sold
#-------------------------------------------------------------------------------------
SELECT
		(25638/134936)*100; #19%

#-------------------------------------------------------------------------------------
#3.1-Average price of the ORDERS being sold (all items)
#-------------------------------------------------------------------------------------
SELECT
    MIN(price), # 0.85 EUR
    MAX(price), # 6,735 EUR
    AVG(price) 	# 120.65 EUR. ==>divided by 1.14 AVG items per order=105.83 EUROS
FROM
	order_items; 
  
#to calculate price per ITEM  
SELECT (120.65/1.14);
    
#-------------------------------------------------------------------------------------
#3.1-Min, Max and Average prices of the ORDERS (only "tech" items)
#-------------------------------------------------------------------------------------

#to calculate price per "tech" ITEM  
SELECT (114.08/1.12);

SELECT
	MIN(price), # 3.49 EUR
    MAX(price), # 6,729 EUR
    AVG(price) 	# 114.08 EUR==>divided by 1.12 AVG items per order=101.86 EUROS
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
    
    
#-----------info on 'telephony' only
SELECT
	MIN(price), # 5 EUR
    MAX(price), # 2,428 EUR
    AVG(price) 	# 71.21 EUR
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'telephony');
    
    
#-------------------------------------------------------------------------------------
#3.1-Prices of "tech" products counted/grouped by price ranges
#-------------------------------------------------------------------------------------
SELECT
    price,
    COUNT(order_item_id)
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	price
ORDER BY
	2, 1 DESC;
    
#-------------------------------------------------------------------------------------
#3.1-Prices of "tech" products grouped by price ranges
#-------------------------------------------------------------------------------------
SELECT
    COUNT(order_item_id),
    CASE
		WHEN price < 100 THEN "Prices are 0-100"
        WHEN price BETWEEN 100 and 200 THEN "Prices are 0100-0200"
        WHEN price BETWEEN 201 and 300 THEN "Prices are 0201-0300"
        WHEN price BETWEEN 301 and 400 THEN "Prices are 0301-0400"
		WHEN price BETWEEN 401 and 500 THEN "Prices are 0401-0500"
        WHEN price BETWEEN 501 and 600 THEN "Prices are 0501-0600"
        WHEN price BETWEEN 601 and 700 THEN "Prices are 0601-0700"
        WHEN price BETWEEN 701 and 800 THEN "Prices are 0701-0800"
        WHEN price BETWEEN 801 and 900 THEN "Prices are 0801-0900"
        WHEN price BETWEEN 901 and 1000 THEN "Prices are 0901-1000"
        WHEN price BETWEEN 1001 and 2000 THEN "Prices are 1001-2000"
        WHEN price BETWEEN 2001 and 3000 THEN "Prices are 2001-3000"
        WHEN price BETWEEN 3001 and 4000 THEN "Prices are 3001-4000"
        WHEN price BETWEEN 4001 and 5000 THEN "Prices are 4001-5000"
        WHEN price BETWEEN 5001 and 6000 THEN "Prices are 5001-6000"
		ELSE "Prices are 6000+"
		END AS "Price groupings"
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	2
ORDER BY
	2 ASC;
    
#-------------------------------------------------------------------------------------
#3.1-Prices of "tech" products by price groups-more details for items priced below 500
#-------------------------------------------------------------------------------------
SELECT
    COUNT(order_item_id),
    CASE
		WHEN price < 50 THEN "Prices are 0-50"
        WHEN price BETWEEN 50 and 100 THEN "Prices are 050-100"
        WHEN price BETWEEN 101 and 150 THEN "Prices are 101-150"
        WHEN price BETWEEN 151 and 200 THEN "Prices are 151-200"
		WHEN price BETWEEN 201 and 250 THEN "Prices are 201-250"
        WHEN price BETWEEN 251 and 300 THEN "Prices are 251-300"
        WHEN price BETWEEN 301 and 350 THEN "Prices are 301-350"
        WHEN price BETWEEN 351 and 400 THEN "Prices are 351-400"
        WHEN price BETWEEN 401 and 450 THEN "Prices are 401-450"
        WHEN price BETWEEN 451 and 500 THEN "Prices are 451-500"
		ELSE "Prices are 500+"
		END AS "Price groupings"
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
	'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	2
ORDER BY
	2 ASC;
    

  
#-------------------------------------------------------------------------------------
#3.1-Prices of "tech" products by price groups-more details for items priced below 150
#-------------------------------------------------------------------------------------
SELECT
    COUNT(order_item_id),
    CASE
		WHEN price < 150 THEN "Prices are 0-150"
		ELSE "Prices are 150+"
		END AS "Price groupings"
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	2
ORDER BY
	2 ASC;
    
#-------------------------------------------------------------------------------------
#Prices of all products by price groups for comparison purposes-more details for items priced below 150
#-------------------------------------------------------------------------------------
SELECT
    COUNT(order_item_id),
    CASE
		WHEN price < 150 THEN "Prices are 0-150"
		ELSE "Prices are 150+"
		END AS "Price groupings"
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
GROUP BY
	2
ORDER BY
	2 ASC;
    
#-------------------------------------------------------------------------------------
#3.1-To answer question "Are expensive tech products popular?"
#Percentages of products with prices above 150 and below for all products
#-------------------------------------------------------------------------------------
SELECT	
	(22764/89886)*100; #answer: above 150 Euros= 25.33%
SELECT	
	(22764/89886)*100-100; #answer: below 150 Euros= 74.67%

#-------------------------------------------------------------------------------------
#Whar are the price range per category? 
SELECT
    COUNT(order_item_id),
    product_category_name_english,
    CASE
		WHEN price < 50 THEN "Prices are 0-50"
        WHEN price BETWEEN 50 and 100 THEN "Prices are 050-100"
        WHEN price BETWEEN 101 and 150 THEN "Prices are 101-150"
        WHEN price BETWEEN 151 and 200 THEN "Prices are 151-200"
		WHEN price BETWEEN 201 and 250 THEN "Prices are 201-250"
        WHEN price BETWEEN 251 and 300 THEN "Prices are 251-300"
        WHEN price BETWEEN 301 and 350 THEN "Prices are 301-350"
        WHEN price BETWEEN 351 and 400 THEN "Prices are 351-400"
        WHEN price BETWEEN 401 and 450 THEN "Prices are 401-450"
        WHEN price BETWEEN 451 and 500 THEN "Prices are 451-500"
		ELSE "Prices are 500+"
		END AS "Price groupings"
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
GROUP BY
	3,2
ORDER BY
	3,1 DESC;

 
#-------------------------------------------------------------------------------------
SELECT
	order_item_id,
    product_category_name_english,
    price
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
ORDER BY
	price DESC, order_item_id DESC, product_category_name_english;


#-------------------------------------------------------------------------------------
#3.2-How many months of data are included in the magist database? 
#-------------------------------------------------------------------------------------
    
SELECT DISTINCT #manual count=25 months--here needed to count rows manually; 
		YEAR(order_purchase_timestamp) as year,
		MONTH(order_purchase_timestamp) as month
FROM
	orders
ORDER BY
	year, month;
    
#The following input counts the rows for me:----------------------------
SELECT 
    TIMESTAMPDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp))
FROM
    orders;

#-------------------------------------------------------------------------------------
#3.2-How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?
#-------------------------------------------------------------------------------------
SELECT #3,095 sellers in total
	COUNT(DISTINCT(seller_id))
FROM
	magist.order_items; #can also use "order_items" alone but gave problem in order codes below;
    
#--------------------------
SELECT #3,095 sellers in total
	COUNT(DISTINCT(seller_id))
FROM
	order_items;
    
#--------------------------
SELECT #810 "Tech" sellers. 
	COUNT(DISTINCT(sellers.seller_id))
FROM
	sellers
LEFT JOIN
	order_items
ON
	sellers.seller_id=order_items.seller_id
LEFT JOIN
	products
ON
    order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
  
#--------------------------
SELECT 
	(810/3095)*100; #===>"Tech" sellers represent 26.17% of all sellers

#-------------------------------------------------------------------------------------
#3.2-What is the total amount earned by all sellers? What is the total amount earned by all "tech" sellers?
#-------------------------------------------------------------------------------------
SELECT  #Taking total of all prices as "earned" amount=13,591,643.70 EUROS over the 25 months
	SUM(price)
FROM
	order_items;
    
#---------------------
    
SELECT  #Taking total of all prices as "earned" amount=6,523,988.98 EUROS per/year
	(SUM(price)/25)*12 
FROM
	order_items;


#--------------------------
SELECT #Taking total of all ORDERS for "tech" categories as "earned"=2,476,601.95 EUROS
	SUM(price) #calculation for 1 year=1,188,768.93 EUROS
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
    
#--------------------------
SELECT
(2476601.95/13591643.70)*100; /*Sell of "tech" items represents 18.22% of all earnings 
(NOTE:"tech" items represent 19% of all sales)*/

#-------------------------------------------------------------------------------------
#3.2-Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?
#-------------------------------------------------------------------------------------
#All sellers=3,095
#Number of months in database=25
#Income of all sellers=13,591,643.70 Euros
#Total income/all sellers/number of months=175.66 Euros
SELECT
	(13591643.70/3095)/25; #175.66 Euros per month as avg for all sellers
    
#--------------------------
#"Tech" sellers=810
#Number of months in database=25
#Income of all "tech" sellers=2,476,601.95 Euros
#Income of all "tech" sellers/Total of "tech" sellers/number of months=122.30 Euros
SELECT
	(2476601.95/810)/25; #122.30 Euros per month as avg for "tech" sellers


#-------------------------------------------------------------------------------------
#3.3-What’s the average time between the order being placed and the product being delivered?
#-------------------------------------------------------------------------------------
SELECT #average time between order and delivery=12 days
	AVG(TIMESTAMPDIFF(DAY, order_purchase_timestamp,
    order_delivered_customer_date))
FROM
	orders;

#-------------------------------------------------------------------------------------
#3.3-How many orders are delivered on time vs orders delivered with a delay?
#-------------------------------------------------------------------------------------
SELECT
	COUNT(TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)) AS "Days difference",		
    CASE
		WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  < 0 THEN "Early"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  = 0 THEN "On time"
		WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  BETWEEN 1 AND 3 THEN "Slight delay"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  BETWEEN 4 AND 5 THEN "Delayed"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  > 5 THEN "Very delayed"
        ELSE "No information/No delivery"
		END AS "Delivery status"
FROM
	orders
WHERE TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) IS NOT NULL
GROUP BY
	2
ORDER BY
	1 DESC;
    
#-------------------------------------------------------------------------------------
SELECT
	COUNT(TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)) AS "Days difference",		
    CASE
		WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  < 0 THEN "Early"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  = 0 THEN "On time"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  > 0 THEN "Delayed"
        ELSE "No information/No delivery"
		END AS "Delivery status"
FROM
	orders
WHERE TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) IS NOT NULL
GROUP BY
	2
ORDER BY
	1 DESC;
#----------------------------
SELECT
	COUNT(DISTINCT(order_id))
FROM
	orders;
    
#----------------------------    
SELECT
	((2754+87187)/99441)*100; #for all deliveries, order early or on-time=90.45%
    
#------------------------------
SELECT
	(6535/(87187+2754))*100; #orders delayed from all= 7.26%    
    
#-------------------------------------------------------------------------------------
SELECT
	COUNT(TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)) AS "Days difference",		
    CASE
		WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  < 0 THEN "Early"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  = 0 THEN "On time"
        WHEN TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date)  > 0 THEN "Delayed"
        ELSE "No information/No delivery"
		END AS "Delivery status"
FROM
	orders
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	2
ORDER BY
	1 DESC;
    
#-----------------------    
SELECT
	((19124+634)/99441)*100; #for "tech" deliveries, order early or on-time=90.45%
    
#------------------------------
SELECT
	(1456/(19124+634))*100; #orders delayed from all= 7.37% 

#----------EXERCISE TO TEST ORDER OF TIMESTAMPS------------------------------
    
SELECT
	TIMESTAMPDIFF(DAY, '2020-12-30', '2020-12-30'),
	TIMESTAMPDIFF(DAY, '2020-12-31', '2020-12-30'),
	TIMESTAMPDIFF(DAY, '2020-12-30', '2020-12-31');
#---------------------------------------------

#-------------------------------------------------------------------------------------
#3.3-Is there any pattern for delayed orders, e.g. big products being delayed more often?
#-------------------------------------------------------------------------------------
SELECT
	TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) AS "Days",
    product_category_name_english AS "Categories",
    freight_value AS "Shipping costs",
    product_weight_g AS "Weight"
FROM
	orders
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	products.product_category_name=product_category_name_translation.product_category_name
WHERE 
	TIMESTAMPDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) IS NOT NULL AND
	product_category_name_english IS NOT NULL AND freight_value IS NOT NULL AND product_weight_g IS NOT NULL 
ORDER BY
	3 DESC;
    
#-------------------------------------------------------------------------------------
#What is the customer satisfaction rating? Overall=4 (out of 5)

#-------------------------------------------------------------------------------------
SELECT COUNT(DISTINCT(order_id)) #total distinct orders (order_id)=98,666
FROM
	order_items;
    
#-----------------------
SELECT COUNT(DISTINCT(review_id)) #total distinct reviews (review_id)=98,371
FROM
	order_reviews;
    
#-----------------------    
SELECT (98371/98666)*100; #99.7 % of all distinct orders provided a review

#-----------------------

SELECT
    COUNT(DISTINCT(orders.order_id)) #total distinct "tech" orders=19,456
FROM
	orders
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');

#-----------------------

SELECT #total distinct "tech" reviews=19,310
	COUNT(DISTINCT(review_id))
FROM
	order_reviews
LEFT JOIN
	orders
ON
	order_reviews.order_id=orders.order_id
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');

#----------------------
SELECT (19310/19456)*100; #99.25% of all "tech" orders have a review

SELECT (10713/19310)*100; #55.5% of all "tech" orders received a "5" review rating (see below)
SELECT (3980/19310)*100; #20.6% of all "tech" orders received a "4" review rating (see below)

#----------------------
SELECT #more than half of the reviews for "tech" products received a 5; 75% received a rating of 4-5;
	COUNT(DISTINCT(review_id)),
    review_score,
    product_category_name_english,
    ROUND(AVG(price))
FROM
	order_reviews
LEFT JOIN
	orders
ON
	order_reviews.order_id=orders.order_id
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	review_score, product_category_name_english
ORDER BY
	review_score DESC;
  
#----------------------
SELECT #more than half of the reviews for "tech" products received a 5; 75% received a rating of 4-5;
	COUNT(DISTINCT(review_id)),
    review_score
FROM
	order_reviews
LEFT JOIN
	orders
ON
	order_reviews.order_id=orders.order_id
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony')
GROUP BY
	review_score
ORDER BY
	review_score DESC;  
    
    
#----------------------
SELECT
	((665+2307)/(10713+3980+1645))*100;  #18.19% of customers who left a review (for shipment) were unsatisfied (rated 1 or 2).
#----------------------    
SELECT #average review score of all reviews for "tech" orders received=3.98 (round up to 4)
	COUNT(DISTINCT(review_id)),
    AVG(review_score)
FROM
	order_reviews
LEFT JOIN
	orders
ON
	order_reviews.order_id=orders.order_id
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
    
#----------------------    
SELECT #average review score for 'telephony' orders received=3.94 (round up to 4)
	COUNT(DISTINCT(review_id)),
    AVG(review_score)
FROM
	order_reviews
LEFT JOIN
	orders
ON
	order_reviews.order_id=orders.order_id
LEFT JOIN
	order_items
ON
	orders.order_id=order_items.order_id
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
	product_category_name_translation.product_category_name=products.product_category_name
WHERE
	product_category_name_english IN (
    'telephony');

/*AVG number of items in an individual "distinct" order=1.14 (for "tech" categories=1.12)
total of items in orders is 112,650 divided by 98,666 of distinct orders is 1.14
versus for "tech" categories=21,710 divided by 19,456=1.12 items*/
SELECT 
    COUNT(DISTINCT(order_id)) #98,666
FROM
	order_items;
#-----------------    
SELECT 
    COUNT(order_item_id) #112,650
FROM
	order_items;
#------------------
SELECT
	112650/98666; #1.14
SELECT 
	21710/19456; #1.12 for "tech" categories only
    
SELECT 
    COUNT(DISTINCT(order_id))#19,456
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');    
#------------------    
SELECT 
    COUNT(order_item_id) #21,710   
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
    
#non-manual calculation of average for the above, "tech" only----
SELECT 
    ((COUNT(order_item_id))/COUNT(DISTINCT(order_id))) #1.12  
FROM
	order_items
LEFT JOIN
	products
ON
	order_items.product_id=products.product_id
LEFT JOIN
	product_category_name_translation
ON
    products.product_category_name=product_category_name_translation.product_category_name
WHERE
	product_category_name_english IN (
    'audio',
    'auto',
    'books_technical',
    'cine_photo',
    'computers',
    'computers_accessories',
    'consoles_games',
    'electronics',
    'pc_gamer',
    'security_and_services',
    'signaling_and_security',
    'tablets_printing_image',
    'telephony');
    
    
    #Looking at sales evolution/trend (all items)
    SELECT
		YEAR(order_purchase_timestamp),
		MONTH(order_purchase_timestamp),
        COUNT(DISTINCT(order_id))
	FROM
		orders
	GROUP BY
		YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp)
	ORDER BY
		YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp),
        COUNT(DISTINCT(order_id));

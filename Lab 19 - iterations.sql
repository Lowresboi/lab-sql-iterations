use sakila;

-- 1
SELECT
    store_id,
    SUM(amount) AS total_sales
FROM
    payment
GROUP BY
    store_id;

-- 2
DELIMITER //
CREATE PROCEDURE GetTotalSalesByStore()
BEGIN
    SELECT
        store_id,
        SUM(amount) AS total_sales
    FROM
        payment
    GROUP BY
        store_id;
END //
DELIMITER ;

-- 3
DELIMITER //
CREATE PROCEDURE GetTotalSalesByStoreID(IN storeID INT)
BEGIN
    SELECT
        store_id,
        SUM(amount) AS total_sales
    FROM
        payment
    WHERE
        store_id = storeID
    GROUP BY
        store_id;
END //
DELIMITER ;

-- 4
DELIMITER //
CREATE PROCEDURE GetTotalSalesAndFlag(IN storeID INT, OUT total_sales_value FLOAT, OUT flag VARCHAR(20))
BEGIN
    SELECT
        SUM(amount) INTO total_sales_value
    FROM
        payment
    WHERE
        store_id = storeID;

    SET flag = CASE
        WHEN total_sales_value > 30000 THEN 'green_flag'
        ELSE 'red_flag'
    END;
END //
DELIMITER ;

-- 5 

-- Call the stored procedure
CALL GetTotalSalesAndFlag(1, total_sales, flag_value);

-- Print the results
SELECT total_sales, flag_value;

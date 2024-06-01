WITH books AS (
  SELECT
    customer,
    sum(purchases) AS total_books
  FROM sales
  WHERE product_type = 'Books'
  GROUP BY customer
),
 
music AS (
  SELECT
    customer,
    sum(purchases) AS total_music
  FROM sales
  WHERE product_type = 'Music'
  GROUP BY customer
),
 
videos as (
  SELECT
    customer,
    sum(purchases) AS total_videos
  FROM sales
  WHERE product_type = 'Videos'
  GROUP BY customer
)
 
SELECT
  customer,
  sum(purchases) AS Total,
  total_books AS Books,
  total_music AS Music,
  total_videos AS Videos
FROM sales
JOIN books ON books.customer = sales.customer
JOIN music ON music.customer = sales.customer
JOIN videos ON videos.customer = sales.customer
GROUP BY customer
ORDER BY customer;

-- this is much easier to read than
SELECT
    customer,
    sum(purchases) AS Total,
    total_books AS Books,
    total_music AS Music,
    total_videos AS Videos
FROM sales
JOIN
    (SELECT account_no, sum(purchases) AS total_books FROM sales
    WHERE product_type = 'Books'
    GROUP BY account_no) books
ON books.account_no = sales.account_no
JOIN
    (SELECT account_no, sum(purchases) AS total_music FROM sales
    WHERE product_type = 'Music'
    GROUP BY account_no) music
ON music.account_no = sales.account_no
JOIN
    (SELECT account_no, sum(purchases) AS total_videos FROM sales
    WHERE product_type = 'Videos'
    GROUP BY account_no) videos
ON videos.account_no = sales.account_no
GROUP BY customer
ORDER BY customer
USE sampledb;tbl_customer

# 1. 2020년 7월의 총 Revenue를 구하라.
SELECT SUM(price)
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01';

/* 2. 2020년 7월의 MAU를 구하라.
- MAU(monthly activity user): 월별 활동 이용자
- COUNT(*): 모든 rows카운팅
- COUNT(customer_id): customer_id의 null값 제외 카운팅
- COUNT(distinct customer_id): unique customer_id 카운팅 */
SELECT COUNT(distinct customer_id)
FROM tbl_visit
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01';

/* 3. 2020년 7월에 우리 Active 유저의 구매율(Paying Rate)은 어떻게 되나?
- 구매율: 구매유저수 / 전체활성유저 */
SELECT COUNT(distinct customer_id)
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01';     # 11174

SELECT COUNT(distinct customer_id)
FROM tbl_visit
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01';     # 16414

SELECT ROUND(11174 / 16414 * 100, 2);     # 백분율로 바꾸고, 소수점 둘째자리까지만 표시

/* 4. 2020년 7월에 구매 유저의 월평균구매액(ARPPU: average revenue per paying user)은 어떻게 되나?
- ARPPU: 유료 사용자 1인당 평균 결제 금액 = 매출 / 중복을 제외한 순수 유료 사용자 수 */
SELECT AVG(revenue)
FROM (SELECT customer_id, SUM(price) AS revenue
      FROM tbl_purchase
      WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
      GROUP BY customer_id) AS sub;     # GROUP BY 1로 써도 됨. FROM절의 AS 뒤에 이름은 아무거로나 해도 됨.

# 5. 2020년 7월에 가장 많이 구매한 top3 고객과 top11~15 고객을 뽑아라.
SELECT customer_id, SUM(price) AS revenue
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
GROUP BY customer_id     # GROUP BY 1과 동일 
ORDER BY revenue DESC     # ORDER BY 2와 동일
LIMIT 3;     # TOP3고객 

SELECT customer_id, SUM(price) AS revenue
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 5 OFFSET 10;     # 상위 10개를 제외하고 5개를 가져와라. 즉, 상위 11~15위

/* 6. 2020년 7월의 평균 DAU(daily active user)를 구하라. active user 수가 증가하는 추세인가?
- DAU: 하루동안 접속한 유저수 */

## 7월 일별 접속 유저수 
SELECT DATE_FORMAT(visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,      # 포맷하는 과정에서 9시간이 더해지므로 9시간을 다시 빼줘야 함
       COUNT(DISTINCT customer_id)
FROM tbl_visit
WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01'
GROUP BY date_at
ORDER BY date_at ASC;

## 문제 정답(7월 평균 일별 접속 유저수)
SELECT ROUND(AVG(cnt), 0)
FROM (SELECT COUNT(DISTINCT customer_id) AS cnt
	  FROM tbl_visit
      WHERE visited_at >= '2020-07-01' AND visited_at < '2020-08-01'
      GROUP BY DATE_FORMAT(visited_at - INTERVAL 9 HOUR, '%Y-%m-%d')) AS sub;

/* 7. 2020년 7월의 평균 WAU(weekly active user)를 구하라.
- WAU: 일주일동안 접속한 유저수 */
SELECT ROUND(AVG(cnt), 0)
FROM (SELECT DATE_FORMAT(visited_at - INTERVAL 9 HOUR, '%Y-%m-%U') AS date_at,     # %U: week주(시작: 일요일)
             COUNT(DISTINCT customer_id) AS cnt
      FROM tbl_visit
      WHERE visited_at >= '2020-07-05' AND visited_at < '2020-07-26'     # 온전히 7일이 전부 있는 주만 알아보기 위해 이렇게 기간 설정
      GROUP BY date_at) AS sub;
      
# 8. 2020년 7월의 daily revenue는 중가하는 주세인가? 평균 daily revenue도 구하라.

## 7월 일별 revenue
SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at, 
       SUM(price)
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
GROUP BY date_at;

## 8번 정답(즉, 7월 평균 일별 revenue)
SELECT ROUND(AVG(revenue), 0)
FROM (SELECT SUM(price) AS revenue
      FROM tbl_purchase
      WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
      GROUP BY DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d')) AS sub;

# 9. 2020년 7월의 평균 weekly revenue를 구하라.
SELECT ROUND(AVG(revenue), 0)
FROM (SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%U') AS date_at,
             SUM(price) AS revenue
      FROM tbl_purchase
      WHERE purchased_at >= '2020-07-05' AND purchased_at < '2020-07-26'
      GROUP BY date_at) AS sub;

# 10. 2020년 7월 요일별 daily revenue를 구하라. 어느 요일이 revenue가 가장 높고 어느 요일이 가장 낮은가?
SELECT DATE_FORMAT(date_at, '%w') AS day_of_week,     # %w: 0부터 일요일 
       DATE_FORMAT(date_at, '%W') AS day_name,     # %W: sunday, monday, ... 
       AVG(revenue) AS daily_revenue
FROM (SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
             SUM(price) AS revenue
	  FROM tbl_purchase
      WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
      GROUP BY date_at) AS sub
GROUP BY day_of_week, day_name
ORDER BY day_of_week;

# 11. 2020년 7월 시간대별 시간당 revenue를 구하라. 어느 시간대가 revenue가 가장 높고 어느 시간대가 가장 낮은가?
SELECT hour_at, AVG(revenue)
FROM (SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
             DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at,     # %H: 24시간 형태
             SUM(price) AS revenue
	  FROM tbl_purchase
      WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
      GROUP BY date_at, hour_at) AS sub
GROUP BY hour_at
ORDER BY AVG(revenue) DESC;

# 12. 2020년 7월 요일 및 시간대별 revenue를 구하라.
SELECT day_of_week_at, hour_at, AVG(revenue)
FROM (SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
             DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%W') AS day_of_week_at,
             DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at,
             SUM(price) AS revenue
	  FROM tbl_purchase
      WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
      GROUP BY date_at, day_of_week_at, hour_at) AS sub
GROUP BY day_of_week_at, hour_at
ORDER BY AVG(revenue) DESC;

/* 13. 전체 유저의 demographic(인구통계)을 알고 싶다. 성, 연령별로 유저 숫자를 구하라. 어느 세그먼트가 가장 숫자가 많은가?
참고로 기타 성별은 하나로, 연령은 5세 단위로 적당히 묶고 유저 수가 높은 순서대로 구하라. */
SELECT CASE WHEN LENGTH(gender) < 1 THEN 'Others'
            ELSE gender
            END AS gender,
	   CASE WHEN age <= 15 THEN '15세 이하'
            WHEN age <= 20 THEN '16-20세'
            WHEN age <= 25 THEN '21-25세'
            WHEN age <= 30 THEN '26-30세'
            WHEN age <= 35 THEN '31-35세'
            WHEN age <= 40 THEN '36-40세'
            WHEN age <= 45 THEN '41-45세'
            WHEN age >= 46 THEN '46세 이상'
            END AS age,
	   COUNT(*) AS cnt
FROM tbl_customer
GROUP BY 1, 2     # case문에서 이름을 tbl_customer표의 컬럼명과 동일하게 했으므로 group by gender, age로 하면 다른 값이 나옴.
ORDER BY cnt DESC;

/* 14. 13번 결과의 성, 연령을 '남성(25-29세)'와 같이 통합하고, 각 성, 연령이 전체 고객에서 얼마나 차지하는지 분포(%)를 구하라.
분포가 높은 순서대로 구하라. */
SELECT CONCAT(CASE WHEN gender = 'M' THEN '남성'
              WHEN gender = 'F' THEN '여성'
              WHEN gender = 'Others' THEN '기타'
			  WHEN LENGTH(gender) < 1 THEN '기타'
              END
			, '('
            , CASE WHEN age IS NULL THEN '무응답'
				   WHEN age <= 15 THEN '15세 이하'
                   WHEN age <= 20 THEN '15-20세'
                   WHEN age <= 25 THEN '21-25세'
                   WHEN age <= 30 THEN '26-30세'
                   WHEN age <= 35 THEN '31-35세'
                   WHEN age <= 40 THEN '36-40세'
                   WHEN age <= 45 THEN '41-45세'
                   WHEN age >= 46 THEN '46세 이상'
                   END
			 , ')') AS gen_age
             , COUNT(*) AS cnt
             , ROUND(COUNT(*) / (SELECT COUNT(*) FROM tbl_customer) * 100, 2) AS per
FROM tbl_customer
GROUP BY 1
ORDER BY 2 DESC;

# 15. 2020년 7월 성별에 따라 구매 건수와 총 revenue를 구하라. 이전처럼 남녀 이외의 성별은 하나로 묶어라.
SELECT CASE WHEN LENGTH(B.gender) < 1 THEN 'Others'
            ELSE B.gender
            END AS gender
		, COUNT(*) AS cnt
        , SUM(price) AS revenue
FROM tbl_purchase A 
LEFT JOIN tbl_customer B
ON A.customer_id = B.customer_id
WHERE A.purchased_at >= '2020-07-01' AND A.purchased_at < '2020-08-01'
GROUP BY 1;

# 16. 2020년 7월 성별, 연령대에 따라 구매건수와 총 revenue를 구하라.
SELECT CASE WHEN LENGTH(B.gender) < 1 THEN 'Others'
            ELSE B.gender
            END AS gender
	 , CASE WHEN B.age IS NULL THEN '무응답'
			WHEN B.age <= 15 THEN '0_15세 이하'
            WHEN B.age <= 20 THEN '1_15-20세'
            WHEN B.age <= 25 THEN '2_21-25세'
            WHEN B.age <= 30 THEN '3_26-30세'
            WHEN B.age <= 35 THEN '4_31-35세'
            WHEN B.age <= 40 THEN '5_36-40세'
            WHEN B.age <= 45 THEN '6_41-45세'
            WHEN B.age >= 46 THEN '7_46세 이상'
            END age
	  , COUNT(*) AS cnt
      , SUM(price) AS revenue
FROM tbl_purchase A
LEFT JOIN tbl_customer B
ON A.customer_id = B.customer_id
WHERE A.purchased_at >= '2020-07-01' AND A.purchased_at < '2020-08-01'
GROUP BY 1, 2
ORDER BY 4 DESC;

/* 17. 2020년 7월 일별 매출의 전일 대비 증감폭, 증감률을 구하라.
- WITH문: 서브쿼리를 사용해서 임시테이블처럼 사용할 수 있는 구문. 옵티마이저가 인라인 뷰나 임시테이블로 판단.
- LAG: 이전 행을 가져옴
- LEAD: 특정 위치의 행을 가져옴(디폴트는 1이라 다음 행을 가져옴)*/
WITH tbl_revenue AS (                          # tbl_revenue라는 임시 테이블 생성
					 SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date, SUM(price) AS revenue
					 FROM tbl_purchase
					 WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
					 GROUP BY 1
					 ORDER BY 1)

SELECT *, revenue - LAG(revenue) OVER(ORDER BY d_date ASC) AS diff_revenue,
          ROUND((revenue - LAG(revenue) OVER(ORDER BY d_date ASC)) / LAG(revenue) OVER(ORDER BY d_date ASC) * 100, 2) AS chg_revenue
FROM tbl_revenue;

/* 18. 일별로 많이 구매한 고객들한테 소정의 선물을 주려고 한다. 7월에 일별로 구매 금액 기준으로 가장 많이 지출한 고객 top3를 뽑아라.
- RANK: 동일한 값이면 같은 순위를 매기고, 다음 값에서는 다음 순위를 매김
- DENSE_RANK: 동일한 값이면 같은 순위를 매기고, 동일한 순위를 하나의 RANK로 계산
- ROW_NUMBER: 중복 허용 없음. 동일한 순위에 대해서 고유의 순위 부여 */
SELECT *
FROM (SELECT DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date
			, customer_id
            , SUM(price) AS revenue
            , DENSE_RANK() OVER (PARTITION BY DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') ORDER BY SUM(price) DESC) AS rank_rev
FROM tbl_purchase
WHERE purchased_at >= '2020-07-01' AND purchased_at < '2020-08-01'
GROUP BY 1, 2) foo
WHERE rank_rev < 4;

/* 19. 2020년 7월에 우리 신규유저가 하루 안에 결제로 넘어가는 비율(paying conversion within 1 day)이 어떻게 되는가? 
해당 비율을 구하고, 결제까지 보통 몇 분 정도가 소요되는지 구하라. */
WITH rt_tbl AS (
                SELECT A.*
					 , B.customer_id AS paying_user
                     , B.purchased_at
                     , TIME_TO_SEC(TIMEDIFF(B.purchased_at, A.created_at)) / 3600 AS diff_hours
				FROM tbl_customer A 
                LEFT JOIN (SELECT customer_id, MIN(purchased_at) AS purchased_at
                           FROM tbl_purchase
                           GROUP BY customer_id) B
				ON A.customer_id = B.customer_id
                AND B.purchased_at < A.created_at + INTERVAL 1 DAY 
                WHERE A.created_at >= '2020-07-01' AND A.created_at < '2020-08-01')

SELECT ROUND(COUNT(paying_user) / COUNT(customer_id) * 100, 2)
FROM rt_tbl
UNION ALL
SELECT ROUND(AVG(diff_hours), 2)
FROM rt_tbl;


/* 20. 우리 서비스는 유저의 재방문율이 높은 서비스인가? 이를 파악하기 위해 7월 기준 day1 retention이 어떤지 구하고, 추세를 보기 위해 daily로 추출하라.
- n-day retention: 시간이 지날수록 얼마나 많은 유저가 제품이나 서비스로 다시 돌아오는지 */
SELECT DATE_FORMAT(A.visited_at, '%Y-%m-%d') AS d_date
     , COUNT(DISTINCT A.customer_id) AS active_users
     , COUNT(DISTINCT B.customer_id) AS retained_users
     , COUNT(DISTINCT B.customer_id) / COUNT(DISTINCT A.customer_id) AS retention
FROM tbl_visit A
LEFT JOIN tbl_visit B
ON A.customer_id = B.customer_id
AND DATE_FORMAT(A.visited_at, '%Y-%m-%d') = DATE_FORMAT(B.visited_at - INTERVAL 1 DAY, '%Y-%m-%d')
WHERE DATE_FORMAT(A.visited_at, '%Y-%m-%d') < '2020-08-01'
GROUP BY 1;

# 21. 우리 서비스는 신규유저가 많은가? 기존 유저가 많은가? 유저들이 가입한 기간별로 그룹지어 고객 분포가 어떤지 DAU 기준으로 보여라.
WITH tbl_visit_by_joined AS (SELECT DATE_FORMAT(A.visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date
                                  , A.customer_id
                                  , B.created_at AS d_joined
                                  , MAX(A.visited_at) AS last_visit
                                  , DATEDIFF(CAST(MAX(A.visited_at) AS date), CAST(B.created_at AS date)) AS date_diff
							 FROM tbl_visit A
                             LEFT JOIN tbl_customer B
                             ON A.customer_id = B.customer_id
                             WHERE A.visited_at >= '2020-07-01' AND A.visited_at < '2020-08-01'
                             GROUP BY 1, 2, 3)

SELECT A.d_date
     , CASE WHEN A.date_diff >= 730 THEN '2년 이상'
            WHEN A.date_diff >= 365 THEN '1년 이상'
            WHEN A.date_diff >= 183 THEN '6개월 이상'
            WHEN A.date_diff >= 91 THEN '3개월 이상'
            WHEN A.date_diff >= 30 THEN '1개월 이상'
            ELSE '1개월 미만'
            END AS segment
	 , B.all_users
     , COUNT(A.customer_id) AS users
     , ROUND(COUNT(A.customer_id) / B.all_users, 2) AS per
FROM tbl_visit_by_joined A 
LEFT JOIN (SELECT d_date, COUNT(customer_id) AS all_users
           FROM tbl_visit_by_joined
           GROUP BY 1) B
ON A.d_date = B.d_date
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;
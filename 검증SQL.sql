-- 1. 대여별, 구매별 각각 가격이 비싼 영화부터 저렴한 영화순서대로 가져오시오.
SELECT 
    v_rental AS rental_type,
    m_title,
    m_release_year,
    m_score
FROM 
    tblVersion
JOIN 
    tblMovie ON tblVersion.m_seq = tblMovie.m_seq
ORDER BY 
    v_rental DESC, m_score DESC;


-- 2. '라미란' 배우가 출연한 영화를 가져오시오.
SELECT 
    m.m_title
FROM 
    tblMovie m
JOIN 
    tblMovieActor ma ON m.m_seq = ma.m_seq
JOIN 
    tblActor a ON ma.a_seq = a.a_seq
WHERE 
    a.a_name = '라미란';


-- 3. '김성훈' 감독이 제작한 영화를 가져오시오.
SELECT 
    m.m_title
FROM 
    tblMovie m
JOIN 
    tblMovieDirector md ON m.m_seq = md.m_seq
JOIN 
    tblDirector d ON md.d_seq = d.d_seq
WHERE 
    d.d_name = '김성훈';


-- 4. 더빙이 있는 영화를 가져오시오.
SELECT 
    m.m_title
FROM 
    tblMovie m
JOIN 
    tblVersion v ON m.m_seq = v.m_seq
WHERE 
    v.v_dub != '-';


-- 5. 별점 8.0 이상 받은 영화를 가져오시오.
SELECT 
    m.m_title, m.m_score
FROM 
    tblMovie m
WHERE 
    m.m_score >= 8.0;


-- 6. 감상평이 없는 영화를 가져오시오.
SELECT 
    m.m_title
FROM 
    tblMovie m
LEFT JOIN 
    tblComment c ON m.m_seq = c.m_seq
WHERE 
    c.c_seq IS NULL;


-- 7. 등록된 50개의 영화중 가장 많은 영화에 참여한 배우를 가져오시오.
SELECT 
    a.a_name, COUNT(ma.m_seq) AS movie_count
FROM 
    tblActor a
JOIN 
    tblMovieActor ma ON a.a_seq = ma.a_seq
GROUP BY 
    a.a_name
ORDER BY 
    movie_count DESC
FETCH FIRST 1 ROW ONLY;


-- 8. 좋아요(하트) 50개 이상이면서 15세 관람가 이상인 영화들을 가져오시오.   
SELECT 
    m.m_title, m.m_rating, c.c_like
FROM 
    tblMovie m
JOIN 
    tblComment c ON m.m_seq = c.m_seq
WHERE 
    c.c_like >= 50 AND m.m_rating LIKE '15%';


-- 9. 러닝타임이 120분 미만인 영화를 가져오시오.
SELECT 
    m.m_title, m.m_running_time
FROM 
    tblMovie m
WHERE 
    TO_NUMBER(REGEXP_SUBSTR(m.m_running_time, '\\d+')) < 120;


-- 10. 감상평 중 싫어요를 가장 많이 받은(누적) 영화를 가져오시오.SELECT 
    m.m_title, c.c_dislike
FROM 
    tblMovie m
JOIN 
    tblComment c ON m.m_seq = c.m_seq
ORDER BY 
    c.c_dislike DESC
FETCH FIRST 1 ROW ONLY;


-- 11. 대여와 구매를 모두 가능한 영화를 가져오시오.
SELECT 
    m.m_title
FROM 
    tblMovie m
JOIN 
    tblVersion v ON m.m_seq = v.m_seq
WHERE 
    v.v_rental = '대여/구매';


-- 12. 랭킹 순위가 가장 많이 오른 영화와 랭킹 순위가 가장 많이 떨어진 영화를 가져오시오.
SELECT 
    m.m_title, r.r_rankchange
FROM 
    tblMovie m
JOIN 
    tblVersion v ON m.m_seq = v.m_seq
JOIN 
    tblRank r ON v.v_seq = r.v_seq
ORDER BY 
    r.r_rankchange DESC FETCH FIRST 1 ROW ONLY
UNION ALL
SELECT 
    m.m_title, r.r_rankchange
FROM 
    tblMovie m
JOIN 
    tblVersion v ON m.m_seq = v.m_seq
JOIN 
    tblRank r ON v.v_seq = r.v_seq
ORDER BY 
    r.r_rankchange ASC FETCH FIRST 1 ROW ONLY;

# MovieDataBase(영화정보 데이터베이스 설계)

## 프로젝트 개요
Naver 영화 순위 정보에서 데이터 수집 후, 데이터베이스를 구축하여 검증 쿼리를 이용해 올바른 관계를 지을수 있게한다.

<br>

## 주요기능
- 영화 한편에 담긴 정보들을 데이터화하여 각각의 테이블로 분류한다. 이후 JOIN을 통해 테이블간 연결을 올바르게하고 검증 쿼리문을 통해 최종 검증을 한다.

 ### 진행 기간
- 2024.08.02
  
<br>

## 개발환경 및 사용언어
- **언어**: SQL 
- **개발 환경**: Windows 11, JDK11, SQL Developer, Oracle Database 11c
- **설계도구**: ERDCloud, draw.io


<br>

## 담당 업무
- 감독 리스트 테이블 작성
- 배우 리스트 테이블 작성
- 영화-감독/배우-영화 관계 테이블 작성

  <br>
## 개념적 모델링
![개념모델링](https://github.com/im9613/MovieDataBase/blob/main/model/개념적%20모델링.png)

## ERDCloud 테이블 설계
![erd테이블](https://github.com/im9613/MovieDataBase/blob/main/model/NaverMovieERDCloud.png)

  <br>
  
## 기능
- 트러블슈팅
  - 영화목록과 출연배우 리스트를 불러왔다.
![영화-배우](https://github.com/im9613/MovieDataBase/blob/main/model/movieActor.png)
#### 수정
- 영화목록과 출연배우 목록이 전혀 일치하지 않는 상황발생.
- 설계내용은 ex) 1번 영화 - (1번 배우, 2번 배우, 3번 배우...) 제대로 설계하였음.
- JOIN방법의 문제라 생각하여 INNER JOIN에서 OUTER JOIN으로 바꿔 진행했으나 NULL값 출력
  #### 해결
  - JOIN을 관계테이블 기본키를 통해 수행하고 있었다..
  - 즉시 관계테이블의 외래키를 통해 JOIN.
   
   ![결과](https://github.com/im9613/MovieDataBase/blob/main/model/result.png)
  - 영화와 배우간 매칭이 성공적으로 이뤄졌으며, 김무열이 출연한 영화 2편도 올바르게 출력 됨.
    
<br>



  
## 느낀점
최초 데이터 설계 이후 영화목록-출연배우 리스트를 조회했을 때, 설계 목적과 다르게 출력되었기에 테이블 작성이 잘못된줄 알고 테이블을 재작성했습니다. 단순히 테이블의 기본키를 통해서만 JOIN을 하면 된다고 잘못 이해하고 있었기에 발생한 일이었습니다.
JOIN과 테이블간 참조에 대해 더 정확하게 짚고 넘어갈 수 있게되어 좋은 경험이었다고 생각했으며, 데이터 정규화의 중요성을 인지하게 되었습니다.

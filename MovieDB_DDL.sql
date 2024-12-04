-- 영화테이블(기본)

drop table tblMovie;
select * from tblMovie;

create table tblMovie (
  m_seq number primary key,
  m_title varchar2(1000) not null,
  m_title_en varchar2(1000) null,
  m_release_year number null,
  m_running_time varchar2(10) not null,
  m_score number not null,
  m_size varchar2(10) not null,
  m_rating varchar2(50) not null,
  m_plot varchar2(3000) not null
 );
---------------------------------------------------------------------------------------------------------
--배우 리스트
drop table tblActor;
create table tblActor(
    a_seq number primary key,
    a_name varchar2(50)
);      --배우

---------------------------------------------------------------------------------------------------------
--감독 리스트
drop table tblDirector;
create table tblDirector(
    d_seq number primary key,
    d_name varchar2(50)
);

drop sequence a_seq;
drop sequence d_seq;
create sequence a_seq;
create sequence d_seq;
---------------------------------------------------------------------------------------------------------
--영화버전

drop table tblVersion;
create table tblVersion(
    v_seq number primary key not null,               --seq순서(PK)
    m_seq references tblMovie(m_seq) not null,       --movie_seq
    v_dub varchar2(50) default '-',           --더빙/자막
    v_rental varchar2(50) not null                   --대여/구매
);
---------------------------------------------------------------------------------------------------------
--영화순위

drop table tblRank;
create table tblRank(
    v_seq references tblVersion(v_seq) primary key not null, 
    r_rank number not null,                  
    r_hot varchar2(30) default '-',
    r_rankchange number default 0
);

drop sequence m_seqMovie;
drop sequence v_seqVersion;
create sequence m_seqMovie;
create sequence v_seqVersion;


---------------------------------------------------------------------------------------------------------
--관계 테이블 (영화/감독)

drop sequence md_seq;
create sequence md_seq;

drop table tblMovieDirector;
create table tblMovieDirector(
    md_seq number primary key,
    d_seq references tblDirector(d_seq),
    m_seq references tblMovie(m_seq)
);

---------------------------------------------------------------------------------------------------------
--관계 테이블 (배우/감독)

drop sequence ma_seq;
create sequence ma_seq;

drop table tblMovieActor;
create table tblMovieActor(
    ma_seq number primary key,
    a_seq references tblActor(a_seq),
    m_seq references tblMovie(m_seq)
);




---------------------------------------------------------------------------------------------------------
--댓글 테이블
DROP TABLE tblComment;
CREATE TABLE  tblComment (
    c_seq NUMBER NOT NULL,
    m_seq NUMBER NOT NULL,
    u_id VARCHAR2(30)  NOT NULL,
    c_comment VARCHAR2(2000) NOT NULL,
    c_like NUMBER DEFAULT 0 NOT NULL,
    c_dislike NUMBER DEFAULT 0 NOT NULL,
    c_time DATE DEFAULT SYSDATE NOT NULL,
    
    CONSTRAINT tblComment_c_seq_pk PRIMARY KEY(c_seq),
    CONSTRAINT tblComment_m_seq_fk FOREIGN KEY(m_seq) REFERENCES tblMovie(m_seq),
    CONSTRAINT tblComment_u_id FOREIGN KEY(u_id) REFERENCES tblUser(u_id)
);

DROP SEQUENCE seqComment;
CREATE SEQUENCE seqComment;


---------------------------------------------------------------------------------------------------------
--유저 목록
DROP TABLE tblUser;
CREATE TABLE tblUser (
    u_seq NUMBER NOT NULL,
    u_id VARCHAR2(30) NOT NULL
    constraint tblUser_u_seq_u_id_pk primary key(u_seq, u_id)
);

DROP SEQUENCE seqUser;
CREATE SEQUENCE seqUser;

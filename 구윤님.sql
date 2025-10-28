--3rdProject 구윤 >> script.sql

-- 1. 사용자 상태 테이블
-------------------------------------------------
CREATE TABLE tblUserStatus (
    user_status_id      NUMBER          NOT NULL,
    status              VARCHAR2(20)    NOT NULL,
    CONSTRAINT PK_tblUserStatus PRIMARY KEY (user_status_id)
);

-------------------------------------------------
-- 2. 사용자 테이블
-------------------------------------------------
CREATE TABLE tblUser (
    user_id             NUMBER          NOT NULL,
    user_status_id      NUMBER          NOT NULL,
    real_name           VARCHAR2(50)    NOT NULL,
    ssn                 VARCHAR2(256)   NOT NULL,
    phone_number        VARCHAR2(20)    NOT NULL,
    username            VARCHAR2(50)    NULL,
    password            VARCHAR2(256)   NOT NULL,
    email               VARCHAR2(100)   NOT NULL,
    nickname            VARCHAR2(50)    NOT NULL,
    address             VARCHAR2(300)   NULL,
    regdate             DATE            NOT NULL,
    deleted_at          DATE            NULL,
    gender              CHAR(1)         NULL,
    height              NUMBER          NULL,
    weight              NUMBER          NULL,
    health_goals        VARCHAR2(300)   NULL,
    CONSTRAINT PK_tblUser PRIMARY KEY (user_id),
    CONSTRAINT FK_tblUserStatus_TO_tblUser FOREIGN KEY (user_status_id)
        REFERENCES tblUserStatus (user_status_id)
);

-------------------------------------------------
-- 3. 여행 루트 게시글 테이블
-------------------------------------------------
CREATE TABLE tblRoutePost (
    routepost_id             NUMBER PRIMARY KEY,             -- 게시글 PK
    user_id                  NUMBER NOT NULL,                -- 작성자 FK
    routepost_title          VARCHAR2(300) NOT NULL,         -- 제목
    routepost_content        CLOB NOT NULL,                  -- 내용
    routepost_satisfaction   NUMBER(2,1) DEFAULT 5.0,        -- 만족도 (0.0~5.0)
    routepost_view_count     NUMBER DEFAULT 0,               -- 조회수
    routepost_report_count   NUMBER DEFAULT 0,               -- 신고 수
    routepost_status         CHAR(1) DEFAULT 'A',            -- 상태 (A=활성, D=삭제)
    routepost_regdate        DATE DEFAULT SYSDATE,           -- 작성일
    routepost_update         DATE DEFAULT SYSDATE,           -- 수정일
    CONSTRAINT FK_tblUser_TO_tblRoutePost FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id)
        ON DELETE CASCADE
);

CREATE SEQUENCE seqRoutePost START WITH 1 INCREMENT BY 1;

-------------------------------------------------
-- 4. 여행 루트 게시글 이미지 테이블
-------------------------------------------------
CREATE TABLE tblRoutePostImage (
    routepost_image_id       NUMBER PRIMARY KEY,             -- 이미지 PK
    routepost_id             NUMBER NOT NULL,                -- 게시글 FK
    routepost_image_seq      NUMBER NOT NULL,                -- 순서
    routepost_image_url      VARCHAR2(300) NOT NULL,         -- 이미지 파일명
    CONSTRAINT FK_tblRoutePost_TO_tblRoutePostImage FOREIGN KEY (routepost_id)
        REFERENCES tblRoutePost (routepost_id)
        ON DELETE CASCADE
);

CREATE SEQUENCE seqRoutePostImage START WITH 1 INCREMENT BY 1;

-------------------------------------------------
-- 5. 좋아요 테이블
-------------------------------------------------
CREATE TABLE tblRoutePostLikes (
    user_id          NUMBER NOT NULL,
    routepost_id     NUMBER NOT NULL,
    CONSTRAINT PK_tblRoutePostLikes PRIMARY KEY (user_id, routepost_id),
    CONSTRAINT FK_tblUser_TO_tblRoutePostLikes FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblRoutePost_TO_tblRoutePostLikes FOREIGN KEY (routepost_id)
        REFERENCES tblRoutePost (routepost_id)
);

-------------------------------------------------
-- 6. 스크랩 테이블
-------------------------------------------------
CREATE TABLE tblRoutePostScrap (
    routepost_scrap_id    NUMBER NOT NULL,
    routepost_user_id     NUMBER NOT NULL,
    routepost_id          NUMBER NOT NULL,
    CONSTRAINT PK_tblRoutePostScrap PRIMARY KEY (routepost_scrap_id),
    CONSTRAINT FK_tblUser_TO_tblRoutePostScrap FOREIGN KEY (routepost_user_id)
        REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblRoutePost_TO_tblRoutePostScrap FOREIGN KEY (routepost_id)
        REFERENCES tblRoutePost (routepost_id)
);

CREATE SEQUENCE seqRoutePostScrap
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 7. 댓글 테이블
-------------------------------------------------
CREATE TABLE tblRoutePostComment (
    routepost_comment_id             NUMBER NOT NULL,
    user_id                          NUMBER NOT NULL,
    routepost_id                     NUMBER NOT NULL,
    routepost_content                VARCHAR2(2000) NOT NULL,
    routepost_regdate                DATE NOT NULL,
    routepost_comment_report_count   NUMBER DEFAULT 0 NOT NULL,
    comment_status                   CHAR(1) NOT NULL,
    CONSTRAINT PK_tblRoutePostComment PRIMARY KEY (routepost_comment_id),
    CONSTRAINT FK_tblUser_TO_tblRoutePostComment FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblRoutePost_TO_tblRoutePostComment FOREIGN KEY (routepost_id)
        REFERENCES tblRoutePost (routepost_id)
);

CREATE SEQUENCE seqRoutePostComment
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
COMMIT;
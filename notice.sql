--1. 사용자 테이블(관리자 계정용)
CREATE TABLE tblAdmin (
    admin_id        NUMBER          PRIMARY KEY,
    admin_username  VARCHAR2(50)    UNIQUE NOT NULL,
    admin_password  VARCHAR2(256)   NOT NULL,
    admin_nickname  VARCHAR2(50)    UNIQUE NOT NULL,
    role            VARCHAR2(20)    DEFAULT 'ADMIN' NOT NULL
);

CREATE SEQUENCE seq_tblAdmin;

-- 관리자 1명 추가
INSERT INTO tblAdmin (admin_id, admin_username, admin_password, admin_nickname, role)
VALUES (seq_tblAdmin.nextVal, 'admin01', 'admin', '총괄관리자', 'ADMIN');

-- 2. 공지사항 게시글 테이블
CREATE TABLE tblNoticePost (
    notice_post_id  NUMBER          PRIMARY KEY,
    admin_id        NUMBER          NOT NULL REFERENCES tblAdmin, -- 작성자 (관리자)
    notice_header   VARCHAR2(300)   NOT NULL,
    notice_content  CLOB            NOT NULL,
    notice_view_count NUMBER        DEFAULT 0,
    notice_regdate  DATE            DEFAULT SYSDATE
);

CREATE SEQUENCE seq_tblNoticePost;

-- 3. 공지사항 첨부 이미지 테이블 (선택 사항)
CREATE TABLE tblNoticeImage (
    image_id        NUMBER          PRIMARY KEY,
    notice_post_id  NUMBER          NOT NULL REFERENCES tblNoticePost(notice_post_id),
    image_url       VARCHAR2(500)   NOT NULL,
    image_sequence  NUMBER          DEFAULT 0
);

CREATE SEQUENCE seq_tblNoticeImage;



--공지사항 더미 데이터 5개 생성
INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[공지] 서비스 점검 안내 (10/15 02:00 ~ 05:00)', '보다 안정적인 서비스 제공을 위해 시스템 정기 점검을 실시합니다. 이용에 불편을 드려 죄송합니다.', 152, TO_DATE('2025-10-13', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 신규 기능 추가: AI 맞춤형 여행 루트 추천', '이제 AI와의 문답을 통해 나만의 맞춤형 여행 루트를 추천받을 수 있습니다. 지금 바로 경험해보세요!', 320, TO_DATE('2025-10-12', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 회원가입/로그인 관련 오류 수정 완료', '일부 환경에서 발생하던 간헐적인 로그인 오류 현상을 수정하였습니다. 안정적으로 서비스를 이용하실 수 있습니다.', 88, TO_DATE('2025-10-12', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[공지] 개인정보 보호 정책 개정 안내', '개인정보 보호 강화를 위해 일부 정책이 개정되었습니다. 자세한 내용은 마이페이지에서 확인하실 수 있습니다.', 210, TO_DATE('2025-10-11', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[공지] 예약 시스템 업데이트 및 개선 사항 안내', '숙소 및 렌터카 예약 확정 프로세스가 더 빠르고 안정적으로 개선되었습니다.', 175, TO_DATE('2025-10-10', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[이벤트] 가을 단풍 명소 추천 루트 오픈 🎉', 'AI가 추천하는 전국 최고의 단풍 명소 루트를 지금 바로 확인해보세요!', 451, TO_DATE('2025-10-10', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 전국 주요 축제/행사 일정 업데이트 (10월 기준)', '10월에 열리는 전국 각지의 축제 정보를 업데이트했습니다. 여행 계획에 참고하세요.', 233, TO_DATE('2025-10-09', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[공지] 태풍 영향으로 일부 여행 루트 자동 변경 안내', '태풍의 영향권에 있는 일부 야외 여행지의 경우, 안전을 위해 실내 코스로 자동 변경될 수 있습니다.', 198, TO_DATE('2025-10-08', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 헬스케어 루트 기능 베타 서비스 시작', '여행을 즐기면서 건강도 챙기세요! 걸음 수와 칼로리 소모량을 계산해주는 헬스케어 루트 베타 서비스를 오픈합니다.', 302, TO_DATE('2025-10-07', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 지역 맛집 데이터 업데이트 완료', '강원, 충청 지역의 신규 맛집 정보가 대량 업데이트되었습니다.', 164, TO_DATE('2025-10-06', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 동행 찾기 게시판 이용 수칙', '안전한 여행을 위해 동행 찾기 게시판 이용 시 유의사항을 안내해 드립니다. 게시판 상단 공지를 확인해주세요.', 95, TO_DATE('2025-10-05', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[공지] 허위/광고성 게시글 제재 기준 안내', '커뮤니티의 쾌적한 이용 환경을 위해 허위/광고성 게시글에 대한 제재 기준이 강화되었습니다.', 110, TO_DATE('2025-10-04', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 여행 후기 게시판 베스트 리뷰 선정 안내', '9월의 베스트 리뷰가 선정되었습니다. 선정되신 회원님께는 소정의 포인트를 지급해 드렸습니다.', 255, TO_DATE('2025-10-03', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[공지] 스크랩 기능 개선 및 마이페이지 연동 안내', '이제 스크랩한 모든 콘텐츠를 마이페이지에서 더 편리하게 관리할 수 있습니다.', 188, TO_DATE('2025-10-02', 'YYYY-MM-DD'));

INSERT INTO tblNoticePost (notice_post_id, admin_id, notice_header, notice_content, notice_view_count, notice_regdate)
VALUES (seq_tblNoticePost.nextVal, 1, '[안내] 신고 게시판 운영 정책 안내', '신고 처리 절차 및 기준에 대한 상세한 운영 정책을 안내해 드립니다.', 76, TO_DATE('2025-10-01', 'YYYY-MM-DD'));


select * from tblnoticepost;

commit;

-------------------------------------------------
-- 1. 질문 테이블
-------------------------------------------------
CREATE TABLE tblQuestion (
    question_id     NUMBER          NOT NULL,
    question_key    VARCHAR2(200)   NOT NULL,
    CONSTRAINT PK_tblQuestion PRIMARY KEY (question_id)
);

CREATE SEQUENCE seqQuestion
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 2. 선택지 테이블
-------------------------------------------------
CREATE TABLE tblOption (
    option_id       NUMBER          NOT NULL,
    question_id     NUMBER          NOT NULL,
    option_key      VARCHAR2(200)   NOT NULL,
    CONSTRAINT PK_tblOption PRIMARY KEY (option_id),
    CONSTRAINT FK_tblQuestion_TO_tblOption FOREIGN KEY (question_id)
        REFERENCES tblQuestion (question_id)
);

CREATE SEQUENCE seqOption
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    

-- 1. 기존 테이블과 관련 제약조건을 모두 삭제합니다.
DROP TABLE tblUser CASCADE CONSTRAINTS;

-- 2. 기존 시퀀스를 삭제합니다.
DROP SEQUENCE seqUser;
    
-- tblUser 테이블 생성
CREATE TABLE tblUser (
    user_id           NUMBER          NOT NULL,
    user_status_id    NUMBER          NULL,
    real_name         VARCHAR2(50)    NOT NULL,
    ssn               VARCHAR2(256)   NOT NULL,
    phone_number      VARCHAR2(20)    NOT NULL,
    username          VARCHAR2(50)    NOT NULL,
    password          VARCHAR2(256)   NOT NULL,
    email             VARCHAR2(100)   NOT NULL,
    nickname          VARCHAR2(50)    NOT NULL,
    address           VARCHAR2(300)   NULL,
    regdate           DATE            DEFAULT sysdate NOT NULL,
    deleted_at        DATE            NULL,
    gender            CHAR(1)         NULL,
    height            NUMBER          NULL,
    weight            NUMBER          NULL,
    health_goals      VARCHAR2(300)   NULL,
    CONSTRAINT PK_tblUser PRIMARY KEY (user_id),
    CONSTRAINT UQ_tblUser_ssn UNIQUE (ssn),
    CONSTRAINT UQ_tblUser_username UNIQUE (username),
    CONSTRAINT UQ_tblUser_email UNIQUE (email),
    CONSTRAINT UQ_tblUser_nickname UNIQUE (nickname)
);

-- user_id를 위한 시퀀스 생성
CREATE SEQUENCE seqUser
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 3. 대화(conversation) 테이블
-------------------------------------------------
CREATE TABLE tblConversation (
    conversation_id NUMBER          NOT NULL,
    user_id         NUMBER          NOT NULL,
    con_start_time  DATE            NOT NULL,
    con_end_time    DATE            NULL,
    route_generated CHAR(1)         NOT NULL,
    CONSTRAINT PK_tblConversation PRIMARY KEY (conversation_id),
    CONSTRAINT FK_tblUser_TO_tblConversation FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id)
);

CREATE SEQUENCE seqConversation
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 4. 사용자 답변 테이블
-------------------------------------------------
CREATE TABLE tblUserAnswer (
    user_answer_id  NUMBER          NOT NULL,
    user_id         NUMBER          NOT NULL,
    question_id     NUMBER          NOT NULL,
    option_id       NUMBER          NOT NULL,
    conversation_id NUMBER          NOT NULL,
    ans_free_text   VARCHAR2(50)    NULL,
    ans_created     DATE            NULL,
    CONSTRAINT PK_tblUserAnswer PRIMARY KEY (user_answer_id),
    CONSTRAINT FK_tblUser_TO_tblUserAnswer FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblQuestion_TO_tblUserAnswer FOREIGN KEY (question_id)
        REFERENCES tblQuestion (question_id),
    CONSTRAINT FK_tblOption_TO_tblUserAnswer FOREIGN KEY (option_id)
        REFERENCES tblOption (option_id),
    CONSTRAINT FK_tblConversation_TO_tblUserAnswer FOREIGN KEY (conversation_id)
        REFERENCES tblConversation (conversation_id)
);

CREATE SEQUENCE seqUserAnswer
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 5. AI 추천 루트 테이블
-------------------------------------------------
CREATE TABLE tblAiRoute (
    ai_route_id         NUMBER          NOT NULL,
    user_id             NUMBER          NOT NULL,
    conversation_id     NUMBER          NOT NULL,
    ai_route_title      VARCHAR2(200)   NULL,
    ai_route_days       NUMBER          NULL,
    ai_route_created    DATE            NULL,
    ai_route_region     VARCHAR2(200)   NULL,   -- ✅ 추가
    ai_route_startdate  DATE            NULL,   -- ✅ 추가
    ai_route_enddate    DATE            NULL,   -- ✅ 추가
    weather_consideration VARCHAR2(1000) NOT NULL,
    CONSTRAINT PK_tblAiRoute PRIMARY KEY (ai_route_id),
    CONSTRAINT FK_tblUser_TO_tblAiRoute FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblConversation_TO_tblAiRoute FOREIGN KEY (conversation_id)
        REFERENCES tblConversation (conversation_id)
);

CREATE SEQUENCE seqAiRoute
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 6. AI 루트 스탑 테이블
-------------------------------------------------
CREATE TABLE tblAiRouteStop (
    ai_route_stop_id        NUMBER          NOT NULL,
    ai_route_id             NUMBER          NOT NULL,
    ai_route_day            NUMBER          NULL,
    ai_route_stop_order     NUMBER          NULL,
    ai_route_lat            NUMBER(9,6)     NULL,
    ai_route_long           NUMBER(9,6)     NULL,
    ai_route_description    VARCHAR2(2000)  NOT NULL, 
    activity_code           VARCHAR2(20)    NOT NULL, 
    duration_in_minutes     NUMBER          NOT NULL, 
    restaurant_category     VARCHAR2(50)    NULL,
    CONSTRAINT PK_tblAiRouteStop PRIMARY KEY (ai_route_stop_id),
    CONSTRAINT FK_tblAiRoute_TO_tblAiRouteStop FOREIGN KEY (ai_route_id)
        REFERENCES tblAiRoute (ai_route_id)
);

CREATE SEQUENCE seqAiRouteStop
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 7. 사용자 루트 테이블
-------------------------------------------------
CREATE TABLE tblUserRoute (
    user_route_id       NUMBER          NOT NULL,
    user_id             NUMBER          NOT NULL,
    source_ai_route_id  NUMBER          NOT NULL,
    user_route_title    VARCHAR2(200)   NULL,
    user_route_days     NUMBER          NULL,
    user_route_saved    DATE            NULL,
    user_route_region   VARCHAR2(200)   NULL,   -- ✅ 추가
    user_route_startdate DATE           NULL,   -- ✅ 추가
    user_route_enddate   DATE           NULL,   -- ✅ 추가
    CONSTRAINT PK_tblUserRoute PRIMARY KEY (user_route_id),
    CONSTRAINT FK_tblUser_TO_tblUserRoute FOREIGN KEY (user_id)
        REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblAiRoute_TO_tblUserRoute FOREIGN KEY (source_ai_route_id)
        REFERENCES tblAiRoute (ai_route_id)
);

CREATE SEQUENCE seqUserRoute
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
-- 8. 사용자 루트 스탑 테이블
-------------------------------------------------
CREATE TABLE tblUserRouteStop (
    user_route_stop_id      NUMBER          NOT NULL,
    user_route_id           NUMBER          NOT NULL,
    user_route_day          NUMBER          NULL,
    user_route_stop_order   NUMBER          NULL,
    user_route_lat          NUMBER(9,6)     NULL,
    user_route_long         NUMBER(9,6)     NULL,
    user_route_description  VARCHAR2(1000)  NULL,
    CONSTRAINT PK_tblUserRouteStop PRIMARY KEY (user_route_stop_id),
    CONSTRAINT FK_tblUserRoute_TO_tblUserRouteStop FOREIGN KEY (user_route_id)
        REFERENCES tblUserRoute (user_route_id)
);

CREATE SEQUENCE seqUserRouteStop
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-------------------------------------------------
COMMIT;
-------------------------------------------------
ALTER TABLE tblAiRoute MODIFY (conversation_id NULL);


SELECT * FROM tblAiRoute ORDER BY ai_route_created DESC;


SELECT * FROM tblAiRouteStop WHERE ai_route_id = (SELECT MAX(ai_route_id) FROM tblAiRoute);

INSERT INTO tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, regdate) 
VALUES (seqUser.nextval, 1, '테스트', 'test_ssn', '010-0000-0000', 'testuser', 'testpass', 'test@example.com', '테스터', sysdate);


CREATE TABLE tblHealthCareLog (
    healthcare_id             NUMBER          NOT NULL,
    user_id                   NUMBER          NOT NULL, -- user_id 추가
    ai_route_stop_id          NUMBER          NOT NULL, -- ai_route_stop_id 추가
    healthcare_date           DATE            NOT NULL,
    healthcare_distance_km    NUMBER          NULL,
    healthcare_steps_count    NUMBER          NULL,
    healthcare_calories_burned NUMBER         NULL,
    CONSTRAINT PK_tblHealthCareLog PRIMARY KEY (healthcare_id),
    CONSTRAINT FK_tblUser_TO_tblHealthCareLog FOREIGN KEY (user_id)
        REFERENCES tblUser(user_id),
    CONSTRAINT FK_tblAiRouteStop_TO_tblHealthCareLog FOREIGN KEY (ai_route_stop_id)
        REFERENCES tblAiRouteStop(ai_route_stop_id)
);

CREATE SEQUENCE seqHealthCareLog
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
ALTER TABLE tblAiRouteStop ADD (
   walking_distance_km    NUMBER,
   walking_steps_count    NUMBER
);

COMMIT;




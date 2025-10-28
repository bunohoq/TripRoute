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
    ai_route_description    VARCHAR2(1000)  NULL,
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
drop table tblUserRoute;


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


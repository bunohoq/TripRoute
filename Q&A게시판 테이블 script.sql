------------------------------------------------------------
-- 🔥 여행 QnA 게시판 전체 초기화 스크립트 (Oracle)
-- 만든이: 성호 (for 누나)
-- 생성일: 2025-10-13
------------------------------------------------------------

-- 기존 테이블 제거 (존재할 경우)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE tblQuestionImage CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblQuestionLike CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblQuestionScrap CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblQuestionAnswer CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblQuestionBoard CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblQuestionCategory CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblUser CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblUserStatus CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

------------------------------------------------------------
-- 1️⃣ 회원 상태 테이블
------------------------------------------------------------
CREATE TABLE tblUserStatus (
    user_status_id NUMBER PRIMARY KEY,
    status         VARCHAR2(20) NOT NULL
);

------------------------------------------------------------
-- 2️⃣ 회원 테이블
------------------------------------------------------------
CREATE TABLE tblUser (
    user_id         NUMBER PRIMARY KEY,
    user_status_id  NUMBER NOT NULL,
    real_name       VARCHAR2(50) NOT NULL,
    ssn             VARCHAR2(256) NOT NULL,
    phone_number    VARCHAR2(20) NOT NULL,
    username        VARCHAR2(50),
    password        VARCHAR2(256) NOT NULL,
    email           VARCHAR2(100) NOT NULL,
    nickname        VARCHAR2(50) NOT NULL,
    address         VARCHAR2(300),
    regdate         DATE DEFAULT SYSDATE NOT NULL,
    deleted_at      DATE,
    gender          CHAR(1),
    height          NUMBER,
    weight          NUMBER,
    health_goals    VARCHAR2(300),
    CONSTRAINT fk_userstatus FOREIGN KEY (user_status_id)
        REFERENCES tblUserStatus (user_status_id)
);

------------------------------------------------------------
-- 3️⃣ 질문 카테고리 테이블
------------------------------------------------------------
CREATE TABLE tblQuestionCategory (
    question_category_id   NUMBER PRIMARY KEY,
    question_category_name VARCHAR2(50)
);

drop table tblQuestionCategory;
DROP TABLE tblQuestionCategory CASCADE CONSTRAINTS;
------------------------------------------------------------
-- 4️⃣ 질문 게시판 테이블
------------------------------------------------------------
CREATE TABLE tblQuestionBoard (
    question_board_id          NUMBER PRIMARY KEY,
    user_id                    NUMBER NOT NULL,
    question_board_title       VARCHAR2(300) NOT NULL,
    question_board_content     CLOB NOT NULL,
    question_board_view_count  NUMBER DEFAULT 0 NOT NULL,
    question_board_like_count  NUMBER DEFAULT 0 NOT NULL,
    question_board_scrap_count NUMBER DEFAULT 0 NOT NULL,
    question_board_comment_count NUMBER DEFAULT 0 NOT NULL,
    question_board_answer_status CHAR(1) DEFAULT 'n',
    question_board_status       CHAR(1) DEFAULT 'y' NOT NULL,
    question_board_regdate      DATE DEFAULT SYSDATE NOT NULL,
    question_board_update       DATE,
    question_board_report_count NUMBER DEFAULT 0 NOT NULL,
    question_category_id        NUMBER NOT NULL,
    CONSTRAINT fk_user_to_board FOREIGN KEY (user_id) REFERENCES tblUser(user_id),
    CONSTRAINT fk_category_to_board FOREIGN KEY (question_category_id) REFERENCES tblQuestionCategory(question_category_id)
);

select * from tblQuestionBoard;

------------------------------------------------------------
-- 5️⃣ 이미지 테이블
------------------------------------------------------------
CREATE TABLE tblQuestionImage (
    question_image_id        NUMBER PRIMARY KEY,
    question_board_id        NUMBER NOT NULL,
    question_image_image_url VARCHAR2(100) NOT NULL,
    question_image_image_sequence NUMBER DEFAULT 1 NOT NULL,
    CONSTRAINT fk_board_to_image FOREIGN KEY (question_board_id)
        REFERENCES tblQuestionBoard (question_board_id)
);

------------------------------------------------------------
-- 6️⃣ 좋아요 테이블
------------------------------------------------------------
CREATE TABLE tblQuestionLike (
    question_board_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    CONSTRAINT pk_questionlike PRIMARY KEY (question_board_id, user_id),
    CONSTRAINT fk_like_board FOREIGN KEY (question_board_id) REFERENCES tblQuestionBoard(question_board_id),
    CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES tblUser(user_id)
);

------------------------------------------------------------
-- 7️⃣ 스크랩 테이블
------------------------------------------------------------
CREATE TABLE tblQuestionScrap (
    question_scrap_id NUMBER PRIMARY KEY,
    question_board_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    CONSTRAINT fk_scrap_board FOREIGN KEY (question_board_id) REFERENCES tblQuestionBoard(question_board_id),
    CONSTRAINT fk_scrap_user FOREIGN KEY (user_id) REFERENCES tblUser(user_id)
);

------------------------------------------------------------
-- 8️⃣ 댓글(답변) 테이블
------------------------------------------------------------
CREATE TABLE tblQuestionAnswer (
    question_answer_id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    question_board_id NUMBER NOT NULL,
    question_answer_content VARCHAR2(200) NOT NULL,
    question_answer_regdate DATE DEFAULT SYSDATE NOT NULL,
    question_answer_report_count NUMBER DEFAULT 0 NOT NULL,
    question_answer_status CHAR(1) DEFAULT 'Y' NOT NULL,
    CONSTRAINT fk_answer_user FOREIGN KEY (user_id) REFERENCES tblUser(user_id),
    CONSTRAINT fk_answer_board FOREIGN KEY (question_board_id) REFERENCES tblQuestionBoard(question_board_id)
);

------------------------------------------------------------
-- 🔹 기본 데이터 삽입
------------------------------------------------------------
-- 회원 상태
INSERT INTO tblUserStatus VALUES (1, '활성');
INSERT INTO tblUserStatus VALUES (2, '정지');
select * from tbluserstatus;

-- 회원
INSERT INTO tblUser VALUES (1, 1, '명재현', '000101-1234567', '010-1111-2222', 'jimin01', 'pass123', 'jimin@test.com', '여행덕후', '서울 강남구', SYSDATE, NULL, 'F', 165, 50, '맛집 탐방');
INSERT INTO tblUser VALUES (2, 1, '한태산', '000202-1234567', '010-3333-4444', 'taesan02', 'pass123', 'taesan@test.com', '산좋아', '부산 해운대구', SYSDATE, NULL, 'M', 180, 70, '국내 등산 정복');
INSERT INTO tblUser VALUES (3, 1, '김운학', '000303-2234567', '010-5555-6666', 'seoyeon03', 'pass123', 'seoyeon@test.com', '캠핑러버', '강릉시 주문진읍', SYSDATE, NULL, 'F', 160, 48, '캠핑 투어');
INSERT INTO tblUser VALUES (4, 1, '박성호', '000404-1234567', '010-7777-8888', 'sungho04', 'pass123', 'sungho@test.com', '예삐', '대전 서구', SYSDATE, NULL, 'M', 178, 68, '드라이브 여행');
INSERT INTO tblUser VALUES (5, 1, '문예빈', '000505-1234567', '010-9999-0000', 'yebin05', 'pass123', 'yebin@test.com', '성호뷘', '제주시 연동', SYSDATE, NULL, 'F', 162, 47, '바다 근처 여행');

-- 카테고리
INSERT INTO tblQuestionCategory VALUES (1, '국내 맛집');
INSERT INTO tblQuestionCategory VALUES (2, '숙소 추천');
INSERT INTO tblQuestionCategory VALUES (3, '여행 팁');
INSERT INTO tblQuestionCategory VALUES (4, '교통/렌터카');

DROP TABLE tblQuestionCategory CASCADE CONSTRAINTS;


------------------------------------------------------------
-- 🔹 국내 여행 QnA 게시글 (20개)
------------------------------------------------------------

drop table tblQuestionBoard CASCADE CONSTRAINTS;

select * from tbluser;

BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO tblQuestionBoard (
            question_board_id, user_id, question_board_title, question_board_content,
            question_category_id
        ) VALUES (
            i,
            MOD(i, 5) + 1,
            CASE 
                WHEN i <= 5 THEN '서울 여행 중 꼭 가봐야 할 맛집 추천해주세요'
                WHEN i <= 10 THEN '부산 해운대 근처 숙소 중 뷰 좋은 곳 있을까요?'
                WHEN i <= 15 THEN '강릉 겨울 여행 시 추천 코스 알려주세요'
                ELSE '제주도 렌터카 이용 시 꿀팁 있나요?'
            END,
            CASE 
                WHEN i <= 5 THEN '서울에서 혼자 여행할 때 가볼만한 맛집이 궁금합니다. 현지인 추천도 좋아요!'
                WHEN i <= 10 THEN '해운대 주변 숙소 중 조용하고 뷰 좋은 곳 찾고 있어요. 가족 여행입니다.'
                WHEN i <= 15 THEN '강릉 겨울 여행 계획 중인데, 눈 오는 날에도 갈만한 코스 있을까요?'
                ELSE '제주 렌터카 예약 시 주의할 점이나 업체 추천 부탁드려요.'
            END,
            CEIL(i / 5)
        );
    END LOOP;
END;
/

select * from tblQuestionBoard;


------------------------------------------------------------
-- 🔹 댓글 (랜덤 생성)
------------------------------------------------------------
BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO tblQuestionAnswer (question_answer_id, user_id, question_board_id, question_answer_content)
        VALUES (i, MOD(i+1,5)+1, i, '좋은 정보네요! 다음 여행에 참고할게요.');
        IF MOD(i,3)=0 THEN
            INSERT INTO tblQuestionAnswer (question_answer_id, user_id, question_board_id, question_answer_content)
            VALUES (i+100, MOD(i+2,5)+1, i, '저도 거기 가봤는데 진짜 좋아요!');
        END IF;
    END LOOP;
END;
/

------------------------------------------------------------
-- 🔹 좋아요 / 스크랩 / 이미지
------------------------------------------------------------
BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO tblQuestionLike VALUES (i, MOD(i,5)+1);
        INSERT INTO tblQuestionScrap VALUES (i, i, MOD(i,5)+1);
        INSERT INTO tblQuestionImage VALUES (i, i, 'https://travelimages.kr/'||i||'.jpg', 1);
    END LOOP;
END;
/

COMMIT;
------------------------------------------------------------
-- ✅ 완료
------------------------------------------------------------
SELECT '✅ 여행 QnA 게시판 더미데이터 생성 완료' AS RESULT FROM dual;



------------------------------------------------------------
-- 🧩 댓글 수 자동 반영 트리거
------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_question_answer_count
AFTER INSERT OR DELETE ON tblQuestionAnswer
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE tblQuestionBoard
           SET question_board_comment_count = question_board_comment_count + 1
         WHERE question_board_id = :NEW.question_board_id;
    ELSIF DELETING THEN
        UPDATE tblQuestionBoard
           SET question_board_comment_count = question_board_comment_count - 1
         WHERE question_board_id = :OLD.question_board_id;
    END IF;
END;
/

------------------------------------------------------------
-- 🧩 좋아요 수 자동 반영 트리거
------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_question_like_count
AFTER INSERT OR DELETE ON tblQuestionLike
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE tblQuestionBoard
           SET question_board_like_count = question_board_like_count + 1
         WHERE question_board_id = :NEW.question_board_id;
    ELSIF DELETING THEN
        UPDATE tblQuestionBoard
           SET question_board_like_count = question_board_like_count - 1
         WHERE question_board_id = :OLD.question_board_id;
    END IF;
END;
/

------------------------------------------------------------
-- 🧩 스크랩 수 자동 반영 트리거
------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_question_scrap_count
AFTER INSERT OR DELETE ON tblQuestionScrap
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE tblQuestionBoard
           SET question_board_scrap_count = question_board_scrap_count + 1
         WHERE question_board_id = :NEW.question_board_id;
    ELSIF DELETING THEN
        UPDATE tblQuestionBoard
           SET question_board_scrap_count = question_board_scrap_count - 1
         WHERE question_board_id = :OLD.question_board_id;
    END IF;
END;
/

------------------------------------------------------------
-- 🔍 조회수는 트리거가 아닌 로직으로 처리!
-- 게시글 상세 조회 시 아래 SQL 실행
-- UPDATE tblQuestionBoard
--    SET question_board_view_count = question_board_view_count + 1
--  WHERE question_board_id = :id;
------------------------------------------------------------

UPDATE tblQuestionBoard
SET QUESTION_BOARD_ANSWER_STATUS = LOWER(QUESTION_BOARD_ANSWER_STATUS),
    QUESTION_BOARD_STATUS = LOWER(QUESTION_BOARD_STATUS);

select * from tblQuestionBoard;

SELECT * FROM tblQuestionBoard ORDER BY question_board_id DESC;

SELECT * FROM (   SELECT ROWNUM AS rnum, a.* FROM (     SELECT b.question_board_id, b.question_board_title, b.user_id AS board_user_id, u.nickname,            b.question_board_regdate, b.question_board_answer_status,            c.question_category_name AS question_board_category,            b.question_board_like_count, b.question_board_scrap_count,            b.question_board_view_count, b.question_board_comment_count     FROM tblQuestionBoard b     LEFT JOIN tblQuestionCategory c ON b.question_category_id = c.question_category_id     LEFT JOIN tblUser u ON b.user_id = u.user_id     ORDER BY b.question_board_id DESC   ) a ) WHERE rnum BETWEEN 1 AND 20;

UPDATE tblQuestionBoard b
SET b.question_board_comment_count = (SELECT COUNT(*) FROM tblQuestionAnswer a WHERE a.question_board_id = b.question_board_id),
    b.question_board_like_count = (SELECT COUNT(*) FROM tblQuestionLike l WHERE l.question_board_id = b.question_board_id),
    b.question_board_scrap_count = (SELECT COUNT(*) FROM tblQuestionScrap s WHERE s.question_board_id = b.question_board_id);

SELECT a.question_answer_id, a.user_id, u.nickname, a.question_board_id, a.question_answer_content, a.question_answer_regdate, a.question_answer_report_count, a.question_answer_status FROM tblQuestionAnswer a JOIN tblUser u ON a.user_id = u.user_id WHERE a.question_board_id = 1 ORDER BY a.question_answer_regdate ASC;

UPDATE tblQuestionBoard
   SET question_board_answer_status = 'y'
 WHERE question_board_answer_status = 'n';

COMMIT;

SELECT room_id, room_name, price_per_night, room_image_url
            FROM tblAccomRoom ar
                JOIN tblAccom a ON ar.accom_id = a.accom_id
                JOIN tblPlace p ON a.place_id = p.place_id
                JOIN tblPlaceLocation pl ON pl.place_Location_id = p.place_Location_id 
            WHERE pl.place_Location_name = '부산' AND capacity >= 1;


DELETE FROM tblQuestionAnswer;
DELETE FROM tblQuestionBoard;
DELETE FROM tblQuestionCategory;
COMMIT;


-- ✅ QnA 더미데이터 (Oracle 호환 50건 풀버전)
-- Category
INSERT INTO tblQuestionCategory (question_category_id, question_category_name) VALUES (1, '예약문의');
INSERT INTO tblQuestionCategory (question_category_id, question_category_name) VALUES (2, '결제문의');
INSERT INTO tblQuestionCategory (question_category_id, question_category_name) VALUES (3, '숙소문의');
INSERT INTO tblQuestionCategory (question_category_id, question_category_name) VALUES (4, '차량문의');
INSERT INTO tblQuestionCategory (question_category_id, question_category_name) VALUES (5, '기타');

delete from tblquestioncategory;

-- ✅ 게시글 (50건)

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (1, 3, '숙소 예약이 자동으로 취소돼요', '숙소 예약이 자동으로 취소돼요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 16, 5, 4, 0, 'n', 'y', SYSDATE - 5, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (2, 8, '카드 결제 오류가 발생했습니다', '카드 결제 오류가 발생했습니다 관련 문의드립니다. 자세한 안내 부탁드립니다.', 97, 4, 5, 1, 'y', 'y', SYSDATE - 7, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (3, 6, '체크인 시간은 몇 시부터인가요?', '체크인 시간은 몇 시부터인가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 146, 5, 1, 0, 'n', 'y', SYSDATE - 1, 4);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (4, 3, '차량 예약 후 수정 가능한가요?', '차량 예약 후 수정 가능한가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 107, 4, 5, 1, 'y', 'y', SYSDATE - 6, 4);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (5, 8, '숙소 위치를 지도에서 볼 수 있나요?', '숙소 위치를 지도에서 볼 수 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 40, 4, 3, 0, 'n', 'y', SYSDATE - 10, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (6, 9, '예약 확정 문자가 안 와요', '예약 확정 문자가 안 와요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 126, 3, 0, 1, 'y', 'y', SYSDATE - 6, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (7, 3, '환불은 언제 처리되나요?', '환불은 언제 처리되나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 191, 7, 0, 0, 'n', 'y', SYSDATE - 6, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (8, 3, 'AI 추천 루트 다시 받을 수 있나요?', 'AI 추천 루트 다시 받을 수 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 197, 1, 4, 1, 'y', 'y', SYSDATE - 3, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (9, 8, '차량 반납 시간은 어떻게 확인하나요?', '차량 반납 시간은 어떻게 확인하나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 142, 9, 3, 0, 'n', 'y', SYSDATE - 6, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (10, 6, '숙소에 주차장이 있나요?', '숙소에 주차장이 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 84, 5, 4, 1, 'y', 'y', SYSDATE - 2, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (11, 6, '예약 내역이 사라졌어요', '예약 내역이 사라졌어요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 85, 4, 5, 0, 'n', 'y', SYSDATE - 9, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (12, 1, '결제 취소 후 재결제 가능한가요?', '결제 취소 후 재결제 가능한가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 120, 4, 3, 1, 'y', 'y', SYSDATE - 8, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (13, 9, '숙소가 실제 사진과 달라요', '숙소가 실제 사진과 달라요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 32, 5, 2, 0, 'n', 'y', SYSDATE - 7, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (14, 10, '차량이 생각보다 작아요', '차량이 생각보다 작아요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 181, 2, 3, 1, 'y', 'y', SYSDATE - 2, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (15, 3, '포인트로 결제할 수 있나요?', '포인트로 결제할 수 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 158, 1, 2, 0, 'n', 'y', SYSDATE - 6, 4);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (16, 10, '숙소 후기 작성은 어디서 하나요?', '숙소 후기 작성은 어디서 하나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 51, 10, 2, 1, 'y', 'y', SYSDATE - 10, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (17, 7, '비회원도 예약 가능한가요?', '비회원도 예약 가능한가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 135, 8, 3, 0, 'n', 'y', SYSDATE - 10, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (18, 2, '여행일정 변경은 어떻게 하나요?', '여행일정 변경은 어떻게 하나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 59, 7, 3, 1, 'y', 'y', SYSDATE - 6, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (19, 8, '이메일 영수증을 못 받았어요', '이메일 영수증을 못 받았어요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 95, 5, 0, 0, 'n', 'y', SYSDATE - 2, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (20, 1, '결제금액이 다르게 청구됐어요', '결제금액이 다르게 청구됐어요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 116, 0, 2, 1, 'y', 'y', SYSDATE - 10, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (21, 7, 'AI 루트 추천 너무 정확해요!', 'AI 루트 추천 너무 정확해요! 관련 문의드립니다. 자세한 안내 부탁드립니다.', 57, 4, 3, 0, 'n', 'y', SYSDATE - 9, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (22, 7, '차량 업체 변경 가능한가요?', '차량 업체 변경 가능한가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 29, 6, 3, 1, 'y', 'y', SYSDATE - 7, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (23, 2, '숙소 변경 시 추가요금 있나요?', '숙소 변경 시 추가요금 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 121, 10, 2, 0, 'n', 'y', SYSDATE - 6, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (24, 7, '예약 완료 후 인원 수정 가능한가요?', '예약 완료 후 인원 수정 가능한가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 31, 8, 1, 1, 'y', 'y', SYSDATE - 7, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (25, 7, 'AI 추천이 안 떠요', 'AI 추천이 안 떠요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 138, 10, 0, 0, 'n', 'y', SYSDATE - 7, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (26, 10, '숙소 정보가 잘못 나와요', '숙소 정보가 잘못 나와요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 103, 10, 5, 1, 'y', 'y', SYSDATE - 8, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (27, 10, '예약 취소가 안 됩니다', '예약 취소가 안 됩니다 관련 문의드립니다. 자세한 안내 부탁드립니다.', 24, 1, 1, 0, 'n', 'y', SYSDATE - 5, 4);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (28, 4, '차량 옵션을 잘못 선택했어요', '차량 옵션을 잘못 선택했어요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 37, 8, 5, 1, 'y', 'y', SYSDATE - 7, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (29, 10, '리뷰 작성하면 포인트 주나요?', '리뷰 작성하면 포인트 주나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 185, 8, 1, 0, 'n', 'y', SYSDATE - 8, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (30, 7, '숙소 체크아웃 시간 알려주세요', '숙소 체크아웃 시간 알려주세요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 50, 1, 3, 1, 'y', 'y', SYSDATE - 5, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (31, 6, '회원탈퇴 후 예약 내역 남나요?', '회원탈퇴 후 예약 내역 남나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 173, 6, 2, 0, 'n', 'y', SYSDATE - 9, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (32, 3, '차량 옵션 비교 기능 있나요?', '차량 옵션 비교 기능 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 32, 0, 2, 1, 'y', 'y', SYSDATE - 5, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (33, 3, '여러 지역 예약이 가능한가요?', '여러 지역 예약이 가능한가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 149, 1, 3, 0, 'n', 'y', SYSDATE - 10, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (34, 5, '예약확인 페이지에서 오류가 떠요', '예약확인 페이지에서 오류가 떠요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 65, 8, 0, 1, 'y', 'y', SYSDATE - 2, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (35, 9, '숙소가 꽉 찼다고 나와요', '숙소가 꽉 찼다고 나와요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 200, 9, 1, 0, 'n', 'y', SYSDATE - 5, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (36, 10, '렌터카 운전연령 제한이 있나요?', '렌터카 운전연령 제한이 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 95, 10, 2, 1, 'y', 'y', SYSDATE - 2, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (37, 7, '숙소 결제 영수증 다시 받을 수 있나요?', '숙소 결제 영수증 다시 받을 수 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 100, 10, 3, 0, 'n', 'y', SYSDATE - 6, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (38, 1, '차량 픽업 장소는 어디인가요?', '차량 픽업 장소는 어디인가요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 54, 6, 1, 1, 'y', 'y', SYSDATE - 5, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (39, 7, '결제 수단 추가 계획 있나요?', '결제 수단 추가 계획 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 61, 2, 3, 0, 'n', 'y', SYSDATE - 9, 4);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (40, 8, 'AI 추천이 너무 느려요', 'AI 추천이 너무 느려요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 17, 5, 5, 1, 'y', 'y', SYSDATE - 5, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (41, 7, '숙소 결제 시 포인트 적용 안 돼요', '숙소 결제 시 포인트 적용 안 돼요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 139, 3, 5, 0, 'n', 'y', SYSDATE - 6, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (42, 9, '예약 날짜를 잘못 선택했어요', '예약 날짜를 잘못 선택했어요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 16, 7, 1, 1, 'y', 'y', SYSDATE - 3, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (43, 5, '예약 취소 수수료가 있나요?', '예약 취소 수수료가 있나요? 관련 문의드립니다. 자세한 안내 부탁드립니다.', 68, 5, 1, 0, 'n', 'y', SYSDATE - 1, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (44, 3, '차량 사진이 안 보여요', '차량 사진이 안 보여요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 154, 2, 5, 1, 'y', 'y', SYSDATE - 10, 2);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (45, 8, '숙소 가격이 다르게 표시돼요', '숙소 가격이 다르게 표시돼요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 60, 7, 1, 0, 'n', 'y', SYSDATE - 8, 1);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (46, 5, 'AI 추천 장소가 이상해요', 'AI 추천 장소가 이상해요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 87, 4, 3, 1, 'y', 'y', SYSDATE - 9, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (47, 2, '숙소 결제 방법이 궁금해요', '숙소 결제 방법이 궁금해요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 89, 10, 2, 0, 'n', 'y', SYSDATE - 9, 3);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (48, 3, '예약 확인 버튼이 안 눌려요', '예약 확인 버튼이 안 눌려요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 26, 0, 3, 1, 'y', 'y', SYSDATE - 10, 4);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (49, 6, '차량 연료 정책이 궁금해요', '차량 연료 정책이 궁금해요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 70, 3, 3, 0, 'n', 'y', SYSDATE - 5, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (50, 9, '숙소 지도 위치가 안 떠요', '숙소 지도 위치가 안 떠요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 17, 6, 0, 1, 'y', 'y', SYSDATE - 6, 5);

INSERT INTO tblQuestionBoard (
    question_board_id, user_id, question_board_title, question_board_content,
    question_board_view_count, question_board_like_count, question_board_scrap_count,
    question_board_comment_count, question_board_answer_status, question_board_status,
    question_board_regdate, question_category_id
) VALUES (51, 1, '예약 수정 버튼이 작동 안 돼요', '예약 수정 버튼이 작동 안 돼요 관련 문의드립니다. 자세한 안내 부탁드립니다.', 126, 5, 2, 0, 'n', 'y', SYSDATE - 8, 5);

-- ✅ 댓글 (30건)
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (1, 2, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 2);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (2, 4, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (3, 6, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 2);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (4, 8, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 4);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (5, 10, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 3);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (6, 12, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (7, 14, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (8, 16, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (9, 18, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 3);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (10, 20, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 3);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (11, 22, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 5);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (12, 24, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (13, 26, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (14, 28, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 4);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (15, 30, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 3);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (16, 32, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 5);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (17, 34, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 4);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (18, 36, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 2);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (19, 38, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 3);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (20, 40, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (21, 42, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 4);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (22, 44, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 2);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (23, 46, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 1);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (24, 48, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 4);
INSERT INTO tblQuestionAnswer (question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate) VALUES (25, 50, 99, '안녕하세요. 문의하신 내용에 대한 답변입니다. 담당자가 확인 후 안내드렸습니다.', SYSDATE - 3);



-- ✅ QnA 더미데이터 정상 삽입 확인용

SELECT COUNT(*) AS "카테고리 수" FROM tblQuestionCategory; -- 5
SELECT COUNT(*) AS "게시글 수" FROM tblQuestionBoard; -- 50
SELECT COUNT(*) AS "댓글 수" FROM tblQuestionAnswer; -- 30

commit;

select * from tblUser;


-- ✅ 회원 더미데이터 (6~10)
INSERT INTO tblUser (
    user_id, user_status_id, real_name, ssn, phone_number, username,
    password, email, nickname, address, regdate, deleted_at,
    gender, height, weight, health_goals
) VALUES (
    6, 1, '홍길동', '901010-1234567', '010-1111-2222', 'hong6',
    '1234', 'hong6@example.com', '길동6', '서울시 강남구 테헤란로 1',
    TO_DATE('2025-01-01', 'YYYY-MM-DD'), NULL, 'M', 178, 70, 'STRESS_RELIEF'
);

INSERT INTO tblUser (
    user_id, user_status_id, real_name, ssn, phone_number, username,
    password, email, nickname, address, regdate, deleted_at,
    gender, height, weight, health_goals
) VALUES (
    7, 1, '이서연', '940305-2234567', '010-2222-3333', 'seoyeon7',
    '1234', 'seoyeon7@example.com', '서연7', '부산시 해운대구 해변로 21',
    TO_DATE('2025-01-02', 'YYYY-MM-DD'), NULL, 'F', 163, 52, 'WEIGHT_LOSS'
);

INSERT INTO tblUser (
    user_id, user_status_id, real_name, ssn, phone_number, username,
    password, email, nickname, address, regdate, deleted_at,
    gender, height, weight, health_goals
) VALUES (
    8, 1, '박지호', '950912-1234567', '010-3333-4444', 'jiho8',
    '1234', 'jiho8@example.com', '지호8', '인천시 연수구 송도동 55',
    TO_DATE('2025-01-03', 'YYYY-MM-DD'), NULL, 'M', 180, 74, 'STRESS_RELIEF'
);

INSERT INTO tblUser (
    user_id, user_status_id, real_name, ssn, phone_number, username,
    password, email, nickname, address, regdate, deleted_at,
    gender, height, weight, health_goals
) VALUES (
    9, 1, '최민준', '970411-1234567', '010-4444-5555', 'minjun9',
    '1234', 'minjun9@example.com', '민준9', '대구시 수성구 들안로 88',
    TO_DATE('2025-01-04', 'YYYY-MM-DD'), NULL, 'M', 175, 68, 'WEIGHT_LOSS'
);

INSERT INTO tblUser (
    user_id, user_status_id, real_name, ssn, phone_number, username,
    password, email, nickname, address, regdate, deleted_at,
    gender, height, weight, health_goals
) VALUES (
    10, 1, '김예빈', '000521-2234567', '010-5555-6666', 'yebin10',
    '1234', 'yebin10@example.com', '예빈10', '광주시 서구 치평동 102',
    TO_DATE('2025-01-05', 'YYYY-MM-DD'), NULL, 'F', 165, 50, 'STRESS_RELIEF'
);

COMMIT;

select * from tblUser;
select * from tbladmin;

SELECT * FROM tblQuestionAnswer ORDER BY question_answer_id DESC;

SELECT question_board_comment_count FROM tblQuestionBoard WHERE question_board_id = 1;

SELECT question_answer_id, question_board_id, user_id, question_answer_content, question_answer_regdate
FROM tblQuestionAnswer
WHERE question_board_id = 2
ORDER BY question_answer_id DESC;

SELECT *
FROM tblQuestionAnswer
ORDER BY question_answer_id DESC;

UPDATE tblUser
SET 
    user_status_id = 1,
    real_name = '명재현',
    ssn = '000101-1234567',
    phone_number = '010-1111-2222',
    username = 'jimin01',
    password = 'pass123',
    email = 'jimin@test.com',
    nickname = '여행덕후',
    address = '서울 강남구',
    regdate = SYSDATE, -- 가입일도 현재 날짜로 변경하려면 이 줄을 유지하세요.
    deleted_at = NULL,
    gender = 'F',
    height = 165,
    weight = 50,
    health_goals = 'food'
WHERE 
    user_id = 3;



commit;







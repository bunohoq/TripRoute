
-- 시퀀스 모음
create sequence seqUser;

create sequence seqHotDealPost;
create sequence seqHotDealComment;
create sequence seqHotDealImage;
create sequence seqHotDealScrap;

drop sequence seqUser;


--유저
select * from tblUser;
select * from tbluserstatus;

DROP TABLE tbluserstatus CASCADE CONSTRAINTS;
DROP TABLE tbluser CASCADE CONSTRAINTS;
DROP TABLE tblhotdealpost CASCADE CONSTRAINTS;


CREATE TABLE tblUser (
	user_id	number	primary key,
	user_status_id	number	NOT NULL REFERENCES tblUserStatus(user_status_id),
	real_name	varchar2(50) NOT NULL,
	ssn	varchar2(256)	NOT NULL,
	phone_number	varchar2(20)	NOT NULL,
	username	varchar2(50)	NULL,
	password	varchar2(256)	NOT NULL,
	email	varchar2(100)	NOT NULL,
	nickname	varchar2(50)	NOT NULL,
	address	varchar2(300)	NULL,
	regdate	date	NOT NULL,
	deleted_at	date	NULL,
	gender	char(1)	NULL,
	height	number	NULL,
	weight	number	NULL,
	health_goals	varchar2(300)	NULL
);


CREATE TABLE tblUserStatus (
	user_status_id	number	primary key,
	status	varchar2(20)	NOT NULL
);



insert into tblUserStatus (user_status_id, status) values (1, 'ACTIVE');
insert into tblUserStatus (user_status_id, status) values (2, 'DELETED');
insert into tblUserStatus (user_status_id, status) values (3, 'BANNED');

insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '김민준', '001123-3123456', '010-1234-5678', 'kimminjun', '1111', 'kim.minjun@example.com', '민준킴', '서울 강남구 테헤란로 152', sysdate, null, 'm', 178, 76, 'MUSCLE_GAIN');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '이서아', '010511-4234567', '010-2345-6789', 'leeseoah', '1111', 'seoah.lee@example.com', '서아리', '서울 서초구 서초대로 77길', sysdate, null, 'f', 165, 54, 'WEIGHT_LOSS');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '박도윤', '990321-3345678', '010-3456-7890', 'parkdoyoon', '1111', 'doyoon.park@example.com', '도윤팍', '부산 해운대구 마린시티로 1', sysdate, null, 'm', 182, 85, 'MUSCLE_GAIN');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '최하윤', '021201-4456789', '010-4567-8901', 'choihayoon', '1111', 'hayoon.choi@example.com', '최하윤짱', '서울 마포구 월드컵북로 400', sysdate, null, 'f', 168, 58, 'MAINTENANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '정시우', '980715-3567890', '010-5678-9012', 'jeongsiwoo', '1111', 'siwoo.jeong@example.com', '시우정', '대구 중구 동성로2길 81', sysdate, null, 'm', 175, 72, 'IMPROVE_ENDURANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '강지안', '030130-4678901', '010-6789-0123', 'kangjian', '1111', 'jian.kang@example.com', '지안강', '인천 연수구 컨벤시아대로 165', sysdate, null, 'f', 160, 51, 'WEIGHT_LOSS');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 2, '조하준', '000824-3789012', '010-7890-1234', 'johajun', '1111', 'hajun.jo@example.com', '조하준맨', '광주 서구 상무중앙로 7', sysdate, null, 'm', 180, 79, 'MUSCLE_GAIN');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '윤서윤', '011005-4890123', '010-8901-2345', 'yoonseoyoon', '1111', 'seoyoon.yoon@example.com', '윤서윤', '대전 유성구 대덕대로 480', sysdate, null, 'f', 172, 60, 'MAINTENANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '장지호', '990218-3901234', '010-9012-3456', 'jangjiho', '1111', 'jiho.jang@example.com', '지호장', '울산 남구 삼산로 277', sysdate, null, 'm', 176, 74, 'IMPROVE_ENDURANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '임하은', '020414-4012345', '010-0123-4567', 'imhaeun', '1111', 'haeun.im@example.com', '하은임', '서울 용산구 한강대로 23길', sysdate, null, 'f', 163, 52, 'WEIGHT_LOSS');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 2, '한주원', '000620-3135791', '010-1122-3344', 'hanjuwon', '1111', 'juwon.han@example.com', '주원한', '수원 팔달구 행궁로 11', sysdate, null, 'm', 181, 81, 'MUSCLE_GAIN');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '오지우', '030909-4246802', '010-2233-4455', 'ohjiwoo', '1111', 'jiwoo.oh@example.com', '오지우월드', '성남 분당구 판교역로 166', sysdate, null, 'f', 166, 56, 'MAINTENANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 3, '서유준', '981111-3357913', '010-3344-5566', 'seoyujun', '1111', 'yujun.seo@example.com', '서유준이다', '고양 일산동구 중앙로 1275', sysdate, null, 'm', 179, 75, 'IMPROVE_ENDURANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '신수아', '010325-4468024', '010-4455-6677', 'shinsuah', '1111', 'suah.shin@example.com', '신수아파워', '용인 기흥구 동백중앙로 225', sysdate, null, 'f', 169, 57, 'WEIGHT_LOSS');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '송재윤', '020817-3579135', '010-5566-7788', 'songjaeyoon', '1111', 'jaeyoon.song@example.com', '송재윤재윤', '서울 종로구 세종대로 175', sysdate, null, 'm', 177, 73, 'MUSCLE_GAIN');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 3, '권지아', '990707-4680246', '010-6677-8899', 'kwonjiah', '1111', 'jiah.kwon@example.com', '권지아님', '제주 제주시 노형로 407', sysdate, null, 'f', 164, 55, 'MAINTENANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '황은우', '001231-3791357', '010-7788-9900', 'hwangeunwoo', '1111', 'eunwoo.hwang@example.com', '황금은우', '서울 송파구 올림픽로 300', sysdate, null, 'm', 183, 88, 'MUSCLE_GAIN');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '안서연', '030228-4802468', '010-8899-0011', 'ahnseoyeon', '1111', 'seoyeon.ahn@example.com', '안서연공주', '전주 완산구 홍산로 276', sysdate, null, 'f', 161, 50, 'WEIGHT_LOSS');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '문건우', '010610-3913579', '010-9900-1122', 'moongunwoo', '1111', 'gunwoo.moon@example.com', '문건우최고', '청주 흥덕구 2순환로 1262', sysdate, null, 'm', 174, 71, 'IMPROVE_ENDURANCE');
insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '박채원', '021020-4024680', '010-0011-2233', 'parkchaewon', '1111', 'chaewon.park@example.com', '채원팍', '강릉 교동광장로 100', sysdate, null, 'f', 167, 59, 'MAINTENANCE');

insert into tblUser (user_id, user_status_id, real_name, ssn, phone_number, username, password, email, nickname, address, regdate, deleted_at, gender, height, weight, health_goals)
    values (seqUser.nextVal, 1, '박채원', '021020-4024680', '010-0011-2233', 'park', '1111', 'chaewon.park@example.com', '채원팍', '강릉 교동광장로 100', sysdate, null, 'f', 167, 59, 'MAINTENANCE');
    
commit;


-- 핫딜 게시판



CREATE TABLE tblHotDealcategory (
	hotdeal_category_id	number	PRIMARY KEY,
	hotdeal_category	varchar2(100)	NULL
);

select * from tblhotdealpost;


CREATE TABLE tblHotDealPost (
    hotdeal_id              number PRIMARY KEY,
    user_id                 number NOT NULL REFERENCES tblUser(user_id),
    hotdeal_category_id     number NOT NULL REFERENCES tblHotDealcategory(hotdeal_category_id),
    hotdeal_status_id     number NOT NULL REFERENCES tblHotDealStatus(hotdeal_status_id),
    hotdeal_title           varchar2(300) NOT NULL,
    hotdeal_content         clob NOT NULL,
    hotdeal_name            varchar2(300),
    hotdeal_price           number,
    hotdeal_url             varchar2(1000),
    hotdeal_view_count      number NOT NULL,
    hotdeal_report_count    number DEFAULT 0 NOT NULL,
    hotdeal_report_status   char(1) NOT NULL,
    hotdeal_regdate         date NOT NULL
);



CREATE TABLE tblHotDealComment (
	hotdeal_comment_id	number PRIMARY KEY,
	user_id	number NOT NULL REFERENCES tblUser(user_id),
	hotdeal_id	number NOT NULL REFERENCES tblHotDealPost(hotdeal_id),
	hotdeal_comment_content	varchar2(200)	NOT NULL,
	hotdeal_comment_regdate	date	NOT NULL,
	hotdeal_comment_report_count	number	DEFAULT 0 NOT NULL,
	hotdeal_comment_status	char(1)	NOT NULL
);

CREATE TABLE tblHotDealImage (
	hotdeal_image_id	number	PRIMARY KEY,
	hotdeal_id	number NOT NULL REFERENCES tblHotDealPost(hotdeal_id),
	hotdeal_image_url	varchar2(100)	NULL,
	hotdeal_image_seq	number	NULL
);

CREATE TABLE tblHotDealLikes (
    hotdeal_id NUMBER NOT NULL REFERENCES tblHotDealPost(hotdeal_id),
    user_id    NUMBER NOT NULL REFERENCES tblUser(user_id),
    CONSTRAINT PK_HOTDEALLIKES PRIMARY KEY (hotdeal_id, user_id)
);

CREATE TABLE tblHotDealScrap (
	hotdeal_scrap_id number	PRIMARY KEY,
	hotdeal_id NUMBER NOT NULL REFERENCES tblHotDealPost(hotdeal_id),
    user_id    NUMBER NOT NULL REFERENCES tblUser(user_id)
);

CREATE TABLE tblHotDealStatus (
    hotdeal_status_id    number    PRIMARY KEY,
    hotdeal_status    varchar2(100)    NULL
);



-----------------------------핫딜 insert-------------------------------------------------------

insert into tblHotDealStatus (hotdeal_status_id, hotdeal_status) values (1, '판매예정');
insert into tblHotDealStatus (hotdeal_status_id, hotdeal_status) values (2, '진행중');
insert into tblHotDealStatus (hotdeal_status_id, hotdeal_status) values (3, '판매종료');

insert into tblHotDealcategory (hotdeal_category_id, hotdeal_category) values (1, '잡화');
insert into tblHotDealcategory (hotdeal_category_id, hotdeal_category) values (2, '전자기기·액세서리');
insert into tblHotDealcategory (hotdeal_category_id, hotdeal_category) values (3, '세면·뷰티');
insert into tblHotDealcategory (hotdeal_category_id, hotdeal_category) values (4, '수납·안전용품');
insert into tblHotDealcategory (hotdeal_category_id, hotdeal_category) values (5, 'e쿠폰·입장권');
insert into tblHotDealcategory (hotdeal_category_id, hotdeal_category) values (6, '아웃도어·캠핑');

select * from tblhotdealcategory;


-- =================================================================================
-- Set 1: 여행용 압축 파우치
-- =================================================================================
-- 게시물
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) 
VALUES (seqHotDealPost.nextVal, 7, 4, 1, '캐리어 공간 2배 활용! 여행용 압축 파우치 6종 세트', '의류, 소지품의 부피를 50% 이상 줄여주는 마법의 아이템! 지퍼로 간편하게 압축하여 캐리어 공간을 효율적으로 사용하세요. 방수 재질이라 더욱 안심!', '트래블이지 압축 파우치', 17900, 'https://example.com/deals/packingcubes', 1150, 'N', sysdate - 10);
-- 이미지
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '1.jpg', 1);
-- 댓글
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 11, seqHotDealPost.currVal, '이거 진짜 물건입니다. 캐리어 공간이 2배가 돼요.', sysdate - 9, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 19, seqHotDealPost.currVal, '곧 유럽 여행가는데 구매했습니다. 기대되네요!', sysdate - 9, 'A');


-- =================================================================================
-- Set 2: 멀티 어댑터
-- =================================================================================
-- 게시물
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) 
VALUES (seqHotDealPost.nextVal, 2, 2, 1, '[전세계 공용] USB-C 포트 지원 만능 멀티 어댑터', '이거 하나면 전세계 150개국 어디서든 충전 가능! USB-C 포트 1개, USB-A 포트 3개를 동시 지원하여 여러 기기를 한번에 충전할 수 있습니다.', '월드트래블 멀티 어댑터', 22500, 'https://example.com/deals/adapter', 2430, 'N', sysdate - 9);
-- 이미지
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '2.jpg', 1);
-- 댓글
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 1, seqHotDealPost.currVal, '해외 출장 잦은데 필수품입니다. 가격 좋네요.', sysdate - 8, 'A');


-- =================================================================================
-- Set 3: 목베개
-- =================================================================================
-- 게시물
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) 
VALUES (seqHotDealPost.nextVal, 15, 1, 1, '메모리폼 저반발 항공기용 목베개 1+1 특가', '장시간 비행의 피로를 확 줄여주는 저반발 메모리폼 목베개입니다. 전용 파우치에 넣어 휴대도 간편합니다.', '에어슬립 목베개', 19900, 'https://example.com/deals/neckpillow', 980, 'N', sysdate - 9);
-- 이미지
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '3.jpg', 1);
-- 댓글
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 8, seqHotDealPost.currVal, '이거 쓰면 이코노미가 비즈니스 됩니다 ㅋㅋ', sysdate - 8, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 14, seqHotDealPost.currVal, '커버 분리해서 세탁 가능한가요?', sysdate - 8, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 15, seqHotDealPost.currVal, '네 커버 분리 가능하다고 상세페이지에 나와있네요!', sysdate - 7, 'A');


-- =================================================================================
-- Set 4: 휴대용 손저울
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 18, 2, 1, '수화물 무게 초과 걱정 끝! 휴대용 캐리어 손저울', '공항에서 짐 풀고 싸는 수고를 덜어줍니다. 최대 50kg까지 측정 가능.', '이지체크 디지털 손저울', 8900, 'https://example.com/deals/scale', 1500, 'N', sysdate - 8);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '4.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 3, seqHotDealPost.currVal, '쇼핑 많이 하는 분들께는 필수템이죠.', sysdate - 7, 'A');

-- =================================================================================
-- Set 5: 여권 케이스
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 20, 1, 1, 'RFID 차단 기능성 가죽 여권케이스 40% 할인', '개인정보 유출을 막아주는 RFID 차단 필름 내장. 항공권, 카드 수납도 가능합니다.', '시큐어 여권지갑', 14500, 'https://example.com/deals/passportcase', 880, 'N', sysdate - 8);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '5.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 10, seqHotDealPost.currVal, '색상 고민되네요. 그린 색상 실물 어떤가요?', sysdate - 7, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 6, seqHotDealPost.currVal, '품절되기 전에 빨리 사야겠어요!', sysdate - 6, 'A');

-- =================================================================================
-- Set 6: 여행용 세면도구 세트
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 1, 3, 1, '기내반입 가능 사이즈! 여행용 올인원 워시 세트', '샴푸, 린스, 바디워시, 폼클렌징을 한번에! 100ml 이하 용량으로 기내 반입도 OK.', '트래블키트 올인원', 12900, 'https://example.com/deals/washkit', 1340, 'N', sysdate - 7);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '6.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 16, seqHotDealPost.currVal, '이거 하나면 세면도구 걱정 없겠네요.', sysdate - 6, 'A');

-- =================================================================================
-- Set 7: 접이식 백팩
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 13, 6, 1, '주머니에 쏙! 초경량 방수 접이식 백팩', '여행 중 늘어난 짐을 보관하거나 가볍게 외출할 때 사용하기 좋은 보조가방입니다. 접으면 한 손에 들어와요.', '포켓 백팩', 11000, 'https://example.com/deals/foldablebag', 950, 'N', sysdate - 7);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '7.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 4, seqHotDealPost.currVal, '하나 사서 정말 잘 쓰고 있습니다. 강추!', sysdate - 6, 'A');

-- =================================================================================
-- Set 8: 방수 스마트폰 파우치
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 5, 4, 1, '물놀이 필수템! 3중 잠금 스마트폰 방수팩 1+1', 'IPX8 최고 등급 방수. 파우치에 넣은 채로 터치, 통화, 사진 촬영 모두 가능합니다.', '아쿠아 방수팩', 9900, 'https://example.com/deals/waterproofpouch', 2100, 'N', sysdate - 6);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '8.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 17, seqHotDealPost.currVal, '휴양지 가는데 딱이네요. 감사합니다.', sysdate - 5, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 9, seqHotDealPost.currVal, '갤럭시 S23 울트라도 들어가나요?', sysdate - 5, 'A');

-- =================================================================================
-- Set 9: 여행용 자물쇠
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 11, 4, 1, '미국 교통안전청 인증 TSA 와이어 자물쇠 2개 세트', '가방 손상 없이 세관 검사 가능한 TSA 인증 자물쇠. 와이어 타입이라 어디든 걸기 편해요.', 'TSA 락 와이어 자물쇠', 10500, 'https://example.com/deals/tsalock', 1020, 'N', sysdate - 5);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '9.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 12, seqHotDealPost.currVal, '유럽 소매치기 방지용으로 구매합니다.', sysdate - 4, 'A');

-- =================================================================================
-- Set 10: 수면안대/귀마개 세트
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 4, 1, 1, '빛/소음 완벽 차단! 3D 수면안대 귀마개 세트', '눈에 압박이 없는 인체공학적 3D 디자인의 수면 안대와 소음 차단 귀마개 세트입니다.', '꿀잠 수면세트', 7500, 'https://example.com/deals/sleepmask', 650, 'N', sysdate - 5);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '10.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 21, seqHotDealPost.currVal, '이거 하고 비행기 타면 기절 가능', sysdate - 4, 'A');

-- =================================================================================
-- Set 11: 스포츠 타올
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 16, 6, 1, '빠른 건조! 초극세사 스포츠 타올 (전용 케이스 증정)', '일반 타올보다 흡수력 3배, 건조 속도 5배! 부피가 작아 여행, 운동 시 휴대하기 좋습니다.', '퀵드라이 스포츠 타올', 6900, 'https://example.com/deals/quickdrytowel', 1420, 'N', sysdate - 4);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '11.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 5, seqHotDealPost.currVal, '동남아 여행갈 때 유용하게 썼어요.', sysdate - 3, 'A');

-- =================================================================================
-- Set 12: 휴대용 약통
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 9, 4, 1, '요일별 분리 수납! 휴대용 알약 케이스', '여행 중 비타민, 상비약을 잊지 않도록 요일별로 관리하세요. 칸막이 분리도 가능합니다.', '위클리 약통', 4500, 'https://example.com/deals/pillcase', 480, 'N', sysdate - 4);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '12.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 2, seqHotDealPost.currVal, '부모님 여행 선물로 하나 사드렸습니다.', sysdate - 3, 'A');

-- =================================================================================
-- Set 13: 노이즈 캔슬링 헤드폰
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 10, 2, 1, '[역대급 할인] XYZ 노이즈 캔슬링 블루투스 헤드폰', '비행기 소음 완벽 차단! 몰입의 즐거움을 느껴보세요. 1회 충전 시 최대 30시간 사용 가능.', 'XYZ-700N 헤드폰', 189000, 'https://example.com/deals/headphones', 5200, 'N', sysdate - 3);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '13.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 7, seqHotDealPost.currVal, '가격이 좀 있지만 삶의 질이 달라집니다.', sysdate - 2, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 18, seqHotDealPost.currVal, '이거 보고 바로 질렀습니다...텅장', sysdate - 2, 'A');

-- =================================================================================
-- Set 14: 캐리어 벨트
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 6, 1, 1, '내 캐리어 눈에 확 띄는 컬러풀 캐리어 벨트', '수화물 찾을 때 헤맬 필요 없어요! 튼튼한 버클로 캐리어가 터지는 것을 방지해줍니다.', '컬러팝 캐리어 벨트', 5900, 'https://example.com/deals/luggagebelt', 910, 'N', sysdate - 3);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '14.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 1, seqHotDealPost.currVal, '검정 캐리어 쓰는 사람에게는 필수', sysdate - 2, 'A');

-- =================================================================================
-- Set 15: 셀카봉 삼각대
-- =================================================================================
INSERT INTO tblHotDealPost (hotdeal_id, user_id, hotdeal_category_id, hotdeal_status_id, hotdeal_title, hotdeal_content, hotdeal_name, hotdeal_price, hotdeal_url, hotdeal_view_count, hotdeal_report_status, hotdeal_regdate) VALUES (seqHotDealPost.nextVal, 21, 2, 1, '블루투스 리모컨 포함! 3 in 1 셀카봉 삼각대', '셀카봉, 삼각대 기능을 하나로! 최대 1m까지 늘어나며 블루투스 리모컨으로 원격 촬영이 가능합니다.', '포토프로 셀카봉', 18000, 'https://example.com/deals/selfiestick', 3120, 'N', sysdate - 2);
INSERT INTO tblHotDealImage (hotdeal_image_id, hotdeal_id, hotdeal_image_url, hotdeal_image_seq) VALUES (seqHotDealImage.nextVal, seqHotDealPost.currVal, '15.jpg', 1);
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 13, seqHotDealPost.currVal, '인생샷 건지려면 꼭 필요하죠.', sysdate - 1, 'A');
INSERT INTO tblHotDealComment (hotdeal_comment_id, user_id, hotdeal_id, hotdeal_comment_content, hotdeal_comment_regdate, hotdeal_comment_status) VALUES (seqHotDealComment.nextVal, 8, seqHotDealPost.currVal, '리모컨 배터리는 뭘로 교체하나요?', sysdate - 1, 'A');











--  조인 

--핫딜게시판 댓글 조인
CREATE OR REPLACE VIEW vw_hotdeal_comment AS
SELECT
  c.hotdeal_comment_id,
  c.hotdeal_id,
  c.user_id,
  u.username   AS user_login,
  u.real_name       AS user_name,
  c.hotdeal_comment_content AS content,
  c.hotdeal_comment_regdate AS regdate,
  c.hotdeal_comment_report_count,
  c.hotdeal_comment_status
FROM tblHotDealComment c
JOIN tblUser u
  ON u.user_id = c.user_id;
  
  select * from tblhotdealcomment;
  select * from tblhotdealpost;
  select * from tblhotdealpost;



--**************activity_code:각 경로에 맞춰 수정해야함*******************************
--전체 게시판 댓글 조인
CREATE OR REPLACE VIEW vwUserAllActivities AS
SELECT
    activity_type,
    activity_code,
    bseq,
    title,
    regdate,
    user_id
FROM (
    SELECT
        '질문게시판' AS activity_type,
        'qna' AS activity_code,
        question_board_id AS bseq,
        question_board_title AS title,
        question_board_regdate AS regdate,
        user_id
    FROM
        tblQuestionBoard
    UNION ALL
    SELECT
        '경로게시판' AS activity_type,
        'rou' AS activity_code,
        routepost_id AS bseq,
        routepost_title AS title,
        routepost_regdate AS regdate,
        user_id
    FROM
        tblRoutePost
    UNION ALL
    SELECT
        '후기게시판' AS activity_type,
        'review' AS activity_code,
        review_post_id AS bseq,
        review_board_title AS title,
        review_board_regdate AS regdate,
        user_id
    FROM
        tblReviewBoard
    UNION ALL
    SELECT
        '동행게시판' AS activity_type,
        'find' AS activity_code,
        find_board_id AS bseq,
        find_board_title AS title,
        find_board_regdate AS regdate,
        user_id
    FROM
        tblFindBoard
    UNION ALL
    SELECT
        '핫딜게시판' AS activity_type,
        'view' AS activity_code,
        hotdeal_id AS bseq,
        hotdeal_title AS title,
        hotdeal_regdate AS regdate,
        user_id
    FROM
        tblHotDealPost
    UNION ALL
    SELECT
        '신고게시판' AS activity_type,
        'report' AS activity_code,
        report_id AS bseq,
        '[신고] ' || report_target_type || ' (대상ID: ' || report_target_id || ')' AS title,
        report_regdate AS regdate,
        user_id
    FROM
        tblReports
);

--게시판 댓글 조인(마이페이지 댓글용)
----------------------------------------예빈이 게시판데이터 넣고 넣기 'qna'이름 바꾸기

CREATE OR REPLACE VIEW vwuserallcomments AS
-- 1. 질문게시판 답변 + 원본 게시물 정보
SELECT
    '질문게시판' AS comment_type,
    'qna' AS activity_code,
    qa.question_answer_id AS comment_id,
    qa.question_board_id AS parent_post_id,
    qa.question_answer_content AS content,
    qa.question_answer_regdate AS regdate,
    qa.user_id,
    qb.question_board_title AS parent_post_title, -- ◀ 원본 게시물 제목
    qb.question_board_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblQuestionAnswer qa
LEFT JOIN
    tblQuestionBoard qb ON qa.question_board_id = qb.question_board_id

UNION ALL

-- 2. 여행경로 댓글 + 원본 게시물 정보
SELECT
    '경로게시판' AS comment_type,
    'rou' AS activity_code,
    rpc.routepost_comment_id AS comment_id,
    rpc.routepost_id AS parent_post_id,
    rpc.routepost_comment_content AS content,
    rpc.routepost_comment_regdate AS regdate,
    rpc.user_id,
    rp.routepost_title AS parent_post_title, -- ◀ 원본 게시물 제목
    rp.routepost_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblRoutePostComment rpc
LEFT JOIN
    tblRoutePost rp ON rpc.routepost_id = rp.routepost_id

UNION ALL

-- 3. 후기게시판 댓글 + 원본 게시물 정보
SELECT
    '후기게시판' AS comment_type,
    'review' AS activity_code,
    rc.review_comment_id AS comment_id,
    rc.review_post_id AS parent_post_id,
    rc.review_comment_content AS content,
    rc.review_comment_regdate AS regdate,
    rc.user_id,
    rb.review_board_title AS parent_post_title, -- ◀ 원본 게시물 제목
    rb.review_board_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblReviewComment rc
LEFT JOIN
    tblReviewBoard rb ON rc.review_post_id = rb.review_post_id

UNION ALL

-- 4. 동행찾기 댓글 + 원본 게시물 정보
SELECT
    '동행게시판' AS comment_type,
    'find' AS activity_code,
    fc.find_comment_id AS comment_id,
    fc.find_board_id AS parent_post_id,
    fc.find_comment_content AS content,
    fc.find_comment_regdate AS regdate,
    fc.user_id,
    fb.find_board_title AS parent_post_title, -- ◀ 원본 게시물 제목
    fb.find_board_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblFindComment fc
LEFT JOIN
    tblFindBoard fb ON fc.find_board_id = fb.find_board_id

UNION ALL

-- 5. 핫딜게시판 댓글 + 원본 게시물 정보
SELECT
    '핫딜게시판' AS comment_type,
        'view' AS activity_code,
    hc.hotdeal_comment_id AS comment_id,
    hc.hotdeal_id AS parent_post_id,
    hc.hotdeal_comment_content AS content,
    hc.hotdeal_comment_regdate AS regdate,
    hc.user_id,
    hp.hotdeal_title AS parent_post_title, -- ◀ 원본 게시물 제목
    hp.hotdeal_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblHotDealComment hc
LEFT JOIN
    tblHotDealPost hp ON hc.hotdeal_id = hp.hotdeal_id;

SELECT
    parent_post_id,
    activity_code,
    comment_type,
    content,
    regdate,
    parent_post_title,
    parent_post_regdate
FROM
    vwUserAllComments   
WHERE
    user_id = 1
ORDER BY regdate DESC;
-----------------------------------------------------------------------------------------------------------------------------------------------예빈이 넣고 생각하면서 넣기

--게시판 댓글 조인(마이페이지 댓글용)
--**************activity_code:각 경로에 맞춰 수정해야함*******************************
CREATE OR REPLACE VIEW vwuserallcomments AS
-- 1. 질문게시판 답변 + 원본 게시물 정보
SELECT
    '질문게시판' AS comment_type,
    'qna' AS activity_code,
    qa.question_answer_id AS comment_id,
    qa.question_board_id AS parent_post_id,
    qa.question_answer_content AS content,
    qa.question_answer_regdate AS regdate,
    qa.user_id,
    qb.question_board_title AS parent_post_title, -- ◀ 원본 게시물 제목
    qb.question_board_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblQuestionAnswer qa
LEFT JOIN
    tblQuestionBoard qb ON qa.question_board_id = qb.question_board_id

UNION ALL

-- 2. 여행경로 댓글 + 원본 게시물 정보
SELECT
    '경로게시판' AS comment_type,
    'rou' AS activity_code,
    rpc.routepost_comment_id AS comment_id,
    rpc.routepost_id AS parent_post_id,
    rpc.routepost_comment_content AS content,
    rpc.routepost_comment_regdate AS regdate,
    rpc.user_id,
    rp.routepost_title AS parent_post_title, -- ◀ 원본 게시물 제목
    rp.routepost_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblRoutePostComment rpc
LEFT JOIN
    tblRoutePost rp ON rpc.routepost_id = rp.routepost_id

UNION ALL

-- 3. 후기게시판 댓글 + 원본 게시물 정보
SELECT
    '후기게시판' AS comment_type,
    'review' AS activity_code,
    rc.review_comment_id AS comment_id,
    rc.review_post_id AS parent_post_id,
    rc.review_comment_content AS content,
    rc.review_comment_regdate AS regdate,
    rc.user_id,
    rb.review_board_title AS parent_post_title, -- ◀ 원본 게시물 제목
    rb.review_board_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblReviewComment rc
LEFT JOIN
    tblReviewBoard rb ON rc.review_post_id = rb.review_post_id

UNION ALL

-- 4. 동행찾기 댓글 + 원본 게시물 정보
SELECT
    '동행게시판' AS comment_type,
    'find' AS activity_code,
    fc.find_comment_id AS comment_id,
    fc.find_board_id AS parent_post_id,
    fc.find_comment_content AS content,
    fc.find_comment_regdate AS regdate,
    fc.user_id,
    fb.find_board_title AS parent_post_title, -- ◀ 원본 게시물 제목
    fb.find_board_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblFindComment fc
LEFT JOIN
    tblFindBoard fb ON fc.find_board_id = fb.find_board_id

UNION ALL

-- 5. 핫딜게시판 댓글 + 원본 게시물 정보
SELECT
    '핫딜게시판' AS comment_type,
        'view' AS activity_code,
    hc.hotdeal_comment_id AS comment_id,
    hc.hotdeal_id AS parent_post_id,
    hc.hotdeal_comment_content AS content,
    hc.hotdeal_comment_regdate AS regdate,
    hc.user_id,
    hp.hotdeal_title AS parent_post_title, -- ◀ 원본 게시물 제목
    hp.hotdeal_regdate AS parent_post_regdate -- ◀ 원본 게시물 작성일
FROM
    tblHotDealComment hc
LEFT JOIN
    tblHotDealPost hp ON hc.hotdeal_id = hp.hotdeal_id;

SELECT
    parent_post_id,
    activity_code,
    comment_type,
    content,
    regdate,
    parent_post_title,
    parent_post_regdate
FROM
    vwUserAllComments   
WHERE
    user_id = 1
ORDER BY regdate DESC;


--게시판 좋아요 조인(마이페이지용)
--**************board_type:각 경로에 맞춰 수정해야함*******************************
CREATE OR REPLACE VIEW vwUserAllLikes AS
SELECT
    l.user_id,                          -- 좋아요 누른 유저 ID
    'question' AS board_type,           -- 게시판 종류
    '질문게시판' AS board_name,           -- 게시판 이름
    b.question_board_id AS post_id,     -- 게시물 ID
    b.question_board_title AS post_title, -- 게시물 제목
    b.question_board_regdate AS regdate -- 게시물 생성일
FROM
    tblQuestionLike l
JOIN
    tblQuestionBoard b ON l.question_board_id = b.question_board_id

UNION ALL

SELECT
    l.user_id,
    'route' AS board_type,
    '경로게시판' AS board_name,
    b.routepost_id AS post_id,
    b.routepost_title AS post_title,
    b.routepost_regdate AS regdate
FROM
    tblRoutePostLikes l
JOIN
    tblRoutePost b ON l.routepost_id = b.routepost_id

UNION ALL

SELECT
    l.user_id,
    'review' AS board_type,
    '후기게시판' AS board_name,
    b.review_post_id AS post_id,
    b.review_board_title AS post_title,
    b.review_board_regdate AS regdate
FROM
    tblReviewLike l
JOIN
    tblReviewBoard b ON l.review_post_id = b.review_post_id

UNION ALL

SELECT
    l.user_id,
    'find' AS board_type,
    '동행게시판' AS board_name,
    b.find_board_id AS post_id,
    b.find_board_title AS post_title,
    b.find_board_regdate AS regdate
FROM
    tblFindLikes l
JOIN
    tblFindBoard b ON l.find_board_id = b.find_board_id

UNION ALL

SELECT
    l.user_id,
    'view' AS board_type,
    '핫딜게시판' AS board_name,
    b.hotdeal_id AS post_id,
    b.hotdeal_title AS post_title,
    b.hotdeal_regdate AS regdate
FROM
    tblHotDealLikes l
JOIN
    tblHotDealPost b ON l.hotdeal_id = b.hotdeal_id;
    






--게시판 스크랩 조인(마이페이지용)
--**************content_type:각 경로에 맞춰 수정해야함*******************************
CREATE OR REPLACE VIEW vwAllScraps AS
-- 1. 핫딜 게시판
SELECT 
    s.hotdeal_scrap_id AS scrap_id,
    s.user_id,
    'view' AS content_type,
    s.hotdeal_id AS content_id,
    '핫딜게시판' AS board_name,
    p.hotdeal_title AS post_title,
    p.hotdeal_regdate AS post_regdate
FROM 
    tblHotDealScrap s
JOIN 
    tblHotDealPost p ON s.hotdeal_id = p.hotdeal_id
    
UNION ALL

-- 2. 질문 게시판
SELECT 
    s.question_scrap_id AS scrap_id,
    s.user_id,
    'question' AS content_type,
    s.question_board_id AS content_id,
    '질문게시판' AS board_name,
    p.question_board_title AS post_title,
    p.question_board_regdate AS post_regdate
FROM 
    tblQuestionScrap s
JOIN 
    tblQuestionBoard p ON s.question_board_id = p.question_board_id

UNION ALL

-- 3. 여행 경로 게시판
SELECT 
    s.routepost_scrap_id AS scrap_id,
    s.user_id,
    'route' AS content_type,
    s.routepost_id AS content_id,
    '경로게시판' AS board_name,
    p.routepost_title AS post_title,
    p.routepost_regdate AS post_regdate
FROM 
    tblRoutePostScrap s
JOIN 
    tblRoutePost p ON s.routepost_id = p.routepost_id

UNION ALL

-- 4. 리뷰 게시판
SELECT 
    s.review_scrap_id AS scrap_id,
    s.user_id,
    'review' AS content_type,
    s.review_post_id AS content_id,
    '리뷰게시판' AS board_name,
    p.review_board_title AS post_title,
    p.review_board_regdate AS post_regdate
FROM 
    tblReviewScrap s
JOIN 
    tblReviewBoard p ON s.review_post_id = p.review_post_id

UNION ALL

-- 5. 동행 찾기 게시판
SELECT 
    s.find_scrap_id AS scrap_id,
    s.user_id,
    'find' AS content_type,
    s.find_board_id AS content_id,
    '동행게시판' AS board_name,
    p.find_board_title AS post_title,
    p.find_board_regdate AS post_regdate
FROM 
    tblFindScrap s
JOIN 
    tblFindBoard p ON s.find_board_id = p.find_board_id;
    



-- 랜터카 예약 뷰(마이페이지)
CREATE OR REPLACE VIEW vwCarReservationDetails AS
SELECT
    r.reservation_id,
    r.user_id,
    cr.status_id,
    rs.status_name,
    cr.car_reservation_id,
    cr.pickup_date,
    cr.dropoff_date,
    cr.pickup_location,
    cr.dropoff_location,
    cr.car_total_price,
    cr.car_notes,
    rt.car_type,
    rt.car_fuel_type,
    rt.car_name
    
FROM
    tblCarReservation cr
    INNER JOIN tblReservation r ON cr.reservation_id = r.reservation_id
    INNER JOIN tblReservationStatus rs ON cr.status_id = rs.status_id
    INNER JOIN tblRentalCar rt ON cr.car_id = rt.car_id;


--숙소 예약 조인(마이페이지)
CREATE OR REPLACE VIEW vwAccomReservAtionDetails AS
SELECT
    r.reservation_id,
    r.user_id,
    ar.status_id,
    ar.room_total_price,
    ar.accom_reservation_id,
    arm.room_name,
    p.place_name,
    p.place_address,
    arm.room_type,
    a.accom_type,
    ar.guest_count,
    ar.checkin_date,
    ar.checkout_date
FROM
    tblAccomReservation ar
    INNER JOIN tblReservation r ON ar.reservation_id = r.reservation_id
    INNER JOIN tblAccomRoom arm ON ar.room_id = arm.room_id
    INNER JOIN tblAccom a ON arm.accom_id = a.accom_id
    INNER JOIN tblPlace p ON p.place_id = a.place_id;
    


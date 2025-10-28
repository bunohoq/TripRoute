--------------------------------------------------------------
---- ⚙️ 1. 기존 데이터 / 테이블 제거
--------------------------------------------------------------
--BEGIN
--    EXECUTE IMMEDIATE 'DROP TABLE tblCarReservation CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblAccomReservation CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblReservation CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblRentalCar CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblAccomRoom CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblAccom CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblPlace CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblPlaceType CASCADE CONSTRAINTS';
--    EXECUTE IMMEDIATE 'DROP TABLE tblPlaceLocation CASCADE CONSTRAINTS';
--EXCEPTION
--    WHEN OTHERS THEN NULL;
--END;
--/
--------------------------------------------------------------
---- ⚙️ 2. 시퀀스 제거
--------------------------------------------------------------
--BEGIN
--    EXECUTE IMMEDIATE 'DROP SEQUENCE seqPlace';
--    EXECUTE IMMEDIATE 'DROP SEQUENCE seqAccom';
--    EXECUTE IMMEDIATE 'DROP SEQUENCE seqAccomRoom';
--    EXECUTE IMMEDIATE 'DROP SEQUENCE seqRentalCar';
--    EXECUTE IMMEDIATE 'DROP SEQUENCE seqReservation';
--EXCEPTION
--    WHEN OTHERS THEN NULL;
--END;
--/

------------------------------------------------------------
-- 🧭 3. 지역 테이블
------------------------------------------------------------
CREATE TABLE tblPlaceLocation (
    place_location_id   NUMBER PRIMARY KEY,
    location_name       VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE seqPlaceLocation;

------------------------------------------------------------
-- 🏷 4. 장소유형 테이블
------------------------------------------------------------
CREATE TABLE tblPlaceType (
    place_type_id   NUMBER PRIMARY KEY,
    place_type_name VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE seqPlaceType;

------------------------------------------------------------
-- 🏙 5. 장소 기본정보 (숙소 등)
------------------------------------------------------------
CREATE TABLE tblPlace (
    place_id              NUMBER PRIMARY KEY,
    place_type_id         NUMBER NOT NULL,
    place_location_id     NUMBER NOT NULL,
    place_name            VARCHAR2(200) NOT NULL,
    place_address         VARCHAR2(400) NOT NULL,
    place_lat             NUMBER NOT NULL,
    place_lng             NUMBER NOT NULL,
    place_main_image_url  VARCHAR2(500) DEFAULT 'https://cdn.pixabay.com/photo/2016/11/18/15/07/hotel-1831072_1280.jpg',
    place_description     VARCHAR2(1000),
    CONSTRAINT fk_place_type FOREIGN KEY (place_type_id) REFERENCES tblPlaceType(place_type_id),
    CONSTRAINT fk_place_location FOREIGN KEY (place_location_id) REFERENCES tblPlaceLocation(place_location_id)
);

CREATE SEQUENCE seqPlace;

------------------------------------------------------------
-- 🏨 6. 숙소 관리 테이블
------------------------------------------------------------
CREATE TABLE tblAccom (
    accom_id      NUMBER PRIMARY KEY,
    place_id      NUMBER NOT NULL,
    accom_type    VARCHAR2(50) DEFAULT '호텔' NOT NULL,
    accom_tel     VARCHAR2(50),
    accom_regdate DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_accom_place FOREIGN KEY (place_id) REFERENCES tblPlace(place_id)
);

CREATE SEQUENCE seqAccom;

------------------------------------------------------------
-- 🛏️ 7. 객실 테이블
------------------------------------------------------------
CREATE TABLE tblAccomRoom (
    room_id         NUMBER PRIMARY KEY,
    accom_id        NUMBER NOT NULL,
    room_name       VARCHAR2(100) NOT NULL,
    room_type       VARCHAR2(50) DEFAULT '스탠다드' NOT NULL,
    capacity        NUMBER DEFAULT 2 NOT NULL,
    price_per_night NUMBER DEFAULT 0 NOT NULL,
    room_area       VARCHAR2(50),
    room_image_url  VARCHAR2(500) DEFAULT 'https://cdn.pixabay.com/photo/2017/03/28/12/13/hotel-room-2182652_1280.jpg',
    room_status     CHAR(1) DEFAULT 'y' NOT NULL,
    room_regdate    DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_room_accom FOREIGN KEY (accom_id) REFERENCES tblAccom(accom_id)
);

CREATE SEQUENCE seqAccomRoom;

------------------------------------------------------------
-- 🚗 8. 차량 테이블
------------------------------------------------------------
CREATE TABLE tblRentalCar (
    car_id              NUMBER PRIMARY KEY,
    place_location_id   NUMBER NOT NULL,
    car_name            VARCHAR2(100) NOT NULL,
    car_type            VARCHAR2(50) DEFAULT '세단' NOT NULL,
    car_number          VARCHAR2(30) UNIQUE NOT NULL,
    car_fuel_type       VARCHAR2(30) DEFAULT '휘발유' NOT NULL,
    car_seats           NUMBER DEFAULT 5 NOT NULL,
    car_price_per_day   NUMBER DEFAULT 0 NOT NULL,
    car_image_url       VARCHAR2(500) DEFAULT 'https://cdn.pixabay.com/photo/2016/11/22/19/14/car-1846911_1280.jpg',
    car_status          CHAR(1) DEFAULT 'y' NOT NULL,
    car_regdate         DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_car_location FOREIGN KEY (place_location_id) REFERENCES tblPlaceLocation(place_location_id)
);


CREATE SEQUENCE seqRentalCar;

-------------------------------------------------
-- 4️⃣ 예약 상태 테이블
-------------------------------------------------
CREATE TABLE tblReservationStatus (
    status_id       NUMBER          NOT NULL,
    status_name     VARCHAR2(50)    UNIQUE  NOT NULL,
    status_desc     VARCHAR2(500)   NULL,
    CONSTRAINT PK_tblReservationStatus PRIMARY KEY (status_id)
);

CREATE SEQUENCE seqReservationStatus START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

------------------------------------------------------------
-- 📅 9. 통합 예약 테이블 (tblUserRoute 테이블있어야함)
------------------------------------------------------------
CREATE TABLE tblReservation (
    reservation_id         NUMBER PRIMARY KEY,
    user_id                NUMBER NOT NULL,
    user_route_id          NUMBER,
    status_id              NUMBER NOT NULL,
    reservation_price      NUMBER DEFAULT 0 NOT NULL,
    reservation_start_date DATE NOT NULL,
    reservation_end_date   DATE NOT NULL,
    reservation_regdate    DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT FK_tblUser_TO_tblReservation 
        FOREIGN KEY (user_id) REFERENCES tblUser (user_id),
    CONSTRAINT FK_tblUserRoute_TO_tblReservation 
        FOREIGN KEY (user_route_id) REFERENCES tblUserRoute (user_route_id),
    CONSTRAINT FK_tblReservationStatus_TO_tblReservation 
        FOREIGN KEY (status_id) REFERENCES tblReservationStatus (status_id)
);

CREATE SEQUENCE seqReservation;

------------------------------------------------------------
-- 🏨 객실 예약 테이블
------------------------------------------------------------
CREATE TABLE tblAccomReservation (
    accom_reservation_id  NUMBER PRIMARY KEY,
    room_id               NUMBER NOT NULL,
    reservation_id        NUMBER NOT NULL,
    user_route_id         NUMBER NOT NULL,
    status_id             NUMBER NOT NULL,
    guest_count           NUMBER DEFAULT 2 NOT NULL,
    room_total_price      NUMBER DEFAULT 0 NOT NULL,
    checkin_date          DATE NOT NULL,
    checkout_date         DATE NOT NULL,
    accom_notes           VARCHAR2(500),

    CONSTRAINT fk_accom_reservation FOREIGN KEY (reservation_id)
        REFERENCES tblReservation(reservation_id),
    CONSTRAINT fk_accom_resv_status FOREIGN KEY (status_id)
        REFERENCES tblReservationStatus(status_id),
    CONSTRAINT fk_accom_resv_route FOREIGN KEY (user_route_id)
        REFERENCES tblUserRoute(user_route_id),
    CONSTRAINT fk_accom_resv_room FOREIGN KEY (room_id)
        REFERENCES tblAccomRoom(room_id)
);

CREATE SEQUENCE seqAccomReservation;



------------------------------------------------------------
-- 🚗 차량 예약 테이블
------------------------------------------------------------
CREATE TABLE tblCarReservation (
    car_reservation_id   NUMBER PRIMARY KEY,
    car_id               NUMBER,
    reservation_id       NUMBER NOT NULL,
    user_route_id        NUMBER NOT NULL,
    status_id            NUMBER NOT NULL,
    pickup_date          DATE,
    dropoff_date         DATE,
    pickup_location      VARCHAR2(300),
    dropoff_location     VARCHAR2(300),
    car_total_price      NUMBER DEFAULT 0 NOT NULL,
    car_notes            VARCHAR2(500),
    
    CONSTRAINT fk_car_reservation FOREIGN KEY (reservation_id)
        REFERENCES tblReservation(reservation_id),
    CONSTRAINT fk_car_resv_status FOREIGN KEY (status_id)
        REFERENCES tblReservationStatus(status_id),
    CONSTRAINT fk_car_resv_route FOREIGN KEY (user_route_id)
        REFERENCES tblUserRoute(user_route_id),
    CONSTRAINT fk_car FOREIGN KEY (car_id)
        REFERENCES tblRentalCar(car_id)
);

CREATE SEQUENCE seqCarReservation;


------------------------------------------------------------
-- 🌍 10 예약 상태 데이터
------------------------------------------------------------
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (1, '예약요청');
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (2, '결제완료');
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (3, '이용완료');
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (4, '취소');

------------------------------------------------------------
-- 🌍 10. 지역 데이터
------------------------------------------------------------
INSERT INTO tblPlaceLocation VALUES (1, '부산');
INSERT INTO tblPlaceLocation VALUES (2, '서울');
INSERT INTO tblPlaceLocation VALUES (3, '제주');
INSERT INTO tblPlaceLocation VALUES (4, '강릉');
INSERT INTO tblPlaceLocation VALUES (5, '대구');
INSERT INTO tblPlaceLocation VALUES (6, '전주');
INSERT INTO tblPlaceLocation VALUES (7, '인천');
INSERT INTO tblPlaceLocation VALUES (8, '여수');
INSERT INTO tblPlaceLocation VALUES (9, '울산');
INSERT INTO tblPlaceLocation VALUES (10, '수원');


select * from tblPlaceLocation;
------------------------------------------------------------
-- 🏨 12. 숙소 + 객실 데이터 (10개)
------------------------------------------------------------
select * from tblplace;
delete from tblplace;

-- 2. 해운대 센텀 호텔 (부산)
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '해운대 센텀 호텔', '부산광역시 해운대구 센텀1로 20', 35.1693, 129.1293, NULL, '부산 해운대 중심의 고급 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-720-9000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 트윈룸', '트윈룸', 2, 120000, '28㎡', NULL, 'y', SYSDATE);

-- 5. 라발스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '라발스 호텔 부산', '부산광역시 영도구 태종로 82', 35.0919, 129.0456, NULL, '부산항과 남포동을 조망할 수 있는 오션뷰 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-790-1500', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 디럭스룸', '더블룸', 2, 180000, '36㎡', NULL, 'y', SYSDATE);

-- 8. 파라다이스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '파라다이스 호텔 부산', '부산광역시 해운대구 해운대해변로 296', 35.1580, 129.1635, NULL, '해운대 해변 앞 럭셔리 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-742-2121', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 프리미어룸', '스위트룸', 3, 380000, '50㎡', NULL, 'y', SYSDATE);

-- 1. 라발스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '라발스 호텔 부산', '부산광역시 영도구 태종로 82', 35.0919, 129.0456, 'lavelz-hotel.jpg', '부산항과 남포동을 조망할 수 있는 오션뷰 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-790-1500', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 디럭스룸', '더블룸', 2, 180000, '36㎡', 'lavelz-room.jpg', 'y', SYSDATE);

-- 2. 파라다이스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '파라다이스 호텔 부산', '부산광역시 해운대구 해운대해변로 296', 35.1580, 129.1635, 'paradise-hotel.jpg', '해운대 해변 앞 럭셔리 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-742-2121', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 프리미어룸', '스위트룸', 3, 380000, '50㎡', 'paradise-room.jpg', 'y', SYSDATE);

-- 3. 해운대 센텀 호텔
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '해운대 센텀 호텔', '부산광역시 해운대구 센텀1로 20', 35.1693, 129.1293, 'centum-hotel.jpg', '부산 해운대 중심의 고급 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-720-9000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 트윈룸', '트윈룸', 2, 120000, '28㎡', 'centum-room.jpg', 'y', SYSDATE);

-- 4. 롯데호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '롯데호텔 부산', '부산광역시 부산진구 가야대로 772', 35.1560, 129.0593, 'lotte-hotel.jpg', '서면 중심의 5성급 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-810-1000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '프리미어 스위트', '스위트룸', 2, 420000, '55㎡', 'lotte-room.jpg', 'y', SYSDATE);

-- 5. 코모도 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '코모도 호텔 부산', '부산광역시 중구 중앙대로 151', 35.1048, 129.0331, 'komodo-hotel.jpg', '한국 전통미와 현대식 객실을 결합한 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-461-9741', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 온돌룸', '온돌룸', 3, 160000, '38㎡', 'komodo-room.jpg', 'y', SYSDATE);

-- 6. 시그니엘 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '시그니엘 부산', '부산광역시 해운대구 달맞이길 30', 35.1613, 129.1732, 'signiel-hotel.jpg', '해운대 해변을 조망할 수 있는 최고급 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-922-1000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션뷰 스위트룸', '스위트룸', 4, 550000, '60㎡', 'signiel-room.jpg', 'y', SYSDATE);

-- 7. 호텔 농심
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '호텔 농심', '부산광역시 동래구 금강공원로 20', 35.2218, 129.0825, 'nongsim-hotel.jpg', '온천장에 위치한 전통과 현대가 조화된 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-550-2100', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '스탠다드 더블룸', '더블룸', 2, 140000, '30㎡', 'nongsim-room.jpg', 'y', SYSDATE);

-- 8. 아난티 힐튼 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '아난티 힐튼 부산', '부산광역시 기장군 기장읍 기장해안로 268-32', 35.2418, 129.2229, 'hilton-hotel.jpg', '부산 대표 해안 리조트형 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-509-1111', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 디럭스룸', '더블룸', 3, 390000, '48㎡', 'hilton-room.jpg', 'y', SYSDATE);

-- 9. 베스트루이스 해운대
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '베스트루이스 해운대', '부산광역시 해운대구 구남로 20', 35.1592, 129.1598, 'bestlouis-hotel.jpg', '합리적인 가격의 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-743-7000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '스탠다드룸', '트윈룸', 2, 95000, '25㎡', 'bestlouis-room.jpg', 'y', SYSDATE);

-- 10. 라한호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 3, 1, '라한호텔 부산', '부산광역시 남구 문현동 860-1', 35.1335, 129.0850, 'lahan-hotel.jpg', '전망이 좋은 프리미엄 시티 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-700-8800', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 더블룸', '더블룸', 2, 170000, '35㎡', 'lahan-room.jpg', 'y', SYSDATE);


select * from tblaccom;
delete from tblaccom;
delete from tblaccomroom;

------------------------------------------------------------
-- 🚗 13. 차량 데이터 (10대)
------------------------------------------------------------
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '쏘나타', '세단', '12가3456', '휘발유', 5, 85000, 'sonata.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '그랜저', '세단', '23나5678', 'LPG', 5, 110000, 'grandeur.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '스포티지', 'SUV', '34다9876', '디젤', 5, 95000, 'sportage.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '카니발', '승합차', '45라2233', '디젤', 9, 135000, 'carnival.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '아반떼', '세단', '56마4321', '휘발유', 5, 70000, 'avante.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '팰리세이드', 'SUV', '67바8765', '디젤', 7, 125000, 'palisade.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '모닝', '경차', '78사1234', '휘발유', 4, 55000, 'morning.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, 'K5', '세단', '89아8888', '휘발유', 5, 80000, 'k5.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '투싼', 'SUV', '90자5555', '디젤', 5, 93000, 'tucson.jpg', 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '제네시스 G80', '세단', '91차7777', '휘발유', 5, 160000, 'genesis-g80.jpg', 'y', SYSDATE);

select * from tblrentalcar;
delete from tblrentalcar;

-- 기존 시퀀스 삭제
DROP SEQUENCE seqPlace;

-- 새로 생성 (100부터 시작)
CREATE SEQUENCE seqPlace
START WITH 200
INCREMENT BY 1
NOCACHE;

commit;

INSERT INTO tblUserRoute (
  user_route_id,
  user_id,
  source_ai_route_id,
  user_route_title,
  user_route_days,
  user_route_saved,
  user_route_region,
  user_route_startdate,
  user_route_enddate
) VALUES (
  seqUserRoute.NEXTVAL,    -- ① 새 user_route_id
  1,                       -- ② 로그인한 회원 번호
  26,                      -- ③ 원본 AI 루트 ID
  '부산 도심 힐링 연인 렌터카 2일 여행',  -- ④ 제목
  2,                       -- ⑤ 여행 일수
  SYSDATE,                 -- ⑥ 저장 일시 (혹은 TO_DATE 지정 가능)
  '부산',                  -- ⑦ 지역
  TO_DATE('2025-10-17','YYYY-MM-DD'),  -- ⑧ 여행 시작일
  TO_DATE('2025-10-18','YYYY-MM-DD')   -- ⑨ 여행 종료일
);



commit;
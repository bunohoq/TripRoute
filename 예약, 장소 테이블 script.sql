------------------------------------------------------------
-- ⚙️ 1. 기존 데이터 / 테이블 제거
------------------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE tblCarReservation CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblAccomReservation CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblReservation CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblRentalCar CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblAccomRoom CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblAccom CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblPlace CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblPlaceType CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE tblPlaceLocation CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
------------------------------------------------------------
-- ⚙️ 2. 시퀀스 제거
------------------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seqPlace';
    EXECUTE IMMEDIATE 'DROP SEQUENCE seqAccom';
    EXECUTE IMMEDIATE 'DROP SEQUENCE seqAccomRoom';
    EXECUTE IMMEDIATE 'DROP SEQUENCE seqRentalCar';
    EXECUTE IMMEDIATE 'DROP SEQUENCE seqReservation';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

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

Drop table tblPlaceType;
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
drop table tblReservationStatus;

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

------------------------------------------------------------
-- 🏷 11. 장소유형 데이터
------------------------------------------------------------
INSERT INTO tblPlaceType VALUES (1, '숙소');
INSERT INTO tblPlaceType VALUES (2, '관광지');
INSERT INTO tblPlaceType VALUES (3, '식당');
INSERT INTO tblPlaceType VALUES (4, '행사장');

------------------------------------------------------------
-- 🏨 12. 숙소 + 객실 데이터 (10개)
------------------------------------------------------------

-- 1. 서울 신라호텔
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 2, '서울 신라호텔', '서울특별시 중구 동호로 249', 37.5574, 127.0025, NULL, '전통과 품격의 서울 대표 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '02-2233-3131', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '프리미어 더블룸', '더블룸', 2, 350000, '46㎡', NULL, 'y', SYSDATE);

-- 2. 해운대 센텀 호텔 (부산)
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '해운대 센텀 호텔', '부산광역시 해운대구 센텀1로 20', 35.1693, 129.1293, NULL, '부산 해운대 중심의 고급 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-720-9000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 트윈룸', '트윈룸', 2, 120000, '28㎡', NULL, 'y', SYSDATE);

-- 3. 해비치 리조트 제주
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 3, '해비치 리조트 제주', '제주특별자치도 서귀포시 표선면 민속해안로 537', 33.3234, 126.8412, NULL, '제주 대표 럭셔리 리조트.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '리조트', '064-780-8000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션뷰 스위트', '스위트룸', 4, 280000, '52㎡', NULL, 'y', SYSDATE);

-- 4. 글래드 여의도
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 2, '글래드 여의도', '서울특별시 영등포구 의사당대로 16', 37.5262, 126.9256, NULL, '비즈니스 여행객에 최적화된 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '02-6222-5000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 더블룸', '더블룸', 2, 160000, '30㎡', NULL, 'y', SYSDATE);

-- 5. 라발스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '라발스 호텔 부산', '부산광역시 영도구 태종로 82', 35.0919, 129.0456, NULL, '부산항과 남포동을 조망할 수 있는 오션뷰 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-790-1500', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 디럭스룸', '더블룸', 2, 180000, '36㎡', NULL, 'y', SYSDATE);

-- 6. 롯데호텔 서울
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 2, '롯데호텔 서울', '서울특별시 중구 을지로 30', 37.5648, 126.9832, NULL, '서울 중심에 위치한 럭셔리 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '02-771-1000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '이그제큐티브 스위트', '스위트룸', 2, 400000, '55㎡', NULL, 'y', SYSDATE);

-- 7. 메종글래드 제주
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 3, '메종글래드 제주', '제주특별자치도 제주시 노연로 80', 33.4860, 126.4880, NULL, '공항 접근성이 뛰어난 프리미엄 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '064-747-4900', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 트윈룸', '트윈룸', 2, 130000, '29㎡', NULL, 'y', SYSDATE);

-- 8. 파라다이스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '파라다이스 호텔 부산', '부산광역시 해운대구 해운대해변로 296', 35.1580, 129.1635, NULL, '해운대 해변 앞 럭셔리 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-742-2121', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 프리미어룸', '스위트룸', 3, 380000, '50㎡', NULL, 'y', SYSDATE);

-- 9. 라온 리조트 강릉
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 4, '라온 리조트 강릉', '강원특별자치도 강릉시 난설헌로 200', 37.7654, 128.8962, NULL, '자연 속 힐링 리조트.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '리조트', '033-650-9000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '패밀리 스위트룸', '스위트룸', 4, 210000, '48㎡', NULL, 'y', SYSDATE);

-- 10. 여수 마리나 호텔
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 8, '여수 마리나 호텔', '전라남도 여수시 돌산읍 우두리 889', 34.7421, 127.7455, NULL, '남해 바다 전망이 아름다운 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '061-681-8000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션뷰 트윈룸', '트윈룸', 2, 140000, '32㎡', NULL, 'y', SYSDATE);

------------------------------------------------------------
-- 🚗 13. 차량 데이터 (10대)
------------------------------------------------------------
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 1, '쏘나타', '세단', '12가3456', '휘발유', 5, 85000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 2, '그랜저', '세단', '23나5678', 'LPG', 5, 110000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 3, '스포티지', 'SUV', '34다9876', '디젤', 5, 95000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 4, '카니발', '승합차', '45라2233', '디젤', 9, 135000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 5, '아반떼', '세단', '56마4321', '휘발유', 5, 70000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 6, '팰리세이드', 'SUV', '67바8765', '디젤', 7, 125000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 7, '모닝', '경차', '78사1234', '휘발유', 4, 55000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 8, 'K5', '세단', '89아8888', '휘발유', 5, 80000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 9, '투싼', 'SUV', '90자5555', '디젤', 5, 93000, NULL, 'y', SYSDATE);
INSERT INTO tblRentalCar VALUES (seqRentalCar.NEXTVAL, 10, '제네시스 G80', '세단', '91차7777', '휘발유', 5, 160000, NULL, 'y', SYSDATE);



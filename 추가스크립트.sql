SELECT car_id, car_name, place_location_id
FROM tblRentalCar
WHERE place_location_id = 1;

-- 🚗 차량 이미지 & 지역 일괄 수정
-- 🚗 부산 렌터카 전용 이미지 업데이트
-- 🚗 차량 이미지 로컬 파일명으로 업데이트

UPDATE tblRentalCar SET car_image_url = 'morning.jpg' WHERE car_name = '모닝';
UPDATE tblRentalCar SET car_image_url = 'avante.jpg' WHERE car_name = '아반떼';
UPDATE tblRentalCar SET car_image_url = 'k5.jpg' WHERE car_name = 'K5';
UPDATE tblRentalCar SET car_image_url = 'sonata.jpg' WHERE car_name = '쏘나타';
UPDATE tblRentalCar SET car_image_url = 'grandeur.jpg' WHERE car_name = '그랜저';
UPDATE tblRentalCar SET car_image_url = 'sportage.jpg' WHERE car_name = '스포티지';
UPDATE tblRentalCar SET car_image_url = 'carnival.jpg' WHERE car_name = '카니발';
UPDATE tblRentalCar SET car_image_url = 'tucson.jpg' WHERE car_name = '투싼';
UPDATE tblRentalCar SET car_image_url = 'palisade.jpg' WHERE car_name = '팰리세이드';
UPDATE tblRentalCar SET car_image_url = 'genesis-g80.jpg' WHERE car_name = '제네시스 G80';

COMMIT;

SELECT car_name, car_image_url FROM tblRentalCar ORDER BY car_id;

------------------------------------------------------------
-- 🏨 숙소 + 객실 데이터 (부산 지역 10개)
------------------------------------------------------------

-- 1. 라발스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '라발스 호텔 부산', '부산광역시 영도구 태종로 82', 35.0919, 129.0456, 'lavelz-hotel.jpg', '부산항과 남포동을 조망할 수 있는 오션뷰 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-790-1500', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 디럭스룸', '더블룸', 2, 180000, '36㎡', 'lavelz-room.jpg', 'y', SYSDATE);

-- 2. 파라다이스 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '파라다이스 호텔 부산', '부산광역시 해운대구 해운대해변로 296', 35.1580, 129.1635, 'paradise-hotel.jpg', '해운대 해변 앞 럭셔리 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-742-2121', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 프리미어룸', '스위트룸', 3, 380000, '50㎡', 'paradise-room.jpg', 'y', SYSDATE);

-- 3. 해운대 센텀 호텔
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '해운대 센텀 호텔', '부산광역시 해운대구 센텀1로 20', 35.1693, 129.1293, 'centum-hotel.jpg', '부산 해운대 중심의 고급 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-720-9000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 트윈룸', '트윈룸', 2, 120000, '28㎡', 'centum-room.jpg', 'y', SYSDATE);

-- 4. 롯데호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '롯데호텔 부산', '부산광역시 부산진구 가야대로 772', 35.1560, 129.0593, 'lotte-hotel.jpg', '서면 중심의 5성급 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-810-1000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '프리미어 스위트', '스위트룸', 2, 420000, '55㎡', 'lotte-room.jpg', 'y', SYSDATE);

-- 5. 코모도 호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '코모도 호텔 부산', '부산광역시 중구 중앙대로 151', 35.1048, 129.0331, 'komodo-hotel.jpg', '한국 전통미와 현대식 객실을 결합한 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-461-9741', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 온돌룸', '온돌룸', 3, 160000, '38㎡', 'komodo-room.jpg', 'y', SYSDATE);

-- 6. 시그니엘 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '시그니엘 부산', '부산광역시 해운대구 달맞이길 30', 35.1613, 129.1732, 'signiel-hotel.jpg', '해운대 해변을 조망할 수 있는 최고급 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-922-1000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션뷰 스위트룸', '스위트룸', 4, 550000, '60㎡', 'signiel-room.jpg', 'y', SYSDATE);

-- 7. 호텔 농심
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '호텔 농심', '부산광역시 동래구 금강공원로 20', 35.2218, 129.0825, 'nongsim-hotel.jpg', '온천장에 위치한 전통과 현대가 조화된 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-550-2100', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '스탠다드 더블룸', '더블룸', 2, 140000, '30㎡', 'nongsim-room.jpg', 'y', SYSDATE);

-- 8. 아난티 힐튼 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '아난티 힐튼 부산', '부산광역시 기장군 기장읍 기장해안로 268-32', 35.2418, 129.2229, 'hilton-hotel.jpg', '부산 대표 해안 리조트형 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-509-1111', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '오션 디럭스룸', '더블룸', 3, 390000, '48㎡', 'hilton-room.jpg', 'y', SYSDATE);

-- 9. 베스트루이스 해운대
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '베스트루이스 해운대', '부산광역시 해운대구 구남로 20', 35.1592, 129.1598, 'bestlouis-hotel.jpg', '합리적인 가격의 비즈니스 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-743-7000', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '스탠다드룸', '트윈룸', 2, 95000, '25㎡', 'bestlouis-room.jpg', 'y', SYSDATE);

-- 10. 라한호텔 부산
INSERT INTO tblPlace VALUES (seqPlace.NEXTVAL, 1, 1, '라한호텔 부산', '부산광역시 남구 문현동 860-1', 35.1335, 129.0850, 'lahan-hotel.jpg', '전망이 좋은 프리미엄 시티 호텔.');
INSERT INTO tblAccom VALUES (seqAccom.NEXTVAL, seqPlace.CURRVAL, '호텔', '051-700-8800', SYSDATE);
INSERT INTO tblAccomRoom VALUES (seqAccomRoom.NEXTVAL, seqAccom.CURRVAL, '디럭스 더블룸', '더블룸', 2, 170000, '35㎡', 'lahan-room.jpg', 'y', SYSDATE);

COMMIT;

SELECT r.room_id, r.room_name, r.room_type, r.capacity,
                   r.price_per_night, r.room_image_url, r.room_status,
                   a.accom_type, p.place_name
              FROM tblAccomRoom r
              JOIN tblAccom a ON r.accom_id = a.accom_id
              JOIN tblPlace p ON a.place_id = p.place_id
             WHERE r.room_status = 'y';

select * from tblAccomRoom;

commit;

UPDATE tblRentalCar SET car_image_url = 'morning.jpg' WHERE car_name = '모닝';
UPDATE tblRentalCar SET car_image_url = 'avante.jpg' WHERE car_name = '아반떼';
UPDATE tblRentalCar SET car_image_url = 'k5.jpg' WHERE car_name = 'K5';
UPDATE tblRentalCar SET car_image_url = 'sonata.jpg' WHERE car_name = '쏘나타';
UPDATE tblRentalCar SET car_image_url = 'grandeur.jpg' WHERE car_name = '그랜저';
UPDATE tblRentalCar SET car_image_url = 'sportage.jpg' WHERE car_name = '스포티지';
UPDATE tblRentalCar SET car_image_url = 'palisade.jpg' WHERE car_name = '팰리세이드';
UPDATE tblRentalCar SET car_image_url = 'carnival.jpg' WHERE car_name = '카니발';
UPDATE tblRentalCar SET car_image_url = 'tucson.jpg' WHERE car_name = '투싼';
UPDATE tblRentalCar SET car_image_url = 'genesis-g80.jpg' WHERE car_name = '제네시스 G80';

SELECT r.room_id,
                   r.room_name,
                   r.room_type,
                   r.capacity,
                   r.price_per_night,
                   r.room_image_url,
                   r.room_status,
                   a.accom_type,
                   p.place_name
              FROM tblAccomRoom r
              JOIN tblAccom a ON r.accom_id = a.accom_id
              JOIN tblPlace p ON a.place_id = p.place_id
              JOIN tblPlaceLocation l ON p.place_location_id = l.place_location_id
             WHERE r.room_status = 'y';


COMMIT;

select * from tblPlaceLocation;

SELECT r.room_id, r.room_name, a.accom_type, p.place_name, l.location_name
FROM tblAccomRoom r
JOIN tblAccom a ON r.accom_id = a.accom_id
JOIN tblPlace p ON a.place_id = p.place_id
JOIN tblPlaceLocation l ON p.place_location_id = l.place_location_id
WHERE l.location_name = '부산'
  AND r.room_status = 'y';
  
  SELECT * FROM tblPlaceLocation;
  
  SELECT r.room_id,
       r.room_name,
       r.room_status,
       a.accom_type,
       p.place_name,
       l.location_name
  FROM tblAccomRoom r
  JOIN tblAccom a ON r.accom_id = a.accom_id
  JOIN tblPlace p ON a.place_id = p.place_id
  JOIN tblPlaceLocation l ON p.place_location_id = l.place_location_id
 WHERE l.location_name = '부산';

select * from tblAccom;

select * from tblAccomRoom;

스탠다드 디럭스 스위트 패밀리룸
UPDATE tblRentalCar SET car_image_url = 'genesis-g80.jpg' WHERE car_name = '제네시스 G80';
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (1, '예약요청');
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (2, '결제완료');
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (3, '이용완료');
INSERT INTO tblReservationStatus (status_id, status_name)
VALUES (4, '취소');
COMMIT;

INSERT INTO tblUserRoute (user_route_id, user_id, source_ai_route_id, user_route_title)
VALUES (10, 1, 100, '테스트 루트');
COMMIT;

update tblRentalCar set place_location_id = 1; 

select * from tblRentalCar;

SELECT * FROM tblUserRoute WHERE user_route_id = 1;

select * from tblAccom;
select * from tblPlace;
select * from tblReservation;
select * from tblaccomreservation;
select * from tblcarreservation;


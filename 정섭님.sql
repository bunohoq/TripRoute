
CREATE TABLE tblPlaceLocation (
	place_Location_id	number	primary key,
    place_Location_name	varchar2(10)	NOT NULL
);  

CREATE TABLE tblPlaceType (
	place_type_id	    NUMBER	        primary key,
	place_type_name	    VARCHAR2(50)	NOT NULL
);


CREATE TABLE tblKeyword (
	keyword_id	        NUMBER	        NOT NULL,
	keyword_name	    VARCHAR2(50)	NOT NULL,
	keyword_regdate	    DATE	        NOT NULL,
    CONSTRAINT PK_TBLKEYWORD PRIMARY KEY (keyword_id)
);


CREATE TABLE tblPlace (
    place_id                NUMBER          primary key,
    place_type_id           NUMBER          NOT NULL,
    place_Location_id       NUMBER          NOT NULL,
    place_name              VARCHAR2(200)   NOT NULL,
    place_address           VARCHAR2(400)   NOT NULL,
    place_lat               NUMBER          NOT NULL,
    place_lng               NUMBER          NOT NULL,
    place_main_image_url    VARCHAR2(500)   NULL,
    place_description       VARCHAR2(1000)  NULL,
    CONSTRAINT FK_tblPlaceType_TO_tblPlace FOREIGN KEY (place_type_id) REFERENCES tblPlaceType (place_type_id),
    CONSTRAINT FK_tblPlaceLocation_TO_tblPlace FOREIGN KEY (place_Location_id) REFERENCES tblPlaceLocation (place_Location_id)
);


 CREATE TABLE tblTouristSpot (
    place_id NUMBER NOT NULL,
    admission_fee VARCHAR2(500) NULL,
    opening_hours VARCHAR2(500) NULL,
    contact_info VARCHAR2(50) NULL,
    spot_overinfo CLOB NULL,
    parking_info VARCHAR2(500) NULL,
    rest_day VARCHAR2(200) NULL,
    CONSTRAINT pk_tblTouristSpot PRIMARY KEY (place_id),
    CONSTRAINT fk_tblTouristSpot_place FOREIGN KEY (place_id) REFERENCES tblPlace(place_id)
    );


CREATE TABLE tblKeyword (
    keyword_id NUMBER PRIMARY KEY,
    keyword VARCHAR2(100) UNIQUE
);

CREATE TABLE tblKeywordLink (
   keyword_link_id NUMBER PRIMARY KEY,
   place_id NUMBER NOT NULL,
   keyword_id NUMBER NOT NULL,
   CONSTRAINT fk_keywordlink_place FOREIGN KEY (place_id) REFERENCES tblPlace(place_id),
   CONSTRAINT fk_keywordlink_keyword FOREIGN KEY (keyword_id) REFERENCES tblKeyword(keyword_id)
 );

--시퀀스문
CREATE SEQUENCE seqKeywordlink;


















select * from tblPlaceType;

INSERT INTO tblPlaceType (place_type_id, place_type_name) VALUES (1, '관광지');
INSERT INTO tblPlaceType (place_type_id, place_type_name) VALUES (2, '맛집');

update tblplacetype set place_type_name='관광지' where place_type_name='숙소';
update tblplacetype set place_type_name='식당' where place_type_id=2;
update tblplacetype set place_type_name='숙소' where place_type_id=3;
update tblplacetype set place_type_name='관광지' where place_type_name='숙소';

select * from tblplacetype;
select * from tblplace;

-- tblPlaceLocation: 지역 위치 정의 (1: 서울 강남)
INSERT INTO tblPlaceLocation (place_location_id, place_location_name) VALUES (1, '서울');


INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (13, 1, 1, '이태원 앤틱 가구 거리', '서울특별시 용산구 보광로 109-1', 37.5326056972, 126.9944149759, 'placeimage/이태원 앤틱 가구 거리_1_공공1유형.jpg', '이태원 앤틱 가구거리는 1960년대 인근 미군 부대에 근무하던 군인들이 본국으로 귀환하면서 사용하던 가구들을 팔려고 내놓은 것에서 시작되었습니다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (14, 1, 1, '뚝섬한강공원', '서울특별시 광진구 강변북로 2273 (자양동)', 37.5294186076, 127.0739939307, 'placeimage/뚝섬한강공원_1_공공1유형.jpg', '뚝섬한강공원은 한강공원으로 새 단장하기 이전부터 강변유원지로 유명했던 곳입니다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (15, 1, 1, '여의도한강공원', '서울특별시 영등포구 여의동로 330 (여의도동)', 37.5263997727, 126.9336095794, 'placeimage/여의도한강공원_1_공공1유형.jpg', '여의도한강공원은 정치, 금융, 언론의 중심지인 여의도에 자리하고 있으며, 지하철, 버스 등 대중교통으로 접근성이 좋아 직장인과 일반시민들이 즐겨 찾는 명소이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (16, 1, 1, '구로거리공원', '서울특별시 구로구 공원로 73-1 (구로동)', 37.5030794513, 126.8883643588, 'placeimage/구로거리공원_1_공공1유형.jpg', '지역 주민들의 휴식과 여가를 위한 공간이며, 구로구의 도시적 특성과 자연을 조화롭게 담아낸 공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (17, 1, 1, '안국사', '서울특별시 관악구 낙성대로 77 (봉천동)', 37.4716399155, 126.9587338341, 'placeimage/안국사_1_공공1유형.jpg', '고려시대 명장인 강감찬 장군의 영정을 모시고 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (18, 1, 1, '용왕산근린공원', '서울특별시 양천구 용왕정길 30 (목동)', 19.69442748, 117.9925662504, 'placeimage/용왕산근린공원_1_공공1유형.jpg', '용왕산은 옛 지도상에 ‘엄지산’으로 기록되어 있으며, 엄지는 순수한 우리말인 ‘첫머리’ 또는 ‘으뜸’이라는 뜻으로 천호가 살 수 있는 들판의 들머리에 있기 때문에 이와 같은 이름이 붙여졌다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (19, 1, 1, '심산기념문화센터', '서울특별시 서초구 사평대로 55 (반포동)', 37.4985345878, 126.9907301631, 'placeimage/심산기념문화센터_1_공공1유형.jpg', '심산기념문화센터는 시민의 문화예술 활동을 도모하고 지역사회의 문화예술 사업을 지원하는 비영리 단체인 서초문화재단이 운영하는 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (20, 1, 1, '청계산', '서울특별시 서초구 원지동', 37.4437532162, 127.0553147223, 'placeimage/청계산_1_공공3유형.jpg', '청계산은 서울특별시와 경기도 성남시, 과천시, 의왕시의 경계에 따라 위치해 있는 산이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (21, 1, 1, '도봉산', '서울특별시 도봉구 도봉동', 37.7009531679, 127.0155138235, 'placeimage/도봉산_1_공공1유형.jpg', '도봉산은 서울특별시 도봉구와 경기도 의정부시, 양주시 장흥면에 걸쳐 있는 산이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (22, 1, 1, '남산공원(서울)', '서울특별시 중구 삼일대로 231 (예장동)', 37.5556863093, 126.9922311881, 'placeimage/남산공원(서울)_1_공공1유형.jpg', '남산공원은 서울 도심에 위치하여 시민에게 맑은 공기를 제공하는 자연 휴식처이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (23, 1, 1, '개운사(서울)', '서울특별시 성북구 개운사길 73 (안암동5가)', 37.5902162775, 127.0282880342, 'placeimage/개운사(서울)_1_공공1유형.jpg', '안암산 자락에 자리하고 있는 개운사는 그리 크지는 않지만 한국 불교 개혁의 근원지이고, 현재는 김포에 위치하고 있지만 불교 교육의 근본도량인 중앙승가대학이 있던 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (24, 1, 1, '경복궁', '서울특별시 종로구 사직로 161 (세종로)', 37.5760836609, 126.9767375783, 'placeimage/경복궁_1_공공1유형.jpg', '경복궁은 1392년 조선 건국 후 1395년(태조 4)에 창건한 조선왕조 제일의 법궁이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (25, 1, 1, '종묘 [유네스코 세계유산]', '서울특별시 종로구 종로 157 (훈정동)', 37.5710345779, 126.9951471543, 'placeimage/종묘 [유네스코 세계유산]_1_공공1유형.jpg', '종묘(宗廟)는 조선과 대한제국의 역대 왕과 왕비, 황제와 황후의 신주를 모시고 제사를 지내는 국가 사당이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (26, 1, 1, '창경궁', '서울특별시 종로구 창경궁로 185 (와룡동)', 37.5789336838, 126.9964634775, 'placeimage/창경궁_1_공공1유형.jpg', '창경궁(昌慶宮)은 성종이 세 명의 대비를 위해 옛 수강궁에 창건한 궁이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (27, 1, 1, '흥인지문', '서울특별시 종로구 종로 288(종로6가)', 37.5711931512, 127.0095263952, 'placeimage/흥인지문_1_공공3유형.jpg', '흥인지문은 서울성곽 8개의 문 가운데 동쪽에 있는 문으로 서울성곽은 서울 한양도성의 옛 이름이며 옛날 중요한 국가시설이 있는 한성부를 보호하기 위해 만들었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (28, 1, 1, '국립서울현충원', '서울특별시 동작구 현충로 210', 37.5013561691, 126.9732511193, 'placeimage/국립서울현충원_1_공공3유형.jpg', '국립현충원은 나라와 민족을 위해 순국한 영령들이 안장된 국립묘지이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (29, 1, 1, '사육신공원', '서울특별시 동작구 노량진로 191 (노량진동)', 37.5135098862, 126.9493751733, 'placeimage/사육신공원_1_공공1유형.jpg', '한강 인도교와 노량진역 중간의 높은 언덕에 자리한 사육신공원은 사육신묘 일대를 성역으로 가꾸어 조성한 공원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (30, 1, 1, '서울 영휘원(순헌황귀비)과 숭인원(이진)', '서울특별시 동대문구 홍릉로 90(청량리동)', 37.589647174, 127.0435644361, 'placeimage/서울 영휘원(순헌황귀비)과 숭인원(이진)_1_공공3유형.JPG', '영휘원은 대한제국 고종황제의 후궁인 순헌황귀비 엄씨의 무덤이고, 숭인원은 대한제국 마지막 황태자인 의민황태자의 첫째 아들 이진 원손의 무덤이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (31, 1, 1, '서울 헌릉(태종·원경왕후)과 인릉(순조·순원황후) [유네스코 세계유산]', '서울특별시 서초구 헌인릉길 34 (내곡동)', 37.464415194, 127.082364456, 'placeimage/서울 헌릉(태종·원경왕후)과 인릉(순조·순원황후) [유네스코 세계유산]_1_공공3유형.jpg', '헌릉은 조선 3대 태종(재위 1400~1418)과 원경왕후 민씨(1365~1420)의 능이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (32, 1, 1, '올림픽공원', '서울특별시 송파구 올림픽로 424 (방이동)', 37.5206092598, 127.1150682209, 'placeimage/올림픽공원_1_공공1유형.jpg', '88서울올림픽의 숨결이 살아 있는 올림픽공원은 88서울올림픽의 정신과 가치를 계승 발전시키고 있는 국민체육진흥공단에서 운영·관리하는 시민들의 체육, 문화, 여가의 공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (33, 1, 1, '청와대 앞길', '서울특별시 종로구 궁정동', 37.5835410742, 126.9737681926, 'placeimage/청와대 앞길_1_공공1유형.jpg', '청와대 앞길은 종로구 팔판동 162번지(삼청동길)에서 청와대 앞을 거쳐 궁정동 98-6번지(효자로)에 이르는 길이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (34, 1, 1, '남산서울타워', '서울특별시 용산구 남산공원길 105', 37.5511089858, 126.9878983791, 'placeimage/남산서울타워_1_공공1유형.jpg', '남산서울타워는 효율적인 방송전파 송수신과 한국의 전통미를 살린 관광 전망시설의 기능을 겸비한 국내 최초의 종합전파탑으로 방송문화와 관광산업의 미래를 위해 건립되었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (35, 1, 1, '서울 명동성당', '서울특별시 중구 명동길 74(명동2가)', 37.5633131117, 126.9872814233, 'placeimage/서울 명동성당_1_공공3유형.png', '서울 대교구 주교좌 명동대성당은 한국 가톨릭교회 공동체가 처음으로 탄생한 곳으로 순교 성인들의 유해를 모시고 있는 한국 가톨릭의 대표 성지이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (36, 1, 1, '관음사(서울)', '서울특별시 관악구 승방1길 109-80(남현동)', 37.4676601403, 126.9765239933, 'placeimage/관음사(서울)_1_공공1유형.JPG', '관음사는 관악산 주봉에서 북동쪽으로 이어지는 마지막 봉우리 기슭에 위치한 대한불교조계종 조계사 말사이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (37, 1, 1, '서울 신림동 굴참나무', '서울특별시 관악구 난곡로35길 28-7', 37.4710197967, 126.9169737649, 'placeimage/서울 신림동 굴참나무_1_공공1유형.JPG', '굴참나무는 참나무과에 속하는 낙엽교목으로, 줄기에 코르크가 발달하는 것이 특징이며 일본, 중국, 우리나라에 분포한다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (38, 1, 1, '이태원 관광특구', '서울특별시 용산구 이태원로 150-1 (이태원동)', 37.5339776925, 126.9906708338, 'placeimage/이태원 관광특구_1_공공1유형.jpg', '이태원은 1997년에 서울시에서 최초로 지정된 관광특구로 2만 명 이상의 외국인이 거주하고 있는 다국적·다문화 지역이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (39, 1, 1, '옛 용산신학교와 원효로 예수성심성당', '서울특별시 용산구 원효로19길 49 (원효로4가)', 37.5334771025, 126.9544963652, 'placeimage/옛 용산신학교와 원효로 예수성심성당_1_공공3유형.jpg', '용산신학교는 1892년, 원효로 예수성심성당은 1902년에 세워졌으며, 두 건물 모두 프랑스인 코스트 신부가 설계, 감독했다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (40, 1, 1, '서울 양천고성지', '서울특별시 강서구 가양동', 37.5740425776, 126.8408278075, 'placeimage/서울 양천고성지_1_공공1유형.jpg', '양천고성지는 서울특별시 강서구 가양동 궁산 정상부의 주능선과 가지능선 상단부를 에워싸 축조한 테뫼식 산성이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (41, 1, 1, '독립문', '서울특별시 서대문구 현저동', 37.5724532182, 126.9595142504, 'placeimage/독립문_1_공공3유형.JPG', '서대문독립공원에 있는 독립문은 갑오개혁 이후 자주독립의 의지를 다짐하기 위해 중국 사신을 영접하던 영은문을 헐고 세운 기념물이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (42, 1, 1, '난지한강공원', '서울특별시 마포구 한강난지로 162', 37.562819678, 126.8854129455, 'placeimage/난지한강공원_1_공공3유형.jpg', '난지한강공원은 수변공간으로서의 공원 기능은 물론 여가·레저 및 습지생태공원 기능을 골고루 갖추고 있는 공원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (43, 1, 1, '보라매공원', '서울특별시 동작구 여의대방로20길 33', 37.4929729132, 126.9231614728, 'placeimage/보라매공원_1_공공1유형.jpg', '보라매공원은 1985년부터 공군사관학교 부지를 정비해 1986년 5월 5일 개원한 도심 공원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (44, 1, 1, '서울 신림동 민속순대타운', '서울특별시 관악구 신림로59길 14(신림동)', 37.4833519091, 126.9287890094, 'placeimage/서울 신림동 민속순대타운_1_공공1유형.JPG', '서울의 대표적인 먹거리 타운인 신림동 순대타운에서는 독특하고 고유한 맛의 순대를 즐길 수 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (45, 1, 1, '조계사(서울)', '서울특별시 종로구 우정국로 55 (견지동)', 37.5739784579, 126.9827509785, 'placeimage/조계사(서울)_1_공공1유형.jpg', '조계사는 대한불교조계종의 총본산 사찰이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (46, 1, 1, '쌈지길', '서울특별시 종로구 인사동길 44 (관훈동)', 37.5743062352, 126.9848674428, 'placeimage/쌈지길_1_공공3유형.JPG', '인사동의 가장 대표적인 장소 쌈지길은 쌈지길은 전통을 현대적으로 재해석한 작품과 문화를 만나고 즐길 수 있는 공예품 전문 쇼핑몰이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (47, 1, 1, '서울숲', '서울특별시 성동구 뚝섬로 273', 37.5431247707, 127.0418131384, 'placeimage/서울숲_1_공공1유형.jpg', '서울숲은 1908년 설치된 서울 최초의 상수원 수원지였으며, 2005년에 뚝섬체육공원 일대를 대규모 도시 숲으로 만들기 위해 새롭게 개원하였다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (48, 1, 1, '홍지문 및 탕춘대성', '서울특별시 종로구 홍지동99-7', 37.5996528175, 126.9586135629, 'placeimage/홍지문 및 탕춘대성_1_공공1유형.jpg', '탕춘대성은 조선 후기 도성방어체계를 보여주는 독특한 구조의 방어성으로, 한양의 도성과 북한산성을 연결하여 세운 성이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (49, 1, 1, '광나루안전체험관', '서울특별시 광진구 능동로 238', 37.5513105664, 127.077162465, 'placeimage/광나루안전체험관_1_공공1유형.jpg', '서울어린이대공원 정문 옆에 위치한 광나루안전체험관은 화재나 지진, 태풍 등 각종 재난 상황을 가상으로 설정하여 일반 시민들이 직접 체험하면서 안전교육을 받을 수 있는 국내 최초의 재난 체험관이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (50, 1, 1, '서울색공원', '서울특별시 영등포구 여의도동', 37.5304520284, 126.9307152844, 'placeimage/서울색공원_1_공공1유형.jpg', '서울 색공원은 마포대교 교각과 둔치 사이의 하부공간에 색을 주제로 조성된 시민공원(약 9,000㎡)이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (51, 1, 1, '최순우 옛집', '서울특별시 성북구 성북로15길 9 (성북동)', 37.5930654442, 127.0003599434, 'placeimage/최순우 옛집_1_공공1유형.jpg', '성북동에 위치한 최순우 옛집은 우리 문화의 아름다움을 찾고 알린 혜곡 최순우(1916~1984) 선생이 1976년부터 1984년까지 거주한 주택이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (52, 1, 1, '서빙고동 부군당', '서울특별시 용산구 서빙고로59길 3-6 (서빙고동)', 37.5205209674, 126.9931932063, 'placeimage/서빙고동 부군당_1_공공1유형.jpg', '서빙고동 부군당은 조선시대 이 마을 주민들이 마을의 수호와 주민의 안녕을 위해 세운 제당이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (53, 1, 1, '남산 팔각정', '서울특별시 중구 예장동 8-1', 37.5516394747, 126.9876206116, 'placeimage/남산 팔각정_1_공공1유형.jpg', '남산 팔각정은 남산타워와 함께 남산의 대표적 명소로 꼽히는 정자이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (54, 1, 1, '경희궁공원', '서울특별시 종로구 새문안로 55 (신문로2가)', 37.5698981615, 126.9707771853, 'placeimage/경희궁공원_1_공공1유형.jpg', '경희궁공원은 서울의 역사와 자연이 어우러진 아름다운 공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (55, 1, 1, '현대원서공원', '서울특별시 종로구 창덕궁길 19 (원서동)', 37.5782863946, 126.9885725479, 'placeimage/현대원서공원_1_공공1유형.jpg', '원서공원은 현대건설이 현대그룹 사옥을 건립할 때 기업의 이익을 사회에 환원한다는 의미로 시민들의 휴식을 위해 도심에 녹지 공간을 조성한 것이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (56, 1, 1, '탑골공원 팔각정', '서울특별시 종로구 종로 99 (종로2가)', 37.5705539611, 126.9886227626, 'placeimage/탑골공원 팔각정_1_공공3유형.jpg', '탑골공원 팔각정은 종로2가 탑골공원에 있는 누정으로 1989년 9월 19일 서울특별시 유형문화재로 지정되었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (57, 1, 1, '덕수궁 대한문', '서울특별시 중구 세종대로 99 (정동)', 37.5651071556, 126.9765906796, 'placeimage/덕수궁 대한문_1_공공3유형.JPG', '대한문(大漢門)은 덕수궁의 정문으로 ‘대한’은 “한양이 창대해진다”라는 뜻이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (58, 1, 1, '관훈동 민씨 가옥 (구 부마도위박영효가옥)', '서울특별시 중구 퇴계로34길 28', 37.5585082277, 126.9935754302, 'placeimage/관훈동 민씨 가옥 (구 부마도위박영효가옥)_1_공공3유형.JPG', '관훈동 30-1에 위치한 민씨 가옥은 조선 말기의 정치인이자 친일인명사전에 등록된 민영휘 일가가 거주한 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (59, 1, 1, '해풍부원군윤택영댁재실', '서울특별시 중구 퇴계로34길 28', 37.5583638148, 126.9944031366, 'placeimage/해풍부원군윤택영댁재실_1_공공3유형.JPG', '이 가옥은 순종의 장인인 해풍 부원군 윤택영이 그의 딸 순정황후가 1906년 황태자비로 책봉되어 창덕궁에 들어갈 때 지은 집이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (60, 1, 1, '순정효황후윤씨친가', '서울특별시 중구 퇴계로34길 28', 37.5586776601, 126.9939920541, 'placeimage/순정효황후윤씨친가_1_공공3유형.JPG', '순정효황후윤씨친가는 조선시대 최상류층 주택의 면모를 고스란히 보여주는 가옥이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (61, 1, 1, '3.1독립운동기념탑', '서울특별시 중구 장충단로 59 (장충동2가)', 37.551800789, 127.0000222551, 'placeimage/3.1독립운동기념탑_1_공공3유형.JPG', '3·1독립운동기념탑은 일본 제국주의의 잔혹한 식민 통치로부터 조국과 민족의 독립을 위해 전개된 3·1독립운동의 숭고한 정신을 계승하고 발전시켜 널리 국민의 호국애족정신을 고양하고자 온 겨레의 정성을 모아 중구 장충동 남산공원에 건립되었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (62, 1, 1, '경찰혼', '서울특별시 영등포구 국회대로 608 (당산동3가)', 37.5262992108, 126.9015402823, 'placeimage/경찰혼_1_공공3유형.jpg', '영등포구 당산동에 2006년 광복 후 혼란기, 6·25전쟁, 전후 시기에 전사하거나 순직한 이 지역 경찰의 영령을 추모하기 위해 ‘추모비’를 건립하였다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (63, 1, 1, '나석주의사동상', '서울특별시 중구 을지로 66(을지로2가) 외환은행 본점 앞', 37.5655100385, 126.9850482312, 'placeimage/나석주의사동상_1_공공3유형.JPG', '나석주의사동상은 조국을 위해 기꺼이 목숨을 바쳤던 나석주 의사의 숭고한 희생정신을 추모하기 위해 현재 외환은행 본점이 위치한 옛 동양척식주식회사 자리에 세워진 동상이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (64, 1, 1, '순국선열추념탑', '서울특별시 서대문구 현저동101', 37.5731530883, 126.9568144774, 'placeimage/순국선열추념탑_1_공공1유형.jpg', '일제가 우리나라의 국권을 침탈하고 지배하던 일제강점기에 수많은 애국선열들이 목숨을 걸고 일어나 항일 의병전쟁, 안중근, 강우규, 이봉창, 윤봉길 같은 의열투쟁, 3·1독립운동, 봉오동전투, 청산리전투 같은 독립군전투, 대한민국임시정부, 광복군 등에 참여하여 조국의 독립을 위해 싸우다가 순국하거나 혹은 일제에 체포되어 옥고를 치렀다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (65, 1, 1, '안중근의사 동상', '서울특별시 중구 남대문로5가471', 37.5536530127, 126.9811155917, 'placeimage/안중근의사 동상_1_공공1유형.jpg', '안중근의사 동상은 독립운동에 투신하여 순국하신 안중근의사의 숭고한 뜻을 기리고 그 애국정신을 후세에 널리 전하기 위하여 2010년 10월 22일 재건립되었으며, 하얼빈역에서 이토 히로부미를 저격한 직후 태극기를 꺼내든 당당하고 떳떳한 모습으로 안중근의사 기념관의 입구에 위치한다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (66, 1, 1, '우남 이승만박사 동상', '서울특별시 강동구 고덕로 227 (고덕동)배재중고등학교 내', 37.5549198104, 127.1508556544, 'placeimage/우남 이승만박사 동상_1_공공3유형.jpg', '우남 이승만 박사 동상은 배재고등학교 내 자리한 동상으로 이승만 박사의 독립운동 업적을 기리기 위해 건립되었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (67, 1, 1, '유관순열사상', '서울특별시 광진구 능동로 18 (자양동, 이튼타워리버3차)', 37.5329264215, 127.0677499556, 'placeimage/유관순열사상_1_공공3유형.jpg', '천안 아우내 장터에서 독립만세운동을 주도하다 옥중에서 순국한 유관순 열사를 기리기 위해 1973년 어린이대공원 내 방문자센터 뒤편 계단 위에 유관순 열사 동상이 세워졌다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (68, 1, 1, '이봉창 의사 동상', '서울특별시 용산구 효창원로 177-18 (효창동)', 37.5445620575, 126.9618926006, 'placeimage/이봉창 의사 동상_1_공공1유형.jpg', '효창공원 안에 위치한 이봉창 의사 동상은 의사의 숭고한 애국심과 희생정신을 기리고자 동아일보사의 후원을 받아 건립한 동상이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (69, 1, 1, '이원등 상사상', '서울특별시 용산구 양녕로 446 (이촌동)', 37.5174179428, 126.9592824935, 'placeimage/이원등 상사상_1_공공1유형.jpg', '한강의 노들섬에 있는 이원등상사상은 거룩한 전우애와 희생정신을 보여준 이원등 상사의 정신을 본받기 위해 세운 동상이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (70, 1, 1, '해공신익희선생동상', '서울특별시 강동구 천호3동 448-49호 (천호동 마을마당 내)', 37.5363494014, 127.131841247, 'placeimage/해공신익희선생동상_1_공공3유형.jpg', '독립운동가로 우리 민족의 자주독립과 민주주의 발전을 위해 헌신한 해공 신익희 선생의 공적을 기려 강동구청 주관으로 천호동에 동상을 건립하였다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (71, 1, 1, '해병대 104고지 전적비', '서울특별시 서대문구 연희동산100-1', 37.5679531406, 126.9260146536, 'placeimage/해병대 104고지 전적비_1_공공1유형.jpg', '서울 서대문구 연희동에 서울 서쪽 관문인 104고지 탈환 작전 중 전사한 해병대 장병들을 추모하기 위해 해병대 사령부에서 1982년 9월 28일 이 비를 세웠다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (72, 1, 1, '명동 남대문 북창동 다동무교동 관광특구', '서울특별시 중구 세종대로 40(남대문로4가)', 37.5599771733, 126.9753048316, 'placeimage/명동 남대문 북창동 다동무교동 관광특구_1_공공3유형.JPG', '명동, 남대문, 북창동, 다동무교동 관광특구는 서울 중심부에 있는 명동과 남대문, 북창동, 다동 무교동 일대의 외국인이 많이 찾는 쇼핑과 먹거리 명소를 말한다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (73, 1, 1, '구룡산(서울)', '서울특별시 서초구 염곡동', 37.4690781677, 127.0615995465, 'placeimage/구룡산(서울)_1_공공3유형.jpg', '구룡산(306m)은 대모산과 하나의 줄기를 가진 산으로 서초구 염곡동과 강남구 개포동 일대에 위치해 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (74, 1, 1, '경성 부민관 폭탄 의거지', '서울특별시 중구 세종대로 125 (태평로1가)', 37.5675596526, 126.9768017026, 'placeimage/경성 부민관 폭탄 의거지_1_공공3유형.JPG', '경성 부민관 폭탄 의거지는 경성부민관에서 친일파가 주도하는 대회를 방해하기 위해 폭탄을 터트린 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (75, 1, 1, '반공 청년운동 순국 열사 기념비', '서울특별시 중구 남산공원길 125-72', 37.552231068, 126.9873511751, 'placeimage/반공 청년운동 순국 열사 기념비_1_공공3유형.JPG', '반공청년운동 기념비 건립위원회가 반공청년운동을 전개하다 순국한 애국열사들의 넋을 기리고 그들의 호국정신을 길이 계승하고자 1968년 10월 9일 중구 예장동 산5-6에 건립한 기념비이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (76, 1, 1, '한복남', '서울특별시 종로구 사직로 133-5', 37.5762891312, 126.9733212169, 'placeimage/한복남_1_공공3유형.jpg', '지금은 한복 입혀주는 남자, ''한복남'' 이라는 이름으로 서울까지 진출했지만, 이전에는 전주에서 2012년부터 한복데이를 기획하여 사람들에게 한복의 아름다움을 알리는 데 큰 역할을 했었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (77, 1, 1, '여의천', '서울특별시 서초구 양재동', 37.4710525137, 127.0379155335, 'placeimage/여의천_1_공공1유형.jpg', '여의천은 서초구 신원동 청계산에서 발원하여 양재천으로 합류하는 지방하천이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (78, 1, 1, '다이나믹 메이즈 인사동', '서울특별시 종로구 인사동길 12 (인사동)지하 1층', 37.5719398862, 126.9872367386, 'placeimage/다이나믹 메이즈 인사동_1_공공1유형.jpg', '다이나믹 메이즈는 차원을 넘나들며 역동적인 체험을 즐길 수 있는 실내 익사이팅 프로그램이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (79, 1, 1, '이태원 이슬람거리', '서울특별시 용산구 우사단로일대', 37.5334001039, 126.9975035607, 'placeimage/이태원 이슬람거리_1_공공1유형.jpg', '수도권 지하철 6호선 이태원역 3번 출구로 나와 보광초등학교 골목으로 올라가면 영어나 한국어 간판보다 아랍어 간판이 더 많은 풍경이 펼쳐지는 곳이 바로 이태원 이슬람거리의 시작이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (80, 1, 1, '대림동 차이나타운', '서울특별시 영등포구 대림동1050-43', 37.4924530714, 126.8975138236, 'placeimage/대림동 차이나타운_1_공공1유형.jpg', '대림동 차이나타운은 2000년대 초반 재중동포들이 대림역을 중심으로 정착하며 형성된 밀집 주거지형 차이나타운이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (81, 1, 1, '아리수나라', '서울특별시 광진구 능동로 216 (능동)', 37.5493552228, 127.0762792676, 'placeimage/아리수나라_1_공공1유형.jpg', '서울특별시 광진구 능동 서울어린이대공원에 위치한 아리수 나라는 전국 최초의 어린이 수돗물체험홍보관으로, 2010년 10월 26일 개관했다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (82, 1, 1, '서울 구의정수장 제1·2공장(구의 아리수 정수센터)', '서울특별시 광진구 광나루로 571 (구의동)', 37.5442227879, 127.093080662, 'placeimage/서울 구의정수장 제1·2공장(구의 아리수 정수센터)_1_공공3유형.jpg', '구의 아리수정수센터에서는 우리나라 정수시설의 변천사를 한눈에 볼 수 있는 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (83, 1, 1, '동대문디자인플라자(DDP)', '서울특별시 중구 을지로 281 (을지로7가)', 37.566107632, 127.0095709797, 'placeimage/동대문디자인플라자(DDP)_1_공공1유형.jpg', '꿈꾸고(Dream), 만들고(Design), 누린다(Play)는 뜻을 가지고 있는 DDP(동대문 디자인 플라자)는 서울특별시 동대문에 위치한 복합문화공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (84, 1, 1, '롯데월드타워 서울스카이', '서울특별시 송파구 올림픽로 300 (신천동)117~123층', 37.5141653654, 127.1040749597, 'placeimage/롯데월드타워 서울스카이_1_공공1유형.jpg', '세계 6위, 국내 최고 높이 123층, 555m 높이의 롯데월드타워에서 가장 높은 곳에 위치한 서울스카이 전망대는 국내에서 가장 높은 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (85, 1, 1, '광나루한강공원', '서울특별시 강동구 선사로 83-106 (암사동)83-106', 37.5500198634, 127.1222639517, 'placeimage/광나루한강공원_1_공공3유형.JPG', '강동대교에서 잠실철교 사이에 있는 광나루 한강공원은 한강 상류로부터 유입된 토사가 퇴적되어 자연스럽게 형성된 모래톱과 대규모 갈대군락지로 자연 그대로의 한강의 모습을 가장 잘 유지하고 있는 공원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (86, 1, 1, '디키디키', '서울특별시 중구 을지로 281동대문디자인플라자 배움터 4층', 37.5681962916, 127.0103125191, 'placeimage/디키디키_1_공공3유형.jpg', '"Design Kids Digital Kids"를 뜻하는 디키디키는 디자인을 통한 어린이의 감성과 창의력을 키우는 공간으로, 유·아동기부터 문화, 예술, 산업 전반의 디자인 마인드를 자연스럽게 체득할 수 있는 디자인 활동이 가능한 대규모 놀이터이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (87, 1, 1, '한방스파 여용국', '서울특별시 송파구 석촌호수로12길 60 (잠실동)2층', 37.5083878233, 127.0799300989, 'placeimage/한방스파 여용국_1_공공3유형.JPG', '여용국은 조선 시대 안정복의 소설 ［여용국전］의 내용을 바탕으로 탄생했다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (88, 1, 1, '올리바인 스파', '서울특별시 종로구 통일로16길 4-1 (무악동)', 37.5758166818, 126.9576059961, 'placeimage/올리바인 스파_1_공공3유형.jpg', '올리바인 스파는 도심 속 럭셔리 스파와 뷰티&슬리밍센터를 운영하고 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (89, 1, 1, '여계묘역', '서울특별시 구로구 고척동산6-3', 37.5073006073, 126.8560838482, 'placeimage/여계묘역_1_공공3유형.jpg', '함양 여씨 묘역은 서울특별시 구로구 고척2동에 위치한 함양 여씨 가문의 선영이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (90, 1, 1, '연의근린공원', '서울특별시 양천구 신정이펜1로 12 (신정동)', 37.511749701, 126.8342218274, 'placeimage/연의근린공원_1_공공3유형.jpg', '연의근린공원은 국내 유일의 생태환경 저류지 공원으로 환경부 신기술인 생태적 수질정화 비오톱 특허시스템을 도입해 조성하였다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (91, 1, 1, '지양산', '서울특별시 양천구 지양로7길 28-29 (신월동)', 37.5214151638, 126.8296969684, 'placeimage/지양산_1_공공3유형.jpg', '지양산은 모든 주민들이 편리하게 산을 산책하며 숲을 이용할 수 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (92, 1, 1, '명동', '서울특별시 중구 명동2가', 37.562152093, 126.984915005, 'placeimage/명동_1_공공1유형.jpg', '명동은 거대 쇼핑도시를 연상케 하는 공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (93, 1, 1, '이태원 우사단길', '서울특별시 용산구 한남동763-7', 37.5326085465, 126.9984451642, 'placeimage/이태원 우사단길_1_공공3유형.jpg', '우사단길은 한국적 정서와 이국적인 분위기가 어우러진 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (94, 1, 1, 'SPA 1899', '서울특별시 강남구 영동대로 416 (대치동)B2층', 37.5066377643, 127.0653425868, 'placeimage/SPA 1899_1_공공1유형.jpg', 'SPA 1899는 1899년부터 이어져온 홍삼 전문가인 한국인삼공사에 의해 탄생한 곳이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (95, 1, 1, '선유도공원', '서울특별시 영등포구 선유로 343 (당산동)', 37.5422918129, 126.902442527, 'placeimage/선유도공원_1_공공1유형.jpg', '한강 중심부에 자리한 작은 봉우리섬 선유도는 예로부터 빼어난 풍광을 지닌 곳으로 예술가와 묵객시인들의 사랑을 받은 곳이었다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (96, 1, 1, '안녕인사동', '서울특별시 종로구 인사동길 49', 37.5744839692, 126.9835620013, 'placeimage/안녕인사동_1_공공3유형.jpg', '2019년 10월에 오픈한 안녕인사동은 다양한 먹거리, 즐길거리, 볼거리가 가득한 복합문화공간으로, 일상의 재미와 여유를 제공하며 시민들에게 휴식을 제공한다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (97, 1, 1, '푸른수목원', '서울특별시 구로구 연동로 240', 37.483080629, 126.8240846662, 'placeimage/푸른수목원_1_공공1유형.jpg', '푸른수목원은 인적 없던 공터를 친환경 공간으로 탈바꿈시켜 조성된 서울시 최초의 시립 수목원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (98, 1, 1, '아모레 성수', '서울특별시 성동구 아차산로11길 7(성수동2가)', 37.5446026871, 127.0590698587, 'placeimage/아모레 성수_1_공공3유형.jpg', '서울 성수동에 위치한 아모레 성수는 아모레퍼시픽이 제안하는 ‘아름다움’에 대해 차별화된 경험을 할 수 있는 뷰티 플래그십 공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (99, 1, 1, '은평한옥마을', '서울특별시 은평구 진관동', 37.64125316, 126.9377142893, 'placeimage/은평한옥마을_1_공공1유형.JPG', '은평한옥마을은 은평구 진관동에 위치한 현대식 한옥마을이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (100, 1, 1, '율현공원', '서울특별시 강남구 율현동77-2', 37.4725537381, 127.115716748, 'placeimage/율현공원_1_공공1유형.jpg', '율현공원은 세곡 주택지구의 동남쪽 영역에 넓게 분포되어 있으며, 아파트 진입 도로를 기준으로 두 공간으로 나누어져 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (101, 1, 1, '신림계곡', '서울특별시 관악구 신림동808-126', 37.4591522814, 126.9478157357, 'placeimage/신림계곡_1_공공1유형.jpg', '관악산 공원 입구 자연학습장 계곡에 조성된 70m 길이의 물놀이장은 어린이들이 안전하게 이용할 수 있도록 수심이 낮고, 주 1회 수질검사와 상시 안전요원이 배치되어 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (102, 1, 1, '뚝섬한강공원 벽천마당', '서울특별시 광진구 자양동', 37.529151924, 127.0713164044, 'placeimage/뚝섬한강공원 벽천마당_1_공공1유형.jpg', '뚝섬한강공원에는 바닥에서 솟아오르는 시원한 물줄기를 감상할 수 있는 분수와 암벽 등반을 즐길 수 있는 벽천마당이 있다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (103, 1, 1, '우면산자연생태공원', '서울특별시 서초구 우면동산 34-1', 37.4692523493, 127.0171146993, 'placeimage/우면산자연생태공원_1_공공1유형.jpg', '우면산은 높이 293m로 서초구 우면동과 서초동, 양재동 등지의 도심에서 쉽게 오를 수 있는 산이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (104, 1, 1, '왜고개', '서울특별시 용산구 한강대로40길 46 (용산동5가)', 37.5300444768, 126.9717476685, 'placeimage/왜고개_1_공공1유형.jpg', '왜고개는 기와와 벽돌을 구워 공급하던 와서(瓦署)가 있던 데서 유래한 명칭이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (105, 1, 1, '올림픽공원 들꽃마루', '서울특별시 송파구 올림픽로 424 (방이동)', 37.5206092598, 127.1150682209, 'placeimage/올림픽공원 들꽃마루_1_공공1유형.jpg', '올림픽공원 사거리 인근 장미공원에서부터 한성백제박물관 사이 자그마한 언덕 경사로에 마련된 대규모 야생화 단지이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (106, 1, 1, '평화잔디광장', '서울특별시 마포구 상암동', 37.5619532089, 126.8908152548, 'placeimage/평화잔디광장_1_공공1유형.jpg', '평화의 공원은 2002년 월드컵 경기를 기념하여 세계적인 화합과 평화를 상징하는 장소로 월드컵경기장과 강북강변로 사이에 조성된 공원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (107, 1, 1, '여의도한강공원 멀티프라자', '서울특별시 영등포구 여의도동 84-4', 37.5282689639, 126.9316013762, 'placeimage/여의도한강공원 멀티프라자_1_공공1유형.jpg', '여의도한강공원 멀티프라자는 여의도 한강공원에 내에 위치한 잔디 광장으로, 서울의 대표적인 여가 공간 중 하나이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (108, 1, 1, '반포한강공원 달빛광장', '서울특별시 서초구 반포동', 37.5116526303, 126.997515286, 'placeimage/반포한강공원 달빛광장_1_공공1유형.jpg', '서울 반포대교와 잠수대교 한강 남단에 있는 반포한강공원의 중심 광장으로, 달의 모습을 형상화하여 만든 테마 광장이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (109, 1, 1, '서울 신당동 박정희 가옥', '서울특별시 중구 다산로36가길 25 (신당동)', 37.5615194612, 127.0198701715, 'placeimage/서울 신당동 박정희 가옥_1_공공3유형.jpg', '박정희 전 대통령이 1958년부터 1961년 장충동의 국가재건최고회의 의장 공관으로 이주할 때까지 가족과 함께 생활했던 집이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (110, 1, 1, '다락원체육공원', '서울특별시 도봉구 창포원로 45 (도봉동)', 37.6914909527, 127.0472806389, 'placeimage/다락원체육공원_1_공공3유형.jpg', '다락원체육공원은 서울 도봉산 자락에 위치한 종합 체육공원이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (111, 1, 1, '후암거실', '서울특별시 용산구 두텁바위로1가길 47 (후암동)', 37.5484924136, 126.9762495143, 'placeimage/후암거실_1_공공1유형.jpg', '후암거실은 서울역 인근에 위치한 곳으로, 나만의 공간에서 영화를 볼 수 있는 아늑한 공간이다.');
INSERT INTO tblPlace (place_id, place_type_id, place_location_id, place_name, place_address, place_lat, place_lng, place_main_image_url, place_description) VALUES (112, 1, 1, '양재근린공원', '서울특별시 서초구 동산로 35 (양재동)', 37.4719802653, 127.0424567609, 'placeimage/양재근린공원_1_공공1유형.jpg', '양재근린공원은 도심 속의 근린공원으로, 숲 속처럼 느껴지고 잘 가꾸어져 있어 많은 사람이 찾는 공원이다.');




INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (13, NULL, '매장에 따라 상이', '02-797-5119', '이태원 앤틱 가구거리는 1960년대 인근 미군 부대에 근무하던 군인들이 본국으로 귀환하면서 사용하던 가구들을 팔려고 내놓은 것에서 시작되었다.', '불가능', '매장에 따라 상이');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (14, '무료', '상시 개방', '02-3780-0521~4', '뚝섬한강공원은 한강공원으로 새 단장하기 이전부터 강변유원지로 유명했던 곳이다.', '가능 (674대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (15, '무료', '상시 개방', '02-3780-0561~6', '여의도한강공원은 정치, 금융, 언론의 중심지인 여의도에 자리하고 있으며, 지하철, 버스 등 대중교통으로 접근성이 좋아 직장인과 일반시민들이 즐겨 찾는 명소이다.', '가능 (1,782대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (16, NULL, '연중개방', '02-860-2114', '지역 주민들의 휴식과 여가를 위한 공간이며, 구로구의 도시적 특성과 자연을 조화롭게 담아낸 공간이다.', NULL, '연중개방');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (17, NULL, '연중개방', NULL, '고려시대 명장인 강감찬 장군의 영정을 모시고 있다.', NULL, '연중개방');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (18, '무료', '상시 개방', '02-2620-3574', '용왕산은 옛 지도상에 ‘엄지산’으로 기록되어 있으며, 엄지는 순수한 우리말인 ‘첫머리’ 또는 ‘으뜸’이라는 뜻으로 천호가 살 수 있는 들판의 들머리에 있기 때문에 이와 같은 이름이 붙여졌다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (19, NULL, '09:00~18:00<br>
※ 시설 별로 상이함', '02-3477-2461', '심산기념문화센터는 시민의 문화예술 활동을 도모하고 지역사회의 문화예술 사업을 지원하는 비영리 단체인 서초문화재단이 운영하는 곳이다.', NULL, NULL);
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (20, '무료', '상시 개방', '서초구청 푸른도시과 02-2155-6872', '청계산은 서울특별시와 경기도 성남시, 과천시, 의왕시의 경계에 따라 위치해 있는 산이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (21, '무료', '상시 개방<br>
※ 단, 기상여건에 따라 통제 가능', '북한산국립공원 도봉분소 02-954-2566', '도봉산은 서울특별시 도봉구와 경기도 의정부시, 양주시 장흥면에 걸쳐 있는 산이다.', '가능', '연중무휴<br>
※ 단, 기상여건에 따라 통제 가능');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (22, '무료', '상시개방', '02-3783-5900', '남산공원은 서울 도심에 위치하여 시민에게 맑은 공기를 제공하는 자연 휴식처이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (23, '무료', '04:00~19:00', '02-926-4069', '안암산 자락에 자리하고 있는 개운사는 그리 크지는 않지만 한국 불교 개혁의 근원지이고, 현재는 김포에 위치하고 있지만 불교 교육의 근본도량인 중앙승가대학이 있던 곳이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (24, '- 개인 3,000원<br>
- 만 24세 이하 청소년 무료
- 만 64세 이상 어르신 무료
- 단체(10인 이상) 2,400원', '[1월~2월] 09:00~17:00 (입장마감 16:00)<br>
[3월~5월] 09:00~18:00 (입장마감 17:00)<br>
[6월~8월] 09:00~18:30 (입장마감 17:30)<br>
[9월~10월] 09:00~18:00 (입장마감 17:00)<br>
[11월~12월] 09:00~17:00 (입장마감 16:00)', '02-3700-3900', '경복궁은 1392년 조선 건국 후 1395년(태조 4)에 창건한 조선왕조 제일의 법궁이다.', '가능 (승용차 240대 / 버스 50대)', '매주 화요일 <br>
※ 단, 정기휴일이 공휴일 및 대체공휴일과 겹칠 경우에는 개방하며, 그 다음의 첫 번째 비공휴일이 정기휴일임');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (25, '1,000원', '[2월~5월, 9월~10월] <br>
- 09:00~18:00 <br>
- 입장 마감 17:00<br>
[6월~8월] <br>
- 09:00~18:30 <br>
- 입장마감 17:30<br>
[11월~1월]<br>
- 09:00~17:30 <br>
- 입장 마감 16:30', '02-765-0195', '종묘(宗廟)는 조선과 대한제국의 역대 왕과 왕비, 황제와 황후의 신주를 모시고 제사를 지내는 국가 사당이다.', '가능', '매주 화요일 (단, 화요일이 공휴일인 경우 개방하며, 그 다음 첫 번째 평일에 휴관)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (26, '- 개인 1,000원<br>
- 단체(10인 이상) 800원', '09:00~21:00 (입장마감 20:00)', '02-762-4868', '창경궁(昌慶宮)은 성종이 세 명의 대비를 위해 옛 수강궁에 창건한 궁이다.', '가능 (22대)', '매주 월요일<br>
※ 단, 정기휴일이 공휴일 및 대체공휴일과 겹칠 경우에는 개방하며, 그 다음의 첫 번째 비공휴일이 정기휴일임');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (27, NULL, NULL, '흥인지문 관리소 02-2148-4166', '흥인지문은 서울성곽 8개의 문 가운데 동쪽에 있는 문으로 서울성곽은 서울 한양도성의 옛 이름이며 옛날 중요한 국가시설이 있는 한성부를 보호하기 위해 만들었다.', '없음', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (28, '무료', '- 개방 시간 06:00~18:00<br>
-  업무 시설 개방 시간 09:00~18:00', '1522-1555', '국립현충원은 나라와 민족을 위해 순국한 영령들이 안장된 국립묘지이다.', '가능', '전시관 : 11월 공휴일 / 12월~2월 토요일·공휴일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (29, '무료', '[공원]<br>
상시 개방<br>
[사육신묘]<br>
- 하절기 09:00~17:30<br>
- 동절기 09:00~17:00', '02-813-2130', '한강 인도교와 노량진역 중간의 높은 언덕에 자리한 사육신공원은 사육신묘 일대를 성역으로 가꾸어 조성한 공원이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (30, '- 대인 1,000원<br>
- 외국인 1,000원<br>
- 지역주민 500원<br>
※ 무료 : 만24세 이하 청소년 / 만65세 이상 어르신 / 장애인 / 유공자', '- 11월~1월 09:00~17:30 (입장 마감 16:30)<br>
- 2월~5월 / 9월~10월 09:00~18:00 (입장 마감 17:00)<br>
- 6월~8월 09:00~18:30 (입장 마감 17:30)', '02-962-0556', '영휘원은 대한제국 고종황제의 후궁인 순헌황귀비 엄씨의 무덤이고, 숭인원은 대한제국 마지막 황태자인 의민황태자의 첫째 아들 이진 원손의 무덤이다.', '가능', '매주 월요일 (단, 월요일이 공휴일일 경우 다음날 휴무)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (31, '- 개인 1,000원<br>
- 단체(10인 이상) 800원', '[2월~5월] 09:00~18:00 (입장마감 17:00)<br>
[6월~8월] 09:00~18:30 (입장마감 17:30)<br>
[9월~10월] 09:00~18:00 (입장마감 17:00)<br>
[11월~1월] 09:00~17:30 (입장마감 16:30)', '02-445-0347', '헌릉은 조선 3대 태종(재위 1400~1418)과 원경왕후 민씨(1365~1420)의 능이다.', '가능', '매주 월요일<br>
※ 단, 월요일이 공휴일인 경우 개방하며, 그 다음 첫 번째 평일에 휴관)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (32, '무료', '- 도보 및 자전거 출입 05:00~22:00 (광장지역 24:00)<br>
- 차량출입 06:00~22:00<br>
※ 시설물 안전과 방문객의 신변보호를 위해 22시 이후에는 공원 안쪽으로 출입금지<br>
※ 심야 행사 시에는 출입문 개방 조정', '02-410-1114', '88서울올림픽의 숨결이 살아 있는 올림픽공원은 88서울올림픽의 정신과 가치를 계승 발전시키고 있는 국민체육진흥공단에서 운영·관리하는 시민들의 체육, 문화, 여가의 공간이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (33, '무료', '상시 개방', NULL, '청와대 앞길은 종로구 팔판동 162번지(삼청동길)에서 청와대 앞을 거쳐 궁정동 98-6번지(효자로)에 이르는 길이다.', NULL, '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (34, '[전망대]<br>
- 대인(만 13세 이상) 26,000원<br>
- 소인(만 3세~ 만 12세)  20,000원<br>
- 경로(만 65세 이상) 20,000원', '- 평일 10:30~22:30<br>
- 주말 10:00~23:00', '02-756-2486', '남산서울타워는 효율적인 방송전파 송수신과 한국의 전통미를 살린 관광 전망시설의 기능을 겸비한 국내 최초의 종합전파탑으로 방송문화와 관광산업의 미래를 위해 건립되었다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (35, '무료', '- 일요일 07:00~20:00<br>
- 월요일~토요일 09:00~19:00', '02-774-1784', '서울 대교구 주교좌 명동대성당은 한국 가톨릭교회 공동체가 처음으로 탄생한 곳으로 순교 성인들의 유해를 모시고 있는 한국 가톨릭의 대표 성지이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (36, '무료', '상시 개방', '02-582-8609', '관음사는 관악산 주봉에서 북동쪽으로 이어지는 마지막 봉우리 기슭에 위치한 대한불교조계종 조계사 말사이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (37, '무료', '상시 개방', '관악구청 문화체육과 02-879-5607', '굴참나무는 참나무과에 속하는 낙엽교목으로, 줄기에 코르크가 발달하는 것이 특징이며 일본, 중국, 우리나라에 분포한다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (38, '무료', '※ 점포 별로 상이함', '이태원 관광안내소 02-3785-0942', '이태원은 1997년에 서울시에서 최초로 지정된 관광특구로 2만 명 이상의 외국인이 거주하고 있는 다국적·다문화 지역이다.', '가능', '※ 점포 별로 상이함');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (39, '무료 ', '주말 09:00~17:00', '02-701-5501', '용산신학교는 1892년, 원효로 예수성심성당은 1902년에 세워졌으며, 두 건물 모두 프랑스인 코스트 신부가 설계, 감독했다.', '가능', '평일 (학생 안전강화로 인해 주말에만 개방)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (40, '무료', '상시 개방', '02-2600-6081', '양천고성지는 서울특별시 강서구 가양동 궁산 정상부의 주능선과 가지능선 상단부를 에워싸 축조한 테뫼식 산성이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (41, '무료', '상시 개방', '서대문독립공원 02-3140-8305', '서대문독립공원에 있는 독립문은 갑오개혁 이후 자주독립의 의지를 다짐하기 위해 중국 사신을 영접하던 영은문을 헐고 세운 기념물이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (42, '무료', '상시개방', '02-3780-0611', '난지한강공원은 수변공간으로서의 공원 기능은 물론 여가·레저 및 습지생태공원 기능을 골고루 갖추고 있는 공원이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (43, '무료', '상시 개방', '02-2181-1113', '보라매공원은 1985년부터 공군사관학교 부지를 정비해 1986년 5월 5일 개원한 도심 공원이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (44, NULL, '점포별 상이함', NULL, '서울의 대표적인 먹거리 타운인 신림동 순대타운에서는 독특하고 고유한 맛의 순대를 즐길 수 있다.', '불가능', '점포별 상이함');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (45, '무료', '상시 개방', '02-768-8600', '조계사는 대한불교조계종의 총본산 사찰이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (46, '무료<br>
※ 단, 체험료 별도', '10:30~20:30', '02-736-0088', '인사동의 가장 대표적인 장소 쌈지길은 쌈지길은 전통을 현대적으로 재해석한 작품과 문화를 만나고 즐길 수 있는 공예품 전문 쇼핑몰이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (47, '무료', '[서울숲] 상시 개방<br>
[생태숲] 05:30~21:30<br>
[곤충식물원] <br>
- 하절기(3월~10월) 10:00~17:00 (입장마감 16:30)<br>
- 동절기(11월~2월) 10:00~16:00 (입장마감 15:30)<br>
[나비정원] 10:00~17:00 (입장마감 16:30)<br>
※ 나비정원은 5월~10월에만 운영', '02-460-2905~6', '서울숲은 1908년 설치된 서울 최초의 상수원 수원지였으며, 2005년에 뚝섬체육공원 일대를 대규모 도시 숲으로 만들기 위해 새롭게 개원하였다.', '가능 (211대)', '[서울숲/생태숲] 연중무휴<br>
[곤충식물원/나비정원] 매주 월요일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (48, '무료', '상시 개방', '종로구청 문화유산과 02-2148-2032', '탕춘대성은 조선 후기 도성방어체계를 보여주는 독특한 구조의 방어성으로, 한양의 도성과 북한산성을 연결하여 세운 성이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (49, NULL, '09:00~17:00<br>
※ 인터넷 사전 예약 필수', '02-2049-4061', '서울어린이대공원 정문 옆에 위치한 광나루안전체험관은 화재나 지진, 태풍 등 각종 재난 상황을 가상으로 설정하여 일반 시민들이 직접 체험하면서 안전교육을 받을 수 있는 국내 최초의 재난 체험관이다.', NULL, NULL);
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (50, '무료', '상시 개방', '여의도한강공원 02-3780-0561~6', '서울 색공원은 마포대교 교각과 둔치 사이의 하부공간에 색을 주제로 조성된 시민공원(약 9,000㎡)이다.', '가능 (1,782대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (51, '무료', '화요일~토요일 10:00~17:00<br>
※ 4월 1일~11월 30일에만 개관', '02-3675-3401~2', '성북동에 위치한 최순우 옛집은 우리 문화의 아름다움을 찾고 알린 혜곡 최순우(1916~1984) 선생이 1976년부터 1984년까지 거주한 주택이다.', '불가능', '매주 일요일~월요일 / 설·추석 당일 / 동절기(12월~3월)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (52, NULL, NULL, '02-2199-7245', '서빙고동 부군당은 조선시대 이 마을 주민들이 마을의 수호와 주민의 안녕을 위해 세운 제당이다.', NULL, NULL);
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (53, '무료', '상시 개방', '남산공원 02-3783-5900', '남산 팔각정은 남산타워와 함께 남산의 대표적 명소로 꼽히는 정자이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (54, '무료', '09:00~18:00 (입장 마감 17:30)', '종로구청 도시녹지과 02-2148-2842', '경희궁공원은 서울의 역사와 자연이 어우러진 아름다운 공간이다.', '가능', '매주 월요일 / 1월 1일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (55, '무료', '상시 개방', '02-731-0120', '원서공원은 현대건설이 현대그룹 사옥을 건립할 때 기업의 이익을 사회에 환원한다는 의미로 시민들의 휴식을 위해 도심에 녹지 공간을 조성한 것이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (56, NULL, '- 3월~10월 09:00~18:00<br>
- 11월~2월 09:00~17:00', '02-731-0534', '탑골공원 팔각정은 종로2가 탑골공원에 있는 누정으로 1989년 9월 19일 서울특별시 유형문화재로 지정되었다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (57, '- 개인 1,000원<br>
- 단체(10인 이상) 800원<br>
※ 덕수궁 미술관 이용자는 덕수궁 관람권 및 미술관 관람권 별도 구매 요망', '[일반관람] 09:00~21:00 (입장마감 20:00)<br>
[전시관]<br>
- 석조전 09:30~17:30 (마지막 해설 16:30)<br>
- 돈덕전 09:00~17:30 (입장마감 17:00)<br>
- 중명전	09:30~17:30(입장마감 17:00)', '02-771-9951', '대한문(大漢門)은 덕수궁의 정문으로 ‘대한’은 “한양이 창대해진다”라는 뜻이다.', '불가', '매주 월요일<br>
※ 단, 정기휴일이 공휴일 및 대체공휴일과 겹칠 경우에는 개방하며, 그 다음의 첫 번째 비공휴일이 정기휴일임');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (58, '무료', '- 하절기(4월~10월) 09:00~21:00<br>
- 동절기(11월~3월) 09:00~20:00', '02-6358-5533', '관훈동 30-1에 위치한 민씨 가옥은 조선 말기의 정치인이자 친일인명사전에 등록된 민영휘 일가가 거주한 곳이다.', '가능', '매주 월요일 (단, 월요일이 공휴일인 경우 정상 운영)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (59, '무료', '- 하절기 09:00~21:00<br>
- 동절기 09:00~20:00', '남산골한옥마을 02-6358-5533', '이 가옥은 순종의 장인인 해풍 부원군 윤택영이 그의 딸 순정황후가 1906년 황태자비로 책봉되어 창덕궁에 들어갈 때 지은 집이다.', '불가능', '매주 월요일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (60, '무료', '- 하절기(4월~10월) 09:00~21:00<br>
- 동절기(11월~3월) 09:00~20:00', '02-6358-5533', '순정효황후윤씨친가는 조선시대 최상류층 주택의 면모를 고스란히 보여주는 가옥이다.', '가능', '매주 월요일 (단, 월요일이 공휴일인 경우 정상 운영)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (61, '무료', '상시 개방', '1577-0606', '3·1독립운동기념탑은 일본 제국주의의 잔혹한 식민 통치로부터 조국과 민족의 독립을 위해 전개된 3·1독립운동의 숭고한 정신을 계승하고 발전시켜 널리 국민의 호국애족정신을 고양하고자 온 겨레의 정성을 모아 중구 장충동 남산공원에 건립되었다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (62, '무료', '상시 개방', '국가보훈부 1577-0606', '영등포구 당산동에 2006년 광복 후 혼란기, 6·25전쟁, 전후 시기에 전사하거나 순직한 이 지역 경찰의 영령을 추모하기 위해 ‘추모비’를 건립하였다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (63, '무료', '상시 개방', '1577-0606', '나석주의사동상은 조국을 위해 기꺼이 목숨을 바쳤던 나석주 의사의 숭고한 희생정신을 추모하기 위해 현재 외환은행 본점이 위치한 옛 동양척식주식회사 자리에 세워진 동상이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (64, '무료', '상시 개방', '서대문독립공원 관리사무소 02-3140-8305<br>
서대문구청 푸른도시과 02-330-1907', '일제가 우리나라의 국권을 침탈하고 지배하던 일제강점기에 수많은 애국선열들이 목숨을 걸고 일어나 항일 의병전쟁, 안중근, 강우규, 이봉창, 윤봉길 같은 의열투쟁, 3·1독립운동, 봉오동전투, 청산리전투 같은 독립군전투, 대한민국임시정부, 광복군 등에 참여하여 조국의 독립을 위해 싸우다가 순국하거나 혹은 일제에 체포되어 옥고를 치렀다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (65, '무료', '상시 개방', '공원녹지사업소 02-2125-0833', '안중근의사 동상은 독립운동에 투신하여 순국하신 안중근의사의 숭고한 뜻을 기리고 그 애국정신을 후세에 널리 전하기 위하여 2010년 10월 22일 재건립되었으며, 하얼빈역에서 이토 히로부미를 저격한 직후 태극기를 꺼내든 당당하고 떳떳한 모습으로 안중근의사 기념관의 입구에 위치한다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (66, NULL, '상시 개방<br>
※ 교내에 위치함으로 전화 문의 후 방문 바람', '배재고등학교 02-429-1885', '우남 이승만 박사 동상은 배재고등학교 내 자리한 동상으로 이승만 박사의 독립운동 업적을 기리기 위해 건립되었다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (67, '무료', '05:00~22:00', '국가보훈부 1577-0606', '천안 아우내 장터에서 독립만세운동을 주도하다 옥중에서 순국한 유관순 열사를 기리기 위해 1973년 어린이대공원 내 방문자센터 뒤편 계단 위에 유관순 열사 동상이 세워졌다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (68, '무료', '상시 개방', '02-2125-0848', '효창공원 안에 위치한 이봉창 의사 동상은 의사의 숭고한 애국심과 희생정신을 기리고자 동아일보사의 후원을 받아 건립한 동상이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (69, '무료', '상시 개방', '국가보훈부 1577-0606', '한강의 노들섬에 있는 이원등상사상은 거룩한 전우애와 희생정신을 보여준 이원등 상사의 정신을 본받기 위해 세운 동상이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (70, '무료', '상시 개방', '강동구 문화예술과 02-3425-5240', '독립운동가로 우리 민족의 자주독립과 민주주의 발전을 위해 헌신한 해공 신익희 선생의 공적을 기려 강동구청 주관으로 천호동에 동상을 건립하였다.', NULL, '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (71, '무료', '상시 개방', '국가보훈부 서울지방보훈청 02-3785-0815', '서울 서대문구 연희동에 서울 서쪽 관문인 104고지 탈환 작전 중 전사한 해병대 장병들을 추모하기 위해 해병대 사령부에서 1982년 9월 28일 이 비를 세웠다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (72, '무료', '점포별 상이함', '중구청 문화관광과 02-3396-4622', '명동, 남대문, 북창동, 다동무교동 관광특구는 서울 중심부에 있는 명동과 남대문, 북창동, 다동 무교동 일대의 외국인이 많이 찾는 쇼핑과 먹거리 명소를 말한다.', '가능', '점포별 상이함');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (73, '무료', '상시 개방', '서초구청 푸른도시과 02-2155-6889', '구룡산(306m)은 대모산과 하나의 줄기를 가진 산으로 서초구 염곡동과 강남구 개포동 일대에 위치해 있다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (74, '무료', '상시 개방', '중구청 문화재관리팀 02-3396-5842', '경성 부민관 폭탄 의거지는 경성부민관에서 친일파가 주도하는 대회를 방해하기 위해 폭탄을 터트린 곳이다.', '불가능', '매주 토요일~일요일 / 법정공휴일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (75, '무료', '상시 개방', '02-442-0001', '반공청년운동 기념비 건립위원회가 반공청년운동을 전개하다 순국한 애국열사들의 넋을 기리고 그들의 호국정신을 길이 계승하고자 1968년 10월 9일 중구 예장동 산5-6에 건립한 기념비이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (76, '- 전통한복 10,000원~<br>
- 테마한복 20,000원~<br>
※ 자세한 내용은 전화문의 요망', '09:00~19:00<br>
※ 시기에 따라 마감시간 변동됨으로 매장 문의', '0507-1435-0189', '지금은 한복 입혀주는 남자, ''한복남'' 이라는 이름으로 서울까지 진출했지만, 이전에는 전주에서 2012년부터 한복데이를 기획하여 사람들에게 한복의 아름다움을 알리는 데 큰 역할을 했었다.', NULL, '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (77, '무료', '상시 개방', '서초구청 정원여가과 02-2155-7167', '여의천은 서초구 신원동 청계산에서 발원하여 양재천으로 합류하는 지방하천이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (78, '16,000원<br>
※ 무료 : 36개월 미만<br>
※ 30% 할인 : 65세 이상 / 장애인(동반 1인 가능) / 군인·경찰·소방관(동반 3인 가능)<br>
※ 50% 할인 : 국가유공자', '10:00~18:00 (입장마감 17:00)', '02-2034-0600', '다이나믹 메이즈는 차원을 넘나들며 역동적인 체험을 즐길 수 있는 실내 익사이팅 프로그램이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (79, NULL, '업체별 상이', '02-2199-6114', '수도권 지하철 6호선 이태원역 3번 출구로 나와 보광초등학교 골목으로 올라가면 영어나 한국어 간판보다 아랍어 간판이 더 많은 풍경이 펼쳐지는 곳이 바로 이태원 이슬람거리의 시작이다.', NULL, '업체별 상이');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (80, '무료', '점포별 상이함', '02-833-8113', '대림동 차이나타운은 2000년대 초반 재중동포들이 대림역을 중심으로 정착하며 형성된 밀집 주거지형 차이나타운이다.', '가능', '점포별 상이함');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (81, '무료', '09:30~17:40<br>
※ 회차 별로 운영<br>
※ 사전 예약제', '02-3146-5946', '서울특별시 광진구 능동 서울어린이대공원에 위치한 아리수 나라는 전국 최초의 어린이 수돗물체험홍보관으로, 2010년 10월 26일 개관했다.', '가능 (720대)', '매주 월요일 / 1월 1일 / 설·추석 연휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (82, '무료', '10:00 / 14:00<br>
※ 사전 예약 필수', '대표전화 02-3146-5400<br>
체험안내 02-3146-5953 / 5415', '구의 아리수정수센터에서는 우리나라 정수시설의 변천사를 한눈에 볼 수 있는 곳이다.', '가능', '매주 토요일~일요일 / 법정공휴일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (83, '무료<br>
※ 이벤트 및 체험 프로그램 별로 별도 요금 발생할 수 있음', '10:00~20:00<br>
※ 프로그램에 따라 일부공간 탄력운영', '02-2153-0000', '꿈꾸고(Dream), 만들고(Design), 누린다(Play)는 뜻을 가지고 있는 DDP(동대문 디자인 플라자)는 서울특별시 동대문에 위치한 복합문화공간이다.', '가능', '1월 1일 / 설·추석 당일<br>
※ 시설 별로 상이하므로 자세한 사항은 홈페이지 참조');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (84, '[일반티켓]<br>
- 어른(만 13세 이상) 31,000원<br>
- 어린이(36개월 이상~만 12세 이하) 27,000원<br>
<br>
[Fast Pass] <br>
- 전 연령 62,000원<br>
<br>
[서울스카이 + 아쿠아리움 패키지]<br>
- 어른(만 13세 이상) 58,000원<br>
- 어린이(36개월 이상~만 12세 이하) 52,000원<br>
- 경로(만 65세 이상) 52,000원<br>
※ 자세한 사항은 홈페이지 참조', '- 월요일~목요일 10:30~22:00 (입장마감 21:00)<br>
- 금요일~토요일 10:30~23:00 (입장마감 22:00)<br>
- 일요일 10:30~22:00 (입장마감 21:00)<br>
- 공휴일 10:30~23:00 (입장마감 22:00)', '02-1661-2000', '세계 6위, 국내 최고 높이 123층, 555m 높이의 롯데월드타워에서 가장 높은 곳에 위치한 서울스카이 전망대는 국내에서 가장 높은 곳이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (85, '무료', '상시 개방', '02-3780-0501~4', '강동대교에서 잠실철교 사이에 있는 광나루 한강공원은 한강 상류로부터 유입된 토사가 퇴적되어 자연스럽게 형성된 모래톱과 대규모 갈대군락지로 자연 그대로의 한강의 모습을 가장 잘 유지하고 있는 공원이다.', '가능 (389대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (86, '[2시간 기준]<br>
- 어린이 15,000원 <br>
- 추가 10분 당 1,250원<br>
- 성인 5,000원', '10:30~18:30', '0507-1317-2523', '"Design Kids Digital Kids"를 뜻하는 디키디키는 디자인을 통한 어린이의 감성과 창의력을 키우는 공간으로, 유·아동기부터 문화, 예술, 산업 전반의 디자인 마인드를 자연스럽게 체득할 수 있는 디자인 활동이 가능한 대규모 놀이터이다.', '가능<br>
요금 (최초 15분 무료 / 5분당 400원)', '매주 월요일 / 설·추석 당일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (87, '- 얼굴관리 130,000원~<br>
- 몸관리 150,000원~<br>
- 산전·산후 관리 150,000원~', '10:00~20:00', '02-412-0100', '여용국은 조선 시대 안정복의 소설 ［여용국전］의 내용을 바탕으로 탄생했다.', '가능', '설·추석 당일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (88, '프로그램별 이용요금 상이', '- 평일 10:00~18:00<br>
- 주말 10:00~17:00', '02-730-1719', '올리바인 스파는 도심 속 럭셔리 스파와 뷰티&슬리밍센터를 운영하고 있다.', '가능 <br>
요금 (무료)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (89, '무료', '상시 개방', '02-860-2282', '함양 여씨 묘역은 서울특별시 구로구 고척2동에 위치한 함양 여씨 가문의 선영이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (90, '무료', '상시 개방', '에코스페이스 연의 02-2603-0203', '연의근린공원은 국내 유일의 생태환경 저류지 공원으로 환경부 신기술인 생태적 수질정화 비오톱 특허시스템을 도입해 조성하였다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (91, NULL, '상시 개방', '양천구청 공원녹지과 02-2620-3579', '지양산은 모든 주민들이 편리하게 산을 산책하며 숲을 이용할 수 있다.', NULL, '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (92, '무료', '상시 개방', '명동관광정보센터 02-778-0333', '명동은 거대 쇼핑도시를 연상케 하는 공간이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (93, '무료', '점포별 상이', '이태원 관광안내소 02-3785-0942', '우사단길은 한국적 정서와 이국적인 분위기가 어우러진 곳이다.', '불가능', '점포별 상이');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (94, '[싱글케어]<br>
- 얼굴 170,000원<br>
- 바디 170,000원<br>
- 하체+발 170,000원<br>
[멀티케어]<br>
- 1899 라인+진 라인 285,000원~340,000원<br>
- 자생 라인 285,000원~340,000원<br>
- 윤 라인 285,000원~340,000원<br>
※ 부위 별로 금액이 상이함<br>
[풀케어] 얼굴+전신+발+머리 395,000원<br>
※ 이용요금은 변동될 수 있으므로 자세한 사항은 홈페이지 참조', '10:00~22:00 <br>
※ 예약 필수', '02-557-8030', 'SPA 1899는 1899년부터 이어져온 홍삼 전문가인 한국인삼공사에 의해 탄생한 곳이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (95, '무료', '06:00~24:00', '02-2631-9368', '한강 중심부에 자리한 작은 봉우리섬 선유도는 예로부터 빼어난 풍광을 지닌 곳으로 예술가와 묵객시인들의 사랑을 받은 곳이었다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (96, '무료 ', '10:00~22:00', '02-6954-2910', '2019년 10월에 오픈한 안녕인사동은 다양한 먹거리, 즐길거리, 볼거리가 가득한 복합문화공간으로, 일상의 재미와 여유를 제공하며 시민들에게 휴식을 제공한다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (97, '무료', '05:00~22:00', '02-2686-3203', '푸른수목원은 인적 없던 공터를 친환경 공간으로 탈바꿈시켜 조성된 서울시 최초의 시립 수목원이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (98, '무료이나 체험 별로 비용이 상이함으로 홈페이지 참조', '10:30~20:30', '02-469-8600', '서울 성수동에 위치한 아모레 성수는 아모레퍼시픽이 제안하는 ‘아름다움’에 대해 차별화된 경험을 할 수 있는 뷰티 플래그십 공간이다.', '불가능', '매주 월요일 / 설·추석 당일');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (99, '무료', '상시 개방', '02-351-6114', '은평한옥마을은 은평구 진관동에 위치한 현대식 한옥마을이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (100, '무료', '상시 개방', '02-459-9451~2', '율현공원은 세곡 주택지구의 동남쪽 영역에 넓게 분포되어 있으며, 아파트 진입 도로를 기준으로 두 공간으로 나누어져 있다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (101, '무료', '상시 개방', '서울 관악구청 공원관리팀 02-879-6526', '관악산 공원 입구 자연학습장 계곡에 조성된 70m 길이의 물놀이장은 어린이들이 안전하게 이용할 수 있도록 수심이 낮고, 주 1회 수질검사와 상시 안전요원이 배치되어 있다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (102, '무료', '상시 개방', '02-3780-0521~4', '뚝섬한강공원에는 바닥에서 솟아오르는 시원한 물줄기를 감상할 수 있는 분수와 암벽 등반을 즐길 수 있는 벽천마당이 있다.', '가능 (674대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (103, '무료', '상시 개방', '서초구청 푸른도시과 02-2155-6883', '우면산은 높이 293m로 서초구 우면동과 서초동, 양재동 등지의 도심에서 쉽게 오를 수 있는 산이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (104, '무료', '상시 개방', '02-798-2457', '왜고개는 기와와 벽돌을 구워 공급하던 와서(瓦署)가 있던 데서 유래한 명칭이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (105, '무료', '05:00~22:00', '02-410-1114', '올림픽공원 사거리 인근 장미공원에서부터 한성백제박물관 사이 자그마한 언덕 경사로에 마련된 대규모 야생화 단지이다.', '가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (106, '무료 ', '[1월~2월 / 12월] 07:00~18:00<br>
[3월] 06:00~20:00<br>
[4월 / 9월] 05:30~20:00<br>
[5월] 05:00~20:00<br>
[6월~7월] 05:00~20:30<br>
[8월] 05:30~20:30<br>
[10월] 06:00~19:00<br>
[11월] 06:30~19:00', '월드컵공원 02-300-5500', '평화의 공원은 2002년 월드컵 경기를 기념하여 세계적인 화합과 평화를 상징하는 장소로 월드컵경기장과 강북강변로 사이에 조성된 공원이다.', '가능 (약 1848대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (107, '무료', '상시 개방', '여의도한강공원 02-3780-0561~6', '여의도한강공원 멀티프라자는 여의도 한강공원에 내에 위치한 잔디 광장으로, 서울의 대표적인 여가 공간 중 하나이다.', '가능 (1,782대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (108, '무료 ', '상시 개방', '02-3780-0541~4', '서울 반포대교와 잠수대교 한강 남단에 있는 반포한강공원의 중심 광장으로, 달의 모습을 형상화하여 만든 테마 광장이다.', '가능 (669대)', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (109, '무료', '10:00~18:00', '02-2231-5143', '박정희 전 대통령이 1958년부터 1961년 장충동의 국가재건최고회의 의장 공관으로 이주할 때까지 가족과 함께 생활했던 집이다.', '불가능', '매주 월요일 / 1월1일 / 설·추석 기념 행사시(사전공지 예정)');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (110, '※ 시설별 상이하므로 홈페이지 참고', '[축구장] 06:00~22:00<br>
[배드민턴장]<br>
- 1부 06:00~09:00<br>
- 2부 10:00~13:00<br>
- 3부 14:00~17:00<br>
- 4부 18:00~22:00<br>
[테니스장]<br>
- 실내 06:00~12:00 / 13:00~22:00<br>
※ 주말 및 공휴일은 21:00까지 운영<br>
- 실외 06:00~22:00', '02-901-5199', '다락원체육공원은 서울 도봉산 자락에 위치한 종합 체육공원이다.', '가능', '※ 시설별 상이하므로 홈페이지 참고');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (111, '[월요일~목요일]<br>
- 아침대관 45,000원<br>
- 점심대관 65,000원<br>
- 저녁대관 75,000원<br>
[금요일~일요일]<br>
- 아침대관 58,000원<br>
- 점심대관 78,000원<br>
- 저녁대관 88,000원<br>
※ 해당 요금은 2인 기준임<br>
※ 이용요금은 변동될 수 있으므로 자세한 사항은 전화 문의', '09:00~24:00', '070-8839-6552', '후암거실은 서울역 인근에 위치한 곳으로, 나만의 공간에서 영화를 볼 수 있는 아늑한 공간이다.', '불가능', '연중무휴');
INSERT INTO tblTouristSpot (place_id, admission_fee, opening_hours, contact_info, spot_overinfo, parking_info, rest_day) VALUES (112, '무료', '상시 개방', '서초구청 푸른도시과 02-2155-6865', '양재근린공원은 도심 속의 근린공원으로, 숲 속처럼 느껴지고 잘 가꾸어져 있어 많은 사람이 찾는 공원이다.', '가능', '연중무휴');





INSERT INTO tblKeyword (keyword_id, keyword) VALUES (1, '힐링');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (2, '인생샷');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (3, '맛집투어');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (4, '가족여행');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (5, '커플');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (6, '액티비티');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (7, '자연');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (8, '역사');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (9, '야경');
INSERT INTO tblKeyword (keyword_id, keyword) VALUES (10, '바다');

DROP TABLE tblkeyword CASCADE CONSTRAINTS;
CREATE TABLE tblKeyword (
    keyword_id            NUMBER            PRIMARY KEY,
    keyword        VARCHAR2(50)    NOT NULL
);


INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 13, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 13, 5);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 14, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 14, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 15, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 15, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 16, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 17, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 18, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 18, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 19, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 20, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 20, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 21, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 22, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 22, 5);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 23, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 24, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 24, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 24, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 25, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 26, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 26, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 27, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 28, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 28, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 29, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 29, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 30, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 31, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 31, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 32, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 32, 6);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 33, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 34, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 34, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 35, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 35, 5);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 36, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 37, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 38, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 39, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 40, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 41, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 42, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 42, 6);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 43, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 44, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 45, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 46, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 46, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 47, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 47, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 48, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 49, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 49, 6);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 50, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 51, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 51, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 52, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 53, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 54, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 54, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 55, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 56, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 57, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 58, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 59, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 60, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 61, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 62, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 63, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 64, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 65, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 66, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 67, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 68, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 69, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 70, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 71, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 72, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 72, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 73, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 74, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 75, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 76, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 76, 5);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 77, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 78, 6);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 78, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 79, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 80, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 81, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 82, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 83, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 83, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 84, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 84, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 85, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 85, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 86, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 87, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 88, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 89, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 90, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 91, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 92, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 93, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 94, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 95, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 95, 1);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 96, 3);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 97, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 97, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 98, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 99, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 99, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 100, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 101, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 101, 4);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 102, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 103, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 104, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 105, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 105, 2);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 106, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 107, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 108, 9);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 108, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 109, 8);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 110, 6);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 111, 5);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 112, 7);
INSERT INTO tblKeywordLink (keyword_link_id, place_id, keyword_id) VALUES (seqKeywordLink.nextVal, 112, 4);

commit;
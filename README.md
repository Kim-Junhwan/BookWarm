# BookWarm
## 2023년 7월 31일 새싹 11차 과제<br>

상단 우측 검색 버튼 클릭시 검색 화면이 fullScreen으로 present, X버튼 클릭시 dismiss 

![Simulator_Screen_Recording_-_iPhone_14_Pro_-_2023-08-01_at_00_49_20_AdobeExpress (2)](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/a22f6dde-0d5e-4850-ab43-76678d83cc1d)
<br>

콜렉션 뷰에서 셀 클릭시 해당 셀의 정보를 상세 화면에 전달하고, 전달된 정보는 상세화면에 표시. 상세 화면의 경우 스크롤 뷰를 이용해서 overview의 모든 내용이 나타나도록 구현

![Simulator_Screen_Recording_-_iPhone_14_Pro_-_2023-08-01_at_00_49_20_AdobeExpress (1)](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/5a41e72b-8b90-479d-a200-424c4905fb6c)

## 2023년 8월 2일 새싹 13차 과제 

테이블뷰의 헤더에 콜렉션 뷰 삽입. 각 셀 클릭시 디테일 화면 fullscreen으로 present. present할 시 디테일 화면에 dismiss하는 버튼이 보이도록 함.

![Simulator_Screen_Recording_-_iPhone_14_Pro_-_2023-08-02_at_23_21_28_AdobeExpress](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/55bdcdf4-6b5e-4fcc-bd47-cb316c115444)

## 2023년 8월 3일 새싹 14차 과제

- 메인화면에서 검색 버튼 클릭 시 검색바가 나오고, 검색할 텍스트를 입력할때마다 해당 단어를 포함하는 검색 결과를 실시간으로 표시

![Simulator_Screen_Recording_-_iPhone_14_Pro_-_2023-08-04_at_00_33_10_AdobeExpress](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/9a02bb26-f26b-4396-858e-6448aca5734e)

- 상세 화면 메모텍스트 뷰 플레이스 홀더 기능 구현
  
![Simulator_Screen_Recording_-_iPhone_14_Pro_-_2023-08-04_at_00_33_10_AdobeExpress (1)](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/ed9ea832-cef9-4c5d-80d1-faebe8d266b5)

## 2023년 8월 9일 과제 

- 카카오 검색 API를 이용한 책 검색 기능 구현

![Simulator_Screen_Recording_-_iPhone_14_-_2023-08-10_at_02_37_55_AdobeExpress (1)](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/fb2946b7-0c74-4539-885f-4f720f70fe39)

### 고민한 부분

UIScrollViewDelegate의 DidScroll로 페이징 기능을 구현 시 여러번 책 검색하는 메소드가 호출이 됨. 스크롤을 하고 있는 동안에 UIScrollViewDelegate의 didScroll는 짧은 시간동안 연속적으로 호출 되기 때문.
이를 해결하기 위해 flag를 사용하여 검색 메소드가 flag값이 false이면 검색을 수행하고 flag를 true로 변경, flag가 true일 시 검색을 수행하지 않도록 해서 여러번 호출되는 것을 막았다. flag가 false로 변경되는 시점은 사용자가 스크롤을 그만 두었을 때 false로 변경. 스크롤을 하고 있는 동안에 검색이 완료 되어서 또 호출 될 수 있기에 스크롤이 종료 되면 flag를 false로 변경하도록 하였음.

|flag 미사용|flag 사용| 
| --- | --- | 
|![화면_기록_2023-08-10_오전_2_52_24_AdobeExpress (1)](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/e92cfc9a-3dbb-4e89-ab87-9c65658f1105)|![화면_기록_2023-08-10_오전_2_49_47_AdobeExpress (1)](https://github.com/Kim-Junhwan/BookWarm/assets/58679737/5a4ec772-7069-43db-948d-1adc9ec3df31)|


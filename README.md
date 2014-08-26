패스트트랙아시아 레일즈 스터디 자료
---

* 기본적인 CRUD를 자세하게 설명하기 위해서 제작되고 있습니다.
* 자세한 내용은 git log 를 살펴봐주시면 감사하겠습니다.

- Gemfile의 15번 째 줄에서, therubyracer의 주석을 풀어준다.
( 실습환경인 ubuntu 같은 경우에는 기본적으로 javascript Runtime이 설치되어 있지 않다. )
- 주석을 푸신 이후에는 다시 bundle install 해주셔야 하는거 아시죠? ( = Gemfile 설치하기 )
- 우리는 무엇을 만들 예정이냐면, Post, Comment가 있는 기본적인 블로그를 만들 예정입니다.
- 순서는 기본적으로 모델을 생성하고, 라우팅을 설정하고, 컨트롤러와 뷰를 생성할 예정입니다.

Post Model
---
- Post Model 생성하기 > rails generate Model Post
- Post Model 정의하기 > vi PROJECT_ROOT/db/migrate/DATE_create_post.rb
- Post Model 실제로 생성하기 > rake db:migrate

Routing for Post
---
- 기본적으로 제공하는 RESTful Rouing 을 이용하자. > resources :posts

Post Controller, View
---
- PostsController 생성하기 > rails generate Controller Posts

Comment Model
---
- Comment Model 생성하기 > rails generate Model Comment
- Comment Model 정의하기

- Post Model과 연결하기

- Comment Model 실제로 생성하기

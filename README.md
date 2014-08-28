패스트트랙아시아 레일즈 스터디 자료
---

* 기본적인 CRUD를 자세하게 설명하기 위해서 제작되고 있습니다.
* 자세한 내용은 git log 를 살펴봐주시면 감사하겠습니다.

Rails 프로젝트 초기화
---
```
$ rails new PROJECT_NAME
```

실습환경인 Ubuntu 12.04의 경우에는 기본적으로 javascript Runtime이 설치되어 있지 않습니다.
따라서 javascript를 실행할 수 있는 therubyracer gem 을 추가적으로 설치해주어야 합니다.
`Gemfile`의 15번 째 줄에서, `therubyracer`의 주석을 풀어주시면 됩니다.

`Post` 모델을 정의하고 생성하기
---
```
$ rails generate model Post
```

물론 `rails generate model Post title:string content:string` 으로 바로 만들어도 괜찮지만,
직접 `db/migrate/DATE_create_post.rb`을 수정해서 모델을 정의해보자.

```
# db/migrate/DATE_create_posts.rb

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
```

```
$ rake db:migrate

== 20140826021041 CreatePosts: migrating ======================================
-- create_table(:posts)
   -> 0.0016s
== 20140826021041 CreatePosts: migrated (0.0017s) =============================
```

`Post`를 위한 라우팅
---
- 기본적으로 제공하는 RESTful Rouing 을 이용하자. > resources :posts

```
$ rake routes

    posts GET    /posts(.:format)                       posts#index
          POST   /posts(.:format)                       posts#create
 new_post GET    /posts/new(.:format)                   posts#new
edit_post GET    /posts/:id/edit(.:format)              posts#edit
     post GET    /posts/:id(.:format)                   posts#show
          PATCH  /posts/:id(.:format)                   posts#update
          PUT    /posts/:id(.:format)                   posts#update
          DELETE /posts/:id(.:format)                   posts#destroy
```

`Post` CRUD
---
```
$ rails generate Controller Posts
```

Comment Model
---
- Comment Model 생성하기 > rails generate Model Comment
- Comment Model 정의하기

- Post Model과 연결하기

- Comment Model 실제로 생성하기

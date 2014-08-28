패스트트랙아시아 레일즈 스터디 자료
---

* 기본적인 CRUD를 자세하게 설명하기 위해서 제작되고 있습니다.
* 자세한 내용은 git log 를 살펴봐주시면 감사하겠습니다.

ScreenCast
---
#### 1. `Post` CRUD ( Basic CRUD )
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/pMi3JImoznM/0.jpg)](http://www.youtube.com/watch?v=pMi3JImoznM)

#### 2. `Comment` CRUD ( Relational Modeling )

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
직접 `match`를 이용해서 라우팅을 해도 상관 없지만 `Post` CRUD에 대한 기본적인 라우팅은 레일즈에서
기본적으로 제공하는 `resources`를 이용하면 쉽게 해결할 수 있다.
`match`를 이용하여 직접적으로 `url`과 `http method`를 명시하는 방식은 `routes.rb` 주석으로 추가해두었다.
( [config/routes.rb](https://github.com/dobestan/rails_fasttrackasia/blob/master/config/routes.rb) )

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
사실 CRUD에서 가장 헷갈리는 부분이 전체적인 큰 프로세스를 이해하는 부분이라고 생각한다.
큰 프로세스에 대한 이해는 이미 했다고 가정하고 과정 중에서 조금씩 헷갈리는 부분들을 집중적으로
설명하도록 한다.


#### Q. form_for는 대체 어떻게 사용하는건가요?
우리는 html에서 기본적으로 있는 `<form><form>`을 사용하지 않고 레일즈에서 제공하는 `form_for`을 사용하였다.
그 이유는 수업 시간에도 설명했지만, html의 form을 사용하는 것 보다 한단계 더 높은 추상화이고 기본적으로
`CSRF_Token`을 포함하고 있어서 더 높은 수준의 보안을 제공한다.

`form_for`에 대해서는 얘기할 부분이 굉장히 많지만, 아래의 두 가지만 비교하고 이해하고 넘어가는걸로 하자.
이 부분에 대해서는 논란의 여지가 있을 수 있는데 개인적으로는 명시적인 전자의 방식보다
두번째의 @post 객체를 그대로 사용하는 방식이 더 좋다고 생각한다.

```
<%= form_for :post, url: posts_path, method: :post do |f| %>
```

이 방식의 경우 `form_for`는 이 데이터가 어떤 데이터인지 알지 못한다.
다만, `:post`라는 이름을 가지고 있음을 알 뿐이다.
그래서 직접적으로 `method: :post`, `url: posts_path` 등을 명시해주어야한다.

```
<%= form_for @post do |f| %>
```

반면에, `:post`가 아니라 `@post`를 사용하였을 때, 컨트롤러에서 `@post = Post.new()`로 넘겨 주었기 때문에,
`form_for`는 이 데이터가 `Post` 데이터이고 만약 현재 action이 `new`라면 `create`로,
`edit`라면 `update`로 넘겨주어야함을 알고 있다. 따라서 명시적으로 `url`이나 `method`를 알려줄 필요가 없다.


`Comment` 모델 생성하고 관계 정의하기
---
그냥 상식적으로 생각하면 굉장히 쉽다. `Post` 모델과 `Comment` 모델의 관계를 정의해주려면 어떻게 하면 될까?

1. `Comment` 모델은 `Post`에 대한 정보를 가지고 있어야 한다.
2. `Post`는 여러 개의 `Comment`를 가지고 있다는 것을 알고 있어야 한다.
3. `Comment`는 단 하나의 `Post`에 속해 있음을 알고 있어야 한다.

위의 세 가지 아이디어를 그대로 코드로 옮기면 된다.

```
$ rails generate model Comment
```

#### 1. `Comment` 모델은 `Post`에 대한 정보를 가지고 있어야 한다.
```
# db/migrate/DATE_create_comment.rb

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :content
      t.references :post # 여기 부분에 post에 대한 정보를 명시한다. ( 실제로는 post_id를 저장 )

      t.timestamps
    end
  end
end
```

#### 2. `Post`는 여러 개의 `Comment`를 가지고 있다는 것을 알고 있어야 한다.
```
# app/models/post.rb

class Post < ActiveRecord::Base
  has_many :comments
end
```

#### 3. `Comment`는 단 하나의 `Post`에 속해 있음을 알고 있어야 한다.
```
# app/models/comment.rb

class Comment < ActiveRecord::Base
  belongs_to :post
end
```

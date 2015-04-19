# postapi json app


This README would normally document whatever steps are necessary to get the
application up and running.

#### Models and properties:

- Users # have name, city
- Posts # have an author, title, content, timestamps
- Images # have a parent post
- Comments # a nested/threaded list (a comment can have children comments & threads)

The app should have a JSON API that has the following endpoints / cases:

#### Posts

- list - return most recent posts, as an array of
  - id, title, author_name, author_city, array of images
- create
- view an individual post
- update post
- delete a post

#### Images

- add image to a post
- delete image

#### Comments

- list comments for a post
- create a comment
- delete a comment / comment thread you've created.

List of commands

* rake db:create db:migrate
* bundle install
* rails generate bootstrap:install less
* rake routes
* rails s

## User

### Create User:

```
curl -X POST http://localhost:3000/users.json -H "Content-Type: application/json" --data  '{ "user": {"name": "sachin maharjan", "city": "san francisco" } }'

{
  "id": 1,
  "name": "sachin maharjan",
  "city": "san francisco",
  "created_at": "2015-04-19 18:52:10 UTC",
  "updated_at": "2015-04-19 18:52:10 UTC"
}
```

## Post

### Post lists

```
curl -X GET http://localhost:3000/posts/list.json
```

### Createa a post

```
curl -X POST http://localhost:3000/posts.json -H "Content-Type: application/json" --data  '{ "post": {"user_id": 1, "author": "sachin maharjan", "title": "some title", "content" : "some content here" } }'
```

Response:

```
{
  "id": 5,
  "author": "sachin maharjan",
  "title": "some title",
  "content": "some content here",
  "created_at": "2015-04-17 06:37:53 UTC",
  "updated_at": "2015-04-17 06:37:53 UTC",
  "user_id": 1
}
```

### Invalid Request:

```
curl -X POST http://localhost:3000/posts.json -H "Content-Type: application/json" --data  '{ "post": {"user_id": 1, "author": "", "title": "", "content" : "some content here" } }'
```

Response:

```
{
  "author": [
    "can't be blank"
  ],
  "title": [
    "can't be blank"
  ]
}
```

### View Individual Post:

```
curl -X GET http://localhost:3000/posts/1

{
  "id": 1,
  "author": "Sachin Maharjan",
  "title": "How was you day?",
  "content": "Today was a great day.",
  "created_at": "2015-04-16 20:29:12 UTC",
  "updated_at": "2015-04-17 06:30:05 UTC",
  "user_id": 1
}
```

### Update a post

```
curl -X PUT http://localhost:3000/posts/1 -H "Content-Type: application/json" --data  '{ "post": {"id": 1, "author": "samwise gamjie"} }'

{
  "id": 1,
  "author": "samwise gamjie",
  "title": "How was you day?",
  "content": "Today was a great day.",
  "created_at": "2015-04-16 20:29:12 UTC",
  "updated_at": "2015-04-17 06:56:27 UTC",
  "user_id": 1
}
```

### Delete a post

```
curl -X DELETE http://localhost:3000/posts/3
{ Successfully deleted post.}
```

## Image
### Createa a image

```
curl -X POST http://localhost:3000/images.json -H "Content-Type: application/json" --data  '{ "image": {"post_id": 1, "path": "http://upload.wikimedia.org/wikipedia/commons/4/4e/Mavericks_Surf_Contest_2010b.jpg"} }'

{
  "id": 2,
  "post_id": 1,
  "path": "http://upload.wikimedia.org/wikipedia/commons/4/4e/Mavericks_Surf_Contest_2010b.jpg",
  "created_at": "2015-04-17 07:22:45 UTC",
  "updated_at": "2015-04-17 07:22:45 UTC",
  "deleted": false
}
```


### Delete an image

```
curl -X DELETE http://localhost:3000/images/2

{ Successfully deleted image.}
```

## Comment

### Commets lists

```
curl -X GET http://localhost:3000/comments/list.json -H "Content-Type: application/json" --data  '{"post_id": 1
```


### Create Comment

```
curl -X POST http://localhost:3000/comments -H "Content-Type: application/json" --data  '{ "comment": {"post_id": 1, "message": "hey this is first comment"} }'

{
  "id": 1,
  "post_id": 1,
  "parent_id": null,
  "message": "hey this is first comment",
  "created_at": "2015-04-17 14:53:40 UTC",
  "updated_at": "2015-04-17 14:53:40 UTC"
}
```

```
curl -X POST http://localhost:3000/comments -H "Content-Type: application/json" --data  '{ "comment": {"post_id": 1, "message": "hey this is second comment"} }'

{
  "id": 2,
  "post_id": 1,
  "parent_id": null,
  "message": "hey this is second comment",
  "created_at": "2015-04-17 14:55:24 UTC",
  "updated_at": "2015-04-17 14:55:24 UTC"
}
```

### Commets lists

```
curl -X GET http://localhost:3000/comments/list.json -H "Content-Type: application/json" --data  '{"post_id": 1 }'

[
  {
    "id": 1,
    "post_id": 1,
    "parent_id": null,
    "message": "hey this is first comment",
    "created_at": "2015-04-17 14:53:40 UTC",
    "updated_at": "2015-04-17 14:53:40 UTC"
  },
  {
    "id": 2,
    "post_id": 1,
    "parent_id": null,
    "message": "hey this is second comment",
    "created_at": "2015-04-17 14:55:24 UTC",
    "updated_at": "2015-04-17 14:55:24 UTC"
  }
```

### Delete a comment

```
curl -X DELETE http://localhost:3000/comments/2

{ Successfully deleted post.}
```

### Create Comment on Comment
```
curl -X POST http://localhost:3000/comments -H "Content-Type: application/json" --data  '{ "comment": {"post_id": 1, "parent_id": 1, "message": "hey this is comment on comment"} }'

{
  "id": 3,
  "post_id": 1,
  "parent_id": 1,
  "message": "hey this is comment on comment",
  "created_at": "2015-04-17 15:02:08 UTC",
  "updated_at": "2015-04-17 15:02:08 UTC"
}
```

## Reports

### Get activities by city
```
curl -X GET http://localhost:3000/reports

or

curl -X GET http://localhost:3000/report/activities_by_city

[
 {
   "city": "San Francisco",
   "id": 1,
   "author": "samwise gamjie",
   "title": "How was you day?",
   "content": "Today was a great day.",
   "created_at": "2015-04-17 14:53:40 UTC",
   "updated_at": "2015-04-17 17:38:39 UTC",
   "user_id": 5,
   "post_id": 1,
   "parent_id": null,
   "message": "hey this is first comment"
 },
 {
   "city": "San Francisco",
   "id": 3,
   "author": "samwise gamjie",
   "title": "How was you day?",
   "content": "Today was a great day.",
   "created_at": "2015-04-17 15:02:08 UTC",
   "updated_at": "2015-04-17 17:39:12 UTC",
   "user_id": 5,
   "post_id": 1,
   "parent_id": 1,
   "message": "hey this is comment on comment"
 },
 {
   "city": "San Francisco",
   "id": 4,
   "author": "sachin maharjan",
   "title": "some title",
   "content": "some content here",
   "created_at": "2015-04-17 17:08:48 UTC",
   "updated_at": "2015-04-17 17:39:20 UTC",
   "user_id": 5,
   "post_id": 7,
   "parent_id": 1,
   "message": "hey this is comment on comment"
 },
 {
   "city": "san antonio",
   "id": null,
   "author": null,
   "title": null,
   "content": null,
   "created_at": null,
   "updated_at": null,
   "user_id": null,
   "post_id": null,
   "parent_id": null,
   "message": null
 },
 {
   "city": "san francisco",
   "id": null,
   "author": null,
   "title": null,
   "content": null,
   "created_at": null,
   "updated_at": null,
   "user_id": null,
   "post_id": null,
   "parent_id": null,
   "message": null
 }
]
```
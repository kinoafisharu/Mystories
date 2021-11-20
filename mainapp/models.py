import pydantic
from tortoise.models import Model
from tortoise import models, fields, Tortoise


class User(models.Model):
    """Модель пользователя"""
    id = fields.IntField(pk=True)
    nickname = fields.CharField(max_length=20)
    email = fields.CharField(max_length=100, unique=True)
    password = fields.CharField(max_length=1000)
    first_name = fields.CharField(max_length=100)
    last_name = fields.CharField(max_length=100, null=True)
    birthdate = fields.DatetimeField(auto_now_add=True)
    is_active = fields.BooleanField(default=True)
    created_at = fields.DatetimeField(auto_now_add=True)
    modified_at = fields.DatetimeField(auto_now=True)
    avatar = fields.CharField(max_length=100, null=True)

    class PydanticMeta:
        exclude = ('comments', 'password')

    def __str__(self):
        return self.name


class StoryCategory(models.Model):
    """ Категории историй """
    name = fields.CharField(max_length=50)
    published = fields.BooleanField(default=True)
    parent: fields.ForeignKeyNullableRelation['StoryCategory'] = fields.ForeignKeyField(
        'models.BlogCategory', on_delete=fields.CASCADE, null=True, related_name='children'
    )
    description = fields.TextField(max_length=300)
    children: fields.ReverseRelation["StoryCategory"]
    posts: fields.ReverseRelation["Post"]

    def __str__(self):
        return self.name

    class PydanticMeta:
        backward_relations = False
        exclude = ('posts', 'parent')
        allow_cycles = True
        max_recursion = 3


class Tag(models.Model):
    """ Модель тэгов """
    name = fields.CharField(max_length=50, unique=True, null=True)
    posts: fields.ManyToManyRelation['Post']

    def __str__(self):
        return self.name


class Post(models.Model):
    """ Модель историй """
    author: fields.ForeignKeyRelation['User'] = fields.ForeignKeyField(
        'models.User', related_name='posts', on_delete=fields.CASCADE
    )
    tag: fields.ManyToManyRelation["Tag"] = fields.ManyToManyField(
        'models.Tag', through='post_tag', null=True, related_name='posts'
    )
    category: fields.ForeignKeyNullableRelation[StoryCategory] = fields.ForeignKeyField(
        'models.BlogCategory', null=True, related_name='posts', on_delete=fields.SET_NULL
    )
    title = fields.CharField(max_length=500)
    mini_text = fields.TextField(max_length=5000)
    text = fields.TextField()
    create_at = fields.DatetimeField(auto_now_add=True)
    publish_at = fields.DatetimeField(auto_now=True)
    image = fields.CharField(max_length=500, null=True)
    is_published = fields.BooleanField(default=True)
    comments: fields.ReverseRelation["Comment"]

    def __str__(self):
        return self.title

    class PydanticMeta:
        exclude = ('comments',)


class Comment(models.Model):
    """ Comment class """
    user: fields.ForeignKeyRelation['User'] = fields.ForeignKeyField(
        'models.User', related_name="comments", on_delete=fields.CASCADE
    )
    post: fields.ForeignKeyRelation[Post] = fields.ForeignKeyField(
        'models.Post', related_name="comments", on_delete=fields.CASCADE
    )
    parent: fields.ForeignKeyNullableRelation['Comment'] = fields.ForeignKeyField(
        "models.Comment",
        on_delete=fields.SET_NULL,
        null=True,
        related_name='children'
    )
    text = fields.TextField(max_length=2000)
    create_at = fields.DatetimeField(auto_now_add=True)
    update_at = fields.DatetimeField(auto_now=True)
    is_published = fields.BooleanField(default=True)
    is_deleted = fields.BooleanField(default=False)

    children: fields.ReverseRelation["Comment"]

    def __str__(self):
        return "{} - {}".format(self.user, self.post)

    class PydanticMeta:
        exclude = ('post',)


Tortoise.init_models(["src.app.blog.models"], "models")
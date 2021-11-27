TORTOISE_ORM = {
    "connections": {"default": "postgres://story_client:123@localhost:5432/story"},
    "apps": {
        "models": {
            "models": ["models", "aerich.models"],
            "default_connection": "default",
        },
    },
}
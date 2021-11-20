from fastapi import FastAPI
from pydantic import BaseModel


app = FastAPI()

# from  импортировать модели

TORTOISE_ORM = {
    "connections": {"default": DATABASE_URI},
    "apps": {
        "models": {
            "models": APPS_MODELS,
            "default_connection": "default",
        }
    },
}
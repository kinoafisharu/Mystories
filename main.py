from fastapi import FastAPI
import uvicorn

from models import User, StoryCategory, Tag, Post, Comment

app = FastAPI()


if __name__ == "__main__":
    uvicorn.run("main:app", port=8000, reload=True)
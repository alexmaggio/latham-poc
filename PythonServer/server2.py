from hashlib import sha256
from fastapi import FastAPI, Form
from fastapi import File, UploadFile
import datetime

# FastAPI Server
app = FastAPI()

@app.post("/login")
async def login(username: str = Form(default=""), password: str = Form(default="")):
    # sha256 of password
    sha256_password = sha256(password.encode()).hexdigest()
    return {"username": username, "password": sha256_password}

# Returns the date
@app.get("/date")
async def get_date():
    current_date_time_utc = datetime.datetime.now()
    return {"date": current_date_time_utc}

@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    request_rx_time = datetime.datetime.now()
    # Get the size of UploadFile
    fs = await file.read()
    # sha256 of UploadFile
    sha256_file = sha256(fs).hexdigest()
    # file_size in MB, rounded to 2 decimal places
    file_size = round(len(fs) / (1024 * 1024), 2)
    file_size_string = str(file_size) + " MB"
    after_read_time = datetime.datetime.now()
    # Time to read file in seconds
    time_to_read = (after_read_time - request_rx_time).total_seconds()
    return {
        "filename": file.filename,
        "content_type": file.content_type,
        "size": file_size_string,
        "read_time": time_to_read,
        "sha256": sha256_file
        }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=8000)

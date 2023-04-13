from flask import Flask,request

import json,requests,boto3

from aws_xray_sdk.core import xray_recorder,patch_all

patch_all()

from aws_xray_sdk.ext.flask.middleware import XRayMiddleware # https://docs.aws.amazon.com/xray/latest/devguide/xray-sdk-python-middleware.html#xray-sdk-python-adding-middleware-flask

app=Flask(__name__)

xray_recorder.configure(service='XRay test app')
XRayMiddleware(app, xray_recorder)

@app.route("/hello")
def hello():
  s3 = boto3.client('s3')

  ip = requests.get("http://ipinfo.io/ip")
  response = s3.list_buckets()

  return json.dumps({
            "message": "hello world",
            "location": ip.text.replace("\n", ""),
            "buckets": [x["Name"] for x in response["Buckets"]]
        })

@app.route("/")
def test():
    return "OK"
    
@app.route("/headers")    
def headers():
    print(dict(request.headers))
    return dict(request.headers)
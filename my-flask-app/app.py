from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "🎉 Hello from Flask running on Azure Kubernetes Service! making cherry pick hands on"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

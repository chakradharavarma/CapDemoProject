from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def main():
    return "42"

if __name__=="__main__":
    app.run()
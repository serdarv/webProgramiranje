import flask
import json
import os
import fnmatch
from flask import request
from flask import Blueprint
from utils.db_connection import mysql

user_services = Blueprint("user_services", __name__)

@user_services.route("/", methods=["GET"])
def users():
    cursor = mysql.get_db().cursor()
    cursor.execute("SELECT id, username, name, surname FROM user")
    rows = cursor.fetchall()

    return flask.jsonify(rows)

@user_services.route("/<int:user_id>", methods=["GET"])
def user(user_id):
    cursor = mysql.get_db().cursor()
    cursor.execute("SELECT id, username, name, surname FROM user WHERE iduser=%s", user_id)
    row = cursor.fetchone()

    return flask.jsonify(row)

@user_services.route("/<int:user_id>", methods=["PUT"])
def update_user(user_id):
    # Izdvaja podatke o korisniku iz multipart zahteva
    data = json.loads(request.form.to_dict()["userData"])
    db = mysql.get_db()
    cursor = db.cursor()
    cursor.execute("UPDATE user SET name=%s, surname=%s WHERE id=%s", (data["name"], data["surname"], user_id))
    db.commit()

    # Ukoliko je poslata avatar slicica, sacuvaj je
    if request.files.get("avatar") is not None:
        uploaded_file = request.files.get("avatar")
        # Jedino sto je bitno je ekstenzija, ime datoteke ce svakako
        # biti promenjeno.
        ext = os.path.splitext(uploaded_file.filename)[1]

        # Pre zapisivanja datoteke obavezno bi trebalo
        # proveriti ispravnost imena datoteke, medjutim
        # posto se ime datoteke kreira na serveru to u ovom
        # slucaju nije neophodno.
        # Detaljnije na: http://flask.pocoo.org/docs/0.12/patterns/fileuploads/

        # Dobavljanje naziva slike korisnika.
        uploaded_file.save("static/media/avatars/user_{0}{1}".format(data["id"], ext))

        # Uklanja sve slike sem trenutno dodate
        files = os.listdir("static/media/avatars")
        avatars = fnmatch.filter(files, "user_{0}.*".format(data["id"]))
        for avatar in avatars:
            if os.path.splitext(avatar)[1] != ext:
                os.remove(os.path.join("static/media/avatars", avatar))
        

    return flask.jsonify({"success": True})

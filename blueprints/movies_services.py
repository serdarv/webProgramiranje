import datetime
import flask
# Dobavljanje klase blueprint iz flask modula.
from flask import Blueprint
from utils.db_connection import mysql
from flask import request
from flask import session

movies_services = Blueprint("movies_services", __name__)

@movies_services.route("/", methods=["GET"])
def movies():
	cursor = mysql.get_db().cursor()
	cursor.execute("SELECT * FROM movie")
	rows = cursor.fetchall()

	if session.get("user") is not None:
		cursor.execute("SELECT * FROM voted where user_iduser=%s",session.get('user')['iduser'])

		data = cursor.fetchall()
		print(data);
		for r in rows:
			for d in data:
				if(d['movie_idmovie']==r['idmovie']) :
					r['myVote'] = d['myVote'];

	return flask.jsonify(rows)

@movies_services.route("/<int:vote>/<int:movie_id>/<int:user_id>", methods=["GET"])
def rating(vote,movie_id,user_id):
	cursor = mysql.get_db().cursor()

	cursor.execute("SELECT * from voted where user_iduser=%s and movie_idmovie=%s",(user_id,movie_id));

	rows = cursor.fetchone();

	cursor.execute("SELECT * from movie where idmovie=%s",(movie_id));
		
	movie = cursor.fetchone();

	if rows==None:

		cursor.execute("insert into voted (myVote,user_iduser,movie_idmovie) values (%s,%s,%s)",(vote,user_id,movie_id));

		vote_average = (movie['vote_count']*movie['vote_average']+vote*2)/(movie['vote_count']+1);

		cursor.execute("update movie set vote_count=%s,vote_average=%s where idmovie=%s",(movie['vote_count']+1,vote_average,movie_id));

	else:

		cursor.execute("update voted set myVote="+str(vote)+" where idvoted="+str(rows['idvoted']));
		
		vote_average = (movie['vote_count']*movie['vote_average']-int(rows['myVote'])*2+vote*2)/(movie['vote_count']);

		cursor.execute("update movie set vote_count=%s,vote_average=%s where idmovie=%s",(movie['vote_count'],vote_average,movie_id));

	mysql.get_db().commit();

	cursor.execute("SELECT * from movie");

	rows = cursor.fetchall()

	if session.get("user") is not None:
		cursor.execute("SELECT * FROM voted where user_iduser=%s",session.get('user')['iduser'])

		data = cursor.fetchall()
		print(data);
		for r in rows:
			for d in data:
				if(d['movie_idmovie']==r['idmovie']) :
					r['myVote'] = d['myVote'];

	return flask.jsonify(rows)


@movies_services.route("/post", methods=["POST"])
def edit():

	json = request.get_json();
	json['release_date'] = json['release_date'][ 0 : 10];

	cursor = mysql.get_db().cursor()

	cursor.execute("update movie set name=%s,imbd_id=%s,release_date=%s,runtime=%s,overview=%s where idmovie=%s",(json['name'],json['imbd_id'],json['release_date'],json['runtime'],json['overview'],json['idmovie']));

	mysql.get_db().commit();

	return "Updated"


@movies_services.route("/delete/<int:id>", methods=["DELETE"])
def delete(id):

	cursor = mysql.get_db().cursor()

	cursor.execute("delete from voted where movie_idmovie=%s",id);
	cursor.execute("delete from movie where idmovie=%s",id);

	mysql.get_db().commit();

	return "Deleted"


@movies_services.route("/newMovie", methods=["POST"])
def newMovie():

	json = request.get_json();
	json['release_date'] = json['release_date'][ 0 : 10];

	cursor = mysql.get_db().cursor()
	print(json['movie_image']);

	if json['genre_idgenre']!='':
		cursor.execute("insert into movie (name, imbd_id, release_date, runtime, vote_count, vote_average, genre_idgenre, language_idlanguage, overview,movie_image) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(json['name'],json['imbd_id'],json['release_date'],json['runtime'],json['vote_count'],json['vote_average'],json['genre_idgenre'],json['language_idlanguage'],json['overview'],json['movie_image']));
	else :
		cursor.execute("insert into movie (name, imbd_id, release_date, runtime, vote_count, vote_average, genre_idgenre, language_idlanguage, overview,movie_image) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(json['name'],json['imbd_id'],json['release_date'],json['runtime'],json['vote_count'],json['vote_average'],'1','1',json['overview'],json['movie_image']));		
	mysql.get_db().commit();

	return "Added"


@movies_services.route("/<order>", methods=["GET"])
def orderMovies(order):
	cursor = mysql.get_db().cursor()
	print(("SELECT * FROM movie order by %s",order));
	cursor.execute("SELECT * FROM movie order by "+order)
	rows = cursor.fetchall()

	if session.get("user") is not None:
		cursor.execute("SELECT * FROM voted where user_iduser=%s",session.get('user')['iduser'])

		data = cursor.fetchall()
		print(data);
		for r in rows:
			for d in data:
				if(d['movie_idmovie']==r['idmovie']) :
					r['myVote'] = d['myVote'];

	# print(rows);

	return flask.jsonify(rows)


@movies_services.route("/genres", methods=["GET"])
def genres():
	cursor = mysql.get_db().cursor()

	cursor.execute("SELECT * FROM genre")
	rows = cursor.fetchall()

	# print(rows);

	return flask.jsonify(rows)

@movies_services.route("/languages", methods=["GET"])
def languages():
	cursor = mysql.get_db().cursor()

	cursor.execute("SELECT * FROM language")
	rows = cursor.fetchall()

	# print(rows);

	return flask.jsonify(rows)
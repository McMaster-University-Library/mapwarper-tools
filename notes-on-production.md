create new postgres with same options as dev postgres
assign password to db 'cos I don't think rails prod works without pw, edit databases.yml for production with user (jbfink) and pw.
dump dev db with -c option, load into prod (see below, under "---")
tell rails to static serve assets (check where this is, grep for jbfink)
        config/environments/production.rb , add:
        config.serve_static_assets = true
        (this fixes thumbnails)


edit application.yml to take out references to /var/etc under production
        (this fixes the actual images)


got this by poring over production logs. Sheesh.


---

rails does not have a facility within itself to migrate the *data* in a db, 
just the schema. Which, yes, may be Best Practice, but to hell with that. Here's how I did a "migration" with postgres. Note that I think "-c" makes drops explicit, e.g. does a full-on db wipe-and-replace when you load:

pg_dump -c mapwarper_development > dev.sql
psql -U jbfink -d mapwarper_production  < dev.sql

this seems to work with the db but images/thumbnails are busted after, cc: homuth. If I fix this, put fix here.


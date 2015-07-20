docker rm -f jekyll
docker run --rm -v "/$PWD:/src" -p 4000:4000 --name jekyll grahamc/jekyll serve -H $CLIENT_IP --drafts --force_polling

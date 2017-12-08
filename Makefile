prepare:
	docker run --rm --tty --volume `pwd`/bin:/base debian:jessie sh /base/fetchlibc.sh

image:
	docker build -t cisco-lab:latest .

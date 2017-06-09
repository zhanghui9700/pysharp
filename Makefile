.PHONY: help

DASHBOARD_PATH?=$(PWD)
DASHBOARD_PATH:=$(abspath $(DASHBOARD_PATH))
BAZAAR_PATH:=$(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../eonbazaar)
PYTHON_PATH=$(DASHBOARD_PATH)/.venv/bin/python

help:
	@echo 'how to use:'
	@echo 'make prepare|client|run'

static:
	.venv/bin/python xweb/manage.py collectstatic -c --noinput

migrate:
	.venv/bin/python xweb/manage.py migrate

venv:
	virtualenv .venv
	.venv/bin/pip install -r requirements.txt

client:
	@echo 'barzaar path: ' $(BAZAAR_PATH)
	@echo 'dashboard path: ' $(DASHBOARD_PATH)
	@echo 'python: ' $(PYTHON_PATH)
	cd $(BAZAAR_PATH)/ceph_manager_client && ($(PYTHON_PATH) setup.py install)
	cd $(BAZAAR_PATH)/salt_api_client && ($(PYTHON_PATH) setup.py install)
	cd $(BAZAAR_PATH)/monitor/alert_api && ($(PYTHON_PATH) setup.py install)
	cd $(BAZAAR_PATH)/monitor/monitor_api && ($(PYTHON_PATH) setup.py install)

run: migrate
	.venv/bin/python xweb/manage.py runserver 0.0.0.0:8001

superuser:
	echo "from django.contrib.auth.models import User; User.objects.filter(username='admin').delete(); User.objects.create_superuser(username='admin', email='admin@example.com',password='password')" | .venv/bin/python xweb/manage.py shell

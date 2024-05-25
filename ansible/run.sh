#!/bin/bash

# Run playbooks

ansible-playbook -u 'antonio.medeiros' -i ./ansible/inventory --private-key .ssh/google_compute_engine -e 'pub_key=.ssh/google_compute_engine.pub' ./ansible/install-nfs-server.yml

ansible-playbook -u 'antonio.medeiros' -i ./ansible/inventory --private-key .ssh/google_compute_engine -e 'pub_key=.ssh/google_compute_engine.pub' ./ansible/mount-nfs.yml
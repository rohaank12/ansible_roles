---
- name: Install unzip and curl if not present
  apt:
    name:
      - unzip
      - curl
    state: present
    update_cache: yes

- name: Download Terraform zip
  get_url:
    url: "{{ terraform_download_url }}"
    dest: "/tmp/terraform_{{ terraform_version }}.zip"
    mode: '0644'

- name: Unzip Terraform binary
  unarchive:
    src: "/tmp/terraform_{{ terraform_version }}.zip"
    dest: /usr/local/bin/
    remote_src: yes
    mode: '0755'

- name: Verify Terraform installation
  command: terraform --version
  register: terraform_version_check
  changed_when: false

- name: Show installed Terraform version
  debug:
    msg: "{{ terraform_version_check.stdout }}"

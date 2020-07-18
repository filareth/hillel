import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'


def test_epel_release(host):
    epelrelease = host.package("epel-release")
    assert epelrelease.is_installed


def test_vim(host):
    vim = host.package("vim")
    assert vim.is_installed


def test_htop(host):
    htop = host.package("htop")
    assert htop.is_installed

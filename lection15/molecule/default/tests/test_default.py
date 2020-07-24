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


def test_gnupg2(host):
    gnupg2 = host.package("gnupg2")
    assert gnupg2.is_installed


def test_ca-certificates(host):
    ca-certificates = host.package("ca-certificates")
    assert ca-certificates.is_installed


def test_lsb-release(host):
    lsb-release = host.package("lsb-release")
    assert lsb-release.is_installed


def test_nginx(host):
    nginx = host.package("nginx")
    assert nginx.is_installed

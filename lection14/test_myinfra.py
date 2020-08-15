def test_passwd_file(host):
    passwd = host.file("/etc/passwd")
    assert passwd.contains("root")
    assert passwd.user == "root"
    assert passwd.group == "root"
    assert passwd.mode == 0o644

def test_epel_release(host):
    epel-release = host.package("epel-release")
    assert epel-release.is_installed
    assert epel-release.version.latest

def test_httpd(host):
    httpd = host.package("httpd")
    assert httpd.is_installed
    assert httpd.version.latest

def test_nano(host):
    nano = host.package("nano")
    assert nano.is_installed
    assert nano.version.latest

def test_apache2(host):
    apache2 = host.package("apache2")
    assert apache2.is_installed
    assert apache2.version.latest
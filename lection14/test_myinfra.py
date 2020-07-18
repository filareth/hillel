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

def test_vim(host):
    vim = host.package("vim")
    assert vim.is_installed
    assert vim.version.latest

def test_htop(host):
    htop = host.package("htop")
    assert htop.is_installed
    assert htop.version.latest
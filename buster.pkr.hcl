source "virtualbox-iso" "buster" {
  /*
		Language, country, and keyboard selection cannot be preseeded from a file,
		because the questions are asked before the preseed file can be loaded.
		Instead, to avoid these questions, pass some more parameters to the kernel:

			debian-installer/locale=en_NZ
			kbd-chooser/method=us
	*/
  boot_command = [
    "<esc><wait>",
    "install ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "auto ",
    "debian-installer=pt_BR ",
    "locale=pt_BR.UTF-8 ",
    "kbd-chooser/method=br-abnt2 ",
    "console-keymaps-at/keymap=br-abnt2 ",
    "keyboard-configuration/xkb-keymap=br-abnt2 ",
    "netcfg/get_hostname=buster ",
    "netcfg/get_domain=home.org ",
    "debconf/frontend=noninteractive ",
    "console-setup/ask_detect=false ",
    "grub-installer/bootdev=/dev/sda ",
    "<enter>"
  ]
  guest_os_type    = "Debian_64" # VBoxManage list ostypes
  ssh_username     = "vagrant"
  ssh_password     = "vagrant"
  ssh_wait_timeout = "90m"

  cpus                 = "1"
  memory               = "1024"
  hard_drive_interface = "sata"
  headless             = "true"

  iso_url      = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.7.0-amd64-netinst.iso"
  iso_checksum = "sha256:b317d87b0a3d5b568f48a92dcabfc4bc51fe58d9f67ca13b013f1b8329d1306d"

  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"

  boot_wait        = "3s"
  http_directory   = "."
  output_directory = "build"
}

build {
  sources = ["sources.virtualbox-iso.buster"]
  post-processor "vagrant" {
    keep_input_artifact = true
  }
}

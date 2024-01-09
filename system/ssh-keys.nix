{...}: let myKeys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjUz1FruDlg5VNmvd4wi7DiXbMJcN4ujr8KtQ6OhlSc stary@pc"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+q372oe3sFtBQPAH93L397gYGYrjeGewzoOW97gSy1 stary@wheatley"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLg5nSbedQYRzm4BAU1OIYpaiTwP+afCAE3BvPcG7OI eddsa-key-20210602" # Windows VM
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK45+pMQ9LCmGLbP4fmDmjJaxEsB0JfeqXm8NK/Q9QSp JuiceSSH" # Phone
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3cTdfUSCjbQaZQRtpGlF+C7Ez9KYI7QCMMwwNlG91H stary@vorticon" # chrome thing
    ]; in {
  users.users.root.openssh.authorizedKeys.keys = myKeys;
  users.users.stary.openssh.authorizedKeys.keys = myKeys;
}

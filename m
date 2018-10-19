Return-Path: <valdis@vt.edu>
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
To: Dennis Zhou <dennis@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-Reply-To: <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu> <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com> <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com> <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539993007_2536P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Oct 2018 19:50:08 -0400
Message-ID: <3699.1539993008@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

--==_Exmh_1539993007_2536P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Oct 2018 17:20:29 -0400, Dennis Zhou said:

> could apply that and send me the full dmesg that would be great. Lastly,
> can you just confirm for me that the commit before, f0fcb3ec89f3
> "blkcg: remove additional reference to the css", isn't seeing this
> issue?

Script started on 2018-10-19 18:53:41-04:00
[root@turing-police x86_64]# uname -a
Linux turing-police.cc.vt.edu 4.19.0-rc2-00202-gf0fcb3ec89f3 #640 SMP PREEMPT Fri Oct 19 14:20:22 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@turing-police x86_64]# rpm -Uvh --force dracut-049-4.git20181010.fc30.x86_64.rpm
Verifying...                          ################################# [100%]
warning: Unable to get systemd shutdown inhibition lock: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
Preparing...                          ################################# [100%]
Updating / installing...
   1:dracut-049-4.git20181010.fc30    ################################# [100%]
[root@turing-police x86_64]# exit
exit

Script done on 2018-10-19 18:54:09-04:00

That commit comes up "good" - broken kernels die before I ever get the prompt back...

--==_Exmh_1539993007_2536P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8ptr40DS38y7CIcAQIuegf/QtQ9PQOKoXVijewIucqhWzvzZWIRvWeb
A1JO8Eang9AUDjkX5FvSs6RW7veaViMJ+Mgt12FmCJkdJzJjxjcgQI1H1p0kIe3U
bQTmxEGBO7PpsasVyhIYsc2dDssgW5rjkTn3PHZzuua76WAq7y4cJq8TsDns1GgO
bfGlipvUKdlfu/hVt/YwlHWswIZm1acyQHtuYoFU1KGTE3/4ZFLzjxe6cw9vAKNS
3ZMMLsnEQQPdG9hrTrhkCM9hIybc1+uSWoHkrEYFygSZnWX/+cVZfoLSeu0eL9il
qh8TDKyh4ccwILfpvAWfo4W0fcOxVppHUei5Z/kpzKC+NUAnk2dsvg==
=l+JZ
-----END PGP SIGNATURE-----

--==_Exmh_1539993007_2536P--

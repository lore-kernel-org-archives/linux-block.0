Return-Path: <massimo@burcheri.de>
Message-ID: <1534926011.18658.29.camel@burcheri.de>
Subject: MQ-BFQ crashing on battery mode
From: Massimo Burcheri <massimo@burcheri.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-FkIqwNjyHCVyvhY4Q5sg"
Date: Wed, 22 Aug 2018 10:20:11 +0200
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>


--=-FkIqwNjyHCVyvhY4Q5sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,


I got a kernel trace when unplugging the power supply, switching to battery
mode. I get the same kernel trace when booting on battery.
Both making the system unusable or breaking the boot.

The kernel call trace with symbols:

? blk_mq_requeue_request+0x...
? __scsi_queue_insert+0x...
? ata_scsi_var_len_cdb_xlat+0x
? __blk_mq_complete_request+0x...
? ata_scsi_translate+0x...
? ata_scsi_queuecmd+0x...
? scsi_dispatch_cmd+0x...
? scsi_queue_rq+0x...
? blk_mq_dispatch_rq_list+0x...
? kyber_dispatch_cur_domain+0x...
? kyber_completed_request+0x...
? blk_mq_sched_dispatch_requests+0x...
? __ blk_mq_run_hw_queue+0x...
? __blk_mq_delay_run_hw_queue+0x...
? blk_mq_run_hw_queue+0x...
? blk_mq_run_hw_queues+0x...
? blk_mq_requeue_work+0x...
? process_one_work+0x...
? worker_thread+0x...
? process_one_work+0x...
? kthread+0x...
? kthread_flush_work_fn+0x...
? ret_from_fork+0x...
Code: ...
RIP: sbitmap_queue_clear+0x...

Screenshot: 	https://ibin.co/4D34Ej3DWsqI.jpg
Kernel config: 	https://bpaste.net/show/870004e55123

Kernel: 4.17.11-ck

Setup:

btrfs-on-bcache-on-luks
btrfs options (rw,noatime,nodiratime,compress-
force=3Dlzo,nossd,noacl,space_cache,autodefrag)

Using mq bfq scheduler for the hdd backing and kyber for the ssd caching de=
vice


Failed tests:
Tested many kernel down to 4.13.2 with Gentoo or Ck patchset. Sorry for not
including the vanilla sources in the test, I can provide if required.
Skipping services in the boot process didn't help, any next service leads t=
o the
same trace.
Switching off the laptop-mode-tools daemon didn't help.
Switching all devices to "none" scheduler did not help.


Workaround:
After some tests and due to the *mq* call stack I was able to workaround by
disabling CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT and switching all
devices to cfq scheduler.
However with the MQ enabled kernel, only bfq, kyber and none are possible, =
while
the non-mq kernel can only set cfq. I guess this is intentional as the curr=
ent
bfq implementation is a MQ only version and CFQ is a non-mq only version?

Best regards,
Massimo
--=-FkIqwNjyHCVyvhY4Q5sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAlt9HLsACgkQlQj3p5VS
ZjL95hAAn3RpwMKbRwv3NjEfWwxpTaJXgtNIAW3rKxyEOO3jX0fhfA1rlEKtQ3r9
w6OCxaORedTpxB0QEIkd2Pe82fj5dteVSETQQsZ1w/PEYhY9nZkhebbhjB5X817x
tmwuYE3CDxn6Yti0phV7tIp9/TxmUaCybP1X8vR02t247x+lqnAPA+3eumig2y5o
YNOghADyJj7dmxnK8C0kcnPicDlxNacP/T7NtHA/3EHIc1/itGGPN6W+G6D2Jpn5
FOShUBCUX6rfc/z9HOWnhZXWGQfqgLp8fCPCainA7EH2DjcZn9xIRxRG/fdkja2w
Aoj4A4JNNLJ/9YSksTt26eaeGT8ybf9eujaDtBdrk1P6R3q6qZ2lgbUOE6V+7F5r
5KE8u1kvGBn8Q/wov6ZzvlR9vnV2GoUlJmSNiAgRt70WXmw3HXgTY5RTj1lnmbTj
1qWJCjdx3OumnfSgrs2s/amAHa3xMhcu7dLL5u7dEg9vzgHARrAve8aQLG/tpXGc
EAXDJIk0WhMeCXWXO3GtZCqTFelKS/BAUeCh7zQwx+U3laKqRr2oFKs6snAliY33
UlCV91Hd8iA6tZqkhWey0sAoXvSiOjRoEE5UywV9WWovTnjMsIsCwvgsfb7f0Vij
qvwAwhtL6G2AcbmioQvybC93r4ZbI0e2WmOvhwjzmMh4qZ8NmeI=
=h385
-----END PGP SIGNATURE-----

--=-FkIqwNjyHCVyvhY4Q5sg--

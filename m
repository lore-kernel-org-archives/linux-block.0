Return-Path: <koalinux@gmail.com>
Return-Path: <koalinux@gmail.com>
From: =?ISO-8859-1?Q?Jos=E9?= Pekkarinen <koalinux@gmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Disable pm on runtime.
Date: Mon, 18 Dec 2017 15:07:22 +0200
Message-ID: <1874121.sq8PTU63rf@bee>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart94610231.tJ3FLDs05r"
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.

--nextPart94610231.tJ3FLDs05r
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

	Hi,

	I hit issues booting my laptop when running on battery thanks to commit=20
765e40b675a9566459ddcb8358ad16f3b8344bbe given that I don't have any ssd/nv=
me=20
on it. Given that I decided to disable the option to default scsi to=20
multiqueue, but still my booting issues persist. For a while I was revertin=
g=20
this patch successfully but nowadays that is not anymore possible. Would it=
 be=20
possible to accept some patch like the one attached to ease this situation?

	Thanks!

	Jos=E9 Pekkarinen.
--nextPart94610231.tJ3FLDs05r
Content-Disposition: attachment; filename="0001-Disable-pm-only-when-scsi-mq-is-default-by-config.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Disable-pm-only-when-scsi-mq-is-default-by-config.patch"

=46rom 05ca41296d7c4c2494ac08c94ad5539914e5131a Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Jos=3DC3=3DA9=3D20Pekkarinen?=3D <koalinux@gmail.com>
Date: Mon, 18 Dec 2017 14:52:12 +0200
Subject: [PATCH] Disable pm only when scsi mq is default by config.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Jos=C3=A9 Pekkarinen <koalinux@gmail.com>
=2D--
 block/blk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 33ee583cfe45..68183bc5933f 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3440,9 +3440,11 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
+#ifdef CONFIG_SCSI_MQ_DEFAULT
 	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
 	if (q->mq_ops)
 		return;
+#endif
=20
 	q->dev =3D dev;
 	q->rpm_status =3D RPM_ACTIVE;
=2D-=20
2.13.6


--nextPart94610231.tJ3FLDs05r--

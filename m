Return-Path: <ben@decadent.org.uk>
Date: Sun, 13 Aug 2017 18:02:19 +0100
From: Ben Hutchings <ben@decadent.org.uk>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Message-ID: <20170813170219.GG18698@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5uO961YFyoDlzFnP"
Subject: [PATCH 1/2] bfq: Re-enable auto-loading when built as a module
List-ID: <linux-block@vger.kernel.org>


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The block core requests modules with the "-iosched" name suffix, but
bfq no longer has that suffix.  Add an alias.

Fixes: ea25da48086d ("block, bfq: split bfq-iosched.c into multiple ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/bfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 436b6ca6b175..3a01563bd564 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4998,6 +4998,7 @@ static struct elevator_type iosched_bfq_mq =3D {
 	.elevator_name =3D	"bfq",
 	.elevator_owner =3D	THIS_MODULE,
 };
+MODULE_ALIAS("bfq-iosched");
=20
 static int __init bfq_init(void)
 {


--5uO961YFyoDlzFnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWZCGG+e/yOyVhhEJAQpaHw//V8E59OQZ3+ZP2xehmdnsbvNIkGDWPzfX
stcDsfiXWiNWtQElwVdj/W0TiT5MW9KUmDQ/0U4I6CaReXCzkAzfoP3mebQuecus
nz58ea7UXypwunEvz7Ez5MYoYGPmF4WFZDsIaMD2WeqUY4boRmohvJ4j9dVDiGN2
S4uRNK4Ee8q1eeLofvptL/80Oyv7JT0oRrpcsrS6huINziSydwmyO1qrDby6bku9
nVkgK5SkbbOJhmFYOF1+4Ys0Xs2VUWBtoKT7FDqfzhNnGTu121llCrMHEgNDQEOh
vQ2BqZn4B9sUc+jR+MqDBlIdi5OMca3s4TTHgalyGa8HUT4myjVMVhQJ6zuq+Eb/
HsXd3f88vtYvpRUtK8gS7RbL9XhKR6nBMdtajzsZY5gUZ0lQiGGVjn+2VkVd+38T
6gDTeeEbzc2/3GFvykh0Fi29oGT9AMPgKwe2bynS0tZTjRH8zBy60HZcuX8PhQw0
9+UyntWLw92C/4V/lPJghlC/iRrILAsrEXQOyiB4k7U9DDuAfbzpcgQ1dxwfUX+6
rsrNUJyOZcR4Ok/actHh+9CskiYTPcRU1z5QPE4LVGWEA3neA+r2IgnJYKzPigG5
LYJO5pzsXvt1/juP/FYX5WPTE/kEkq4e/PGoX0pLinYyLMPi8RON6Oz21/5kbwst
JHU9yR+rraM=
=U89H
-----END PGP SIGNATURE-----

--5uO961YFyoDlzFnP--

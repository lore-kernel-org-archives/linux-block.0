Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49072 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751024AbdHMRDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Aug 2017 13:03:17 -0400
Date: Sun, 13 Aug 2017 18:03:15 +0100
From: Ben Hutchings <ben@decadent.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Message-ID: <20170813170315.GH18698@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
In-Reply-To: <20170813170219.GG18698@decadent.org.uk>
Subject: [PATCH 2/2] mq-deadline: Enable auto-loading when built as module
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The block core requests modules with the "-iosched" name suffix, but
mq-deadline does not have that suffix.  Add an alias.

Fixes: 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the deadline ..=
=2E")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/mq-deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1b964a387afe..78e7698fa4ed 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -660,6 +660,7 @@ static struct elevator_type mq_deadline =3D {
 	.elevator_name =3D "mq-deadline",
 	.elevator_owner =3D THIS_MODULE,
 };
+MODULE_ALIAS("mq-deadline-iosched");
=20
 static int __init deadline_init(void)
 {

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWZCGU+e/yOyVhhEJAQqitg//VhG282B/H24V+9TCIB1T27Ms3cRStBK2
BtFIaXRz9Qo7uh6OQIIo8jWgafwMCeHbGgYiSmKh5u2NYK559ABSSs3zpgPj6K9P
BJ85eNYriinAl/Xt06sognkGvFTJydw86MxejY+Q4eP5jObKKcZrm2sdWQFrE0U+
jSiXQrWhn3LE56XtIYk+4iZ51gXe0I0vS5n0WfGZWqBvqAKTJ7ye+rMfCvbAtEaD
qzORo1O1OS3J1yWXFOUVtiChwuYAhKbQYUaaFixyMqrmigPmLeU94WiIdj0spDXg
tBHPcG0ifFYynM5slDmPiOVc9GTaP7JS8gPAoL0dr1R6+aQz/1oQYichRW915N5H
BXOfQV3In7moJUOEkAAPN6mvkc+pOyZ1BWufto0VPSF5kLSde81z3V75FgnOePAO
J8Ncc+RreCKCYQ6TaSA/vJATYkUAgbZKMZijkfe6Xm2taSLIauCNQyXBQas5Wo0z
Ln5CaaKH2E+QeNVmYcnOB0IaALsN9+LXdK6/hfRsZ9Z9r7gI25kS9bio1hhsx1h1
imXxz90k9wD5WGy6t8vltCV5Ga9/RMHVuMWP8RyYC8QBWdRqibYe0tqGT6YHFU9e
VOtMus2gmPTarhlfR3Lj2INd1wDIT4NE36V1IzK7wuEMvDcXOA+hGkWVyh07TqWi
XPlVXZn22pQ=
=Z3fg
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--

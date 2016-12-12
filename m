Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 12 Dec 2016 11:29:32 +1100
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH resend] block_dev: don't test bdev->bd_contains when it is not stable.
In-Reply-To: <87mvgo9vgy.fsf@notabene.neil.brown.name>
References: <87mvgo9vgy.fsf@notabene.neil.brown.name>
Message-ID: <87d1gy0z2r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


bdev->bd_contains is not stable before calling __blkdev_get().
When __blkdev_get() is called on a parition with ->bd_openers =3D=3D 0
it sets
  bdev->bd_contains =3D bdev;
which is not correct for a partition.
After a call to __blkdev_get() succeeds, ->bd_openers will be > 0
and then ->bd_contains is stable.

When FMODE_EXCL is used, blkdev_get() calls
   bd_start_claiming() ->  bd_prepare_to_claim() -> bd_may_claim()

This call happens before __blkdev_get() is called, so ->bd_contains
is not stable.  So bd_may_claim() cannot safely use ->bd_contains.
It currently tries to use it, and this can lead to a BUG_ON().

This happens when a whole device is open with a bd_holder (in use by
dm in my particular example) and two threads race to open a partition
for the first time, one opening with O_EXCL and one without.

The thread that doesn't use O_EXCL gets through blkdev_get() to
__blkdev_get(), gains the ->bd_mutex, and sets bdev->bd_contains =3D bdev;

Immediately thereafter the other thread, using FMODE_EXCL, calls
bd_start_claiming from blkdev_get().  This should fail because the
whole device has a holder, but because bdev->bd_contains =3D=3D bdev
bd_may_claim() incorrectly reports success.

This thread continues and blocks on bd_mutex.
The first thread then sets bdev->bd_contains correctly and drops the mutex.
The thread using FMODE_EXCL then continues and when it calls bd_may_claim()
again in:
			BUG_ON(!bd_may_claim(bdev, whole, holder));
The BUG_ON fires.

Fix this by removing the dependency on ->bd_contains in
bd_may_claim().  As bd_may_claim() have direct access to the whole
device, it can simply test if the target bdev is the whole device.

Fixes: 6b4517a7913a ("block: implement bd_claiming and claiming block")
Cc: stable@vger.kernel.org (v2.6.35+)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--


No reply after 2 weeks, and this didn't appear in -next, so I'm adding a
couple more addresses - hopefully someone can take it.
Thanks,
NeilBrown


 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 05b553368bb4..9166b9f63d33 100644
=2D-- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -832,7 +832,7 @@ static bool bd_may_claim(struct block_device *bdev, str=
uct block_device *whole,
 		return true;	 /* already a holder */
 	else if (bdev->bd_holder !=3D NULL)
 		return false; 	 /* held by someone else */
=2D	else if (bdev->bd_contains =3D=3D bdev)
+	else if (whole =3D=3D bdev)
 		return true;  	 /* is a whole device which isn't held */
=20
 	else if (whole->bd_holder =3D=3D bd_may_claim)
=2D-=20
2.11.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlhN72wACgkQOeye3VZi
gbnWnA//UXR6KjZwFfuNyweOtoqqdS+VVdWOZYI5JEKLN0DLifAEwrrt/qn/ec66
eMRiCyDitriq4vck7zphgLh9SG3g6qzqu4fTzES6SF0ePdgAScad3PjUhXbQ3ZKy
aJmGrqX7TgmDOExEUmLUHdfnMu1/OTb9aCKju/sUgoeLpOIlacgyjelbe483w81i
xbk6ETzdm2pLHTSgsnj74izjrv0ycYp0Y1KovHdjJOaxLvBSP4ZyONEb7t8+qBm3
ICCglmtNnOE5WpQFLidIVlB/QapmReUPJ5+qBGS+o4dYeiolxn+6cLSaDX0dGIBq
xGhuEreuYFp7jn1L93g+mqk1jkT9Fg+xMuHSg4JdWbFiINn3oK68NAnGFX5IUQPe
3ZRCi6aqQzG1UQRH/fpt9Tt6vxGHMc5/omzxEYRsdwSnlD1eQGR6BVv7YVhC49TR
K7eW70LAGoxZ3rGqZHe01VGceVZZn3+q0GWKYVU0+/ZwsKt+pp3KN3y6Vw6A+YZn
MsXtISeT+WMGhIS9ZBwo9Ec5K4B/+CZf/ya/gFCSjf+RFTShsbqTdl1+7WvCZV7S
sONFubqRoJO5r8WNae4C7/SQ0dQjssTJ2QXhnDMB7hbY5TxvDs9chUZczXYPngJL
isceoPV4Qk2XNy8+py9b7eYC83injsuOUqjAApyAOC38eW6CO1o=
=v/ol
-----END PGP SIGNATURE-----
--=-=-=--

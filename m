Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53825 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbcKYBw5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2016 20:52:57 -0500
From: NeilBrown <neilb@suse.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Date: Fri, 25 Nov 2016 12:52:45 +1100
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] block_dev: don't test bdev->bd_contains when it is not stable.
Message-ID: <87mvgo9vgy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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

This happens when a whole device is already open with a bd_holder (in
use by dm in my particular example) and two threads race to open a
partition of that device for the first time, one opening with O_EXCL and
one without.

The thread that doesn't use O_EXCL gets through blkdev_get() to
__blkdev_get(), gains the ->bd_mutex, and sets bdev->bd_contains =3D bdev;

Immediately thereafter the other thread, using FMODE_EXCL, calls
bd_start_claiming() from blkdev_get().  This should fail because the
whole device has a holder, but because bdev->bd_contains =3D=3D bdev
bd_may_claim() incorrectly reports success.
This thread continues and blocks on bd_mutex.

The first thread then sets bdev->bd_contains correctly and drops the mutex.
The thread using FMODE_EXCL then continues and when it calls bd_may_claim()
again in:
			BUG_ON(!bd_may_claim(bdev, whole, holder));
The BUG_ON fires.

Fix this by removing the dependency on ->bd_contains in
bd_may_claim().  As bd_may_claim() has direct access to the whole
device, it can simply test if the target bdev is the whole device.

Fixes: 6b4517a7913a ("block: implement bd_claiming and claiming block")
Cc: stable@vger.kernel.org (v2.6.35+)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
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
2.10.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlg3mW0ACgkQOeye3VZi
gbl3Qw//bhFxEb/edWZGmApFcl5LeUMPmt+fL03paOibldA+zaApzBZhz/49B+Qx
s3izAtYkb3pG4yc71Wcb/qfO6U8Ce3l1q/Ug7t0eO2gNwSzaJO36wgxnNDWa38Mw
S3K9BEMHpLK2XjONtgrFF7BE6QIZVHaSlQOHv8+u4MocXrZHaZM1wzFr+VsYDMvH
rqxEbTkIajrSsTc+AUiLgJDso4bF+Iv8N85OEKOBiPg0b8/+WYB84+vXM8BvEnC3
729oEahqcFXEwDe2Ipgnno2KaHyHcxcRfvTNV88z4KAGyWSB3en2g+q1B/OYD3+4
5o3teE95raWxYIIw2soXqnYAzd/+/IlvvDK3ePEIeu859jQXBf+VhjSq51yDmNO0
6mh4BWnNBWiNWBlCBgPZ1lcqVw8V1Gpj/8hp3PIDUEjs37gWVfaRwGooHIbqNBSV
Pbu5ZyX3WIOIKP4sPXAfEEnOYXnRkuPsPIgHuK3SD4amLbcXMLtdVDgSxjE99eSG
zeRuy0he8dr2Ry4iUhhuIaM8m5pnktt3xER0ETIMvWQmCJnRNpwXtkwdzpRch01W
6vfKYFhTa5k+k2qoUjmuQ+tcysubUHmsZZy4vpVhxwbvm/+5cUWjhTENAfbSc4XB
OlnQ34mOI3uYWB9qpeZ/eiyHEvWP5Jg3goybuH2qydlQmchdjwY=
=dNso
-----END PGP SIGNATURE-----
--=-=-=--

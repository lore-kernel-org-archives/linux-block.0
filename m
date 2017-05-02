Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 03 May 2017 09:21:48 +1000
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13 V2] blk: use non-rescuing bioset for q->bio_split.
In-Reply-To: <149369654452.5146.12018336836086489178.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654452.5146.12018336836086489178.stgit@noble>
Message-ID: <87o9vaq1yr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


A rescuing bioset is only useful if there might be bios from
that same bioset on the bio_list_on_stack queue at a time
when bio_alloc_bioset() is called.  This never applies to
q->bio_split.

Allocations from q->bio_split are only ever made from
blk_queue_split() which is only ever called early in each of
various make_request_fn()s.  The original bio (call this A)
is then passed to generic_make_request() and is placed on
the bio_list_on_stack queue, and the bio that was allocated
from q->bio_split (B) is processed.

The processing of this may cause other bios to be passed to
generic_make_request() or may even cause the bio B itself to
be passed, possible after some prefix has been split off
(using some other bioset).

generic_make_request() now guarantees that all of these bios
(B and dependants) will be fully processed before the tail
of the original bio A gets handled.  None of these early bios
can possible trigger an allocation from the original
q->bio_split as they are either too small to require
splitting or (more likely) are destined for a different queue.

The next time that the original q->bio_split might be used
by this thread is when A is processed again, as it might
still be too big to handle directly.  By this time there
cannot be any other bios allocated from q->bio_split in the
generic_make_request() queue.  So no rescuing will ever be
needed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

This patch needed to be refreshed after previous patch
had long lines wrapped.
Also added Ming's Reviewed-by.

Thanks,
NeilBrown



 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bc66cd595bef..3797753f4085 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -730,8 +730,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_ma=
sk, int node_id)
 	if (q->id < 0)
 		goto fail_q;
=20
=2D	q->bio_split =3D bioset_create(BIO_POOL_SIZE, 0, (BIOSET_NEED_BVECS |
=2D							BIOSET_NEED_RESCUER));
+	q->bio_split =3D bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	if (!q->bio_split)
 		goto fail_id;
=20
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkJFI0ACgkQOeye3VZi
gbmVihAAqsd8Ax/uFAsgLXv6/vfT/4gzWIfocbDCwhReHtNzTrgSAGUKD9bbiDCg
Kmc10unaw1Wvk0tZ54wPuF+4hWvBRSI8pECjgaC8Ez7DmhFxPkUa7mcAqpddaOH1
wMMUbipK8Fm7EE36dVSzd6klxEicqllQExZE2WP/NN8gl3i2WvINkhNJMo9MmcOU
MGh08NKtfZF2Xr6nDuLieCBVIHonJ9AY4ky+JgNFRTs3U1Rh+VGQH9lDloDk7qJ4
VXKk31pSzB5dj8mLLCVrriTahXhlW2n7NkLRp707BbkO6zs8rKTrCyCga9uVl9tE
AgOjBlqCHOc+m/ep9ZUPg/o4R8XzdcBPY6+2kcVhrjTVOpWavo+Txb6yaPpn7Z/C
uLK1EbKf0vNho05Yt+vYe4ZYgF+BRsHgssa7b+dvdbpzWS54KXhZCF1xTV/X9Ni2
SmncTZSYJSaPl4de2ZhoMN1ylJOJCgtcU16SUf/Z4Jj/8+xFVIv4rJOJEB9oNZ8o
59XXf51eN1luSyV//fKcBowr0+OUSrekrg6pHP9WcMX6uwFPUxftRjspyNQ6bCLU
7R/n0KeiLceW2+rI3ElRY3FSkRjDblvTymZEe/RsLLl9MNfwDhu2QDwBduvworzV
IyE6VzPvC19DHLlsQUSJB+jS1+B5d+nKKtn28TEH7X5fgFUSOEI=
=m538
-----END PGP SIGNATURE-----
--=-=-=--

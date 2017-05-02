Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 03 May 2017 09:20:20 +1000
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13 V2] drbd: use bio_clone_fast() instead of bio_clone()
In-Reply-To: <149369654517.5146.709918236180021330.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654517.5146.709918236180021330.stgit@noble>
Message-ID: <87r306q217.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


drbd does not modify the bi_io_vec of the cloned bio,
so there is no need to clone that part.  So bio_clone_fast()
is the better choice.
For bio_clone_fast() we need to specify a bio_set.
We could use fs_bio_set, which bio_clone() uses, or
drbd_md_io_bio_set, which drbd uses for metadata, but it is
generally best to avoid sharing bio_sets unless you can
be certain that there are no interdependencies.

So create a new bio_set, drbd_io_bio_set, and use bio_clone_fast().

Also remove a "XXX cannot fail ???" comment because it definitely
cannot fail - bio_clone_fast() doesn't fail if the GFP flags allow for
sleeping.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

This patch needed to be refreshed after long lines were
wrapped in an earlier patch.
Also added the BIOSET_NEED_RESCUER flag for new bioset as
it is not trivially obvious that this isn't needed.

NeilBrown


 drivers/block/drbd/drbd_int.h  | 3 +++
 drivers/block/drbd/drbd_main.c | 9 +++++++++
 drivers/block/drbd/drbd_req.h  | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d5da45bb03a6..f91982515a6b 100644
=2D-- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1441,6 +1441,9 @@ extern struct bio_set *drbd_md_io_bio_set;
 /* to allocate from that set */
 extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
=20
+/* And a bio_set for cloning */
+extern struct bio_set *drbd_io_bio_set;
+
 extern struct mutex resources_mutex;
=20
 extern int conn_lowest_minor(struct drbd_connection *connection);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index bdf51b6977cf..90680034ef57 100644
=2D-- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -128,6 +128,7 @@ mempool_t *drbd_request_mempool;
 mempool_t *drbd_ee_mempool;
 mempool_t *drbd_md_io_page_pool;
 struct bio_set *drbd_md_io_bio_set;
+struct bio_set *drbd_io_bio_set;
=20
 /* I do not use a standard mempool, because:
    1) I want to hand out the pre-allocated objects first.
@@ -2098,6 +2099,8 @@ static void drbd_destroy_mempools(void)
=20
 	/* D_ASSERT(device, atomic_read(&drbd_pp_vacant)=3D=3D0); */
=20
+	if (drbd_io_bio_set)
+		bioset_free(drbd_io_bio_set);
 	if (drbd_md_io_bio_set)
 		bioset_free(drbd_md_io_bio_set);
 	if (drbd_md_io_page_pool)
@@ -2115,6 +2118,7 @@ static void drbd_destroy_mempools(void)
 	if (drbd_al_ext_cache)
 		kmem_cache_destroy(drbd_al_ext_cache);
=20
+	drbd_io_bio_set      =3D NULL;
 	drbd_md_io_bio_set   =3D NULL;
 	drbd_md_io_page_pool =3D NULL;
 	drbd_ee_mempool      =3D NULL;
@@ -2142,6 +2146,7 @@ static int drbd_create_mempools(void)
 	drbd_pp_pool         =3D NULL;
 	drbd_md_io_page_pool =3D NULL;
 	drbd_md_io_bio_set   =3D NULL;
+	drbd_io_bio_set      =3D NULL;
=20
 	/* caches */
 	drbd_request_cache =3D kmem_cache_create(
@@ -2165,6 +2170,10 @@ static int drbd_create_mempools(void)
 		goto Enomem;
=20
 	/* mempools */
+	drbd_io_bio_set =3D bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_RESCUER);
+	if (drbd_io_bio_set =3D=3D NULL)
+		goto Enomem;
+
 	drbd_md_io_bio_set =3D bioset_create(DRBD_MIN_POOL_PAGES, 0,
 					   BIOSET_NEED_BVECS |
 					   BIOSET_NEED_RESCUER);
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index eb49e7f2da91..9e1866ab238f 100644
=2D-- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -263,7 +263,7 @@ enum drbd_req_state_bits {
 static inline void drbd_req_make_private_bio(struct drbd_request *req, str=
uct bio *bio_src)
 {
 	struct bio *bio;
=2D	bio =3D bio_clone(bio_src, GFP_NOIO); /* XXX cannot fail?? */
+	bio =3D bio_clone_fast(bio_src, GFP_NOIO, drbd_io_bio_set);
=20
 	req->private_bio =3D bio;
=20
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkJFDQACgkQOeye3VZi
gbkCnRAAw0qqouVDukxK8AHIATbT0yy0Z++yFE6nv9btHCNidtlZD4ScbXpA2NQu
ClIcLj1G8aXDzTKPf4SbqP5oIrPxH9b0O/ukaYIbscOH3JkFdT1j6di6c+ANO1JF
wZ2HOma8TPnTw9nLpHdJzx+QhxVJOIPGNWJnZ3KTooIXVt/O+kvGHLCzIq4XllLY
W4XLNurHQOXLU8QLqD3lw4ougfG06m1CT9kl14j5RUfUkddH1Hsa2ExXImIGatM7
TtF+DqrUshw8Yxw1p3a/2pmMrW8hN8QqEiWr06EXGOWCFIZuiKEdiHoT2tmAcS3N
XPlZSzda4bVyXcIODGbL/sp7+b0ehJ0q68aBCPuR9K/H7+KRIpKd8KylwxTSLOIe
Tpk216kHQXY7JvIN1ZrTGvS3hughKUJ6A/f2+yPecRvd+xt69mxBgfXV88Iom0OD
HkeGNHH4YJKoowViaw4Ut4g0EmdSrJW4/JtmQKoA/S18BNLVLr+JdR8hbxNMs1xK
Qi5tKf/pzH2sAvyWHeO8BsL3eQYP90/3HOdU0PVUtI0IbZyKoWG3UtmrtVZ+A8+B
VHgF1B7O1FzKILEdwuj0Aw9ALp0LhJkYWQsGZXxaR16Twbr09oJtXXz9MaughdA3
FAwcx78qrD0tFyIeN/JPLB4xrOFaDTFwIL4SQFYs1rncrV9OI8w=
=/ycU
-----END PGP SIGNATURE-----
--=-=-=--

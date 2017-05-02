Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed, 03 May 2017 08:34:13 +1000
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/13 V2] blk: make the bioset rescue_workqueue optional.
In-Reply-To: <149369654434.5146.15331164625586213889.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble> <149369654434.5146.15331164625586213889.stgit@noble>
Message-ID: <87wp9yq462.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

From=2009017acf74ec4df674b78ca66f0924187f10d8a4 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.com>
Date: Fri, 10 Mar 2017 13:59:50 +1100
Subject: [PATCH] blk: make the bioset rescue_workqueue optional.

This patch converts bioset_create() to not create a workqueue by
default, so alloctions will never trigger punt_bios_to_rescuer().  It
also introduces a new flag BIOSET_NEED_RESCUER() which tells
bioset_create() to preserve the old behavior.

All callers of bioset_create() that are inside block device drivers,
are given the BIOSET_NEED_RESCUER().

biosets used by filesystems or other top-level users do not
need rescuing as the bio can never be queued behind other
bios.  This includes fs_bio_set, blkdev_dio_pool,
btrfs_bioset, xfs_ioend_bioset, and one allocated by
target_core_iblock.c.

biosets used by md/raid do not need rescuing as
their usage was recently audited and revised to never
risk deadlock.

It is hoped that most, if not all, of the remaining biosets
can end up being the non-rescued version.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Credit-to: Ming Lei <ming.lei@redhat.com> (minor fixes)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

This version fixes the WARN_ON_ONCE() typo, updates the above comment,
wraps long lines, and preserves the rescuer behavior for DRBD.

Thanks for the review.

NeilBrown


 block/bio.c                    | 13 +++++++++++--
 block/blk-core.c               |  3 ++-
 drivers/block/drbd/drbd_main.c |  4 +++-
 drivers/md/bcache/super.c      |  8 ++++++--
 drivers/md/dm-crypt.c          |  3 ++-
 drivers/md/dm-io.c             |  3 ++-
 drivers/md/dm.c                |  5 +++--
 include/linux/bio.h            |  1 +
 8 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3f1286ed301e..f3a6ef4f5c42 100644
=2D-- a/block/bio.c
+++ b/block/bio.c
@@ -363,6 +363,8 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
 	struct bio_list punt, nopunt;
 	struct bio *bio;
=20
+	if (WARN_ON_ONCE(!bs->rescue_workqueue))
+		return;
 	/*
 	 * In order to guarantee forward progress we must punt only bios that
 	 * were allocated from this bio_set; otherwise, if there was a bio on
@@ -474,7 +476,8 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned i=
nt nr_iovecs,
=20
 		if (current->bio_list &&
 		    (!bio_list_empty(&current->bio_list[0]) ||
=2D		     !bio_list_empty(&current->bio_list[1])))
+		     !bio_list_empty(&current->bio_list[1])) &&
+		    bs->rescue_workqueue)
 			gfp_mask &=3D ~__GFP_DIRECT_RECLAIM;
=20
 		p =3D mempool_alloc(bs->bio_pool, gfp_mask);
@@ -1925,7 +1928,8 @@ EXPORT_SYMBOL(bioset_free);
  * bioset_create  - Create a bio_set
  * @pool_size:	Number of bio and bio_vecs to cache in the mempool
  * @front_pad:	Number of bytes to allocate in front of the returned bio
=2D * @flags:	Flags to modify behavior, currently only %BIOSET_NEED_BVECS
+ * @flags:	Flags to modify behavior, currently %BIOSET_NEED_BVECS
+ *              and %BIOSET_NEED_RESCUER
  *
  * Description:
  *    Set up a bio_set to be used with @bio_alloc_bioset. Allows the caller
@@ -1936,6 +1940,8 @@ EXPORT_SYMBOL(bioset_free);
  *    or things will break badly.
  *    If %BIOSET_NEED_BVECS is set in @flags, a separate pool will be allo=
cated
  *    for allocating iovecs.  This pool is not needed e.g. for bio_clone_f=
ast().
+ *    If %BIOSET_NEED_RESCUER is set, workqueue is create which can be use=
d to
+ *    dispatch queued requests when the mempool runs out of space.
  *
  */
 struct bio_set *bioset_create(unsigned int pool_size,
@@ -1971,6 +1977,9 @@ struct bio_set *bioset_create(unsigned int pool_size,
 			goto bad;
 	}
=20
+	if (!(flags & BIOSET_NEED_RESCUER))
+		return bs;
+
 	bs->rescue_workqueue =3D alloc_workqueue("bioset", WQ_MEM_RECLAIM, 0);
 	if (!bs->rescue_workqueue)
 		goto bad;
diff --git a/block/blk-core.c b/block/blk-core.c
index 3797753f4085..bc66cd595bef 100644
=2D-- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -730,7 +730,8 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_ma=
sk, int node_id)
 	if (q->id < 0)
 		goto fail_q;
=20
=2D	q->bio_split =3D bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	q->bio_split =3D bioset_create(BIO_POOL_SIZE, 0, (BIOSET_NEED_BVECS |
+							BIOSET_NEED_RESCUER));
 	if (!q->bio_split)
 		goto fail_id;
=20
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b395fe391171..bdf51b6977cf 100644
=2D-- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2165,7 +2165,9 @@ static int drbd_create_mempools(void)
 		goto Enomem;
=20
 	/* mempools */
=2D	drbd_md_io_bio_set =3D bioset_create(DRBD_MIN_POOL_PAGES, 0, BIOSET_NEE=
D_BVECS);
+	drbd_md_io_bio_set =3D bioset_create(DRBD_MIN_POOL_PAGES, 0,
+					   BIOSET_NEED_BVECS |
+					   BIOSET_NEED_RESCUER);
 	if (drbd_md_io_bio_set =3D=3D NULL)
 		goto Enomem;
=20
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 8b9dae98cc7e..f8d4c9543c45 100644
=2D-- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -786,7 +786,9 @@ static int bcache_device_init(struct bcache_device *d, =
unsigned block_size,
=20
 	minor *=3D BCACHE_MINORS;
=20
=2D	if (!(d->bio_split =3D bioset_create(4, offsetof(struct bbio, bio), BIO=
SET_NEED_BVECS)) ||
+	if (!(d->bio_split =3D bioset_create(4, offsetof(struct bbio, bio),
+					   BIOSET_NEED_BVECS |
+					   BIOSET_NEED_RESCUER)) ||
 	    !(d->disk =3D alloc_disk(BCACHE_MINORS))) {
 		ida_simple_remove(&bcache_minor, minor);
 		return -ENOMEM;
@@ -1520,7 +1522,9 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb=
 *sb)
 				sizeof(struct bbio) + sizeof(struct bio_vec) *
 				bucket_pages(c))) ||
 	    !(c->fill_iter =3D mempool_create_kmalloc_pool(1, iter_size)) ||
=2D	    !(c->bio_split =3D bioset_create(4, offsetof(struct bbio, bio), BIO=
SET_NEED_BVECS)) ||
+	    !(c->bio_split =3D bioset_create(4, offsetof(struct bbio, bio),
+					   BIOSET_NEED_BVECS |
+					   BIOSET_NEED_RESCUER)) ||
 	    !(c->uuids =3D alloc_bucket_pages(GFP_KERNEL, c)) ||
 	    !(c->moving_gc_wq =3D alloc_workqueue("bcache_gc",
 						WQ_MEM_RECLAIM, 0)) ||
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5a98c1eb87d9..1ddb2b160e14 100644
=2D-- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1936,7 +1936,8 @@ static int crypt_ctr(struct dm_target *ti, unsigned i=
nt argc, char **argv)
 		goto bad;
 	}
=20
=2D	cc->bs =3D bioset_create(MIN_IOS, 0, BIOSET_NEED_BVECS);
+	cc->bs =3D bioset_create(MIN_IOS, 0, (BIOSET_NEED_BVECS |
+					    BIOSET_NEED_RESCUER));
 	if (!cc->bs) {
 		ti->error =3D "Cannot allocate crypt bioset";
 		goto bad;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 1d86d1d39d48..aee5aae1c992 100644
=2D-- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -58,7 +58,8 @@ struct dm_io_client *dm_io_client_create(void)
 	if (!client->pool)
 		goto bad;
=20
=2D	client->bios =3D bioset_create(min_ios, 0, BIOSET_NEED_BVECS);
+	client->bios =3D bioset_create(min_ios, 0, (BIOSET_NEED_BVECS |
+						  BIOSET_NEED_RESCUER));
 	if (!client->bios)
 		goto bad;
=20
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e21a7d58c8ef..4f96556cb8c5 100644
=2D-- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1014,7 +1014,8 @@ static void flush_current_bio_list(struct blk_plug_cb=
 *cb, bool from_schedule)
=20
 		while ((bio =3D bio_list_pop(&list))) {
 			struct bio_set *bs =3D bio->bi_pool;
=2D			if (unlikely(!bs) || bs =3D=3D fs_bio_set) {
+			if (unlikely(!bs) || bs =3D=3D fs_bio_set ||
+			    !bs->rescue_workqueue) {
 				bio_list_add(&current->bio_list[i], bio);
 				continue;
 			}
@@ -2601,7 +2602,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct ma=
pped_device *md, unsigned t
 		BUG();
 	}
=20
=2D	pools->bs =3D bioset_create(pool_size, front_pad, 0);
+	pools->bs =3D bioset_create(pool_size, front_pad, BIOSET_NEED_RESCUER);
 	if (!pools->bs)
 		goto out;
=20
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 0975da6bebd9..40e5d7b62f29 100644
=2D-- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -376,6 +376,7 @@ static inline struct bio *bio_next_split(struct bio *bi=
o, int sectors,
 extern struct bio_set *bioset_create(unsigned int, unsigned int, int flags=
);
 enum {
 	BIOSET_NEED_BVECS =3D BIT(0),
+	BIOSET_NEED_RESCUER =3D BIT(1),
 };
 extern void bioset_free(struct bio_set *);
 extern mempool_t *biovec_create_pool(int pool_entries);
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkJCWUACgkQOeye3VZi
gbnkxg//RShqP6HCwCS26v/Xhr3XHxbCP0eahSQiT80tO0M1V3xku+tXhUQ8Y8k3
76WIFz6BRzQ04N/NVwiRTaWtnEPTny5Ms3DRlXy5UwxPyA4K5M+yatvJO+o+hAEq
2fEHxhbE+Faqt++QcTCN7YIlSHJiAUDS+aa1nFd3DNPZsMU/Sdwo5JuizbH4h3YR
8SQjLpc6HH3QZTEwtpeb5ysnxFNlZL4CpbVZJ0t0s8Q8iiiXo3+TACYBKjQhQ820
nI4cWjD/Ek2uCoaXpfVUFwtpc3FNNJzINYx1EoaOBerOwH71Z3xkdPphicottxGr
6acgr8QIF0VF3ESnrwwc8wGznrGYzV7N8QQnlwaMkNUmAQgoL42GLBsKzpsbdfdR
3W4yctD4Q5FJFmJZ81LVgTCz9y3PSd04v2QWblT4ewjUvpfTY9H+G7rXdoR2BZtY
zj7ytfVHen9ADnKzf15vhP87AUw2IoRe8dLuAQ2li9QPhBS257EbLBzfeOHKaZE8
pMMHBxije0fBV2hFak3P7f+uEo61qlI0PXfgTVx/iahQClR5J6ag1KGZR4RAboNf
+H1iT+OMkmZvs+BVaOEjuPMbK6dywlc2SBuIAogNBfqb4I+A6XlGGGEk3oK2Msq0
uk622/CPXOrGL7/l+wpWieYoj8gDX8y+So7STNyy1NYYGrXtFo0=
=O/dI
-----END PGP SIGNATURE-----
--=-=-=--

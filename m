Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Tue, 02 May 2017 13:42:24 +1000
Subject: [PATCH 02/13] blk: replace bioset_create_nobvec() with a flags arg
 to bioset_create()
Cc: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <149369654407.5146.12779672368228096310.stgit@noble>
In-Reply-To: <149369628671.5146.4865312503373040039.stgit@noble>
References: <149369628671.5146.4865312503373040039.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

"flags" arguments are often seen as good API design as they allow
easy extensibility.
bioset_create_nobvec() is implemented internally as a variation in
flags passed to __bioset_create().

To support future extension, make the internal structure part of the
API.
i.e. add a 'flags' argument to bioset_create() and discard
bioset_create_nobvec().

Note that the bio_split allocations in drivers/md/raid* do not need
the bvec mempool - they should have used bioset_create_nobvec().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 block/bio.c                         |   60 +++++++++++++----------------------
 block/blk-core.c                    |    2 +
 drivers/block/drbd/drbd_main.c      |    2 +
 drivers/md/bcache/super.c           |    4 +-
 drivers/md/dm-crypt.c               |    2 +
 drivers/md/dm-io.c                  |    2 +
 drivers/md/dm.c                     |    2 +
 drivers/md/md.c                     |    2 +
 drivers/md/raid1.c                  |    2 +
 drivers/md/raid10.c                 |    2 +
 drivers/md/raid5-cache.c            |    2 +
 drivers/md/raid5-ppl.c              |    2 +
 drivers/md/raid5.c                  |    2 +
 drivers/target/target_core_iblock.c |    2 +
 fs/block_dev.c                      |    2 +
 fs/btrfs/extent_io.c                |    3 +-
 fs/xfs/xfs_super.c                  |    3 +-
 include/linux/bio.h                 |    6 ++--
 18 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 888e7801c638..3f1286ed301e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1921,9 +1921,26 @@ void bioset_free(struct bio_set *bs)
 }
 EXPORT_SYMBOL(bioset_free);
 
-static struct bio_set *__bioset_create(unsigned int pool_size,
-				       unsigned int front_pad,
-				       bool create_bvec_pool)
+/**
+ * bioset_create  - Create a bio_set
+ * @pool_size:	Number of bio and bio_vecs to cache in the mempool
+ * @front_pad:	Number of bytes to allocate in front of the returned bio
+ * @flags:	Flags to modify behavior, currently only %BIOSET_NEED_BVECS
+ *
+ * Description:
+ *    Set up a bio_set to be used with @bio_alloc_bioset. Allows the caller
+ *    to ask for a number of bytes to be allocated in front of the bio.
+ *    Front pad allocation is useful for embedding the bio inside
+ *    another structure, to avoid allocating extra data to go with the bio.
+ *    Note that the bio must be embedded at the END of that structure always,
+ *    or things will break badly.
+ *    If %BIOSET_NEED_BVECS is set in @flags, a separate pool will be allocated
+ *    for allocating iovecs.  This pool is not needed e.g. for bio_clone_fast().
+ *
+ */
+struct bio_set *bioset_create(unsigned int pool_size,
+			      unsigned int front_pad,
+			      int flags)
 {
 	unsigned int back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
 	struct bio_set *bs;
@@ -1948,7 +1965,7 @@ static struct bio_set *__bioset_create(unsigned int pool_size,
 	if (!bs->bio_pool)
 		goto bad;
 
-	if (create_bvec_pool) {
+	if (flags & BIOSET_NEED_BVECS) {
 		bs->bvec_pool = biovec_create_pool(pool_size);
 		if (!bs->bvec_pool)
 			goto bad;
@@ -1963,41 +1980,8 @@ static struct bio_set *__bioset_create(unsigned int pool_size,
 	bioset_free(bs);
 	return NULL;
 }
-
-/**
- * bioset_create  - Create a bio_set
- * @pool_size:	Number of bio and bio_vecs to cache in the mempool
- * @front_pad:	Number of bytes to allocate in front of the returned bio
- *
- * Description:
- *    Set up a bio_set to be used with @bio_alloc_bioset. Allows the caller
- *    to ask for a number of bytes to be allocated in front of the bio.
- *    Front pad allocation is useful for embedding the bio inside
- *    another structure, to avoid allocating extra data to go with the bio.
- *    Note that the bio must be embedded at the END of that structure always,
- *    or things will break badly.
- */
-struct bio_set *bioset_create(unsigned int pool_size, unsigned int front_pad)
-{
-	return __bioset_create(pool_size, front_pad, true);
-}
 EXPORT_SYMBOL(bioset_create);
 
-/**
- * bioset_create_nobvec  - Create a bio_set without bio_vec mempool
- * @pool_size:	Number of bio to cache in the mempool
- * @front_pad:	Number of bytes to allocate in front of the returned bio
- *
- * Description:
- *    Same functionality as bioset_create() except that mempool is not
- *    created for bio_vecs. Saving some memory for bio_clone_fast() users.
- */
-struct bio_set *bioset_create_nobvec(unsigned int pool_size, unsigned int front_pad)
-{
-	return __bioset_create(pool_size, front_pad, false);
-}
-EXPORT_SYMBOL(bioset_create_nobvec);
-
 #ifdef CONFIG_BLK_CGROUP
 
 /**
@@ -2112,7 +2096,7 @@ static int __init init_bio(void)
 	bio_integrity_init();
 	biovec_init_slabs();
 
-	fs_bio_set = bioset_create(BIO_POOL_SIZE, 0);
+	fs_bio_set = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	if (!fs_bio_set)
 		panic("bio: can't allocate bios\n");
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 1a05c505964d..3797753f4085 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -730,7 +730,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	q->bio_split = bioset_create(BIO_POOL_SIZE, 0);
+	q->bio_split = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	if (!q->bio_split)
 		goto fail_id;
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 84455c365f57..b395fe391171 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2165,7 +2165,7 @@ static int drbd_create_mempools(void)
 		goto Enomem;
 
 	/* mempools */
-	drbd_md_io_bio_set = bioset_create(DRBD_MIN_POOL_PAGES, 0);
+	drbd_md_io_bio_set = bioset_create(DRBD_MIN_POOL_PAGES, 0, BIOSET_NEED_BVECS);
 	if (drbd_md_io_bio_set == NULL)
 		goto Enomem;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 85e3f21c2514..8b9dae98cc7e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -786,7 +786,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 
 	minor *= BCACHE_MINORS;
 
-	if (!(d->bio_split = bioset_create(4, offsetof(struct bbio, bio))) ||
+	if (!(d->bio_split = bioset_create(4, offsetof(struct bbio, bio), BIOSET_NEED_BVECS)) ||
 	    !(d->disk = alloc_disk(BCACHE_MINORS))) {
 		ida_simple_remove(&bcache_minor, minor);
 		return -ENOMEM;
@@ -1520,7 +1520,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 				sizeof(struct bbio) + sizeof(struct bio_vec) *
 				bucket_pages(c))) ||
 	    !(c->fill_iter = mempool_create_kmalloc_pool(1, iter_size)) ||
-	    !(c->bio_split = bioset_create(4, offsetof(struct bbio, bio))) ||
+	    !(c->bio_split = bioset_create(4, offsetof(struct bbio, bio), BIOSET_NEED_BVECS)) ||
 	    !(c->uuids = alloc_bucket_pages(GFP_KERNEL, c)) ||
 	    !(c->moving_gc_wq = alloc_workqueue("bcache_gc",
 						WQ_MEM_RECLAIM, 0)) ||
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index ef1d836bd81b..5a98c1eb87d9 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1936,7 +1936,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad;
 	}
 
-	cc->bs = bioset_create(MIN_IOS, 0);
+	cc->bs = bioset_create(MIN_IOS, 0, BIOSET_NEED_BVECS);
 	if (!cc->bs) {
 		ti->error = "Cannot allocate crypt bioset";
 		goto bad;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 3702e502466d..1d86d1d39d48 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -58,7 +58,7 @@ struct dm_io_client *dm_io_client_create(void)
 	if (!client->pool)
 		goto bad;
 
-	client->bios = bioset_create(min_ios, 0);
+	client->bios = bioset_create(min_ios, 0, BIOSET_NEED_BVECS);
 	if (!client->bios)
 		goto bad;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8bf397729bbd..e21a7d58c8ef 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2601,7 +2601,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, unsigned t
 		BUG();
 	}
 
-	pools->bs = bioset_create_nobvec(pool_size, front_pad);
+	pools->bs = bioset_create(pool_size, front_pad, 0);
 	if (!pools->bs)
 		goto out;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index de78e74c8e01..1379fb636de2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5420,7 +5420,7 @@ int md_run(struct mddev *mddev)
 	}
 
 	if (mddev->bio_set == NULL) {
-		mddev->bio_set = bioset_create(BIO_POOL_SIZE, 0);
+		mddev->bio_set = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (!mddev->bio_set)
 			return -ENOMEM;
 	}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7ed59351fe97..3f951e4a36ea 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2953,7 +2953,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 	if (!conf->r1bio_pool)
 		goto abort;
 
-	conf->bio_split = bioset_create(BIO_POOL_SIZE, 0);
+	conf->bio_split = bioset_create(BIO_POOL_SIZE, 0, 0);
 	if (!conf->bio_split)
 		goto abort;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6b86a0032cf8..9b401a9eae85 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3553,7 +3553,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	if (!conf->r10bio_pool)
 		goto out;
 
-	conf->bio_split = bioset_create(BIO_POOL_SIZE, 0);
+	conf->bio_split = bioset_create(BIO_POOL_SIZE, 0, 0);
 	if (!conf->bio_split)
 		goto out;
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index b6194e082e48..ea562aa735ac 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3034,7 +3034,7 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	if (!log->io_pool)
 		goto io_pool;
 
-	log->bs = bioset_create(R5L_POOL_SIZE, 0);
+	log->bs = bioset_create(R5L_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	if (!log->bs)
 		goto io_bs;
 
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 5d25bebf3328..3a31e6ef74d5 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -1150,7 +1150,7 @@ int ppl_init_log(struct r5conf *conf)
 		goto err;
 	}
 
-	ppl_conf->bs = bioset_create(conf->raid_disks, 0);
+	ppl_conf->bs = bioset_create(conf->raid_disks, 0, 0);
 	if (!ppl_conf->bs) {
 		ret = -ENOMEM;
 		goto err;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2e38cfac5b1d..3da078676503 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6918,7 +6918,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 			goto abort;
 	}
 
-	conf->bio_split = bioset_create(BIO_POOL_SIZE, 0);
+	conf->bio_split = bioset_create(BIO_POOL_SIZE, 0, 0);
 	if (!conf->bio_split)
 		goto abort;
 	conf->mddev = mddev;
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index d316ed537d59..c7b373dafaf9 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -93,7 +93,7 @@ static int iblock_configure_device(struct se_device *dev)
 		return -EINVAL;
 	}
 
-	ib_dev->ibd_bio_set = bioset_create(IBLOCK_BIO_POOL_SIZE, 0);
+	ib_dev->ibd_bio_set = bioset_create(IBLOCK_BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	if (!ib_dev->ibd_bio_set) {
 		pr_err("IBLOCK: Unable to create bioset\n");
 		goto out;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9ccabe3bb7de..6e7a4c411cd2 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -436,7 +436,7 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static __init int blkdev_init(void)
 {
-	blkdev_dio_pool = bioset_create(4, offsetof(struct blkdev_dio, bio));
+	blkdev_dio_pool = bioset_create(4, offsetof(struct blkdev_dio, bio), BIOSET_NEED_BVECS);
 	if (!blkdev_dio_pool)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 27fdb250b446..6897c2cd18d3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -174,7 +174,8 @@ int __init extent_io_init(void)
 		goto free_state_cache;
 
 	btrfs_bioset = bioset_create(BIO_POOL_SIZE,
-				     offsetof(struct btrfs_io_bio, bio));
+				     offsetof(struct btrfs_io_bio, bio),
+				     BIOSET_NEED_BVECS);
 	if (!btrfs_bioset)
 		goto free_buffer_cache;
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 685c042a120f..0262063014c6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1757,7 +1757,8 @@ STATIC int __init
 xfs_init_zones(void)
 {
 	xfs_ioend_bioset = bioset_create(4 * MAX_BUF_PER_PAGE,
-			offsetof(struct xfs_ioend, io_inline_bio));
+			offsetof(struct xfs_ioend, io_inline_bio),
+			BIOSET_NEED_BVECS);
 	if (!xfs_ioend_bioset)
 		goto out;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d1b04b0e99cf..0975da6bebd9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -373,8 +373,10 @@ static inline struct bio *bio_next_split(struct bio *bio, int sectors,
 	return bio_split(bio, sectors, gfp, bs);
 }
 
-extern struct bio_set *bioset_create(unsigned int, unsigned int);
-extern struct bio_set *bioset_create_nobvec(unsigned int, unsigned int);
+extern struct bio_set *bioset_create(unsigned int, unsigned int, int flags);
+enum {
+	BIOSET_NEED_BVECS = BIT(0),
+};
 extern void bioset_free(struct bio_set *);
 extern mempool_t *biovec_create_pool(int pool_entries);
 

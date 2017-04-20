Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 20 Apr 2017 15:38:48 +1000
Subject: [PATCH 02/11] blk: make the bioset rescue_workqueue optional.
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149266672858.27388.11409778158413625707.stgit@noble>
In-Reply-To: <149266645258.27388.14083229348123176454.stgit@noble>
References: <149266645258.27388.14083229348123176454.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

This patch converts bioset_create() and
bioset_create_nobvec() to not create a workqueue so
alloctions will never trigger punt_bios_to_rescuer().  It
also introduces bioset_create_rescued() and
bioset_create_nobvec_rescued() which preserve the old
behaviour.

All callers of bioset_create() and bioset_create_nobvec(),
that are inside block device drivers, are converted to the
_rescued() version.

biosets used by filesystems or other top-level users do not
need rescuing as the bio can never be queued behind other
bios.  This includes fs_bio_set, blkdev_dio_pool,
btrfs_bioset, xfs_ioend_bioset, drbd_md_io_bio_set,
and one allocated by target_core_iblock.c.

biosets used by md/raid to not need rescuing as
their usage was recently audited to revised to never
risk deadlock.

It is hoped that most, if not all, of the remaining biosets
can end up being the non-rescued version.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 block/bio.c               |   28 ++++++++++++++++++++++++----
 block/blk-core.c          |    2 +-
 drivers/md/bcache/super.c |    4 ++--
 drivers/md/dm-crypt.c     |    2 +-
 drivers/md/dm-io.c        |    2 +-
 drivers/md/dm.c           |    5 +++--
 include/linux/bio.h       |    2 ++
 7 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 888e7801c638..b8e304015dc8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -363,6 +363,8 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
 	struct bio_list punt, nopunt;
 	struct bio *bio;
 
+	if (!WARN_ON_ONCE(!bs->rescue_workqueue))
+		return;
 	/*
 	 * In order to guarantee forward progress we must punt only bios that
 	 * were allocated from this bio_set; otherwise, if there was a bio on
@@ -474,7 +476,8 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 
 		if (current->bio_list &&
 		    (!bio_list_empty(&current->bio_list[0]) ||
-		     !bio_list_empty(&current->bio_list[1])))
+		     !bio_list_empty(&current->bio_list[1])) &&
+		    bs->rescue_workqueue)
 			gfp_mask &= ~__GFP_DIRECT_RECLAIM;
 
 		p = mempool_alloc(bs->bio_pool, gfp_mask);
@@ -1923,7 +1926,8 @@ EXPORT_SYMBOL(bioset_free);
 
 static struct bio_set *__bioset_create(unsigned int pool_size,
 				       unsigned int front_pad,
-				       bool create_bvec_pool)
+				       bool create_bvec_pool,
+				       bool create_rescue_workqueue)
 {
 	unsigned int back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
 	struct bio_set *bs;
@@ -1954,6 +1958,9 @@ static struct bio_set *__bioset_create(unsigned int pool_size,
 			goto bad;
 	}
 
+	if (!create_rescue_workqueue)
+		return bs;
+
 	bs->rescue_workqueue = alloc_workqueue("bioset", WQ_MEM_RECLAIM, 0);
 	if (!bs->rescue_workqueue)
 		goto bad;
@@ -1979,10 +1986,16 @@ static struct bio_set *__bioset_create(unsigned int pool_size,
  */
 struct bio_set *bioset_create(unsigned int pool_size, unsigned int front_pad)
 {
-	return __bioset_create(pool_size, front_pad, true);
+	return __bioset_create(pool_size, front_pad, true, false);
 }
 EXPORT_SYMBOL(bioset_create);
 
+struct bio_set *bioset_create_rescued(unsigned int pool_size, unsigned int front_pad)
+{
+	return __bioset_create(pool_size, front_pad, true, true);
+}
+EXPORT_SYMBOL(bioset_create_rescued);
+
 /**
  * bioset_create_nobvec  - Create a bio_set without bio_vec mempool
  * @pool_size:	Number of bio to cache in the mempool
@@ -1994,10 +2007,17 @@ EXPORT_SYMBOL(bioset_create);
  */
 struct bio_set *bioset_create_nobvec(unsigned int pool_size, unsigned int front_pad)
 {
-	return __bioset_create(pool_size, front_pad, false);
+	return __bioset_create(pool_size, front_pad, false, false);
 }
 EXPORT_SYMBOL(bioset_create_nobvec);
 
+struct bio_set *bioset_create_nobvec_rescued(unsigned int pool_size,
+					     unsigned int front_pad)
+{
+	return __bioset_create(pool_size, front_pad, false, true);
+}
+EXPORT_SYMBOL(bioset_create_nobvec_rescued);
+
 #ifdef CONFIG_BLK_CGROUP
 
 /**
diff --git a/block/blk-core.c b/block/blk-core.c
index f5d64ad75b36..23f20cb84b2f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -728,7 +728,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	q->bio_split = bioset_create(BIO_POOL_SIZE, 0);
+	q->bio_split = bioset_create_rescued(BIO_POOL_SIZE, 0);
 	if (!q->bio_split)
 		goto fail_id;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 85e3f21c2514..6cb30792f0ed 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -786,7 +786,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 
 	minor *= BCACHE_MINORS;
 
-	if (!(d->bio_split = bioset_create(4, offsetof(struct bbio, bio))) ||
+	if (!(d->bio_split = bioset_create_rescued(4, offsetof(struct bbio, bio))) ||
 	    !(d->disk = alloc_disk(BCACHE_MINORS))) {
 		ida_simple_remove(&bcache_minor, minor);
 		return -ENOMEM;
@@ -1520,7 +1520,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 				sizeof(struct bbio) + sizeof(struct bio_vec) *
 				bucket_pages(c))) ||
 	    !(c->fill_iter = mempool_create_kmalloc_pool(1, iter_size)) ||
-	    !(c->bio_split = bioset_create(4, offsetof(struct bbio, bio))) ||
+	    !(c->bio_split = bioset_create_rescued(4, offsetof(struct bbio, bio))) ||
 	    !(c->uuids = alloc_bucket_pages(GFP_KERNEL, c)) ||
 	    !(c->moving_gc_wq = alloc_workqueue("bcache_gc",
 						WQ_MEM_RECLAIM, 0)) ||
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index ef1d836bd81b..b7b1df84fe4a 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1936,7 +1936,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad;
 	}
 
-	cc->bs = bioset_create(MIN_IOS, 0);
+	cc->bs = bioset_create_rescued(MIN_IOS, 0);
 	if (!cc->bs) {
 		ti->error = "Cannot allocate crypt bioset";
 		goto bad;
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 3702e502466d..5557d5d97b5b 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -58,7 +58,7 @@ struct dm_io_client *dm_io_client_create(void)
 	if (!client->pool)
 		goto bad;
 
-	client->bios = bioset_create(min_ios, 0);
+	client->bios = bioset_create_rescued(min_ios, 0);
 	if (!client->bios)
 		goto bad;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8bf397729bbd..5590c571c0e7 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1014,7 +1014,8 @@ static void flush_current_bio_list(struct blk_plug_cb *cb, bool from_schedule)
 
 		while ((bio = bio_list_pop(&list))) {
 			struct bio_set *bs = bio->bi_pool;
-			if (unlikely(!bs) || bs == fs_bio_set) {
+			if (unlikely(!bs) || bs == fs_bio_set ||
+			    !bs->rescue_workqueue) {
 				bio_list_add(&current->bio_list[i], bio);
 				continue;
 			}
@@ -2601,7 +2602,7 @@ struct dm_md_mempools *dm_alloc_md_mempools(struct mapped_device *md, unsigned t
 		BUG();
 	}
 
-	pools->bs = bioset_create_nobvec(pool_size, front_pad);
+	pools->bs = bioset_create_nobvec_rescued(pool_size, front_pad);
 	if (!pools->bs)
 		goto out;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d1b04b0e99cf..2eb8bfae5276 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -374,7 +374,9 @@ static inline struct bio *bio_next_split(struct bio *bio, int sectors,
 }
 
 extern struct bio_set *bioset_create(unsigned int, unsigned int);
+extern struct bio_set *bioset_create_rescued(unsigned int, unsigned int);
 extern struct bio_set *bioset_create_nobvec(unsigned int, unsigned int);
+extern struct bio_set *bioset_create_nobvec_rescued(unsigned int, unsigned int);
 extern void bioset_free(struct bio_set *);
 extern mempool_t *biovec_create_pool(int pool_entries);
 

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50251 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424332AbcKANk3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:40:29 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/16] block,fs: use REQ_* flags directly
Date: Tue,  1 Nov 2016 07:40:10 -0600
Message-Id: <1478007617-18715-10-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove the WRITE_* and READ_SYNC wrappers, and just use the flags
directly.  Where applicable this also drops usage of the
bio_set_op_attrs wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c                   |  4 ++--
 drivers/block/drbd/drbd_receiver.c  |  2 +-
 drivers/block/xen-blkback/blkback.c | 10 ++++----
 drivers/md/bcache/btree.c           |  4 ++--
 drivers/md/bcache/debug.c           |  4 ++--
 drivers/md/bcache/request.c         |  2 +-
 drivers/md/bcache/super.c           |  4 ++--
 drivers/md/dm-bufio.c               |  2 +-
 drivers/md/dm-log.c                 |  2 +-
 drivers/md/dm-raid1.c               |  4 ++--
 drivers/md/dm-snap-persistent.c     |  4 ++--
 drivers/md/dm.c                     |  2 +-
 drivers/md/md.c                     |  4 ++--
 drivers/md/raid5-cache.c            |  4 ++--
 drivers/md/raid5.c                  |  2 +-
 drivers/nvme/target/io-cmd.c        |  4 ++--
 drivers/target/target_core_iblock.c |  8 +++----
 fs/btrfs/disk-io.c                  |  6 ++---
 fs/btrfs/extent_io.c                | 16 ++++++-------
 fs/btrfs/inode.c                    |  6 ++---
 fs/btrfs/scrub.c                    |  2 +-
 fs/btrfs/volumes.c                  |  2 +-
 fs/btrfs/volumes.h                  |  2 +-
 fs/buffer.c                         |  8 +++----
 fs/direct-io.c                      |  2 +-
 fs/ext4/mmp.c                       |  6 ++---
 fs/ext4/page-io.c                   |  2 +-
 fs/ext4/super.c                     |  2 +-
 fs/f2fs/checkpoint.c                |  4 ++--
 fs/f2fs/data.c                      | 16 ++++++-------
 fs/f2fs/gc.c                        |  6 ++---
 fs/f2fs/inline.c                    |  2 +-
 fs/f2fs/node.c                      |  4 ++--
 fs/f2fs/segment.c                   |  8 +++----
 fs/f2fs/super.c                     |  2 +-
 fs/gfs2/log.c                       |  4 ++--
 fs/gfs2/meta_io.c                   |  6 ++---
 fs/gfs2/ops_fstype.c                |  2 +-
 fs/hfsplus/super.c                  |  4 ++--
 fs/jbd2/checkpoint.c                |  2 +-
 fs/jbd2/commit.c                    |  9 +++----
 fs/jbd2/journal.c                   | 15 ++++++------
 fs/jbd2/revoke.c                    |  2 +-
 fs/jfs/jfs_logmgr.c                 |  4 ++--
 fs/mpage.c                          |  6 ++---
 fs/nilfs2/super.c                   |  2 +-
 fs/ocfs2/cluster/heartbeat.c        |  2 +-
 fs/reiserfs/journal.c               |  6 +++--
 fs/xfs/xfs_aops.c                   | 11 +++++----
 fs/xfs/xfs_buf.c                    |  2 +-
 include/linux/fs.h                  | 47 -------------------------------------
 include/trace/events/f2fs.h         | 10 ++++----
 kernel/power/swap.c                 | 19 +++++++--------
 53 files changed, 133 insertions(+), 182 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 95f1d4d..d35beca 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -330,7 +330,7 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	}
 
 	flush_rq->cmd_type = REQ_TYPE_FS;
-	flush_rq->cmd_flags = REQ_OP_FLUSH | WRITE_FLUSH;
+	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->rq_disk = first_rq->rq_disk;
 	flush_rq->end_io = flush_end_io;
@@ -486,7 +486,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 
 	bio = bio_alloc(gfp_mask, 0);
 	bio->bi_bdev = bdev;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	ret = submit_bio_wait(bio);
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 942384f..a89538c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1266,7 +1266,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio->bi_bdev = device->ldev->backing_bdev;
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio_set_op_attrs(bio, REQ_OP_FLUSH, WRITE_FLUSH);
+	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 4a80ee7..726c32e 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1253,14 +1253,14 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	case BLKIF_OP_WRITE:
 		ring->st_wr_req++;
 		operation = REQ_OP_WRITE;
-		operation_flags = WRITE_ODIRECT;
+		operation_flags = REQ_SYNC | REQ_IDLE;
 		break;
 	case BLKIF_OP_WRITE_BARRIER:
 		drain = true;
 	case BLKIF_OP_FLUSH_DISKCACHE:
 		ring->st_f_req++;
 		operation = REQ_OP_WRITE;
-		operation_flags = WRITE_FLUSH;
+		operation_flags = REQ_PREFLUSH;
 		break;
 	default:
 		operation = 0; /* make gcc happy */
@@ -1272,7 +1272,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	nseg = req->operation == BLKIF_OP_INDIRECT ?
 	       req->u.indirect.nr_segments : req->u.rw.nr_segments;
 
-	if (unlikely(nseg == 0 && operation_flags != WRITE_FLUSH) ||
+	if (unlikely(nseg == 0 && operation_flags != REQ_PREFLUSH) ||
 	    unlikely((req->operation != BLKIF_OP_INDIRECT) &&
 		     (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST)) ||
 	    unlikely((req->operation == BLKIF_OP_INDIRECT) &&
@@ -1334,7 +1334,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	}
 
 	/* Wait on all outstanding I/O's and once that has been completed
-	 * issue the WRITE_FLUSH.
+	 * issue the flush.
 	 */
 	if (drain)
 		xen_blk_drain_io(pending_req->ring);
@@ -1380,7 +1380,7 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 
 	/* This will be hit if the operation was a flush or discard. */
 	if (!bio) {
-		BUG_ON(operation_flags != WRITE_FLUSH);
+		BUG_ON(operation_flags != REQ_PREFLUSH);
 
 		bio = bio_alloc(GFP_KERNEL, 0);
 		if (unlikely(bio == NULL))
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 81d3db4..6fdd8e2 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -297,7 +297,7 @@ static void bch_btree_node_read(struct btree *b)
 	bio->bi_iter.bi_size = KEY_SIZE(&b->key) << 9;
 	bio->bi_end_io	= btree_node_read_endio;
 	bio->bi_private	= &cl;
-	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META|READ_SYNC);
+	bio->bi_opf = REQ_OP_READ | REQ_META;
 
 	bch_bio_map(bio, b->keys.set[0].data);
 
@@ -393,7 +393,7 @@ static void do_btree_node_write(struct btree *b)
 	b->bio->bi_end_io	= btree_node_write_endio;
 	b->bio->bi_private	= cl;
 	b->bio->bi_iter.bi_size	= roundup(set_bytes(i), block_bytes(b->c));
-	bio_set_op_attrs(b->bio, REQ_OP_WRITE, REQ_META|WRITE_SYNC|REQ_FUA);
+	b->bio->bi_opf		= REQ_OP_WRITE | REQ_META | REQ_FUA;
 	bch_bio_map(b->bio, i);
 
 	/*
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 333a1e5..1c9130ae 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -52,7 +52,7 @@ void bch_btree_verify(struct btree *b)
 	bio->bi_bdev		= PTR_CACHE(b->c, &b->key, 0)->bdev;
 	bio->bi_iter.bi_sector	= PTR_OFFSET(&b->key, 0);
 	bio->bi_iter.bi_size	= KEY_SIZE(&v->key) << 9;
-	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META|READ_SYNC);
+	bio->bi_opf		= REQ_OP_READ | REQ_META;
 	bch_bio_map(bio, sorted);
 
 	submit_bio_wait(bio);
@@ -113,7 +113,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	check = bio_clone(bio, GFP_NOIO);
 	if (!check)
 		return;
-	bio_set_op_attrs(check, REQ_OP_READ, READ_SYNC);
+	check->bi_opf = REQ_OP_READ;
 
 	if (bio_alloc_pages(check, GFP_NOIO))
 		goto out_put;
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index e8a2b69..0d99b5f 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -923,7 +923,7 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
 			flush->bi_bdev	= bio->bi_bdev;
 			flush->bi_end_io = request_endio;
 			flush->bi_private = cl;
-			bio_set_op_attrs(flush, REQ_OP_WRITE, WRITE_FLUSH);
+			flush->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 			closure_bio_submit(flush, cl);
 		}
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 849ad44..988edf9 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -381,7 +381,7 @@ static char *uuid_read(struct cache_set *c, struct jset *j, struct closure *cl)
 		return "bad uuid pointer";
 
 	bkey_copy(&c->uuid_bucket, k);
-	uuid_io(c, REQ_OP_READ, READ_SYNC, k, cl);
+	uuid_io(c, REQ_OP_READ, 0, k, cl);
 
 	if (j->version < BCACHE_JSET_VERSION_UUIDv1) {
 		struct uuid_entry_v0	*u0 = (void *) c->uuids;
@@ -600,7 +600,7 @@ static void prio_read(struct cache *ca, uint64_t bucket)
 			ca->prio_last_buckets[bucket_nr] = bucket;
 			bucket_nr++;
 
-			prio_io(ca, bucket, REQ_OP_READ, READ_SYNC);
+			prio_io(ca, bucket, REQ_OP_READ, 0);
 
 			if (p->csum != bch_crc64(&p->magic, bucket_bytes(ca) - 8))
 				pr_warn("bad csum reading priorities");
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 125aedc..b3ba142 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1316,7 +1316,7 @@ int dm_bufio_issue_flush(struct dm_bufio_client *c)
 {
 	struct dm_io_request io_req = {
 		.bi_op = REQ_OP_WRITE,
-		.bi_op_flags = WRITE_FLUSH,
+		.bi_op_flags = REQ_PREFLUSH,
 		.mem.type = DM_IO_KMEM,
 		.mem.ptr.addr = NULL,
 		.client = c->dm_io,
diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 07fc1ad..33e71ea 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -308,7 +308,7 @@ static int flush_header(struct log_c *lc)
 	};
 
 	lc->io_req.bi_op = REQ_OP_WRITE;
-	lc->io_req.bi_op_flags = WRITE_FLUSH;
+	lc->io_req.bi_op_flags = REQ_PREFLUSH;
 
 	return dm_io(&lc->io_req, 1, &null_location, NULL);
 }
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index bdf1606..1a176d7 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -261,7 +261,7 @@ static int mirror_flush(struct dm_target *ti)
 	struct mirror *m;
 	struct dm_io_request io_req = {
 		.bi_op = REQ_OP_WRITE,
-		.bi_op_flags = WRITE_FLUSH,
+		.bi_op_flags = REQ_PREFLUSH,
 		.mem.type = DM_IO_KMEM,
 		.mem.ptr.addr = NULL,
 		.client = ms->io_client,
@@ -657,7 +657,7 @@ static void do_write(struct mirror_set *ms, struct bio *bio)
 	struct mirror *m;
 	struct dm_io_request io_req = {
 		.bi_op = REQ_OP_WRITE,
-		.bi_op_flags = bio->bi_opf & WRITE_FLUSH_FUA,
+		.bi_op_flags = bio->bi_opf & (REQ_FUA | REQ_PREFLUSH),
 		.mem.type = DM_IO_BIO,
 		.mem.ptr.bio = bio,
 		.notify.fn = write_callback,
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index b8cf956..b93476c 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -741,7 +741,7 @@ static void persistent_commit_exception(struct dm_exception_store *store,
 	/*
 	 * Commit exceptions to disk.
 	 */
-	if (ps->valid && area_io(ps, REQ_OP_WRITE, WRITE_FLUSH_FUA))
+	if (ps->valid && area_io(ps, REQ_OP_WRITE, REQ_PREFLUSH | REQ_FUA))
 		ps->valid = 0;
 
 	/*
@@ -818,7 +818,7 @@ static int persistent_commit_merge(struct dm_exception_store *store,
 	for (i = 0; i < nr_merged; i++)
 		clear_exception(ps, ps->current_committed - 1 - i);
 
-	r = area_io(ps, REQ_OP_WRITE, WRITE_FLUSH_FUA);
+	r = area_io(ps, REQ_OP_WRITE, REQ_PREFLUSH | REQ_FUA);
 	if (r < 0)
 		return r;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 147af95..b2abfa4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1527,7 +1527,7 @@ static struct mapped_device *alloc_dev(int minor)
 
 	bio_init(&md->flush_bio);
 	md->flush_bio.bi_bdev = md->bdev;
-	bio_set_op_attrs(&md->flush_bio, REQ_OP_WRITE, WRITE_FLUSH);
+	md->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	dm_stats_init(&md->stats);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index eac84d8..b69ec7d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -394,7 +394,7 @@ static void submit_flushes(struct work_struct *ws)
 			bi->bi_end_io = md_end_flush;
 			bi->bi_private = rdev;
 			bi->bi_bdev = rdev->bdev;
-			bio_set_op_attrs(bi, REQ_OP_WRITE, WRITE_FLUSH);
+			bi->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 			atomic_inc(&mddev->flush_pending);
 			submit_bio(bi);
 			rcu_read_lock();
@@ -743,7 +743,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH_FUA);
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_FUA;
 
 	atomic_inc(&mddev->pending_writes);
 	submit_bio(bio);
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 1b1ab4a..28d015c 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -685,7 +685,7 @@ void r5l_flush_stripe_to_raid(struct r5l_log *log)
 	bio_reset(&log->flush_bio);
 	log->flush_bio.bi_bdev = log->rdev->bdev;
 	log->flush_bio.bi_end_io = r5l_log_flush_endio;
-	bio_set_op_attrs(&log->flush_bio, REQ_OP_WRITE, WRITE_FLUSH);
+	log->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	submit_bio(&log->flush_bio);
 }
 
@@ -1053,7 +1053,7 @@ static int r5l_log_write_empty_meta_block(struct r5l_log *log, sector_t pos,
 	mb->checksum = cpu_to_le32(crc);
 
 	if (!sync_page_io(log->rdev, pos, PAGE_SIZE, page, REQ_OP_WRITE,
-			  WRITE_FUA, false)) {
+			  REQ_FUA, false)) {
 		__free_page(page);
 		return -EIO;
 	}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 92ac251..70acdd3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -913,7 +913,7 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 		if (test_and_clear_bit(R5_Wantwrite, &sh->dev[i].flags)) {
 			op = REQ_OP_WRITE;
 			if (test_and_clear_bit(R5_WantFUA, &sh->dev[i].flags))
-				op_flags = WRITE_FUA;
+				op_flags = REQ_FUA;
 			if (test_bit(R5_Discard, &sh->dev[i].flags))
 				op = REQ_OP_DISCARD;
 		} else if (test_and_clear_bit(R5_Wantread, &sh->dev[i].flags))
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4a96c20..c2784cf 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -58,7 +58,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		op = REQ_OP_WRITE;
-		op_flags = WRITE_ODIRECT;
+		op_flags = REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			op_flags |= REQ_FUA;
 	} else {
@@ -109,7 +109,7 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	bio->bi_bdev = req->ns->bdev;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	submit_bio(bio);
 }
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 372d744..d316ed5 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -388,7 +388,7 @@ iblock_execute_sync_cache(struct se_cmd *cmd)
 	bio = bio_alloc(GFP_KERNEL, 0);
 	bio->bi_end_io = iblock_end_io_flush;
 	bio->bi_bdev = ib_dev->ibd_bd;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	if (!immed)
 		bio->bi_private = cmd;
 	submit_bio(bio);
@@ -686,15 +686,15 @@ iblock_execute_rw(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 		struct request_queue *q = bdev_get_queue(ib_dev->ibd_bd);
 		/*
-		 * Force writethrough using WRITE_FUA if a volatile write cache
+		 * Force writethrough using REQ_FUA if a volatile write cache
 		 * is not enabled, or if initiator set the Force Unit Access bit.
 		 */
 		op = REQ_OP_WRITE;
 		if (test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {
 			if (cmd->se_cmd_flags & SCF_FUA)
-				op_flags = WRITE_FUA;
+				op_flags = REQ_FUA;
 			else if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
-				op_flags = WRITE_FUA;
+				op_flags = REQ_FUA;
 		}
 	} else {
 		op = REQ_OP_READ;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c8454a8..fe10afd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3485,9 +3485,9 @@ static int write_dev_supers(struct btrfs_device *device,
 		 * to go down lazy.
 		 */
 		if (i == 0)
-			ret = btrfsic_submit_bh(REQ_OP_WRITE, WRITE_FUA, bh);
+			ret = btrfsic_submit_bh(REQ_OP_WRITE, REQ_FUA, bh);
 		else
-			ret = btrfsic_submit_bh(REQ_OP_WRITE, WRITE_SYNC, bh);
+			ret = btrfsic_submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
 		if (ret)
 			errors++;
 	}
@@ -3551,7 +3551,7 @@ static int write_dev_flush(struct btrfs_device *device, int wait)
 
 	bio->bi_end_io = btrfs_end_empty_barrier;
 	bio->bi_bdev = device->bdev;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	init_completion(&device->flush_wait);
 	bio->bi_private = &device->flush_wait;
 	device->flush_bio = bio;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 66a7551..ff87bff 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -127,7 +127,7 @@ struct extent_page_data {
 	 */
 	unsigned int extent_locked:1;
 
-	/* tells the submit_bio code to use a WRITE_SYNC */
+	/* tells the submit_bio code to use REQ_SYNC */
 	unsigned int sync_io:1;
 };
 
@@ -2047,7 +2047,7 @@ int repair_io_failure(struct inode *inode, u64 start, u64 length, u64 logical,
 		return -EIO;
 	}
 	bio->bi_bdev = dev->bdev;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_SYNC);
+	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 	bio_add_page(bio, page, length, pg_offset);
 
 	if (btrfsic_submit_bio_wait(bio)) {
@@ -2388,7 +2388,7 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct bio *bio;
-	int read_mode;
+	int read_mode = 0;
 	int ret;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -2404,9 +2404,7 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	}
 
 	if (failed_bio->bi_vcnt > 1)
-		read_mode = READ_SYNC | REQ_FAILFAST_DEV;
-	else
-		read_mode = READ_SYNC;
+		read_mode |= REQ_FAILFAST_DEV;
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
 	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
@@ -3484,7 +3482,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	unsigned long nr_written = 0;
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		write_flags = WRITE_SYNC;
+		write_flags = REQ_SYNC;
 
 	trace___extent_writepage(page, inode, wbc);
 
@@ -3729,7 +3727,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	unsigned long i, num_pages;
 	unsigned long bio_flags = 0;
 	unsigned long start, end;
-	int write_flags = (epd->sync_io ? WRITE_SYNC : 0) | REQ_META;
+	int write_flags = (epd->sync_io ? REQ_SYNC : 0) | REQ_META;
 	int ret = 0;
 
 	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
@@ -4076,7 +4074,7 @@ static void flush_epd_write_bio(struct extent_page_data *epd)
 		int ret;
 
 		bio_set_op_attrs(epd->bio, REQ_OP_WRITE,
-				 epd->sync_io ? WRITE_SYNC : 0);
+				 epd->sync_io ? REQ_SYNC : 0);
 
 		ret = submit_one_bio(epd->bio, 0, epd->bio_flags);
 		BUG_ON(ret < 0); /* -ENOMEM */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9a37707..c8eb82a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7917,7 +7917,7 @@ static int dio_read_error(struct inode *inode, struct bio *failed_bio,
 	struct io_failure_record *failrec;
 	struct bio *bio;
 	int isector;
-	int read_mode;
+	int read_mode = 0;
 	int ret;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
@@ -7936,9 +7936,7 @@ static int dio_read_error(struct inode *inode, struct bio *failed_bio,
 	if ((failed_bio->bi_vcnt > 1)
 		|| (failed_bio->bi_io_vec->bv_len
 			> BTRFS_I(inode)->root->sectorsize))
-		read_mode = READ_SYNC | REQ_FAILFAST_DEV;
-	else
-		read_mode = READ_SYNC;
+		read_mode |= REQ_FAILFAST_DEV;
 
 	isector = start - btrfs_io_bio(failed_bio)->logical;
 	isector >>= inode->i_sb->s_blocksize_bits;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fffb9ab..ff30782 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4440,7 +4440,7 @@ static int write_page_nocow(struct scrub_ctx *sctx,
 	bio->bi_iter.bi_size = 0;
 	bio->bi_iter.bi_sector = physical_for_dev_replace >> 9;
 	bio->bi_bdev = dev->bdev;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_SYNC);
+	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 	ret = bio_add_page(bio, page, PAGE_SIZE, 0);
 	if (ret != PAGE_SIZE) {
 leave_with_eio:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index deda46cf..0d7d635 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6023,7 +6023,7 @@ static void btrfs_end_bio(struct bio *bio)
 				else
 					btrfs_dev_stat_inc(dev,
 						BTRFS_DEV_STAT_READ_ERRS);
-				if ((bio->bi_opf & WRITE_FLUSH) == WRITE_FLUSH)
+				if (bio->bi_opf & REQ_PREFLUSH)
 					btrfs_dev_stat_inc(dev,
 						BTRFS_DEV_STAT_FLUSH_ERRS);
 				btrfs_dev_stat_print_on_error(dev);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 09ed29c..f137ffe 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -62,7 +62,7 @@ struct btrfs_device {
 	int running_pending;
 	/* regular prio bios */
 	struct btrfs_pending_bios pending_bios;
-	/* WRITE_SYNC bios */
+	/* sync bios */
 	struct btrfs_pending_bios pending_sync_bios;
 
 	struct block_device *bdev;
diff --git a/fs/buffer.c b/fs/buffer.c
index a293358..bc7c2bb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -753,7 +753,7 @@ static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
 				 * still in flight on potentially older
 				 * contents.
 				 */
-				write_dirty_buffer(bh, WRITE_SYNC);
+				write_dirty_buffer(bh, REQ_SYNC);
 
 				/*
 				 * Kick off IO for the previous mapping. Note
@@ -1684,7 +1684,7 @@ static struct buffer_head *create_page_buffers(struct page *page, struct inode *
  * prevents this contention from occurring.
  *
  * If block_write_full_page() is called with wbc->sync_mode ==
- * WB_SYNC_ALL, the writes are posted using WRITE_SYNC; this
+ * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
  * causes the writes to be flagged as synchronous writes.
  */
 int __block_write_full_page(struct inode *inode, struct page *page,
@@ -1697,7 +1697,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	struct buffer_head *bh, *head;
 	unsigned int blocksize, bbits;
 	int nr_underway = 0;
-	int write_flags = (wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : 0);
+	int write_flags = (wbc->sync_mode == WB_SYNC_ALL ? REQ_SYNC : 0);
 
 	head = create_page_buffers(page, inode,
 					(1 << BH_Dirty)|(1 << BH_Uptodate));
@@ -3210,7 +3210,7 @@ EXPORT_SYMBOL(__sync_dirty_buffer);
 
 int sync_dirty_buffer(struct buffer_head *bh)
 {
-	return __sync_dirty_buffer(bh, WRITE_SYNC);
+	return __sync_dirty_buffer(bh, REQ_SYNC);
 }
 EXPORT_SYMBOL(sync_dirty_buffer);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index fb9aa16..a5138c5 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1209,7 +1209,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	dio->inode = inode;
 	if (iov_iter_rw(iter) == WRITE) {
 		dio->op = REQ_OP_WRITE;
-		dio->op_flags = WRITE_ODIRECT;
+		dio->op_flags = REQ_SYNC | REQ_IDLE;
 	} else {
 		dio->op = REQ_OP_READ;
 	}
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index d89754e..eb98356 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -35,7 +35,7 @@ static void ext4_mmp_csum_set(struct super_block *sb, struct mmp_struct *mmp)
 }
 
 /*
- * Write the MMP block using WRITE_SYNC to try to get the block on-disk
+ * Write the MMP block using REQ_SYNC to try to get the block on-disk
  * faster.
  */
 static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
@@ -52,7 +52,7 @@ static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
 	lock_buffer(bh);
 	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
-	submit_bh(REQ_OP_WRITE, WRITE_SYNC | REQ_META | REQ_PRIO, bh);
+	submit_bh(REQ_OP_WRITE, REQ_SYNC | REQ_META | REQ_PRIO, bh);
 	wait_on_buffer(bh);
 	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
@@ -88,7 +88,7 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
 	get_bh(*bh);
 	lock_buffer(*bh);
 	(*bh)->b_end_io = end_buffer_read_sync;
-	submit_bh(REQ_OP_READ, READ_SYNC | REQ_META | REQ_PRIO, *bh);
+	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, *bh);
 	wait_on_buffer(*bh);
 	if (!buffer_uptodate(*bh)) {
 		ret = -EIO;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 0094923..e0b3b54 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -340,7 +340,7 @@ void ext4_io_submit(struct ext4_io_submit *io)
 
 	if (bio) {
 		int io_op_flags = io->io_wbc->sync_mode == WB_SYNC_ALL ?
-				  WRITE_SYNC : 0;
+				  REQ_SYNC : 0;
 		bio_set_op_attrs(io->io_bio, REQ_OP_WRITE, io_op_flags);
 		submit_bio(io->io_bio);
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 20da99d..45589c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4554,7 +4554,7 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	unlock_buffer(sbh);
 	if (sync) {
 		error = __sync_dirty_buffer(sbh,
-			test_opt(sb, BARRIER) ? WRITE_FUA : WRITE_SYNC);
+			test_opt(sb, BARRIER) ? REQ_FUA : REQ_SYNC);
 		if (error)
 			return error;
 
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7e9b504..d935c06 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -65,7 +65,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.sbi = sbi,
 		.type = META,
 		.op = REQ_OP_READ,
-		.op_flags = READ_SYNC | REQ_META | REQ_PRIO,
+		.op_flags = REQ_META | REQ_PRIO,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
@@ -160,7 +160,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.sbi = sbi,
 		.type = META,
 		.op = REQ_OP_READ,
-		.op_flags = sync ? (READ_SYNC | REQ_META | REQ_PRIO) : REQ_RAHEAD,
+		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
 	};
 	struct blk_plug plug;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ae194f..b80bf10 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -198,11 +198,9 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 	if (type >= META_FLUSH) {
 		io->fio.type = META_FLUSH;
 		io->fio.op = REQ_OP_WRITE;
-		if (test_opt(sbi, NOBARRIER))
-			io->fio.op_flags = WRITE_FLUSH | REQ_META | REQ_PRIO;
-		else
-			io->fio.op_flags = WRITE_FLUSH_FUA | REQ_META |
-								REQ_PRIO;
+		io->fio.op_flags = REQ_PREFLUSH | REQ_META | REQ_PRIO;
+		if (!test_opt(sbi, NOBARRIER))
+			io->fio.op_flags |= REQ_FUA;
 	}
 	__submit_merged_bio(io);
 out:
@@ -483,7 +481,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index)
 		return page;
 	f2fs_put_page(page, 0);
 
-	page = get_read_data_page(inode, index, READ_SYNC, false);
+	page = get_read_data_page(inode, index, 0, false);
 	if (IS_ERR(page))
 		return page;
 
@@ -509,7 +507,7 @@ struct page *get_lock_data_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 repeat:
-	page = get_read_data_page(inode, index, READ_SYNC, for_write);
+	page = get_read_data_page(inode, index, 0, for_write);
 	if (IS_ERR(page))
 		return page;
 
@@ -1251,7 +1249,7 @@ static int f2fs_write_data_page(struct page *page,
 		.sbi = sbi,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
-		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0,
+		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? REQ_SYNC : 0,
 		.page = page,
 		.encrypted_page = NULL,
 	};
@@ -1663,7 +1661,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			err = PTR_ERR(bio);
 			goto fail;
 		}
-		bio_set_op_attrs(bio, REQ_OP_READ, READ_SYNC);
+		bio->bi_opf = REQ_OP_READ;
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 			bio_put(bio);
 			err = -EFAULT;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6f14ee9..fcca12b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -550,7 +550,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
 		.op = REQ_OP_READ,
-		.op_flags = READ_SYNC,
+		.op_flags = 0,
 		.encrypted_page = NULL,
 	};
 	struct dnode_of_data dn;
@@ -625,7 +625,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
 
 	fio.op = REQ_OP_WRITE;
-	fio.op_flags = WRITE_SYNC;
+	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_mbio(&fio);
 
@@ -663,7 +663,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 			.sbi = F2FS_I_SB(inode),
 			.type = DATA,
 			.op = REQ_OP_WRITE,
-			.op_flags = WRITE_SYNC,
+			.op_flags = REQ_SYNC,
 			.page = page,
 			.encrypted_page = NULL,
 		};
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 5f1a67f..2e7f54c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -111,7 +111,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		.sbi = F2FS_I_SB(dn->inode),
 		.type = DATA,
 		.op = REQ_OP_WRITE,
-		.op_flags = WRITE_SYNC | REQ_PRIO,
+		.op_flags = REQ_SYNC | REQ_PRIO,
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 01177ec..932f3f8b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1134,7 +1134,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	err = read_node_page(page, READ_SYNC);
+	err = read_node_page(page, 0);
 	if (err < 0) {
 		f2fs_put_page(page, 1);
 		return ERR_PTR(err);
@@ -1570,7 +1570,7 @@ static int f2fs_write_node_page(struct page *page,
 		.sbi = sbi,
 		.type = NODE,
 		.op = REQ_OP_WRITE,
-		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0,
+		.op_flags = (wbc->sync_mode == WB_SYNC_ALL) ? REQ_SYNC : 0,
 		.page = page,
 		.encrypted_page = NULL,
 	};
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc886f0..f1b4a17 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -259,7 +259,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.sbi = sbi,
 		.type = DATA,
 		.op = REQ_OP_WRITE,
-		.op_flags = WRITE_SYNC | REQ_PRIO,
+		.op_flags = REQ_SYNC | REQ_PRIO,
 		.encrypted_page = NULL,
 	};
 	bool submit_bio = false;
@@ -420,7 +420,7 @@ static int issue_flush_thread(void *data)
 		fcc->dispatch_list = llist_reverse_order(fcc->dispatch_list);
 
 		bio->bi_bdev = sbi->sb->s_bdev;
-		bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
+		bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 		ret = submit_bio_wait(bio);
 
 		llist_for_each_entry_safe(cmd, next,
@@ -454,7 +454,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 
 		atomic_inc(&fcc->submit_flush);
 		bio->bi_bdev = sbi->sb->s_bdev;
-		bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_FLUSH);
+		bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 		ret = submit_bio_wait(bio);
 		atomic_dec(&fcc->submit_flush);
 		bio_put(bio);
@@ -1515,7 +1515,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		.sbi = sbi,
 		.type = META,
 		.op = REQ_OP_WRITE,
-		.op_flags = WRITE_SYNC | REQ_META | REQ_PRIO,
+		.op_flags = REQ_SYNC | REQ_META | REQ_PRIO,
 		.old_blkaddr = page->index,
 		.new_blkaddr = page->index,
 		.page = page,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6132b4c..2cac6bb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1238,7 +1238,7 @@ static int __f2fs_commit_super(struct buffer_head *bh,
 	unlock_buffer(bh);
 
 	/* it's rare case, we can do fua all the time */
-	return __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
+	return __sync_dirty_buffer(bh, REQ_PREFLUSH | REQ_FUA);
 }
 
 static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e58ccef0..27c00a1 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -657,7 +657,7 @@ static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
 	struct gfs2_log_header *lh;
 	unsigned int tail;
 	u32 hash;
-	int op_flags = WRITE_FLUSH_FUA | REQ_META;
+	int op_flags = REQ_PREFLUSH | REQ_FUA | REQ_META;
 	struct page *page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
 	enum gfs2_freeze_state state = atomic_read(&sdp->sd_freeze_state);
 	lh = page_address(page);
@@ -682,7 +682,7 @@ static void log_write_header(struct gfs2_sbd *sdp, u32 flags)
 	if (test_bit(SDF_NOBARRIERS, &sdp->sd_flags)) {
 		gfs2_ordered_wait(sdp);
 		log_flush_wait(sdp);
-		op_flags = WRITE_SYNC | REQ_META | REQ_PRIO;
+		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
 	}
 
 	sdp->sd_log_idle = (tail == sdp->sd_log_flush_head);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 373639a5..e562b11 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -38,7 +38,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
 	int write_flags = REQ_META | REQ_PRIO |
-		(wbc->sync_mode == WB_SYNC_ALL ? WRITE_SYNC : 0);
+		(wbc->sync_mode == WB_SYNC_ALL ? REQ_SYNC : 0);
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!page_has_buffers(page));
@@ -285,7 +285,7 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		}
 	}
 
-	gfs2_submit_bhs(REQ_OP_READ, READ_SYNC | REQ_META | REQ_PRIO, bhs, num);
+	gfs2_submit_bhs(REQ_OP_READ, REQ_META | REQ_PRIO, bhs, num);
 	if (!(flags & DIO_WAIT))
 		return 0;
 
@@ -453,7 +453,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 	if (buffer_uptodate(first_bh))
 		goto out;
 	if (!buffer_locked(first_bh))
-		ll_rw_block(REQ_OP_READ, READ_SYNC | REQ_META, 1, &first_bh);
+		ll_rw_block(REQ_OP_READ, REQ_META, 1, &first_bh);
 
 	dblock++;
 	extlen--;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index ff72ac6..a34308d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -246,7 +246,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
-	bio_set_op_attrs(bio, REQ_OP_READ, READ_SYNC | REQ_META);
+	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META);
 	submit_bio(bio);
 	wait_on_page_locked(page);
 	bio_put(bio);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 11854dd..67aedf4 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -221,7 +221,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 	error2 = hfsplus_submit_bio(sb,
 				   sbi->part_start + HFSPLUS_VOLHEAD_SECTOR,
 				   sbi->s_vhdr_buf, NULL, REQ_OP_WRITE,
-				   WRITE_SYNC);
+				   REQ_SYNC);
 	if (!error)
 		error = error2;
 	if (!write_backup)
@@ -230,7 +230,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 	error2 = hfsplus_submit_bio(sb,
 				  sbi->part_start + sbi->sect_count - 2,
 				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE,
-				  WRITE_SYNC);
+				  REQ_SYNC);
 	if (!error)
 		error2 = error;
 out:
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 684996c..4055f51 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -186,7 +186,7 @@ __flush_batch(journal_t *journal, int *batch_count)
 
 	blk_start_plug(&plug);
 	for (i = 0; i < *batch_count; i++)
-		write_dirty_buffer(journal->j_chkpt_bhs[i], WRITE_SYNC);
+		write_dirty_buffer(journal->j_chkpt_bhs[i], REQ_SYNC);
 	blk_finish_plug(&plug);
 
 	for (i = 0; i < *batch_count; i++) {
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 31f8ca0..8c51436 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -155,9 +155,10 @@ static int journal_submit_commit_record(journal_t *journal,
 
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_has_feature_async_commit(journal))
-		ret = submit_bh(REQ_OP_WRITE, WRITE_SYNC | WRITE_FLUSH_FUA, bh);
+		ret = submit_bh(REQ_OP_WRITE,
+			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);
 	else
-		ret = submit_bh(REQ_OP_WRITE, WRITE_SYNC, bh);
+		ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
 
 	*cbh = bh;
 	return ret;
@@ -402,7 +403,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
 						journal->j_tail,
-						WRITE_SYNC);
+						REQ_SYNC);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	} else {
 		jbd_debug(3, "superblock not updated\n");
@@ -717,7 +718,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 				clear_buffer_dirty(bh);
 				set_buffer_uptodate(bh);
 				bh->b_end_io = journal_end_buffer_io_sync;
-				submit_bh(REQ_OP_WRITE, WRITE_SYNC, bh);
+				submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
 			}
 			cond_resched();
 			stats.run.rs_blocks_logged += bufs;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 927da49..8ed971e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -913,7 +913,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 	 * space and if we lose sb update during power failure we'd replay
 	 * old transaction with possibly newly overwritten data.
 	 */
-	ret = jbd2_journal_update_sb_log_tail(journal, tid, block, WRITE_FUA);
+	ret = jbd2_journal_update_sb_log_tail(journal, tid, block, REQ_FUA);
 	if (ret)
 		goto out;
 
@@ -1306,7 +1306,7 @@ static int journal_reset(journal_t *journal)
 		/* Lock here to make assertions happy... */
 		mutex_lock(&journal->j_checkpoint_mutex);
 		/*
-		 * Update log tail information. We use WRITE_FUA since new
+		 * Update log tail information. We use REQ_FUA since new
 		 * transaction will start reusing journal space and so we
 		 * must make sure information about current log tail is on
 		 * disk before that.
@@ -1314,7 +1314,7 @@ static int journal_reset(journal_t *journal)
 		jbd2_journal_update_sb_log_tail(journal,
 						journal->j_tail_sequence,
 						journal->j_tail,
-						WRITE_FUA);
+						REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 	return jbd2_journal_start_thread(journal);
@@ -1454,7 +1454,7 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 	sb->s_errno    = cpu_to_be32(journal->j_errno);
 	read_unlock(&journal->j_state_lock);
 
-	jbd2_write_superblock(journal, WRITE_FUA);
+	jbd2_write_superblock(journal, REQ_FUA);
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
@@ -1720,7 +1720,8 @@ int jbd2_journal_destroy(journal_t *journal)
 				++journal->j_transaction_sequence;
 			write_unlock(&journal->j_state_lock);
 
-			jbd2_mark_journal_empty(journal, WRITE_FLUSH_FUA);
+			jbd2_mark_journal_empty(journal,
+					REQ_PREFLUSH | REQ_FUA);
 			mutex_unlock(&journal->j_checkpoint_mutex);
 		} else
 			err = -EIO;
@@ -1979,7 +1980,7 @@ int jbd2_journal_flush(journal_t *journal)
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
-	jbd2_mark_journal_empty(journal, WRITE_FUA);
+	jbd2_mark_journal_empty(journal, REQ_FUA);
 	mutex_unlock(&journal->j_checkpoint_mutex);
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(!journal->j_running_transaction);
@@ -2025,7 +2026,7 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 	if (write) {
 		/* Lock to make assertions happy... */
 		mutex_lock(&journal->j_checkpoint_mutex);
-		jbd2_mark_journal_empty(journal, WRITE_FUA);
+		jbd2_mark_journal_empty(journal, REQ_FUA);
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 91171dc..cfc38b5 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -648,7 +648,7 @@ static void flush_descriptor(journal_t *journal,
 	set_buffer_jwrite(descriptor);
 	BUFFER_TRACE(descriptor, "write");
 	set_buffer_dirty(descriptor);
-	write_dirty_buffer(descriptor, WRITE_SYNC);
+	write_dirty_buffer(descriptor, REQ_SYNC);
 }
 #endif
 
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index a21ea8b..bb1da1f 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2002,7 +2002,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	bio_set_op_attrs(bio, REQ_OP_READ, READ_SYNC);
+	bio->bi_opf = REQ_OP_READ;
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
 		bio->bi_iter.bi_size = 0;
@@ -2146,7 +2146,7 @@ static void lbmStartIO(struct lbuf * bp)
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, WRITE_SYNC);
+	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
diff --git a/fs/mpage.c b/fs/mpage.c
index d2413af..f35e281 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -489,7 +489,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 	int ret = 0;
-	int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?  WRITE_SYNC : 0);
+	int op_flags = (wbc->sync_mode == WB_SYNC_ALL ? REQ_SYNC : 0);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *head = page_buffers(page);
@@ -705,7 +705,7 @@ mpage_writepages(struct address_space *mapping,
 		ret = write_cache_pages(mapping, wbc, __mpage_writepage, &mpd);
 		if (mpd.bio) {
 			int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?
-				  WRITE_SYNC : 0);
+				  REQ_SYNC : 0);
 			mpage_bio_submit(REQ_OP_WRITE, op_flags, mpd.bio);
 		}
 	}
@@ -726,7 +726,7 @@ int mpage_writepage(struct page *page, get_block_t get_block,
 	int ret = __mpage_writepage(page, wbc, &mpd);
 	if (mpd.bio) {
 		int op_flags = (wbc->sync_mode == WB_SYNC_ALL ?
-			  WRITE_SYNC : 0);
+			  REQ_SYNC : 0);
 		mpage_bio_submit(REQ_OP_WRITE, op_flags, mpd.bio);
 	}
 	return ret;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index c95d369..12eeae6 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -189,7 +189,7 @@ static int nilfs_sync_super(struct super_block *sb, int flag)
 	set_buffer_dirty(nilfs->ns_sbh[0]);
 	if (nilfs_test_opt(nilfs, BARRIER)) {
 		err = __sync_dirty_buffer(nilfs->ns_sbh[0],
-					  WRITE_SYNC | WRITE_FLUSH_FUA);
+					  REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
 	} else {
 		err = sync_dirty_buffer(nilfs->ns_sbh[0]);
 	}
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 636abcb..52eef16 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -627,7 +627,7 @@ static int o2hb_issue_node_write(struct o2hb_region *reg,
 	slot = o2nm_this_node();
 
 	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE,
-				 WRITE_SYNC);
+				 REQ_SYNC);
 	if (IS_ERR(bio)) {
 		status = PTR_ERR(bio);
 		mlog_errno(status);
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index bc2dde2..aa40c24 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1111,7 +1111,8 @@ static int flush_commit_list(struct super_block *s,
 		mark_buffer_dirty(jl->j_commit_bh) ;
 		depth = reiserfs_write_unlock_nested(s);
 		if (reiserfs_barrier_flush(s))
-			__sync_dirty_buffer(jl->j_commit_bh, WRITE_FLUSH_FUA);
+			__sync_dirty_buffer(jl->j_commit_bh,
+					REQ_PREFLUSH | REQ_FUA);
 		else
 			sync_dirty_buffer(jl->j_commit_bh);
 		reiserfs_write_lock_nested(s, depth);
@@ -1269,7 +1270,8 @@ static int _update_journal_header_block(struct super_block *sb,
 		depth = reiserfs_write_unlock_nested(sb);
 
 		if (reiserfs_barrier_flush(sb))
-			__sync_dirty_buffer(journal->j_header_bh, WRITE_FLUSH_FUA);
+			__sync_dirty_buffer(journal->j_header_bh,
+					REQ_PREFLUSH | REQ_FUA);
 		else
 			sync_dirty_buffer(journal->j_header_bh);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3e57a56..594e02c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -495,8 +495,10 @@ xfs_submit_ioend(
 
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = xfs_end_bio;
-	bio_set_op_attrs(ioend->io_bio, REQ_OP_WRITE,
-			 (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0);
+	ioend->io_bio->bi_opf = REQ_OP_WRITE;
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		ioend->io_bio->bi_opf |= REQ_SYNC;
+
 	/*
 	 * If we are failing the IO now, just mark the ioend with an
 	 * error and finish it. This will run IO completion immediately
@@ -567,8 +569,9 @@ xfs_chain_bio(
 
 	bio_chain(ioend->io_bio, new);
 	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
-	bio_set_op_attrs(ioend->io_bio, REQ_OP_WRITE,
-			  (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : 0);
+	ioend->io_bio->bi_opf = REQ_OP_WRITE;
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		ioend->io_bio->bi_opf |= REQ_SYNC;
 	submit_bio(ioend->io_bio);
 	ioend->io_bio = new;
 }
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index b5b9bff..33c435f 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1304,7 +1304,7 @@ _xfs_buf_ioapply(
 	if (bp->b_flags & XBF_WRITE) {
 		op = REQ_OP_WRITE;
 		if (bp->b_flags & XBF_SYNCIO)
-			op_flags = WRITE_SYNC;
+			op_flags = REQ_SYNC;
 		if (bp->b_flags & XBF_FUA)
 			op_flags |= REQ_FUA;
 		if (bp->b_flags & XBF_FLUSH)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 46a7420..7a1b78a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -151,58 +151,11 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  */
 #define CHECK_IOVEC_ONLY -1
 
-/*
- * The below are the various read and write flags that we support. Some of
- * them include behavioral modifiers that send information down to the
- * block layer and IO scheduler. They should be used along with a req_op.
- * Terminology:
- *
- *	The block layer uses device plugging to defer IO a little bit, in
- *	the hope that we will see more IO very shortly. This increases
- *	coalescing of adjacent IO and thus reduces the number of IOs we
- *	have to send to the device. It also allows for better queuing,
- *	if the IO isn't mergeable. If the caller is going to be waiting
- *	for the IO, then he must ensure that the device is unplugged so
- *	that the IO is dispatched to the driver.
- *
- *	All IO is handled async in Linux. This is fine for background
- *	writes, but for reads or writes that someone waits for completion
- *	on, we want to notify the block layer and IO scheduler so that they
- *	know about it. That allows them to make better scheduling
- *	decisions. So when the below references 'sync' and 'async', it
- *	is referencing this priority hint.
- *
- * With that in mind, the available types are:
- *
- * READ			A normal read operation. Device will be plugged.
- * READ_SYNC		A synchronous read. Device is not plugged, caller can
- *			immediately wait on this read without caring about
- *			unplugging.
- * WRITE		A normal async write. Device will be plugged.
- * WRITE_SYNC		Synchronous write. Identical to WRITE, but passes down
- *			the hint that someone will be waiting on this IO
- *			shortly. The write equivalent of READ_SYNC.
- * WRITE_ODIRECT	Special case write for O_DIRECT only.
- * WRITE_FLUSH		Like WRITE_SYNC but with preceding cache flush.
- * WRITE_FUA		Like WRITE_SYNC but data is guaranteed to be on
- *			non-volatile media on completion.
- * WRITE_FLUSH_FUA	Combination of WRITE_FLUSH and FUA. The IO is preceded
- *			by a cache flush and data is guaranteed to be on
- *			non-volatile media on completion.
- *
- */
 #define RW_MASK			REQ_OP_WRITE
 
 #define READ			REQ_OP_READ
 #define WRITE			REQ_OP_WRITE
 
-#define READ_SYNC		0
-#define WRITE_SYNC		REQ_SYNC
-#define WRITE_ODIRECT		(REQ_SYNC | REQ_IDLE)
-#define WRITE_FLUSH		REQ_PREFLUSH
-#define WRITE_FUA		REQ_FUA
-#define WRITE_FLUSH_FUA		(REQ_PREFLUSH | REQ_FUA)
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index a9d3442..5da2c82 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -55,7 +55,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
 
-#define F2FS_BIO_FLAG_MASK(t)	(t & (REQ_RAHEAD | WRITE_FLUSH_FUA))
+#define F2FS_BIO_FLAG_MASK(t)	(t & (REQ_RAHEAD | REQ_PREFLUSH | REQ_FUA))
 #define F2FS_BIO_EXTRA_MASK(t)	(t & (REQ_META | REQ_PRIO))
 
 #define show_bio_type(op_flags)	show_bio_op_flags(op_flags), 		\
@@ -65,11 +65,9 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 	__print_symbolic(F2FS_BIO_FLAG_MASK(flags),			\
 		{ 0,			"WRITE" },			\
 		{ REQ_RAHEAD, 		"READAHEAD" },			\
-		{ READ_SYNC, 		"READ_SYNC" },			\
-		{ WRITE_SYNC, 		"WRITE_SYNC" },			\
-		{ WRITE_FLUSH,		"WRITE_FLUSH" },		\
-		{ WRITE_FUA, 		"WRITE_FUA" },			\
-		{ WRITE_FLUSH_FUA,	"WRITE_FLUSH_FUA" })
+		{ REQ_SYNC, 		"REQ_SYNC" },			\
+		{ REQ_PREFLUSH,		"REQ_PREFLUSH" },		\
+		{ REQ_FUA,		"REQ_FUA" })
 
 #define show_bio_extra(type)						\
 	__print_symbolic(F2FS_BIO_EXTRA_MASK(type),			\
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index a3b1e61..32e0c23 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -307,7 +307,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 {
 	int error;
 
-	hib_submit_io(REQ_OP_READ, READ_SYNC, swsusp_resume_block,
+	hib_submit_io(REQ_OP_READ, 0, swsusp_resume_block,
 		      swsusp_header, NULL);
 	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
 	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
@@ -317,7 +317,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
-		error = hib_submit_io(REQ_OP_WRITE, WRITE_SYNC,
+		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
 				      swsusp_resume_block, swsusp_header, NULL);
 	} else {
 		printk(KERN_ERR "PM: Swap header not found!\n");
@@ -397,7 +397,7 @@ static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
 	} else {
 		src = buf;
 	}
-	return hib_submit_io(REQ_OP_WRITE, WRITE_SYNC, offset, src, hb);
+	return hib_submit_io(REQ_OP_WRITE, REQ_SYNC, offset, src, hb);
 }
 
 static void release_swap_writer(struct swap_map_handle *handle)
@@ -1000,8 +1000,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
 			return -ENOMEM;
 		}
 
-		error = hib_submit_io(REQ_OP_READ, READ_SYNC, offset,
-				      tmp->map, NULL);
+		error = hib_submit_io(REQ_OP_READ, 0, offset, tmp->map, NULL);
 		if (error) {
 			release_swap_reader(handle);
 			return error;
@@ -1025,7 +1024,7 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
 	offset = handle->cur->entries[handle->k];
 	if (!offset)
 		return -EFAULT;
-	error = hib_submit_io(REQ_OP_READ, READ_SYNC, offset, buf, hb);
+	error = hib_submit_io(REQ_OP_READ, 0, offset, buf, hb);
 	if (error)
 		return error;
 	if (++handle->k >= MAP_PAGE_ENTRIES) {
@@ -1534,7 +1533,7 @@ int swsusp_check(void)
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
-		error = hib_submit_io(REQ_OP_READ, READ_SYNC,
+		error = hib_submit_io(REQ_OP_READ, 0,
 					swsusp_resume_block,
 					swsusp_header, NULL);
 		if (error)
@@ -1543,7 +1542,7 @@ int swsusp_check(void)
 		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			/* Reset swap signature now */
-			error = hib_submit_io(REQ_OP_WRITE, WRITE_SYNC,
+			error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
 						swsusp_resume_block,
 						swsusp_header, NULL);
 		} else {
@@ -1588,11 +1587,11 @@ int swsusp_unmark(void)
 {
 	int error;
 
-	hib_submit_io(REQ_OP_READ, READ_SYNC, swsusp_resume_block,
+	hib_submit_io(REQ_OP_READ, 0, swsusp_resume_block,
 		      swsusp_header, NULL);
 	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
-		error = hib_submit_io(REQ_OP_WRITE, WRITE_SYNC,
+		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
 					swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
-- 
2.1.4


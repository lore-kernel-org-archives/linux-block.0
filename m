Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: get rid of bio_rw and READA
Date: Tue, 19 Jul 2016 11:28:41 +0200
Message-Id: <1468920523-3189-2-git-send-email-hch@lst.de>
In-Reply-To: <1468920523-3189-1-git-send-email-hch@lst.de>
References: <1468920523-3189-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

These two are confusing leftover of the old world order, combining
values of the REQ_OP_ and REQ_ namespaces.  For callers that don't
special case we mostly just replace bi_rw with bio_data_dir or
op_is_write, except for the few cases where a switch over the REQ_OP_
values makes more sense.  Any check for READA is replaced with an
explicit check for REQ_RAHEAD.  Also remove the READA alias for
REQ_RAHEAD.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/brd.c                         |  4 +---
 drivers/block/drbd/drbd_req.c               | 34 ++++++++++++++++-------------
 drivers/block/drbd/drbd_worker.c            | 30 +++++++++++++++----------
 drivers/block/null_blk.c                    |  2 +-
 drivers/block/umem.c                        |  6 ++---
 drivers/lightnvm/rrpc.c                     |  4 ++--
 drivers/md/dm-raid1.c                       |  8 +++----
 drivers/md/dm-snap.c                        | 13 ++++++-----
 drivers/md/dm-zero.c                        | 15 ++++++++-----
 drivers/md/dm.c                             |  2 +-
 drivers/md/raid1.c                          |  2 +-
 drivers/md/raid5.c                          |  2 +-
 drivers/nvme/host/lightnvm.c                |  2 +-
 drivers/staging/lustre/lustre/llite/lloop.c | 13 ++++++-----
 fs/buffer.c                                 | 12 +++++-----
 fs/f2fs/checkpoint.c                        |  2 +-
 fs/f2fs/gc.c                                |  3 ++-
 fs/f2fs/node.c                              |  2 +-
 fs/gfs2/bmap.c                              |  3 ++-
 fs/gfs2/dir.c                               |  2 +-
 fs/gfs2/meta_io.c                           |  2 +-
 fs/reiserfs/stree.c                         |  2 +-
 fs/udf/dir.c                                |  2 +-
 fs/udf/directory.c                          |  2 +-
 include/linux/fs.h                          | 18 +--------------
 include/trace/events/f2fs.h                 |  4 ++--
 26 files changed, 95 insertions(+), 96 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index f5b0d6f..41a6c4c 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -347,9 +347,7 @@ static blk_qc_t brd_make_request(struct request_queue *q, struct bio *bio)
 		goto out;
 	}
 
-	rw = bio_rw(bio);
-	if (rw == READA)
-		rw = READ;
+	rw = bio_data_dir(bio);
 
 	bio_for_each_segment(bvec, bio, iter) {
 		unsigned int len = bvec.bv_len;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 787536a..66b8e4b 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -219,7 +219,6 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 {
 	const unsigned s = req->rq_state;
 	struct drbd_device *device = req->device;
-	int rw;
 	int error, ok;
 
 	/* we must not complete the master bio, while it is
@@ -243,8 +242,6 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 		return;
 	}
 
-	rw = bio_rw(req->master_bio);
-
 	/*
 	 * figure out whether to report success or failure.
 	 *
@@ -268,7 +265,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 	 * epoch number.  If they match, increase the current_tle_nr,
 	 * and reset the transfer log epoch write_cnt.
 	 */
-	if (rw == WRITE &&
+	if (op_is_write(bio_op(req->master_bio)) &&
 	    req->epoch == atomic_read(&first_peer_device(device)->connection->current_tle_nr))
 		start_new_tl_epoch(first_peer_device(device)->connection);
 
@@ -285,11 +282,14 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 	 * because no path was available, in which case
 	 * it was not even added to the transfer_log.
 	 *
-	 * READA may fail, and will not be retried.
+	 * read-ahead may fail, and will not be retried.
 	 *
 	 * WRITE should have used all available paths already.
 	 */
-	if (!ok && rw == READ && !list_empty(&req->tl_requests))
+	if (!ok &&
+	    bio_op(req->master_bio) == REQ_OP_READ &&
+	    !(req->master_bio->bi_rw & REQ_RAHEAD) &&
+	    !list_empty(&req->tl_requests))
 		req->rq_state |= RQ_POSTPONED;
 
 	if (!(req->rq_state & RQ_POSTPONED)) {
@@ -645,7 +645,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		/* fall through. */
 	case READ_AHEAD_COMPLETED_WITH_ERROR:
-		/* it is legal to fail READA, no __drbd_chk_io_error in that case. */
+		/* it is legal to fail read-ahead, no __drbd_chk_io_error in that case. */
 		mod_rq_state(req, m, RQ_LOCAL_PENDING, RQ_LOCAL_COMPLETED);
 		break;
 
@@ -657,7 +657,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		break;
 
 	case QUEUE_FOR_NET_READ:
-		/* READ or READA, and
+		/* READ, and
 		 * no local disk,
 		 * or target area marked as invalid,
 		 * or just got an io-error. */
@@ -1172,7 +1172,14 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 {
 	struct drbd_device *device = req->device;
 	struct bio *bio = req->private_bio;
-	const int rw = bio_rw(bio);
+	unsigned int type;
+
+	if (bio_op(bio) != REQ_OP_READ)
+		type = DRBD_FAULT_DT_WR;
+	else if (bio->bi_rw & REQ_RAHEAD)
+		type = DRBD_FAULT_DT_RA;
+	else
+		type = DRBD_FAULT_DT_RD;
 
 	bio->bi_bdev = device->ldev->backing_bdev;
 
@@ -1182,10 +1189,7 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 	 * stable storage, and this is a WRITE, we may not even submit
 	 * this bio. */
 	if (get_ldev(device)) {
-		if (drbd_insert_fault(device,
-				      rw == WRITE ? DRBD_FAULT_DT_WR
-				    : rw == READ  ? DRBD_FAULT_DT_RD
-				    :               DRBD_FAULT_DT_RA))
+		if (drbd_insert_fault(device, type))
 			bio_io_error(bio);
 		else if (bio_op(bio) == REQ_OP_DISCARD)
 			drbd_process_discard_req(req);
@@ -1278,7 +1282,7 @@ static bool may_do_writes(struct drbd_device *device)
 static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request *req)
 {
 	struct drbd_resource *resource = device->resource;
-	const int rw = bio_rw(req->master_bio);
+	const int rw = bio_data_dir(req->master_bio);
 	struct bio_and_error m = { NULL, };
 	bool no_remote = false;
 	bool submit_private_bio = false;
@@ -1308,7 +1312,7 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
 		goto out;
 	}
 
-	/* We fail READ/READA early, if we can not serve it.
+	/* We fail READ early, if we can not serve it.
 	 * We must do this before req is registered on any lists.
 	 * Otherwise, drbd_req_complete() will queue failed READ for retry. */
 	if (rw != WRITE) {
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index b3fa557..35dbb3d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -248,18 +248,26 @@ void drbd_request_endio(struct bio *bio)
 
 	/* to avoid recursion in __req_mod */
 	if (unlikely(bio->bi_error)) {
-		if (bio_op(bio) == REQ_OP_DISCARD)
-			what = (bio->bi_error == -EOPNOTSUPP)
-				? DISCARD_COMPLETED_NOTSUPP
-				: DISCARD_COMPLETED_WITH_ERROR;
-		else
-			what = (bio_data_dir(bio) == WRITE)
-			? WRITE_COMPLETED_WITH_ERROR
-			: (bio_rw(bio) == READ)
-			  ? READ_COMPLETED_WITH_ERROR
-			  : READ_AHEAD_COMPLETED_WITH_ERROR;
-	} else
+		switch (bio_op(bio)) {
+		case REQ_OP_DISCARD:
+			if (bio->bi_error == -EOPNOTSUPP)
+				what = DISCARD_COMPLETED_NOTSUPP;
+			else
+				what = DISCARD_COMPLETED_WITH_ERROR;
+			break;
+		case REQ_OP_READ:
+			if (bio->bi_rw & REQ_RAHEAD)
+				what = READ_AHEAD_COMPLETED_WITH_ERROR;
+			else
+				what = READ_COMPLETED_WITH_ERROR;
+			break;
+		default:
+			what = WRITE_COMPLETED_WITH_ERROR;
+			break;
+		}
+	} else {
 		what = COMPLETED_OK;
+	}
 
 	bio_put(req->private_bio);
 	req->private_bio = ERR_PTR(bio->bi_error);
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index cab9759..75a7f88 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -448,7 +448,7 @@ static int null_lnvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	struct request *rq;
 	struct bio *bio = rqd->bio;
 
-	rq = blk_mq_alloc_request(q, bio_rw(bio), 0);
+	rq = blk_mq_alloc_request(q, bio_data_dir(bio), 0);
 	if (IS_ERR(rq))
 		return -ENOMEM;
 
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 4b3ba74..d0a3e6d 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -344,7 +344,6 @@ static int add_bio(struct cardinfo *card)
 	int offset;
 	struct bio *bio;
 	struct bio_vec vec;
-	int rw;
 
 	bio = card->currentbio;
 	if (!bio && card->bio) {
@@ -359,7 +358,6 @@ static int add_bio(struct cardinfo *card)
 	if (!bio)
 		return 0;
 
-	rw = bio_rw(bio);
 	if (card->mm_pages[card->Ready].cnt >= DESC_PER_PAGE)
 		return 0;
 
@@ -369,7 +367,7 @@ static int add_bio(struct cardinfo *card)
 				  vec.bv_page,
 				  vec.bv_offset,
 				  vec.bv_len,
-				  (rw == READ) ?
+				  bio_op(bio) == REQ_OP_READ ?
 				  PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
 
 	p = &card->mm_pages[card->Ready];
@@ -398,7 +396,7 @@ static int add_bio(struct cardinfo *card)
 					 DMASCR_CHAIN_EN |
 					 DMASCR_SEM_EN |
 					 pci_cmds);
-	if (rw == WRITE)
+	if (bio_op(bio) == REQ_OP_WRITE)
 		desc->control_bits |= cpu_to_le32(DMASCR_TRANSFER_READ);
 	desc->sem_control_bits = desc->control_bits;
 
diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index fa1ab04..37fcaad 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -853,14 +853,14 @@ static int rrpc_setup_rq(struct rrpc *rrpc, struct bio *bio,
 			return NVM_IO_ERR;
 		}
 
-		if (bio_rw(bio) == WRITE)
+		if (bio_op(bio) == REQ_OP_WRITE)
 			return rrpc_write_ppalist_rq(rrpc, bio, rqd, flags,
 									npages);
 
 		return rrpc_read_ppalist_rq(rrpc, bio, rqd, flags, npages);
 	}
 
-	if (bio_rw(bio) == WRITE)
+	if (bio_op(bio) == REQ_OP_WRITE)
 		return rrpc_write_rq(rrpc, bio, rqd, flags);
 
 	return rrpc_read_rq(rrpc, bio, rqd, flags);
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 9f5f460..dac55b2 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -528,7 +528,7 @@ static void read_callback(unsigned long error, void *context)
 		DMWARN_LIMIT("Read failure on mirror device %s.  "
 			     "Trying alternative device.",
 			     m->dev->name);
-		queue_bio(m->ms, bio, bio_rw(bio));
+		queue_bio(m->ms, bio, bio_data_dir(bio));
 		return;
 	}
 
@@ -1193,7 +1193,7 @@ static void mirror_dtr(struct dm_target *ti)
  */
 static int mirror_map(struct dm_target *ti, struct bio *bio)
 {
-	int r, rw = bio_rw(bio);
+	int r, rw = bio_data_dir(bio);
 	struct mirror *m;
 	struct mirror_set *ms = ti->private;
 	struct dm_dirty_log *log = dm_rh_dirty_log(ms->rh);
@@ -1217,7 +1217,7 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
 	 * If region is not in-sync queue the bio.
 	 */
 	if (!r || (r == -EWOULDBLOCK)) {
-		if (rw == READA)
+		if (bio->bi_rw & REQ_RAHEAD)
 			return -EWOULDBLOCK;
 
 		queue_bio(ms, bio, rw);
@@ -1242,7 +1242,7 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
 
 static int mirror_end_io(struct dm_target *ti, struct bio *bio, int error)
 {
-	int rw = bio_rw(bio);
+	int rw = bio_data_dir(bio);
 	struct mirror_set *ms = (struct mirror_set *) ti->private;
 	struct mirror *m = NULL;
 	struct dm_bio_details *bd = NULL;
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 69ab1ff..cc2f14b 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1696,7 +1696,8 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 	 * to copy an exception */
 	down_write(&s->lock);
 
-	if (!s->valid || (unlikely(s->snapshot_overflowed) && bio_rw(bio) == WRITE)) {
+	if (!s->valid || (unlikely(s->snapshot_overflowed) &&
+	    bio_data_dir(bio) == WRITE)) {
 		r = -EIO;
 		goto out_unlock;
 	}
@@ -1713,7 +1714,7 @@ static int snapshot_map(struct dm_target *ti, struct bio *bio)
 	 * flags so we should only get this if we are
 	 * writeable.
 	 */
-	if (bio_rw(bio) == WRITE) {
+	if (bio_data_dir(bio) == WRITE) {
 		pe = __lookup_pending_exception(s, chunk);
 		if (!pe) {
 			up_write(&s->lock);
@@ -1819,7 +1820,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 	e = dm_lookup_exception(&s->complete, chunk);
 	if (e) {
 		/* Queue writes overlapping with chunks being merged */
-		if (bio_rw(bio) == WRITE &&
+		if (bio_data_dir(bio) == WRITE &&
 		    chunk >= s->first_merging_chunk &&
 		    chunk < (s->first_merging_chunk +
 			     s->num_merging_chunks)) {
@@ -1831,7 +1832,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 
 		remap_exception(s, e, bio, chunk);
 
-		if (bio_rw(bio) == WRITE)
+		if (bio_data_dir(bio) == WRITE)
 			track_chunk(s, bio, chunk);
 		goto out_unlock;
 	}
@@ -1839,7 +1840,7 @@ static int snapshot_merge_map(struct dm_target *ti, struct bio *bio)
 redirect_to_origin:
 	bio->bi_bdev = s->origin->bdev;
 
-	if (bio_rw(bio) == WRITE) {
+	if (bio_data_dir(bio) == WRITE) {
 		up_write(&s->lock);
 		return do_origin(s->origin, bio);
 	}
@@ -2288,7 +2289,7 @@ static int origin_map(struct dm_target *ti, struct bio *bio)
 	if (unlikely(bio->bi_rw & REQ_PREFLUSH))
 		return DM_MAPIO_REMAPPED;
 
-	if (bio_rw(bio) != WRITE)
+	if (bio_data_dir(bio) != WRITE)
 		return DM_MAPIO_REMAPPED;
 
 	available_sectors = o->split_boundary -
diff --git a/drivers/md/dm-zero.c b/drivers/md/dm-zero.c
index 766bc93..618b875 100644
--- a/drivers/md/dm-zero.c
+++ b/drivers/md/dm-zero.c
@@ -35,16 +35,19 @@ static int zero_ctr(struct dm_target *ti, unsigned int argc, char **argv)
  */
 static int zero_map(struct dm_target *ti, struct bio *bio)
 {
-	switch(bio_rw(bio)) {
-	case READ:
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+		if (bio->bi_rw & REQ_RAHEAD) {
+			/* readahead of null bytes only wastes buffer cache */
+			return -EIO;
+		}
 		zero_fill_bio(bio);
 		break;
-	case READA:
-		/* readahead of null bytes only wastes buffer cache */
-		return -EIO;
-	case WRITE:
+	case REQ_OP_WRITE:
 		/* writes get silently dropped */
 		break;
+	default:
+		return -EIO;
 	}
 
 	bio_endio(bio);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index aba7ed9..812fd59 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1833,7 +1833,7 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
 		dm_put_live_table(md, srcu_idx);
 
-		if (bio_rw(bio) != READA)
+		if (!(bio->bi_rw & REQ_RAHEAD))
 			queue_io(md, bio);
 		else
 			bio_io_error(bio);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 41d9c31..4e6da44 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1105,7 +1105,7 @@ static void raid1_make_request(struct mddev *mddev, struct bio * bio)
 	bitmap = mddev->bitmap;
 
 	/*
-	 * make_request() can abort the operation when READA is being
+	 * make_request() can abort the operation when read-ahead is being
 	 * used and no empty request is available.
 	 *
 	 */
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7aacf5b..6953d78 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5233,7 +5233,7 @@ static void raid5_make_request(struct mddev *mddev, struct bio * bi)
 			(unsigned long long)logical_sector);
 
 		sh = raid5_get_active_stripe(conf, new_sector, previous,
-				       (bi->bi_rw&RWA_MASK), 0);
+				       (bi->bi_rw & REQ_RAHEAD), 0);
 		if (sh) {
 			if (unlikely(previous)) {
 				/* expansion might have moved on while waiting for a
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 97fe610..63f483d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -500,7 +500,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	struct bio *bio = rqd->bio;
 	struct nvme_nvm_command *cmd;
 
-	rq = blk_mq_alloc_request(q, bio_rw(bio), 0);
+	rq = blk_mq_alloc_request(q, bio_data_dir(bio), 0);
 	if (IS_ERR(rq))
 		return -ENOMEM;
 
diff --git a/drivers/staging/lustre/lustre/llite/lloop.c b/drivers/staging/lustre/lustre/llite/lloop.c
index b677930..56ae8ac3 100644
--- a/drivers/staging/lustre/lustre/llite/lloop.c
+++ b/drivers/staging/lustre/lustre/llite/lloop.c
@@ -336,7 +336,6 @@ static unsigned int loop_get_bio(struct lloop_device *lo, struct bio **req)
 static blk_qc_t loop_make_request(struct request_queue *q, struct bio *old_bio)
 {
 	struct lloop_device *lo = q->queuedata;
-	int rw = bio_rw(old_bio);
 	int inactive;
 
 	blk_queue_split(q, &old_bio, q->bio_split);
@@ -354,13 +353,15 @@ static blk_qc_t loop_make_request(struct request_queue *q, struct bio *old_bio)
 	if (inactive)
 		goto err;
 
-	if (rw == WRITE) {
+	switch (bio_op(old_bio)) {
+	case REQ_OP_WRITE:
 		if (lo->lo_flags & LO_FLAGS_READ_ONLY)
 			goto err;
-	} else if (rw == READA) {
-		rw = READ;
-	} else if (rw != READ) {
-		CERROR("lloop: unknown command (%x)\n", rw);
+		break;
+	case REQ_OP_READ:
+		break;
+	default:
+		CERROR("lloop: unknown command (%x)\n", bio_op(old_bio));
 		goto err;
 	}
 	loop_add_bio(lo, old_bio);
diff --git a/fs/buffer.c b/fs/buffer.c
index 373aacb..c24201e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -153,7 +153,7 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
-		/* This happens, due to failed READA attempts. */
+		/* This happens, due to failed read-ahead attempts. */
 		clear_buffer_uptodate(bh);
 	}
 	unlock_buffer(bh);
@@ -1395,7 +1395,7 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 {
 	struct buffer_head *bh = __getblk(bdev, block, size);
 	if (likely(bh)) {
-		ll_rw_block(REQ_OP_READ, READA, 1, &bh);
+		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, &bh);
 		brelse(bh);
 	}
 }
@@ -3052,14 +3052,14 @@ EXPORT_SYMBOL(submit_bh);
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
  * @op: whether to %READ or %WRITE
- * @op_flags: rq_flag_bits or %READA (readahead)
+ * @op_flags: rq_flag_bits
  * @nr: number of &struct buffer_heads in the array
  * @bhs: array of pointers to &struct buffer_head
  *
  * ll_rw_block() takes an array of pointers to &struct buffer_heads, and
- * requests an I/O operation on them, either a %READ or a %WRITE.  The third
- * %READA option is described in the documentation for generic_make_request()
- * which ll_rw_block() calls.
+ * requests an I/O operation on them, either a %REQ_OP_READ or a %REQ_OP_WRITE.
+ * @op_flags contains flags modifying the detailed I/O behavior, most notably
+ * %REQ_RAHEAD.
  *
  * This function drops any buffer that it cannot get a lock on (with the
  * BH_Lock state bit), any buffer that appears to be clean when doing a write
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b6d600e..124b4a3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -159,7 +159,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.sbi = sbi,
 		.type = META,
 		.op = REQ_OP_READ,
-		.op_flags = sync ? (READ_SYNC | REQ_META | REQ_PRIO) : READA,
+		.op_flags = sync ? (READ_SYNC | REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
 	};
 	struct blk_plug plug;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3649d86..f06ed73 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -733,7 +733,8 @@ next_step:
 
 			start_bidx = start_bidx_of_node(nofs, inode);
 			data_page = get_read_data_page(inode,
-					start_bidx + ofs_in_node, READA, true);
+					start_bidx + ofs_in_node, REQ_RAHEAD,
+					true);
 			if (IS_ERR(data_page)) {
 				iput(inode);
 				continue;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e534039..d186769 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1119,7 +1119,7 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	if (!apage)
 		return;
 
-	err = read_node_page(apage, READA);
+	err = read_node_page(apage, REQ_RAHEAD);
 	f2fs_put_page(apage, err ? 1 : 0);
 }
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index fd6389c..6e2bec1 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -285,7 +285,8 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl,
 		if (trylock_buffer(rabh)) {
 			if (!buffer_uptodate(rabh)) {
 				rabh->b_end_io = end_buffer_read_sync;
-				submit_bh(REQ_OP_READ, READA | REQ_META, rabh);
+				submit_bh(REQ_OP_READ, REQ_RAHEAD | REQ_META,
+						rabh);
 				continue;
 			}
 			unlock_buffer(rabh);
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0fbb426..f077cf5 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1513,7 +1513,7 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 				continue;
 			}
 			bh->b_end_io = end_buffer_read_sync;
-			submit_bh(REQ_OP_READ, READA | REQ_META, bh);
+			submit_bh(REQ_OP_READ, REQ_RAHEAD | REQ_META, bh);
 			continue;
 		}
 		brelse(bh);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 052c113..950b8be 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -459,7 +459,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 		bh = gfs2_getbuf(gl, dblock, CREATE);
 
 		if (!buffer_uptodate(bh) && !buffer_locked(bh))
-			ll_rw_block(REQ_OP_READ, READA | REQ_META, 1, &bh);
+			ll_rw_block(REQ_OP_READ, REQ_RAHEAD | REQ_META, 1, &bh);
 		brelse(bh);
 		dblock++;
 		extlen--;
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 64b29b5..4032d1e 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -551,7 +551,7 @@ static int search_by_key_reada(struct super_block *s,
 		if (!buffer_uptodate(bh[j])) {
 			if (depth == -1)
 				depth = reiserfs_write_unlock_nested(s);
-			ll_rw_block(REQ_OP_READ, READA, 1, bh + j);
+			ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, bh + j);
 		}
 		brelse(bh[j]);
 	}
diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 80c8a21..aaec13c 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -113,7 +113,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 					brelse(tmp);
 			}
 			if (num) {
-				ll_rw_block(REQ_OP_READ, READA, num, bha);
+				ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
 				for (i = 0; i < num; i++)
 					brelse(bha[i]);
 			}
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 71f3e0b..988d535 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -87,7 +87,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 					brelse(tmp);
 			}
 			if (num) {
-				ll_rw_block(REQ_OP_READ, READA, num, bha);
+				ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
 				for (i = 0; i < num; i++)
 					brelse(bha[i]);
 			}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1830245..dc48866 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -178,9 +178,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  * READ_SYNC		A synchronous read. Device is not plugged, caller can
  *			immediately wait on this read without caring about
  *			unplugging.
- * READA		Used for read-ahead operations. Lower priority, and the
- *			block layer could (in theory) choose to ignore this
- *			request if it runs into resource problems.
  * WRITE		A normal async write. Device will be plugged.
  * WRITE_SYNC		Synchronous write. Identical to WRITE, but passes down
  *			the hint that someone will be waiting on this IO
@@ -195,11 +192,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  *
  */
 #define RW_MASK			REQ_OP_WRITE
-#define RWA_MASK		REQ_RAHEAD
 
 #define READ			REQ_OP_READ
-#define WRITE			RW_MASK
-#define READA			RWA_MASK
+#define WRITE			REQ_OP_WRITE
 
 #define READ_SYNC		REQ_SYNC
 #define WRITE_SYNC		(REQ_SYNC | REQ_NOIDLE)
@@ -2471,17 +2466,6 @@ static inline bool op_is_write(unsigned int op)
 }
 
 /*
- * return READ, READA, or WRITE
- */
-static inline int bio_rw(struct bio *bio)
-{
-	if (op_is_write(bio_op(bio)))
-		return WRITE;
-
-	return bio->bi_rw & RWA_MASK;
-}
-
-/*
  * return data direction, READ or WRITE
  */
 static inline int bio_data_dir(struct bio *bio)
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 878963a..ff95fd0 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -55,7 +55,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ IPU,		"IN-PLACE" },				\
 		{ OPU,		"OUT-OF-PLACE" })
 
-#define F2FS_BIO_FLAG_MASK(t)	(t & (READA | WRITE_FLUSH_FUA))
+#define F2FS_BIO_FLAG_MASK(t)	(t & (REQ_RAHEAD | WRITE_FLUSH_FUA))
 #define F2FS_BIO_EXTRA_MASK(t)	(t & (REQ_META | REQ_PRIO))
 
 #define show_bio_type(op, op_flags) show_bio_op(op),			\
@@ -68,7 +68,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 
 #define show_bio_op_flags(flags)					\
 	__print_symbolic(F2FS_BIO_FLAG_MASK(flags),			\
-		{ READA, 		"READAHEAD" },			\
+		{ REQ_RAHEAD, 		"READAHEAD" },			\
 		{ READ_SYNC, 		"READ_SYNC" },			\
 		{ WRITE_SYNC, 		"WRITE_SYNC" },			\
 		{ WRITE_FLUSH,		"WRITE_FLUSH" },		\
-- 
2.1.4

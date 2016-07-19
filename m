Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/7] scsi/osd: open code blk_make_request
Date: Tue, 19 Jul 2016 11:31:53 +0200
Message-Id: <1468920714-4304-7-git-send-email-hch@lst.de>
In-Reply-To: <1468920714-4304-1-git-send-email-hch@lst.de>
References: <1468920714-4304-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

I wish the OSD code could simply use blk_rq_map_* helpers like
everyone else, but the complex nature of deciding if we have
DATA IN and/or DATA OUT buffers might make this impossible
(at least for a mere human like me).

But using blk_rq_append_bio at least allows sharing the setup code
between request with or without dat a buffers, and given that this
is the last user of blk_make_request it allows getting rid of that
somewhat awkward interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Boaz Harrosh <ooo@electrozaur.com>
---
 block/blk-core.c                 | 57 ----------------------------------------
 drivers/scsi/osd/osd_initiator.c | 25 +++++++++++-------
 include/linux/blkdev.h           |  2 --
 3 files changed, 16 insertions(+), 68 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0e8b00f..a687e9c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1318,63 +1318,6 @@ struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
 EXPORT_SYMBOL(blk_get_request);
 
 /**
- * blk_make_request - given a bio, allocate a corresponding struct request.
- * @q: target request queue
- * @bio:  The bio describing the memory mappings that will be submitted for IO.
- *        It may be a chained-bio properly constructed by block/bio layer.
- * @gfp_mask: gfp flags to be used for memory allocation
- *
- * blk_make_request is the parallel of generic_make_request for BLOCK_PC
- * type commands. Where the struct request needs to be farther initialized by
- * the caller. It is passed a &struct bio, which describes the memory info of
- * the I/O transfer.
- *
- * The caller of blk_make_request must make sure that bi_io_vec
- * are set to describe the memory buffers. That bio_data_dir() will return
- * the needed direction of the request. (And all bio's in the passed bio-chain
- * are properly set accordingly)
- *
- * If called under none-sleepable conditions, mapped bio buffers must not
- * need bouncing, by calling the appropriate masked or flagged allocator,
- * suitable for the target device. Otherwise the call to blk_queue_bounce will
- * BUG.
- *
- * WARNING: When allocating/cloning a bio-chain, careful consideration should be
- * given to how you allocate bios. In particular, you cannot use
- * __GFP_DIRECT_RECLAIM for anything but the first bio in the chain. Otherwise
- * you risk waiting for IO completion of a bio that hasn't been submitted yet,
- * thus resulting in a deadlock. Alternatively bios should be allocated using
- * bio_kmalloc() instead of bio_alloc(), as that avoids the mempool deadlock.
- * If possible a big IO should be split into smaller parts when allocation
- * fails. Partial allocation should not be an error, or you risk a live-lock.
- */
-struct request *blk_make_request(struct request_queue *q, struct bio *bio,
-				 gfp_t gfp_mask)
-{
-	struct request *rq = blk_get_request(q, bio_data_dir(bio), gfp_mask);
-
-	if (IS_ERR(rq))
-		return rq;
-
-	blk_rq_set_block_pc(rq);
-
-	for_each_bio(bio) {
-		struct bio *bounce_bio = bio;
-		int ret;
-
-		blk_queue_bounce(q, &bounce_bio);
-		ret = blk_rq_append_bio(rq, bounce_bio);
-		if (unlikely(ret)) {
-			blk_put_request(rq);
-			return ERR_PTR(ret);
-		}
-	}
-
-	return rq;
-}
-EXPORT_SYMBOL(blk_make_request);
-
-/**
  * blk_rq_set_block_pc - initialize a request to type BLOCK_PC
  * @rq:		request to be initialized
  *
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index daa4dc1..2f2a991 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1558,18 +1558,25 @@ static int _osd_req_finalize_data_integrity(struct osd_request *or,
 static struct request *_make_request(struct request_queue *q, bool has_write,
 			      struct _osd_io_info *oii, gfp_t flags)
 {
-	if (oii->bio)
-		return blk_make_request(q, oii->bio, flags);
-	else {
-		struct request *req;
-
-		req = blk_get_request(q, has_write ? WRITE : READ, flags);
-		if (IS_ERR(req))
-			return req;
+	struct request *req;
+	struct bio *bio = oii->bio;
+	int ret;
 
-		blk_rq_set_block_pc(req);
+	req = blk_get_request(q, has_write ? WRITE : READ, flags);
+	if (IS_ERR(req))
 		return req;
+	blk_rq_set_block_pc(req);
+
+	for_each_bio(bio) {
+		struct bio *bounce_bio = bio;
+
+		blk_queue_bounce(req->q, &bounce_bio);
+		ret = blk_rq_append_bio(req, bounce_bio);
+		if (ret)
+			return ERR_PTR(ret);
 	}
+
+	return req;
 }
 
 static int _init_blk_request(struct osd_request *or,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a029ad9..18e5e5a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -787,8 +787,6 @@ extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_put_request(struct request *);
 extern void __blk_put_request(struct request_queue *, struct request *);
 extern struct request *blk_get_request(struct request_queue *, int, gfp_t);
-extern struct request *blk_make_request(struct request_queue *, struct bio *,
-					gfp_t);
 extern void blk_rq_set_block_pc(struct request *);
 extern void blk_requeue_request(struct request_queue *, struct request *);
 extern void blk_add_request_payload(struct request *rq, struct page *page,
-- 
2.1.4

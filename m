Return-Path: <BATV+08196f5b2bd262a84b8d+5113+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 08/10] block: provide a generic_make_request_fast helper
Date: Wed, 23 Aug 2017 19:58:13 +0200
Message-Id: <20170823175815.3646-9-hch@lst.de>
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This helper allows reinserting a bio into a new queue without much
overhead, but requires all queue limits to be the same for the upper
and lower queues, and it does not provide any recursion preventions,
which requires the caller to not split the bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 26 ++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0c7050f20a60..e91f3477538f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2224,6 +2224,32 @@ blk_qc_t generic_make_request(struct bio *bio)
 }
 EXPORT_SYMBOL(generic_make_request);
 
+/*
+ * Fast-path version of generic_make_request.  The caller must ensure that
+ * generic_make_request_checks has already been called with the limits that
+ * fit the queue, and no recursion prevention is provided.
+ */
+blk_qc_t generic_make_request_fast(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	bool nowait = bio->bi_opf & REQ_NOWAIT;
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	if (unlikely(blk_queue_enter(q, nowait))) {
+		if (nowait && !blk_queue_dying(q))
+			bio->bi_status = BLK_STS_AGAIN;
+		else
+			bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return BLK_QC_T_NONE;
+	}
+
+	ret = q->make_request_fn(q, bio);
+	blk_queue_exit(q);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_make_request_fast);
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 25f6a0cb27d3..5f81151d181a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -938,6 +938,7 @@ do {								\
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern blk_qc_t generic_make_request(struct bio *bio);
+extern blk_qc_t generic_make_request_fast(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
-- 
2.11.0

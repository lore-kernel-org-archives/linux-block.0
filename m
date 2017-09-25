Return-Path: <BATV+21c581e1042956a70a85+5146+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/9] block: provide a direct_make_request helper
Date: Mon, 25 Sep 2017 15:40:25 +0200
Message-Id: <20170925134031.10548-4-hch@lst.de>
In-Reply-To: <20170925134031.10548-1-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This helper allows reinserting a bio into a new queue without much
overhead, but requires all queue limits to be the same for the upper
and lower queues, and it does not provide any recursion preventions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 048be4aa6024..d7b5d392b550 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2241,6 +2241,38 @@ blk_qc_t generic_make_request(struct bio *bio)
 }
 EXPORT_SYMBOL(generic_make_request);
 
+/**
+ * direct_make_request - hand a buffer directly to its device driver for I/O
+ * @bio:  The bio describing the location in memory and on the device.
+ *
+ * This function behaves like generic_make_request(), but does not protect
+ * against recursion.  Must only be used if the called driver is known
+ * to not re-issue this bio or a split to itself.
+ */
+blk_qc_t direct_make_request(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	bool nowait = bio->bi_opf & REQ_NOWAIT;
+	blk_qc_t ret;
+
+	if (!generic_make_request_checks(bio))
+		return BLK_QC_T_NONE;
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
+EXPORT_SYMBOL_GPL(direct_make_request);
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02fa42d24b52..780f01db5899 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -936,6 +936,7 @@ do {								\
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
 extern blk_qc_t generic_make_request(struct bio *bio);
+extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
 extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
-- 
2.14.1

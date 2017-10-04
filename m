Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	shli@kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/9] QUEUE_FLAG_NOWAIT to indicate device supports nowait
Date: Wed,  4 Oct 2017 08:55:03 -0500
Message-Id: <20171004135511.26110-2-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Nowait is a feature of direct AIO, where users can request
to return immediately if the I/O is going to block. This translates
to REQ_NOWAIT in bio.bi_opf flags. While request based devices
don't wait, stacked devices such as md/dm will.

In order to explicitly mark stacked devices as supported, we
set the QUEUE_FLAG_NOWAIT in the queue_flags and return -EAGAIN
whenever the device would block.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 block/blk-core.c       | 4 ++--
 include/linux/blkdev.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 048be4aa6024..8de633f8c633 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2044,10 +2044,10 @@ generic_make_request_checks(struct bio *bio)
 
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
-	 * if queue is not a request based queue.
+	 * if queue cannot handle nowait bio's
 	 */
 
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
+	if ((bio->bi_opf & REQ_NOWAIT) && !blk_queue_supports_nowait(q))
 		goto not_supported;
 
 	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02fa42d24b52..1d0da2a9cf46 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -631,6 +631,7 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
+#define QUEUE_FLAG_NOWAIT      29	/* stack device driver supports REQ_NOWAIT */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -759,6 +760,11 @@ static inline bool queue_is_rq_based(struct request_queue *q)
 	return q->request_fn || q->mq_ops;
 }
 
+static inline bool blk_queue_supports_nowait(struct request_queue *q)
+{
+	return queue_is_rq_based(q) || test_bit(QUEUE_FLAG_NOWAIT, &q->queue_flags);
+}
+
 static inline unsigned int blk_queue_cluster(struct request_queue *q)
 {
 	return q->limits.cluster;
-- 
2.14.2

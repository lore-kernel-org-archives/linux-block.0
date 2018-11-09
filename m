Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJETi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Nov 2018 23:19:38 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove req->timeout_list
Date: Fri,  9 Nov 2018 19:37:44 +0100
Message-Id: <20181109183744.21451-1-hch@lst.de>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Unused now that the legacy request path is gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  1 -
 block/blk-mq.c         |  1 -
 block/blk-timeout.c    | 12 ------------
 block/blk.h            |  2 --
 include/linux/blkdev.h |  2 --
 5 files changed, 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3daab9df24e0..fdc0ad2686c4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -144,7 +144,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	memset(rq, 0, sizeof(*rq));
 
 	INIT_LIST_HEAD(&rq->queuelist);
-	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->q = q;
 	rq->__sector = (sector_t) -1;
 	INIT_HLIST_NODE(&rq->hash);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4880e13e2394..411be60d0cb6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -327,7 +327,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->extra_len = 0;
 	rq->__deadline = 0;
 
-	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
 
 	rq->end_io = NULL;
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 6428d458072a..006cff4390c0 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -68,16 +68,6 @@ ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
 
 #endif /* CONFIG_FAIL_IO_TIMEOUT */
 
-/*
- * blk_delete_timer - Delete/cancel timer for a given function.
- * @req:	request that we are canceling timer for
- *
- */
-void blk_delete_timer(struct request *req)
-{
-	list_del_init(&req->timeout_list);
-}
-
 /**
  * blk_abort_request -- Request request recovery for the specified command
  * @req:	pointer to the request of interest
@@ -123,8 +113,6 @@ void blk_add_timer(struct request *req)
 	struct request_queue *q = req->q;
 	unsigned long expiry;
 
-	BUG_ON(!list_empty(&req->timeout_list));
-
 	/*
 	 * Some LLDs, like scsi, peek at the timeout to prevent a
 	 * command from being retried forever.
diff --git a/block/blk.h b/block/blk.h
index 78ae94886acf..41b64e6e101b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -222,8 +222,6 @@ static inline bool bio_integrity_endio(struct bio *bio)
 
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
-void blk_delete_timer(struct request *);
-
 
 bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 			     struct bio *bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9b1f470cc784..dc2a6f625ecb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -228,8 +228,6 @@ struct request {
 	/* access through blk_rq_set_deadline, blk_rq_deadline */
 	unsigned long __deadline;
 
-	struct list_head timeout_list;
-
 	union {
 		struct __call_single_data csd;
 		u64 fifo_time;
-- 
2.19.1

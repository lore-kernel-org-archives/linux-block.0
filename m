Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, Omar Sandoval
	<osandov@fb.com>
Subject: [PATCH v5 03/12] block: Introduce request_queue.initialize_rq_fn()
Date: Tue, 20 Jun 2017 11:15:40 -0700
Message-ID: <20170620181549.24903-4-bart.vanassche@wdc.com>
In-Reply-To: <20170620181549.24903-1-bart.vanassche@wdc.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

Several block drivers need to initialize the driver-private request
data after having called blk_get_request() and before .prep_rq_fn()
is called, e.g. when submitting a REQ_OP_SCSI_* request. Avoid that
that initialization code has to be repeated after every
blk_get_request() call by adding new callback functions to struct
request_queue and to struct blk_mq_ops.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c       | 17 +++++++++++++----
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  4 ++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 21f6f1020303..09989028616f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1372,12 +1372,21 @@ static struct request *blk_old_get_request(struct request_queue *q,
 struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				gfp_t gfp_mask)
 {
-	if (q->mq_ops)
-		return blk_mq_alloc_request(q, op,
+	struct request *req;
+
+	if (q->mq_ops) {
+		req = blk_mq_alloc_request(q, op,
 			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
 				0 : BLK_MQ_REQ_NOWAIT);
-	else
-		return blk_old_get_request(q, op, gfp_mask);
+		if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
+			q->mq_ops->initialize_rq_fn(req);
+	} else {
+		req = blk_old_get_request(q, op, gfp_mask);
+		if (!IS_ERR(req) && q->initialize_rq_fn)
+			q->initialize_rq_fn(req);
+	}
+
+	return req;
 }
 EXPORT_SYMBOL(blk_get_request);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3077714250ce..366b83cee955 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -144,6 +144,8 @@ struct blk_mq_ops {
 	init_request_fn		*init_request;
 	exit_request_fn		*exit_request;
 	reinit_request_fn	*reinit_request;
+	/* Called from inside blk_get_request() */
+	void (*initialize_rq_fn)(struct request *rq);
 
 	map_queues_fn		*map_queues;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c2844c27ef65..ff0ae83235ea 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -410,8 +410,12 @@ struct request_queue {
 	rq_timed_out_fn		*rq_timed_out_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 	lld_busy_fn		*lld_busy_fn;
+	/* Called just after a request is allocated */
 	init_rq_fn		*init_rq_fn;
+	/* Called just before a request is freed */
 	exit_rq_fn		*exit_rq_fn;
+	/* Called from inside blk_get_request() */
+	void (*initialize_rq_fn)(struct request *rq);
 
 	const struct blk_mq_ops	*mq_ops;
 
-- 
2.13.1

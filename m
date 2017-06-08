Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>
Subject: [PATCH v3 03/12] block: Introduce request_queue.initialize_rq_fn()
Date: Thu, 8 Jun 2017 10:33:46 -0700
Message-ID: <20170608173355.25898-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170608173355.25898-1-bart.vanassche@sandisk.com>
References: <20170608173355.25898-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

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
 block/blk-core.c       | 17 +++++++++++++++--
 include/linux/blk-mq.h |  2 ++
 include/linux/blkdev.h |  4 ++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3bc431a77309..86fc08898fac 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1308,12 +1308,25 @@ static struct request *blk_old_get_request(struct request_queue *q,
 struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				gfp_t gfp_mask)
 {
+	struct request *req;
+
 	if (q->mq_ops)
-		return blk_mq_alloc_request(q, op,
+		req = blk_mq_alloc_request(q, op,
 			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
 				0 : BLK_MQ_REQ_NOWAIT);
 	else
-		return blk_old_get_request(q, op, gfp_mask);
+		req = blk_old_get_request(q, op, gfp_mask);
+
+	if (IS_ERR(req))
+		goto out;
+
+	if (q->mq_ops && q->mq_ops->initialize_rq_fn)
+		q->mq_ops->initialize_rq_fn(req);
+	else if (!q->mq_ops && q->initialize_rq_fn)
+		q->initialize_rq_fn(req);
+
+out:
+	return req;
 }
 EXPORT_SYMBOL(blk_get_request);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a4759fd34e7e..61125d200492 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -143,6 +143,8 @@ struct blk_mq_ops {
 	init_request_fn		*init_request;
 	exit_request_fn		*exit_request;
 	reinit_request_fn	*reinit_request;
+	/* Called from inside blk_get_request() */
+	void (*initialize_rq_fn)(struct request *rq);
 
 	map_queues_fn		*map_queues;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6c4235018b49..cbc0028290e4 100644
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
2.12.2

Return-Path: <prvs=403a468a2=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Call .initialize_rq_fn() also for filesystem requests
Date: Fri, 25 Aug 2017 12:00:57 -0700
Message-Id: <20170825190057.15592-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since .initialize_rq_fn() is called from inside blk_get_request()
that function is only called for pass-through requests but not for
filesystem requests. There is agreement in the SCSI community that
the jiffies_at_alloc and retries members of struct scsi_cmnd
should be initialized at request allocation time instead of when
preparing a request. This will allow to preserve the value of these
members when requeuing a request. Since the block layer does not
yet allow block drivers to initialize filesystem requests without
overriding request_queue.make_request_fn, move the
.initialize_rq_fn() calls from blk_get_request() into
blk_mq_rq_ctx_init() and blk_rq_init().

See also https://www.spinics.net/lists/linux-scsi/msg108934.html.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-core.c | 20 +++++++-------------
 block/blk-mq.c   |  4 ++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 78a46794053e..463aa0ee36ce 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -126,6 +126,9 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->start_time = jiffies;
 	set_start_time_ns(rq);
 	rq->part = NULL;
+
+	if (q && q->initialize_rq_fn)
+		q->initialize_rq_fn(rq);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
@@ -1420,21 +1423,12 @@ static struct request *blk_old_get_request(struct request_queue *q,
 struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				gfp_t gfp_mask)
 {
-	struct request *req;
-
-	if (q->mq_ops) {
-		req = blk_mq_alloc_request(q, op,
+	if (q->mq_ops)
+		return blk_mq_alloc_request(q, op,
 			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
 				0 : BLK_MQ_REQ_NOWAIT);
-		if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
-			q->mq_ops->initialize_rq_fn(req);
-	} else {
-		req = blk_old_get_request(q, op, gfp_mask);
-		if (!IS_ERR(req) && q->initialize_rq_fn)
-			q->initialize_rq_fn(req);
-	}
-
-	return req;
+	else
+		return blk_old_get_request(q, op, gfp_mask);
 }
 EXPORT_SYMBOL(blk_get_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21f2cff217ce..fdb33f8a2860 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -273,6 +273,7 @@ EXPORT_SYMBOL(blk_mq_can_queue);
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		unsigned int tag, unsigned int op)
 {
+	struct request_queue *q = data->q;
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
 
@@ -325,6 +326,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
 
+	if (q->mq_ops->initialize_rq_fn)
+		q->mq_ops->initialize_rq_fn(rq);
+
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
 	return rq;
 }
-- 
2.14.1

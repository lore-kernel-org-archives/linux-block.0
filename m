Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 06/10] blk-mq: streamline blk_mq_get_request
Date: Fri, 16 Jun 2017 18:15:23 +0200
Message-Id: <20170616161527.17649-7-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0b17351fccfc..e056725679a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -302,24 +302,24 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 			rq = e->type->ops.mq.get_request(q, op, data);
 			if (rq)
 				rq->rq_flags |= RQF_QUEUED;
-		} else
-			rq = __blk_mq_alloc_request(data, op);
-	} else {
-		rq = __blk_mq_alloc_request(data, op);
+			goto allocated;
+		}
 	}
 
-	if (rq) {
-		if (!op_is_flush(op)) {
-			rq->elv.icq = NULL;
-			if (e && e->type->icq_cache)
-				blk_mq_sched_assign_ioc(q, rq, bio);
-		}
-		data->hctx->queued++;
-		return rq;
+	rq = __blk_mq_alloc_request(data, op);
+allocated:
+	if (!rq) {
+		blk_queue_exit(q);
+		return NULL;
 	}
 
-	blk_queue_exit(q);
-	return NULL;
+	if (!op_is_flush(op)) {
+		rq->elv.icq = NULL;
+		if (e && e->type->icq_cache)
+			blk_mq_sched_assign_ioc(q, rq, bio);
+	}
+	data->hctx->queued++;
+	return rq;
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
-- 
2.11.0

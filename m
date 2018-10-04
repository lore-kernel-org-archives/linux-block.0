Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] blk-mq-debugfs: Also show requests that have not yet been started
Date: Thu,  4 Oct 2018 10:35:24 -0700
Message-Id: <20181004173524.52712-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

When debugging e.g. the SCSI timeout handler it is important that
requests that have not yet been started or that already have
completed are also reported through debugfs.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq-debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index a5ea86835fcb..41b86f50d126 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -431,8 +431,7 @@ static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
 {
 	const struct show_busy_params *params = data;
 
-	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
-	    blk_mq_rq_state(rq) != MQ_RQ_IDLE)
+	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx)
 		__blk_mq_debugfs_rq_show(params->m,
 					 list_entry_rq(&rq->queuelist));
 }
-- 
2.19.0.605.g01d371f741-goog

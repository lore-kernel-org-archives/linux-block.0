Return-Path: <prvs=5743cbe84=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] blk-mq-debugfs: Also show requests that have not yet been started
Date: Mon, 12 Feb 2018 09:02:00 -0800
Message-Id: <20180212170200.13131-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

When debugging e.g. the SCSI timeout handler it is important that
requests that have not yet been started or that already have
completed are also reported through debugfs.

This patch depends on a patch that went upstream in kernel v4.15,
namely commit 14e3062fb185 ("scsi: core: Fix a scsi_show_rq() NULL
pointer dereference").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-mq-debugfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c62a3704515b..bcb64b2f8090 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -401,6 +401,12 @@ struct show_busy_params {
 };
 
 /*
+ * Show "busy" requests - these are the requests owned by the block driver.
+ * The test list_empty(&rq->queuelist) is used to figure out whether or not
+ * a request is owned by the block driver. That test works because the block
+ * layer core uses list_del_init() consistently to remove a request from one
+ * of the request lists.
+ *
  * Note: the state of a request may change while this function is in progress,
  * e.g. due to a concurrent blk_mq_finish_request() call.
  */
@@ -409,7 +415,7 @@ static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
 	const struct show_busy_params *params = data;
 
 	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
-	    blk_mq_rq_state(rq) != MQ_RQ_IDLE)
+	    list_empty(&rq->queuelist))
 		__blk_mq_debugfs_rq_show(params->m,
 					 list_entry_rq(&rq->queuelist));
 }
-- 
2.16.1

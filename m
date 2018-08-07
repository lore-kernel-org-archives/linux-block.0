Return-Path: <prvs=750bc9d11=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 8/9] blk-mq: Insert a blk_pm_put_request() call
Date: Tue,  7 Aug 2018 15:51:32 -0700
Message-Id: <20180807225133.27221-9-bart.vanassche@wdc.com>
In-Reply-To: <20180807225133.27221-1-bart.vanassche@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Call blk_pm_put_request() after a request has finished.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 434515018c43..6fb91b2b001c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -37,6 +37,7 @@
 #include "blk-pm.h"
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
+#include "blk-pm.h"
 #include "blk-rq-qos.h"
 
 static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
@@ -478,6 +479,8 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	blk_pm_put_request(rq);
+
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
-- 
2.18.0

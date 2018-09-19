Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v9 8/8] blk-mq: Enable support for runtime power management
Date: Wed, 19 Sep 2018 15:45:30 -0700
Message-Id: <20180919224530.222469-9-bvanassche@acm.org>
In-Reply-To: <20180919224530.222469-1-bvanassche@acm.org>
References: <20180919224530.222469-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Now that the blk-mq core processes power management requests
(marked with RQF_PREEMPT) in other states than RPM_ACTIVE, enable
runtime power management for blk-mq.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-mq.c | 2 ++
 block/blk-pm.c | 6 ------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..20fdd78b75c7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -33,6 +33,7 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
+#include "blk-pm.h"
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
@@ -475,6 +476,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	blk_pm_mark_last_busy(rq);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 3ad5a7334baa..7c0ac1424f46 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -30,12 +30,6 @@
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* Don't enable runtime PM for blk-mq until it is ready */
-	if (q->mq_ops) {
-		pm_runtime_disable(dev);
-		return;
-	}
-
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_set_autosuspend_delay(q->dev, -1);
-- 
2.19.0.397.gdd90340f6a-goog

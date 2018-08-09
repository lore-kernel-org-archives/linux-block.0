Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
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
Subject: [PATCH v6 10/12] block: Change the runtime power management approach (1/2)
Date: Thu,  9 Aug 2018 12:41:47 -0700
Message-Id: <20180809194149.15285-11-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Instead of scheduling runtime resume of a request queue after a
request has been queued, schedule asynchronous resume during request
allocation. The new pm_request_resume() calls occur after
blk_queue_enter() has increased the q_usage_counter request queue
member. This change is needed for a later patch that will make request
allocation block while the queue status is not RPM_ACTIVE.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c | 2 ++
 block/blk-mq.c   | 2 ++
 block/elevator.c | 1 -
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 59dd98585eb0..f30545fb2de2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -972,6 +972,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (success)
 			return 0;
 
+		blk_pm_request_resume(q);
+
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2a0eb058ba5a..24439735f20b 100644
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
@@ -473,6 +474,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	blk_pm_mark_last_busy(rq);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
diff --git a/block/elevator.c b/block/elevator.c
index 00c5d8dbce16..4c15f0240c99 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -601,7 +601,6 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 	trace_block_rq_insert(q, rq);
 
 	blk_pm_add_request(q, rq);
-	blk_pm_request_resume(q);
 
 	rq->q = q;
 
-- 
2.18.0

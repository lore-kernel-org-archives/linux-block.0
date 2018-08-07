Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [RFC PATCH 14/14] block: enable runtime PM for blk-mq
Date: Wed,  8 Aug 2018 01:44:33 +0800
Message-Id: <20180807174433.8374-15-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now blk-mq can borrow the runtime PM approach from legacy path, so
enable it simply.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 6 ------
 block/blk-mq.c   | 4 ++++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7390149f4fd1..26f9ceb85318 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3722,12 +3722,6 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* Don't enable runtime PM for blk-mq until it is ready */
-	if (q->mq_ops) {
-		pm_runtime_disable(dev);
-		return;
-	}
-
 	mutex_init(&q->pm_lock);
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf0790b628e4..4feb3f484c6a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/pm_runtime.h>
 
 #include <trace/events/block.h>
 
@@ -479,6 +480,9 @@ static void __blk_mq_free_request(struct request *rq)
 		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
+
+	if (q->dev)
+		pm_runtime_mark_last_busy(q->dev);
 }
 
 void blk_mq_free_request(struct request *rq)
-- 
2.9.5

Return-Path: <prvs=7457c2e9b=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 9/9] blk-mq: Enable support for runtime power management
Date: Thu,  2 Aug 2018 11:29:44 -0700
Message-Id: <20180802182944.14442-10-bart.vanassche@wdc.com>
In-Reply-To: <20180802182944.14442-1-bart.vanassche@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Now that the blk-mq core processes power management requests
(marked with RQF_PREEMPT) in other states than RPM_ACTIVE, enable
runtime power management for blk-mq.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-pm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index c33c881f64df..d719cae766cf 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -66,10 +66,6 @@ void blk_pm_runtime_unlock(struct request_queue *q)
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
-	if (q->mq_ops)
-		return;
-
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_set_autosuspend_delay(q->dev, -1);
-- 
2.18.0

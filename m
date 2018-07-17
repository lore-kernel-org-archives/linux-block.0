Return-Path: <prvs=72995191e=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/3] blk-mq: Enable support for runtime power management
Date: Tue, 17 Jul 2018 16:49:40 -0700
Message-Id: <20180717234940.11231-4-bart.vanassche@wdc.com>
In-Reply-To: <20180717234940.11231-1-bart.vanassche@wdc.com>
References: <20180717234940.11231-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Now that the blk-mq core processes power management requests
(marked with RQF_PREEMPT) in other states than RPM_ACTIVE, enable
runtime power management for blk-mq.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 65d7f27c8c22..5aade9fa96be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3739,10 +3739,6 @@ EXPORT_SYMBOL(blk_finish_plug);
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

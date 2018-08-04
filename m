Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34555 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbeHDCCA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 22:02:00 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 10/10] blk-mq: Enable support for runtime power management
Date: Fri,  3 Aug 2018 17:03:25 -0700
Message-Id: <20180804000325.3610-11-bart.vanassche@wdc.com>
In-Reply-To: <20180804000325.3610-1-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
 block/blk-pm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 0708185ead61..583cfc04e869 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -66,12 +66,6 @@ void blk_pm_runtime_unlock(struct request_queue *q)
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
2.18.0

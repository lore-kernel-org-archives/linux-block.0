Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33909 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbeGYXjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jul 2018 19:39:54 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 5/5] blk-mq: Enable support for runtime power management
Date: Wed, 25 Jul 2018 15:26:07 -0700
Message-Id: <20180725222607.8854-6-bart.vanassche@wdc.com>
In-Reply-To: <20180725222607.8854-1-bart.vanassche@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that the blk-mq core processes power management requests
(marked with RQF_PREEMPT) in other states than RPM_ACTIVE, enable
runtime power management for blk-mq.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-pm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 9f1130381322..d9e64bfb3007 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -62,10 +62,6 @@ void blk_pm_runtime_unlock(struct request_queue *q)
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

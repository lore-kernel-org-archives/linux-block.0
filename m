Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6503 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbeHBUWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Aug 2018 16:22:04 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 7/9] block: Remove blk_pm_requeue_request()
Date: Thu,  2 Aug 2018 11:29:42 -0700
Message-Id: <20180802182944.14442-8-bart.vanassche@wdc.com>
In-Reply-To: <20180802182944.14442-1-bart.vanassche@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since this function is now empty, remove it.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-pm.h   | 8 --------
 block/elevator.c | 2 --
 2 files changed, 10 deletions(-)

diff --git a/block/blk-pm.h b/block/blk-pm.h
index 3978a3021958..d9077bd7ba6d 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -6,10 +6,6 @@
 #include <linux/pm_runtime.h>
 
 #ifdef CONFIG_PM
-static inline void blk_pm_requeue_request(struct request *rq)
-{
-}
-
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
@@ -26,10 +22,6 @@ static inline void blk_pm_put_request(struct request *rq)
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
 #else
-static inline void blk_pm_requeue_request(struct request *rq)
-{
-}
-
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
diff --git a/block/elevator.c b/block/elevator.c
index 4c15f0240c99..fd7b12bb32a3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -572,8 +572,6 @@ void elv_requeue_request(struct request_queue *q, struct request *rq)
 
 	rq->rq_flags &= ~RQF_STARTED;
 
-	blk_pm_requeue_request(rq);
-
 	__elv_add_request(q, rq, ELEVATOR_INSERT_REQUEUE);
 }
 
-- 
2.18.0

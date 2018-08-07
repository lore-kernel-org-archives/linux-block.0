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
Subject: [PATCH v5 7/9] block: Remove blk_pm_requeue_request()
Date: Tue,  7 Aug 2018 15:51:31 -0700
Message-Id: <20180807225133.27221-8-bart.vanassche@wdc.com>
In-Reply-To: <20180807225133.27221-1-bart.vanassche@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since this function is now empty, remove it.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-pm.h   | 8 --------
 block/elevator.c | 2 --
 2 files changed, 10 deletions(-)

diff --git a/block/blk-pm.h b/block/blk-pm.h
index fcb507a29e99..3a903efcacaf 100644
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
@@ -24,10 +20,6 @@ static inline void blk_pm_put_request(struct request *rq)
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
index 3965292b0724..9e46df35cacc 100644
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

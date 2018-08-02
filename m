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
Subject: [PATCH v3 6/9] block: Warn if pm_runtime_get*() has not been called
Date: Thu,  2 Aug 2018 11:29:41 -0700
Message-Id: <20180802182944.14442-7-bart.vanassche@wdc.com>
In-Reply-To: <20180802182944.14442-1-bart.vanassche@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Make it easier to determine from which code path a pm_runtime_get*()
call is missing by issuing a warning if such a call is missing.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-pm.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-pm.h b/block/blk-pm.h
index 226fe34c0df9..3978a3021958 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -13,8 +13,10 @@ static inline void blk_pm_requeue_request(struct request *rq)
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
-	if (q->dev && !(rq->rq_flags & RQF_PREEMPT) &&
-	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
+	if (!q->dev || (rq->rq_flags & RQF_PREEMPT))
+		return;
+	WARN_ON_ONCE(atomic_read(&q->dev->power.usage_count) == 0);
+	if (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING)
 		pm_request_resume(q->dev);
 }
 
-- 
2.18.0

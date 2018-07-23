Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/2] blk-mq: export setting request completion state
Date: Mon, 23 Jul 2018 08:37:50 -0600
Message-Id: <20180723143751.10843-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This is preparing for drivers that want to directly alter the state of
their requests. No functional change here.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

  Reversed the return value: 'true' for success instead of failure.

  Document the caller's responsibilities after a successful state transtion.

 block/blk-mq.c         |  4 +---
 include/linux/blk-mq.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22326612a5d3..8f01cd7fd182 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -558,10 +558,8 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	if (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
-			MQ_RQ_IN_FLIGHT)
+	if (!blk_mq_mark_complete(rq))
 		return;
-
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9b0fd11ce89a..4d41ed16314c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -289,6 +289,20 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
+/**
+ * blk_mq_mark_complete() - Set request state to complete
+ * @rq: request to set to complete state
+ *
+ * Returns true if request state was successfully set to complete. If
+ * successful, the caller is responsibile for seeing this request is ended, as
+ * blk_mq_complete_request will not work again.
+ */
+static inline bool blk_mq_mark_complete(struct request *rq)
+{
+	return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
+			MQ_RQ_IN_FLIGHT;
+}
+
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
-- 
2.14.4

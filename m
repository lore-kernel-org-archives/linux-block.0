Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: [PATCH 02/12] blk-mq: Introduce blk_mq_hctx_stopped()
To: Jens Axboe <axboe@fb.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <0de50789-e3b7-0a07-73c1-4fb87b1f957e@sandisk.com>
Date: Wed, 26 Oct 2016 15:51:33 -0700
MIME-Version: 1.0
In-Reply-To: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Ming Lei <tom.leiming@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>, Doug Ledford <dledford@redhat.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Multiple functions test the BLK_MQ_S_STOPPED bit so introduce
a helper function that performs this test.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 12 ++++++------
 block/blk-mq.h |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b5dcafb..b52b3a6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -787,7 +787,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	struct list_head *dptr;
 	int queued;
 
-	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 
 	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
@@ -912,8 +912,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
-	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state) ||
-	    !blk_mq_hw_queue_mapped(hctx)))
+	if (unlikely(blk_mq_hctx_stopped(hctx) ||
+		     !blk_mq_hw_queue_mapped(hctx)))
 		return;
 
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
@@ -938,7 +938,7 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if ((!blk_mq_hctx_has_pending(hctx) &&
 		    list_empty_careful(&hctx->dispatch)) ||
-		    test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+		    blk_mq_hctx_stopped(hctx))
 			continue;
 
 		blk_mq_run_hw_queue(hctx, async);
@@ -988,7 +988,7 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!test_bit(BLK_MQ_S_STOPPED, &hctx->state))
+		if (!blk_mq_hctx_stopped(hctx))
 			continue;
 
 		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
@@ -1332,7 +1332,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_mq_put_ctx(data.ctx);
 		if (!old_rq)
 			goto done;
-		if (test_bit(BLK_MQ_S_STOPPED, &data.hctx->state) ||
+		if (blk_mq_hctx_stopped(data.hctx) ||
 		    blk_mq_direct_issue_request(old_rq, &cookie) != 0)
 			blk_mq_insert_request(old_rq, false, true, true);
 		goto done;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e5d2524..ac772da 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -100,6 +100,11 @@ static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
 	data->hctx = hctx;
 }
 
+static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
+{
+	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
+}
+
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 {
 	return hctx->nr_ctx && hctx->tags;
-- 
2.10.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
Date: Thu, 21 Dec 2017 13:46:35 -0700
Message-Id: <20171221204636.2924-3-keith.busch@intel.com>
In-Reply-To: <20171221204636.2924-1-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This is a micro-optimization removing unnecessary check for a disabled
queue. We no longer need this check because blk-mq provides the ability
to quiesce queues that nvme uses, and the doorbell registers are never
unmapped as long as requests are active.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index df5550ce0531..0be5124a3a49 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -887,11 +887,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (unlikely(nvmeq->cq_vector < 0)) {
-		ret = BLK_STS_IOERR;
-		spin_unlock_irq(&nvmeq->q_lock);
-		goto out_cleanup_iod;
-	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
 	blk_mq_start_request(req);
 	nvme_process_cq(nvmeq);
@@ -923,11 +918,9 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 {
 	u16 head = nvmeq->cq_head;
 
-	if (likely(nvmeq->cq_vector >= 0)) {
-		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
+	if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
 						      nvmeq->dbbuf_cq_ei))
-			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-	}
+		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 }
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
-- 
2.13.6

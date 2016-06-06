Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lin <ming.l@samsung.com>
Subject: [PATCH 10/10] nvme: move nvme_cancel_request() to core.c
Date: Mon,  6 Jun 2016 23:20:52 +0200
Message-Id: <1465248052-17811-11-git-send-email-hch@lst.de>
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Ming Lin <ming.l@samsung.com>

So it can be used by fabrics driver as well.

Signed-off-by: Ming Lin <ming.l@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 16 ----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 972029a..27cce17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -58,6 +58,23 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+void nvme_cancel_request(struct request *req, void *data, bool reserved)
+{
+	int status;
+
+	if (!blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+				"Cancelling I/O %d", req->tag);
+
+	status = NVME_SC_ABORT_REQ;
+	if (blk_queue_dying(req->q))
+		status |= NVME_SC_DNR;
+	blk_mq_complete_request(req, status);
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_request);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1daa048..bb7f001 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -207,6 +207,7 @@ static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 		(jiffies - req->start_time) < req->timeout;
 }
 
+void nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5ae5804..2c3019a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -919,22 +919,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_cancel_request(struct request *req, void *data, bool reserved)
-{
-	int status;
-
-	if (!blk_mq_request_started(req))
-		return;
-
-	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
-				"Cancelling I/O %d", req->tag);
-
-	status = NVME_SC_ABORT_REQ;
-	if (blk_queue_dying(req->q))
-		status |= NVME_SC_DNR;
-	blk_mq_complete_request(req, status);
-}
-
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-- 
2.1.4

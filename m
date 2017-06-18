Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52150 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:28 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 13/30] nvme-rdma: move queue LIVE/DELETING flags settings to queue routines
Date: Sun, 18 Jun 2017 18:21:47 +0300
Message-Id: <1497799324-19598-14-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 34518c90609a..d9524389aedd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -565,7 +565,7 @@ static void nvme_rdma_stop_queue(struct nvme_rdma_ctrl *ctrl, int qid)
 {
 	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
 
-	if (test_bit(NVME_RDMA_Q_DELETING, &queue->flags))
+	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		return;
 	rdma_disconnect(queue->cm_id);
 	ib_drain_qp(queue->qp);
@@ -617,7 +617,9 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	else
 		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 
-	if (ret)
+	if (!ret)
+		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[idx].flags);
+	else
 		dev_info(ctrl->ctrl.device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
@@ -631,8 +633,6 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 		ret = nvme_rdma_start_queue(ctrl, i);
 		if (ret)
 			goto out_stop_queues;
-
-		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
@@ -823,8 +823,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new
 	if (error)
 		goto out_cleanup_connect_queue;
 
-	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
-
 	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
-- 
2.7.4

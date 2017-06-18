Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52192 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbdFRPWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:35 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 18/30] nvme-rdma: limit max_queues to rdma device number of completion vectors
Date: Sun, 18 Jun 2017 18:21:52 +0300
Message-Id: <1497799324-19598-19-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

nvme_rdma_alloc_io_queues is heading to generic code, we want
to decouple its dependency from the various transports.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7f4b66cf67cc..ce63dd40e6b4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -625,6 +625,14 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		ctrl->ctrl.max_hw_sectors =
 			(ctrl->max_fr_pages - 1) << (PAGE_SHIFT - 9);
 
+		/*
+		 * we map queues according to the device irq vectors for
+		 * optimal locality so we don't need more queues than
+		 * completion vectors.
+		 */
+		ctrl->ctrl.max_queues = min_t(u32, ctrl->ctrl.max_queues,
+				ctrl->device->dev->num_comp_vectors + 1);
+
 		ret = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
 			&ctrl->async_event_sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
@@ -632,7 +640,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 			nvme_rdma_destroy_queue_ib(&ctrl->queues[0]);
 			goto out_destroy_cm_id;
 		}
-
 	}
 
 	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
@@ -733,18 +740,9 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	unsigned int nr_io_queues = ctrl->ctrl.max_queues - 1;
-	struct ib_device *ibdev = ctrl->device->dev;
 	int i, ret;
 
 	nr_io_queues = min(nr_io_queues, num_online_cpus());
-	/*
-	 * we map queues according to the device irq vectors for
-	 * optimal locality so we don't need more queues than
-	 * completion vectors.
-	 */
-	nr_io_queues = min_t(unsigned int, nr_io_queues,
-				ibdev->num_comp_vectors);
-
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
-- 
2.7.4

Return-Path: <anish.jhaveri@paviliondata.com>
Date: Mon, 11 Sep 2017 21:22:26 -0700
From: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
To: sagi@grimberg.me, hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 02/10] RDMA timeout triggers failover.
Message-ID: <20170912042226.bwdalyhvqd5xc24n@haynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: anish.jhaveri@paviliondata.com
List-ID: <linux-block@vger.kernel.org>

Trigger failover functionality will be called on any RDMA timeout. This timeout can occur due failure for an IO to be returned from Target. This could be caused due to interface going down while leads to failover functionality being triggered.

Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
---
 drivers/nvme/host/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a03299d..cb6a5f8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -174,6 +174,7 @@ static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
 {
 	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
 	kfree(qe->data);
+	qe->data = NULL;
 }
 
 static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
@@ -766,6 +767,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 
+	nvme_trigger_failover(&ctrl->ctrl);
+
 	for (i = 0; i < ctrl->ctrl.queue_count; i++)
 		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 
-- 
2.9.3

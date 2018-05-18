Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/6] nvme: Move all IO out of controller reset
Date: Fri, 18 May 2018 10:38:20 -0600
Message-Id: <20180518163823.27820-3-keith.busch@intel.com>
In-Reply-To: <20180518163823.27820-1-keith.busch@intel.com>
References: <20180518163823.27820-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

IO may be retryable, so don't wait for them in the reset path. These
commands may trigger a reset if that IO expires without a completion,
placing it on the requeue list. Waiting for these would then deadlock
the reset handler.

To fix the theoretical deadlock, this patch unblocks IO submission from
the reset_work as before, but moves the waiting to the IO safe scan_work
so that the reset_work may proceed to completion. Since the unfreezing
happens in the controller LIVE state, the nvme device has to track if
the queues were frozen now to prevent incorrect freeze depths.

This patch is also renaming the function 'nvme_dev_add' to a
more appropriate name that describes what it's actually doing:
nvme_alloc_io_tags.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++++++++-------------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1de68b56b318..34d7731f1419 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -214,6 +214,7 @@ static inline bool nvme_req_needs_retry(struct request *req)
 	if (blk_noretry_request(req))
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
+
 		return false;
 	if (nvme_req(req)->retries >= nvme_max_retries)
 		return false;
@@ -3177,6 +3178,8 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
+	if (ctrl->ops->update_hw_ctx)
+		ctrl->ops->update_hw_ctx(ctrl);
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c15c2ee7f61a..230c5424b197 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -320,6 +320,7 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	int (*reinit_request)(void *data, struct request *rq);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
+	void (*update_hw_ctx)(struct nvme_ctrl *ctrl);
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2bd9d84f58d0..6a7cbc631d92 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -99,6 +99,7 @@ struct nvme_dev {
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
+	bool queues_froze;
 
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
@@ -2065,10 +2066,33 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_pci_update_hw_ctx(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	bool unfreeze;
+
+	mutex_lock(&dev->shutdown_lock);
+	unfreeze = dev->queues_froze;
+	mutex_unlock(&dev->shutdown_lock);
+
+	if (unfreeze)
+		nvme_wait_freeze(&dev->ctrl);
+
+	blk_mq_update_nr_hw_queues(ctrl->tagset, dev->online_queues - 1);
+	nvme_free_queues(dev, dev->online_queues);
+
+	if (unfreeze)
+		nvme_unfreeze(&dev->ctrl);
+
+	mutex_lock(&dev->shutdown_lock);
+	dev->queues_froze = false;
+	mutex_unlock(&dev->shutdown_lock);
+}
+
 /*
  * return error value only when tagset allocation failed
  */
-static int nvme_dev_add(struct nvme_dev *dev)
+static int nvme_alloc_io_tags(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -2097,10 +2121,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 
 		nvme_dbbuf_set(dev);
 	} else {
-		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
-
-		/* Free previously allocated queues that are no longer usable */
-		nvme_free_queues(dev, dev->online_queues);
+		nvme_start_queues(&dev->ctrl);
 	}
 
 	return 0;
@@ -2201,7 +2222,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		nvme_start_freeze(&dev->ctrl);
+		if (!dev->queues_froze)	{
+			nvme_start_freeze(&dev->ctrl);
+			dev->queues_froze = true;
+		}
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pci_channel_offline(pdev) || !pci_is_enabled(pdev));
 	}
@@ -2375,13 +2399,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
-	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		/* hit this only when allocate tagset fails */
-		if (nvme_dev_add(dev))
-			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+	} else if (nvme_alloc_io_tags(dev)) {
+		new_state = NVME_CTRL_ADMIN_ONLY;
 	}
 
 	/*
@@ -2446,6 +2465,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
+	.update_hw_ctx		= nvme_pci_update_hw_ctx,
 	.get_address		= nvme_pci_get_address,
 };
 
-- 
2.14.3

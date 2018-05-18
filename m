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
Subject: [PATCH 1/6] nvme: Sync request queues on reset
Date: Fri, 18 May 2018 10:38:18 -0600
Message-Id: <20180518163823.27820-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This patch fixes races that occur with simultaneous controller
resets by synchronizing request queues prior to initializing the
controller. Withouth this, a thread may attempt disabling a controller
at the same time as we're trying to enable it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e5a7a9..1de68b56b318 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3471,6 +3471,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
+static void nvme_start_queue(struct nvme_ns *ns)
+{
+	blk_mq_unquiesce_queue(ns->queue);
+	blk_mq_kick_requeue_list(ns->queue);
+}
+
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -3499,7 +3505,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		blk_set_queue_dying(ns->queue);
 
 		/* Forcibly unquiesce queues to avoid blocking dispatch */
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_queue(ns);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
@@ -3569,11 +3575,22 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_sync_queue(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_sync_queues);
+
 int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
 {
 	if (!ctrl->ops->reinit_request)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7cf3fed..c15c2ee7f61a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -407,6 +407,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..8da63402d474 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2312,6 +2312,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
 
 	/*
 	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
-- 
2.14.3

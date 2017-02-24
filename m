Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:21956 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbdBXA1u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Feb 2017 19:27:50 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Marc MERLIN <marc@merlins.org>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/2] nvme: Complete all stuck requests
Date: Thu, 23 Feb 2017 19:36:01 -0500
Message-Id: <1487896561-10454-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If the block layer has entered requests and gets a CPU hot plug event
prior to the resume event, it will wait for those requests to exit. If
the nvme driver is shutting down, it will not start the queues back up,
preventing forward progress.

To fix that, this patch freezes the request queues when the driver intends
to shut down the controller so that no new requests may enter.  After the
controller has been disabled, the queues will be restarted to force all
entered requests to end in failure so that blk-mq's hot cpu notifier may
progress. To ensure the queue usage count is 0 on a shutdown, the driver
waits for freeze to complete before completing the controller shutdown.

On resume, the driver will unfreeze the queue for new requests to enter
once the hardware contexts are reinitialized.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:
  Simplified the freeze and waiting, using the new blk API.

 drivers/nvme/host/core.c | 33 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 14 ++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25ec4e5..9e99b94 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2344,6 +2344,39 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
+void nvme_unfreeze(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_unfreeze_queue(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_unfreeze);
+
+void nvme_wait_freeze(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_freeze_queue_wait(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_wait_freeze);
+
+void nvme_start_freeze(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_freeze_queue_start(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_start_freeze);
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a3da1e9..62af901 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -294,6 +294,9 @@ void nvme_queue_async_events(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
+void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_wait_freeze(struct nvme_ctrl *ctrl);
+void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 57a1af5..ce80cb5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1676,6 +1676,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	del_timer_sync(&dev->watchdog_timer);
 
 	mutex_lock(&dev->shutdown_lock);
+	if (shutdown)
+		nvme_start_freeze(&dev->ctrl);
 	if (pci_is_enabled(to_pci_dev(dev->dev))) {
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
@@ -1700,6 +1702,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+
+	/*
+	 * The driver will not be starting up queues again if shutting down so
+	 * must flush all entered requests to their failed completion to avoid
+	 * deadlocking blk-mq hot-cpu notifier.
+	 */
+	if (shutdown) {
+		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
+	}
 	mutex_unlock(&dev->shutdown_lock);
 }
 
@@ -1823,6 +1835,8 @@ static void nvme_reset_work(struct work_struct *work)
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_dev_add(dev);
+		if (was_suspended)
+			nvme_unfreeze(&dev->ctrl);
 	}
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
-- 
2.5.5

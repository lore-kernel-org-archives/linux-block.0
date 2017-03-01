Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: Marc MERLIN <marc@merlins.org>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/3] nvme: Complete all stuck requests
Date: Wed,  1 Mar 2017 14:22:12 -0500
Message-Id: <1488396132-11369-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
References: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

If the nvme driver is shutting down its controller, the drievr will not
start the queues up again, preventing blk-mq's hot CPU notifier from
making forward progress.

To fix that, this patch starts a request_queue freeze when the driver
resets a controller so no new requests may enter. The driver will wait
for frozen after IO queues are restarted to ensure the queue reference
can be reinitialized when nvme requests to unfreeze the queues.

If the driver is doing a safe shutdown, the driver will wait for the
controller to successfully complete all inflight requests so that we
don't unnecessarily fail them. Once the controller has been disabled,
the queues will be restarted to force remaining entered requests to end
in failure so that blk-mq's hot cpu notifier may progress.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/core.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  | 33 ++++++++++++++++++++++++++++-----
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25ec4e5..9b3b57f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2344,6 +2344,53 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
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
+void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
+		if (timeout <= 0)
+			break;
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
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
index a3da1e9..2aa20e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -294,6 +294,10 @@ void nvme_queue_async_events(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
+void nvme_unfreeze(struct nvme_ctrl *ctrl);
+void nvme_wait_freeze(struct nvme_ctrl *ctrl);
+void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
+void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eee8f84..26a5fd0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1675,21 +1675,34 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i, queues;
-	u32 csts = -1;
+	bool dead = true;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	del_timer_sync(&dev->watchdog_timer);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(to_pci_dev(dev->dev))) {
-		nvme_stop_queues(&dev->ctrl);
-		csts = readl(dev->bar + NVME_REG_CSTS);
+	if (pci_is_enabled(pdev)) {
+		u32 csts = readl(dev->bar + NVME_REG_CSTS);
+
+		if (dev->ctrl.state == NVME_CTRL_LIVE)
+			nvme_start_freeze(&dev->ctrl);
+		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
+			pdev->error_state  != pci_channel_io_normal);
 	}
 
+	/*
+	 * Give the controller a chance to complete all entered requests if
+	 * doing a safe shutdown.
+	 */
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+	nvme_stop_queues(&dev->ctrl);
+
 	queues = dev->online_queues - 1;
 	for (i = dev->queue_count - 1; i > 0; i--)
 		nvme_suspend_queue(dev->queues[i]);
 
-	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
+	if (dead) {
 		/* A device might become IO incapable very soon during
 		 * probe, before the admin queue is configured. Thus,
 		 * queue_count can be 0 here.
@@ -1704,6 +1717,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+
+	/*
+	 * The driver will not be starting up queues again if shutting down so
+	 * must flush all entered requests to their failed completion to avoid
+	 * deadlocking blk-mq hot-cpu notifier.
+	 */
+	if (shutdown)
+		nvme_start_queues(&dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
@@ -1826,7 +1847,9 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
 		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
 		nvme_dev_add(dev);
+		nvme_unfreeze(&dev->ctrl);
 	}
 
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
-- 
2.5.5

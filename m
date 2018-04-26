Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: pci: simplify timeout handling
Date: Thu, 26 Apr 2018 20:39:55 +0800
Message-Id: <20180426123956.26039-2-ming.lei@redhat.com>
In-Reply-To: <20180426123956.26039-1-ming.lei@redhat.com>
References: <20180426123956.26039-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

When one req is timed out, now nvme_timeout() handles it by the
following way:

	nvme_dev_disable(dev, false);
	nvme_reset_ctrl(&dev->ctrl);
	return BLK_EH_HANDLED.

which may introduces the following issues:

1) the following timeout on other reqs may call nvme_dev_disable()
again, which may quiesce queue again when resetting is in-progress,
then finally nothing can move on.

2) inside resetting, nvme_dev_disable() may be called, but this way
may cause double completion on the previous timed-out request.

3) the timed-out request can't be covered by nvme_dev_disable(), and
this way is too tricky and easy to cause trouble.

This patch fixes these issues by moving timeout handling into one EH
thread, and wakeup this thread for handling timedout request, meantime
return BLK_EH_NOT_HANDLED, so all requests will be handled in the
EH handler.

This patch fixes reports from the horible test of block/011.

Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c |  11 ++++
 drivers/nvme/host/nvme.h |   1 +
 drivers/nvme/host/pci.c  | 134 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df4f71e58ca..f68c653f7fbf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3569,6 +3569,17 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
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
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecfd44f5..08bb297d5f62 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -402,6 +402,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbc71fac6f1e..5d05a04f8e72 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/sed-opal.h>
+#include <linux/kthread.h>
 
 #include "nvme.h"
 
@@ -112,6 +113,11 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+
+	spinlock_t	  eh_lock;
+	wait_queue_head_t eh_wq;
+	bool		eh_in_recovery;
+	struct task_struct    *ehandler;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -1176,6 +1182,80 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 			 csts, result);
 }
 
+static void nvme_eh_schedule(struct nvme_dev *dev)
+{
+	spin_lock(&dev->eh_lock);
+	if (!dev->eh_in_recovery) {
+		dev->eh_in_recovery = true;
+		wake_up_process(dev->ehandler);
+	}
+	spin_unlock(&dev->eh_lock);
+}
+
+static void nvme_eh_done(struct nvme_dev *dev)
+{
+	spin_lock(&dev->eh_lock);
+	if (dev->eh_in_recovery) {
+		dev->eh_in_recovery = false;
+		wake_up(&dev->eh_wq);
+	}
+	spin_unlock(&dev->eh_lock);
+}
+
+static int nvme_error_handler(void *data)
+{
+	struct nvme_dev *dev = data;
+
+	while (true) {
+		/*
+		 * The sequence in kthread_stop() sets the stop flag first
+		 * then wakes the process.  To avoid missed wakeups, the task
+		 * should always be in a non running state before the stop
+		 * flag is checked
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_stop())
+			break;
+
+		spin_lock(&dev->eh_lock);
+		if (!dev->eh_in_recovery) {
+			spin_unlock(&dev->eh_lock);
+			schedule();
+			continue;
+		}
+		spin_unlock(&dev->eh_lock);
+
+		__set_current_state(TASK_RUNNING);
+
+		dev_info(dev->ctrl.device, "start eh recovery\n");
+		nvme_dev_disable(dev, false);
+		nvme_reset_ctrl(&dev->ctrl);
+
+		wait_event(dev->eh_wq, !dev->eh_in_recovery);
+
+		dev_info(dev->ctrl.device, "eh recovery done\n");
+	}
+	__set_current_state(TASK_RUNNING);
+	dev->ehandler = NULL;
+
+	return 0;
+}
+
+static int nvme_eh_init(struct nvme_dev *dev)
+{
+	spin_lock_init(&dev->eh_lock);
+	init_waitqueue_head(&dev->eh_wq);
+
+	dev->ehandler = kthread_run(nvme_error_handler, dev,
+			"nvme_eh_%d", dev->ctrl.instance);
+	if (IS_ERR(dev->ehandler)) {
+		dev_err(dev->ctrl.device, "error handler thread failed to spawn, error = %ld\n",
+			PTR_ERR(dev->ehandler));
+		return PTR_ERR(dev->ehandler);
+	}
+	return 0;
+}
+
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1197,9 +1277,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
-		nvme_reset_ctrl(&dev->ctrl);
-		return BLK_EH_HANDLED;
+		nvme_eh_schedule(dev);
+		return BLK_EH_NOT_HANDLED;
 	}
 
 	/*
@@ -1224,9 +1303,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		return BLK_EH_HANDLED;
+		nvme_eh_schedule(dev);
+		return BLK_EH_NOT_HANDLED;
 	default:
 		break;
 	}
@@ -1240,15 +1319,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
-		nvme_reset_ctrl(&dev->ctrl);
-
 		/*
 		 * Mark the request as handled, since the inline shutdown
 		 * forces all outstanding requests to complete.
 		 */
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		return BLK_EH_HANDLED;
+		nvme_eh_schedule(dev);
+		return BLK_EH_NOT_HANDLED;
 	}
 
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
@@ -2180,6 +2257,22 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+/*
+ * This one is called after queues are quiesced, and no in-fligh timeout
+ * and nvme interrupt handling.
+ */
+static void nvme_pci_cancel_request(struct request *req, void *data,
+		bool reserved)
+{
+	/* make sure timed-out requests are covered too */
+	if (req->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) {
+		req->aborted_gstate = 0;
+		req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
+	}
+
+	nvme_cancel_request(req, data, reserved);
+}
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
@@ -2223,10 +2316,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
 		nvme_suspend_queue(&dev->queues[i]);
 
+	/*
+	 * safe to sync timeout after queues are quiesced, then all
+	 * requests(include the time-out ones) will be canceled.
+	 */
+	nvme_sync_queues(&dev->ctrl);
+	blk_sync_queue(dev->ctrl.admin_q);
+
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_pci_cancel_request, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_pci_cancel_request, &dev->ctrl);
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
@@ -2358,6 +2458,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	nvme_eh_done(dev);
+
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
@@ -2391,6 +2493,9 @@ static void nvme_reset_work(struct work_struct *work)
 
  out:
 	nvme_remove_dead_ctrl(dev, result);
+
+	/* mark EH done even conroller is dead */
+	nvme_eh_done(dev);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
@@ -2532,10 +2637,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	if (nvme_eh_init(dev))
+		goto uninit_ctrl;
+
 	nvme_reset_ctrl(&dev->ctrl);
 
 	return 0;
 
+ uninit_ctrl:
+	nvme_uninit_ctrl(&dev->ctrl);
  release_pools:
 	nvme_release_prp_pools(dev);
  unmap:
@@ -2589,6 +2699,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	if (dev->ehandler)
+		kthread_stop(dev->ehandler);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-- 
2.9.5

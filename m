Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947380AbcJaWDu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 18:03:50 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <scott.bauer@intel.com>
Subject: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
Date: Mon, 31 Oct 2016 15:58:18 -0600
Message-Id: <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch adds a new function unlock_from_suspend which is used
to call into the Opal code to attempt to unlock Locking Ranges,
after a suspend-to-RAM.

The patch also modifies nvme_req_needs_retry to *not* retry
a request that failed due to a NVME_SC_ACCESS_DENIED, which
gets returned if a request is attempting to much with a locked
range. The range won't magically unlock itself without user
interaction so we shouldn't retry the request -- it will fail
again.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 drivers/nvme/host/core.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   4 +-
 drivers/nvme/host/pci.c  |  19 ++++---
 3 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79e679d..1321331 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -28,6 +28,8 @@
 #include <linux/t10-pi.h>
 #include <scsi/sg.h>
 #include <asm/unaligned.h>
+#include <linux/sed.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -1067,6 +1069,137 @@ static const struct pr_ops nvme_pr_ops = {
 	.pr_clear	= nvme_pr_clear,
 };
 
+struct sed_cb_data {
+	sec_cb	*cb;
+	void	*cb_data;
+	struct nvme_command cmd;
+};
+
+static void sec_submit_endio(struct request *req, int error)
+{
+	struct sed_cb_data *sed_data = req->end_io_data;
+
+	if (sed_data->cb)
+		sed_data->cb(error, sed_data->cb_data);
+
+	kfree(sed_data);
+	blk_mq_free_request(req);
+}
+
+static int nvme_insert_rq(struct request_queue *q, struct request *rq,
+			  int at_head, rq_end_io_fn *done)
+{
+	WARN_ON(rq->cmd_type == REQ_TYPE_FS);
+
+	rq->end_io = done;
+
+	if (!q->mq_ops)
+		return -EINVAL;
+
+	blk_mq_insert_request(rq, at_head, true, true);
+
+	return 0;
+}
+
+static int nvme_sec_submit(void *data, u8 opcode, u16 SPSP,
+			   u8 SECP, void *buffer, size_t len,
+			   sec_cb *cb, void *cb_data)
+{
+	struct request_queue *q;
+	struct request *req;
+	struct sed_cb_data *sed_data;
+	struct nvme_ns *ns;
+	struct nvme_command *cmd;
+	int ret;
+
+	ns = data;//bdev->bd_disk->private_data;
+
+	sed_data = kzalloc(sizeof(*sed_data), GFP_NOWAIT);
+	if (!sed_data)
+		return -ENOMEM;
+	sed_data->cb = cb;
+	sed_data->cb_data = cb_data;
+	cmd = &sed_data->cmd;
+
+	cmd->common.opcode = opcode;
+	cmd->common.nsid = ns->ns_id;
+	cmd->common.cdw10[0] = SECP << 24 | SPSP << 8;
+	cmd->common.cdw10[1] = len;
+
+	q = ns->ctrl->admin_q;
+
+	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	if (IS_ERR(req)) {
+		ret = PTR_ERR(req);
+		goto err_free;
+	}
+
+	req->timeout = ADMIN_TIMEOUT;
+	req->special = NULL;
+
+	if (buffer && len) {
+		ret = blk_rq_map_kern(q, req, buffer, len, GFP_NOWAIT);
+		if (ret) {
+			blk_mq_free_request(req);
+			goto err_free;
+		}
+	}
+
+	req->end_io_data = sed_data;
+	//req->rq_disk = bdev->bd_disk;
+
+	return nvme_insert_rq(q, req, 1, sec_submit_endio);
+
+err_free:
+	kfree(sed_data);
+	return ret;
+}
+
+static int nvme_sec_recv(void *data, u16 SPSP, u8 SECP,
+			 void *buffer, size_t len,
+			 sec_cb *cb, void *cb_data)
+{
+	return nvme_sec_submit(data, nvme_admin_security_recv, SPSP, SECP,
+			       buffer, len, cb, cb_data);
+}
+
+static int nvme_sec_send(void *data, u16 SPSP, u8 SECP,
+			 void *buffer, size_t len,
+			 sec_cb *cb, void *cb_data)
+{
+	return nvme_sec_submit(data, nvme_admin_security_send, SPSP, SECP,
+			       buffer, len, cb, cb_data);
+}
+
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+	struct opal_suspend_unlk ulk = { 0 };
+	struct nvme_ns *ns;
+	char diskname[DISK_NAME_LEN];
+       	mutex_lock(&ctrl->namespaces_mutex);
+	if (list_empty(&ctrl->namespaces))
+		goto out_no_namespace;
+	ulk.data = ns =list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+	mutex_unlock(&ctrl->namespaces_mutex);
+	snprintf(diskname, sizeof(diskname), "%sn%d",
+		 dev_name(ctrl->device), ns->instance);
+	ulk.name = diskname;
+
+	ulk.ops.send = nvme_sec_send;
+	ulk.ops.recv = nvme_sec_recv;
+	opal_unlock_from_suspend(&ulk);
+
+	return;
+ out_no_namespace:
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_unlock_from_suspend);
+
+static struct sec_ops nvme_sec_ops = {
+	.send	= nvme_sec_send,
+	.recv	= nvme_sec_recv,
+};
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
@@ -1076,6 +1209,7 @@ static const struct block_device_operations nvme_fops = {
 	.getgeo		= nvme_getgeo,
 	.revalidate_disk= nvme_revalidate_disk,
 	.pr_ops		= &nvme_pr_ops,
+	.sec_ops	= &nvme_sec_ops,
 };
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d47f5a5..ac7e5b1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -240,7 +240,8 @@ static inline int nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 {
-	return !(status & NVME_SC_DNR || blk_noretry_request(req)) &&
+	return !(status & NVME_SC_DNR || status & NVME_SC_ACCESS_DENIED ||
+		 blk_noretry_request(req)) &&
 		(jiffies - req->start_time) < req->timeout &&
 		req->retries < nvme_max_retries;
 }
@@ -259,6 +260,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl);
 
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0248d0e..18fd878 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 
@@ -582,6 +583,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	unsigned map_len;
 	int ret = BLK_MQ_RQ_QUEUE_OK;
+	unsigned long flags;
 
 	/*
 	 * If formated with metadata, require the block layer provide a buffer
@@ -614,18 +616,18 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmnd.common.command_id = req->tag;
 	blk_mq_start_request(req);
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irqsave(&nvmeq->q_lock, flags);
 	if (unlikely(nvmeq->cq_vector < 0)) {
 		if (ns && !test_bit(NVME_NS_DEAD, &ns->flags))
 			ret = BLK_MQ_RQ_QUEUE_BUSY;
 		else
 			ret = BLK_MQ_RQ_QUEUE_ERROR;
-		spin_unlock_irq(&nvmeq->q_lock);
+		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
 		goto out;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
 	nvme_process_cq(nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
 	return BLK_MQ_RQ_QUEUE_OK;
 out:
 	nvme_free_iod(dev, req);
@@ -635,11 +637,11 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 static void nvme_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_dev *dev = iod->nvmeq->dev;
+	struct nvme_queue *nvmeq = iod->nvmeq;
+	struct nvme_dev *dev = nvmeq->dev;
 	int error = 0;
 
 	nvme_unmap_data(dev, req);
-
 	if (unlikely(req->errors)) {
 		if (nvme_req_needs_retry(req, req->errors)) {
 			req->retries++;
@@ -658,7 +660,6 @@ static void nvme_complete_rq(struct request *req)
 			"completing aborted command with status: %04x\n",
 			req->errors);
 	}
-
 	blk_mq_end_request(req, error);
 }
 
@@ -1758,10 +1759,11 @@ static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
 	int result = -ENODEV;
-
+	bool was_suspend = false;
 	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
 		goto out;
 
+	was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	/*
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
@@ -1789,6 +1791,9 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	if (was_suspend)
+		nvme_unlock_from_suspend(&dev->ctrl);
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-- 
2.7.4


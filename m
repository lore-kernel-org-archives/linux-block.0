Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/4] nvme: Implement resume_from_suspend and sed block ioctl
Date: Tue, 29 Nov 2016 14:52:01 -0700
Message-Id: <1480456322-27339-4-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, sagi@grimberg.me, hch@infradead.org,
 Rafael.Antognolli@intel.com, axboe@fb.com, linux-block@vger.kernel.org,
 Scott Bauer <scott.bauer@intel.com>, jonathan.derrick@intel.com,
 j.naumann@fu-berlin.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

This patch implements the necessary logic to unlock a SED
enabled device coming back from an S3.

The patch also implements the ioctl handling from the block
layer.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 drivers/nvme/host/core.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++-
 drivers/nvme/host/pci.c  |  7 ++++-
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79e679d..9a3eb41 100644
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
@@ -778,11 +780,57 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return status;
 }
 
+static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer,
+			   size_t len, bool send)
+{
+	struct request_queue *q;
+	struct request *req;
+	struct nvme_ns *ns;
+	struct nvme_command cmd = { 0 };
+	int ret;
+
+	ns = data;
+
+	if (send)
+		cmd.common.opcode = (u8)nvme_admin_security_send;
+	else
+		cmd.common.opcode = (u8)nvme_admin_security_recv;
+
+	cmd.common.nsid = ns->ns_id;
+	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
+	cmd.common.cdw10[1] = cpu_to_le32(len);
+
+	q = ns->ctrl->admin_q;
+
+	req = nvme_alloc_request(q, &cmd, 0, NVME_QID_ANY);
+	if (IS_ERR(req)) {
+		ret = PTR_ERR(req);
+		return ret;
+	}
+
+	req->timeout = ADMIN_TIMEOUT;
+	req->special = NULL;
+
+	if (buffer && len) {
+		ret = blk_rq_map_kern(q, req, buffer, len, GFP_KERNEL);
+		if (ret)
+			goto out;
+	}
+
+	ret = blk_execute_rq(req->q, ns->disk, req, 1);
+ out:
+	blk_mq_free_request(req);
+	return ret;
+}
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
+	if (is_sed_ioctl(cmd))
+		return blkdev_sed_ioctl(bdev, mode, cmd, arg,
+					ns, nvme_sec_submit);
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
@@ -1067,6 +1115,34 @@ static const struct pr_ops nvme_pr_ops = {
 	.pr_clear	= nvme_pr_clear,
 };
 
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+	struct opal_suspend_unlk ulk = { 0 };
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	if (list_empty(&ctrl->namespaces))
+		goto out_no_namespace;
+
+	ulk.submit_data = ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+	kref_get(&ns->kref);
+
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	ulk.submit_fn = nvme_sec_submit;
+	ulk.dev = disk_devt(ns->disk);
+
+	if (opal_unlock_from_suspend(&ulk))
+		pr_warn("Failed to unlock one or more locking ranges!\n");
+
+	nvme_put_ns(ns);
+	return;
+
+ out_no_namespace:
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_unlock_from_suspend);
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
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
index 5e52034..1a1fc9b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 
@@ -1748,10 +1749,11 @@ static void nvme_reset_work(struct work_struct *work)
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
@@ -1779,6 +1781,9 @@ static void nvme_reset_work(struct work_struct *work)
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

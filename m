Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:55780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbcKPXZS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 18:25:18 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH v1 5/7] nvme: Implement SED Security Operations
Date: Wed, 16 Nov 2016 16:17:30 -0700
Message-Id: <1479338252-8777-6-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch implements the sec_ops functions for sending OPAL
packets to the controller.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 drivers/nvme/host/core.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +-
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79e679d..e8b6804 100644
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
@@ -1067,6 +1069,97 @@ static const struct pr_ops nvme_pr_ops = {
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
+	ns = data;
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
+
+	blk_execute_rq_nowait(q, ns->disk, req, 1, sec_submit_endio);
+	return 0;
+
+err_free:
+	kfree(sed_data);
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
+static struct sec_ops nvme_sec_ops = {
+	.send	= nvme_sec_send,
+	.recv	= nvme_sec_recv,
+};
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
@@ -1076,6 +1169,7 @@ static const struct block_device_operations nvme_fops = {
 	.getgeo		= nvme_getgeo,
 	.revalidate_disk= nvme_revalidate_disk,
 	.pr_ops		= &nvme_pr_ops,
+	.sec_ops	= &nvme_sec_ops,
 };
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d47f5a5..977c631 100644
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
-- 
2.7.4


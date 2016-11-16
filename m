Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:55780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbcKPXZT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 18:25:19 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH v1 6/7] nvme: Implement SED Unlock from suspend
Date: Wed, 16 Nov 2016 16:17:31 -0700
Message-Id: <1479338252-8777-7-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch implements the necessary logic to unlock a drive after a
suspend-to-RAM.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e8b6804..0a2b866 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1155,6 +1155,30 @@ static int nvme_sec_send(void *data, u16 SPSP, u8 SECP,
 			       buffer, len, cb, cb_data);
 }
 
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl)
+{
+	struct opal_suspend_unlk ulk = { 0 };
+	struct nvme_ns *ns;
+	char diskname[DISK_NAME_LEN];
+	mutex_lock(&ctrl->namespaces_mutex);
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
 static struct sec_ops nvme_sec_ops = {
 	.send	= nvme_sec_send,
 	.recv	= nvme_sec_recv,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 977c631..ac7e5b1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -260,6 +260,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
+void nvme_unlock_from_suspend(struct nvme_ctrl *ctrl);
 
 #define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0248d0e..3c29f75 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -43,6 +43,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
+#include <linux/sed-opal.h>
 
 #include "nvme.h"
 
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


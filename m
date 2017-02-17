Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933787AbdBQNAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 08:00:07 -0500
From: Christoph Hellwig <hch@lst.de>
To: scott.bauer@intel.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: Check for Security send/recv support before issuing commands.
Date: Fri, 17 Feb 2017 13:59:40 +0100
Message-Id: <20170217125941.14319-4-hch@lst.de>
In-Reply-To: <20170217125941.14319-1-hch@lst.de>
References: <20170217125941.14319-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Scott Bauer <scott.bauer@intel.com>

We need to verify that the controller supports the security
commands before actually trying to issue them.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
[hch: moved the check so that we don't call into the OPAL code if not
      supported]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/pci.c  | 2 +-
 include/linux/nvme.h     | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8aeb4a623b65..44a1a257e0b5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1285,6 +1285,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5126c4bbee1a..14cfc6f7facb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -140,6 +140,7 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u16 oncs;
 	u16 vid;
+	u16 oacs;
 	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5db8a38a8b43..ddc51adb594d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1789,7 +1789,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if (!dev->ctrl.opal_dev) {
+	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
 		dev->ctrl.opal_dev =
 			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3e2ed49c3ad8..0b676a02cf3e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -244,6 +244,7 @@ enum {
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
+	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 };
 
 struct nvme_lbaf {
-- 
2.11.0

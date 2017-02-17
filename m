Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56811 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933787AbdBQNAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 08:00:10 -0500
From: Christoph Hellwig <hch@lst.de>
To: scott.bauer@intel.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: re-check security protocol support after reset
Date: Fri, 17 Feb 2017 13:59:41 +0100
Message-Id: <20170217125941.14319-5-hch@lst.de>
In-Reply-To: <20170217125941.14319-1-hch@lst.de>
References: <20170217125941.14319-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A device may change capabilities after each reset, e.g. due to a firmware
upgrade.  We should thus check for Security Send/Receive and OPAL support
after each reset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ddc51adb594d..c5986850f88b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1789,7 +1789,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
+	kfree(dev->ctrl.opal_dev);
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
 		dev->ctrl.opal_dev =
 			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
 	}
-- 
2.11.0

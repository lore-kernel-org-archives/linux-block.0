Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58924 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdFTWRj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2017 18:17:39 -0400
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-block@vger.kernel.org>, Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] pci/vmd: Move srcu cleanup after bus/irq domain removal
Date: Tue, 20 Jun 2017 16:13:04 -0600
Message-Id: <1497996784-9177-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Recent __call_srcu changes have exposed that we need to cleanup srcu
structures after pci_stop_root_bus calls into vmd_msi_free.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Cc: <stable@vger.kernel.org> # 4.11
---
 drivers/pci/host/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index e27ad2a..642a182 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -733,10 +733,10 @@ static void vmd_remove(struct pci_dev *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
 	vmd_detach_resources(vmd);
-	vmd_cleanup_srcu(vmd);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
 	pci_remove_root_bus(vmd->bus);
+	vmd_cleanup_srcu(vmd);
 	vmd_teardown_dma_ops(vmd);
 	irq_domain_remove(vmd->irq_domain);
 }
-- 
1.8.3.1

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:45287
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751060AbeDQBzh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 21:55:37 -0400
From: Wei Xu <wxu@cnexlabs.com>
To: linux-nvme@lists.infradead.org
Cc: mb@lightnvm.io, javier@cnexlabs.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Xu <wxu@cnexlabs.com>
Subject: [PATCH] nvme: lightnvm: add granby support
Date: Tue, 17 Apr 2018 09:55:12 +0800
Message-Id: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a new lightnvm quirk to identify CNEX’s Granby controller.

Signed-off-by: Wei Xu <wxu@cnexlabs.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb73bc8..9419e88 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
+		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.7.4

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:11538
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751380AbdBXRRa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 12:17:30 -0500
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 1/2] lightnvm: add generic ocssd detection
Date: Fri, 24 Feb 2017 18:16:48 +0100
Message-ID: <20170224171649.27409-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

More implementations of OCSSDs are becoming available. Adding each using
pci ids are becoming a hassle. Instead, use a 16 byte string in the
vendor-specific area of the identification command to identify an
Open-Channel SSD.

The large string should make the collision probability with other
vendor-specific strings to be near nil.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 4ea9c93..e37b432 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -986,6 +986,9 @@ int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
 	/* XXX: this is poking into PCI structures from generic code! */
 	struct pci_dev *pdev = to_pci_dev(ctrl->dev);
 
+	if (!strncmp((char *)id->vs, "open-channel ssd", 16))
+		return 1;
+
 	/* QEMU NVMe simulator - PCI ID + Vendor specific bit */
 	if (pdev->vendor == PCI_VENDOR_ID_CNEX &&
 				pdev->device == PCI_DEVICE_ID_CNEX_QEMU &&
-- 
2.9.3

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48346 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751922AbdF3X4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 19:56:07 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5UNqWkD028169
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 16:56:06 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2bdx0a0m7x-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 30 Jun 2017 16:56:06 -0700
Received: from facebook.com (2401:db00:2120:20f7:face:0:37:0)   by
 mx-out.facebook.com (10.212.232.63) with ESMTP id
 ad5da76c5def11e7bec30002c992ebde-9b33e6b0 for <linux-block@vger.kernel.org>;
        Fri, 30 Jun 2017 16:56:04 -0700
From: Wei Zhang <wzhang@fb.com>
To: <linux-block@vger.kernel.org>
CC: <kernel-team@fb.com>, <keith.busch@intel.com>
Subject: [PATCH] nvme: remove pci device if no longer present
Date: Fri, 30 Jun 2017 16:56:04 -0700
Message-ID: <20170630235604.880695-1-wzhang@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch removes the PCI device from the kernel's topology tree
if the device is no longer present.

Commit ddf097ec1d44c9648c4738d7cf2819411b44253a (NVMe: Unbind driver on
failure) left the PCI device in the kernel's topology upon device failure.
However, this does not work well for the slot power off/on test cases.
After a slot power off, we need to manually remove the PCI device
before triggering the rescan, in order for the SSD to be rediscovered.

Fixes: ddf097ec1d44c9648c4738d7cf2819411b44253a
Signed-off-by: Wei Zhang <wzhang@fb.com>
Reviewed-by: Jens Axboe <axboe@fb.com>
---
 drivers/nvme/host/pci.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32a98e2..094b22f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2174,8 +2174,19 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	nvme_kill_queues(&dev->ctrl);
-	if (pci_get_drvdata(pdev))
-		device_release_driver(&pdev->dev);
+
+	/*
+	 * Remove the PCI device from the topology tree if the device is no longer
+	 * present.  Without removing, slot power off/on test cannot re-discover
+	 * the SSD.
+	 */
+	if (pci_get_drvdata(pdev)) {
+		if (!pci_device_is_present(pdev)) {
+			pci_stop_and_remove_bus_device_locked(pdev);
+		} else {
+			device_release_driver(&pdev->dev);
+		}
+	}
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-- 
2.9.3

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.150.24]:37484 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754556AbcLPTt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2016 14:49:59 -0500
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6A14360D8F
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2016 12:54:58 -0600 (CST)
From: Stephen Bates <sbates@raithlin.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, axboe@fb.com
Cc: sagi@grimberg.me, james_p_freyensee@linux.intel.com,
        jonathan.derrick@intel.com, Stephen Bates <sbates@raithlin.com>
Subject: [PATCH 1/2] nvme : Use correct scnprintf in cmb show
Date: Fri, 16 Dec 2016 11:54:50 -0700
Message-Id: <1481914491-21456-2-git-send-email-sbates@raithlin.com>
In-Reply-To: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make sure we are using the correct scnprintf in the sysfs show
function for the CMB.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5e52034..be10860 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -50,7 +50,7 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-		
+
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
@@ -1332,7 +1332,7 @@ static ssize_t nvme_cmb_show(struct device *dev,
 {
 	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
 
-	return snprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
+	return scnprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
 		       ndev->cmbloc, ndev->cmbsz);
 }
 static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
-- 
2.1.4


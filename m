Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdFRPWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 11:22:41 -0400
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: [PATCH rfc 24/30] nvme-pci: rename to nvme_pci_configure_admin_queue
Date: Sun, 18 Jun 2017 18:21:58 +0300
Message-Id: <1497799324-19598-25-git-send-email-sagi@grimberg.me>
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

we are going to need the name for the core routine...

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32a98e2740ad..628f1edb0acd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1385,7 +1385,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 	return 0;
 }
 
-static int nvme_configure_admin_queue(struct nvme_dev *dev)
+static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
 	u32 aqa;
@@ -2093,7 +2093,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	result = nvme_configure_admin_queue(dev);
+	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
 		goto out;
 
-- 
2.7.4

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322BFA3740
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiJYOkl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D67F112
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lFXkQpcW6Icmlt3nU6nQbVbgi1E/ki18edYGUI18Kqo=; b=nznETTYJrJRJF5OXvoh23qOfeg
        ui4XriGSHHsmUSNkJAzhR41ZfgGSZaxhEJNT/ttQsAv7xNMGBArFGJRbdvamJCzNL/0P5R5M+SOSu
        lZvDRHE7/X2HNFt9tIvJYgtSULEBxdAR2Ky0+MPjCK1Fb9DTTcSTRP1M5FfTOZscCr2t6MWOPLdVC
        MQSdChJdTlMC5fE6XvoUh/Gb6eM6F+GkB09j5pPMq3techO23aMz83MOa6yqznrS54nZ9hFSCoq/y
        NXTQljTIjovzboeXoByTCMikg0B3hctCLK8yqU4HwucOlfVYU102D1V6RTQ5rzDv6b7fw7i8kr6eN
        NJSSsdlw==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6L-005pm8-AP; Tue, 25 Oct 2022 14:40:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 02/17] nvme-pci: refactor the tagset handling in nvme_reset_work
Date:   Tue, 25 Oct 2022 07:40:05 -0700
Message-Id: <20221025144020.260458-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code to create, update or delete a tagset and namespaces in
nvme_reset_work is a bit convoluted.  Refactor it with a two high-level
conditionals for first probe vs reset and I/O queues vs no I/O queues
to make the code flow more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 31e577b01257d..51513d263d77a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2902,25 +2902,37 @@ static void nvme_reset_work(struct work_struct *work)
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
-
-	/*
-	 * Keep the controller around but remove all namespaces if we don't have
-	 * any working I/O queue.
-	 */
-	if (dev->online_queues < 2) {
-		dev_warn(dev->ctrl.device, "IO queues not created\n");
-		nvme_kill_queues(&dev->ctrl);
-		nvme_remove_namespaces(&dev->ctrl);
-		nvme_free_tagset(dev);
+		
+	if (dev->ctrl.tagset) {
+		/*
+		 * This is a controller reset and we already have a tagset.
+		 * Freeze and update the number of I/O queues as thos might have
+		 * changed.  If there are no I/O queues left after this reset,
+		 * keep the controller around but remove all namespaces.
+		 */
+		if (dev->online_queues > 1) {
+			nvme_start_queues(&dev->ctrl);
+			nvme_wait_freeze(&dev->ctrl);
+			nvme_pci_update_nr_queues(dev);
+			nvme_dbbuf_set(dev);
+			nvme_unfreeze(&dev->ctrl);
+		} else {
+			dev_warn(dev->ctrl.device, "IO queues lost\n");
+			nvme_kill_queues(&dev->ctrl);
+			nvme_remove_namespaces(&dev->ctrl);
+			nvme_free_tagset(dev);
+		}
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		if (!dev->ctrl.tagset)
+		/*
+		 * First probe.  Still allow the controller to show up even if
+		 * there are no namespaces.
+		 */
+		if (dev->online_queues > 1) {
 			nvme_pci_alloc_tag_set(dev);
-		else
-			nvme_pci_update_nr_queues(dev);
-		nvme_dbbuf_set(dev);
-		nvme_unfreeze(&dev->ctrl);
+			nvme_dbbuf_set(dev);
+		} else {
+			dev_warn(dev->ctrl.device, "IO queues not created\n");
+		}
 	}
 
 	/*
-- 
2.30.2


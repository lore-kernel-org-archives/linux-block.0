Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF81C43219
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKAPIE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKAPHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739C1CFEC
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RMeBBtuZ6jN1c2xr45VBpasHrL1bqnzj0i7LLV0DoSY=; b=gVn4z3tLk2y8kIsfYRVJuFq3Cp
        NhHck4o9kuBisUJYWpfDuTm9cOiWA5CrKci7CCkljhWbXhwHxfgs/F/SzXAJ6V7QXcVkrhp6mUNiI
        d+ytgNVdoQT6fafmdt9BLdGHDbf3kwQM/E4fUkBSCbF1Q/d33Ae8NG2gCQGOFeIP6Pv+/7N6IXM7/
        osELVWXILNTGsVxWNb/gSx4Y5jeLQwI3rYs7vGERtW5xLNF2SQE0t5WRsOTEClzTr2X2vNrc/vV4Y
        T29DfXN3V/j5bu/cX5Usl/GzlrqztMIVcDjvQ3NHPsKnnwczaEwICjdK42fR093Q9dq2LYwQZsh43
        9YL2K9+g==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opsl9-005ge8-7t; Tue, 01 Nov 2022 15:00:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 02/14] nvme-pci: refactor the tagset handling in nvme_reset_work
Date:   Tue,  1 Nov 2022 16:00:38 +0100
Message-Id: <20221101150050.3510-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
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
index 5f1d71ac00865..0e8410edb41bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2897,25 +2897,37 @@ static void nvme_reset_work(struct work_struct *work)
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


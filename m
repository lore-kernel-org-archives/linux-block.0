Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C939C04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiJYOkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A579939
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=G18MsieJsOrNp1Fytemcz8cUlIxG4bfMDX9pF8+dvVo=; b=I0oNoQchr8OMWqTbPCFlR19eRZ
        D86fYr+lG9VDWXV/Ft3AtR3YpUBc4RCizW3l2MLiBza2B8HlQ6+5K6h+tiJ3Wr0690xGCKKudT2Vr
        ZzpaWI463I6QPa6ZIR/fSIZHLP8y+yzRGp3V3WMRCC46cucb0+dgrXDt5JYKjr/dCf6vFc27ykuvv
        3PuI4palPQ9HwHrbcm+g3aunFZ98iKFQbdmyYFlfKhVSMx/o7vefV5uRYk43i2748wc0I/VvdICJA
        c64hrDxdpundUgg6NMCYYRSaxnH/0PqK1Ctw1tbm3eC1+x2lJVcm/zcCZte7JTeIDhzEaclnBaKht
        22xGTD4A==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6N-005pnf-IP; Tue, 25 Oct 2022 14:40:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in nvme_remove
Date:   Tue, 25 Oct 2022 07:40:13 -0700
Message-Id: <20221025144020.260458-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we have a non-present controller there is no reason to wait in
marking the namespaces dead, so do it ASAP.  Also remove the superflous
call to nvme_start_queues as nvme_dev_disable already did that for us.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ab54857cfd50..bef98f6e1396c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	pci_set_drvdata(pdev, NULL);
 
+	/*
+	 * Mark the namespaces dead as we can't flush the data, and disable the
+	 * controller ASAP as we can't shut it down properly if it was surprise
+	 * removed.
+	 */
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+		nvme_mark_namespaces_dead(&dev->ctrl);
 		nvme_dev_disable(dev, true);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
-
-	/*
-	 * The dead states indicates the controller was not gracefully
-	 * disconnected. In that case, we won't be able to flush any data while
-	 * removing the namespaces' disks; fail all the queues now to avoid
-	 * potentially having to clean up the failed sync later.
-	 */
-	if (dev->ctrl.state == NVME_CTRL_DEAD) {
-		nvme_mark_namespaces_dead(&dev->ctrl);
-		nvme_start_queues(&dev->ctrl);
-	}
-
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_remove_attrs(dev);
-- 
2.30.2


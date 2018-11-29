Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8129DC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF69213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVmxybuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF69213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeK3GUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeK3GUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6qSxV15VEaVIfggvbTtNHmhq2+qVvluiNMxzn9Zd65o=; b=TVmxybuwxq5I9Yl+gIVEGemGwH
        3xNIaZ2D0iK131Z8HXSn+BG2vzbr1ZyuDBJr7Oh2p8ze4PdtowbH5sYaorgYtF3S+QwhPqD2u7Vaq
        JgaRkNp/AqJa3eRBVsUP88lzugaHJwqlzrNM94XNr64KJQptNzS/8G5SHjGtkmK/ewC6L4MTd5t33
        Vk5i0rQza27zl2/bPF5YCSpKFmkjvUvb1TkyVe3KduPzcydqx823pTJCZPzvbXMKicqlcWOq8W7Sx
        jN5aJUs30uEaF09sBm06wfPM9vWfldz3It4ZJC5THnUZI32WMzEJZGNMD4kssekb8wB7N62L1KgAZ
        cW7pDosA==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRkb-0003fE-1c; Thu, 29 Nov 2018 19:13:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
Date:   Thu, 29 Nov 2018 20:12:59 +0100
Message-Id: <20181129191310.9795-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This gets rid of all the messing with cq_vector and the ->polled field
by using an atomic bitop to mark the queue enabled or not.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 43 ++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a1bb4bb92e7f..022395a319f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -201,7 +201,8 @@ struct nvme_queue {
 	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
-	u8 polled;
+	unsigned long flags;
+#define NVMEQ_ENABLED		0
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -927,7 +928,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
 	 */
-	if (unlikely(nvmeq->cq_vector < 0 && !nvmeq->polled))
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
 	ret = nvme_setup_cmd(ns, req, &cmnd);
@@ -1395,31 +1396,19 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
  */
 static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
-	int vector;
-
-	spin_lock_irq(&nvmeq->cq_lock);
-	if (nvmeq->cq_vector == -1 && !nvmeq->polled) {
-		spin_unlock_irq(&nvmeq->cq_lock);
+	if (!test_and_clear_bit(NVMEQ_ENABLED, &nvmeq->flags))
 		return 1;
-	}
-	vector = nvmeq->cq_vector;
-	nvmeq->dev->online_queues--;
-	nvmeq->cq_vector = -1;
-	nvmeq->polled = false;
-	spin_unlock_irq(&nvmeq->cq_lock);
 
-	/*
-	 * Ensure that nvme_queue_rq() sees it ->cq_vector == -1 without
-	 * having to grab the lock.
-	 */
+	/* ensure that nvme_queue_rq() sees NVMEQ_ENABLED cleared */
 	mb();
 
+	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
-
-	if (vector != -1)
-		pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
-
+	if (nvmeq->cq_vector == -1)
+		return 0;
+	pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
+	nvmeq->cq_vector = -1;
 	return 0;
 }
 
@@ -1578,13 +1567,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	else if (result)
 		goto release_cq;
 
-	/*
-	 * Set cq_vector after alloc cq/sq, otherwise nvme_suspend_queue will
-	 * invoke free_irq for it and cause a 'Trying to free already-free IRQ
-	 * xxx' warning if the create CQ/SQ command times out.
-	 */
 	nvmeq->cq_vector = vector;
-	nvmeq->polled = polled;
 	nvme_init_queue(nvmeq, qid);
 
 	if (vector != -1) {
@@ -1593,11 +1576,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 			goto release_sq;
 	}
 
+	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
 	return result;
 
 release_sq:
 	nvmeq->cq_vector = -1;
-	nvmeq->polled = false;
 	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
 release_cq:
@@ -1751,6 +1734,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 	}
 
+	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
 	return result;
 }
 
@@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	if (nr_io_queues == 0)
 		return 0;
+	
+	clear_bit(NVMEQ_ENABLED, &adminq->flags);
 
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
@@ -2227,6 +2213,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		adminq->cq_vector = -1;
 		return result;
 	}
+	set_bit(NVMEQ_ENABLED, &adminq->flags);
 	return nvme_create_io_queues(dev);
 }
 
-- 
2.19.1


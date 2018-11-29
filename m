Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEC7C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216F21104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SqgFtio9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E216F21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeK3GUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeK3GUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lCfDOqmQ1jDiWTny7yuKbTsbrn8yNPEn4By9WWfMTRk=; b=SqgFtio9KBqUXi5DHUQ/oIjwt1
        SQ2gTh4Z1ibXH3o4RLI3U7gMVv5D+quVqWaFSPGGSPRG4eDwKSdS5oHAcq3ziYkthosQp14X/zWXj
        zR5ZksL1YbPj/p5IoRN5o1TyZ2wCt22ZMWOFCjBsI4fKVQTtTowjV7kntT3LAdDe0Nh2tftUy8aGd
        BzmfmJXrpNvKMNM9pQggA2tBZj95qLofOCv69m3mq43h0NsPrJx0UzN9VRFBGcNk1kBpzeAFvFJc7
        mYIjmAoArRUp3hRQ/Cg4ywJj3jNydaUQfUOr993CZaog9gnAARhazs/+M/wbkNPiqDIQd4UJViipP
        FJZgr3Bw==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRkr-0003kh-UQ; Thu, 29 Nov 2018 19:13:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt driven queues
Date:   Thu, 29 Nov 2018 20:13:05 +0100
Message-Id: <20181129191310.9795-9-hch@lst.de>
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

Now that we can't poll regular, interrupt driven I/O queues there
is almost nothing that can race with an interrupt.  The only
possible other contexts polling a CQ are the error handler and
queue shutdown, and both are so far off in the slow path that
we can simply use the big hammer of disabling interrupts.

With that we can stop taking the cq_lock for normal queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb8db7d8170a..d43925fba560 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -186,7 +186,8 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
-	spinlock_t cq_lock ____cacheline_aligned_in_smp;
+	 /* only used for poll queues: */
+	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
@@ -1050,12 +1051,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	u16 start, end;
 
-	spin_lock(&nvmeq->cq_lock);
+	/*
+	 * The rmb/wmb pair ensures we see all updates from a previous run of
+	 * the irq handler, even if that was on another CPU.
+	 */
+	rmb();
 	if (nvmeq->cq_head != nvmeq->last_cq_head)
 		ret = IRQ_HANDLED;
 	nvme_process_cq(nvmeq, &start, &end, -1);
 	nvmeq->last_cq_head = nvmeq->cq_head;
-	spin_unlock(&nvmeq->cq_lock);
+	wmb();
 
 	if (start != end) {
 		nvme_complete_cqes(nvmeq, start, end);
@@ -1079,13 +1084,24 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  */
 static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	unsigned long flags;
+	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	u16 start, end;
 	int found;
 
-	spin_lock_irqsave(&nvmeq->cq_lock, flags);
+	/*
+	 * For a poll queue we need to protect against the polling thread
+	 * using the CQ lock.  For normal interrupt driven threads we have
+	 * to disable the interrupt to avoid racing with it.
+	 */
+	if (nvmeq->cq_vector == -1)
+		spin_lock(&nvmeq->cq_poll_lock);
+	else
+		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
+	if (nvmeq->cq_vector == -1)
+		spin_unlock(&nvmeq->cq_poll_lock);
+	else
+		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1100,9 +1116,9 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock(&nvmeq->cq_lock);
+	spin_lock(&nvmeq->cq_poll_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, -1);
-	spin_unlock(&nvmeq->cq_lock);
+	spin_unlock(&nvmeq->cq_poll_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1482,7 +1498,7 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
-	spin_lock_init(&nvmeq->cq_lock);
+	spin_lock_init(&nvmeq->cq_poll_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1518,7 +1534,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
@@ -1527,7 +1542,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
-	spin_unlock_irq(&nvmeq->cq_lock);
+	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
-- 
2.19.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E09610E8
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 07:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhJNH5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJNH5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 03:57:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0F7C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1eDxRyizmYxYP3cRkJGONUpaE7b5mnk3w8krVfxL3VQ=; b=Wr2WsfCvJG0IFShlVHN3NnB2tJ
        f1QK+4ILax5mKdTLxv/3AtJTHrg9XQX1lm2bPaJaBLqJMIXnoY1mqubZZSuQRZm2WL/GiVbKy/56T
        /khJasSKP7fabXYzqt7vlZOAjiDrbYdj7CzWqk6TUQ2YyXXP0Zq2GK/QUyyAVZi0jM4OgyJqHOiRw
        b27s8WaC54LdnKhZmxKuNfjLcEPezww6QUxX6uNBWDO7pjiMRa8NC0o53YStN3BfzVOOyl6gXD7w8
        aBw0qI4vpa+tmcfSWRoVXR2HHJH5RnjkNqUgEpbieendjbreH/EJ+W7nMQJ63X3t1zacqW/rKiiBS
        TUK1ZozA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mavYZ-0089sX-Fc; Thu, 14 Oct 2021 07:54:15 +0000
Date:   Thu, 14 Oct 2021 08:53:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: wire up completion batching for the IRQ path
Message-ID: <YWfiA96OpkT4Oomp@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-10-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165416.985696-10-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Couldn't we do something like the incremental patch below to avoid
duplicating the CQ processing? With that this patch could probably go
away entirely and we could fold the change into the other nvme patch.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 061f0b1cb0ec3..ce69e9666caac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1059,9 +1059,8 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline int nvme_process_cq(struct nvme_queue *nvmeq)
+static inline int nvme_poll_cq(struct nvme_queue *nvmeq, struct io_batch *iob)
 {
-	DEFINE_IO_BATCH(iob);
 	int found = 0;
 
 	while (nvme_cqe_pending(nvmeq)) {
@@ -1071,15 +1070,23 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 		 * the cqe requires a full read memory barrier
 		 */
 		dma_rmb();
-		nvme_handle_cqe(nvmeq, &iob, nvmeq->cq_head);
+		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
 
-	if (found) {
-		if (iob.req_list)
-			nvme_pci_complete_batch(&iob);
+	if (found)
 		nvme_ring_cq_doorbell(nvmeq);
-	}
+	return found;
+}
+
+static inline int nvme_process_cq(struct nvme_queue *nvmeq)
+{
+	DEFINE_IO_BATCH(iob);
+	int found;
+
+	found = nvme_poll_cq(nvmeq, &iob);
+	if (iob.req_list)
+		nvme_pci_complete_batch(&iob);
 	return found;
 }
 
@@ -1116,27 +1123,6 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
-static inline int nvme_poll_cq(struct nvme_queue *nvmeq, struct io_batch *iob)
-{
-	int found = 0;
-
-	while (nvme_cqe_pending(nvmeq)) {
-		found++;
-		/*
-		 * load-load control dependency between phase and the rest of
-		 * the cqe requires a full read memory barrier
-		 */
-		dma_rmb();
-		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
-		nvme_update_cq_head(nvmeq);
-	}
-
-	if (found)
-		nvme_ring_cq_doorbell(nvmeq);
-	return found;
-}
-
-
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;

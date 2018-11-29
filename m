Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA58C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F95213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFsltPst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F95213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeK3GUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3GUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DTX2tXXuyg8Oh1Pn2cg1PiVkACUyu9wKtwo8xbh33MU=; b=YFsltPst5mQ7a1Ng5Jcqzl+7OE
        v5gc1vrZH+uYVrl7KHYZrnU0RA69eL0YTDnD0esQywEkHQQpm0+Cv8oKy9vnTKl0Q53OYsPL4TbnX
        LgCOZ//YVazbp1J6z2zy/v0+pscGTHGbakjz3j50VZ8X0xG9oTENLS3wMGij92aoALUvd2RbEDACc
        +kKUukd+KUp5O9CdDw8pUPepwygFwCajh8OzxWRqWT9CKE8rA5uZhw0rxrYYqRzNtS9Q+ifAuOXrU
        S1Mdly0q5Zdo44wf14enCenRoXvcxV8UQe7Gqeg8ln/xEusqCHbzKFQuuNvYGta5yAv6OA/BoJtZ0
        /d/1Dgyw==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRko-0003hJ-Uj; Thu, 29 Nov 2018 19:13:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when deleting queues
Date:   Thu, 29 Nov 2018 20:13:04 +0100
Message-Id: <20181129191310.9795-8-hch@lst.de>
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

This is the last place outside of nvme_irq that handles CQEs from
interrupt context, and thus is in the way of removing the cq_lock for
normal queues, and avoiding lockdep warnings on the poll queues, for
which we already take it without IRQ disabling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9ceba9900ca3..fb8db7d8170a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -203,6 +203,7 @@ struct nvme_queue {
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
+#define NVMEQ_DELETE_ERROR	2
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -2216,7 +2217,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 	struct nvme_queue *nvmeq = req->end_io_data;
 
 	if (!error)
-		nvme_poll_irqdisable(nvmeq, -1);
+		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
 	nvme_del_queue_end(req, error);
 }
@@ -2258,11 +2259,20 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 		nr_queues--;
 		sent++;
 	}
-	while (sent--) {
+	while (sent) {
+		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
+
 		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
 				timeout);
 		if (timeout == 0)
 			return false;
+
+		/* handle any remaining CQEs */
+		if (opcode == nvme_admin_delete_cq &&
+		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
+			nvme_poll_irqdisable(nvmeq, -1);
+
+		sent--;
 		if (nr_queues)
 			goto retry;
 	}
-- 
2.19.1


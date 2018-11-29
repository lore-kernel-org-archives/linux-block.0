Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C15BC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DF921104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ORnST+Bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DF921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeK3GUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeK3GUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PEIzcJpy3wmcq5f+eYMjlUOuE0CnlWkpzgmtT8oDRiY=; b=ORnST+Bd8wncTLNGufeN68AhJ4
        +wVyUWG6P9ZunCaVwAL3ikq1jk4K2y2BmCrH+EqAsFcLQk8l/rDQtxwQhsOBChJtYSd1FP4q5fA+5
        wEIH4BgXtMMwB8D29GUjYTDmXL52tXPBGUDALjJ6HPY39sbL26tNbEFkAH6BmCeqR712cTaFSo7VB
        /jXMwLAb6/VCq6COl22wcaO/c/usOMlYDmWjf8eKmRNAlJeN57Jx1D7+gbdXlnhr4xkOV/f0EX20i
        fUfXZDdx/YfcSdW0eQthrnywas2ks04NdKSZXOXKe5rv1dmDOnfGYFyCThLPh/nQWBA1ngZXHJtzm
        Bc67iTqQ==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRkg-0003fp-F7; Thu, 29 Nov 2018 19:13:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 04/13] nvme-pci: only allow polling with separate poll queues
Date:   Thu, 29 Nov 2018 20:13:01 +0100
Message-Id: <20181129191310.9795-5-hch@lst.de>
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

This will allow us to simplify both the regular NVMe interrupt handler
and the upcoming aio poll code.  In addition to that the separate
queues are generally a good idea for performance reasons.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b820dd0351cb..d42bb76e5e78 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1089,13 +1089,6 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx)
-{
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
-	return __nvme_poll(nvmeq, -1);
-}
-
-static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	u16 start, end;
@@ -1605,12 +1598,11 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	NVME_SHARED_MQ_OPS,
-	.poll			= nvme_poll,
 };
 
-static const struct blk_mq_ops nvme_mq_poll_noirq_ops = {
+static const struct blk_mq_ops nvme_mq_poll_ops = {
 	NVME_SHARED_MQ_OPS,
-	.poll			= nvme_poll_noirq,
+	.poll			= nvme_poll,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -2298,10 +2290,10 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		if (!dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.ops = &nvme_mq_ops;
+		if (dev->io_queues[HCTX_TYPE_POLL])
+			dev->tagset.ops = &nvme_mq_poll_ops;
 		else
-			dev->tagset.ops = &nvme_mq_poll_noirq_ops;
+			dev->tagset.ops = &nvme_mq_ops;
 
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = HCTX_MAX_TYPES;
-- 
2.19.1


Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2AC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C5213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOjLfWnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924C5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeK3GUb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeK3GUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dD5o0GTVmZSDtjcU9Ok3nDAm417JPyuLUQcM4U5TOXE=; b=KOjLfWnUPKUC6bySOc7GIopLt9
        r1fXk070QOLmz4GOGl32LcR8RbBajL2C5whtzIwTPcd67MWDswvO86pPYlbzj2Lthu/zu5+vn7y/n
        deQqFy2+TzKTJKgzq02VFrHoZMsKKnF6v+6nMmNx5nPnyHQX12s9F2Xwso9MWRpslfWFRRiy4lND+
        apV2Q0qV0bpO3FaB/+T/aTd4dgNImAD2aZf0gvYYZFZChrmH2WrPUb88NORMYFRK8e+1CWXrmEx9c
        8rraAQGMhJzqFKOEApbel0MMuSOg+0k+AXGEtOLOTnA3NBY7VyiDQ+vIJfR0xVT3/otN+YoGegHs0
        6Jy+pSHw==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRl3-0003zN-PU; Thu, 29 Nov 2018 19:13:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 12/13] block: only allow polling if a poll queue_map exists
Date:   Thu, 29 Nov 2018 20:13:09 +0100
Message-Id: <20181129191310.9795-13-hch@lst.de>
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

This avoids having to have differnet mq_ops for different setups
with or without poll queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c       |  2 +-
 drivers/nvme/host/pci.c | 29 +++++++++--------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9f0cb370b39b..bb7c642ffefa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -402,7 +402,7 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->mq_ops || !q->mq_ops->poll)
+	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL)
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d43925fba560..3ecc0bf75a62 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1600,22 +1600,15 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.timeout	= nvme_timeout,
 };
 
-#define NVME_SHARED_MQ_OPS					\
-	.queue_rq		= nvme_queue_rq,		\
-	.commit_rqs		= nvme_commit_rqs,		\
-	.complete		= nvme_pci_complete_rq,		\
-	.init_hctx		= nvme_init_hctx,		\
-	.init_request		= nvme_init_request,		\
-	.map_queues		= nvme_pci_map_queues,		\
-	.timeout		= nvme_timeout			\
-
 static const struct blk_mq_ops nvme_mq_ops = {
-	NVME_SHARED_MQ_OPS,
-};
-
-static const struct blk_mq_ops nvme_mq_poll_ops = {
-	NVME_SHARED_MQ_OPS,
-	.poll			= nvme_poll,
+	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_pci_complete_rq,
+	.commit_rqs	= nvme_commit_rqs,
+	.init_hctx	= nvme_init_hctx,
+	.init_request	= nvme_init_request,
+	.map_queues	= nvme_pci_map_queues,
+	.timeout	= nvme_timeout,
+	.poll		= nvme_poll,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -2302,11 +2295,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		if (dev->io_queues[HCTX_TYPE_POLL])
-			dev->tagset.ops = &nvme_mq_poll_ops;
-		else
-			dev->tagset.ops = &nvme_mq_ops;
-
+		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-- 
2.19.1


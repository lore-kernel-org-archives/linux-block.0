Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3218C64EB4
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9981520851
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fokhhk03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9981520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbeLBQsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:48:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbeLBQsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 11:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dNADhd9xviHVkkwk7j5mLOQq+L79o9RgisN5N2dYn0k=; b=Fokhhk03T2oYskblzKSDhwvWrE
        ueCSMzMLGTJ0emEFESvznMM4xPUjTi8jl8IKIBISRE96plfY0YZnygJu0rrrKSqqa2/q2sYEMtvBg
        h/dIp7binWQvRBuC6K7RRJQWz1JdO7IUe3uAFxzjTmL/5Zvp28SR/76E+QQli0BzmwfhTdSOOZCQO
        U2GqV0BLk0kygV5xjBD2ZWcHjRigtbZCRZL7SZfl4GEAdvILu8FxoOT3uxjeZz6NdcQGDAr+YgpGG
        GoxuVSPn8Gie9hNfTpJiYKLOFdGE1CWh0HavtE6MvXjGytWRTP+lGDMvfJZjQjvAQhvSZ+WsCPlyk
        oRUNjF7A==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTUua-0002WW-Kc; Sun, 02 Dec 2018 16:48:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 09/13] nvme-rdma: remove I/O polling support
Date:   Sun,  2 Dec 2018 17:46:24 +0100
Message-Id: <20181202164628.1116-10-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181202164628.1116-1-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code was always a bit of a hack that digs far too much into
RDMA core internals.  Lets kick it out and reimplement proper
dedicated poll queues as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ccfde6c7c0a5..a62e9f177c06 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1736,29 +1736,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
-static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
-{
-	struct nvme_rdma_queue *queue = hctx->driver_data;
-	struct ib_cq *cq = queue->ib_cq;
-	struct ib_wc wc;
-	int found = 0;
-
-	while (ib_poll_cq(cq, 1, &wc) > 0) {
-		struct ib_cqe *cqe = wc.wr_cqe;
-
-		if (cqe) {
-			if (cqe->done == nvme_rdma_recv_done) {
-				nvme_rdma_recv_done(cq, &wc);
-				found++;
-			} else {
-				cqe->done(cq, &wc);
-			}
-		}
-	}
-
-	return found;
-}
-
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1780,7 +1757,6 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.init_request	= nvme_rdma_init_request,
 	.exit_request	= nvme_rdma_exit_request,
 	.init_hctx	= nvme_rdma_init_hctx,
-	.poll		= nvme_rdma_poll,
 	.timeout	= nvme_rdma_timeout,
 	.map_queues	= nvme_rdma_map_queues,
 };
-- 
2.19.1


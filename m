Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951B6CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574EA20769
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g6E2Fboj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgEMLEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgEMLEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:04:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C839C061A0F
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T1vYHMISEymqF8VzlhDBb4Ep+RFiSx2oPHPEtm8laRg=; b=g6E2FbojSGzwnUFSTg1I6TKgjS
        cUeYrapGWGm+mnceJC2CXiUYaZ3rTB9zGkZ/sKfIpN3J1zCuukQq7picReLrCvUF7ynn56i8fowln
        +Z0PVxm/3j80dHQEcCFb5CVvhETyh+v5z+aS0JaBAKsGUDTLKbn4nA/z9Fm63xVboazLgRaeH39rB
        JNQ2i7cLb6U3ghbiilXxLo22Ib2IsT5rBzbunLuz8EvtERmqSRNmBtA7XBtI4Iy8tDLjO7t2BThqe
        qy8tEXqpTvHDuDZw7IIuaBZHgyShvPbeh/vuqnvNG29Vok/txIfy9e5/ADEPVHccBu77WWxbKzdfH
        GnN6hQTg==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpBd-0006iz-TW; Wed, 13 May 2020 11:04:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: remove a pointless queue enter pair in blk_mq_alloc_request_hctx
Date:   Wed, 13 May 2020 13:04:18 +0200
Message-Id: <20200513110419.2362556-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513110419.2362556-1-hch@lst.de>
References: <20200513110419.2362556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need for two queue references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a3491c1397501..81b7af7be70b5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -445,24 +445,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
+	ret = -EXDEV;
 	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
-		blk_queue_exit(q);
-		return ERR_PTR(-EXDEV);
-	}
+	if (!blk_mq_hw_queue_mapped(alloc_data.hctx))
+		goto out_queue_exit;
 	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	blk_queue_enter_live(q);
+	ret = -EWOULDBLOCK;
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
-	if (!rq) {
-		blk_queue_exit(q);
-		return ERR_PTR(-EWOULDBLOCK);
-	}
+	if (!rq)
+		goto out_queue_exit;
 
 	return rq;
+out_queue_exit:
+	blk_queue_exit(q);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-- 
2.26.2


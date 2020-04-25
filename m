Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C0C54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C073E20700
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="srieIhwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgDYRKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:10:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FAC09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/bNuAnFkJnnrwHqkCrVpP2VvUTaxGsnyx6Cr+FSu6DM=; b=srieIhwr30CnL4W1xhJcVMMZVp
        x5zw7LdCfmo0GAwtSy/en/vfNx2iwHPMQY90pTv0jSGffLAQ2iHq4iMf77NqmX68mEj70DDd6Bx0a
        CxG4d+c+j2oelERgqQFCXME5mS4FZqp7hZLuA6gZATqNh3H8dd+BzikXoAW+S3MFnlgR2gwH1P+4L
        Ovqe5Hc86a4HUpzZ+wQVCOA8XVJgnlPbp48I3TDyafTfmq22LfVTPHDyFkNajChStWbzwNDimrvCz
        TCzaaDHBb52sucHYbcIs9SfB6+syKP8bOQylTO7s4f+6jXaYCq3jeVjE0o+cn0dO35Av6zr806mf6
        G6bAuhzg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJg-0003z2-Bt; Sat, 25 Apr 2020 17:10:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 10/11] block: remove a pointless queue enter pair in blk_mq_alloc_request_hctx
Date:   Sat, 25 Apr 2020 19:09:43 +0200
Message-Id: <20200425170944.968861-11-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
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
index fc1df2a5969a0..6375ed55cdfa7 100644
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
2.26.1


Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37AC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B0120767
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUYD3RLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgEPPel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgEPPek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:34:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF0C061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sagZo/dzXd5EFZZxgynNukeup1OsrElwTFyOdchzgMU=; b=aUYD3RLwSNONW2IAmWroV6siJ8
        KNwk/hPWiLun1qfLcSn+EqVJB1MhZ+cYzJBQRnF0d9DtWfC9ztLeSCGu5kSfZVbMCs483MX3e0Di5
        Vrr80Vq/UiXkt95Yadm4Kz2HtcCmVubyLgloKbVvOXXEFvtMUvxEC4//vWufUMBeW1iYnKI1br8JC
        pnDDG3Gbq9YH2hFnimnNamaOAyYxQBdrpatf0OE0q1FoyrbRFK9YHk9aBN1pNy+ld1MIlyp23T4zB
        3Z9w+40tZG9kZkteRMsVI8NgkcLjBRSN38EJh3w3mS1FExD/pAqSLsiJ4ZykXR0HXV9WuoEcXx77a
        8XblHwUQ==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZypk-00051S-Bv; Sat, 16 May 2020 15:34:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/4] blk-mq: remove a pointless queue enter pair in blk_mq_alloc_request_hctx
Date:   Sat, 16 May 2020 17:34:29 +0200
Message-Id: <20200516153430.294324-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516153430.294324-1-hch@lst.de>
References: <20200516153430.294324-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need for two queue references.  Also reduce the q_usage_counter
critical section to just the actual request allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d96d3931f33e6..69e58cc4244c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -439,26 +439,20 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (hctx_idx >= q->nr_hw_queues)
 		return ERR_PTR(-EIO);
 
-	ret = blk_queue_enter(q, flags);
-	if (ret)
-		return ERR_PTR(ret);
-
 	/*
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
 	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
-		blk_queue_exit(q);
+	if (!blk_mq_hw_queue_mapped(alloc_data.hctx))
 		return ERR_PTR(-EXDEV);
-	}
 	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	blk_queue_enter_live(q);
+	ret = blk_queue_enter(q, flags);
+	if (ret)
+		return ERR_PTR(ret);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
 	if (!rq) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
-- 
2.26.2


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC06C77B75
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 06:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjDLGiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDLGh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 02:37:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52B5B8E
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4+jC496WGaXp+r9NRdzpXwuQGAeApCgH661SvYpOTPM=; b=Xvh/gU8tijFoN5Y3II4k78dgON
        qPBK90PacBHXsOgXWiPBb6wlv6K8WF5v2eqUVdlurk6s3om+RTvzQuf1dVWZzryP4Yk0heqjMxB7a
        vs+547jvyMk5ihIjjSqtendHrIQSlHuFb3SA+v18i3M0yB0SOivZjZ2mikTdRVuexgm1rAll8mxwX
        IyncGnNVZvMFAavq562WdLtNYc6a8QclrpDx0XtEQnDse9QgJ0wM9PP4EagU2WA5fV6A+V8I8X3Wg
        D/BQg7+wo9DgxlAI52qO3qyWQmFXKkPAkEG8en8DEO4tbGPQD0HNcWEnlkOKLSxlorQUyZkUBOgvD
        d+RaoVEQ==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmU71-001z7E-0f;
        Wed, 12 Apr 2023 06:37:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: call blk_mq_hctx_stopped in __blk_mq_run_hw_queue
Date:   Wed, 12 Apr 2023 08:37:42 +0200
Message-Id: <20230412063743.618957-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of calling blk_mq_hctx_stopped in both callers, move it right
next to the dispatching.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 03c6fa4afcdb91..cdf1d5ca04bba2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2150,6 +2150,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	WARN_ON_ONCE(in_interrupt());
 
+	if (blk_mq_hctx_stopped(hctx))
+		return;
 	blk_mq_run_dispatch_ops(hctx->queue,
 			blk_mq_sched_dispatch_requests(hctx));
 }
@@ -2221,9 +2223,6 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
-	if (unlikely(blk_mq_hctx_stopped(hctx)))
-		return;
-
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
@@ -2231,6 +2230,8 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		}
 	}
 
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
@@ -2439,15 +2440,8 @@ EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
 
 static void blk_mq_run_work_fn(struct work_struct *work)
 {
-	struct blk_mq_hw_ctx *hctx;
-
-	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
-
-	/*
-	 * If we are stopped, don't run the queue.
-	 */
-	if (blk_mq_hctx_stopped(hctx))
-		return;
+	struct blk_mq_hw_ctx *hctx =
+		container_of(work, struct blk_mq_hw_ctx, run_work.work);
 
 	__blk_mq_run_hw_queue(hctx);
 }
-- 
2.39.2


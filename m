Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10932C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 12:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbhLWMhy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 07:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLWMhy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 07:37:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F37C061756
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IauANIHbGwlRZqDk0f3+k3UtC4XemScdfsSDAhiiU0A=; b=uE/XGtHQ9S1yQF17rfwwPDS/MG
        zeTUI1Ss671S8vAeZlYi8N4X5FE8+/12w9ZZul9jY6ojAka7ttbdI8820CacBMj4xwrTepj745m9+
        LAnwgOVyjBki5s50ANLuNmFEPyi5n6NwGI87UgKQ4yj/6/wktOFVKoLk7pfqDayxcyCpZXlEMw72X
        Ah+PcCKKuq3yR5Yu741PkK4DGsoq2zTZKOZLsSDxI626llhrxcx5tlYzSa1J/7hHUKdmMRG+/ycst
        +vDOF+Vvvtv11cAJRKNjwgwH35LzrBg7pZC4N+dZ8PzWXH3MAD7eOjIimEsdO346ABrzT8CH3besM
        0ImoGcEA==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0NM1-00CiIi-8G; Thu, 23 Dec 2021 12:37:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: remove __blk_mq_delay_run_hw_queue
Date:   Thu, 23 Dec 2021 13:37:49 +0100
Message-Id: <20211223123750.1222349-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Open code the relevant parts of __blk_mq_delay_run_hw_queue in the two
callers instead of the convoluted shared helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 51 +++++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d7c9d3e03293..565a0e6897b8f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2025,46 +2025,19 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 }
 
 /**
- * __blk_mq_delay_run_hw_queue - Run (or schedule to run) a hardware queue.
+ * blk_mq_delay_run_hw_queue - Run a hardware queue asynchronously.
  * @hctx: Pointer to the hardware queue to run.
- * @async: If we want to run the queue asynchronously.
  * @msecs: Milliseconds of delay to wait before running the queue.
  *
- * If !@async, try to run the queue now. Else, run the queue asynchronously and
- * with a delay of @msecs.
+ * Run a hardware queue asynchronously with a delay of @msecs.
  */
-static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
-					unsigned long msecs)
+void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
-
-	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		int cpu = get_cpu();
-		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
-			__blk_mq_run_hw_queue(hctx);
-			put_cpu();
-			return;
-		}
-
-		put_cpu();
-	}
-
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
-
-/**
- * blk_mq_delay_run_hw_queue - Run a hardware queue asynchronously.
- * @hctx: Pointer to the hardware queue to run.
- * @msecs: Milliseconds of delay to wait before running the queue.
- *
- * Run a hardware queue asynchronously with a delay of @msecs.
- */
-void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
-{
-	__blk_mq_delay_run_hw_queue(hctx, true, msecs);
-}
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
 /**
@@ -2092,8 +2065,22 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx));
 
-	if (need_run)
-		__blk_mq_delay_run_hw_queue(hctx, async, 0);
+	if (!need_run || unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
+
+	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
+		int cpu = get_cpu();
+		if (cpumask_test_cpu(cpu, hctx->cpumask)) {
+			__blk_mq_run_hw_queue(hctx);
+			put_cpu();
+			return;
+		}
+
+		put_cpu();
+	}
+
+	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
+				    0);
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
-- 
2.30.2


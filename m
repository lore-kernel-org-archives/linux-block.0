Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568B6C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 06:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDLGiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDLGh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 02:37:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590C959D1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4Y19Qj4RFbRejoRFA/QuLQDkmyYLjvQCwIc49L6TSvs=; b=oCQAJwsk3bmkRrL0Ghhk82fXYV
        922toeY/q1f7b7XvMBo8CRzAI8t83N6fin32waiNn0tU4YAjaFT1hSIdC5DlQUlQuFiHJBWTEMKPl
        uEZNR3eMKZwGRIrR3JTSg9u2VBOsii7lToJu9xd4gPtd0GO/IZX9yLM5PxXPsqar4K3UQlIDfEPw2
        QpnzX7nyaZjj7z5EYosGR/M/ZFRCUSThqJRP6WnRO8VzEq/dF4VPqe9xwbCg8s0SG9sBDXj/6a3XR
        M3H5ZIgaRwBDUduKX3HpoBpq8UTPLW00LkKPKjWchv+1dR89Xznkd1NqyWFmhAktM3zxab3wJrTfz
        iBwsVQXA==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmU73-001z80-2j;
        Wed, 12 Apr 2023 06:37:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: move the !async handling out of __blk_mq_delay_run_hw_queue
Date:   Wed, 12 Apr 2023 08:37:43 +0200
Message-Id: <20230412063743.618957-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412063743.618957-1-hch@lst.de>
References: <20230412063743.618957-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only blk_mq_run_hw_queue can call __blk_mq_delay_run_hw_queue with
async=false, so move the handling there.

With this __blk_mq_delay_run_hw_queue can be merged into
blk_mq_delay_run_hw_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cdf1d5ca04bba2..ff03f7d3c5c708 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2212,41 +2212,19 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
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
-	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
-			__blk_mq_run_hw_queue(hctx);
-			return;
-		}
-	}
-
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
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
@@ -2274,8 +2252,14 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx));
 
-	if (need_run)
-		__blk_mq_delay_run_hw_queue(hctx, async, 0);
+	if (!need_run)
+		return;
+
+	if (async || (hctx->flags & BLK_MQ_F_BLOCKING) ||
+	    !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask))
+		blk_mq_delay_run_hw_queue(hctx, 0);
+	else
+		__blk_mq_run_hw_queue(hctx);
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
-- 
2.39.2


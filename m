Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9254C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDMGHI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDMGHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:07:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CF729A
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=afIf0SMTjEY2cYI/j4PnCXGEppDvlv+fwKPUZYeN6Mk=; b=NkmY/hcJuTB1pTJicyYWE8DKR5
        1aaJY+LFc1ZWIDol4wrS6p4UusoqXJd+hYqQ79ORBT7nN6VfztCzBkU+KzubgeN0OshW+XhxMtHeC
        a+uuulg+im/blClyAWhRI6p02QhFC+dKveN9f64+Bk6xVRIX4Z6AIxgKi2B04DjnXjoM2a4/eUV3H
        mYK6Yl1u1bfJrlVOtWdNxZDrKhOMpb5/YUstv8W4yYHFfqVgCXhqXbO4wPfKEKBRWx5dplrS1i4f5
        8dpwKFUUiP3aMKRG2QyUqPwEOueeGyCjkvn60GUhDIlnNs60b9YRRbQBseSl+PoHowRcwBlya2APQ
        680NOwcA==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmq6s-0057ju-0s;
        Thu, 13 Apr 2023 06:07:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 4/5] blk-mq: move the !async handling out of __blk_mq_delay_run_hw_queue
Date:   Thu, 13 Apr 2023 08:06:50 +0200
Message-Id: <20230413060651.694656-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413060651.694656-1-hch@lst.de>
References: <20230413060651.694656-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e0c914651f7946..6eef65ac4996bf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2201,41 +2201,19 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
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
@@ -2263,8 +2241,16 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx));
 
-	if (need_run)
-		__blk_mq_delay_run_hw_queue(hctx, async, 0);
+	if (!need_run)
+		return;
+
+	if (async || (hctx->flags & BLK_MQ_F_BLOCKING) ||
+	    !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
+		blk_mq_delay_run_hw_queue(hctx, 0);
+		return;
+	}
+
+	__blk_mq_run_hw_queue(hctx);
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
-- 
2.39.2


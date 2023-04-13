Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE3C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDMGHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMGHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:07:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08859C5
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mTj1ILY9FaIscuusZD3yOOXbkTl64mq7dYxq5yxssFQ=; b=jq+EcKWsWVIk3wDOSVVR+Thzi5
        sHI1sRehtVC5wvjV/2Z2Bv7ttnNP2ciGuK4lq/uPOunWQicmBDqRCBwUKGFb/9v7g/6LM266cWF9O
        CFLp0r6Guy33VYVQS2Y7Ht7iCYl+zTFzQ1NnsrvQDuhvIalslsNaHfjrXkCArksR8KClu1WCYnABF
        +a5Ww6ggarl+JxDtNjO2n4kiiD5QuJ+z+yHRTgR1s4znk05H/X8IjkO/5dNQYxztj6/gdrWBKPigv
        EXmWFt5uCWxjkrMhkePY/OtdU8qCKMmEEKVPszy0NfEmep4Q78touGzlkybh+KIuXQGjaAADHBaj4
        UGdBOhCQ==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmq6u-0057kI-2e;
        Thu, 13 Apr 2023 06:07:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5/5] blk-mq: remove __blk_mq_run_hw_queue
Date:   Thu, 13 Apr 2023 08:06:51 +0200
Message-Id: <20230413060651.694656-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413060651.694656-1-hch@lst.de>
References: <20230413060651.694656-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_mq_run_hw_queue just contains a WARN_ON_ONCE for calls from
interrupt context and a blk_mq_run_dispatch_ops-protected call to
blk_mq_sched_dispatch_requests.  Open code the call to
blk_mq_sched_dispatch_requests in both callers, and move the WARN_ON_ONCE
to blk_mq_run_hw_queue where it can be extented to all !async calls,
while the other call is from workqueue context and thus obviously does
not need the assert.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6eef65ac4996bf..9e683f511f8ac0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2127,24 +2127,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	return true;
 }
 
-/**
- * __blk_mq_run_hw_queue - Run a hardware queue.
- * @hctx: Pointer to the hardware queue to run.
- *
- * Send pending requests to the hardware.
- */
-static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
-{
-	/*
-	 * We can't run the queue inline with ints disabled. Ensure that
-	 * we catch bad users of this early.
-	 */
-	WARN_ON_ONCE(in_interrupt());
-
-	blk_mq_run_dispatch_ops(hctx->queue,
-			blk_mq_sched_dispatch_requests(hctx));
-}
-
 static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
 {
 	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
@@ -2229,6 +2211,11 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	bool need_run;
 
+	/*
+	 * We can't run the queue inline with interrupts disabled.
+	 */
+	WARN_ON_ONCE(!async && in_interrupt());
+
 	/*
 	 * When queue is quiesced, we may be switching io scheduler, or
 	 * updating nr_hw_queues, or other things, and we can't run queue
@@ -2250,7 +2237,8 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 	}
 
-	__blk_mq_run_hw_queue(hctx);
+	blk_mq_run_dispatch_ops(hctx->queue,
+				blk_mq_sched_dispatch_requests(hctx));
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
@@ -2418,7 +2406,8 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx =
 		container_of(work, struct blk_mq_hw_ctx, run_work.work);
 
-	__blk_mq_run_hw_queue(hctx);
+	blk_mq_run_dispatch_ops(hctx->queue,
+				blk_mq_sched_dispatch_requests(hctx));
 }
 
 static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
-- 
2.39.2


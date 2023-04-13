Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574DC77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDMGHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMGHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:07:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A67DB0
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9ohnZj+UP2E669TGXNdyCWP3rFeUm2JcnEYpLbWQpZY=; b=wLqcpRNVZ0d/HgLQtNdlv8xgaN
        S+KKj98mNdg2mjyBeo6N8sMBKKqA1AkPgsnPNiZKvmu5ATxzBX1NSh73wyZpd0Wl1R/SvfWpgb79z
        1Q3ZO/lHnAjAKKO9u4y68LERkwUTSXaLeiYXSfB+axNqKJEKwN9q2juOA5QzBkW9RsTQGhIyDqh0d
        MWgjE+Z02V04rk+cxlxEs0MnR+SHF3YzfhwhGjRASB80kdgDChVdZFCgUwbscDL5Zcp6uCDM6M9Q4
        hTElO3RZb1hlEuUeDiBF6OR0yojYMi5s6anmhHRxO+uig1WwX9qWX1V/rYnv+LOZxapBLl4v6XGAV
        K4CyH9DQ==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmq6p-0057j6-2O;
        Thu, 13 Apr 2023 06:07:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 3/5] blk-mq: move the blk_mq_hctx_stopped check in __blk_mq_delay_run_hw_queue
Date:   Thu, 13 Apr 2023 08:06:49 +0200
Message-Id: <20230413060651.694656-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413060651.694656-1-hch@lst.de>
References: <20230413060651.694656-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the in-context dispatch, blk_mq_hctx_stopped is alredy checked in
blk_mq_sched_dispatch_requests under blk_mq_run_dispatch_ops() protetion.
For the async dispatch case having a check before scheduling the work
still makes sense to avoid needless workqueue scheduling, so just keep
it for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5289a34e68b937..e0c914651f7946 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2212,9 +2212,6 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
-	if (unlikely(blk_mq_hctx_stopped(hctx)))
-		return;
-
 	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		if (cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 			__blk_mq_run_hw_queue(hctx);
@@ -2222,6 +2219,8 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		}
 	}
 
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
-- 
2.39.2


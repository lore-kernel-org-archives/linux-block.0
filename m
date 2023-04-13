Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E968EC77B71
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDMGHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMGHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:07:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C564ED8
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mhkuFHS/1KLpoG0nLLYmEFco6ZIM8dO1/TxmIPTQWJo=; b=J9ab4AchZkIYK1Pluv/aB219PO
        OLoFFgFyRqsj85KeX4NsLxNZsQn5DnqSFm8hvlDKdPzo278EvVTmtJVElgmp5WcK3jH/EesKYtmYN
        kn6hIMW/pOPil1AF/wodPLQs+XjJKazn650govcfdZ2/5sITZxQ4ZvBCxMQqPGPsND4JqxilFURiH
        TLmx2JAiK7PzqHKa483AXZVm2N60fRm2Hc7a7vI0LmAo5UaeZBiufYfudowmudx7y4KIZkNQKu99D
        b2tjHcdHVBaAdTNbEa95mJokPWGpX64QpzVQKL7xl6XHOFKn8raeHxs95p60/PlJCxwMtLMMjo/QR
        VDhEuzCg==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmq6n-0057it-0i;
        Thu, 13 Apr 2023 06:07:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 2/5] blk-mq: remove the blk_mq_hctx_stopped check in blk_mq_run_work_fn
Date:   Thu, 13 Apr 2023 08:06:48 +0200
Message-Id: <20230413060651.694656-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413060651.694656-1-hch@lst.de>
References: <20230413060651.694656-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_hctx_stopped is alredy checked in blk_mq_sched_dispatch_requests
under blk_mq_run_dispatch_ops() protetion, so remove the duplicate check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 52f8e0099c7f4b..5289a34e68b937 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2430,15 +2430,8 @@ EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
 
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


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F5FC77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDMGHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDMGHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:07:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A94EDE
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cc23uwDorSZ++2byttC1mhaCtRgIgF0SWFi4mTeCvQ4=; b=fJENeOrqn0F+otnC+MHrCLXpSO
        S29m9pfRNdv88Pr0yRn/8+BfUxPPt5dA8JAH3acvZBKkxZ/FNAM0cBKncjOEYSGGZK16I6pOstVjp
        OmkE9qaqwrJYHOm0WwWC3piRAds8ifg3zOBYDNP1Iot/vwROKwn2KwDRAVI62vpuIyQd1+r5xYrRX
        YbuwDof9wVAmNYw05RkgRwS/J2pYKB6XmpGvJR5huvP7RULGsFvuLbr4nHa+1vgnYydiGXdfxaLKb
        9tdNf3icUP+0WfKrX0Wkxwz6ah3EW3bKTQYB9Ft0XO6yNeiJP+oWLvenJrL/J9YZDYqjpafxk5y/S
        8XE3ji+A==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmq6k-0057ie-26;
        Thu, 13 Apr 2023 06:06:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 1/5] blk-mq: cleanup __blk_mq_sched_dispatch_requests
Date:   Thu, 13 Apr 2023 08:06:47 +0200
Message-Id: <20230413060651.694656-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413060651.694656-1-hch@lst.de>
References: <20230413060651.694656-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_mq_sched_dispatch_requests currently has duplicated logic
for the cases where requests are on the hctx dispatch list or not.
Merge the two with a new need_dispatch variable and remove a few
pointless local variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 06b312c691143f..f3257e1607a00c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -271,9 +271,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 
 static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
-	struct request_queue *q = hctx->queue;
-	const bool has_sched = q->elevator;
-	int ret = 0;
+	bool need_dispatch = false;
 	LIST_HEAD(rq_list);
 
 	/*
@@ -302,23 +300,22 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		if (blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) {
-			if (has_sched)
-				ret = blk_mq_do_dispatch_sched(hctx);
-			else
-				ret = blk_mq_do_dispatch_ctx(hctx);
-		}
-	} else if (has_sched) {
-		ret = blk_mq_do_dispatch_sched(hctx);
-	} else if (hctx->dispatch_busy) {
-		/* dequeue request one by one from sw queue if queue is busy */
-		ret = blk_mq_do_dispatch_ctx(hctx);
+		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) 
+			return 0;
+		need_dispatch = true;
 	} else {
-		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-		blk_mq_dispatch_rq_list(hctx, &rq_list, 0);
+		need_dispatch = hctx->dispatch_busy;
 	}
 
-	return ret;
+	if (hctx->queue->elevator)
+		return blk_mq_do_dispatch_sched(hctx);
+
+	/* dequeue request one by one from sw queue if queue is busy */
+	if (need_dispatch)
+		return blk_mq_do_dispatch_ctx(hctx);
+	blk_mq_flush_busy_ctxs(hctx, &rq_list);
+	blk_mq_dispatch_rq_list(hctx, &rq_list, 0);
+	return 0;
 }
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
-- 
2.39.2


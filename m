Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79FC77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDKNeY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjDKNeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:34:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFCF3C39
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9NLpAaiklui+4Sdl05N+0y4tAEqsohXA/XYQgZ+iFGk=; b=MEKzJoDPgJhs/tmp2uOxXpgFV4
        LNHQL2VMdJj3v0Qy/VNc3akmezIuwx/hsecWCZ5p3TEuFHo6+O6FI3ieR+SXQ33LpMqEzVGHuO0bI
        tnmkcAMOq8QzYMrhM83pPVc6JIbY78G7AineFfWgClFA9uQDhbbf/PQyI2WvvxjXeO1jLmgwGwvAS
        N6n4kQ0TKiy/f81viHpzu9ZcShDMIfpXrmCRh+tHAXtI8xJXs9WRzf0VDQ9jP3xLga9UnQzSV0UYw
        lO/LS5VtXzMBrR06Ohtb37tCc5DZH08RJO+sfq8Km0+j+JvvHz08LQ4mrKI3VEF+Y8s/FZ8VNinvq
        NGRSvXow==;
Received: from [2001:4bb8:192:2d6c:a9b7:88a0:9fdd:81ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmE8W-0007xk-0y;
        Tue, 11 Apr 2023 13:34:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 09/16] blk-mq: refactor the DONTPREP/SOFTBARRIER andling in blk_mq_requeue_work
Date:   Tue, 11 Apr 2023 15:33:22 +0200
Message-Id: <20230411133329.554624-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411133329.554624-1-hch@lst.de>
References: <20230411133329.554624-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the RQF_DONTPREP and RQF_SOFTBARRIER in separate branches to make
the code more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4bd7736c173bc8..a4fc6e68c3a66b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1429,20 +1429,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
-			continue;
-
-		rq->rq_flags &= ~RQF_SOFTBARRIER;
-		list_del_init(&rq->queuelist);
 		/*
 		 * If RQF_DONTPREP, rq has contained some driver specific
 		 * data, so insert it to hctx dispatch list to avoid any
 		 * merge.
 		 */
-		if (rq->rq_flags & RQF_DONTPREP)
+		if (rq->rq_flags & RQF_DONTPREP) {
+			rq->rq_flags &= ~RQF_SOFTBARRIER;
+			list_del_init(&rq->queuelist);
 			blk_mq_request_bypass_insert(rq, false, false);
-		else
+		} else if (rq->rq_flags & RQF_SOFTBARRIER) {
+			rq->rq_flags &= ~RQF_SOFTBARRIER;
+			list_del_init(&rq->queuelist);
 			blk_mq_insert_request(rq, true, false, false);
+		}
 	}
 
 	while (!list_empty(&rq_list)) {
-- 
2.39.2


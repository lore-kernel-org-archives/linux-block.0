Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F4C77B75
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLFdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDLFdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:33:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CCE4B
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KFqPgRp00d0JHE+OvAdBw37vXdwvhC84SDu1COfKPD4=; b=h7bZuycOchf8yEqhD8aGLzbKb/
        xxHPUfk+BiRZjcdDo15A2Hk6v1qxwPgjsRCjjQcX9QZRJQj/8c4QETaOic0eIqfnGpFUnVkpRckqk
        D3pWSqrtQLHO0JLGpP6rvD684Gv9Z8yVXjjmlhdRnWeuMnsoD0krKdcjfhMLisQejzhRu0g3I8wCz
        5OcmHBBXbCyDYFQTvs+2QLow5Scp8aX5B1JPiY2CwDId4afjry0s5WkOmhm8l3Nx3gbSKmnfOD0E5
        Lzw6rnbOXpWBlXoupA8T5ebiyYFbFOYTkCcWUowgmX42cBeq80ri0XizE71MlzcyPwGO4BvEvoYxN
        PgCoFpaQ==;
Received: from [2001:4bb8:192:2d6c:58da:8aa2:ef59:390f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmT6d-001rJg-30;
        Wed, 12 Apr 2023 05:33:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: [PATCH 11/18] blk-mq: refactor the DONTPREP/SOFTBARRIER andling in blk_mq_requeue_work
Date:   Wed, 12 Apr 2023 07:32:41 +0200
Message-Id: <20230412053248.601961-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412053248.601961-1-hch@lst.de>
References: <20230412053248.601961-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the RQF_DONTPREP and RQF_SOFTBARRIER in separate branches to make
the code more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3de03217f4f1a..5dfb927d1b9145 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1427,20 +1427,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
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


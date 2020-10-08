Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604F7C433E7
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 03:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDA52145D
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 03:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgJHDxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 23:53:02 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33738 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728313AbgJHDwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 23:52:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBGF.4a_1602129161;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGF.4a_1602129161)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] blk-throttle: Open code __throtl_de/enqueue_tg()
Date:   Thu,  8 Oct 2020 11:52:28 +0800
Message-Id: <6a43ae990da3163204bae3ddedb6025d73b91545.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The __throtl_de/enqueue_tg() functions are only be called by
throtl_de/enqueue_tg(), thus we can just open code them to
make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-throttle.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 38aed8b..fc5c14f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -691,29 +691,21 @@ static void tg_service_queue_add(struct throtl_grp *tg)
 			       leftmost);
 }
 
-static void __throtl_enqueue_tg(struct throtl_grp *tg)
-{
-	tg_service_queue_add(tg);
-	tg->flags |= THROTL_TG_PENDING;
-	tg->service_queue.parent_sq->nr_pending++;
-}
-
 static void throtl_enqueue_tg(struct throtl_grp *tg)
 {
-	if (!(tg->flags & THROTL_TG_PENDING))
-		__throtl_enqueue_tg(tg);
-}
-
-static void __throtl_dequeue_tg(struct throtl_grp *tg)
-{
-	throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
-	tg->flags &= ~THROTL_TG_PENDING;
+	if (!(tg->flags & THROTL_TG_PENDING)) {
+		tg_service_queue_add(tg);
+		tg->flags |= THROTL_TG_PENDING;
+		tg->service_queue.parent_sq->nr_pending++;
+	}
 }
 
 static void throtl_dequeue_tg(struct throtl_grp *tg)
 {
-	if (tg->flags & THROTL_TG_PENDING)
-		__throtl_dequeue_tg(tg);
+	if (tg->flags & THROTL_TG_PENDING) {
+		throtl_rb_erase(&tg->rb_node, tg->service_queue.parent_sq);
+		tg->flags &= ~THROTL_TG_PENDING;
+	}
 }
 
 /* Call with queue lock held */
-- 
1.8.3.1


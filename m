Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A6C433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 03:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9135F2074B
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 03:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgG2D3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:29:08 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:55135 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgG2D3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 23:29:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U46nKlX_1595993332;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U46nKlX_1595993332)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 11:28:53 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] block: Remove __blk_mq_sched_bio_merge() helper
Date:   Wed, 29 Jul 2020 11:28:37 +0800
Message-Id: <d0e8446df5a34264c22637b742c762efcb2c4241.1595987955.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
References: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The blk_mq_sched_bio_merge() just wrap the __blk_mq_sched_bio_merge(), and
no other places will use __blk_mq_sched_bio_merge(). Thus we can combine
these 2 similar functions into one function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-mq-sched.c |  5 ++++-
 block/blk-mq-sched.h | 13 ++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4e3eef5..f7ae74a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -408,7 +408,7 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 }
 EXPORT_SYMBOL_GPL(blk_mq_bio_list_merge);
 
-bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct elevator_queue *e = q->elevator;
@@ -417,6 +417,9 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	bool ret = false;
 	enum hctx_type type;
 
+	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
+		return false;
+
 	if (e && e->type->ops.bio_merge)
 		return e->type->ops.bio_merge(hctx, bio, nr_segs);
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021f..65151de 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -13,8 +13,6 @@ void blk_mq_sched_free_hctx_data(struct request_queue *q,
 void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
-bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
 void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
@@ -31,15 +29,8 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 void blk_mq_sched_free_requests(struct request_queue *q);
 
-static inline bool
-blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs)
-{
-	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
-		return false;
-
-	return __blk_mq_sched_bio_merge(q, bio, nr_segs);
-}
+bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+			    unsigned int nr_segs);
 
 static inline bool
 blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
-- 
1.8.3.1


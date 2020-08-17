Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D246FC433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 04:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B764820674
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 04:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgHQEJx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 00:09:53 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50067 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgHQEJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 00:09:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5xKxWv_1597637375;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U5xKxWv_1597637375)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 12:09:35 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 5/5] block: Remove __blk_mq_sched_bio_merge() helper
Date:   Mon, 17 Aug 2020 12:09:19 +0800
Message-Id: <4ad0888df567a8bd75676b618ad87147c634d7b0.1597637287.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
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
index 1cc7919..ba34460 100644
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


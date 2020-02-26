Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C502EC4BA10
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C872467B
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 12:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgBZMOa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:14:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbgBZMO3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 07:14:29 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD6FD38F0FDB02B7E510;
        Wed, 26 Feb 2020 20:14:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 26 Feb 2020 20:14:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Remove some unused function arguments
Date:   Wed, 26 Feb 2020 20:10:15 +0800
Message-ID: <1582719015-198980-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The struct blk_mq_hw_ctx pointer argument in blk_mq_put_tag(),
blk_mq_poll_nsecs(), and blk_mq_poll_hybrid_sleep() is unused, so remove
it.

Overall obj code size shows a minor reduction, before:
   text	   data	    bss	    dec	    hex	filename
  27306	   1312	      0	  28618	   6fca	block/blk-mq.o
   4303	    272	      0	   4575	   11df	block/blk-mq-tag.o

after:
  27282	   1312	      0	  28594	   6fb2	block/blk-mq.o
   4311	    272	      0	   4583	   11e7	block/blk-mq-tag.o

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.garry@huawei.com>
--
This minor patch had been carried as part of the blk-mq shared tags RFC,
I'd rather not carry it anymore as it required rebasing, so now or never..

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fbacde454718..586c9d6e904a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -183,8 +183,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return tag + tag_offset;
 }
 
-void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
-		    struct blk_mq_ctx *ctx, unsigned int tag)
+void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
+		    unsigned int tag)
 {
 	if (!blk_mq_tag_is_reserved(tags, tag)) {
 		const int real_tag = tag - tags->nr_reserved_tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 15bc74acb57e..2b8321efb682 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -26,8 +26,8 @@ extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int r
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
-extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
-			   struct blk_mq_ctx *ctx, unsigned int tag);
+extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
+			   unsigned int tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..0836b5135fa6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -477,9 +477,9 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 	if (rq->tag != -1)
-		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
+		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
-		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
+		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
 }
@@ -3398,7 +3398,6 @@ static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
 }
 
 static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
-				       struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
 	unsigned long ret = 0;
@@ -3431,7 +3430,6 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 }
 
 static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
-				     struct blk_mq_hw_ctx *hctx,
 				     struct request *rq)
 {
 	struct hrtimer_sleeper hs;
@@ -3451,7 +3449,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	if (q->poll_nsec > 0)
 		nsecs = q->poll_nsec;
 	else
-		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
+		nsecs = blk_mq_poll_nsecs(q, rq);
 
 	if (!nsecs)
 		return false;
@@ -3506,7 +3504,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 			return false;
 	}
 
-	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
+	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
 /**
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..ba37cd64894c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -199,7 +199,7 @@ static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
-	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = -1;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
-- 
2.17.1


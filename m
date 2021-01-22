Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DCBC4332B
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663C32343E
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 12:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAVJZZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:25:25 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:52466 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbhAVJRF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 04:17:05 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2021 04:17:02 EST
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 448344E16AB;
        Fri, 22 Jan 2021 17:06:43 +0800 (CST)
From:   Yang Yang <yang.yang@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     onlyfever@icloud.com, yang.yang@vivo.com
Subject: [PATCH] kyber: introduce kyber_depth_updated()
Date:   Fri, 22 Jan 2021 01:06:36 -0800
Message-Id: <20210122090636.55428-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS09MTEIYQkJNSEMYVkpNSkpIS01PS0hPSkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6Ojo4HT8NNkIsS0sxOAtJ
        TSgaCQhVSlVKTUpKSEtNT0tIQ0hLVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJTllXWQgBWUFISElINwY+
X-HM-Tid: 0a77295886129376kuws448344e16ab
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hang occurs when user changes the scheduler queue depth, by writing to
the 'nr_requests' sysfs file of that device.
This patch introduces kyber_depth_updated(), so that kyber can update its
internal state when queue depth changes.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
 block/kyber-iosched.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index dc89199bc8c6..b64f80d3eaf3 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -353,19 +353,9 @@ static void kyber_timer_fn(struct timer_list *t)
 	}
 }
 
-static unsigned int kyber_sched_tags_shift(struct request_queue *q)
-{
-	/*
-	 * All of the hardware queues have the same depth, so we can just grab
-	 * the shift of the first one.
-	 */
-	return q->queue_hw_ctx[0]->sched_tags->bitmap_tags->sb.shift;
-}
-
 static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 {
 	struct kyber_queue_data *kqd;
-	unsigned int shift;
 	int ret = -ENOMEM;
 	int i;
 
@@ -400,9 +390,6 @@ static struct kyber_queue_data *kyber_queue_data_alloc(struct request_queue *q)
 		kqd->latency_targets[i] = kyber_latency_targets[i];
 	}
 
-	shift = kyber_sched_tags_shift(q);
-	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
-
 	return kqd;
 
 err_buckets:
@@ -458,9 +445,18 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
 		INIT_LIST_HEAD(&kcq->rq_list[i]);
 }
 
-static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
+	struct blk_mq_tags *tags = hctx->sched_tags;
+
+	kqd->async_depth = tags->bitmap_tags->sb.depth * KYBER_ASYNC_PERCENT / 100U;
+
+	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
+}
+
+static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
 	struct kyber_hctx_data *khd;
 	int i;
 
@@ -502,8 +498,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	khd->batching = 0;
 
 	hctx->sched_data = khd;
-	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
-					kqd->async_depth);
+	kyber_depth_updated(hctx);
 
 	return 0;
 
@@ -1022,6 +1017,7 @@ static struct elevator_type kyber_sched = {
 		.completed_request = kyber_completed_request,
 		.dispatch_request = kyber_dispatch_request,
 		.has_work = kyber_has_work,
+		.depth_updated = kyber_depth_updated,
 	},
 #ifdef CONFIG_BLK_DEBUG_FS
 	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
-- 
2.17.1


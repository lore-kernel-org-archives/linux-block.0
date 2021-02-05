Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37DFC433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8452A64F70
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBEJRP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:17:15 -0500
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:60630 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBEJO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 04:14:57 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id C85A6AC0384;
        Fri,  5 Feb 2021 17:14:07 +0800 (CST)
From:   Yang Yang <yang.yang@vivo.com>
To:     Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com
Subject: [PATCH v2] kyber: introduce kyber_depth_updated()
Date:   Fri,  5 Feb 2021 01:13:10 -0800
Message-Id: <20210205091311.129498-1-yang.yang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhpNHk5CSx8aTksZVkpNSklOSk1PT0xCTE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6Qjo4Oj8WKSo9OCgoGDky
        SzoKCjBVSlVKTUpJTkpNT09DSE9PVTMWGhIXVQIaFRxVAhoVHDsNEg0UVRgUFkVZV1kSC1lBWUpO
        TFVLVUhKVUpJT1lXWQgBWUFPS0pKNwY+
X-HM-Tid: 0a77717856aeb039kuuuc85a6ac0384
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hang occurs when user changes the scheduler queue depth, by writing to
the 'nr_requests' sysfs file of that device.

The details of the environment that we found the problem are as follows:
  an eMMC block device
  total driver tags: 16
  default queue_depth: 32
  kqd->async_depth initialized in kyber_init_sched() with queue_depth=32

Then we change queue_depth to 256, by writing to the 'nr_requests' sysfs
file. But kqd->async_depth don't be updated after queue_depth changes.
Now the value of async depth is too small for queue_depth=256, this may
cause hang.

This patch introduces kyber_depth_updated(), so that kyber can update
async depth when queue depth changes.

Signed-off-by: Yang Yang <yang.yang@vivo.com>
---
v2:
- Change the commit message
- Change from sbitmap::depth to 2^sbitmap::shift
---
 block/kyber-iosched.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index dc89199bc8c6..17215b6bf482 100644
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
@@ -458,9 +445,19 @@ static void kyber_ctx_queue_init(struct kyber_ctx_queue *kcq)
 		INIT_LIST_HEAD(&kcq->rq_list[i]);
 }
 
-static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
+	struct blk_mq_tags *tags = hctx->sched_tags;
+	unsigned int shift = tags->bitmap_tags->sb.shift;
+
+	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
+
+	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, kqd->async_depth);
+}
+
+static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
 	struct kyber_hctx_data *khd;
 	int i;
 
@@ -502,8 +499,7 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 	khd->batching = 0;
 
 	hctx->sched_data = khd;
-	sbitmap_queue_min_shallow_depth(hctx->sched_tags->bitmap_tags,
-					kqd->async_depth);
+	kyber_depth_updated(hctx);
 
 	return 0;
 
@@ -1022,6 +1018,7 @@ static struct elevator_type kyber_sched = {
 		.completed_request = kyber_completed_request,
 		.dispatch_request = kyber_dispatch_request,
 		.has_work = kyber_has_work,
+		.depth_updated = kyber_depth_updated,
 	},
 #ifdef CONFIG_BLK_DEBUG_FS
 	.queue_debugfs_attrs = kyber_queue_debugfs_attrs,
-- 
2.17.1


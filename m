Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2995C4332D
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AC221E7
	for <linux-block@archiver.kernel.org>; Sat, 26 Dec 2020 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLZK0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Dec 2020 05:26:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10366 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLZK0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Dec 2020 05:26:22 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D30LC75kYz7LDT;
        Sat, 26 Dec 2020 18:24:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Sat, 26 Dec 2020
 18:25:29 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 3/3] blk-mq: decrease pending_queues when it expires
Date:   Sat, 26 Dec 2020 18:28:08 +0800
Message-ID: <20201226102808.2534966-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201226102808.2534966-1-yukuai3@huawei.com>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If pending_queues is increased once, it will only be decreased when
nr_active is zero, and that will lead to the under-utilization of
host tags because pending_queues is non-zero and the available
tags for the queue will be max(host tags / active_queues, 4)
instead of the needed tags of the queue.

Fix it by adding an expiration time for the increasement of pending_queues,
and decrease it when it expires, so pending_queues will be decreased
to zero if there is no tag allocation failure, and the available tags
for the queue will be the whole host tags.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 29 ++++++++++++++++++++++++++---
 block/blk-mq-tag.h     |  6 +++---
 block/blk-mq.c         |  5 +++--
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h |  6 +++++-
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 6dcd6dd9123a..e3ffe0fde052 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -46,12 +46,16 @@ void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx)
 		struct blk_mq_tag_set *set = q->tag_set;
 
 		if (!test_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags) &&
-		    !test_and_set_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags))
+		    !test_and_set_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags)) {
+			hctx->dtag_wait_time = jiffies;
 			atomic_inc(&set->pending_queues_shared_sbitmap);
+		}
 	} else {
 		if (!test_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state) &&
-		    !test_and_set_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state))
+		    !test_and_set_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state)) {
+			hctx->dtag_wait_time = jiffies;
 			atomic_inc(&hctx->tags->pending_queues);
+		}
 	}
 }
 
@@ -89,12 +93,28 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
-void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+#define BLK_MQ_DTAG_WAIT_EXPIRE (5 * HZ)
+
+void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx, bool force)
 {
 	struct blk_mq_tags *tags = hctx->tags;
 	struct request_queue *q = hctx->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
 
+	if (!force) {
+		if (blk_mq_is_sbitmap_shared(hctx->flags)) {
+			if (!(test_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags) &&
+			      time_after(jiffies, hctx->dtag_wait_time +
+					BLK_MQ_DTAG_WAIT_EXPIRE)))
+				return;
+		} else {
+			if (!(test_bit(BLK_MQ_S_DTAG_WAIT, &hctx->state) &&
+			      time_after(jiffies, hctx->dtag_wait_time +
+					BLK_MQ_DTAG_WAIT_EXPIRE)))
+				return;
+		}
+	}
+
 	if (blk_mq_is_sbitmap_shared(hctx->flags) &&
 	    test_and_clear_bit(QUEUE_FLAG_HCTX_WAIT, &q->queue_flags))
 		atomic_dec(&set->pending_queues_shared_sbitmap);
@@ -202,6 +222,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	sbitmap_finish_wait(bt, ws, &wait);
 
 found_tag:
+	if (!data->q->elevator)
+		blk_mq_dtag_idle(data->hctx, false);
+
 	/*
 	 * Give up this allocation if the hctx is inactive.  The caller will
 	 * retry on an active hctx.
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 52d08a92f683..888692498ef2 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -68,7 +68,7 @@ enum {
 extern bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
 extern void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
 extern void __blk_mq_dtag_busy(struct blk_mq_hw_ctx *);
-extern void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *);
+extern void __blk_mq_dtag_idle(struct blk_mq_hw_ctx *, bool);
 
 static inline bool blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
@@ -94,12 +94,12 @@ static inline void blk_mq_dtag_busy(struct blk_mq_hw_ctx *hctx)
 	__blk_mq_dtag_busy(hctx);
 }
 
-static inline void blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_dtag_idle(struct blk_mq_hw_ctx *hctx, bool force)
 {
 	if (!(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return;
 
-	__blk_mq_dtag_idle(hctx);
+	__blk_mq_dtag_idle(hctx, force);
 }
 
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2b8fa49bccb4..9ac976107154 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1015,7 +1015,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 			/* the hctx may be unmapped, so check it here */
 			if (blk_mq_hw_queue_mapped(hctx)) {
 				blk_mq_tag_idle(hctx);
-				blk_mq_dtag_idle(hctx);
+				blk_mq_dtag_idle(hctx, true);
 			}
 		}
 	}
@@ -2568,7 +2568,7 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 {
 	if (blk_mq_hw_queue_mapped(hctx)) {
 		blk_mq_tag_idle(hctx);
-		blk_mq_dtag_idle(hctx);
+		blk_mq_dtag_idle(hctx, true);
 	}
 
 	if (set->ops->exit_request)
@@ -2667,6 +2667,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&hctx->dispatch);
 	hctx->queue = q;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_QUEUE_SHARED;
+	hctx->dtag_wait_time = jiffies;
 
 	INIT_LIST_HEAD(&hctx->hctx_list);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 228c5c442be4..93ede498f5e6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -214,7 +214,7 @@ static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 		atomic_dec(&hctx->queue->nr_active_requests_shared_sbitmap);
 	else if (!atomic_dec_return(&hctx->nr_active)) {
 		blk_mq_tag_idle(hctx);
-		blk_mq_dtag_idle(hctx);
+		blk_mq_dtag_idle(hctx, true);
 	}
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a473865ee7f..82591c2f76cc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -158,7 +158,11 @@ struct blk_mq_hw_ctx {
 	unsigned long		poll_invoked;
 	/** @poll_success: Count how many polled requests were completed. */
 	unsigned long		poll_success;
-
+	/**
+	 * record when hardware queue is pending, specifically when
+	 * BLK_MQ_S_DTAG_WAIT is set in state.
+	 */
+	unsigned long dtag_wait_time;
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
 	 * @debugfs_dir: debugfs directory for this hardware queue. Named
-- 
2.25.4


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D397C433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 07:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4402F60F92
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 07:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhIMIAE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:00:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16194 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbhIMIAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 04:00:04 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H7Jk30tSGz1DGxK;
        Mon, 13 Sep 2021 15:57:47 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 15:58:44 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 15:58:44 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <hare@suse.de>, <asml.silence@gmail.com>, <bvanassche@acm.org>
Subject: [PATCH -next] blk-mq: fix tag_get wait task can't be awakened
Date:   Mon, 13 Sep 2021 16:12:48 +0800
Message-ID: <20210913081248.3201596-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When multiple hctx share one tagset. The wake_batch is calculated
during initialization by queue_depth. But when multiple hctx share one
tagset. The queue depth assigned to each user may be smaller than
wakup_batch. This may cause the waiting queue to fail to wakup and leads
to Hang.

Fix this by recalculating wake_batch when inc or dec active_queues.

Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/blk-mq-tag.c      | 44 +++++++++++++++++++++++++++++++++++++++--
 include/linux/sbitmap.h |  8 ++++++++
 lib/sbitmap.c           |  3 ++-
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 86f87346232a..d02f5ac0004c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -16,6 +16,27 @@
 #include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
 
+static void bt_update_wake_batch(struct sbitmap_queue *bt, unsigned int users)
+{
+	unsigned int depth;
+
+	depth = max((bt->sb.depth + users - 1) / users, 4U);
+	sbitmap_queue_update_wake_batch(bt, depth);
+}
+
+/*
+ * Recalculate wakeup batch when tag is shared by hctx.
+ */
+static void blk_mq_update_wake_batch(struct sbitmap_queue *bitmap_tags,
+		struct sbitmap_queue *breserved_tags, unsigned int users)
+{
+	if (!users)
+		return;
+
+	bt_update_wake_batch(bitmap_tags, users);
+	bt_update_wake_batch(breserved_tags, users);
+}
+
 /*
  * If a previously inactive queue goes active, bump the active user count.
  * We need to do this before try to allocate driver tag, then even if fail
@@ -24,17 +45,29 @@
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
+	unsigned int users;
+
 	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 		struct blk_mq_tag_set *set = q->tag_set;
 
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) &&
-		    !test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+		    !test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
 			atomic_inc(&set->active_queues_shared_sbitmap);
+
+			users = atomic_read(&set->active_queues_shared_sbitmap);
+			blk_mq_update_wake_batch(&set->__bitmap_tags,
+					&set->__breserved_tags, users);
+		}
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
-		    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
 			atomic_inc(&hctx->tags->active_queues);
+
+			users = atomic_read(&hctx->tags->active_queues);
+			blk_mq_update_wake_batch(&hctx->tags->__bitmap_tags,
+					&hctx->tags->__breserved_tags, users);
+		}
 	}
 
 	return true;
@@ -59,16 +92,23 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	struct blk_mq_tags *tags = hctx->tags;
 	struct request_queue *q = hctx->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
+	unsigned int users;
 
 	if (blk_mq_is_sbitmap_shared(hctx->flags)) {
 		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_ACTIVE,
 					&q->queue_flags))
 			return;
 		atomic_dec(&set->active_queues_shared_sbitmap);
+		users = atomic_read(&set->active_queues_shared_sbitmap);
+		blk_mq_update_wake_batch(&set->__bitmap_tags,
+				&set->__breserved_tags, users);
 	} else {
 		if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
 		atomic_dec(&tags->active_queues);
+		users = atomic_read(&tags->active_queues);
+		blk_mq_update_wake_batch(&tags->__bitmap_tags,
+				&tags->__breserved_tags, users);
 	}
 
 	blk_mq_tag_wakeup_all(tags, false);
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 2713e689ad66..d49e4f054bfe 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -406,6 +406,14 @@ static inline void sbitmap_queue_free(struct sbitmap_queue *sbq)
 	sbitmap_free(&sbq->sb);
 }
 
+/**
+ * sbitmap_queue_update_wake_batch() - Recalucate wake batch.
+ * @sbq: Bitmap queue.
+ * @depth: New number of queue depth.
+ */
+void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
+				     unsigned int depth);
+
 /**
  * sbitmap_queue_resize() - Resize a &struct sbitmap_queue.
  * @sbq: Bitmap queue to resize.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index b25db9be938a..bbe1d663763f 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -457,7 +457,7 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
 
-static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
+void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
 					    unsigned int depth)
 {
 	unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
@@ -475,6 +475,7 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
 			atomic_set(&sbq->ws[i].wait_cnt, 1);
 	}
 }
+EXPORT_SYMBOL_GPL(sbitmap_queue_update_wake_batch);
 
 void sbitmap_queue_resize(struct sbitmap_queue *sbq, unsigned int depth)
 {
-- 
2.22.0


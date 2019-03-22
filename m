Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E40C4360F
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C94B20883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfCVOoJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:44:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729414AbfCVOoI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:44:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5CCF2E53A93B3F350C4D;
        Fri, 22 Mar 2019 22:44:06 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:44:02 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <dwindsor@gmail.com>, <peterz@infradead.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] blk-mq: convert hctx.nr_active to refcount_t
Date:   Fri, 22 Mar 2019 22:48:17 +0800
Message-ID: <20190322144818.987-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20190322144818.987-1-yuyufen@huawei.com>
References: <20190322144818.987-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We convert 'nr_active' from atomic_t to newly provied
refcount_t type and API, which can prevent accidental counter
overflows and underflows.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq-debugfs.c | 2 +-
 block/blk-mq-tag.c     | 2 +-
 block/blk-mq.c         | 8 ++++----
 block/blk-mq.h         | 2 +-
 include/linux/blk-mq.h | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ec1d18cb643c..81536b7201be 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -637,7 +637,7 @@ static int hctx_active_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
+	seq_printf(m, "%d\n", refcount_read(&hctx->nr_active));
 	return 0;
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..3fcb15fa6398 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -90,7 +90,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	 * Allow at least some tags
 	 */
 	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return atomic_read(&hctx->nr_active) < depth;
+	return refcount_read(&hctx->nr_active) < depth;
 }
 
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ea01c23b58a3..004773378209 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -300,7 +300,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	} else {
 		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
+			refcount_inc(&data->hctx->nr_active);
 		}
 		rq->tag = tag;
 		rq->internal_tag = -1;
@@ -514,7 +514,7 @@ void blk_mq_free_request(struct request *rq)
 
 	ctx->rq_completed[rq_is_sync(rq)]++;
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		atomic_dec(&hctx->nr_active);
+		refcount_dec(&hctx->nr_active);
 
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->backing_dev_info);
@@ -1055,7 +1055,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	if (rq->tag >= 0) {
 		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
+			refcount_inc(&data.hctx->nr_active);
 		}
 		data.hctx->tags->rqs[rq->tag] = rq;
 	}
@@ -2710,7 +2710,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		return NULL;
 	}
 
-	atomic_set(&hctx->nr_active, 0);
+	refcount_set(&hctx->nr_active, 0);
 	hctx->numa_node = node;
 	hctx->queue_num = hctx_idx;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 60698b4c25a2..26089d7679a2 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -218,7 +218,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
+		refcount_dec(&hctx->nr_active);
 	}
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814bcc7e3..8868e56d7532 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -56,7 +56,7 @@ struct blk_mq_hw_ctx {
 	unsigned int		numa_node;
 	unsigned int		queue_num;
 
-	atomic_t		nr_active;
+	refcount_t		nr_active;
 	unsigned int		nr_expired;
 
 	struct hlist_node	cpuhp_dead;
-- 
2.16.2.dirty


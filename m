Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9359EC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C42120883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfCVOoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:44:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729424AbfCVOoJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:44:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 58815870277896B0D6FA;
        Fri, 22 Mar 2019 22:44:06 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:44:02 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <dwindsor@gmail.com>, <peterz@infradead.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] blk-mq: covert blk_mq_tag.active_queues to refcount_t
Date:   Fri, 22 Mar 2019 22:48:18 +0800
Message-ID: <20190322144818.987-3-yuyufen@huawei.com>
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

We convert 'active_queues' from atomic_t to newly provied
refcount_t type and API, which can prevent accidental counter
overflows and underflows.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-mq-debugfs.c | 2 +-
 block/blk-mq-tag.c     | 6 +++---
 block/blk-mq-tag.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 81536b7201be..48f0cc2c90ba 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -473,7 +473,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
-		   atomic_read(&tags->active_queues));
+		   refcount_read(&tags->active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3fcb15fa6398..1d713f221bf7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -31,7 +31,7 @@ bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
 	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
-		atomic_inc(&hctx->tags->active_queues);
+		refcount_inc(&hctx->tags->active_queues);
 
 	return true;
 }
@@ -57,7 +57,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return;
 
-	atomic_dec(&tags->active_queues);
+	refcount_dec(&tags->active_queues);
 
 	blk_mq_tag_wakeup_all(tags, false);
 }
@@ -82,7 +82,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	if (bt->sb.depth == 1)
 		return true;
 
-	users = atomic_read(&hctx->tags->active_queues);
+	users = refcount_read(&hctx->tags->active_queues);
 	if (!users)
 		return true;
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..e948b4833a2a 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -11,7 +11,7 @@ struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
 
-	atomic_t active_queues;
+	refcount_t active_queues;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
-- 
2.16.2.dirty


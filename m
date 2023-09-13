Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF6CA0ED1
	for <linux-block@archiver.kernel.org>; Wed, 13 Sep 2023 03:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjIMDvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Sep 2023 23:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjIMDvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:12 -0400
Received: from out-225.mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029B6172D
        for <linux-block@vger.kernel.org>; Tue, 12 Sep 2023 20:51:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEQUCPUPTnw8DVS45Whbzs7PuWsvHPKXqwBfw1rbYI4=;
        b=ssUxvOoXRUx2Pm6338qfoIwPn+XyiQU0rIfk8nVcF0TtKWrXpDxxFPUgY2e9y0Y7m3Oue0
        DYgkAFvj9Shjeqs0cwM0NWJd/2n/wM7Xea1Az4VMr1IYnqz2jEkRLEfSdLeckiQhAgnTfr
        d0gjwXhTex1t74vgRyp8NR6DrmptqRs=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 2/6] blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
Date:   Wed, 13 Sep 2023 03:50:29 +0000
Message-Id: <20230913035033.1549277-3-chengming.zhou@linux.dev>
In-Reply-To: <20230913035033.1549277-1-chengming.zhou@linux.dev>
References: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

For support of specified queue filter when iterating over a tagset,
we introduce __blk_mq_tagset_busy_iter() here and all current users
just set queue as NULL which means have no queue filter.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3cf3cf72cd54..dc4edde3c80a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -381,15 +381,18 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		to continue iterating tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @flags:	BT_TAG_ITER_*
+ * @q:		Only iterate over requests of this queue.
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, unsigned int flags)
+			     busy_tag_iter_fn *fn, void *data, unsigned int flags,
+			     struct request_queue *q)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
 		.flags = flags,
+		.q = q,
 	};
 
 	if (tags->rqs)
@@ -397,14 +400,15 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 }
 
 static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv, unsigned int flags)
+		busy_tag_iter_fn *fn, void *priv, unsigned int flags,
+		struct request_queue *q)
 {
 	WARN_ON_ONCE(flags & BT_TAG_ITER_RESERVED);
 
 	if (tags->nr_reserved_tags)
 		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
-				 flags | BT_TAG_ITER_RESERVED);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
+				 flags | BT_TAG_ITER_RESERVED, q);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags, q);
 }
 
 /**
@@ -422,7 +426,23 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
+	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS, NULL);
+}
+
+static void __blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
+				      busy_tag_iter_fn *fn, void *priv,
+				      struct request_queue *q)
+{
+	unsigned int flags = tagset->flags;
+	int i, nr_tags;
+
+	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
+
+	for (i = 0; i < nr_tags; i++) {
+		if (tagset->tags && tagset->tags[i])
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED, q);
+	}
 }
 
 /**
@@ -441,16 +461,7 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
-	unsigned int flags = tagset->flags;
-	int i, nr_tags;
-
-	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
-
-	for (i = 0; i < nr_tags; i++) {
-		if (tagset->tags && tagset->tags[i])
-			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
-					      BT_TAG_ITER_STARTED);
-	}
+	__blk_mq_tagset_busy_iter(tagset, fn, priv, NULL);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-- 
2.40.1


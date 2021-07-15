Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ACBC07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4156B61360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhGONdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:33:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbhGONdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 09:33:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 66AE71FE27;
        Thu, 15 Jul 2021 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626355827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwo33Naj/CPFidpZeosCdaEDnv3XgY9VCBciCRXHwWw=;
        b=FCJrhGxVLppxZASb7CGalncGBtH0S3Jb1RvaYdc/t+c8U1mPJIAhruAFzBm+v5Kmqg5Sai
        i1Gm65iRv0RtKHkL6haH9neK/fuk6C84w45vWt+ofLgl/Qwkd2JLBLrfCttPfGgG921lKG
        jg/O3GQ2aYKitr/QaL69kADVDhuPixM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626355827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwo33Naj/CPFidpZeosCdaEDnv3XgY9VCBciCRXHwWw=;
        b=eWQCKqD94NZUmtFrPl3D+MmBleg/RT5GAS5xVU+cW5u1mB0Ru1hpSBeyV4V7EZxhsBNUKY
        OYU/jTi42HyAoCCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 58E2EA3B9B;
        Thu, 15 Jul 2021 13:30:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 39ECF1E0BF8; Thu, 15 Jul 2021 15:30:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] bfq: Limit number of requests consumed by each cgroup
Date:   Thu, 15 Jul 2021 15:30:19 +0200
Message-Id: <20210715133027.23975-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715132047.20874-1-jack@suse.cz>
References: <20210715132047.20874-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6369; h=from:subject; bh=Bp/OSDW5Rjr0UeO2reqvBpkYjy5sYrS7zC7p9jDV+Nc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8Dhrq6VWQjZY4UnX53DHpzTqIe8h6p2MzOlj4Zap TTN89HKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA4awAKCRCcnaoHP2RA2akCB/ 9mUxSBzvtUGjlpomqcV67PaLox+msu0iERsheXwT7Vsr/lukmy2JEO4q7L+Uijh4n78YET1UsJigdl Cm10Sn+EcrUDMzFV1hvDQuhWLe8fgF9CzX6vKSt1lgYZvsFU620OY1kU5yNxjOeysg+dARnGgDH19f 2NsG1G/Az7hqLDRs56JPwGbiENxZfdoUTHG1IXWl8mwrDkQM4B6nTlNAO1AUQ2RPl11m+F+l+KrsT4 JBKfH05G+iSXQgmMpb9sm52aWqiNjFnLf34I0biH65gu02Wae+q6jNUgQiCSiyRVTOD+kB7aHm8vBW 4MLmxwXD5kIHlfV7FEwuAgIqffvr+i
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When cgroup IO scheduling is used with BFQ it does not really provide
service differentiation if the cgroup drives a big IO depth. That for
example happens with writeback which asynchronously submits lots of IO
but it can happen with AIO as well. The problem is that if we have two
cgroups that submit IO with different weights, the cgroup with higher
weight properly gets more IO time and is able to dispatch more IO.
However this causes lower weight cgroup to accumulate more requests
inside BFQ and eventually lower weight cgroup consumes most of IO
scheduler tags. At that point higher weight cgroup stops getting better
service as it is mostly blocked waiting for a scheduler tag while its
queues inside BFQ are empty and thus lower weight cgroup gets served.

Check how many requests submitting cgroup has allocated in
bfq_limit_depth() and if it consumes more requests than what would
correspond to its weight limit available depth to 1 so that the cgroup
cannot consume many more requests. With this limitation the higher
weight cgroup gets proper service even with writeback.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 103 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9ef057dc0028..8f9b4904934b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -565,6 +565,71 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 	}
 }
 
+#define BFQ_LIMIT_INLINE_DEPTH 16
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+{
+	struct bfq_data *bfqd = bfqq->bfqd;
+	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_entity *inline_entities[BFQ_LIMIT_INLINE_DEPTH];
+	struct bfq_entity **entities = inline_entities;
+	int depth, level;
+	bool ret = false;
+
+	if (!entity->on_st_or_in_serv)
+		return false;
+
+	/* +1 for bfqq entity, root cgroup not included */
+	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
+	if (depth > BFQ_LIMIT_INLINE_DEPTH) {
+		entities = kmalloc_array(depth, sizeof(*entities), GFP_NOIO);
+		if (!entities)
+			return false;
+	}
+
+	spin_lock_irq(&bfqd->lock);
+	if (!entity->on_st_or_in_serv)
+		goto out;
+	/* Gather our ancestors as we need to traverse them in reverse order */
+	level = 0;
+	for_each_entity(entity) {
+		/* Uh, more parents than cgroup subsystem thinks? */
+		if (WARN_ON_ONCE(level >= depth))
+			break;
+		entities[level++] = entity;
+	}
+	WARN_ON_ONCE(level != depth);
+	for (level--; level >= 0; level--) {
+		entity = entities[level];
+		/*
+		 * If the leaf entity has work to do, parents should be tracked
+		 * as well.
+		 */
+		WARN_ON_ONCE(!entity->on_st_or_in_serv);
+		limit = DIV_ROUND_CLOSEST(limit * entity->weight,
+					bfq_entity_service_tree(entity)->wsum);
+		if (entity->allocated >= limit) {
+			bfq_log_bfqq(bfqq->bfqd, bfqq,
+				"too many requests: allocated %d limit %d level %d",
+				entity->allocated, limit, level);
+			ret = true;
+			break;
+		}
+	}
+out:
+	spin_unlock_irq(&bfqd->lock);
+	if (entities != inline_entities)
+		kfree(entities);
+	return ret;
+}
+#else
+static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+{
+	return false;
+}
+#endif
+
 /*
  * Async I/O can easily starve sync I/O (both sync reads and sync
  * writes), by consuming all tags. Similarly, storms of sync writes,
@@ -575,16 +640,28 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
+	struct bfq_io_cq *bic = data->icq ? icq_to_bic(data->icq) : NULL;
+	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(op)) : NULL;
+	int depth;
 
+	/* Sync reads have full depth available */
 	if (op_is_sync(op) && !op_is_write(op))
-		return;
+		depth = 0;
+	else
+		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
 
-	data->shallow_depth =
-		bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+	/*
+	 * Does queue (or any parent entity) exceed number of requests that
+	 * should be available to it? Heavily limit depth so that it cannot
+	 * consume more available requests and thus starve other entities.
+	 */
+	if (bfqq && bfqq_request_over_limit(bfqq, data->q->nr_requests))
+		depth = 1;
 
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
-			__func__, bfqd->wr_busy_queues, op_is_sync(op),
-			data->shallow_depth);
+		__func__, bfqd->wr_busy_queues, op_is_sync(op), depth);
+	if (depth)
+		data->shallow_depth = depth;
 }
 
 static struct bfq_queue *
@@ -6848,11 +6925,8 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
  * See the comments on bfq_limit_depth for the purpose of
  * the depths set in the function. Return minimum shallow depth we'll use.
  */
-static unsigned int bfq_update_depths(struct bfq_data *bfqd,
-				      struct sbitmap_queue *bt)
+static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 {
-	unsigned int i, j, min_shallow = UINT_MAX;
-
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
@@ -6883,22 +6957,15 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
 	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
-
-	for (i = 0; i < 2; i++)
-		for (j = 0; j < 2; j++)
-			min_shallow = min(min_shallow, bfqd->word_depths[i][j]);
-
-	return min_shallow;
 }
 
 static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
 {
 	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 	struct blk_mq_tags *tags = hctx->sched_tags;
-	unsigned int min_shallow;
 
-	min_shallow = bfq_update_depths(bfqd, tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, min_shallow);
+	bfq_update_depths(bfqd, tags->bitmap_tags);
+	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, 1);
 }
 
 static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
-- 
2.26.2


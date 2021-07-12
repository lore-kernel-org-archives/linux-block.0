Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA0C11F66
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D688F61222
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhGLRap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:30:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhGLRao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 13:30:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8F4E21FD5F;
        Mon, 12 Jul 2021 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626110875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/JvUq8Nxd1rWCAL3yyFE7fFdgyAuDisT3eFOL7/cLI=;
        b=pbR3wyZmqzNBTdzUXuVEjpbJ+zyir4KrMfan6CFtclTy9We4Gwh0kW7P4tUZsrfWpnCSSq
        uSVZtJiN44hhTEqhI9yBpl1a+5TPOS8MM9NAKQORZ3qkDA3eyUjhiSFhzk2HgfiEc6McV2
        jyimq4EA8gpuYTOfdvAh0igvEiuVebY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626110875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/JvUq8Nxd1rWCAL3yyFE7fFdgyAuDisT3eFOL7/cLI=;
        b=MN2jla+/xy7lLZd313Z2dUhTrj4nTETrBRbzme9Xin0aIThAy8bObH5NfCOpWxD9RctSp5
        Y/iTdADmSWGeVEAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 81CBDA3B83;
        Mon, 12 Jul 2021 17:27:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6B0DA1F2CCB; Mon, 12 Jul 2021 19:27:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, mkoutny@suse.cz,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] bfq: Limit number of requests consumed by each cgroup
Date:   Mon, 12 Jul 2021 19:27:39 +0200
Message-Id: <20210712172755.2414-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712171146.12231-1-jack@suse.cz>
References: <20210712171146.12231-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5037; h=from:subject; bh=3Ulr6KjQkchbARmJnlEme3XKQ6fHa9z5THtoJJg2tpg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HuKtutHAcm0A81XiLKHy74IvfkxLDE2C8W88bwP +EG5DX+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx7igAKCRCcnaoHP2RA2e6RCA DuajF2wB5t8j1uA9/kHxs/bJZ9OThm4xkRCd/7nHArL6ShffzF/R9a7cIhcFOWPFWlC50eEJC/SPBu cWdeo3NysCDBwrHXju31//Bu82yPrzWHmp34W8YNKk5Nmeu3d6OLfUYArmK20YTPXP7vtPrhsf70tq aye6e1MowEC6+LK7/wndooNJ9wM4vS0hMJR/o5/cdiM6YwyB7/ggQzEwD8htm5X65er0s5JO4KEELy S9z5RkKjmr6wM0yNQYpLpFm7joi/8RpjLnkKxdL8VjqJ/+y027LOTOHOc+BibzlixrRFfPDZsjk3bO frhC1vEpTNlcIeIxF27kM0+QuTlNNh
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
 block/bfq-iosched.c | 54 ++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9ef057dc0028..fad54c11c43f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -565,6 +565,22 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
 	}
 }
 
+static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	for_each_entity(entity) {
+		if (entity->on_st_or_in_serv &&
+		    entity->allocated >= limit * entity->weight /
+					bfq_entity_service_tree(entity)->wsum) {
+			bfq_log_bfqq(bfqq->bfqd, bfqq, "too many requests: allocated %d limit %d weight %d wsum %lu",
+				entity->allocated, limit, entity->weight, bfq_entity_service_tree(entity)->wsum);
+			return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Async I/O can easily starve sync I/O (both sync reads and sync
  * writes), by consuming all tags. Similarly, storms of sync writes,
@@ -575,16 +591,28 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
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
@@ -6848,11 +6876,8 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
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
@@ -6883,22 +6908,15 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
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


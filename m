Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4236C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhKWKfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A6D41FD5A;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e700UlOYR0WiOFMrAmvDZKz6BwvRL88oCTmYpVjyu1Q=;
        b=Ct83bqGt1NHYFea2+ezeJyBd2Ef3qeOKA18X1LBkvRGtwciC2Ub7jQaYIyjc51JpwEVAbR
        MD79gzkLKpzOwjSMM01sHamsF2JlIn1ek47VgBzsFSjChhSIG+l6urKlN0c/ZY3P//TBwk
        hhFuYtabFhOtCZzS3l6hLpqOlaL991Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e700UlOYR0WiOFMrAmvDZKz6BwvRL88oCTmYpVjyu1Q=;
        b=R4e82Ek/Cf/u8EnMRewLJdgqoANFUmc0B3HFVmGb5+7tlTdoF2sANmPHofX93JYTw25TMX
        YnKb/n8U6nOEDOCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 90B5FA3B88;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E07F1E1972; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH 4/8] bfq: Limit number of requests consumed by each cgroup
Date:   Tue, 23 Nov 2021 11:29:16 +0100
Message-Id: <20211123103158.17284-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7752; h=from:subject; bh=Gm1zGcMoN3V9o1l/0aQz6iBtDMJmEwZC1w1mfAW7zEE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ72d2QRqfjt3bdazDRz9IUMW2XN/JZDtHRN4v1 YAs3skqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCewAKCRCcnaoHP2RA2cn4B/ 9KO8m4ky911zvtzJX+NTc1RgDKbNB1Z2KcoN91hF0hT/2K30nCJEqEQ8172i1iRwIcsNVkWj4iLSgY rvaolupGU42jvV6gXhbn16PUyM6zfi+6ISYUg+M7ahAz4sTm7wNCNGHGwk60Z7VwppKazSmo29TKsz gcrLkqPfRqFH07sNPFRtYhQqX9AflGuBFHkiI6p1XXnIRtAkTzKpd05iRIFjlRjQ4iksRKyUmaqmXm eMMaSEgwqY6qaxvTsBMJMHpFo/niZFvZ62yZi/rIJTaHg8inLg+4Tb6wndL4QrZKEgKPPdn1urVqMe oRyeffwmo65oeJEjkO/Au5MjG/ButO
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

Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 137 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 19 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1fef82bf4a55..36ee407cebc6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -565,26 +565,134 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
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
+	int class_idx = bfqq->ioprio_class - 1;
+	struct bfq_sched_data *sched_data;
+	unsigned long wsum;
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
+	sched_data = entity->sched_data;
+	/* Gather our ancestors as we need to traverse them in reverse order */
+	level = 0;
+	for_each_entity(entity) {
+		/*
+		 * If at some level entity is not even active, allow request
+ 		 * queueing so that BFQ knows there's work to do and activate
+		 * entities.
+		 */
+		if (!entity->on_st_or_in_serv)
+			goto out;
+		/* Uh, more parents than cgroup subsystem thinks? */
+		if (WARN_ON_ONCE(level >= depth))
+			break;
+		entities[level++] = entity;
+	}
+	WARN_ON_ONCE(level != depth);
+	for (level--; level >= 0; level--) {
+		entity = entities[level];
+		if (level > 0) {
+			wsum = bfq_entity_service_tree(entity)->wsum;
+		} else {
+			int i;
+			/*
+			 * For bfqq itself we take into account service trees
+			 * of all higher priority classes and multiply their
+			 * weights so that low prio queue from higher class
+			 * gets more requests than high prio queue from lower
+			 * class.
+			 */
+			wsum = 0;
+			for (i = 0; i <= class_idx; i++) {
+				wsum = wsum * IOPRIO_BE_NR +
+					sched_data->service_tree[i].wsum;
+			}
+		}
+		limit = DIV_ROUND_CLOSEST(limit * entity->weight, wsum);
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
  * such as those that sync(2) may trigger, can starve sync reads.
  * Limit depths of async I/O and sync writes so as to counter both
  * problems.
+ *
+ * Also if a bfq queue or its parent cgroup consume more tags than would be
+ * appropriate for their weight, we trim the available tag depth to 1. This
+ * avoids a situation where one cgroup can starve another cgroup from tags and
+ * thus block service differentiation among cgroups. Note that because the
+ * queue / cgroup already has many requests allocated and queued, this does not
+ * significantly affect service guarantees coming from the BFQ scheduling
+ * algorithm.
  */
 static void bfq_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 {
 	struct bfq_data *bfqd = data->q->elevator->elevator_data;
+	struct bfq_io_cq *bic = data->icq ? icq_to_bic(data->icq) : NULL;
+	struct bfq_queue *bfqq = bic ? bic_to_bfqq(bic, op_is_sync(op)) : NULL;
+	int depth;
+	unsigned limit = data->q->nr_requests;
+
+	/* Sync reads have full depth available */
+	if (op_is_sync(op) && !op_is_write(op)) {
+		depth = 0;
+	} else {
+		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+		limit = (limit * depth) >> bfqd->full_depth_shift;
+	}
 
-	if (op_is_sync(op) && !op_is_write(op))
-		return;
-
-	data->shallow_depth =
-		bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+	/*
+	 * Does queue (or any parent entity) exceed number of requests that
+	 * should be available to it? Heavily limit depth so that it cannot
+	 * consume more available requests and thus starve other entities.
+	 */
+	if (bfqq && bfqq_request_over_limit(bfqq, limit))
+		depth = 1;
 
 	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
-			__func__, bfqd->wr_busy_queues, op_is_sync(op),
-			data->shallow_depth);
+		__func__, bfqd->wr_busy_queues, op_is_sync(op), depth);
+	if (depth)
+		data->shallow_depth = depth;
 }
 
 static struct bfq_queue *
@@ -6851,10 +6959,8 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
  * See the comments on bfq_limit_depth for the purpose of
  * the depths set in the function. Return minimum shallow depth we'll use.
  */
-static unsigned int bfq_update_depths(struct bfq_data *bfqd,
-				      struct sbitmap_queue *bt)
+static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
 {
-	unsigned int i, j, min_shallow = UINT_MAX;
 	unsigned int depth = 1U << bt->sb.shift;
 
 	bfqd->full_depth_shift = bt->sb.shift;
@@ -6888,22 +6994,15 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	bfqd->word_depths[1][0] = max((depth * 3) >> 4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
 	bfqd->word_depths[1][1] = max((depth * 6) >> 4, 1U);
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
 
-	min_shallow = bfq_update_depths(bfqd, &tags->bitmap_tags);
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, min_shallow);
+	bfq_update_depths(bfqd, &tags->bitmap_tags);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
 }
 
 static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
-- 
2.26.2


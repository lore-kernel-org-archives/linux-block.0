Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164BC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3012085B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQyLqjJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfA2LIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:08:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53592 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfA2LHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so17344476wmb.3
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqaJMhHhfa+weQuFHVAWQG1S7lc+lO9DghKMucIuInE=;
        b=RQyLqjJkLnXNErvrLwkz6/bNzX/uXTTeUHDCjG6NXq6xDaRWgLdnjLRygLiCuODTsx
         L/FBcJHYMh6Rj7nfy/e3yHNwqE1Q+nk3jp99ALN6zDKFZjcTqsYZJWJ98u0kfWiryCFU
         QNwJf/9aBcD34eR7Eti129p1MBKHZz7TcmHIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqaJMhHhfa+weQuFHVAWQG1S7lc+lO9DghKMucIuInE=;
        b=Cqi0q6+vg+VRjUnTEf2uJ2XNtP/iwlT7aCNaspdUzZRn1bajKx6sIwHALAQArXk5h0
         nZ+cE4oR4jf4ovNedNAn4dHm3Ti/tR+ikaaHWSUt2yweZZFpmByzlrkbRjaPDKk5t7ui
         PufSmIY681EsIIzWOW3xV8TQE7XqzGVyLjBpERkTMA9RJR0kmvh8D2MnTKOguQSQwbsN
         pzpKBJQAQvJs0TF4XVyvGYYjOpaMuFA68wU+TsRNV07ktbhgoaY1G004twIpQZgs9OC/
         5UYc30lYUJUHXOF0lmLbI9kqWZML1nLwpMFg1tUORh3tVeRF1ezTfzzmT2+DTNpv4EfM
         cqTA==
X-Gm-Message-State: AHQUAuYzQx8qjU7Zw4rx8BspT/09/0DulwTrDeW0Ka6SCCbroFFHRnQe
        jCqMZ+4MPALBgIHOqYCCYMVzcQ==
X-Google-Smtp-Source: AHgI3IZuKp0rYO0AUupSe03vR5gKzD5AA9e/e0m3XD2/rvBM6QZESFLieD9MLxzgRuyF302jYWwgFw==
X-Received: by 2002:a1c:4c9:: with SMTP id 192mr10565730wme.135.1548760023620;
        Tue, 29 Jan 2019 03:07:03 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:02 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 05/14] block, bfq: consider also ioprio classes in symmetry detection
Date:   Tue, 29 Jan 2019 12:06:29 +0100
Message-Id: <20190129110638.12652-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In asymmetric scenarios, i.e., when some bfq_queue or bfq_group needs
to be guaranteed a different bandwidth than other bfq_queues or
bfq_groups, these service guaranteed can be provided only by plugging
I/O dispatch, completely or partially, when the queue in service
remains temporarily empty. A case where asymmetry is particularly
strong is when some active bfq_queues belong to a higher-priority
class than some other active bfq_queues. Unfortunately, this important
case is not considered at all in the code for detecting asymmetric
scenarios. This commit adds the missing logic.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 86 ++++++++++++++++++++++++---------------------
 block/bfq-iosched.h |  8 +++--
 block/bfq-wf2q.c    | 12 +++++--
 3 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a9275ed57726..6bfbfa65610b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -623,26 +623,6 @@ void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		bfqq->pos_root = NULL;
 }
 
-/*
- * Tell whether there are active queues with different weights or
- * active groups.
- */
-static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
-{
-	/*
-	 * For queue weights to differ, queue_weights_tree must contain
-	 * at least two nodes.
-	 */
-	return (!RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
-		(bfqd->queue_weights_tree.rb_node->rb_left ||
-		 bfqd->queue_weights_tree.rb_node->rb_right)
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       ) ||
-		(bfqd->num_groups_with_pending_reqs > 0
-#endif
-	       );
-}
-
 /*
  * The following function returns true if every queue must receive the
  * same share of the throughput (this condition is used when deciding
@@ -651,25 +631,48 @@ static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
  *
  * Such a scenario occurs when:
  * 1) all active queues have the same weight,
- * 2) all active groups at the same level in the groups tree have the same
- *    weight,
+ * 2) all active queues belong to the same I/O-priority class,
  * 3) all active groups at the same level in the groups tree have the same
+ *    weight,
+ * 4) all active groups at the same level in the groups tree have the same
  *    number of children.
  *
  * Unfortunately, keeping the necessary state for evaluating exactly
  * the last two symmetry sub-conditions above would be quite complex
- * and time consuming.  Therefore this function evaluates, instead,
- * only the following stronger two sub-conditions, for which it is
+ * and time consuming. Therefore this function evaluates, instead,
+ * only the following stronger three sub-conditions, for which it is
  * much easier to maintain the needed state:
  * 1) all active queues have the same weight,
- * 2) there are no active groups.
+ * 2) all active queues belong to the same I/O-priority class,
+ * 3) there are no active groups.
  * In particular, the last condition is always true if hierarchical
  * support or the cgroups interface are not enabled, thus no state
  * needs to be maintained in this case.
  */
 static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
 {
-	return !bfq_varied_queue_weights_or_active_groups(bfqd);
+	/*
+	 * For queue weights to differ, queue_weights_tree must contain
+	 * at least two nodes.
+	 */
+	bool varied_queue_weights = !RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
+		(bfqd->queue_weights_tree.rb_node->rb_left ||
+		 bfqd->queue_weights_tree.rb_node->rb_right);
+
+	bool multiple_classes_busy =
+		(bfqd->busy_queues[0] && bfqd->busy_queues[1]) ||
+		(bfqd->busy_queues[0] && bfqd->busy_queues[2]) ||
+		(bfqd->busy_queues[1] && bfqd->busy_queues[2]);
+
+	/*
+	 * For queue weights to differ, queue_weights_tree must contain
+	 * at least two nodes.
+	 */
+	return !(varied_queue_weights || multiple_classes_busy
+#ifdef BFQ_GROUP_IOSCHED_ENABLED
+	       || bfqd->num_groups_with_pending_reqs > 0
+#endif
+		);
 }
 
 /*
@@ -728,15 +731,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	/*
 	 * In the unlucky event of an allocation failure, we just
 	 * exit. This will cause the weight of queue to not be
-	 * considered in bfq_varied_queue_weights_or_active_groups,
-	 * which, in its turn, causes the scenario to be deemed
-	 * wrongly symmetric in case bfqq's weight would have been
-	 * the only weight making the scenario asymmetric.  On the
-	 * bright side, no unbalance will however occur when bfqq
-	 * becomes inactive again (the invocation of this function
-	 * is triggered by an activation of queue).  In fact,
-	 * bfq_weights_tree_remove does nothing if
-	 * !bfqq->weight_counter.
+	 * considered in bfq_symmetric_scenario, which, in its turn,
+	 * causes the scenario to be deemed wrongly symmetric in case
+	 * bfqq's weight would have been the only weight making the
+	 * scenario asymmetric.  On the bright side, no unbalance will
+	 * however occur when bfqq becomes inactive again (the
+	 * invocation of this function is triggered by an activation
+	 * of queue).  In fact, bfq_weights_tree_remove does nothing
+	 * if !bfqq->weight_counter.
 	 */
 	if (unlikely(!bfqq->weight_counter))
 		return;
@@ -2227,7 +2229,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		return NULL;
 
 	/* If there is only one backlogged queue, don't search. */
-	if (bfqd->busy_queues == 1)
+	if (bfq_tot_busy_queues(bfqd) == 1)
 		return NULL;
 
 	in_service_bfqq = bfqd->in_service_queue;
@@ -3681,7 +3683,8 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * the requests already queued in the device have been served.
 	 */
 	asymmetric_scenario = (bfqq->wr_coeff > 1 &&
-			       bfqd->wr_busy_queues < bfqd->busy_queues) ||
+			       bfqd->wr_busy_queues <
+			       bfq_tot_busy_queues(bfqd)) ||
 		!bfq_symmetric_scenario(bfqd);
 
 	/*
@@ -3960,7 +3963,7 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	 * belongs to CLASS_IDLE and other queues are waiting for
 	 * service.
 	 */
-	if (!(bfqd->busy_queues > 1 && bfq_class_idle(bfqq)))
+	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
 		goto return_rq;
 
 	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
@@ -3978,7 +3981,7 @@ static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 	 * most a call to dispatch for nothing
 	 */
 	return !list_empty_careful(&bfqd->dispatch) ||
-		bfqd->busy_queues > 0;
+		bfq_tot_busy_queues(bfqd) > 0;
 }
 
 static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
@@ -4032,9 +4035,10 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		goto start_rq;
 	}
 
-	bfq_log(bfqd, "dispatch requests: %d busy queues", bfqd->busy_queues);
+	bfq_log(bfqd, "dispatch requests: %d busy queues",
+		bfq_tot_busy_queues(bfqd));
 
-	if (bfqd->busy_queues == 0)
+	if (bfq_tot_busy_queues(bfqd) == 0)
 		goto exit;
 
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 0b02bf302de0..30be669be465 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -501,10 +501,11 @@ struct bfq_data {
 	unsigned int num_groups_with_pending_reqs;
 
 	/*
-	 * Number of bfq_queues containing requests (including the
-	 * queue in service, even if it is idling).
+	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
+	 * requests (including the queue in service, even if it is
+	 * idling).
 	 */
-	int busy_queues;
+	unsigned int busy_queues[3];
 	/* number of weight-raised busy @bfq_queues */
 	int wr_busy_queues;
 	/* number of queued requests */
@@ -974,6 +975,7 @@ extern struct blkcg_policy blkcg_policy_bfq;
 
 struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
 struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
 struct bfq_entity *bfq_entity_of(struct rb_node *node);
 unsigned short bfq_ioprio_to_weight(int ioprio);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 72adbbe975d5..ce37d709a34f 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -44,6 +44,12 @@ static unsigned int bfq_class_idx(struct bfq_entity *entity)
 		BFQ_DEFAULT_GRP_CLASS - 1;
 }
 
+unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd)
+{
+	return bfqd->busy_queues[0] + bfqd->busy_queues[1] +
+		bfqd->busy_queues[2];
+}
+
 static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
 						 bool expiration);
 
@@ -1513,7 +1519,7 @@ struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 	struct bfq_sched_data *sd;
 	struct bfq_queue *bfqq;
 
-	if (bfqd->busy_queues == 0)
+	if (bfq_tot_busy_queues(bfqd) == 0)
 		return NULL;
 
 	/*
@@ -1665,7 +1671,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfq_clear_bfqq_busy(bfqq);
 
-	bfqd->busy_queues--;
+	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
 
 	if (!bfqq->dispatched)
 		bfq_weights_tree_remove(bfqd, bfqq);
@@ -1688,7 +1694,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_activate_bfqq(bfqd, bfqq);
 
 	bfq_mark_bfqq_busy(bfqq);
-	bfqd->busy_queues++;
+	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
 
 	if (!bfqq->dispatched)
 		if (bfqq->wr_coeff == 1)
-- 
2.20.1


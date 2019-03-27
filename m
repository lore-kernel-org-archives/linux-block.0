Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F20C10F00
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6252064A
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714282;
	bh=J/++bZj6EMAxb1LPDclSEOFVVjmZFr85edmg43Bb2Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zaJbQeOyv8/ixfUPpQn2IzIZ/a2ruEH2DPE3w/0TD5GJoSGVL6qm74ta26ZJzTtbT
	 u5jaJ/arPbvFS6FX1IiED8oVTlxaAFc+nYpsK9J4W1ZYZPQdaSePuQfc6/mIUw4XIo
	 az47VR3Clt+m4h4NOREAWvjnf7HWCUZN5zOI6SgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfC0SIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfC0SIa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCED021738;
        Wed, 27 Mar 2019 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710109;
        bh=J/++bZj6EMAxb1LPDclSEOFVVjmZFr85edmg43Bb2Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f545AhMQYS1XqY0wKTBtBkikWxYKcJL92oAN4ZELDPnpNh5+ihJhyi1jNqsBFPl6i
         QtAGmHoWCedXqe0u6pYqggqXnsvwIycz+H8oOg/ilEzIk7UtcUd7ETUYl4nx9AXxWd
         Z8GybNezfR71IqrfnE6ynqSxuE9jnNAWEzjys34g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 199/262] block, bfq: fix queue removal from weights tree
Date:   Wed, 27 Mar 2019 14:00:54 -0400
Message-Id: <20190327180158.10245-199-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

[ Upstream commit 9dee8b3b057e1da26f85f1842f2aaf3bb200fb94 ]

bfq maintains an ordered list, through a red-black tree, of unique
weights of active bfq_queues. This list is used to detect whether there
are active queues with differentiated weights. The weight of a queue is
removed from the list when both the following two conditions become
true:

(1) the bfq_queue is flagged as inactive
(2) the has no in-flight request any longer;

Unfortunately, in the rare cases where condition (2) becomes true before
condition (1), the removal fails, because the function to remove the
weight of the queue (bfq_weights_tree_remove) is rightly invoked in the
path that deactivates the bfq_queue, but mistakenly invoked *before* the
function that actually performs the deactivation (bfq_deactivate_bfqq).

This commits moves the invocation of bfq_weights_tree_remove for
condition (1) to after bfq_deactivate_bfqq. As a consequence of this
move, it is necessary to add a further reference to the queue when the
weight of a queue is added, because the queue might otherwise be freed
before bfq_weights_tree_remove is invoked. This commit adds this
reference and makes all related modifications.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 17 +++++++++++++----
 block/bfq-wf2q.c    |  6 +++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f010810c095f..e5ed28629271 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -747,6 +747,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 inc_counter:
 	bfqq->weight_counter->num_active++;
+	bfqq->ref++;
 }
 
 /*
@@ -771,6 +772,7 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 
 reset_entity_pointer:
 	bfqq->weight_counter = NULL;
+	bfq_put_queue(bfqq);
 }
 
 /*
@@ -782,9 +784,6 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 {
 	struct bfq_entity *entity = bfqq->entity.parent;
 
-	__bfq_weights_tree_remove(bfqd, bfqq,
-				  &bfqd->queue_weights_tree);
-
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
@@ -818,6 +817,15 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			bfqd->num_groups_with_pending_reqs--;
 		}
 	}
+
+	/*
+	 * Next function is invoked last, because it causes bfqq to be
+	 * freed if the following holds: bfqq is not in service and
+	 * has no dispatched request. DO NOT use bfqq after the next
+	 * function invocation.
+	 */
+	__bfq_weights_tree_remove(bfqd, bfqq,
+				  &bfqd->queue_weights_tree);
 }
 
 /*
@@ -1011,7 +1019,8 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st;
+	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st -
+		(bfqq->weight_counter != NULL);
 }
 
 /* Empty burst list and add just bfqq (see comments on bfq_handle_burst) */
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 72adbbe975d5..4aab1a8191f0 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1667,15 +1667,15 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqd->busy_queues--;
 
-	if (!bfqq->dispatched)
-		bfq_weights_tree_remove(bfqd, bfqq);
-
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues--;
 
 	bfqg_stats_update_dequeue(bfqq_group(bfqq));
 
 	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
+
+	if (!bfqq->dispatched)
+		bfq_weights_tree_remove(bfqd, bfqq);
 }
 
 /*
-- 
2.19.1


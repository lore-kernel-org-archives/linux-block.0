Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F6C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE0920868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQUJpn77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE0920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFSSq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:18:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45344 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLFSSf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:18:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id b14so1403879wru.12
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEWTYFxHD6jSePp1DOJ6lK2N9qNF0TKxvyVLNROZM4c=;
        b=DQUJpn77whLW4EgtacgtSO29oQnKcdxeWTKC5/51avbJDTGVAIzD3ZzyNji1tM9K7w
         BjpjqE2Z8B5bzFqYwz3ADJJTwOokGdGKaliXMYihKi6gqFJfJpT6sBCkXZKif/fypn/G
         +vkgW4FORJkFUC32jEqIRaeapnrdd3tBoVXFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nEWTYFxHD6jSePp1DOJ6lK2N9qNF0TKxvyVLNROZM4c=;
        b=LBpk8YkvKm6jgFVWbGgwXfSXqRR8TpYYRS6F+ieEniU/hoRAgWBp1y/mexDqdZiI3G
         ke1iRwP5xhyH+zasGD6S764bVklcluNIQxjtVmWUyPbium/Px73YdH7TfCPSuTWWAFU+
         ZTHRhyGvUZ8K23uyGaGzMhJNsXk5RTfaU7/n73BYFbslhXbrg7zpRmc5U1nIP6tBxiSG
         Yjwuf2eJoVZebF6aQMLgJ//zztbgVWKDTTlteH/u4RHFIkr3mc6Vq4WgtesNW2nkRQLF
         u9ZSZ5TBHcWP5SrQaPWmFmlqZBlbOFA+OhynutHNvnp2wtsKfe+1Oais8AsFrO+8BPz4
         SYyQ==
X-Gm-Message-State: AA+aEWYwgQBkUm+M4Mv5bPa8ThMISXwTt618rXYwQyV2vJNMiTo8Nnuy
        2grISUXYAZ5xcrbEn08IrKNn5w==
X-Google-Smtp-Source: AFSGD/W6z8xSV4GCrY5XWiuiLUGXWT7xt9ddnpTxctdn1PodtOzQZtHOHn0vFrSKJvg2SpMJWx8ISQ==
X-Received: by 2002:adf:e509:: with SMTP id j9mr27910785wrm.76.1544120312509;
        Thu, 06 Dec 2018 10:18:32 -0800 (PST)
Received: from localhost.localdomain (146-241-0-214.dyn.eolo.it. [146.241.0.214])
        by smtp.gmail.com with ESMTPSA id w18sm727733wru.54.2018.12.06.10.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:18:31 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 1/2] block, bfq: fix decrement of num_active_groups
Date:   Thu,  6 Dec 2018 19:18:18 +0100
Message-Id: <20181206181819.11148-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181206181819.11148-1-paolo.valente@linaro.org>
References: <20181206181819.11148-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit '2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
detection")', if there are process groups with I/O requests waiting for
completion, then BFQ tags the scenario as 'asymmetric'. This detection
is needed for preserving service guarantees (for details, see comments
on the computation * of the variable asymmetric_scenario in the
function bfq_better_to_idle).

Unfortunately, commit '2d29c9f89fcd ("block, bfq: improve asymmetric
scenarios detection")' contains an error exactly in the updating of
the number of groups with I/O requests waiting for completion: if a
group has more than one descendant process, then the above number of
groups, which is renamed from num_active_groups to a more appropriate
num_groups_with_pending_reqs by this commit, may happen to be wrongly
decremented multiple times, namely every time one of the descendant
processes gets all its pending I/O requests completed.

A correct, complete solution should work as follows. Consider a group
that is inactive, i.e., that has no descendant process with pending
I/O inside BFQ queues. Then suppose that num_groups_with_pending_reqs
is still accounting for this group, because the group still has some
descendant process with some I/O request still in
flight. num_groups_with_pending_reqs should be decremented when the
in-flight request of the last descendant process is finally completed
(assuming that nothing else has changed for the group in the meantime,
in terms of composition of the group and active/inactive state of
child groups and processes). To accomplish this, an additional
pending-request counter must be added to entities, and must be
updated correctly.

To avoid this additional field and operations, this commit resorts to
the following tradeoff between simplicity and accuracy: for an
inactive group that is still counted in num_groups_with_pending_reqs,
this commit decrements num_groups_with_pending_reqs when the first
descendant process of the group remains with no request waiting for
completion.

This simplified scheme provides a fix to the unbalanced decrements
introduced by 2d29c9f89fcd. Since this error was also caused by lack
of comments on this non-trivial issue, this commit also adds related
comments.

Fixes: 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios detection")
Reported-by: Steven Barrett <steven@liquorix.net>
Tested-by: Steven Barrett <steven@liquorix.net>
Tested-by: Lucjan Lucjanov <lucjan.lucjanov@gmail.com>
Reviewed-by: Federico Motta <federico@willer.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 76 +++++++++++++++++++++++++++++++++++++----------------
 block/bfq-iosched.h | 51 +++++++++++++++++++++++++++++++++--
 block/bfq-wf2q.c    |  5 +++-
 3 files changed, 107 insertions(+), 25 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3a27d31fcda6..97337214bec4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -638,7 +638,7 @@ static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
 		 bfqd->queue_weights_tree.rb_node->rb_right)
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	       ) ||
-		(bfqd->num_active_groups > 0
+		(bfqd->num_groups_with_pending_reqs > 0
 #endif
 	       );
 }
@@ -802,7 +802,21 @@ void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			 */
 			break;
 		}
-		bfqd->num_active_groups--;
+
+		/*
+		 * The decrement of num_groups_with_pending_reqs is
+		 * not performed immediately upon the deactivation of
+		 * entity, but it is delayed to when it also happens
+		 * that the first leaf descendant bfqq of entity gets
+		 * all its pending requests completed. The following
+		 * instructions perform this delayed decrement, if
+		 * needed. See the comments on
+		 * num_groups_with_pending_reqs for details.
+		 */
+		if (entity->in_groups_with_pending_reqs) {
+			entity->in_groups_with_pending_reqs = false;
+			bfqd->num_groups_with_pending_reqs--;
+		}
 	}
 }
 
@@ -3529,27 +3543,44 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * fact, if there are active groups, then, for condition (i)
 	 * to become false, it is enough that an active group contains
 	 * more active processes or sub-groups than some other active
-	 * group. We address this issue with the following bi-modal
-	 * behavior, implemented in the function
+	 * group. More precisely, for condition (i) to hold because of
+	 * such a group, it is not even necessary that the group is
+	 * (still) active: it is sufficient that, even if the group
+	 * has become inactive, some of its descendant processes still
+	 * have some request already dispatched but still waiting for
+	 * completion. In fact, requests have still to be guaranteed
+	 * their share of the throughput even after being
+	 * dispatched. In this respect, it is easy to show that, if a
+	 * group frequently becomes inactive while still having
+	 * in-flight requests, and if, when this happens, the group is
+	 * not considered in the calculation of whether the scenario
+	 * is asymmetric, then the group may fail to be guaranteed its
+	 * fair share of the throughput (basically because idling may
+	 * not be performed for the descendant processes of the group,
+	 * but it had to be).  We address this issue with the
+	 * following bi-modal behavior, implemented in the function
 	 * bfq_symmetric_scenario().
 	 *
-	 * If there are active groups, then the scenario is tagged as
+	 * If there are groups with requests waiting for completion
+	 * (as commented above, some of these groups may even be
+	 * already inactive), then the scenario is tagged as
 	 * asymmetric, conservatively, without checking any of the
 	 * conditions (i) and (ii). So the device is idled for bfqq.
 	 * This behavior matches also the fact that groups are created
-	 * exactly if controlling I/O (to preserve bandwidth and
-	 * latency guarantees) is a primary concern.
+	 * exactly if controlling I/O is a primary concern (to
+	 * preserve bandwidth and latency guarantees).
 	 *
-	 * On the opposite end, if there are no active groups, then
-	 * only condition (i) is actually controlled, i.e., provided
-	 * that condition (i) holds, idling is not performed,
-	 * regardless of whether condition (ii) holds. In other words,
-	 * only if condition (i) does not hold, then idling is
-	 * allowed, and the device tends to be prevented from queueing
-	 * many requests, possibly of several processes. Since there
-	 * are no active groups, then, to control condition (i) it is
-	 * enough to check whether all active queues have the same
-	 * weight.
+	 * On the opposite end, if there are no groups with requests
+	 * waiting for completion, then only condition (i) is actually
+	 * controlled, i.e., provided that condition (i) holds, idling
+	 * is not performed, regardless of whether condition (ii)
+	 * holds. In other words, only if condition (i) does not hold,
+	 * then idling is allowed, and the device tends to be
+	 * prevented from queueing many requests, possibly of several
+	 * processes. Since there are no groups with requests waiting
+	 * for completion, then, to control condition (i) it is enough
+	 * to check just whether all the queues with requests waiting
+	 * for completion also have the same weight.
 	 *
 	 * Not checking condition (ii) evidently exposes bfqq to the
 	 * risk of getting less throughput than its fair share.
@@ -3607,10 +3638,11 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	 * bfqq is weight-raised is checked explicitly here. More
 	 * precisely, the compound condition below takes into account
 	 * also the fact that, even if bfqq is being weight-raised,
-	 * the scenario is still symmetric if all active queues happen
-	 * to be weight-raised. Actually, we should be even more
-	 * precise here, and differentiate between interactive weight
-	 * raising and soft real-time weight raising.
+	 * the scenario is still symmetric if all queues with requests
+	 * waiting for completion happen to be
+	 * weight-raised. Actually, we should be even more precise
+	 * here, and differentiate between interactive weight raising
+	 * and soft real-time weight raising.
 	 *
 	 * As a side note, it is worth considering that the above
 	 * device-idling countermeasures may however fail in the
@@ -5417,7 +5449,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
 
 	bfqd->queue_weights_tree = RB_ROOT;
-	bfqd->num_active_groups = 0;
+	bfqd->num_groups_with_pending_reqs = 0;
 
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 77651d817ecd..0b02bf302de0 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -196,6 +196,9 @@ struct bfq_entity {
 
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
 	int prio_changed;
+
+	/* flag, set if the entity is counted in groups_with_pending_reqs */
+	bool in_groups_with_pending_reqs;
 };
 
 struct bfq_group;
@@ -448,10 +451,54 @@ struct bfq_data {
 	 * bfq_weights_tree_[add|remove] for further details).
 	 */
 	struct rb_root queue_weights_tree;
+
 	/*
-	 * number of groups with requests still waiting for completion
+	 * Number of groups with at least one descendant process that
+	 * has at least one request waiting for completion. Note that
+	 * this accounts for also requests already dispatched, but not
+	 * yet completed. Therefore this number of groups may differ
+	 * (be larger) than the number of active groups, as a group is
+	 * considered active only if its corresponding entity has
+	 * descendant queues with at least one request queued. This
+	 * number is used to decide whether a scenario is symmetric.
+	 * For a detailed explanation see comments on the computation
+	 * of the variable asymmetric_scenario in the function
+	 * bfq_better_to_idle().
+	 *
+	 * However, it is hard to compute this number exactly, for
+	 * groups with multiple descendant processes. Consider a group
+	 * that is inactive, i.e., that has no descendant process with
+	 * pending I/O inside BFQ queues. Then suppose that
+	 * num_groups_with_pending_reqs is still accounting for this
+	 * group, because the group has descendant processes with some
+	 * I/O request still in flight. num_groups_with_pending_reqs
+	 * should be decremented when the in-flight request of the
+	 * last descendant process is finally completed (assuming that
+	 * nothing else has changed for the group in the meantime, in
+	 * terms of composition of the group and active/inactive state of child
+	 * groups and processes). To accomplish this, an additional
+	 * pending-request counter must be added to entities, and must
+	 * be updated correctly. To avoid this additional field and operations,
+	 * we resort to the following tradeoff between simplicity and
+	 * accuracy: for an inactive group that is still counted in
+	 * num_groups_with_pending_reqs, we decrement
+	 * num_groups_with_pending_reqs when the first descendant
+	 * process of the group remains with no request waiting for
+	 * completion.
+	 *
+	 * Even this simpler decrement strategy requires a little
+	 * carefulness: to avoid multiple decrements, we flag a group,
+	 * more precisely an entity representing a group, as still
+	 * counted in num_groups_with_pending_reqs when it becomes
+	 * inactive. Then, when the first descendant queue of the
+	 * entity remains with no request waiting for completion,
+	 * num_groups_with_pending_reqs is decremented, and this flag
+	 * is reset. After this flag is reset for the entity,
+	 * num_groups_with_pending_reqs won't be decremented any
+	 * longer in case a new descendant queue of the entity remains
+	 * with no request waiting for completion.
 	 */
-	unsigned int num_active_groups;
+	unsigned int num_groups_with_pending_reqs;
 
 	/*
 	 * Number of bfq_queues containing requests (including the
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 4b0d5fb69160..63e0f12be7c9 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1012,7 +1012,10 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 			container_of(entity, struct bfq_group, entity);
 		struct bfq_data *bfqd = bfqg->bfqd;
 
-		bfqd->num_active_groups++;
+		if (!entity->in_groups_with_pending_reqs) {
+			entity->in_groups_with_pending_reqs = true;
+			bfqd->num_groups_with_pending_reqs++;
+		}
 	}
 #endif
 
-- 
2.16.1


Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78AC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B594E20656
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ra6XFgaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFYFNQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:13:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40274 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfFYFNQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so1425327wmj.5
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqOH6JolxVNnSbSBaGe2Jh+qvF6QxJR/Z+iRWaahp5U=;
        b=ra6XFgaS1A6h1N/8W58YTrkGriiiJHAvNjaWn53UFbrbTIy3Ec587O5LVXyY8MMu2T
         yOtG0gBqF2OfLvhR++hWQ8rQE4RNF6+2RVZNQNSl+iZ+dPAP0BP05b4P8tpHr7z/uevY
         iduU4i7XiZoM3pzXEAM9yH0ejnJt06LSvIztvRGL5WrXZanKNLIxWdTnOlvzZv0VQw8z
         gnVt6pUqbB0V0vHPtwlDq12q7AFKuS8HWf3pgSdQhlR4LfmkQ7NUqZP0A8dg09y2a1pF
         1idl+isvR+emaCN6wMbgsaQVNFdSjn5xrQBRkGlsHfyF1IM7V1Wt8/kWC27t8/AEkdoY
         3DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqOH6JolxVNnSbSBaGe2Jh+qvF6QxJR/Z+iRWaahp5U=;
        b=hLyMM9HC6ebE7bPuYv6+4W34Y7ryQ2QyUsJGOjMBJHs+AFe1BYytiVieWnW58NB6Xy
         2kujfSF3C1A7uSFKOnkPmtgLBRdLrXLeO1RzgQ0BjSuxz0VBWtwwPtrg/N7HtIsbFYEM
         QtoUpJtiI1CLaS5ZJ7KFo+Gm/dfqcy2QG8QJPVvCIt+LsHg26HMRwFZIQlwq7a7QoU0P
         zSE6cFa8yfxPwl0YrgmWdFM9V8IP8ubi8wcykax6ltzgLHHSMYcHbkdimErz3jD06Mtv
         fuUSQ/2x1Gk06SliYEPDqtw2Jy785tx0Jcxe3MlCz1ABhf+8ubRYtDmkx5X3qiLZ/Ojb
         V60Q==
X-Gm-Message-State: APjAAAV/zi+MbFMKJM3IA57MpFF36lVMVQI+JJxvm8/QaxEjN3RJixFq
        PvFX1E/QN9mvtmK6cmYQPeWpXA==
X-Google-Smtp-Source: APXvYqwTMTOr7Q1X17LScYCOk0Jn9SIZT2RpY/Cg0fz29dvRXFPUrWHiBcZ7QxOmFNMaUt2Yx43IuA==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr5529925wmk.14.1561439592734;
        Mon, 24 Jun 2019 22:13:12 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:12 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 7/7] block, bfq: re-schedule empty queues if they deserve I/O plugging
Date:   Tue, 25 Jun 2019 07:12:49 +0200
Message-Id: <20190625051249.39265-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
References: <20190625051249.39265-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consider, on one side, a bfq_queue Q that remains empty while in
service, and, on the other side, the pending I/O of bfq_queues that,
according to their timestamps, have to be served after Q.  If an
uncontrolled amount of I/O from the latter bfq_queues were dispatched
while Q is waiting for its new I/O to arrive, then Q's bandwidth
guarantees would be violated. To prevent this, I/O dispatch is plugged
until Q receives new I/O (except for a properly controlled amount of
injected I/O). Unfortunately, preemption breaks I/O-dispatch plugging,
for the following reason.

Preemption is performed in two steps. First, Q is expired and
re-scheduled. Second, the new bfq_queue to serve is chosen. The first
step is needed by the second, as the second can be performed only
after Q's timestamps have been properly updated (done in the
expiration step), and Q has been re-queued for service. This
dependency is a consequence of the way how BFQ's scheduling algorithm
is currently implemented.

But Q is not re-scheduled at all in the first step, because Q is
empty. As a consequence, an uncontrolled amount of I/O may be
dispatched until Q becomes non empty again. This breaks Q's service
guarantees.

This commit addresses this issue by re-scheduling Q even if it is
empty. This in turn breaks the assumption that all scheduled queues
are non empty. Then a few extra checks are now needed.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 387 +++++++++++++++++++++++---------------------
 1 file changed, 203 insertions(+), 184 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6a3d05023300..72840ebf953e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3210,7 +3210,186 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 	bfq_remove_request(q, rq);
 }
 
-static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+/*
+ * There is a case where idling does not have to be performed for
+ * throughput concerns, but to preserve the throughput share of
+ * the process associated with bfqq.
+ *
+ * To introduce this case, we can note that allowing the drive
+ * to enqueue more than one request at a time, and hence
+ * delegating de facto final scheduling decisions to the
+ * drive's internal scheduler, entails loss of control on the
+ * actual request service order. In particular, the critical
+ * situation is when requests from different processes happen
+ * to be present, at the same time, in the internal queue(s)
+ * of the drive. In such a situation, the drive, by deciding
+ * the service order of the internally-queued requests, does
+ * determine also the actual throughput distribution among
+ * these processes. But the drive typically has no notion or
+ * concern about per-process throughput distribution, and
+ * makes its decisions only on a per-request basis. Therefore,
+ * the service distribution enforced by the drive's internal
+ * scheduler is likely to coincide with the desired throughput
+ * distribution only in a completely symmetric, or favorably
+ * skewed scenario where:
+ * (i-a) each of these processes must get the same throughput as
+ *	 the others,
+ * (i-b) in case (i-a) does not hold, it holds that the process
+ *       associated with bfqq must receive a lower or equal
+ *	 throughput than any of the other processes;
+ * (ii)  the I/O of each process has the same properties, in
+ *       terms of locality (sequential or random), direction
+ *       (reads or writes), request sizes, greediness
+ *       (from I/O-bound to sporadic), and so on;
+
+ * In fact, in such a scenario, the drive tends to treat the requests
+ * of each process in about the same way as the requests of the
+ * others, and thus to provide each of these processes with about the
+ * same throughput.  This is exactly the desired throughput
+ * distribution if (i-a) holds, or, if (i-b) holds instead, this is an
+ * even more convenient distribution for (the process associated with)
+ * bfqq.
+ *
+ * In contrast, in any asymmetric or unfavorable scenario, device
+ * idling (I/O-dispatch plugging) is certainly needed to guarantee
+ * that bfqq receives its assigned fraction of the device throughput
+ * (see [1] for details).
+ *
+ * The problem is that idling may significantly reduce throughput with
+ * certain combinations of types of I/O and devices. An important
+ * example is sync random I/O on flash storage with command
+ * queueing. So, unless bfqq falls in cases where idling also boosts
+ * throughput, it is important to check conditions (i-a), i(-b) and
+ * (ii) accurately, so as to avoid idling when not strictly needed for
+ * service guarantees.
+ *
+ * Unfortunately, it is extremely difficult to thoroughly check
+ * condition (ii). And, in case there are active groups, it becomes
+ * very difficult to check conditions (i-a) and (i-b) too.  In fact,
+ * if there are active groups, then, for conditions (i-a) or (i-b) to
+ * become false 'indirectly', it is enough that an active group
+ * contains more active processes or sub-groups than some other active
+ * group. More precisely, for conditions (i-a) or (i-b) to become
+ * false because of such a group, it is not even necessary that the
+ * group is (still) active: it is sufficient that, even if the group
+ * has become inactive, some of its descendant processes still have
+ * some request already dispatched but still waiting for
+ * completion. In fact, requests have still to be guaranteed their
+ * share of the throughput even after being dispatched. In this
+ * respect, it is easy to show that, if a group frequently becomes
+ * inactive while still having in-flight requests, and if, when this
+ * happens, the group is not considered in the calculation of whether
+ * the scenario is asymmetric, then the group may fail to be
+ * guaranteed its fair share of the throughput (basically because
+ * idling may not be performed for the descendant processes of the
+ * group, but it had to be).  We address this issue with the following
+ * bi-modal behavior, implemented in the function
+ * bfq_asymmetric_scenario().
+ *
+ * If there are groups with requests waiting for completion
+ * (as commented above, some of these groups may even be
+ * already inactive), then the scenario is tagged as
+ * asymmetric, conservatively, without checking any of the
+ * conditions (i-a), (i-b) or (ii). So the device is idled for bfqq.
+ * This behavior matches also the fact that groups are created
+ * exactly if controlling I/O is a primary concern (to
+ * preserve bandwidth and latency guarantees).
+ *
+ * On the opposite end, if there are no groups with requests waiting
+ * for completion, then only conditions (i-a) and (i-b) are actually
+ * controlled, i.e., provided that conditions (i-a) or (i-b) holds,
+ * idling is not performed, regardless of whether condition (ii)
+ * holds.  In other words, only if conditions (i-a) and (i-b) do not
+ * hold, then idling is allowed, and the device tends to be prevented
+ * from queueing many requests, possibly of several processes. Since
+ * there are no groups with requests waiting for completion, then, to
+ * control conditions (i-a) and (i-b) it is enough to check just
+ * whether all the queues with requests waiting for completion also
+ * have the same weight.
+ *
+ * Not checking condition (ii) evidently exposes bfqq to the
+ * risk of getting less throughput than its fair share.
+ * However, for queues with the same weight, a further
+ * mechanism, preemption, mitigates or even eliminates this
+ * problem. And it does so without consequences on overall
+ * throughput. This mechanism and its benefits are explained
+ * in the next three paragraphs.
+ *
+ * Even if a queue, say Q, is expired when it remains idle, Q
+ * can still preempt the new in-service queue if the next
+ * request of Q arrives soon (see the comments on
+ * bfq_bfqq_update_budg_for_activation). If all queues and
+ * groups have the same weight, this form of preemption,
+ * combined with the hole-recovery heuristic described in the
+ * comments on function bfq_bfqq_update_budg_for_activation,
+ * are enough to preserve a correct bandwidth distribution in
+ * the mid term, even without idling. In fact, even if not
+ * idling allows the internal queues of the device to contain
+ * many requests, and thus to reorder requests, we can rather
+ * safely assume that the internal scheduler still preserves a
+ * minimum of mid-term fairness.
+ *
+ * More precisely, this preemption-based, idleless approach
+ * provides fairness in terms of IOPS, and not sectors per
+ * second. This can be seen with a simple example. Suppose
+ * that there are two queues with the same weight, but that
+ * the first queue receives requests of 8 sectors, while the
+ * second queue receives requests of 1024 sectors. In
+ * addition, suppose that each of the two queues contains at
+ * most one request at a time, which implies that each queue
+ * always remains idle after it is served. Finally, after
+ * remaining idle, each queue receives very quickly a new
+ * request. It follows that the two queues are served
+ * alternatively, preempting each other if needed. This
+ * implies that, although both queues have the same weight,
+ * the queue with large requests receives a service that is
+ * 1024/8 times as high as the service received by the other
+ * queue.
+ *
+ * The motivation for using preemption instead of idling (for
+ * queues with the same weight) is that, by not idling,
+ * service guarantees are preserved (completely or at least in
+ * part) without minimally sacrificing throughput. And, if
+ * there is no active group, then the primary expectation for
+ * this device is probably a high throughput.
+ *
+ * We are now left only with explaining the additional
+ * compound condition that is checked below for deciding
+ * whether the scenario is asymmetric. To explain this
+ * compound condition, we need to add that the function
+ * bfq_asymmetric_scenario checks the weights of only
+ * non-weight-raised queues, for efficiency reasons (see
+ * comments on bfq_weights_tree_add()). Then the fact that
+ * bfqq is weight-raised is checked explicitly here. More
+ * precisely, the compound condition below takes into account
+ * also the fact that, even if bfqq is being weight-raised,
+ * the scenario is still symmetric if all queues with requests
+ * waiting for completion happen to be
+ * weight-raised. Actually, we should be even more precise
+ * here, and differentiate between interactive weight raising
+ * and soft real-time weight raising.
+ *
+ * As a side note, it is worth considering that the above
+ * device-idling countermeasures may however fail in the
+ * following unlucky scenario: if idling is (correctly)
+ * disabled in a time period during which all symmetry
+ * sub-conditions hold, and hence the device is allowed to
+ * enqueue many requests, but at some later point in time some
+ * sub-condition stops to hold, then it may become impossible
+ * to let requests be served in the desired order until all
+ * the requests already queued in the device have been served.
+ */
+static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
+						 struct bfq_queue *bfqq)
+{
+	return (bfqq->wr_coeff > 1 &&
+		bfqd->wr_busy_queues <
+		bfq_tot_busy_queues(bfqd)) ||
+		bfq_asymmetric_scenario(bfqd, bfqq);
+}
+
+static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			      enum bfqq_expiration reason)
 {
 	/*
 	 * If this bfqq is shared between multiple processes, check
@@ -3221,7 +3400,22 @@ static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	if (bfq_bfqq_coop(bfqq) && BFQQ_SEEKY(bfqq))
 		bfq_mark_bfqq_split_coop(bfqq);
 
-	if (RB_EMPTY_ROOT(&bfqq->sort_list)) {
+	/*
+	 * Consider queues with a higher finish virtual time than
+	 * bfqq. If idling_needed_for_service_guarantees(bfqq) returns
+	 * true, then bfqq's bandwidth would be violated if an
+	 * uncontrolled amount of I/O from these queues were
+	 * dispatched while bfqq is waiting for its new I/O to
+	 * arrive. This is exactly what may happen if this is a forced
+	 * expiration caused by a preemption attempt, and if bfqq is
+	 * not re-scheduled. To prevent this from happening, re-queue
+	 * bfqq if it needs I/O-dispatch plugging, even if it is
+	 * empty. By doing so, bfqq is granted to be served before the
+	 * above queues (provided that bfqq is of course eligible).
+	 */
+	if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
+	    !(reason == BFQQE_PREEMPTED &&
+	      idling_needed_for_service_guarantees(bfqd, bfqq))) {
 		if (bfqq->dispatched == 0)
 			/*
 			 * Overloading budget_timeout field to store
@@ -3238,7 +3432,8 @@ static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		 * Resort priority tree of potential close cooperators.
 		 * See comments on bfq_pos_tree_add_move() for the unlikely().
 		 */
-		if (unlikely(!bfqd->nonrot_with_queueing))
+		if (unlikely(!bfqd->nonrot_with_queueing &&
+			     !RB_EMPTY_ROOT(&bfqq->sort_list)))
 			bfq_pos_tree_add_move(bfqd, bfqq);
 	}
 
@@ -3739,7 +3934,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * reason.
 	 */
 	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
-	if (__bfq_bfqq_expire(bfqd, bfqq))
+	if (__bfq_bfqq_expire(bfqd, bfqq, reason))
 		/* bfqq is gone, no more actions on it */
 		return;
 
@@ -3885,184 +4080,6 @@ static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 		bfqd->wr_busy_queues == 0;
 }
 
-/*
- * There is a case where idling does not have to be performed for
- * throughput concerns, but to preserve the throughput share of
- * the process associated with bfqq.
- *
- * To introduce this case, we can note that allowing the drive
- * to enqueue more than one request at a time, and hence
- * delegating de facto final scheduling decisions to the
- * drive's internal scheduler, entails loss of control on the
- * actual request service order. In particular, the critical
- * situation is when requests from different processes happen
- * to be present, at the same time, in the internal queue(s)
- * of the drive. In such a situation, the drive, by deciding
- * the service order of the internally-queued requests, does
- * determine also the actual throughput distribution among
- * these processes. But the drive typically has no notion or
- * concern about per-process throughput distribution, and
- * makes its decisions only on a per-request basis. Therefore,
- * the service distribution enforced by the drive's internal
- * scheduler is likely to coincide with the desired throughput
- * distribution only in a completely symmetric, or favorably
- * skewed scenario where:
- * (i-a) each of these processes must get the same throughput as
- *	 the others,
- * (i-b) in case (i-a) does not hold, it holds that the process
- *       associated with bfqq must receive a lower or equal
- *	 throughput than any of the other processes;
- * (ii)  the I/O of each process has the same properties, in
- *       terms of locality (sequential or random), direction
- *       (reads or writes), request sizes, greediness
- *       (from I/O-bound to sporadic), and so on;
-
- * In fact, in such a scenario, the drive tends to treat the requests
- * of each process in about the same way as the requests of the
- * others, and thus to provide each of these processes with about the
- * same throughput.  This is exactly the desired throughput
- * distribution if (i-a) holds, or, if (i-b) holds instead, this is an
- * even more convenient distribution for (the process associated with)
- * bfqq.
- *
- * In contrast, in any asymmetric or unfavorable scenario, device
- * idling (I/O-dispatch plugging) is certainly needed to guarantee
- * that bfqq receives its assigned fraction of the device throughput
- * (see [1] for details).
- *
- * The problem is that idling may significantly reduce throughput with
- * certain combinations of types of I/O and devices. An important
- * example is sync random I/O on flash storage with command
- * queueing. So, unless bfqq falls in cases where idling also boosts
- * throughput, it is important to check conditions (i-a), i(-b) and
- * (ii) accurately, so as to avoid idling when not strictly needed for
- * service guarantees.
- *
- * Unfortunately, it is extremely difficult to thoroughly check
- * condition (ii). And, in case there are active groups, it becomes
- * very difficult to check conditions (i-a) and (i-b) too.  In fact,
- * if there are active groups, then, for conditions (i-a) or (i-b) to
- * become false 'indirectly', it is enough that an active group
- * contains more active processes or sub-groups than some other active
- * group. More precisely, for conditions (i-a) or (i-b) to become
- * false because of such a group, it is not even necessary that the
- * group is (still) active: it is sufficient that, even if the group
- * has become inactive, some of its descendant processes still have
- * some request already dispatched but still waiting for
- * completion. In fact, requests have still to be guaranteed their
- * share of the throughput even after being dispatched. In this
- * respect, it is easy to show that, if a group frequently becomes
- * inactive while still having in-flight requests, and if, when this
- * happens, the group is not considered in the calculation of whether
- * the scenario is asymmetric, then the group may fail to be
- * guaranteed its fair share of the throughput (basically because
- * idling may not be performed for the descendant processes of the
- * group, but it had to be).  We address this issue with the following
- * bi-modal behavior, implemented in the function
- * bfq_asymmetric_scenario().
- *
- * If there are groups with requests waiting for completion
- * (as commented above, some of these groups may even be
- * already inactive), then the scenario is tagged as
- * asymmetric, conservatively, without checking any of the
- * conditions (i-a), (i-b) or (ii). So the device is idled for bfqq.
- * This behavior matches also the fact that groups are created
- * exactly if controlling I/O is a primary concern (to
- * preserve bandwidth and latency guarantees).
- *
- * On the opposite end, if there are no groups with requests waiting
- * for completion, then only conditions (i-a) and (i-b) are actually
- * controlled, i.e., provided that conditions (i-a) or (i-b) holds,
- * idling is not performed, regardless of whether condition (ii)
- * holds.  In other words, only if conditions (i-a) and (i-b) do not
- * hold, then idling is allowed, and the device tends to be prevented
- * from queueing many requests, possibly of several processes. Since
- * there are no groups with requests waiting for completion, then, to
- * control conditions (i-a) and (i-b) it is enough to check just
- * whether all the queues with requests waiting for completion also
- * have the same weight.
- *
- * Not checking condition (ii) evidently exposes bfqq to the
- * risk of getting less throughput than its fair share.
- * However, for queues with the same weight, a further
- * mechanism, preemption, mitigates or even eliminates this
- * problem. And it does so without consequences on overall
- * throughput. This mechanism and its benefits are explained
- * in the next three paragraphs.
- *
- * Even if a queue, say Q, is expired when it remains idle, Q
- * can still preempt the new in-service queue if the next
- * request of Q arrives soon (see the comments on
- * bfq_bfqq_update_budg_for_activation). If all queues and
- * groups have the same weight, this form of preemption,
- * combined with the hole-recovery heuristic described in the
- * comments on function bfq_bfqq_update_budg_for_activation,
- * are enough to preserve a correct bandwidth distribution in
- * the mid term, even without idling. In fact, even if not
- * idling allows the internal queues of the device to contain
- * many requests, and thus to reorder requests, we can rather
- * safely assume that the internal scheduler still preserves a
- * minimum of mid-term fairness.
- *
- * More precisely, this preemption-based, idleless approach
- * provides fairness in terms of IOPS, and not sectors per
- * second. This can be seen with a simple example. Suppose
- * that there are two queues with the same weight, but that
- * the first queue receives requests of 8 sectors, while the
- * second queue receives requests of 1024 sectors. In
- * addition, suppose that each of the two queues contains at
- * most one request at a time, which implies that each queue
- * always remains idle after it is served. Finally, after
- * remaining idle, each queue receives very quickly a new
- * request. It follows that the two queues are served
- * alternatively, preempting each other if needed. This
- * implies that, although both queues have the same weight,
- * the queue with large requests receives a service that is
- * 1024/8 times as high as the service received by the other
- * queue.
- *
- * The motivation for using preemption instead of idling (for
- * queues with the same weight) is that, by not idling,
- * service guarantees are preserved (completely or at least in
- * part) without minimally sacrificing throughput. And, if
- * there is no active group, then the primary expectation for
- * this device is probably a high throughput.
- *
- * We are now left only with explaining the additional
- * compound condition that is checked below for deciding
- * whether the scenario is asymmetric. To explain this
- * compound condition, we need to add that the function
- * bfq_asymmetric_scenario checks the weights of only
- * non-weight-raised queues, for efficiency reasons (see
- * comments on bfq_weights_tree_add()). Then the fact that
- * bfqq is weight-raised is checked explicitly here. More
- * precisely, the compound condition below takes into account
- * also the fact that, even if bfqq is being weight-raised,
- * the scenario is still symmetric if all queues with requests
- * waiting for completion happen to be
- * weight-raised. Actually, we should be even more precise
- * here, and differentiate between interactive weight raising
- * and soft real-time weight raising.
- *
- * As a side note, it is worth considering that the above
- * device-idling countermeasures may however fail in the
- * following unlucky scenario: if idling is (correctly)
- * disabled in a time period during which all symmetry
- * sub-conditions hold, and hence the device is allowed to
- * enqueue many requests, but at some later point in time some
- * sub-condition stops to hold, then it may become impossible
- * to let requests be served in the desired order until all
- * the requests already queued in the device have been served.
- */
-static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
-						 struct bfq_queue *bfqq)
-{
-	return (bfqq->wr_coeff > 1 &&
-		bfqd->wr_busy_queues <
-		bfq_tot_busy_queues(bfqd)) ||
-		bfq_asymmetric_scenario(bfqd, bfqq);
-}
-
 /*
  * For a queue that becomes empty, device idling is allowed only if
  * this function returns true for that queue. As a consequence, since
@@ -4321,7 +4338,8 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	    (bfqq->dispatched != 0 && bfq_better_to_idle(bfqq))) {
 		struct bfq_queue *async_bfqq =
 			bfqq->bic && bfqq->bic->bfqq[0] &&
-			bfq_bfqq_busy(bfqq->bic->bfqq[0]) ?
+			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
+			bfqq->bic->bfqq[0]->next_rq ?
 			bfqq->bic->bfqq[0] : NULL;
 
 		/*
@@ -4403,6 +4421,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfqq = bfqq->bic->bfqq[0];
 		else if (bfq_bfqq_has_waker(bfqq) &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
+			   bfqq->next_rq &&
 			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
 					      bfqq->waker_bfqq) <=
 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
@@ -4800,7 +4819,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	struct hlist_node *n;
 
 	if (bfqq == bfqd->in_service_queue) {
-		__bfq_bfqq_expire(bfqd, bfqq);
+		__bfq_bfqq_expire(bfqd, bfqq, BFQQE_BUDGET_TIMEOUT);
 		bfq_schedule_dispatch(bfqd);
 	}
 
-- 
2.20.1


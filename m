Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C39C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FCD22A85
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbhAZFdb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbhAYTFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 14:05:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896CCC061797
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h9so3845513wrr.9
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBtrbFwWUbHdCDpM5SiVyGA3LyuDrRqzb7zQyqRYGq0=;
        b=p9GSSB5J4VKyYCQ6cOc3y0WntPOPd4tW17j6qu5wDnKIFPCSLUrJuJGQ83oIdnif2L
         KGVpmhZQp1RhdRyGcFzLuNvDEAT7THPotg9hEDq5RVzeNj6f0l9F7e4Iz0ovIEVxIHs6
         5aSILS3/1hiDs5UAN1ja+Ue22g9cKXixRLA4XW24KBQ5KAQ/ww2xrAbZOgIJlmsNBccr
         z/1ezJuIidYtBcmY0CJ3NKG+E5AKFSlxSbu5TnvCzKysyzxAp4UVeeLrezhplBXSX11V
         0PeZhtMowMddbCGw3/LswgE5vLpuDBeh8zRiDeCB+miE6NYSftb7SRs0wtc3WEJVg5VE
         Iglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBtrbFwWUbHdCDpM5SiVyGA3LyuDrRqzb7zQyqRYGq0=;
        b=pNVe6NhhTDmyD/nc00vPu74Xbu+1SkWvX9s6Y8nvh1ehsme5rjWylf2EIKyP7lkspS
         WHthzgrWXjULmtbQE5t2bWNJhYOIG+Mp8jXvK3FF6Qy3gxDYBvgGJqR2NqT7FfJ8uIOU
         /oiJ1E+7SW8xAcT8vtckp7i/BpNseBOjRsbPxJweOW5vRAOlv67WvN5IKSAjvwVDWRWE
         Je333QAXtjC7uw1SYK0eRy20hOVCIaDjBaMZuKDDWrUXr1pps8JwBszbfndOCAVixEu9
         fErvE2gbhlslczaBktbIpWroiaonqpSzkC24V5Ng2ABuTkalPEj+w9LZt/RMu0SYnBbF
         wxDg==
X-Gm-Message-State: AOAM532VmvMXQy5F0zOpvClqQ9nL/uxuTpxT8Fr19C37K/zX5S+Bw0S3
        CZCqz37jmFSBdxgrG/rgCLAO2kpFY9ZDmg==
X-Google-Smtp-Source: ABdhPJyrLVkgmvRn21KH1LTSFELBuNlDN1V1usXfDnA1I+XJ/hPJjhKl9HZ8B0pHQkTJHJbOZMjD9w==
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr2507895wrg.322.1611601403210;
        Mon, 25 Jan 2021 11:03:23 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:22 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 6/6] block, bfq: make waker-queue detection more robust
Date:   Mon, 25 Jan 2021 20:02:48 +0100
Message-Id: <20210125190248.49338-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the presence of many parallel I/O flows, the detection of waker
bfq_queues suffers from false positives. This commits addresses this
issue by making the filtering of actual wakers more selective. In more
detail, a candidate waker must be found to meet waker requirements
three times before being promoted to actual waker.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 211 +++++++++++++++++++++-----------------------
 block/bfq-iosched.h |   7 +-
 2 files changed, 108 insertions(+), 110 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e56ee60df014..445cef9c0bb9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -158,7 +158,6 @@ BFQ_BFQQ_FNS(in_large_burst);
 BFQ_BFQQ_FNS(coop);
 BFQ_BFQQ_FNS(split_coop);
 BFQ_BFQQ_FNS(softrt_update);
-BFQ_BFQQ_FNS(has_waker);
 #undef BFQ_BFQQ_FNS						\
 
 /* Expiration time of sync (0) and async (1) requests, in ns. */
@@ -1905,6 +1904,107 @@ static void bfq_update_io_intensity(struct bfq_queue *bfqq, u64 now_ns)
 	}
 }
 
+/*
+ * Detect whether bfqq's I/O seems synchronized with that of some
+ * other queue, i.e., whether bfqq, after remaining empty, happens to
+ * receive new I/O only right after some I/O request of the other
+ * queue has been completed. We call waker queue the other queue, and
+ * we assume, for simplicity, that bfqq may have at most one waker
+ * queue.
+ *
+ * A remarkable throughput boost can be reached by unconditionally
+ * injecting the I/O of the waker queue, every time a new
+ * bfq_dispatch_request happens to be invoked while I/O is being
+ * plugged for bfqq.  In addition to boosting throughput, this
+ * unblocks bfqq's I/O, thereby improving bandwidth and latency for
+ * bfqq. Note that these same results may be achieved with the general
+ * injection mechanism, but less effectively. For details on this
+ * aspect, see the comments on the choice of the queue for injection
+ * in bfq_select_queue().
+ *
+ * Turning back to the detection of a waker queue, a queue Q is deemed
+ * as a waker queue for bfqq if, for three consecutive times, bfqq
+ * happens to become non empty right after a request of Q has been
+ * completed. In particular, on the first time, Q is tentatively set
+ * as a candidate waker queue, while on the third consecutive time
+ * that Q is detected, the field waker_bfqq is set to Q, to confirm
+ * that Q is a waker queue for bfqq. These detection steps are
+ * performed only if bfqq has a long think time, so as to make it more
+ * likely that bfqq's I/O is actually being blocked by a
+ * synchronization. This last filter, plus the above three-times
+ * requirement, make false positives less likely.
+ *
+ * NOTE
+ *
+ * The sooner a waker queue is detected, the sooner throughput can be
+ * boosted by injecting I/O from the waker queue. Fortunately,
+ * detection is likely to be actually fast, for the following
+ * reasons. While blocked by synchronization, bfqq has a long think
+ * time. This implies that bfqq's inject limit is at least equal to 1
+ * (see the comments in bfq_update_inject_limit()). So, thanks to
+ * injection, the waker queue is likely to be served during the very
+ * first I/O-plugging time interval for bfqq. This triggers the first
+ * step of the detection mechanism. Thanks again to injection, the
+ * candidate waker queue is then likely to be confirmed no later than
+ * during the next I/O-plugging interval for bfqq.
+ *
+ * ISSUE
+ *
+ * On queue merging all waker information is lost.
+ */
+void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq, u64 now_ns)
+{
+	if (!bfqd->last_completed_rq_bfqq ||
+	    bfqd->last_completed_rq_bfqq == bfqq ||
+	    bfq_bfqq_has_short_ttime(bfqq) ||
+	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
+	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
+		return;
+
+	if (bfqd->last_completed_rq_bfqq !=
+	    bfqq->tentative_waker_bfqq) {
+		/*
+		 * First synchronization detected with a
+		 * candidate waker queue, or with a different
+		 * candidate waker queue from the current one.
+		 */
+		bfqq->tentative_waker_bfqq =
+			bfqd->last_completed_rq_bfqq;
+		bfqq->num_waker_detections = 1;
+	} else /* Same tentative waker queue detected again */
+		bfqq->num_waker_detections++;
+
+	if (bfqq->num_waker_detections == 3) {
+		bfqq->waker_bfqq = bfqd->last_completed_rq_bfqq;
+		bfqq->tentative_waker_bfqq = NULL;
+
+		/*
+		 * If the waker queue disappears, then
+		 * bfqq->waker_bfqq must be reset. To
+		 * this goal, we maintain in each
+		 * waker queue a list, woken_list, of
+		 * all the queues that reference the
+		 * waker queue through their
+		 * waker_bfqq pointer. When the waker
+		 * queue exits, the waker_bfqq pointer
+		 * of all the queues in the woken_list
+		 * is reset.
+		 *
+		 * In addition, if bfqq is already in
+		 * the woken_list of a waker queue,
+		 * then, before being inserted into
+		 * the woken_list of a new waker
+		 * queue, bfqq must be removed from
+		 * the woken_list of the old waker
+		 * queue.
+		 */
+		if (!hlist_unhashed(&bfqq->woken_list_node))
+			hlist_del_init(&bfqq->woken_list_node);
+		hlist_add_head(&bfqq->woken_list_node,
+			       &bfqd->last_completed_rq_bfqq->woken_list);
+	}
+}
+
 static void bfq_add_request(struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
@@ -1919,111 +2019,7 @@ static void bfq_add_request(struct request *rq)
 	bfqd->queued++;
 
 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
-		/*
-		 * Detect whether bfqq's I/O seems synchronized with
-		 * that of some other queue, i.e., whether bfqq, after
-		 * remaining empty, happens to receive new I/O only
-		 * right after some I/O request of the other queue has
-		 * been completed. We call waker queue the other
-		 * queue, and we assume, for simplicity, that bfqq may
-		 * have at most one waker queue.
-		 *
-		 * A remarkable throughput boost can be reached by
-		 * unconditionally injecting the I/O of the waker
-		 * queue, every time a new bfq_dispatch_request
-		 * happens to be invoked while I/O is being plugged
-		 * for bfqq.  In addition to boosting throughput, this
-		 * unblocks bfqq's I/O, thereby improving bandwidth
-		 * and latency for bfqq. Note that these same results
-		 * may be achieved with the general injection
-		 * mechanism, but less effectively. For details on
-		 * this aspect, see the comments on the choice of the
-		 * queue for injection in bfq_select_queue().
-		 *
-		 * Turning back to the detection of a waker queue, a
-		 * queue Q is deemed as a waker queue for bfqq if, for
-		 * two consecutive times, bfqq happens to become non
-		 * empty right after a request of Q has been
-		 * completed. In particular, on the first time, Q is
-		 * tentatively set as a candidate waker queue, while
-		 * on the second time, the flag
-		 * bfq_bfqq_has_waker(bfqq) is set to confirm that Q
-		 * is a waker queue for bfqq. These detection steps
-		 * are performed only if bfqq has a long think time,
-		 * so as to make it more likely that bfqq's I/O is
-		 * actually being blocked by a synchronization. This
-		 * last filter, plus the above two-times requirement,
-		 * make false positives less likely.
-		 *
-		 * NOTE
-		 *
-		 * The sooner a waker queue is detected, the sooner
-		 * throughput can be boosted by injecting I/O from the
-		 * waker queue. Fortunately, detection is likely to be
-		 * actually fast, for the following reasons. While
-		 * blocked by synchronization, bfqq has a long think
-		 * time. This implies that bfqq's inject limit is at
-		 * least equal to 1 (see the comments in
-		 * bfq_update_inject_limit()). So, thanks to
-		 * injection, the waker queue is likely to be served
-		 * during the very first I/O-plugging time interval
-		 * for bfqq. This triggers the first step of the
-		 * detection mechanism. Thanks again to injection, the
-		 * candidate waker queue is then likely to be
-		 * confirmed no later than during the next
-		 * I/O-plugging interval for bfqq.
-		 */
-		if (bfqd->last_completed_rq_bfqq &&
-		    !bfq_bfqq_has_short_ttime(bfqq) &&
-		    now_ns - bfqd->last_completion <
-		    4 * NSEC_PER_MSEC) {
-			if (bfqd->last_completed_rq_bfqq != bfqq &&
-			    bfqd->last_completed_rq_bfqq !=
-			    bfqq->waker_bfqq) {
-				/*
-				 * First synchronization detected with
-				 * a candidate waker queue, or with a
-				 * different candidate waker queue
-				 * from the current one.
-				 */
-				bfqq->waker_bfqq = bfqd->last_completed_rq_bfqq;
-
-				/*
-				 * If the waker queue disappears, then
-				 * bfqq->waker_bfqq must be reset. To
-				 * this goal, we maintain in each
-				 * waker queue a list, woken_list, of
-				 * all the queues that reference the
-				 * waker queue through their
-				 * waker_bfqq pointer. When the waker
-				 * queue exits, the waker_bfqq pointer
-				 * of all the queues in the woken_list
-				 * is reset.
-				 *
-				 * In addition, if bfqq is already in
-				 * the woken_list of a waker queue,
-				 * then, before being inserted into
-				 * the woken_list of a new waker
-				 * queue, bfqq must be removed from
-				 * the woken_list of the old waker
-				 * queue.
-				 */
-				if (!hlist_unhashed(&bfqq->woken_list_node))
-					hlist_del_init(&bfqq->woken_list_node);
-				hlist_add_head(&bfqq->woken_list_node,
-				    &bfqd->last_completed_rq_bfqq->woken_list);
-
-				bfq_clear_bfqq_has_waker(bfqq);
-			} else if (bfqd->last_completed_rq_bfqq ==
-				   bfqq->waker_bfqq &&
-				   !bfq_bfqq_has_waker(bfqq)) {
-				/*
-				 * synchronization with waker_bfqq
-				 * seen for the second time
-				 */
-				bfq_mark_bfqq_has_waker(bfqq);
-			}
-		}
+		bfq_check_waker(bfqd, bfqq, now_ns);
 
 		/*
 		 * Periodically reset inject limit, to make sure that
@@ -4569,7 +4565,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
 			bfqq = bfqq->bic->bfqq[0];
-		else if (bfq_bfqq_has_waker(bfqq) &&
+		else if (bfqq->waker_bfqq &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
 			   bfqq->waker_bfqq->next_rq &&
 			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
@@ -4976,7 +4972,6 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 	hlist_for_each_entry_safe(item, n, &bfqq->woken_list,
 				  woken_list_node) {
 		item->waker_bfqq = NULL;
-		bfq_clear_bfqq_has_waker(item);
 		hlist_del_init(&item->woken_list_node);
 	}
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3f350fa3c5fd..b8e793c34ff1 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -376,6 +376,11 @@ struct bfq_queue {
 	 * bfq_select_queue().
 	 */
 	struct bfq_queue *waker_bfqq;
+	/* pointer to the curr. tentative waker queue, see bfq_check_waker() */
+	struct bfq_queue *tentative_waker_bfqq;
+	/* number of times the same tentative waker has been detected */
+	unsigned int num_waker_detections;
+
 	/* node for woken_list, see below */
 	struct hlist_node woken_list_node;
 	/*
@@ -776,7 +781,6 @@ enum bfqq_state_flags {
 				 */
 	BFQQF_coop,		/* bfqq is shared */
 	BFQQF_split_coop,	/* shared bfqq will be split */
-	BFQQF_has_waker		/* bfqq has a waker queue */
 };
 
 #define BFQ_BFQQ_FNS(name)						\
@@ -796,7 +800,6 @@ BFQ_BFQQ_FNS(in_large_burst);
 BFQ_BFQQ_FNS(coop);
 BFQ_BFQQ_FNS(split_coop);
 BFQ_BFQQ_FNS(softrt_update);
-BFQ_BFQQ_FNS(has_waker);
 #undef BFQ_BFQQ_FNS
 
 /* Expiration reasons. */
-- 
2.20.1


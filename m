Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F934C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE4F229C4
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbhAZFdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbhAYTD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 14:03:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A593C061756
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d16so13419304wro.11
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgGFbvXxHvS5eUAN/hln5OKJlAJbciVhefRf0mMTswU=;
        b=KjoB8VpoBeqeCFf+1js5OWLn3XeZLjEhCQcs7QPGEfZdwqHQ0iMln4FfmlXmM/dYdw
         Od+jRiFZo7ddkhBE8ByTSWYCVO8Fo84QHRIuAkBIp9XJpb4dqrxVNOgMECme+VNZ8s7P
         p4aVOdjjCtBcMXs/Zy4+fhKkBJgEpyu7bM8cSAupcricts2FrbLFeCT16jTjUeAutXcq
         NYcUx+UDSAqXkI/itiY5J7zhUUPB8IvJFqN73NkEjkQr3/W9CjDjSq7yrNn0qqwgyzey
         SypkN40Dq8GyymVh7g12ZbEEUTV7fYeK8BZJ/PBWHtqCKIueciFmbkiQCBu/noHV96aO
         7PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgGFbvXxHvS5eUAN/hln5OKJlAJbciVhefRf0mMTswU=;
        b=U3zigaSYQ063/LysqziWHdbxthLOP3256xT3ewKRVameVfOS7ffOoQuOrOI5QK84B6
         AtFSnsEPTBf8jwkBe5/PR53QRX2g2+0Ct3tmzpC248XEc21sEa1BpG1lGyjcwDJ9WkPF
         w5VaDIqqJaDFsRg/c5vh5tdHAF9VndOJXDPfKzU96tlfpFmnJ49QrvpIMK0pgAi9ygib
         DxR3Uz2ZHxy4oZM+tF8Ks1Gib15bITd32hfIpXvCMyz8Xn6BfR+DTkTEwWUab5xOU7bu
         ndyjM6i1mS6DpxvYqi791f84aJZTVRMkBmb5J0kCTChIFih2AncF9ftgewKoeM9qxSJE
         pUEQ==
X-Gm-Message-State: AOAM531sNov2lwZfYpNzOIk9rr5JEUASWVM8uwMGLMQXfHQXUFyeXrDJ
        hXkNJSh6oxUiyJAdV8u4SWpjiw==
X-Google-Smtp-Source: ABdhPJwUWAsFf6dK2EcfP+GGoeBvK78AUFHELoUYX26fRo4bwu35ni+MdVc7neA/Qw7dzWF+RzE3UA==
X-Received: by 2002:adf:decb:: with SMTP id i11mr1213090wrn.78.1611601395112;
        Mon, 25 Jan 2021 11:03:15 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:14 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 1/6] block, bfq: replace mechanism for evaluating I/O intensity
Date:   Mon, 25 Jan 2021 20:02:43 +0100
Message-Id: <20210125190248.49338-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some BFQ mechanisms make their decisions on a bfq_queue basing also on
whether the bfq_queue is I/O bound. In this respect, the current logic
for evaluating whether a bfq_queue is I/O bound is rather rough. This
commits replaces this logic with a more effective one.

The new logic measures the percentage of time during which a bfq_queue
is active, and marks the bfq_queue as I/O bound if the latter if this
percentage is above a fixed threshold.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 63 +++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 16 ++++++------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c045613ce927..db393f5d70ba 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1026,6 +1026,8 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 	bfqq->entity.new_weight = bic->saved_weight;
 	bfqq->ttime = bic->saved_ttime;
+	bfqq->io_start_time = bic->saved_io_start_time;
+	bfqq->tot_idle_time = bic->saved_tot_idle_time;
 	bfqq->wr_coeff = bic->saved_wr_coeff;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
@@ -1721,17 +1723,6 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 
 	bfq_clear_bfqq_just_created(bfqq);
 
-
-	if (!bfq_bfqq_IO_bound(bfqq)) {
-		if (arrived_in_time) {
-			bfqq->requests_within_timer++;
-			if (bfqq->requests_within_timer >=
-			    bfqd->bfq_requests_within_timer)
-				bfq_mark_bfqq_IO_bound(bfqq);
-		} else
-			bfqq->requests_within_timer = 0;
-	}
-
 	if (bfqd->low_latency) {
 		if (unlikely(time_is_after_jiffies(bfqq->split_time)))
 			/* wraparound */
@@ -1865,6 +1856,36 @@ static void bfq_reset_inject_limit(struct bfq_data *bfqd,
 	bfqq->decrease_time_jif = jiffies;
 }
 
+static void bfq_update_io_intensity(struct bfq_queue *bfqq, u64 now_ns)
+{
+	u64 tot_io_time = now_ns - bfqq->io_start_time;
+
+	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfqq->dispatched == 0)
+		bfqq->tot_idle_time +=
+			now_ns - bfqq->ttime.last_end_request;
+
+	if (unlikely(bfq_bfqq_just_created(bfqq)))
+		return;
+
+	/*
+	 * Must be busy for at least about 80% of the time to be
+	 * considered I/O bound.
+	 */
+	if (bfqq->tot_idle_time * 5 > tot_io_time)
+		bfq_clear_bfqq_IO_bound(bfqq);
+	else
+		bfq_mark_bfqq_IO_bound(bfqq);
+
+	/*
+	 * Keep an observation window of at most 200 ms in the past
+	 * from now.
+	 */
+	if (tot_io_time > 200 * NSEC_PER_MSEC) {
+		bfqq->io_start_time = now_ns - (tot_io_time>>1);
+		bfqq->tot_idle_time >>= 1;
+	}
+}
+
 static void bfq_add_request(struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
@@ -1872,6 +1893,7 @@ static void bfq_add_request(struct request *rq)
 	struct request *next_rq, *prev;
 	unsigned int old_wr_coeff = bfqq->wr_coeff;
 	bool interactive = false;
+	u64 now_ns = ktime_get_ns();
 
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
@@ -1934,7 +1956,7 @@ static void bfq_add_request(struct request *rq)
 		 */
 		if (bfqd->last_completed_rq_bfqq &&
 		    !bfq_bfqq_has_short_ttime(bfqq) &&
-		    ktime_get_ns() - bfqd->last_completion <
+		    now_ns - bfqd->last_completion <
 		    4 * NSEC_PER_MSEC) {
 			if (bfqd->last_completed_rq_bfqq != bfqq &&
 			    bfqd->last_completed_rq_bfqq !=
@@ -2051,6 +2073,9 @@ static void bfq_add_request(struct request *rq)
 		}
 	}
 
+	if (bfq_bfqq_sync(bfqq))
+		bfq_update_io_intensity(bfqq, now_ns);
+
 	elv_rb_add(&bfqq->sort_list, rq);
 
 	/*
@@ -2712,6 +2737,8 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	bic->saved_ttime = bfqq->ttime;
 	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
 	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
+	bic->saved_io_start_time = bfqq->io_start_time;
+	bic->saved_tot_idle_time = bfqq->tot_idle_time;
 	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
 	bic->was_in_burst_list = !hlist_unhashed(&bfqq->burst_list_node);
 	if (unlikely(bfq_bfqq_just_created(bfqq) &&
@@ -3979,10 +4006,6 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	      bfq_bfqq_budget_left(bfqq) >=  entity->budget / 3)))
 		bfq_bfqq_charge_time(bfqd, bfqq, delta);
 
-	if (reason == BFQQE_TOO_IDLE &&
-	    entity->service <= 2 * entity->budget / 10)
-		bfq_clear_bfqq_IO_bound(bfqq);
-
 	if (bfqd->low_latency && bfqq->wr_coeff == 1)
 		bfqq->last_wr_start_finish = jiffies;
 
@@ -5088,6 +5111,8 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
 {
+	u64 now_ns = ktime_get_ns();
+
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
 	INIT_LIST_HEAD(&bfqq->fifo);
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
@@ -5115,7 +5140,9 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_clear_bfqq_sync(bfqq);
 
 	/* set end request to minus infinity from now */
-	bfqq->ttime.last_end_request = ktime_get_ns() + 1;
+	bfqq->ttime.last_end_request = now_ns + 1;
+
+	bfqq->io_start_time = now_ns;
 
 	bfq_mark_bfqq_IO_bound(bfqq);
 
@@ -6529,8 +6556,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_slice_idle = bfq_slice_idle;
 	bfqd->bfq_timeout = bfq_timeout;
 
-	bfqd->bfq_requests_within_timer = 120;
-
 	bfqd->bfq_large_burst_thresh = 8;
 	bfqd->bfq_burst_interval = msecs_to_jiffies(180);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 703895224562..c913b06016b3 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -291,6 +291,11 @@ struct bfq_queue {
 	/* associated @bfq_ttime struct */
 	struct bfq_ttime ttime;
 
+	/* when bfqq started to do I/O within the last observation window */
+	u64 io_start_time;
+	/* how long bfqq has remained empty during the last observ. window */
+	u64 tot_idle_time;
+
 	/* bit vector: a 1 for each seeky requests in history */
 	u32 seek_history;
 
@@ -407,6 +412,9 @@ struct bfq_io_cq {
 	 */
 	bool saved_IO_bound;
 
+	u64 saved_io_start_time;
+	u64 saved_tot_idle_time;
+
 	/*
 	 * Same purpose as the previous fields for the value of the
 	 * field keeping the queue's belonging to a large burst
@@ -641,14 +649,6 @@ struct bfq_data {
 	 */
 	unsigned int bfq_timeout;
 
-	/*
-	 * Number of consecutive requests that must be issued within
-	 * the idle time slice to set again idling to a queue which
-	 * was marked as non-I/O-bound (see the definition of the
-	 * IO_bound flag for further details).
-	 */
-	unsigned int bfq_requests_within_timer;
-
 	/*
 	 * Force device idling whenever needed to provide accurate
 	 * service guarantees, without caring about throughput
-- 
2.20.1


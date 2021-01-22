Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FFDC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279B623AAC
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbhAVScQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbhAVSYF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:24:05 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C6C061353
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a10so8986727ejg.10
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ync7PZ48gx4UVZHAI7K02vmsl5qLTj/68LiBQ/q3fY=;
        b=WHKfG20W1NGjqkxbfsmPZbXVg+hViuMYnDXAU3Db0epIqKa31itA4Px7dLa/a9ZraV
         jL3rOkuREAsWxTgaeEIHnsjLRb0IZIZq0qgFNJYpQMBHwFdtGvSmcbEAMCcPFOWHQtJu
         FsjBn1w439MPo3jxdbUfiR2XRP0+KUBfo6Ojv/Z1USQYZkU0p8bToG/89tCGtu8w/BJo
         sVWmFMGHLJQoV4WytiOLbWl5u/A79aeuuMcEDjlpQQnqwq+wgix47u19EbA4r2eIEnIC
         Xpd/ZA3yBZZCE1DJr4b+W1cn0RURLy7SAqyGueDhSwi0xzp5fK8F8qm+cvQ5B8vikDjN
         Uv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ync7PZ48gx4UVZHAI7K02vmsl5qLTj/68LiBQ/q3fY=;
        b=uMAX1a1YA3KAEaLedn1DpW61xXelTovlMwxFOOWagc8RRncgnnA/mzu31ofvBSwul2
         kMY3gGQun7us5RjKKgAn52bhXmzxRo/iQk1aGO3z/0e3XfnM1shfo1tHJoAvjQ4wj2Be
         nqp1ZIfbnyzwBuX7l109YfWUrAdt84kvHZo5i8UPqtFzNYHzn5KA3ai7ebcsywB2wYOV
         SQq81f4+XkzR/QWmok+yeTh/SUETqKY+BIdJ5Ch3iFzEIurxTbAxjm8MxV9Ox4gM0TcW
         6drWzZF8El8lLl3al51I73fe7Ydoftau85ltunfw8ZdDNReyUNPt0loBMD29uWWbgWCE
         SqqA==
X-Gm-Message-State: AOAM5309cZoLruax/mvtH9Zdqlc8GGN1YeRmFRYU/jwjlAP+Wvk9DOhq
        O8Gn6wPkkHrUfJ0aXQ17LaLTrA==
X-Google-Smtp-Source: ABdhPJxq4Z+S+aEJXgZVIgei4gpelzO0H045ROe5jVkLKD8AmH04Yk3ARPXBkmynCIBIL6Gn6imcFw==
X-Received: by 2002:a17:907:d04:: with SMTP id gn4mr2621650ejc.126.1611339641511;
        Fri, 22 Jan 2021 10:20:41 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:40 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 5/6] block, bfq: avoid spurious switches to soft_rt of interactive queues
Date:   Fri, 22 Jan 2021 19:19:47 +0100
Message-Id: <20210122181948.35660-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ tags some bfq_queues as interactive or soft_rt if it deems that
these bfq_queues contain the I/O of, respectively, interactive or soft
real-time applications. BFQ privileges both these special types of
bfq_queues over normal bfq_queues. To privilege a bfq_queue, BFQ
mainly raises the weight of the bfq_queue. In particular, soft_rt
bfq_queues get a higher weight than interactive bfq_queues.

A bfq_queue may turn from interactive to soft_rt. And this leads to a
tricky issue. Soft real-time applications usually start with an
I/O-bound, interactive phase, in which they load themselves into main
memory. BFQ correctly detects this phase, and keeps the bfq_queues
associated with the application in interactive mode for a
while. Problems arise when the I/O pattern of the application finally
switches to soft real-time. One of the conditions for a bfq_queue to
be deemed as soft_rt is that the bfq_queue does not consume too much
bandwidth. But the bfq_queues associated with a soft real-time
application consume as much bandwidth as they can in the loading phase
of the application. So, after the application becomes truly soft
real-time, a lot of time should pass before the average bandwidth
consumed by its bfq_queues finally drops to a value acceptable for
soft_rt bfq_queues. As a consequence, there might be a time gap during
which the application is not privileged at all, because its bfq_queues
are not interactive any longer, but cannot be deemed as soft_rt yet.

To avoid this problem, BFQ pretends that an interactive bfq_queue
consumes zero bandwidth, and allows an interactive bfq_queue to switch
to soft_rt. Yet, this fake zero-bandwidth consumption easily causes
the bfq_queue to often switch to soft_rt deceptively, during its
loading phase. As in soft_rt mode, the bfq_queue gets its bandwidth
correctly computed, and therefore soon switches back to
interactive. Then it switches again to soft_rt, and so on. These
spurious fluctuations usually cause losses of throughput, because they
deceive BFQ's mechanisms for boosting throughput (injection,
I/O-plugging avoidance, ...).

This commit addresses this issue as follows:
1) It does compute actual bandwidth consumption also for interactive
   bfq_queues. This avoids the above false positives.
2) When a bfq_queue switches from interactive to normal mode, the
   consumed bandwidth is reset (forgotten). This allows the
   bfq_queue to enjoy soft_rt very quickly. In particular, two
   alternatives are possible in this switch:
    - the bfq_queue still has backlog, and therefore there is a budget
      already scheduled to serve the bfq_queue; in this case, the
      scheduling of the current budget of the bfq_queue is not
      hindered, because only the scheduling of the next budget will
      be affected by the weight drop. After that, if the bfq_queue is
      actually in a soft_rt phase, and becomes empty during the
      service of its current budget, which is the natural behavior of
      a soft_rt bfq_queue, then the bfq_queue will be considered as
      soft_rt when its next I/O arrives. If, in contrast, the
      bfq_queue remains constantly non-empty, then its next budget
      will be scheduled with a low weight, which is the natural
      treatment for an I/O-bound (non soft_rt) bfq_queue.
    - the bfq_queue is empty; in this case, the bfq_queue may be
      considered unjustly soft_rt when its new I/O arrives. Yet
      the problem is now much smaller than before, because it is
      unlikely that more than one spurious fluctuation occurs.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 57 +++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 161badb744d6..003c96fa01ad 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2356,6 +2356,24 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 /* Must be called with bfqq != NULL */
 static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 {
+	/*
+	 * If bfqq has been enjoying interactive weight-raising, then
+	 * reset soft_rt_next_start. We do it for the following
+	 * reason. bfqq may have been conveying the I/O needed to load
+	 * a soft real-time application. Such an application actually
+	 * exhibits a soft real-time I/O pattern after it finishes
+	 * loading, and finally starts doing its job. But, if bfqq has
+	 * been receiving a lot of bandwidth so far (likely to happen
+	 * on a fast device), then soft_rt_next_start now contains a
+	 * high value that. So, without this reset, bfqq would be
+	 * prevented from being possibly considered as soft_rt for a
+	 * very long time.
+	 */
+
+	if (bfqq->wr_cur_max_time !=
+	    bfqq->bfqd->bfq_wr_rt_max_time)
+		bfqq->soft_rt_next_start = jiffies;
+
 	if (bfq_bfqq_busy(bfqq))
 		bfqq->bfqd->wr_busy_queues--;
 	bfqq->wr_coeff = 1;
@@ -3956,30 +3974,15 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 		 * If we get here, and there are no outstanding
 		 * requests, then the request pattern is isochronous
 		 * (see the comments on the function
-		 * bfq_bfqq_softrt_next_start()). Thus we can compute
-		 * soft_rt_next_start. And we do it, unless bfqq is in
-		 * interactive weight raising. We do not do it in the
-		 * latter subcase, for the following reason. bfqq may
-		 * be conveying the I/O needed to load a soft
-		 * real-time application. Such an application will
-		 * actually exhibit a soft real-time I/O pattern after
-		 * it finally starts doing its job. But, if
-		 * soft_rt_next_start is computed here for an
-		 * interactive bfqq, and bfqq had received a lot of
-		 * service before remaining with no outstanding
-		 * request (likely to happen on a fast device), then
-		 * soft_rt_next_start would be assigned such a high
-		 * value that, for a very long time, bfqq would be
-		 * prevented from being possibly considered as soft
-		 * real time.
+		 * bfq_bfqq_softrt_next_start()). Therefore we can
+		 * compute soft_rt_next_start.
 		 *
 		 * If, instead, the queue still has outstanding
 		 * requests, then we have to wait for the completion
 		 * of all the outstanding requests to discover whether
 		 * the request pattern is actually isochronous.
 		 */
-		if (bfqq->dispatched == 0 &&
-		    bfqq->wr_coeff != bfqd->bfq_wr_coeff)
+		if (bfqq->dispatched == 0)
 			bfqq->soft_rt_next_start =
 				bfq_bfqq_softrt_next_start(bfqd, bfqq);
 		else if (bfqq->dispatched > 0) {
@@ -4563,9 +4566,21 @@ static void bfq_update_wr_data(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 						bfqq->wr_cur_max_time)) {
 			if (bfqq->wr_cur_max_time != bfqd->bfq_wr_rt_max_time ||
 			time_is_before_jiffies(bfqq->wr_start_at_switch_to_srt +
-					       bfq_wr_duration(bfqd)))
+					       bfq_wr_duration(bfqd))) {
+				/*
+				 * Either in interactive weight
+				 * raising, or in soft_rt weight
+				 * raising with the
+				 * interactive-weight-raising period
+				 * elapsed (so no switch back to
+				 * interactive weight raising).
+				 */
 				bfq_bfqq_end_wr(bfqq);
-			else {
+			} else { /*
+				  * soft_rt finishing while still in
+				  * interactive period, switch back to
+				  * interactive weight raising
+				  */
 				switch_back_to_interactive_wr(bfqq, bfqd);
 				bfqq->entity.prio_changed = 1;
 			}
@@ -5016,6 +5031,8 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	}
 
 	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
+	bfq_log_bfqq(bfqd, bfqq, "new_ioprio %d new_weight %d",
+		     bfqq->new_ioprio, bfqq->entity.new_weight);
 	bfqq->entity.prio_changed = 1;
 }
 
-- 
2.20.1


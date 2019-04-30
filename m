Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560BC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9252121670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K35uN9Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfD3Hf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfD3HfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id q10so11798578ljc.6;
        Tue, 30 Apr 2019 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4L9J9dAEoQlGCP+x9t5jKWTgnLhmW8dV6Nb+oW0n3A=;
        b=K35uN9Zlj58R341Z/qXn0mrBFqREe5xLoDm+1zlj+w2BquLt6gB8q/XwH22N58JBgP
         hezSNnR7CLnbaRE/O1fu7boo6XcudBklxYusfbVTL5Sz2EXhqWG6i3kus6aCN1h0BfEM
         190dn4ENHuQM7mpZdTZannSUJ8hpxMjzGPTjK+pCrK7hJhmfMiXkgynvKrCfUv8ncamr
         b/d8tXKPcU+T83vX4CxljWN9Wyvat+U11VCmU2omeNhlb41dVtCcOInBY0DsA+DJdFH1
         9HVMkaoMwNHiI5LSJQneido3h90OBSfLlasKXJORNcBzZ2xNxiimD9WiBrIJC8iHV5ow
         V/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4L9J9dAEoQlGCP+x9t5jKWTgnLhmW8dV6Nb+oW0n3A=;
        b=JfZzYNty9p4hhZ3LuMhu5gx46qWllalMfabilTGK3b5qjKkdMDBWQHHCHQeBEfc19i
         +1hCKke0fPx0KwKjH1LMJj/vrGpri7m/RL8uAWnT3Zq3dXUMqDn302zXl38g2poTWs/Y
         CYsNrQIvATHwTlEuiqJdvUe0dqsh8eLz9YxU+9gsXkhHhECVCMBmifW/rPkp9zkwIKsU
         UNrhNUzPoaeIbKiGhs6kmkc2N8eAZj29lfXHOQuaE07Y7I7PcEbnYh3JGNPLcKvDkpkD
         b+k49tXP5xAFl9zSoI5juESeIjgGkNdIy0f4nWX6QG0yHJbsrs/v49VgvXcHtP7PYRa6
         YqSw==
X-Gm-Message-State: APjAAAXptwi59yEFCSzkg/Ai3C+GGmPfhnpd4H5pKpxxJJS14oY6aIb4
        Lv4v9zaZQJVVen8YPJvgG7U=
X-Google-Smtp-Source: APXvYqxrI3bf3njEPBSGRY9DDunnyCW7fa8B2f49T9zIIbcxhHcvtx3pHieXY9+Ntj5b4rHCdRnD0Q==
X-Received: by 2002:a2e:8703:: with SMTP id m3mr33795416lji.107.1556609707787;
        Tue, 30 Apr 2019 00:35:07 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:35:07 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 6/7] blk-mq: Track num of overslept by hybrid poll rqs
Date:   Tue, 30 Apr 2019 10:34:18 +0300
Message-Id: <0096e72ed1e1c94021a33cddeffee36abe78338b.1556609582.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1556609582.git.asml.silence@gmail.com>
References: <cover.1556609582.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

To fine-tune adaptive polling sleep time, it's needed to know how
accurate the current estimate is, which could be done using the ratio of
missed (i.e., overslept) requests.

The collection of the missed number is performed with an assumption,
that a request needs to busy poll for some time after wake up to
complete. And if it was completed by the first poll call, than
that's a miss.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c       |  4 +-
 block/blk-mq.c         | 94 ++++++++++++++++++++++++++++++------------
 block/blk-stat.c       |  2 +-
 include/linux/blkdev.h |  9 ++++
 4 files changed, 81 insertions(+), 28 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index daadce545e43..88d8ec4268ca 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -536,8 +536,10 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (blkcg_init_queue(q))
 		goto fail_ref;
 
-	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++)
+	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
 		q->poll_info[bucket].sleep_ns = 0;
+		atomic_set(&q->poll_info[bucket].nr_misses, 0);
+	}
 
 	return q;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e54a004e345..ec7cde754c2f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -528,6 +528,34 @@ void blk_mq_free_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
+static inline void blk_mq_record_stats(struct request *rq, u64 now)
+{
+	int bucket = blk_mq_poll_stats_bkt(rq);
+
+	if (bucket >= 0 && !(rq->rq_flags & RQF_MQ_POLLED)) {
+		struct poll_info *pi;
+		u64 threshold;
+
+		pi = &rq->q->poll_info[bucket];
+		/*
+		 * Even if the time for hybrid polling predicted well, the
+		 * completion could oversleep because of a timer's lag. Try
+		 * to detect and skip accounting for such outliers.
+		 */
+		threshold = pi->stat.mean;
+
+		/*
+		 * Ideally, miss count should be close to 0,
+		 * so should not happen often.
+		 */
+		if (blk_rq_io_time(rq, now) < threshold)
+			atomic_inc(&pi->nr_misses);
+	}
+
+	blk_mq_poll_stats_start(rq->q);
+	blk_stat_add(rq, now);
+}
+
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	u64 now = 0;
@@ -574,10 +602,8 @@ static void __blk_mq_complete_request(struct request *rq)
 
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
-	if (rq->rq_flags & RQF_STATS) {
-		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq, ktime_get_ns());
-	}
+	if (rq->rq_flags & RQF_STATS)
+		blk_mq_record_stats(rq, ktime_get_ns());
 	/*
 	 * Most of single queue controllers, there is only one irq vector
 	 * for handling IO completion, and the only irq's affinity is set
@@ -3316,14 +3342,25 @@ static void blk_mq_update_poll_info(struct poll_info *pi,
 				    struct blk_rq_stat *stat)
 {
 	u64 sleep_ns;
+	u32 nr_misses, nr_samples;
+
+	nr_samples = stat->nr_samples;
+	nr_misses = atomic_read(&pi->nr_misses);
+	if (nr_misses > nr_samples)
+		nr_misses = nr_samples;
 
-	if (!stat->nr_samples)
+	if (!nr_samples)
 		sleep_ns = 0;
 	else
 		sleep_ns = (stat->mean + 1) / 2;
 
+	/*
+	 * Use miss ratio here to adjust sleep time
+	 */
+
 	pi->stat = *stat;
 	pi->sleep_ns = sleep_ns;
+	atomic_set(&pi->nr_misses, 0);
 }
 
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
@@ -3389,10 +3426,6 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	rq->rq_flags |= RQF_MQ_POLL_SLEPT;
 
-	/*
-	 * This will be replaced with the stats tracking code, using
-	 * 'avg_completion_time / 2' as the pre-sleep target.
-	 */
 	kt = nsecs;
 
 	mode = HRTIMER_MODE_REL;
@@ -3417,30 +3450,34 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 }
 
 static bool blk_mq_poll_hybrid(struct request_queue *q,
-			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+			       struct blk_mq_hw_ctx *hctx,
+			       struct request *rq)
 {
-	struct request *rq;
-
 	if (q->poll_nsec == BLK_MQ_POLL_CLASSIC)
 		return false;
 
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return false;
-	}
+	/*
+	 * With scheduling, if the request has completed, we'll
+	 * get a NULL request here, as we clear the sched tag when
+	 * that happens. The request still remains valid, like always,
+	 * so we should be safe with just the NULL check.
+	 */
+	if (!rq)
+		return false;
 
 	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
 }
 
+static inline struct request *qc_t_to_request(struct blk_mq_hw_ctx *hctx,
+		blk_qc_t cookie)
+{
+	struct blk_mq_tags *tags;
+
+	tags = blk_qc_t_is_internal(cookie) ? hctx->sched_tags : hctx->tags;
+
+	return blk_mq_tag_to_rq(tags, blk_qc_t_to_tag(cookie));
+}
+
 /**
  * blk_poll - poll for IO completions
  * @q:  the queue
@@ -3456,6 +3493,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
+	struct request *rq;
 	long state;
 
 	if (!blk_qc_t_valid(cookie) ||
@@ -3466,6 +3504,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 		blk_flush_plug_list(current->plug, false);
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
+	rq = qc_t_to_request(hctx, cookie);
 
 	/*
 	 * If we sleep, have the caller restart the poll loop to reset
@@ -3474,7 +3513,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	 * the IO isn't complete, we'll get called again and will go
 	 * straight to the busy poll loop.
 	 */
-	if (blk_mq_poll_hybrid(q, hctx, cookie))
+	if (blk_mq_poll_hybrid(q, hctx, rq))
 		return 1;
 
 	hctx->poll_considered++;
@@ -3486,6 +3525,9 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 		hctx->poll_invoked++;
 
 		ret = q->mq_ops->poll(hctx);
+		if (rq)
+			rq->rq_flags |= RQF_MQ_POLLED;
+
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index e1915a4e41b9..33b7b9c35791 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -94,7 +94,7 @@ void blk_stat_add(struct request *rq, u64 now)
 	int bucket;
 	u64 value;
 
-	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
+	value = blk_rq_io_time(rq, now);
 
 	blk_throtl_stat_add(rq, value);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 40c77935fd61..36f17ed1376a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -109,6 +109,9 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
 /* ->timeout has been called, don't expire again */
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
+/* Request has been polled at least once */
+#define RQF_MQ_POLLED		((__force req_flags_t)(1 << 22))
+
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
@@ -389,6 +392,7 @@ struct poll_info
 {
 	struct blk_rq_stat	stat;
 	u64			sleep_ns;
+	atomic_t		nr_misses;
 };
 
 struct request_queue {
@@ -924,6 +928,11 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static inline u64 blk_rq_io_time(struct request *rq, u64 now)
+{
+	return (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
+}
+
 /*
  * Some commands like WRITE SAME have a payload or data transfer size which
  * is different from the size of the request.  Any driver that supports such
-- 
2.21.0


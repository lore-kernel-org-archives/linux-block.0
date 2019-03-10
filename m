Return-Path: <SRS0=4SCO=RN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191FC43381
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF74B206DF
	for <linux-block@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nO3pUx4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfCJSMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:12:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCJSMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so2187602wma.0
        for <linux-block@vger.kernel.org>; Sun, 10 Mar 2019 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QZLgskSCrdBD9un8CU62IVDYuz5MmLQQB3oIqrmxZE=;
        b=nO3pUx4OMmDgoQO5L2YrY+nrS1Hq8rf5ZJP8jui67Shle2skP7E8ufW5Ep0Dm654C2
         i/kkCc2op5YOwwSamzjNbgbCeVkC9dHweYik0iOrudeQXruBK9F6/P0goq27qVnlpbiE
         NfxDNVVcNCpM5XAqBjV93Bt3ji4ua2B+vYf3KxZkohaPe9SlMLsk28f60ok7OYQNmzmz
         jg52gentUnxoRJBCy0oHphDHHSYOW6i5SxKgCDNCAgGSMMidgQgZ+jEPTRF3g5U4Os6s
         jxrzI7OcoS8tru1H2l8w62YgSCnLJbqyuPD8MoPFPPvTXzzdSxAh3EbAsmC4ozXy8ByF
         lHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QZLgskSCrdBD9un8CU62IVDYuz5MmLQQB3oIqrmxZE=;
        b=GQiuokdHGvZegyAIXgmLr1PM3WCMY8Kr6oD+2JYJAZrQmfUHAViJ6hdci5OlZIy8A2
         xfH82Cxkb2OxPbhnQNRRoi9YR3wlXNN9TiwAts+ZUKXuz5DcbqlOh6wqANrzYIB4xBU4
         zKuOfV9wNpAZkGdUEYBc4wQyam7zQaAzmx6RngQSTCew/PtLl9fdBkh4XK/vqujqQ9Yy
         aYCheDksyMDscA28YAZuYuVRdsroSv83cj87Sg+OjjhLMYKXYGX4NTyoI6I9vEvSjjiL
         3Sr3RrPFaKTEItF8j/BYeSP17y9jpyDN28fLOwzNAGxsxVEIe3t/vksHSxlhheVGPopU
         wgGw==
X-Gm-Message-State: APjAAAWK3O0wqBc8BKAgbAQ2+q5Bqyo63u1Ig25G6tZ76ATJjXSLrSK2
        RiwbqrqlTgWZI9kuqBZLWAcglw==
X-Google-Smtp-Source: APXvYqxK91pUlXI2fHCDWIVw/PB6Vzd2bv9CU8NN5ffGWdsSvAu+HiGL6ZgGKDuypEPdnFIGfTm6kw==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr14919968wmf.65.1552241538035;
        Sun, 10 Mar 2019 11:12:18 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:17 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 4/9] block, bfq: do not merge queues on flash storage with queueing
Date:   Sun, 10 Mar 2019 19:11:32 +0100
Message-Id: <20190310181137.2604-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To boost throughput with a set of processes doing interleaved I/O
(i.e., a set of processes whose individual I/O is random, but whose
merged cumulative I/O is sequential), BFQ merges the queues associated
with these processes, i.e., redirects the I/O of these processes into a
common, shared queue. In the shared queue, I/O requests are ordered by
their position on the medium, thus sequential I/O gets dispatched to
the device when the shared queue is served.

Queue merging costs execution time, because, to detect which queues to
merge, BFQ must maintain a list of the head I/O requests of active
queues, ordered by request positions. Measurements showed that this
costs about 10% of BFQ's total per-request processing time.

Request processing time becomes more and more critical as the speed of
the underlying storage device grows. Yet, fortunately, queue merging
is basically useless on the very devices that are so fast to make
request processing time critical. To reach a high throughput, these
devices must have many requests queued at the same time. But, in this
configuration, the internal scheduling algorithms of these devices do
also the job of queue merging: they reorder requests so as to obtain
as much as possible a sequential I/O pattern. As a consequence, with
processes doing interleaved I/O, the throughput reached by one such
device is likely to be the same, with and without queue merging.

In view of this fact, this commit disables queue merging, and all
related housekeeping, for non-rotational devices with internal
queueing. The total, single-lock-protected, per-request processing
time of BFQ drops to, e.g., 1.9 us on an Intel Core i7-2760QM@2.40GHz
(time measured with simple code instrumentation, and using the
throughput-sync.sh script of the S suite [1], in performance-profiling
mode). To put this result into context, the total,
single-lock-protected, per-request execution time of the lightest I/O
scheduler available in blk-mq, mq-deadline, is 0.7 us (mq-deadline is
~800 LOC, against ~10500 LOC for BFQ).

Disabling merging provides a further, remarkable benefit in terms of
throughput. Merging tends to make many workloads artificially more
uneven, mainly because of shared queues remaining non empty for
incomparably more time than normal queues. So, if, e.g., one of the
queues in a set of merged queues has a higher weight than a normal
queue, then the shared queue may inherit such a high weight and, by
staying almost always active, may force BFQ to perform I/O plugging
most of the time. This evidently makes it harder for BFQ to let the
device reach a high throughput.

As a practical example of this problem, and of the benefits of this
commit, we measured again the throughput in the nasty scenario
considered in previous commit messages: dbench test (in the Phoronix
suite), with 6 clients, on a filesystem with journaling, and with the
journaling daemon enjoying a higher weight than normal processes. With
this commit, the throughput grows from ~150 MB/s to ~200 MB/s on a
PLEXTOR PX-256M5 SSD. This is the same peak throughput reached by any
of the other I/O schedulers. As such, this is also likely to be the
maximum possible throughput reachable with this workload on this
device, because I/O is mostly random, and the other schedulers
basically just pass I/O requests to the drive as fast as possible.

[1] https://github.com/Algodev-github/S

Tested-by: Francesco Pollicino <fra.fra.800@gmail.com>
Signed-off-by: Alessio Masola <alessio.masola@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  3 +-
 block/bfq-iosched.c | 73 +++++++++++++++++++++++++++++++++++++++++----
 block/bfq-iosched.h |  3 ++
 3 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c6113af31960..2a74a3f2a8f7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -578,7 +578,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfqg_and_blkg_get(bfqg);
 
 	if (bfq_bfqq_busy(bfqq)) {
-		bfq_pos_tree_add_move(bfqd, bfqq);
+		if (unlikely(!bfqd->nonrot_with_queueing))
+			bfq_pos_tree_add_move(bfqd, bfqq);
 		bfq_activate_bfqq(bfqd, bfqq);
 	}
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 41364c0cca8c..b96be3764b8a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -595,7 +595,16 @@ static bool bfq_too_late_for_merging(struct bfq_queue *bfqq)
 				       bfq_merge_time_limit);
 }
 
-void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+/*
+ * The following function is not marked as __cold because it is
+ * actually cold, but for the same performance goal described in the
+ * comments on the likely() at the beginning of
+ * bfq_setup_cooperator(). Unexpectedly, to reach an even lower
+ * execution time for the case where this function is not invoked, we
+ * had to add an unlikely() in each involved if().
+ */
+void __cold
+bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	struct rb_node **p, *parent;
 	struct bfq_queue *__bfqq;
@@ -1849,8 +1858,9 @@ static void bfq_add_request(struct request *rq)
 
 	/*
 	 * Adjust priority tree position, if next_rq changes.
+	 * See comments on bfq_pos_tree_add_move() for the unlikely().
 	 */
-	if (prev != bfqq->next_rq)
+	if (unlikely(!bfqd->nonrot_with_queueing && prev != bfqq->next_rq))
 		bfq_pos_tree_add_move(bfqd, bfqq);
 
 	if (!bfq_bfqq_busy(bfqq)) /* switching to busy ... */
@@ -1990,7 +2000,9 @@ static void bfq_remove_request(struct request_queue *q,
 			bfqq->pos_root = NULL;
 		}
 	} else {
-		bfq_pos_tree_add_move(bfqd, bfqq);
+		/* see comments on bfq_pos_tree_add_move() for the unlikely() */
+		if (unlikely(!bfqd->nonrot_with_queueing))
+			bfq_pos_tree_add_move(bfqd, bfqq);
 	}
 
 	if (rq->cmd_flags & REQ_META)
@@ -2075,7 +2087,12 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
 		 */
 		if (prev != bfqq->next_rq) {
 			bfq_updated_next_req(bfqd, bfqq);
-			bfq_pos_tree_add_move(bfqd, bfqq);
+			/*
+			 * See comments on bfq_pos_tree_add_move() for
+			 * the unlikely().
+			 */
+			if (unlikely(!bfqd->nonrot_with_queueing))
+				bfq_pos_tree_add_move(bfqd, bfqq);
 		}
 	}
 }
@@ -2357,6 +2374,46 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_queue *in_service_bfqq, *new_bfqq;
 
+	/*
+	 * Do not perform queue merging if the device is non
+	 * rotational and performs internal queueing. In fact, such a
+	 * device reaches a high speed through internal parallelism
+	 * and pipelining. This means that, to reach a high
+	 * throughput, it must have many requests enqueued at the same
+	 * time. But, in this configuration, the internal scheduling
+	 * algorithm of the device does exactly the job of queue
+	 * merging: it reorders requests so as to obtain as much as
+	 * possible a sequential I/O pattern. As a consequence, with
+	 * the workload generated by processes doing interleaved I/O,
+	 * the throughput reached by the device is likely to be the
+	 * same, with and without queue merging.
+	 *
+	 * Disabling merging also provides a remarkable benefit in
+	 * terms of throughput. Merging tends to make many workloads
+	 * artificially more uneven, because of shared queues
+	 * remaining non empty for incomparably more time than
+	 * non-merged queues. This may accentuate workload
+	 * asymmetries. For example, if one of the queues in a set of
+	 * merged queues has a higher weight than a normal queue, then
+	 * the shared queue may inherit such a high weight and, by
+	 * staying almost always active, may force BFQ to perform I/O
+	 * plugging most of the time. This evidently makes it harder
+	 * for BFQ to let the device reach a high throughput.
+	 *
+	 * Finally, the likely() macro below is not used because one
+	 * of the two branches is more likely than the other, but to
+	 * have the code path after the following if() executed as
+	 * fast as possible for the case of a non rotational device
+	 * with queueing. We want it because this is the fastest kind
+	 * of device. On the opposite end, the likely() may lengthen
+	 * the execution time of BFQ for the case of slower devices
+	 * (rotational or at least without queueing). But in this case
+	 * the execution time of BFQ matters very little, if not at
+	 * all.
+	 */
+	if (likely(bfqd->nonrot_with_queueing))
+		return NULL;
+
 	/*
 	 * Prevent bfqq from being merged if it has been created too
 	 * long ago. The idea is that true cooperating processes, and
@@ -2986,8 +3043,10 @@ static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		bfq_requeue_bfqq(bfqd, bfqq, true);
 		/*
 		 * Resort priority tree of potential close cooperators.
+		 * See comments on bfq_pos_tree_add_move() for the unlikely().
 		 */
-		bfq_pos_tree_add_move(bfqd, bfqq);
+		if (unlikely(!bfqd->nonrot_with_queueing))
+			bfq_pos_tree_add_move(bfqd, bfqq);
 	}
 
 	/*
@@ -5051,6 +5110,9 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	bfqd->hw_tag = bfqd->max_rq_in_driver > BFQ_HW_QUEUE_THRESHOLD;
 	bfqd->max_rq_in_driver = 0;
 	bfqd->hw_tag_samples = 0;
+
+	bfqd->nonrot_with_queueing =
+		blk_queue_nonrot(bfqd->queue) && bfqd->hw_tag;
 }
 
 static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
@@ -5882,6 +5944,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	INIT_HLIST_HEAD(&bfqd->burst_list);
 
 	bfqd->hw_tag = -1;
+	bfqd->nonrot_with_queueing = blk_queue_nonrot(bfqd->queue);
 
 	bfqd->bfq_max_budget = bfq_default_max_budget;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 26869cfbbfa9..829730b96fb2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -497,6 +497,9 @@ struct bfq_data {
 	/* number of requests dispatched and waiting for completion */
 	int rq_in_driver;
 
+	/* true if the device is non rotational and performs queueing */
+	bool nonrot_with_queueing;
+
 	/*
 	 * Maximum number of requests in driver in the last
 	 * @hw_tag_samples completed requests.
-- 
2.20.1


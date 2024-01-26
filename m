Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884524B28
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305117; cv=none; b=W5MEtnglE2IfDxGyHR2/Dt+VFc9+zY4FOStT9pWH9k1P7z6SxrOBT5KdjmIVa/pjuuS3GR3UkpANvN5ZKpTZLIZ+p0+3nM3AXUdjL2LjbHvUn7OqrjbzYdsDiwp3LeOy6vfYQ05n/mCmaEso2uonj6GPe3l5rnmpRvYrP3lBoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305117; c=relaxed/simple;
	bh=TiPFZMoQf7s6cYWhJDrcrxkvBj/AbRHWakKJC6lHucs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX5ZK+/BjJL3oIsaqcONgywq7z0Bd3QUvYokYf6b+GJ7CbRU1Hh1XD6wMwkC6XBjJVdg2PGycf4bg1sQug5FfH/H2zIzHnD48F4BGZFlbI2J3goTS2WNeYwqH7yS1+/B4FWRlVp3NNQ4GMkz0YLjKJB3VsqaN9S7BfzAHZgOF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t9YPU/ox; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t9YPU/ox"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so16260839f.0
        for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706305113; x=1706909913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvcyg50oGgcL0TRTk/ptioiiAOEOOV4JrBImTrzg+fU=;
        b=t9YPU/oxbPMvGnBKczIJMVwCudtcdJpojf/tFOjvimnwfQ64DLiIJdPK4oOEC9cUOh
         b1p5Oui5hDNKstoOI4syfoqaQ9MHyOrqDoFYHhZbfA4WEfwAlQeUxhLHlNfV3Iifvsvu
         KFVZT31dBCQGdRGofVDzQDB0oYNQHshrMaEkNfFet4mm66U71+qGRX60tcYmypsxiVar
         ucFlvMHzkNXW6x0JgFoBbr5DjgCXv2bz1llS6lQ+UbayCh9vTQZwlj6hgm1ujHVJB5ul
         VsL48wU/XuGhpz10cItrWWt8KVk8wDznzSGc0y4QPLDM9o30lPdfT2B/KuTiAbbmHkrc
         gMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305113; x=1706909913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvcyg50oGgcL0TRTk/ptioiiAOEOOV4JrBImTrzg+fU=;
        b=qEzUsJYPUado8P5G4G3qtNyKlBYqPyTxoDKmh66KiBoD8II/gOGvPoiX/TzSSg0HYm
         61lKDHWhLamMSVeCmUBLUe8VCGpReQoWJFZK+yCv8Y9jVb4cM6INUzOwL8o0HsYDfZMO
         i9csYMtHv57XTpcLoneYMFzyMbFBXD20UwB2narBJEskmI9b5zITR4R+j/Pj24tA2WiM
         M9ie4cSXpEcbvvaqMLaxLee7KAMM7yFnILsPnwut1/W+o2dAicxcOTh2jEfm5ZySd8uX
         dCTyfb4MINbPs1VXqkemstbWKuKj5YgxXSTZ+mLENkMrrLYrkiybsnEdEmQU2glvdsBF
         pBQw==
X-Gm-Message-State: AOJu0Yw/Sv274HIZ7WavlqOgT4N4831PqrCh3COCUG7VcN/Fn/BQxp6b
	sMeRsacMh7eQawqs9Zrzw52AzAtkoWLVIj/T2cdOsxJQwabtgr7LAk4F4LjaQIbCixPFDidH1bh
	Sazc=
X-Google-Smtp-Source: AGHT+IHHJDbs6cPFnDcKE9yD/sNMkgKyx+DabnDjOrgCJ89utZ9BhVtxmFH3b9D4H4FVGDkhdURK4A==
X-Received: by 2002:a6b:f815:0:b0:7bf:cc4d:ea53 with SMTP id o21-20020a6bf815000000b007bfcc4dea53mr963059ioh.0.1706305113348;
        Fri, 26 Jan 2024 13:38:33 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b4-20020a029a04000000b0046f34484578sm471788jal.126.2024.01.26.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:38:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/4] block: add blk_time_get_ns() and blk_time_get() helpers
Date: Fri, 26 Jan 2024 14:30:32 -0700
Message-ID: <20240126213827.2757115-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126213827.2757115-1-axboe@kernel.dk>
References: <20240126213827.2757115-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert any user of ktime_get_ns() to use blk_time_get_ns(), and
ktime_get() to blk_time_get(), so we have a unified API for querying the
current time in nanoseconds or as ktime.

No functional changes intended, this patch just wraps ktime_get_ns()
and ktime_get() with a block helper.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-cgroup.c    | 14 +++++++-------
 block/bfq-iosched.c   | 28 ++++++++++++++--------------
 block/blk-cgroup.c    |  2 +-
 block/blk-flush.c     |  2 +-
 block/blk-iocost.c    |  8 ++++----
 block/blk-iolatency.c |  6 +++---
 block/blk-mq.c        | 16 ++++++++--------
 block/blk-throttle.c  |  6 +++---
 block/blk-wbt.c       |  6 +++---
 block/blk.h           | 13 ++++++++++++-
 10 files changed, 56 insertions(+), 45 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 2c90e5de0acd..d442ee358fc2 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -127,7 +127,7 @@ static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
 	if (!bfqg_stats_waiting(stats))
 		return;
 
-	now = ktime_get_ns();
+	now = blk_time_get_ns();
 	if (now > stats->start_group_wait_time)
 		bfq_stat_add(&stats->group_wait_time,
 			      now - stats->start_group_wait_time);
@@ -144,7 +144,7 @@ static void bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
 		return;
 	if (bfqg == curr_bfqg)
 		return;
-	stats->start_group_wait_time = ktime_get_ns();
+	stats->start_group_wait_time = blk_time_get_ns();
 	bfqg_stats_mark_waiting(stats);
 }
 
@@ -156,7 +156,7 @@ static void bfqg_stats_end_empty_time(struct bfqg_stats *stats)
 	if (!bfqg_stats_empty(stats))
 		return;
 
-	now = ktime_get_ns();
+	now = blk_time_get_ns();
 	if (now > stats->start_empty_time)
 		bfq_stat_add(&stats->empty_time,
 			      now - stats->start_empty_time);
@@ -183,7 +183,7 @@ void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
 	if (bfqg_stats_empty(stats))
 		return;
 
-	stats->start_empty_time = ktime_get_ns();
+	stats->start_empty_time = blk_time_get_ns();
 	bfqg_stats_mark_empty(stats);
 }
 
@@ -192,7 +192,7 @@ void bfqg_stats_update_idle_time(struct bfq_group *bfqg)
 	struct bfqg_stats *stats = &bfqg->stats;
 
 	if (bfqg_stats_idling(stats)) {
-		u64 now = ktime_get_ns();
+		u64 now = blk_time_get_ns();
 
 		if (now > stats->start_idle_time)
 			bfq_stat_add(&stats->idle_time,
@@ -205,7 +205,7 @@ void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
 
-	stats->start_idle_time = ktime_get_ns();
+	stats->start_idle_time = blk_time_get_ns();
 	bfqg_stats_mark_idling(stats);
 }
 
@@ -242,7 +242,7 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
 				  u64 io_start_time_ns, blk_opf_t opf)
 {
 	struct bfqg_stats *stats = &bfqg->stats;
-	u64 now = ktime_get_ns();
+	u64 now = blk_time_get_ns();
 
 	if (now > io_start_time_ns)
 		blkg_rwstat_add(&stats->service_time, opf,
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3cce6de464a7..4b88a54a9b76 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1005,7 +1005,7 @@ static struct request *bfq_check_fifo(struct bfq_queue *bfqq,
 
 	rq = rq_entry_fifo(bfqq->fifo.next);
 
-	if (rq == last || ktime_get_ns() < rq->fifo_time)
+	if (rq == last || blk_time_get_ns() < rq->fifo_time)
 		return NULL;
 
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "check_fifo: returned %p", rq);
@@ -1829,7 +1829,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		 * bfq_bfqq_update_budg_for_activation for
 		 * details on the usage of the next variable.
 		 */
-		arrived_in_time =  ktime_get_ns() <=
+		arrived_in_time =  blk_time_get_ns() <=
 			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
 	unsigned int act_idx = bfq_actuator_index(bfqd, rq->bio);
@@ -2208,7 +2208,7 @@ static void bfq_add_request(struct request *rq)
 	struct request *next_rq, *prev;
 	unsigned int old_wr_coeff = bfqq->wr_coeff;
 	bool interactive = false;
-	u64 now_ns = ktime_get_ns();
+	u64 now_ns = blk_time_get_ns();
 
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
@@ -2262,7 +2262,7 @@ static void bfq_add_request(struct request *rq)
 		      bfqd->rqs_injected && bfqd->tot_rq_in_driver > 0)) &&
 		    time_is_before_eq_jiffies(bfqq->decrease_time_jif +
 					      msecs_to_jiffies(10))) {
-			bfqd->last_empty_occupied_ns = ktime_get_ns();
+			bfqd->last_empty_occupied_ns = blk_time_get_ns();
 			/*
 			 * Start the state machine for measuring the
 			 * total service time of rq: setting
@@ -3294,7 +3294,7 @@ static void bfq_set_budget_timeout(struct bfq_data *bfqd,
 	else
 		timeout_coeff = bfqq->entity.weight / bfqq->entity.orig_weight;
 
-	bfqd->last_budget_start = ktime_get();
+	bfqd->last_budget_start = blk_time_get();
 
 	bfqq->budget_timeout = jiffies +
 		bfqd->bfq_timeout * timeout_coeff;
@@ -3394,7 +3394,7 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 	else if (bfqq->wr_coeff > 1)
 		sl = max_t(u32, sl, 20ULL * NSEC_PER_MSEC);
 
-	bfqd->last_idling_start = ktime_get();
+	bfqd->last_idling_start = blk_time_get();
 	bfqd->last_idling_start_jiffies = jiffies;
 
 	hrtimer_start(&bfqd->idle_slice_timer, ns_to_ktime(sl),
@@ -3433,7 +3433,7 @@ static void bfq_reset_rate_computation(struct bfq_data *bfqd,
 				       struct request *rq)
 {
 	if (rq != NULL) { /* new rq dispatch now, reset accordingly */
-		bfqd->last_dispatch = bfqd->first_dispatch = ktime_get_ns();
+		bfqd->last_dispatch = bfqd->first_dispatch = blk_time_get_ns();
 		bfqd->peak_rate_samples = 1;
 		bfqd->sequential_samples = 0;
 		bfqd->tot_sectors_dispatched = bfqd->last_rq_max_size =
@@ -3590,7 +3590,7 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
  */
 static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 {
-	u64 now_ns = ktime_get_ns();
+	u64 now_ns = blk_time_get_ns();
 
 	if (bfqd->peak_rate_samples == 0) { /* first dispatch */
 		bfq_log(bfqd, "update_peak_rate: goto reset, samples %d",
@@ -4162,7 +4162,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (compensate)
 		delta_ktime = bfqd->last_idling_start;
 	else
-		delta_ktime = ktime_get();
+		delta_ktime = blk_time_get();
 	delta_ktime = ktime_sub(delta_ktime, bfqd->last_budget_start);
 	delta_usecs = ktime_to_us(delta_ktime);
 
@@ -5591,7 +5591,7 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  struct bfq_io_cq *bic, pid_t pid, int is_sync,
 			  unsigned int act_idx)
 {
-	u64 now_ns = ktime_get_ns();
+	u64 now_ns = blk_time_get_ns();
 
 	bfqq->actuator_idx = act_idx;
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
@@ -5903,7 +5903,7 @@ static void bfq_update_io_thinktime(struct bfq_data *bfqd,
 	 */
 	if (bfqq->dispatched || bfq_bfqq_busy(bfqq))
 		return;
-	elapsed = ktime_get_ns() - bfqq->ttime.last_end_request;
+	elapsed = blk_time_get_ns() - bfqq->ttime.last_end_request;
 	elapsed = min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
 
 	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
@@ -6194,7 +6194,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bfq_add_request(rq);
 	idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);
 
-	rq->fifo_time = ktime_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
+	rq->fifo_time = blk_time_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
 	list_add_tail(&rq->queuelist, &bfqq->fifo);
 
 	bfq_rq_enqueued(bfqd, bfqq, rq);
@@ -6370,7 +6370,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		bfq_weights_tree_remove(bfqq);
 	}
 
-	now_ns = ktime_get_ns();
+	now_ns = blk_time_get_ns();
 
 	bfqq->ttime.last_end_request = now_ns;
 
@@ -6585,7 +6585,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 static void bfq_update_inject_limit(struct bfq_data *bfqd,
 				    struct bfq_queue *bfqq)
 {
-	u64 tot_time_ns = ktime_get_ns() - bfqd->last_empty_occupied_ns;
+	u64 tot_time_ns = blk_time_get_ns() - bfqd->last_empty_occupied_ns;
 	unsigned int old_limit = bfqq->inject_limit;
 
 	if (bfqq->last_serv_time_ns > 0 && bfqd->rqs_injected) {
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ff93c385ba5a..bdbb557feb5a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1846,7 +1846,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 {
 	unsigned long pflags;
 	bool clamp;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = blk_time_get_ns();
 	u64 exp;
 	u64 delay_nsec = 0;
 	int tok;
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3f4d41952ef2..b0f314f4bc14 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -143,7 +143,7 @@ static void blk_account_io_flush(struct request *rq)
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
 	part_stat_add(part, nsecs[STAT_FLUSH],
-		      ktime_get_ns() - rq->start_time_ns);
+		      blk_time_get_ns() - rq->start_time_ns);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index c8beec6d7df0..4b0b483a9693 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -829,7 +829,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 
 	/* step up/down based on the vrate */
 	vrate_pct = div64_u64(ioc->vtime_base_rate * 100, VTIME_PER_USEC);
-	now_ns = ktime_get_ns();
+	now_ns = blk_time_get_ns();
 
 	if (p->too_fast_vrate_pct && p->too_fast_vrate_pct <= vrate_pct) {
 		if (!ioc->autop_too_fast_at)
@@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 	unsigned seq;
 	u64 vrate;
 
-	now->now_ns = ktime_get();
+	now->now_ns = blk_time_get_ns();
 	now->now = ktime_to_us(now->now_ns);
 	vrate = atomic64_read(&ioc->vtime_rate);
 
@@ -2810,7 +2810,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 		return;
 	}
 
-	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
+	on_q_ns = blk_time_get_ns() - rq->alloc_time_ns;
 	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
 	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
 
@@ -2893,7 +2893,7 @@ static int blk_iocost_init(struct gendisk *disk)
 	ioc->vtime_base_rate = VTIME_PER_USEC;
 	atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
 	seqcount_spinlock_init(&ioc->period_seqcount, &ioc->lock);
-	ioc->period_at = ktime_to_us(ktime_get());
+	ioc->period_at = ktime_to_us(blk_time_get());
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c1a6aba1d59e..ebb522788d97 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -609,7 +609,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
 	if (!iolat->blkiolat->enabled)
 		return;
 
-	now = ktime_to_ns(ktime_get());
+	now = blk_time_get_ns();
 	while (blkg && blkg->parent) {
 		iolat = blkg_to_lat(blkg);
 		if (!iolat) {
@@ -661,7 +661,7 @@ static void blkiolatency_timer_fn(struct timer_list *t)
 	struct blk_iolatency *blkiolat = from_timer(blkiolat, t, timer);
 	struct blkcg_gq *blkg;
 	struct cgroup_subsys_state *pos_css;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = blk_time_get_ns();
 
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(blkg, pos_css,
@@ -985,7 +985,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
 	struct rq_qos *rqos = iolat_rq_qos(blkg->q);
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = blk_time_get_ns();
 	int cpu;
 
 	if (blk_queue_nonrot(blkg->q))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..aff9e9492f59 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -323,7 +323,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag = BLK_MQ_NO_TAG;
 	rq->internal_tag = BLK_MQ_NO_TAG;
-	rq->start_time_ns = ktime_get_ns();
+	rq->start_time_ns = blk_time_get_ns();
 	rq->part = NULL;
 	blk_crypto_rq_set_defaults(rq);
 }
@@ -333,7 +333,7 @@ EXPORT_SYMBOL(blk_rq_init);
 static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
 {
 	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
+		rq->start_time_ns = blk_time_get_ns();
 	else
 		rq->start_time_ns = 0;
 
@@ -444,7 +444,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_time_get_ns();
 
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
@@ -629,7 +629,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_time_get_ns();
 
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
@@ -1042,7 +1042,7 @@ static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	if (blk_mq_need_time_stamp(rq))
-		__blk_mq_end_request_acct(rq, ktime_get_ns());
+		__blk_mq_end_request_acct(rq, blk_time_get_ns());
 
 	blk_mq_finish_request(rq);
 
@@ -1085,7 +1085,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 	u64 now = 0;
 
 	if (iob->need_ts)
-		now = ktime_get_ns();
+		now = blk_time_get_ns();
 
 	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
 		prefetch(rq->bio);
@@ -1255,7 +1255,7 @@ void blk_mq_start_request(struct request *rq)
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags) &&
 	    !blk_rq_is_passthrough(rq)) {
-		rq->io_start_time_ns = ktime_get_ns();
+		rq->io_start_time_ns = blk_time_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
@@ -3107,7 +3107,7 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	blk_mq_run_dispatch_ops(q,
 			ret = blk_mq_request_issue_directly(rq, true));
 	if (ret)
-		blk_account_io_done(rq, ktime_get_ns());
+		blk_account_io_done(rq, blk_time_get_ns());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16f5766620a4..da9dc1f793c3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1815,7 +1815,7 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	time = min_t(unsigned long, MAX_IDLE_TIME, 4 * tg->idletime_threshold);
 	ret = tg->latency_target == DFL_LATENCY_TARGET ||
 	      tg->idletime_threshold == DFL_IDLE_THRESHOLD ||
-	      (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
+	      (blk_time_get_ns() >> 10) - tg->last_finish_time > time ||
 	      tg->avg_idletime > tg->idletime_threshold ||
 	      (tg->latency_target && tg->bio_cnt &&
 		tg->bad_bio_cnt * 5 < tg->bio_cnt);
@@ -2060,7 +2060,7 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
 	if (last_finish_time == 0)
 		return;
 
-	now = ktime_get_ns() >> 10;
+	now = blk_time_get_ns() >> 10;
 	if (now <= last_finish_time ||
 	    last_finish_time == tg->checked_last_finish_time)
 		return;
@@ -2327,7 +2327,7 @@ void blk_throtl_bio_endio(struct bio *bio)
 	if (!tg->td->limit_valid[LIMIT_LOW])
 		return;
 
-	finish_time_ns = ktime_get_ns();
+	finish_time_ns = blk_time_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
 
 	start_time = bio_issue_time(&bio->bi_issue) >> 10;
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 5ba3cd574eac..8cb53bf4c7b1 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -29,6 +29,7 @@
 #include "blk-wbt.h"
 #include "blk-rq-qos.h"
 #include "elevator.h"
+#include "blk.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/wbt.h>
@@ -274,13 +275,12 @@ static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 
 static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
 {
-	u64 now, issue = READ_ONCE(rwb->sync_issue);
+	u64 issue = READ_ONCE(rwb->sync_issue);
 
 	if (!issue || !rwb->sync_cookie)
 		return 0;
 
-	now = ktime_to_ns(ktime_get());
-	return now - issue;
+	return blk_time_get_ns() - issue;
 }
 
 static inline unsigned int wbt_inflight(struct rq_wb *rwb)
diff --git a/block/blk.h b/block/blk.h
index 620e3a035da1..79ae533cdf02 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
 
 #include <linux/blk-crypto.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
+#include <linux/timekeeping.h>
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
@@ -516,6 +517,16 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
+static inline u64 blk_time_get_ns(void)
+{
+	return ktime_get_ns();
+}
+
+static inline ktime_t blk_time_get(void)
+{
+	return ns_to_ktime(blk_time_get_ns());
+}
+
 /*
  * From most significant bit:
  * 1 bit: reserved for other usage, see below
@@ -554,7 +565,7 @@ static inline void bio_issue_init(struct bio_issue *issue,
 {
 	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
 	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
-			(ktime_get_ns() & BIO_ISSUE_TIME_MASK) |
+			(blk_time_get_ns() & BIO_ISSUE_TIME_MASK) |
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
 }
 
-- 
2.43.0


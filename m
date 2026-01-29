Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128537AA87
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671935; cv=none; b=rDak/Dysbl01T9urv4vi+WVBVN2P5dzC5k+lxq/Rq2Lh/kF+gGk5gYgcxchFislBbp3GpCYqtrbRQrXc27wRHWFQGQXuHCzRuYtztnSgfd/TdQg9pYUdzoJJmNEcNZdFeVAH63WLGRe14NDqYWBVbFHLNRIXVU9spTILRooR24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671935; c=relaxed/simple;
	bh=Rz112gLf2q6Y4A/3v8pvZ1zVE3+9CnBWB5V6K5R0K/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVK/dDHLcQ60Weg83edzRbAONc27BoGC1MCYDxRVZ6tC/26NAjvZ+zbQyoSU1kf4/PB6uDvhqOvRvfn5scuE7obbV1RKQjdD/kl7sd2JfJocvc9AdapoipzjnDIbpB03qNxbwgpy9BrfWldNzCeU82egTP2xN/mQjPnHhH1lrAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9KkqP0D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9KkqP0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B65C2BCB0;
	Thu, 29 Jan 2026 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769671935;
	bh=Rz112gLf2q6Y4A/3v8pvZ1zVE3+9CnBWB5V6K5R0K/I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=W9KkqP0D8U9C6TKZQFoBTt0K9hyv6Uvje4XjFFTBkluZZwpuxWeRlY2/PVLAlheYr
	 EWn617tJfWXwdTEkfkOb/PjjH4wQtZZbOtqWQKZH6e5Ma9m1jBKyt/UTvdn9EXdbIn
	 8TnmIrMyw/Bp3ncpXfYDUFvqEO6iq0S09pfRIjc5CkyxX/aMACpIduO90IGExVBy/e
	 aJcm5ZcE965NfvWKSG+L8vjrEnWCArm5g/FwZ2N6c9zfpe9az9w2s6J3qCHDTrDZD/
	 LqSYK807RVPJ8RMWonrBnohw39xAO/vedMb6JYU6gqlntWZp/wjwBsobg6Nmwjb/mb
	 Y7eK/fmiDa99Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: introduce blk_queue_rot()
Date: Thu, 29 Jan 2026 16:27:15 +0900
Message-ID: <20260129072715.1107336-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129072715.1107336-1-dlemoal@kernel.org>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To check if a request queue is for a rotational device, a double
negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
this with the introduction of the helper blk_queue_rot() which tests
if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
and blk_queue_nonrot() definition removed.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/bfq-iosched.c    | 20 ++++++++++----------
 block/blk-iocost.c     |  2 +-
 block/blk-iolatency.c  |  5 +----
 block/blk-wbt.c        |  5 ++---
 include/linux/blkdev.h |  4 ++--
 5 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6e54b1d3d8bc..3ebdec40e758 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -231,7 +231,7 @@ static struct kmem_cache *bfq_pool;
 #define BFQ_RQ_SEEKY(bfqd, last_pos, rq) \
 	(get_sdist(last_pos, rq) >			\
 	 BFQQ_SEEK_THR &&				\
-	 (!blk_queue_nonrot(bfqd->queue) ||		\
+	 (blk_queue_rot(bfqd->queue) ||			\
 	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
 #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
 #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
@@ -4165,7 +4165,7 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	/* don't use too short time intervals */
 	if (delta_usecs < 1000) {
-		if (blk_queue_nonrot(bfqd->queue))
+		if (!blk_queue_rot(bfqd->queue))
 			 /*
 			  * give same worst-case guarantees as idling
 			  * for seeky
@@ -4487,7 +4487,7 @@ static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq)
 {
 	bool rot_without_queueing =
-		!blk_queue_nonrot(bfqd->queue) && !bfqd->hw_tag,
+		blk_queue_rot(bfqd->queue) && !bfqd->hw_tag,
 		bfqq_sequential_and_IO_bound,
 		idling_boosts_thr;
 
@@ -4521,7 +4521,7 @@ static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 	 * flash-based device.
 	 */
 	idling_boosts_thr = rot_without_queueing ||
-		((!blk_queue_nonrot(bfqd->queue) || !bfqd->hw_tag) &&
+		((blk_queue_rot(bfqd->queue) || !bfqd->hw_tag) &&
 		 bfqq_sequential_and_IO_bound);
 
 	/*
@@ -4722,7 +4722,7 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 			 * there is only one in-flight large request
 			 * at a time.
 			 */
-			if (blk_queue_nonrot(bfqd->queue) &&
+			if (!blk_queue_rot(bfqd->queue) &&
 			    blk_rq_sectors(bfqq->next_rq) >=
 			    BFQQ_SECT_THR_NONROT &&
 			    bfqd->tot_rq_in_driver >= 1)
@@ -6340,7 +6340,7 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	bfqd->hw_tag_samples = 0;
 
 	bfqd->nonrot_with_queueing =
-		blk_queue_nonrot(bfqd->queue) && bfqd->hw_tag;
+		!blk_queue_rot(bfqd->queue) && bfqd->hw_tag;
 }
 
 static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
@@ -7293,7 +7293,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	INIT_HLIST_HEAD(&bfqd->burst_list);
 
 	bfqd->hw_tag = -1;
-	bfqd->nonrot_with_queueing = blk_queue_nonrot(bfqd->queue);
+	bfqd->nonrot_with_queueing = !blk_queue_rot(bfqd->queue);
 
 	bfqd->bfq_max_budget = bfq_default_max_budget;
 
@@ -7328,9 +7328,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	 * Begin by assuming, optimistically, that the device peak
 	 * rate is equal to 2/3 of the highest reference rate.
 	 */
-	bfqd->rate_dur_prod = ref_rate[blk_queue_nonrot(bfqd->queue)] *
-		ref_wr_duration[blk_queue_nonrot(bfqd->queue)];
-	bfqd->peak_rate = ref_rate[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
+	bfqd->rate_dur_prod = ref_rate[!blk_queue_rot(bfqd->queue)] *
+		ref_wr_duration[!blk_queue_rot(bfqd->queue)];
+	bfqd->peak_rate = ref_rate[!blk_queue_rot(bfqd->queue)] * 2 / 3;
 
 	/* see comments on the definition of next field inside bfq_data */
 	bfqd->actuator_load_threshold = 4;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a0416927d33d..ef543d163d46 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -812,7 +812,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 	u64 now_ns;
 
 	/* rotational? */
-	if (!blk_queue_nonrot(disk->queue))
+	if (blk_queue_rot(disk->queue))
 		return AUTOP_HDD;
 
 	/* handle SATA SSDs w/ broken NCQ */
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 45bd18f68541..f7434278cd29 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -988,10 +988,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	u64 now = blk_time_get_ns();
 	int cpu;
 
-	if (blk_queue_nonrot(blkg->q))
-		iolat->ssd = true;
-	else
-		iolat->ssd = false;
+	iolat->ssd = !blk_queue_rot(blkg->q);
 
 	for_each_possible_cpu(cpu) {
 		struct latency_stat *stat;
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 0974875f77bd..8e025834f2fb 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -747,10 +747,9 @@ u64 wbt_default_latency_nsec(struct request_queue *q)
 	 * We default to 2msec for non-rotational storage, and 75msec
 	 * for rotational storage.
 	 */
-	if (blk_queue_nonrot(q))
-		return 2000000ULL;
-	else
+	if (blk_queue_rot(q))
 		return 75000000ULL;
+	return 2000000ULL;
 }
 
 static int wbt_data_dir(const struct request *rq)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4536211ff33c..1e5b5547929f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -680,7 +680,7 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
-#define blk_queue_nonrot(q)	(!((q)->limits.features & BLK_FEAT_ROTATIONAL))
+#define blk_queue_rot(q)	((q)->limits.features & BLK_FEAT_ROTATIONAL)
 #define blk_queue_io_stat(q)	((q)->limits.features & BLK_FEAT_IO_STAT)
 #define blk_queue_passthrough_stat(q)	\
 	((q)->limits.flags & BLK_FLAG_IOSTATS_PASSTHROUGH)
@@ -1463,7 +1463,7 @@ bdev_write_zeroes_unmap_sectors(struct block_device *bdev)
 
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
-	return blk_queue_nonrot(bdev_get_queue(bdev));
+	return !blk_queue_rot(bdev_get_queue(bdev));
 }
 
 static inline bool bdev_synchronous(struct block_device *bdev)
-- 
2.52.0


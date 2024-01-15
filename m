Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BB1B594
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ihQ7fNfE"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9ab48faeaso1561575b3a.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 13:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705355926; x=1705960726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezqkoV5us3ZBNOFXWJJPiL+uJVYKmj8Ie3laNetbR74=;
        b=ihQ7fNfEN6OQoi34KWQyGppWwt/DLEuGDCqo1O9Wr+AZj16rfbsMaOWbtk7Iv//hee
         3v/JsoEpZwgknAXvt5AISQ43VdHzzyWsyaWFU3SKyEHKWImV7nYPZH+u4ryAfezWGDiS
         er1IMbfZ1PZEQG+aSiQNGXHvNyS1uiYHI/E/PvLY+2Aq3jfzpMJtv0mdnNS7E6g0CHhs
         cubPwiAGvka1CZJkARUfdUDd40zTxx3LJ4tjrz4ncqx9P9EY+pTD4Cg15we45s42Ff39
         uvMxTrGXiGiQcamoDNlkeRbzk8TETufSQkmO98eh3J1DgQa5b1LDEcz7mRskgnb9FiZj
         W7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355926; x=1705960726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezqkoV5us3ZBNOFXWJJPiL+uJVYKmj8Ie3laNetbR74=;
        b=oiyDHKDh+Kv7DXZh+bTOe+RULY+ZHbrtSUYmtjCs8D1+IG3ETUo87wSqYFgw0yjQ1j
         Ki0UQHgMTqjx4qUTz5Mq5pGHZLLbFZ0ZdUiths+RJa7ptRYXQSCu89rpPHPErVtZEn4Z
         YZIzdFUzkxhcs85iypIenv+7kPXYFDd68+ojSpmZwjdzPKp2hxnkWYhCdQ+f3nwK9zQn
         Z/ZS4Rt3HfF2O7xnHdm99oeThxmVIxSBmaFzYVZPGKex9PjNi4guTw+cyq/k5rRA0rF2
         NhAIEHNgCX7p18fRnN70nbO3xUsDWC71qe34lDmmVhK7HaUCvepjK7jqWzIDZjwi2bTP
         1Y4g==
X-Gm-Message-State: AOJu0YznTyjp82T8LsGChE35+Cjbs7piXzPma20n9Ex1ivFhwiwbkkyJ
	t6MMRgD0+V5uDeIwNc2a2QzyPcD3u/XL/ibiVqW7A6zEXXN7Uw==
X-Google-Smtp-Source: AGHT+IHD8Kc02zauk6QgUYVnhgGzzJJm/ExEyTwfj4LSVp+skuyr2+qu2Cp8qtdlbpUYAYJksGuAxg==
X-Received: by 2002:a05:6a00:450f:b0:6cd:dfff:19b6 with SMTP id cw15-20020a056a00450f00b006cddfff19b6mr13078834pfb.2.1705355925883;
        Mon, 15 Jan 2024 13:58:45 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o6-20020a056a001b4600b006d98505dacasm8072764pfv.132.2024.01.15.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:58:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: add blk_time_get_ns() helper
Date: Mon, 15 Jan 2024 14:53:54 -0700
Message-ID: <20240115215840.54432-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115215840.54432-1-axboe@kernel.dk>
References: <20240115215840.54432-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes intended, this patch just wraps ktime_get_ns()
with a block helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c     |  2 +-
 block/blk-flush.c      |  2 +-
 block/blk-iocost.c     |  6 +++---
 block/blk-mq.c         | 16 ++++++++--------
 block/blk-throttle.c   |  6 +++---
 block/blk-wbt.c        |  5 ++---
 include/linux/blkdev.h |  5 +++++
 7 files changed, 23 insertions(+), 19 deletions(-)

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
index c8beec6d7df0..e54b17261d96 100644
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
index 5ba3cd574eac..d5dcf44ef0de 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -274,13 +274,12 @@ static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 
 static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
 {
-	u64 now, issue = READ_ONCE(rwb->sync_issue);
+	u64 issue = READ_ONCE(rwb->sync_issue);
 
 	if (!issue || !rwb->sync_cookie)
 		return 0;
 
-	now = ktime_to_ns(ktime_get());
-	return now - issue;
+	return blk_time_to_ns() - issue;
 }
 
 static inline unsigned int wbt_inflight(struct rq_wb *rwb)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e72213..2f9ceea0e23b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -974,6 +974,11 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
+
+static inline u64 blk_time_get_ns(void)
+{
+	return ktime_get_ns();
+}
 #else /* CONFIG_BLOCK */
 struct blk_plug {
 };
-- 
2.43.0


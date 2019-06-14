Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE6C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921D921473
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRwCL1U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfFNLsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:48:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54616 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfFNLsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 07:48:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so2022626wme.4;
        Fri, 14 Jun 2019 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmqqlh+Ng4Lx0b4f9QJyb+8pjE4L9tOXqPgB/iHHAno=;
        b=lRwCL1U0/2tKSPUyrqnO/aX3p+94C0LAliylKjwDHSBjqW14VvDxBTvsttLdWIhpK8
         2CaWvpGpG/6wT9pUs+p1yZPAQw61jf820ENK9rghbBK4zr7o4iN/YvPATdRSGZg6ps/8
         PVdzDeTMbmB6uTOlLn/4GFf6XLMiOhWVK7fFOSbRDq4OenlHaJmUR5QtiWplSMZCSwW7
         v+3ljkq2jr0LrIPH+sz+V4+onvD+fmBQoLXt3uZfBjW93fAF4BbaYceH9SJwr0luf1HR
         bA28eqnKONvS2Q0frUTQuj+6w+6i7fi6VeHOT+msfelZZ7WYBFy5E1vaFaA4TaL9ryXa
         VuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmqqlh+Ng4Lx0b4f9QJyb+8pjE4L9tOXqPgB/iHHAno=;
        b=cUnzJmaYjt/v3FKjjNmFSft+9i+yhj9mfT8w5tAH9Hgt1luc8YbZ7APcvcvGsQg23+
         4Ew8BvzuVuUxI1DEXJrMsUy+0BDOGqm+qcv71SnC5Ci/5KyTVL+EGjpygdZj1sivjcDo
         Vc92C19d5VZ/BS+mMA0hANx9h848aFvXW9Il12WmdnXRIC9cjtoht+Qcgf/MB5rn2k39
         jf1Vza0FdXetF72L0s8ko24065xQOIXeo6CZzxVfR2A8XHXPMBGVF8fXFZzX1cw2Nv0E
         oytY3MiMrT2FZHT7BXJkvBa+/1RWgMglrGIEZ/SD4EsKapqCwY4+xjR4zLzbJ+yzNt2u
         8Jkg==
X-Gm-Message-State: APjAAAU7cjf0P0W/TdmPPhnu9zJc6JI/j270dZAT+JpAuffaHPFx1DI9
        QlvuScs4DvQfNOdV35LuecIoK8U1eA2rCQ==
X-Google-Smtp-Source: APXvYqyVJWnTCPj5kEWvI9Fp1k0zCHiaiA2uzpzB6kRFHnxKmPddcp7076qglnbRV/90vGHEZew9dQ==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr7385321wmz.165.1560512895691;
        Fri, 14 Jun 2019 04:48:15 -0700 (PDT)
Received: from localhost.localdomain ([185.107.117.129])
        by smtp.gmail.com with ESMTPSA id v204sm4510656wma.20.2019.06.14.04.48.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 04:48:15 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        dennis@kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/2] blk-stats: Introduce explicit stat staging buffers
Date:   Fri, 14 Jun 2019 14:47:48 +0300
Message-Id: <bf0b7c79f2cb55c338e7112543706b65c5c497a4.1560510935.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560510935.git.asml.silence@gmail.com>
References: <cover.1560510935.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Split struct blk_rq_stat into 2 structs, so each would explicitely
represent one of the mentioned states. That duplicates code, but
1. prevents misuses (compile-time check by type-system)
2. reduces memory needed (inc. per-cpu)
3. makes it easier to extend stats

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-iolatency.c     | 41 +++++++++++++++++++++++++++++----------
 block/blk-stat.c          | 30 +++++++++++++++++-----------
 block/blk-stat.h          |  8 +++++---
 include/linux/blk_types.h |  6 ++++++
 4 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index fc8ce1a0ae21..fbf986a0b8c2 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -130,9 +130,16 @@ struct latency_stat {
 	};
 };
 
+struct latency_stat_staging {
+	union {
+		struct percentile_stats ps;
+		struct blk_rq_stat_staging rqs;
+	};
+};
+
 struct iolatency_grp {
 	struct blkg_policy_data pd;
-	struct latency_stat __percpu *stats;
+	struct latency_stat_staging __percpu *stats;
 	struct latency_stat cur_stat;
 	struct blk_iolatency *blkiolat;
 	struct rq_depth rq_depth;
@@ -199,6 +206,16 @@ static inline void latency_stat_init(struct iolatency_grp *iolat,
 		blk_rq_stat_init(&stat->rqs);
 }
 
+static inline void latency_stat_init_staging(struct iolatency_grp *iolat,
+					     struct latency_stat_staging *stat)
+{
+	if (iolat->ssd) {
+		stat->ps.total = 0;
+		stat->ps.missed = 0;
+	} else
+		blk_rq_stat_init_staging(&stat->rqs);
+}
+
 static inline void latency_stat_merge(struct iolatency_grp *iolat,
 				    struct latency_stat *sum,
 				    struct latency_stat *stat)
@@ -212,7 +229,7 @@ static inline void latency_stat_merge(struct iolatency_grp *iolat,
 
 static inline void latency_stat_collect(struct iolatency_grp *iolat,
 					struct latency_stat *sum,
-					struct latency_stat *stat)
+					struct latency_stat_staging *stat)
 {
 	if (iolat->ssd) {
 		sum->ps.total += stat->ps.total;
@@ -224,7 +241,8 @@ static inline void latency_stat_collect(struct iolatency_grp *iolat,
 static inline void latency_stat_record_time(struct iolatency_grp *iolat,
 					    u64 req_time)
 {
-	struct latency_stat *stat = get_cpu_ptr(iolat->stats);
+	struct latency_stat_staging *stat = get_cpu_ptr(iolat->stats);
+
 	if (iolat->ssd) {
 		if (req_time >= iolat->min_lat_nsec)
 			stat->ps.missed++;
@@ -540,10 +558,11 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	latency_stat_init(iolat, &stat);
 	preempt_disable();
 	for_each_online_cpu(cpu) {
-		struct latency_stat *s;
+		struct latency_stat_staging *s;
+
 		s = per_cpu_ptr(iolat->stats, cpu);
 		latency_stat_collect(iolat, &stat, s);
-		latency_stat_init(iolat, s);
+		latency_stat_init_staging(iolat, s);
 	}
 	preempt_enable();
 
@@ -922,7 +941,8 @@ static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
 	latency_stat_init(iolat, &stat);
 	preempt_disable();
 	for_each_online_cpu(cpu) {
-		struct latency_stat *s;
+		struct latency_stat_staging *s;
+
 		s = per_cpu_ptr(iolat->stats, cpu);
 		latency_stat_collect(iolat, &stat, s);
 	}
@@ -966,8 +986,8 @@ static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp, int node)
 	iolat = kzalloc_node(sizeof(*iolat), gfp, node);
 	if (!iolat)
 		return NULL;
-	iolat->stats = __alloc_percpu_gfp(sizeof(struct latency_stat),
-				       __alignof__(struct latency_stat), gfp);
+	iolat->stats = __alloc_percpu_gfp(sizeof(struct latency_stat_staging),
+				__alignof__(struct latency_stat_staging), gfp);
 	if (!iolat->stats) {
 		kfree(iolat);
 		return NULL;
@@ -990,9 +1010,10 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 		iolat->ssd = false;
 
 	for_each_possible_cpu(cpu) {
-		struct latency_stat *stat;
+		struct latency_stat_staging *stat;
+
 		stat = per_cpu_ptr(iolat->stats, cpu);
-		latency_stat_init(iolat, stat);
+		latency_stat_init_staging(iolat, stat);
 	}
 
 	latency_stat_init(iolat, &iolat->cur_stat);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 78389182b5d0..d892ad2cb938 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -18,15 +18,22 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
+void blk_rq_stat_init_staging(struct blk_rq_stat_staging *stat)
+{
+	stat->min = -1ULL;
+	stat->max = 0;
+	stat->batch = 0;
+	stat->nr_samples = 0;
+}
+
 void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->batch = 0;
 }
 
-/* src is a per-cpu stat, mean isn't initialized */
-void blk_rq_stat_collect(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+void blk_rq_stat_collect(struct blk_rq_stat *dst,
+			 struct blk_rq_stat_staging *src)
 {
 	if (!src->nr_samples)
 		return;
@@ -55,7 +62,7 @@ void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
+void blk_rq_stat_add(struct blk_rq_stat_staging *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
 	stat->max = max(stat->max, value);
@@ -67,7 +74,7 @@ void blk_stat_add(struct request *rq, u64 now)
 {
 	struct request_queue *q = rq->q;
 	struct blk_stat_callback *cb;
-	struct blk_rq_stat *stat;
+	struct blk_rq_stat_staging *stat;
 	int bucket;
 	u64 value;
 
@@ -101,13 +108,13 @@ static void blk_stat_timer_fn(struct timer_list *t)
 		blk_rq_stat_init(&cb->stat[bucket]);
 
 	for_each_online_cpu(cpu) {
-		struct blk_rq_stat *cpu_stat;
+		struct blk_rq_stat_staging *cpu_stat;
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++) {
 			blk_rq_stat_collect(&cb->stat[bucket],
 					    &cpu_stat[bucket]);
-			blk_rq_stat_init(&cpu_stat[bucket]);
+			blk_rq_stat_init_staging(&cpu_stat[bucket]);
 		}
 	}
 
@@ -131,8 +138,9 @@ blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
 		kfree(cb);
 		return NULL;
 	}
-	cb->cpu_stat = __alloc_percpu(buckets * sizeof(struct blk_rq_stat),
-				      __alignof__(struct blk_rq_stat));
+	cb->cpu_stat = __alloc_percpu(
+				buckets * sizeof(struct blk_rq_stat_staging),
+				__alignof__(struct blk_rq_stat_staging));
 	if (!cb->cpu_stat) {
 		kfree(cb->stat);
 		kfree(cb);
@@ -155,11 +163,11 @@ void blk_stat_add_callback(struct request_queue *q,
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		struct blk_rq_stat *cpu_stat;
+		struct blk_rq_stat_staging *cpu_stat;
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++)
-			blk_rq_stat_init(&cpu_stat[bucket]);
+			blk_rq_stat_init_staging(&cpu_stat[bucket]);
 	}
 
 	spin_lock(&q->stats->lock);
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 5597ecc34ef5..e5c753fbd6e6 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -30,7 +30,7 @@ struct blk_stat_callback {
 	/**
 	 * @cpu_stat: Per-cpu statistics buckets.
 	 */
-	struct blk_rq_stat __percpu *cpu_stat;
+	struct blk_rq_stat_staging __percpu *cpu_stat;
 
 	/**
 	 * @bucket_fn: Given a request, returns which statistics bucket it
@@ -164,9 +164,11 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *, u64);
-void blk_rq_stat_collect(struct blk_rq_stat *dst, struct blk_rq_stat *src);
+void blk_rq_stat_add(struct blk_rq_stat_staging *stat, u64);
+void blk_rq_stat_collect(struct blk_rq_stat *dst,
+			 struct blk_rq_stat_staging *src);
 void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src);
 void blk_rq_stat_init(struct blk_rq_stat *);
+void blk_rq_stat_init_staging(struct blk_rq_stat_staging *stat);
 
 #endif
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index be418275763c..2db5a5fd318f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -449,7 +449,13 @@ struct blk_rq_stat {
 	u64 min;
 	u64 max;
 	u32 nr_samples;
+};
+
+struct blk_rq_stat_staging {
+	u64 min;
+	u64 max;
 	u64 batch;
+	u32 nr_samples;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.22.0


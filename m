Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB1EC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AB921670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr3JRRzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfD3HfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37900 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfD3HfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id e18so5901599lja.5;
        Tue, 30 Apr 2019 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruXerJK2lhLfErL9M//JhKigc+Dy/ckGxlO5z13UynM=;
        b=Mr3JRRzHKfelKtj8fAoavSGgBRd76y/y3JQBCRUmTCafh5CePCG/3FRLFgY4lgaCza
         FRVzFlB0K+G9QHeXVTblcHA2g7zT47p4rOIPG8ZLphAdobVESZ+iI/2WnqLt4RmRjndg
         MQhmvVXLiIKNwGuGbGBmoVbXU7c66qYNlc5hwB3jYps9kEYzHzqT5jGd2Uouhe+Ovr7J
         dMJWH2rcQOxhiU706dWq570JDYIA8pTL5nPL+mo8DFqys9sTfYK1N4/5zB2jobiwrCZF
         cLroWrmzLoe2fqJDXtsRcHhHpS2FU2zl12XdynU4QNJgYNvsFwpqETViCtzFi1yty/9I
         Xb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruXerJK2lhLfErL9M//JhKigc+Dy/ckGxlO5z13UynM=;
        b=U2m7oS0RcW4Dv7uh323xOX01r7m86R9rnvbE+puGgcgGutYg3DGfXsYRAyAL00/3Lx
         oAJlcAC3jdUwuY2U5M6ZFZ0/zc9TRG7VmPCpF3aFiiKolRngcBAEi01G96mCa3Z81zi2
         MNCvZj1jvktT3ohBFeTRowZvb7f5K1L5rFOGqaMjDjw3xlVOclR5HhcJ7EpCO69ZLjU9
         Ra1KcWbqq8v9x5xcdL+vUkMjyEpcfpXZATxRjT7mhTksB1vlzvTy5jRUY36wtYU7I+gY
         Wv1izvUORqFfgB1N9NroqsIok+MIHwLYlwm4TyJ5rZY/7oiLY9S2xupIqhHQLQCkXtNo
         1Ldw==
X-Gm-Message-State: APjAAAWObh/CS3DeYM/XlGUkYVR/OsYQtqmWooFCznCwxb/7yLwdOAcf
        Wtl4Sk8AKrCq8b5hAkxvx7DwQlg2
X-Google-Smtp-Source: APXvYqxPA9tkDZl7eYGKLwLIMT4rxKqxM9LJESFUlBnOdLRTO8hblIZcC2jLpQO9F8erxexgRiKTjQ==
X-Received: by 2002:a2e:96cf:: with SMTP id d15mr16247037ljj.66.1556609697396;
        Tue, 30 Apr 2019 00:34:57 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:34:56 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/7] blk-stats: Introduce explicit stat staging buffers
Date:   Tue, 30 Apr 2019 10:34:14 +0300
Message-Id: <702524f38b2705c98e16ada0db9cc6f7eff40fc2.1556609582.git.asml.silence@gmail.com>
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

struct blk_rq_stat could be in one of two implicit states, which use
different set of fields:
1. per-cpu intermediate (i.e. staging) (keep batch, invalid mean)
2. calculated stats (see blk_rq_stat_collect) (w/o batch, w/ mean)

blk_rq_stat_*() expect their arguments to be in the right state, and it
is not documented in which. That's error prone.

Split blk_rq_stat into 2 structs corresponding to one of the states.
That requires some code duplication, but
1. prevents misuses (compile-time type-system check)
2. reduces memory needed
3. makes it easier to extend stats

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-iolatency.c     | 41 +++++++++++++++++++++++++++++----------
 block/blk-stat.c          | 30 +++++++++++++++++-----------
 block/blk-stat.h          |  8 +++++---
 include/linux/blk_types.h |  6 ++++++
 4 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 4010152ebeb2..df9d37398a0f 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -129,9 +129,16 @@ struct latency_stat {
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
@@ -198,6 +205,16 @@ static inline void latency_stat_init(struct iolatency_grp *iolat,
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
@@ -211,7 +228,7 @@ static inline void latency_stat_merge(struct iolatency_grp *iolat,
 
 static inline void latency_stat_collect(struct iolatency_grp *iolat,
 					struct latency_stat *sum,
-					struct latency_stat *stat)
+					struct latency_stat_staging *stat)
 {
 	if (iolat->ssd) {
 		sum->ps.total += stat->ps.total;
@@ -223,7 +240,8 @@ static inline void latency_stat_collect(struct iolatency_grp *iolat,
 static inline void latency_stat_record_time(struct iolatency_grp *iolat,
 					    u64 req_time)
 {
-	struct latency_stat *stat = get_cpu_ptr(iolat->stats);
+	struct latency_stat_staging *stat = get_cpu_ptr(iolat->stats);
+
 	if (iolat->ssd) {
 		if (req_time >= iolat->min_lat_nsec)
 			stat->ps.missed++;
@@ -539,10 +557,11 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
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
 
@@ -921,7 +940,8 @@ static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
 	latency_stat_init(iolat, &stat);
 	preempt_disable();
 	for_each_online_cpu(cpu) {
-		struct latency_stat *s;
+		struct latency_stat_staging *s;
+
 		s = per_cpu_ptr(iolat->stats, cpu);
 		latency_stat_collect(iolat, &stat, s);
 	}
@@ -965,8 +985,8 @@ static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp, int node)
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
@@ -989,9 +1009,10 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
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
index a6da68af45db..13f93249fd5f 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -17,15 +17,22 @@ struct blk_queue_stats {
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
@@ -54,7 +61,7 @@ void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
+void blk_rq_stat_add(struct blk_rq_stat_staging *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
 	stat->max = max(stat->max, value);
@@ -66,7 +73,7 @@ void blk_stat_add(struct request *rq, u64 now)
 {
 	struct request_queue *q = rq->q;
 	struct blk_stat_callback *cb;
-	struct blk_rq_stat *stat;
+	struct blk_rq_stat_staging *stat;
 	int bucket;
 	u64 value;
 
@@ -100,13 +107,13 @@ static void blk_stat_timer_fn(struct timer_list *t)
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
 
@@ -130,8 +137,9 @@ blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
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
@@ -154,11 +162,11 @@ void blk_stat_add_callback(struct request_queue *q,
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
index 791fee35df88..5718a4e2e731 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -446,7 +446,13 @@ struct blk_rq_stat {
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
2.21.0


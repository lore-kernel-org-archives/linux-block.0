Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C2C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE02080C
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWNLw/Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfD3He7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:34:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33263 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3He6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:34:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so10076026lfm.0;
        Tue, 30 Apr 2019 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvAqw7tCZYei3xD/pwkIEpXrRiHrC/rYQbdBE+/n0iM=;
        b=pWNLw/KiQu+15z6cjskRAADRy26wd9hNr8NMve2g/524ip+o0+UD1vzVEA7pcBgFVS
         QopHfj5VHNqBZgg5NSqWYoX4CVVzpzMcTpD5FIFLc38MXLwNwpnxdbo/U8aUE0aNQbIp
         pLgYVpLbWex5VuLb0bxovHwLFjK5aXIbMFLzCDU2AIsPqccQkhbLrv9568dnaJfNx2Mb
         rm4rLcQ8pIFK+7NMOYlVKcWW7XgDeIRSWHac0zr5pc92URAJ3SCct24/teRE7j4Lyo0h
         tIMNJLdCRvebkmrw2tipXmVDkVsK6lUsqbjtAbSWbtzMcGETS5LRdcTTwtMxhSaWK+dW
         xghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvAqw7tCZYei3xD/pwkIEpXrRiHrC/rYQbdBE+/n0iM=;
        b=jdoOu2OZveJmoJEFu83uo6xanpRk31x3in/27gCY6Zea70XKeoxdCO+JB7MXpUmJHG
         llL4cLDKMWZ8lSYEuIe7nSFf0RFqozXPZmGQqL6f5DQ+gk2U06rBdioQEO4LtNLR/efr
         jxvCtE3uL7iL6zO5dhPwhpxNbrnmlrhSGfq7pYmRXq/3XFYaaLawrg+qYiS5tpnat3oN
         w6ZehcD0rFqpK/qsPOxquldclKQcqNy2KaL+VZhEe9ekploi7H2Ea6mxkLG6MDrCljmC
         KgJZt0z/fJYsEOVxqYsO1cK4eq37CotYeAWIIKjM+3SeEy6aCKLA6wYJs5RZu6F9FJXk
         aFJA==
X-Gm-Message-State: APjAAAXh0qdTTJyQh2YAfQ2Oswf+ZqqYKupLK7cBmRQGeru8OYcTO74M
        /k4gmuOGHsN2hoX9/c3jxWU=
X-Google-Smtp-Source: APXvYqwPSGPUKOjRpnOthFlA3apSAuoe7lRIrzeGAcYid8k9fBo0NDmZiw+Ic6fdPk2O7wNaqe5FGA==
X-Received: by 2002:ac2:485a:: with SMTP id 26mr34567832lfy.23.1556609695248;
        Tue, 30 Apr 2019 00:34:55 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:34:54 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/7] blk-iolatency: Fix zero mean in previous stats
Date:   Tue, 30 Apr 2019 10:34:13 +0300
Message-Id: <897b1aaf6749a707b2190e138d2bf7ba22920082.1556609582.git.asml.silence@gmail.com>
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

blk_rq_stat_sum() expects src argument (struct blk_rq_stat) to have
valid batch field and won't calculate it for dst. Thus, former dst
shouldn't be used as an src arg. iolatency_check_latencies() violates
that, making iolat->cur_stat.rqs.mean always to be 0 for non-ssd
devices.

Use 2 distinct functions instead: one to collect intermediate stats
(i.e. with valid batch), and the second one for merging already
accumulated stats (i.e. with valid mean).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-iolatency.c | 21 ++++++++++++++++-----
 block/blk-stat.c      | 20 ++++++++++++++++++--
 block/blk-stat.h      |  3 ++-
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 507212d75ee2..4010152ebeb2 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -198,7 +198,7 @@ static inline void latency_stat_init(struct iolatency_grp *iolat,
 		blk_rq_stat_init(&stat->rqs);
 }
 
-static inline void latency_stat_sum(struct iolatency_grp *iolat,
+static inline void latency_stat_merge(struct iolatency_grp *iolat,
 				    struct latency_stat *sum,
 				    struct latency_stat *stat)
 {
@@ -206,7 +206,18 @@ static inline void latency_stat_sum(struct iolatency_grp *iolat,
 		sum->ps.total += stat->ps.total;
 		sum->ps.missed += stat->ps.missed;
 	} else
-		blk_rq_stat_sum(&sum->rqs, &stat->rqs);
+		blk_rq_stat_merge(&sum->rqs, &stat->rqs);
+}
+
+static inline void latency_stat_collect(struct iolatency_grp *iolat,
+					struct latency_stat *sum,
+					struct latency_stat *stat)
+{
+	if (iolat->ssd) {
+		sum->ps.total += stat->ps.total;
+		sum->ps.missed += stat->ps.missed;
+	} else
+		blk_rq_stat_collect(&sum->rqs, &stat->rqs);
 }
 
 static inline void latency_stat_record_time(struct iolatency_grp *iolat,
@@ -530,7 +541,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	for_each_online_cpu(cpu) {
 		struct latency_stat *s;
 		s = per_cpu_ptr(iolat->stats, cpu);
-		latency_stat_sum(iolat, &stat, s);
+		latency_stat_collect(iolat, &stat, s);
 		latency_stat_init(iolat, s);
 	}
 	preempt_enable();
@@ -551,7 +562,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	/* Somebody beat us to the punch, just bail. */
 	spin_lock_irqsave(&lat_info->lock, flags);
 
-	latency_stat_sum(iolat, &iolat->cur_stat, &stat);
+	latency_stat_merge(iolat, &iolat->cur_stat, &stat);
 	lat_info->nr_samples -= iolat->nr_samples;
 	lat_info->nr_samples += latency_stat_samples(iolat, &iolat->cur_stat);
 	iolat->nr_samples = latency_stat_samples(iolat, &iolat->cur_stat);
@@ -912,7 +923,7 @@ static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
 	for_each_online_cpu(cpu) {
 		struct latency_stat *s;
 		s = per_cpu_ptr(iolat->stats, cpu);
-		latency_stat_sum(iolat, &stat, s);
+		latency_stat_collect(iolat, &stat, s);
 	}
 	preempt_enable();
 
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 696a04176e4d..a6da68af45db 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -25,7 +25,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
-void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+void blk_rq_stat_collect(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
 	if (!src->nr_samples)
 		return;
@@ -39,6 +39,21 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
+void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+{
+	if (!src->nr_samples)
+		return;
+
+	dst->min = min(dst->min, src->min);
+	dst->max = max(dst->max, src->max);
+
+	dst->mean = div_u64(src->mean * src->nr_samples +
+				dst->mean * dst->nr_samples,
+				dst->nr_samples + src->nr_samples);
+
+	dst->nr_samples += src->nr_samples;
+}
+
 void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 {
 	stat->min = min(stat->min, value);
@@ -89,7 +104,8 @@ static void blk_stat_timer_fn(struct timer_list *t)
 
 		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
 		for (bucket = 0; bucket < cb->buckets; bucket++) {
-			blk_rq_stat_sum(&cb->stat[bucket], &cpu_stat[bucket]);
+			blk_rq_stat_collect(&cb->stat[bucket],
+					    &cpu_stat[bucket]);
 			blk_rq_stat_init(&cpu_stat[bucket]);
 		}
 	}
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..5597ecc34ef5 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -165,7 +165,8 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 }
 
 void blk_rq_stat_add(struct blk_rq_stat *, u64);
-void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
+void blk_rq_stat_collect(struct blk_rq_stat *dst, struct blk_rq_stat *src);
+void blk_rq_stat_merge(struct blk_rq_stat *dst, struct blk_rq_stat *src);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
 #endif
-- 
2.21.0


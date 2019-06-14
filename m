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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FAAC31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D6C20850
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 11:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVyisGSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFNLsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:48:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfFNLsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 07:48:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so2174848wrl.11;
        Fri, 14 Jun 2019 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4tIopvAHkt6FY4+Y6Lo4ek2c4j4aI85q+AB/SfNRnc=;
        b=DVyisGSBG2m+9zrPQhqsUkYWGDipMPTHn1EfS26qfu1mMNutLtJ2OWxKpLkk/Ye78t
         YkAcOouXoIvD4IU6Lprl3qJCUNX2P0taFX+2nxBgbZfnhD1ISxJnHjB9m7u2pkEF4mBE
         CpET/xi5ANV4lGoBoq8iImWtRoZtcCx8y6kjBaWi6yz/A59W7WMuJl+NgLZOulA8uAUP
         34o611fW6BIILrRU9Hy+s1mM8lRa1IKnIp15TR+A/X9p5OPPgTmwsvGWReYj0nUb8aI8
         g3JBqw/WMgpGgejTS+m2ftT2Y7auFttOKL+3Hln9Lqj1DX4CSBMyMtJrBZCPqzKa5gLq
         sSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4tIopvAHkt6FY4+Y6Lo4ek2c4j4aI85q+AB/SfNRnc=;
        b=ah8vqAlwFRywI93RPL/thtXbg291VGmmmKmB8hLd9QWY+P2RAEYLIbdML12k6jMgPL
         slU7z5b6Mu0mX9R6aAG0Nl0oFzieLi62ZHdzUuqCn7c3KnVT3cikNUZIge47haLbBarY
         P02OpwJ8b+lEMK1dkAWPigidp8cmBeXiF3te0/9n3YiQpwkLdmhRuUwKAe3RCOdTbXQO
         AoyvYH3dlgUdHFinaPtsguVGZnbHkvJH7iORR3qRHOGzYawcOmCEXu7U8kRAfldDZblt
         s4vhsezRsBgz4a5HCWVvkjTBGAOhq0WVfI9CaD9feU0iGGsBwxN4O1UMe/M1cFfMzuon
         FXZQ==
X-Gm-Message-State: APjAAAVVrABUudBGYZuKNN0xncN1VQJwpil1kJSAlsi4zXNHfemuAvwQ
        BCkyuZHQ3kAxOqPv/b5NqOs=
X-Google-Smtp-Source: APXvYqxxqojJV8VCHEgQh6txCIzR8R3q/AhKY/2zuP+BoLVYRRZ41EA+FVWavmZYJ8pcMbj72EHC2Q==
X-Received: by 2002:adf:c5c1:: with SMTP id v1mr46156893wrg.129.1560512894084;
        Fri, 14 Jun 2019 04:48:14 -0700 (PDT)
Received: from localhost.localdomain ([185.107.117.129])
        by smtp.gmail.com with ESMTPSA id v204sm4510656wma.20.2019.06.14.04.48.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 04:48:13 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        dennis@kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/2] blk-iolatency: Fix zero mean in previous stats
Date:   Fri, 14 Jun 2019 14:47:47 +0300
Message-Id: <0b930bf6ebcc309748419877eb34fe50cb747299.1560510935.git.asml.silence@gmail.com>
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

struct blk_rq_stat has two implicit states in which it can be:
(1) per-cpu intermediate stats (i.e. staging, intermediate)
(2) final stats / aggregation of (1) (see blk_rq_stat_collect)

The states use different sets of fields. E.g. (1) uses @batch but not
@mean, and vise versa for (2). So, any function that uses
struct blk_rq_stat has implicit assumptions about the states.

blk_rq_stat_sum() expects @src to be in (1) and @dst in (2).
iolatency_check_latencies() violates that (passing struct blk_rq_stat,
previously used as @dst, as @src). As a result, iolat->cur_stat.rqs.mean
is always 0 for non-ssd devices.

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
index d22e61bced86..fc8ce1a0ae21 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -199,7 +199,7 @@ static inline void latency_stat_init(struct iolatency_grp *iolat,
 		blk_rq_stat_init(&stat->rqs);
 }
 
-static inline void latency_stat_sum(struct iolatency_grp *iolat,
+static inline void latency_stat_merge(struct iolatency_grp *iolat,
 				    struct latency_stat *sum,
 				    struct latency_stat *stat)
 {
@@ -207,7 +207,18 @@ static inline void latency_stat_sum(struct iolatency_grp *iolat,
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
@@ -531,7 +542,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	for_each_online_cpu(cpu) {
 		struct latency_stat *s;
 		s = per_cpu_ptr(iolat->stats, cpu);
-		latency_stat_sum(iolat, &stat, s);
+		latency_stat_collect(iolat, &stat, s);
 		latency_stat_init(iolat, s);
 	}
 	preempt_enable();
@@ -552,7 +563,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	/* Somebody beat us to the punch, just bail. */
 	spin_lock_irqsave(&lat_info->lock, flags);
 
-	latency_stat_sum(iolat, &iolat->cur_stat, &stat);
+	latency_stat_merge(iolat, &iolat->cur_stat, &stat);
 	lat_info->nr_samples -= iolat->nr_samples;
 	lat_info->nr_samples += latency_stat_samples(iolat, &iolat->cur_stat);
 	iolat->nr_samples = latency_stat_samples(iolat, &iolat->cur_stat);
@@ -913,7 +924,7 @@ static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
 	for_each_online_cpu(cpu) {
 		struct latency_stat *s;
 		s = per_cpu_ptr(iolat->stats, cpu);
-		latency_stat_sum(iolat, &stat, s);
+		latency_stat_collect(iolat, &stat, s);
 	}
 	preempt_enable();
 
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 940f15d600f8..78389182b5d0 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -26,7 +26,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
-void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+void blk_rq_stat_collect(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
 	if (!src->nr_samples)
 		return;
@@ -40,6 +40,21 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
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
@@ -90,7 +105,8 @@ static void blk_stat_timer_fn(struct timer_list *t)
 
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
2.22.0


Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C8C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742B9206A5
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCqTFv2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405570AbfIFOmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:42:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43464 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403803AbfIFOmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 10:42:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id q27so5240384lfo.10;
        Fri, 06 Sep 2019 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dt8uSL3rBfeGOiceNnvAOGJYsWns10YZS/8kUjC4/V8=;
        b=nCqTFv2pMNBPHjB5OG93w6kLu1PDXQ14YuSrQLiihDU9dBwRGiiU1y4loAGRAaf2s2
         dJ1xlXv/kHrNDXfCkZzxY2YjVyPqr1EFRVnLrziRC6ho8Sd6Ny8b3tnfEJo567/iBHXV
         MLH255hEalHH+frMDlyf9LOvCyyk5CHREivKOhF228pamzz9bmtkX+fTOkn5PrDC54VC
         9LwLGebfOkbeAVcjtCZDN2Iopq6TOonsCPojCWVtQQaL2PNmru7PDvUODGvaV4bOy516
         N4UrkeGBLIgrHvA5WsDYVliJHO2qXZhNKw2BCNTJ/IKhDYeYVZ9hMjcwpbAC7QGXe/na
         3l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dt8uSL3rBfeGOiceNnvAOGJYsWns10YZS/8kUjC4/V8=;
        b=oW/ALkg3aJ0sY5r87b2lxRg22g6piBA9fOT6gOJ8JwyAm6VlteRgCtcGgwq073Z0Ui
         nn8O5pkd1rvpYKE8olDYYaj60CGdnMAQlg1Y5QSve4Zk8X+oAyNUZ9gwXRjzmDddh0MA
         soic1n5cUBpseztlNQRfvRVrScFg7y7Oot4yJHoyubfflrdQkdhA+jwTpT7aqt8b4lXk
         3FrgDYOG3+uWN0Bg2e8A8mzcYmEENEZhoxnp1Yj1hhWKqInTMvFpyEbtGL/J4SAIj4YT
         3LMqm01ZcqnEaVws5rddwGjFRA23zYCkAKwoxqfdDcP/3fFotTvBeVp/GPMtuFoFWNlT
         rLVw==
X-Gm-Message-State: APjAAAU15hgZPOS8k5Aih5AwpOD0iBalQsT+9/COztUqxo0WDPxMbpMe
        kEXFDrdvogLUmaWPxf3ItgIYzWh0
X-Google-Smtp-Source: APXvYqwQX3p7rJ9qvL+UbUvqkfZmctNFw/LXlBz0VAyuFPXbIm4i8pPObVPO2lUqn5RwvlrnLkuGiA==
X-Received: by 2002:a19:6001:: with SMTP id u1mr6636298lfb.50.1567780935056;
        Fri, 06 Sep 2019 07:42:15 -0700 (PDT)
Received: from localhost.localdomain (mm-82-227-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.227.82])
        by smtp.gmail.com with ESMTPSA id z30sm1325077lfj.63.2019.09.06.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:42:14 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/2] blk-iolatency: Fix zero mean in previous stats
Date:   Fri,  6 Sep 2019 17:42:03 +0300
Message-Id: <919e7e7012ac22854b347fd8efa99a6fa17d2144.1567780718.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567780718.git.asml.silence@gmail.com>
References: <cover.1567780718.git.asml.silence@gmail.com>
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
@mean, and vise versa for (2). Functions operating on struct blk_rq_stat
have implicit assumptions about its state.

blk_rq_stat_sum() require @src argument to be in (1) and @dst in (2).
iolatency_check_latencies() violates that, and as a result,
iolat->cur_stat.rqs.mean is always 0 for non-ssd devices.

Use 2 distinct functions instead:
blk_rq_stat_collect() to collect intermediate stats (1)
blk_rq_stat_merge() to merge accumulated stats (2)

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-iolatency.c | 21 ++++++++++++++++-----
 block/blk-stat.c      | 20 ++++++++++++++++++--
 block/blk-stat.h      |  3 ++-
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c128d50cb410..895c6e955f97 100644
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
@@ -896,7 +907,7 @@ static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
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


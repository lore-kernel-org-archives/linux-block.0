Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD9C3F2C6
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D6324654
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 21:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKWB8q3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCIVAB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:00:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43763 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCIVAB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:00:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id q18so10699995qki.10
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DI7uxpfBO6HHZsVr+alAd8q8w11ZcjhTyNN3pgPmuzY=;
        b=pKWB8q3JXMbGkjWxPXClfe64nR8RCJuOcCagxWsukz/2vfNgSpYW3tATHThBO7efA5
         B3U1VZjDWeAlP38bdhQDEyexmve2TOdXi+TJh0uZDEHjCz82T+X/iuYxEcv228/cqDBg
         QAtQLtR4bXE073qbSmiMnNUIz8YQWVFU47JF6B64G1UDRSgni7NzNgjVCWYvgwmz0UoU
         lu4j1oPrVitqHVNEE5qI3rbpCapoSev5aCg/LcraurBWQ/dEm9BiW2kPyxIMBVni0zvu
         I1g9cn0HeIc6QY2FXPyWKOInxFZNQ8GOxV89ae+R3H56jLbR7GkuA29r3ThXqn4Lq4TW
         QcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DI7uxpfBO6HHZsVr+alAd8q8w11ZcjhTyNN3pgPmuzY=;
        b=NdJix7GoD1txmv90goIGVZFLNB2T4OugphedML+Hh8qdhk9E7cMUykKWEaY40pwsIN
         S58pRzga7qZcN4gdSFa7ZFt1V43jYMEYHgnNr8//ZYgSjRxTjul8nRZj1DrZD1//oiuG
         sL3PunBccOAmvizRSp4H28cNRzwRslrmasmSsDv2aoCvfBZGCJT/N0zZF0d64ei4S3Vz
         mtOPol0/q5P/V6fHAIPsfBINB4CcKBHP01Ni4ExdK0Y8PiHNIjTI2eI2QAwurBBpOZ86
         AUspUJM7vOrjLahbpujiymRk1uk7/roX497h5BH++DjkmYxxrxWx1pyC8cn3F2EN2B1F
         gKcQ==
X-Gm-Message-State: ANhLgQ2VahFZ8kkCSIf+wx0ANAnxa68sHQ2LOGlnWUsDsl1S/FwnFqA7
        N7lpnjVcaS95afy2YUWJEaeDmKxI8fE=
X-Google-Smtp-Source: ADFU+vuDuqo6hC70nm5zC7WMhQkSgeyZnDTEml6Jkk2Tsvbrq6wMx56kT7Q5SDjUL0i1Ib2q2EsSRw==
X-Received: by 2002:a37:634d:: with SMTP id x74mr10674090qkb.254.1583787599890;
        Mon, 09 Mar 2020 13:59:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id l8sm89441qth.3.2020.03.09.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:59 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 6/7] blk-stat: Make bucket function take latency as an additional argument
Date:   Mon,  9 Mar 2020 16:59:30 -0400
Message-Id: <20200309205931.24256-7-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

This is useful for tracking request latencies, which will be
introduced in the follow-on patch.

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-mq.c   | 6 +++---
 block/blk-stat.c | 4 ++--
 block/blk-stat.h | 6 +++---
 block/blk-wbt.c  | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 04652e59b0e9..a1e4c444a10b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,7 +43,7 @@
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
-static int blk_mq_poll_stats_bkt(const struct request *rq)
+static int blk_mq_poll_stats_bkt(const struct request *rq, u64 value)
 {
 	int ddir, sectors, bucket;
 
@@ -63,7 +63,7 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 /*
  * 8 buckets for each of read, write, and discard
  */
-int blk_req_stats_bkt(const struct request *rq)
+int blk_req_stats_bkt(const struct request *rq, u64 value)
 {
 	int grp, bucket;
 
@@ -3475,7 +3475,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * than ~10 usec. We do use the stats for the relevant IO size
 	 * if available which does lead to better estimates.
 	 */
-	bucket = blk_mq_poll_stats_bkt(rq);
+	bucket = blk_mq_poll_stats_bkt(rq, 0);
 	if (bucket < 0)
 		return ret;
 
diff --git a/block/blk-stat.c b/block/blk-stat.c
index dd5c9c8989a5..812af84b6d1b 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -68,7 +68,7 @@ void blk_stat_add(struct request *rq, u64 now)
 		if (!blk_stat_is_active(cb))
 			continue;
 
-		bucket = cb->bucket_fn(rq);
+		bucket = cb->bucket_fn(rq, value);
 		if (bucket < 0)
 			continue;
 
@@ -103,7 +103,7 @@ static void blk_stat_timer_fn(struct timer_list *t)
 
 struct blk_stat_callback *
 blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
-			int (*bucket_fn)(const struct request *),
+			int (*bucket_fn)(const struct request *, u64),
 			unsigned int buckets, void *data)
 {
 	struct blk_stat_callback *cb;
diff --git a/block/blk-stat.h b/block/blk-stat.h
index d23090b53e12..51abad3775a9 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -37,7 +37,7 @@ struct blk_stat_callback {
 	 * should be accounted under. Return -1 for no bucket for this
 	 * request.
 	 */
-	int (*bucket_fn)(const struct request *);
+	int (*bucket_fn)(const struct request *, u64);
 
 	/**
 	 * @buckets: Number of statistics buckets.
@@ -83,7 +83,7 @@ void blk_stat_enable_accounting(struct request_queue *q);
  */
 struct blk_stat_callback *
 blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
-			int (*bucket_fn)(const struct request *),
+			int (*bucket_fn)(const struct request *, u64),
 			unsigned int buckets, void *data);
 
 /**
@@ -168,7 +168,7 @@ void blk_rq_stat_add(struct blk_rq_stat *, u64, u64);
 void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
-int blk_req_stats_bkt(const struct request *rq);
+int blk_req_stats_bkt(const struct request *rq, u64 value);
 void blk_req_stats_cb(struct blk_stat_callback *cb);
 void blk_req_stats_free(struct request_queue *q);
 #endif
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 8641ba9793c5..9593f7ae3e31 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -669,7 +669,7 @@ u64 wbt_default_latency_nsec(struct request_queue *q)
 		return 75000000ULL;
 }
 
-static int wbt_data_dir(const struct request *rq)
+static int wbt_data_dir(const struct request *rq, u64 value)
 {
 	const int op = req_op(rq);
 
-- 
2.17.1


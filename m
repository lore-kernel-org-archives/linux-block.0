Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F0C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBD52080C
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFLixQ6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfD3HfO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41954 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfD3HfN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so9921366lfd.8;
        Tue, 30 Apr 2019 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Akp5uxp13EweIV3YZW+2vy2S3lWmyRPWKOuymZaNBQ=;
        b=LFLixQ6b6+xa9/QZVqDDGA21oDHgPCKaF3ael1isibVX7xxiKAthhuYeKMRq8INoMY
         MrkjZsyED6OgcB5DbWY1NaE9vG0iRgMOpEwrXWZ/w7iKvNlHNzQccL94pJCJ9dw/akWa
         VydPi/RwXz7qmbQ5AR9CEzvO5iP81KQTvUhxarrrPKKwrl/toGTeguZiSzuiZ0gcIgij
         7MY9SnM6umJ76UIBnegY4Q7haFT+ZMfwgNS26spdYL09UFp7uehv0FdUMX2itADK20IF
         3ZlZpUydeBuHTdK/LThLpAOYG8n0bCYlG7e6Wzt5tw7XvcLtfb/D1n7jDqr7mYKHg4Jh
         ddkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Akp5uxp13EweIV3YZW+2vy2S3lWmyRPWKOuymZaNBQ=;
        b=rCvZAEVrMRrN7tF1jKOQfR1zS5ho3t7WoSutVJbVcbhzMSKSikDA9BuPIJj0ciKf+J
         IpFmM+Nkp+ZYUgrnRf9fK0/tow92Psa08M+YCsZbfX+io/04+6cV4GhvyxcmXKcpq5bE
         38k1c3JBRXYdUm42Zoq88evtAkA0IkkzYTdIEhcmsZsXfimkF88Mpjgxgh2ETBFxlSwG
         fT0ZGplBt6uaK+zgfFcfQFm5Qm+YQePogZGz1ySKcVTHDPMJnzu1yPZG4moIZWWjpTGg
         sjG0AEXmtembIelVlLvURPe1NTlUlSjD7PLQ22YhulRnLnQwtdXb64M/Y3dvCHI8NbeX
         uK2g==
X-Gm-Message-State: APjAAAVRMjyS3TdOVNu6C4sJmOel9bBThefkz0bQm+8WErCppcXijS2c
        4FkVZ0cf69LHZ0q1B4mII3o=
X-Google-Smtp-Source: APXvYqzAVtaeLvJcIE/R+qJxl8ttLN6W3l69ULlOrb+R12MtLxhFyXnmQXwOHsclaEN/tVWSHOqa1w==
X-Received: by 2002:ac2:5582:: with SMTP id v2mr9892379lfg.19.1556609710946;
        Tue, 30 Apr 2019 00:35:10 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:35:10 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 7/7] blk-mq: Adjust hybrid poll sleep time
Date:   Tue, 30 Apr 2019 10:34:19 +0300
Message-Id: <90ea71d810084eec70fb1632587b450b3037ce85.1556609582.git.asml.silence@gmail.com>
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

Sleep for (mean / 2) in the adaptive polling is often too pessimistic,
use a variation of the 3-sigma rule (mean - 4 * lmd) and tune it in
runtime using percentage of missed (i.e. overslept) requests:
1. if more than ~3% of requests are missed, then fallback to (mean / 2)
2. if more than ~0.4% is missed, then scale down

Pitfalls:
1. any missed request increases the mean, synergistically increasing
mean and sleep time, so, scale down fast in the case
2. even if the sleep time is predicted well, sleep loop could greatly
oversleep by itself. Then try to detect it and skip the miss accounting.

Tested on an NVMe SSD:
{4K,8K} read-only workloads give similar latency distribution (up to
7 nines), and decreases CPU load twice (50% -> 25%). New method even
outperform the old one a bit (in terms of throughput and latencies),
presumably, because it alleviates the 2nd pitfall.
For write-only workload it falls back to (mean / 2).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec7cde754c2f..efa44a617bea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3338,10 +3338,21 @@ static void blk_mq_poll_stats_start(struct request_queue *q)
 	blk_stat_activate_msecs(q->poll_cb, 100);
 }
 
+/*
+ * Thresholds are ilog2(nr_requests / nr_misses)
+ * To calculate tolerated miss ratio from it, use
+ * f(x) ~= 2 ^ -(x + 1)
+ *
+ * fallback ~ 3.1%
+ * throttle ~ 0.4%
+ */
+#define BLK_POLL_FALLBACK_THRESHOLD	4
+#define BLK_POLL_THROTTLE_THRESHOLD	7
+
 static void blk_mq_update_poll_info(struct poll_info *pi,
 				    struct blk_rq_stat *stat)
 {
-	u64 sleep_ns;
+	u64 half_mean, indent, sleep_ns;
 	u32 nr_misses, nr_samples;
 
 	nr_samples = stat->nr_samples;
@@ -3349,14 +3360,33 @@ static void blk_mq_update_poll_info(struct poll_info *pi,
 	if (nr_misses > nr_samples)
 		nr_misses = nr_samples;
 
-	if (!nr_samples)
+	half_mean = (stat->mean + 1) / 2;
+	indent = stat->lmd * 4;
+
+	if (!stat->nr_samples) {
 		sleep_ns = 0;
-	else
-		sleep_ns = (stat->mean + 1) / 2;
+	} else if (!stat->lmd || stat->mean <= indent) {
+		sleep_ns = half_mean;
+	} else {
+		int ratio = INT_MAX;
 
-	/*
-	 * Use miss ratio here to adjust sleep time
-	 */
+		sleep_ns = stat->mean - indent;
+
+		/*
+		 * If a completion is overslept, the observable time will
+		 * be greater than the actual, so increasing mean. It
+		 * also increases sleep time estimation, synergistically
+		 * backfiring on mean. Need to scale down / fallback early.
+		 */
+		if (nr_misses)
+			ratio = ilog2(nr_samples / nr_misses);
+		if (ratio <= BLK_POLL_FALLBACK_THRESHOLD)
+			sleep_ns = half_mean;
+		else if (ratio <= BLK_POLL_THROTTLE_THRESHOLD)
+			sleep_ns -= sleep_ns / 4;
+
+		sleep_ns = max(sleep_ns, half_mean);
+	}
 
 	pi->stat = *stat;
 	pi->sleep_ns = sleep_ns;
-- 
2.21.0


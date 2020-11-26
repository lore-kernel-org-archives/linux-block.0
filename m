Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D727C64E7A
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E93020DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbgKZIQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:16:27 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34808 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgKZIQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGa-lFP_1606378582;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGa-lFP_1606378582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 16:16:23 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] blk-iocost: Factor out the base vrate change into a separate function
Date:   Thu, 26 Nov 2020 16:16:15 +0800
Message-Id: <6d14f8c88beee6561cf0ab091e3bbf0a60fb8e34.1606378475.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Factor out the base vrate change code into a separate function
to fimplify the ioc_timer_fn().

No functional change.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 99 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 93abfe0..8348db4 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -971,6 +971,58 @@ static void ioc_refresh_vrate(struct ioc *ioc, struct ioc_now *now)
 	ioc->vtime_err = clamp(ioc->vtime_err, -vperiod, vperiod);
 }
 
+static void ioc_adjust_base_vrate(struct ioc *ioc, u32 rq_wait_pct,
+				  int nr_lagging, int nr_shortages,
+				  int prev_busy_level, u32 *missed_ppm)
+{
+	u64 vrate = ioc->vtime_base_rate;
+	u64 vrate_min = ioc->vrate_min, vrate_max = ioc->vrate_max;
+
+	if (!ioc->busy_level || (ioc->busy_level < 0 && nr_lagging)) {
+		if (ioc->busy_level != prev_busy_level || nr_lagging)
+			trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
+						   missed_ppm, rq_wait_pct,
+						   nr_lagging, nr_shortages);
+
+		return;
+	}
+
+	/* rq_wait signal is always reliable, ignore user vrate_min */
+	if (rq_wait_pct > RQ_WAIT_BUSY_PCT)
+		vrate_min = VRATE_MIN;
+
+	/*
+	 * If vrate is out of bounds, apply clamp gradually as the
+	 * bounds can change abruptly.  Otherwise, apply busy_level
+	 * based adjustment.
+	 */
+	if (vrate < vrate_min) {
+		vrate = div64_u64(vrate * (100 + VRATE_CLAMP_ADJ_PCT), 100);
+		vrate = min(vrate, vrate_min);
+	} else if (vrate > vrate_max) {
+		vrate = div64_u64(vrate * (100 - VRATE_CLAMP_ADJ_PCT), 100);
+		vrate = max(vrate, vrate_max);
+	} else {
+		int idx = min_t(int, abs(ioc->busy_level),
+				ARRAY_SIZE(vrate_adj_pct) - 1);
+		u32 adj_pct = vrate_adj_pct[idx];
+
+		if (ioc->busy_level > 0)
+			adj_pct = 100 - adj_pct;
+		else
+			adj_pct = 100 + adj_pct;
+
+		vrate = clamp(DIV64_U64_ROUND_UP(vrate * adj_pct, 100),
+			      vrate_min, vrate_max);
+	}
+
+	trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
+				   nr_lagging, nr_shortages);
+
+	ioc->vtime_base_rate = vrate;
+	ioc_refresh_margins(ioc);
+}
+
 /* take a snapshot of the current [v]time and vrate */
 static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 {
@@ -2323,51 +2375,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 	ioc->busy_level = clamp(ioc->busy_level, -1000, 1000);
 
-	if (ioc->busy_level > 0 || (ioc->busy_level < 0 && !nr_lagging)) {
-		u64 vrate = ioc->vtime_base_rate;
-		u64 vrate_min = ioc->vrate_min, vrate_max = ioc->vrate_max;
-
-		/* rq_wait signal is always reliable, ignore user vrate_min */
-		if (rq_wait_pct > RQ_WAIT_BUSY_PCT)
-			vrate_min = VRATE_MIN;
-
-		/*
-		 * If vrate is out of bounds, apply clamp gradually as the
-		 * bounds can change abruptly.  Otherwise, apply busy_level
-		 * based adjustment.
-		 */
-		if (vrate < vrate_min) {
-			vrate = div64_u64(vrate * (100 + VRATE_CLAMP_ADJ_PCT),
-					  100);
-			vrate = min(vrate, vrate_min);
-		} else if (vrate > vrate_max) {
-			vrate = div64_u64(vrate * (100 - VRATE_CLAMP_ADJ_PCT),
-					  100);
-			vrate = max(vrate, vrate_max);
-		} else {
-			int idx = min_t(int, abs(ioc->busy_level),
-					ARRAY_SIZE(vrate_adj_pct) - 1);
-			u32 adj_pct = vrate_adj_pct[idx];
-
-			if (ioc->busy_level > 0)
-				adj_pct = 100 - adj_pct;
-			else
-				adj_pct = 100 + adj_pct;
-
-			vrate = clamp(DIV64_U64_ROUND_UP(vrate * adj_pct, 100),
-				      vrate_min, vrate_max);
-		}
-
-		trace_iocost_ioc_vrate_adj(ioc, vrate, missed_ppm, rq_wait_pct,
-					   nr_lagging, nr_shortages);
-
-		ioc->vtime_base_rate = vrate;
-		ioc_refresh_margins(ioc);
-	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
-		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
-					   missed_ppm, rq_wait_pct, nr_lagging,
-					   nr_shortages);
-	}
+	ioc_adjust_base_vrate(ioc, rq_wait_pct, nr_lagging, nr_shortages,
+			      prev_busy_level, missed_ppm);
 
 	ioc_refresh_params(ioc, false);
 
-- 
1.8.3.1


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC87C64E7D
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C312A20872
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbgKZIQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:16:26 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37985 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729608AbgKZIQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGa2A8f_1606378581;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGa2A8f_1606378581)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 16:16:22 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] blk-iocost: Move the usage ratio calculation to the correct place
Date:   Thu, 26 Nov 2020 16:16:13 +0800
Message-Id: <a4e6af93419250de5372ff681d3395cf36676037.1606378475.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only use the hweight based usage ratio to calculate the new
hweight_inuse of the iocg to decide if this iocg can donate some
surplus vtime.

Thus move the usage ratio calculation to the correct place to
avoid unnecessary calculation for some vtime shortage iocgs.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 103ccbd..a926179 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2168,8 +2168,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 	/* calc usage and see whether some weights need to be moved around */
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
-		u64 vdone, vtime, usage_us, usage_dur;
-		u32 usage, hw_active, hw_inuse;
+		u64 vdone, vtime, usage_us;
+		u32 hw_active, hw_inuse;
 
 		/*
 		 * Collect unused and wind vtime closer to vnow to prevent
@@ -2200,30 +2200,32 @@ static void ioc_timer_fn(struct timer_list *timer)
 		usage_us = iocg->usage_delta_us;
 		usage_us_sum += usage_us;
 
-		if (vdone != vtime) {
-			u64 inflight_us = DIV64_U64_ROUND_UP(
-				cost_to_abs_cost(vtime - vdone, hw_inuse),
-				ioc->vtime_base_rate);
-			usage_us = max(usage_us, inflight_us);
-		}
-
-		/* convert to hweight based usage ratio */
-		if (time_after64(iocg->activated_at, ioc->period_at))
-			usage_dur = max_t(u64, now.now - iocg->activated_at, 1);
-		else
-			usage_dur = max_t(u64, now.now - ioc->period_at, 1);
-
-		usage = clamp_t(u32,
-				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE,
-						   usage_dur),
-				1, WEIGHT_ONE);
-
 		/* see whether there's surplus vtime */
 		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
 		if (hw_inuse < hw_active ||
 		    (!waitqueue_active(&iocg->waitq) &&
 		     time_before64(vtime, now.vnow - ioc->margins.low))) {
-			u32 hwa, old_hwi, hwm, new_hwi;
+			u32 hwa, old_hwi, hwm, new_hwi, usage;
+			u64 usage_dur;
+
+			if (vdone != vtime) {
+				u64 inflight_us = DIV64_U64_ROUND_UP(
+					cost_to_abs_cost(vtime - vdone, hw_inuse),
+					ioc->vtime_base_rate);
+
+				usage_us = max(usage_us, inflight_us);
+			}
+
+			/* convert to hweight based usage ratio */
+			if (time_after64(iocg->activated_at, ioc->period_at))
+				usage_dur = max_t(u64, now.now - iocg->activated_at, 1);
+			else
+				usage_dur = max_t(u64, now.now - ioc->period_at, 1);
+
+			usage = clamp_t(u32,
+				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE,
+						   usage_dur),
+				1, WEIGHT_ONE);
 
 			/*
 			 * Already donating or accumulated enough to start.
-- 
1.8.3.1


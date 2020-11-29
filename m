Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C9C63777
	for <linux-block@archiver.kernel.org>; Sun, 29 Nov 2020 02:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B72720786
	for <linux-block@archiver.kernel.org>; Sun, 29 Nov 2020 02:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgK2Ci2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Nov 2020 21:38:28 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36002 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbgK2Ci1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Nov 2020 21:38:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGpYhm1_1606617444;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGpYhm1_1606617444)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 29 Nov 2020 10:37:24 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] blk-iocost: Optimize the ioc_refreash_vrate() function
Date:   Sun, 29 Nov 2020 10:37:18 +0800
Message-Id: <071dbbbdfecaebf9e850e622c52dd591969e21ab.1606617087.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ioc_refreash_vrate() will only be called in ioc_timer_fn() after
starting a new period or stopping the period.

So when starting a new period, the variable 'pleft' in ioc_refreash_vrate()
is always the period's time, which means if the abs(ioc->vtime_err)
is less than the period's time, the vcomp is 0, and we do not need
compensate the vtime_rate in this case, just set it as the base vrate
and return.

When stopping the period, the ioc->vtime_err will be cleared to 0,
and we also do not need to compensate the vtime_rate, just set it as
the base vrate and return.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8348db4..58c9533 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -943,30 +943,29 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
  */
 static void ioc_refresh_vrate(struct ioc *ioc, struct ioc_now *now)
 {
-	s64 pleft = ioc->period_at + ioc->period_us - now->now;
 	s64 vperiod = ioc->period_us * ioc->vtime_base_rate;
 	s64 vcomp, vcomp_min, vcomp_max;
 
 	lockdep_assert_held(&ioc->lock);
 
-	/* we need some time left in this period */
-	if (pleft <= 0)
-		goto done;
+	if (abs(ioc->vtime_err) < ioc->period_us) {
+		atomic64_set(&ioc->vtime_rate, ioc->vtime_base_rate);
+		return;
+	}
 
 	/*
 	 * Calculate how much vrate should be adjusted to offset the error.
 	 * Limit the amount of adjustment and deduct the adjusted amount from
 	 * the error.
 	 */
-	vcomp = -div64_s64(ioc->vtime_err, pleft);
+	vcomp = -div64_s64(ioc->vtime_err, ioc->period_us);
 	vcomp_min = -(ioc->vtime_base_rate >> 1);
 	vcomp_max = ioc->vtime_base_rate;
 	vcomp = clamp(vcomp, vcomp_min, vcomp_max);
 
-	ioc->vtime_err += vcomp * pleft;
+	ioc->vtime_err += vcomp * ioc->period_us;
 
 	atomic64_set(&ioc->vtime_rate, ioc->vtime_base_rate + vcomp);
-done:
 	/* bound how much error can accumulate */
 	ioc->vtime_err = clamp(ioc->vtime_err, -vperiod, vperiod);
 }
-- 
1.8.3.1


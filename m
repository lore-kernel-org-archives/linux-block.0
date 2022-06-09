Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC4C43334
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 07:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbiFIHfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFIHfQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 03:35:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F5F1A07A
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 00:35:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c14so21057933pgu.13
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2022 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNCO6xxGMkcdib2z4zEwPrhl1AuTZlBAkdZZQBMoJ70=;
        b=42DS6C9QAdOWkd4ugKBoSqNcOX/jjGsn2CabYnajx+nK8AZ7cpx+/kKTtME6+1yIFN
         xAQuAZGMH3I1GUe3o8OzqVULAiaC/KV1HqZeEZsnCZQ3ErOTpZqbWLU84JIPs754wLL0
         0UVq5ie3X9KeaY9pw2XWHn1D/7bBKVMAULD3FUKyQCTCP48PuMW6a0fxwp/2j9lFboVG
         /hFXwM/+ztFxNoKlpxeBPO+vYUCmCG3pyZ2zmAKT5el+1WVzLdomTaBCXIMNyDgct+3L
         sjeYbvAWpIlpO88gfM9Hw6967VQ3/a5nkDQpaoHEpmSwqr4rfkLUcrYYPMTPr2fKkzUj
         kDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JNCO6xxGMkcdib2z4zEwPrhl1AuTZlBAkdZZQBMoJ70=;
        b=yzovRXp4xU1+kmB2BogoIcXahHrpwRHm2ioAr5rF/jRw/RRuggXsrPnAZPi27klyY3
         Es+QEQOWzzXwv/8PrOw8EqneJ+02FPJB72jBN2ND8bUShnTtooW14clOg4DsP7JyDLwg
         Vzdk1RX9OKYLosCPkTkDZl63/lrAm/sJdBMzbpxSCoqYiOsxf3ckaT4fbGIDrpx16Waz
         CFqbPhCGnEdnbArjL9dlod+siBteg2qUUc2XchzlX4a+i+NHjUzf8/dk0ezP5Ib+s6qU
         D+Ut5mtxdSDfWeuErDNiakev6W9ZbODPB7hKLxQLGYuYBt3qQ8E6MYiZTy5sdc+rE518
         9UGw==
X-Gm-Message-State: AOAM531MqQX5poDD28ptLKYEqiu+Owc2cDUzbCNiORIF6SL5A75m+bAw
        vVd+B4GSQIyxbLsEUKvt/meSEw==
X-Google-Smtp-Source: ABdhPJyHbAGnhnBq7RZ5N1q/CfzYou3wiB6VJmVXQQM7uEV7GM9bjSz49OkbGN3IRRa6v+LMf/q6dw==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr38773986pfj.83.1654760114016;
        Thu, 09 Jun 2022 00:35:14 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79f02000000b005185407eda5sm16484841pfr.44.2022.06.09.00.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:35:13 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] blk-iocost: remove the second superfluous current_hweight
Date:   Thu,  9 Jun 2022 15:34:49 +0800
Message-Id: <20220609073450.98975-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit ac33e91e2dac ("blk-iocost: implement vtime loss compensation")
add the second current_hweight() in the loop of active iocgs list to
get old_hwi to calculate the vtime loss of the iocg.

Since the hwi can't change and the first current_hweight already get
hwa and hwi, so this second superfluous current_hweight() can be
removed. There should be no functional changes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..3cda08224d51 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2238,7 +2238,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	/* calc usage and see whether some weights need to be moved around */
 	list_for_each_entry(iocg, &ioc->active_iocgs, active_list) {
 		u64 vdone, vtime, usage_us;
-		u32 hw_active, hw_inuse;
+		u32 hwa, old_hwi;
 
 		/*
 		 * Collect unused and wind vtime closer to vnow to prevent
@@ -2246,7 +2246,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 		 */
 		vdone = atomic64_read(&iocg->done_vtime);
 		vtime = atomic64_read(&iocg->vtime);
-		current_hweight(iocg, &hw_active, &hw_inuse);
+		current_hweight(iocg, &hwa, &old_hwi);
 
 		/*
 		 * Latency QoS detection doesn't account for IOs which are
@@ -2271,15 +2271,15 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 		/* see whether there's surplus vtime */
 		WARN_ON_ONCE(!list_empty(&iocg->surplus_list));
-		if (hw_inuse < hw_active ||
+		if (old_hwi < hwa ||
 		    (!waitqueue_active(&iocg->waitq) &&
 		     time_before64(vtime, now.vnow - ioc->margins.low))) {
-			u32 hwa, old_hwi, hwm, new_hwi, usage;
+			u32 hwm, new_hwi, usage;
 			u64 usage_dur;
 
 			if (vdone != vtime) {
 				u64 inflight_us = DIV64_U64_ROUND_UP(
-					cost_to_abs_cost(vtime - vdone, hw_inuse),
+					cost_to_abs_cost(vtime - vdone, old_hwi),
 					ioc->vtime_base_rate);
 
 				usage_us = max(usage_us, inflight_us);
@@ -2300,7 +2300,6 @@ static void ioc_timer_fn(struct timer_list *timer)
 			 * Already donating or accumulated enough to start.
 			 * Determine the donation amount.
 			 */
-			current_hweight(iocg, &hwa, &old_hwi);
 			hwm = current_hweight_max(iocg);
 			new_hwi = hweight_after_donation(iocg, old_hwi, hwm,
 							 usage, &now);
-- 
2.36.1


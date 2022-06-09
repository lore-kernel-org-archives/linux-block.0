Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F71C43334
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 07:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiFIHff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiFIHfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 03:35:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B01A390
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 00:35:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a10so20654105pju.3
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2022 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYw6wvPJ7Xei/HGruHsIypVM6+sZb5U/lhRvaoIzlbw=;
        b=QhaY0KimCJ7at9K6S0OXb5L3mB9z34R2FTDzj0Jghmx7QumPqtodv+9bcOIlOJow64
         3/BWCjbNtxyIKj2VFlSmT5eo7Ovr5uQ4t1tYbyCJ6YT0Btm/8kzoArqvJY1TNzRPZMB8
         V2Wgc5UOPmDZEol3qH0XdoQcPkpnvPvCRYj1b9rYIxclFNbfH1pSAl7hMH9dT3qKrS3D
         AXckhuDY+6PUjI+HOUvCI2cKzV0l+HkWPSU2GSgaHj1uoPWRW9ZZOJQCz3NEWu02g4Dj
         s4E1cFhD/usRtWVcqDTniYwm+mK1iV+NeKeN/BdxowLR3MD/8OpaPsSKvstKxoPyvOvT
         VBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYw6wvPJ7Xei/HGruHsIypVM6+sZb5U/lhRvaoIzlbw=;
        b=k4NOCaVAWTWpapl7LFyf8DUMXwLloxXdPWHLQqxXd1iQSZEkPBGZVDOeGwoUFPJM3n
         IFr/1u999n4NgWjfU1qUSYFLfHZ7yRaXWh3rq/wxwBlgZ6JFEAY4BPi44eerEQoa8QiU
         P1Q6qjsD0vH3Y0qJRbJaVgA5bQDi5sTTyD6y430niSU5HqNsinBUBdlP+Ujv1ASWKnYj
         A+J+KdfWLESuK4jlESANtC5HAQr36vi/Kv1+WYuWECHkqyenFKgmo54X01YLebraJKAT
         Xt2wkwWgLCcDNPtWOISbdu6oZrp6BFS+wUxpQamedhCnggFnLwKjrPgvmFoCB7BCcXmd
         TCrg==
X-Gm-Message-State: AOAM531rk8sVvhxRSV1Tq81Jy/n6SApC7gVJZ4WCPoPq9lT6dft4SYsP
        vyz4AlzmRInDYWJox1NQlbyUIRxD9wrGxQ==
X-Google-Smtp-Source: ABdhPJwKMgkKBTOY+kiwZqtSuwSPoJjYIG63GIF3HIGXDYGokUyK7wRZ/g9ktVM5DkV4RU2vvRtn1w==
X-Received: by 2002:a17:902:da87:b0:164:395:71d7 with SMTP id j7-20020a170902da8700b00164039571d7mr38363713plx.81.1654760116980;
        Thu, 09 Jun 2022 00:35:16 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79f02000000b005185407eda5sm16484841pfr.44.2022.06.09.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:35:16 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 2/2] blk-iocost: fix vtime loss calculation when iocg deactivate
Date:   Thu,  9 Jun 2022 15:34:50 +0800
Message-Id: <20220609073450.98975-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609073450.98975-1-zhouchengming@bytedance.com>
References: <20220609073450.98975-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit ac33e91e2dac ("blk-iocost: implement vtime loss compensation")
will accumulate vtime loss of iocgs on the period, to compensate
the vtime loss we throw away, which is good for device utilization.

But the vtime loss calculation of iocg is wrong because of different
hweight_gen when having some iocgs deactivated.

ioc_check_iocgs()
  ...
  } else if (iocg_is_idle(iocg)) {
    ioc->vtime_err -= div64_u64(excess * old_hwi,	--> old_hwi_1
                                WEIGHT_ONE);
  }

  commit_weights(ioc);			--> hweight_gen increase

hweight_after_donation()
  ...
  ioc->vtime_err -= div64_u64(excess * old_hwi,		--> old_hwi_2
                              WEIGHT_ONE);

The old_hwi_2 of active iocgs is in fact not of the same hweight_gen
as the old_hwi_1 of idle iocgs. After idle iocgs deactivate and
hweight_gen increase, the old_hwi_2 become larger than it should be,
which cause the calculated vtime_err more than it should be.

I found this problem by noticing some abnormal vtime loss compensation
when having some cgroups with intermittent IO.

Since we already have recorded the usage_delta_us of each iocg, and
usage_us_sum is the sum of them, so the vtime loss calculation of
the period is straightforward and more accurate.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3cda08224d51..6c55c69d4aad 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1730,7 +1730,6 @@ static u32 hweight_after_donation(struct ioc_gq *iocg, u32 old_hwi, u32 hwm,
 		atomic64_add(excess, &iocg->vtime);
 		atomic64_add(excess, &iocg->done_vtime);
 		vtime += excess;
-		ioc->vtime_err -= div64_u64(excess * old_hwi, WEIGHT_ONE);
 	}
 
 	/*
@@ -2168,22 +2167,6 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 		} else if (iocg_is_idle(iocg)) {
 			/* no waiter and idle, deactivate */
 			u64 vtime = atomic64_read(&iocg->vtime);
-			s64 excess;
-
-			/*
-			 * @iocg has been inactive for a full duration and will
-			 * have a high budget. Account anything above target as
-			 * error and throw away. On reactivation, it'll start
-			 * with the target budget.
-			 */
-			excess = now->vnow - vtime - ioc->margins.target;
-			if (excess > 0) {
-				u32 old_hwi;
-
-				current_hweight(iocg, NULL, &old_hwi);
-				ioc->vtime_err -= div64_u64(excess * old_hwi,
-							    WEIGHT_ONE);
-			}
 
 			TRACE_IOCG_PATH(iocg_idle, iocg, now,
 					atomic64_read(&iocg->active_period),
@@ -2348,6 +2331,10 @@ static void ioc_timer_fn(struct timer_list *timer)
 	list_for_each_entry_safe(iocg, tiocg, &surpluses, surplus_list)
 		list_del_init(&iocg->surplus_list);
 
+	/* calculate vtime loss in this period */
+	if (period_vtime > usage_us_sum * ioc->vtime_base_rate)
+		ioc->vtime_err -= period_vtime - usage_us_sum * ioc->vtime_base_rate;
+
 	/*
 	 * If q is getting clogged or we're missing too much, we're issuing
 	 * too much IO and should lower vtime rate.  If we're not missing
-- 
2.36.1


Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C07C4CECE
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 00:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20D217D9
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 00:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571098696;
	bh=WAOsRKHaIlvPKRrDZsgGiKrgNU1+TKo7NOeKs4/xAio=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Tb7rCV4qBL54wpLHSIrVq8IgsjSJ3+YSeBJekoMz8JSnzUZZpfBYDGG+HWRKYHaL0
	 M8W/xkAvcfnN2HVq06nY905eiL+uLVDo2jwB6sIaHGbEDQQ2OI0mvF+5PHt2e0HImy
	 88z8MbPQdPxYTj4Y7UsNWywuzTnurEmH/7P86mtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfJOASP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:18:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33203 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfJOASP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 20:18:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so28097312qtd.0;
        Mon, 14 Oct 2019 17:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4vu2k7uXTZA3blp3ATlra2S1b9kFWXb8/Zwu5O+3lL4=;
        b=NnTuiUcIMkYX/SzX0f5d/3lXY1M2mnKL7Ro9joj2AkDYaVqLW6gWrgUQVBT1AteK4F
         eiAbQp62j7+DzIjEciKyzU2RK74kIiHNs0mOASzst65jIrV4Xs1uujcGNah35LLpRv2d
         fyXMliZMk++LsoKsnokc5eLoE4QYl4E7bjeiFBLbU42OGPh0OAfATihuc76YR162fybx
         keBKj5uRulVilQL36JVLd+SxWVYyL5Kcf31kTF0HmtipHqv6tRC4NVOQt9giz5A67v9E
         K9I5qJkrP4igNTK71LqT45x965ZCzbXZNSwMzn7k05VrMGcxQN64Br8VTl3Ys6wlH6zO
         jC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=4vu2k7uXTZA3blp3ATlra2S1b9kFWXb8/Zwu5O+3lL4=;
        b=LjVvuFCrmihkRTEkAVaKg2gJHQwUBnAn8/IwBKU4Rw/t1FU+IREXNqm7w8uWp64I9X
         mmOtB3o4lClCG6BIr5lVb5IdwadAnvXJFRxADxUMyw5VJeHvu6HnBMxixvvtnAqAapJP
         xDhkOFznml78hx7Ep+E6ReNQtbAOkcmRLEf//HjH5+PdmL7TaVbJdqy4EB5tjCUhKUrv
         aDyR3gnQPqA+G8Nwd4eSWN9LYuZWx6YdYEg+LQ4dO7wMElD8WkI94w1F7pE3ahXZEwEc
         YnFwDxLN7aCFbxn6kOiU23hq6fnnn+bZQ1gVAwQUTThPQG8DaI9/dCe8RcH5xYrnKova
         XV9w==
X-Gm-Message-State: APjAAAUvg/nfKdG9mM81LUogZLzpmqBEssIgXk7rgBDhZ3GuXPKuWA5c
        LNpbXxWrIqcPZbXCQrzcjjI=
X-Google-Smtp-Source: APXvYqwEbxwsBUnBxZTcjmeXs2HOjqULcXSy5zz52zrwQoIXIF7mKeDssOWXUz13xhxaGMWoJn8PTA==
X-Received: by 2002:ac8:714e:: with SMTP id h14mr2298285qtp.147.1571098693868;
        Mon, 14 Oct 2019 17:18:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:50c5])
        by smtp.gmail.com with ESMTPSA id v5sm13682479qtk.66.2019.10.14.17.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 17:18:13 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:18:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, newella@fb.com
Subject: [PATCH block/for-linus] iocost: don't let vrate run wild while
 there's no saturation signal
Message-ID: <20191015001811.GI18794@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the QoS targets are met and nothing is being throttled, there's
no way to tell how saturated the underlying device is - it could be
almost entirely idle, at the cusp of saturation or anywhere inbetween.
Given that there's no information, it's best to keep vrate as-is in
this state.  Before 7cd806a9a953 ("iocost: improve nr_lagging
handling"), this was the case - if the device isn't missing QoS
targets and nothing is being throttled, busy_level was reset to zero.

While fixing nr_lagging handling, 7cd806a9a953 ("iocost: improve
nr_lagging handling") broke this.  Now, while the device is hitting
QoS targets and nothing is being throttled, vrate keeps getting
adjusted according to the existing busy_level.

This led to vrate keeping climing till it hits max when there's an IO
issuer with limited request concurrency if the vrate started low.
vrate starts getting adjusted upwards until the issuer can issue IOs
w/o being throttled.  From then on, QoS targets keeps getting met and
nothing on the system needs throttling and vrate keeps getting
increased due to the existing busy_level.

This patch makes the following changes to the busy_level logic.

* Reset busy_level if nr_shortages is zero to avoid the above
  scenario.

* Make non-zero nr_lagging block lowering nr_level but still clear
  positive busy_level if there's clear non-saturation signal - QoS
  targets are met and nr_shortages is non-zero.  nr_lagging's role is
  preventing adjusting vrate upwards while there are long-running
  commands and it shouldn't keep busy_level positive while there's
  clear non-saturation signal.

* Restructure code for clarity and add comments.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Andy Newell <newella@fb.com>
Fixes: 7cd806a9a953 ("iocost: improve nr_lagging handling")
---
 block/blk-iocost.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2a3db80c1dce..b6326ab5ffe7 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1536,19 +1536,39 @@ static void ioc_timer_fn(struct timer_list *timer)
 	if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
 	    missed_ppm[READ] > ppm_rthr ||
 	    missed_ppm[WRITE] > ppm_wthr) {
+		/* clearly missing QoS targets, slow down vrate */
 		ioc->busy_level = max(ioc->busy_level, 0);
 		ioc->busy_level++;
 	} else if (rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[READ] <= ppm_rthr * UNBUSY_THR_PCT / 100 &&
 		   missed_ppm[WRITE] <= ppm_wthr * UNBUSY_THR_PCT / 100) {
-		/* take action iff there is contention */
-		if (nr_shortages && !nr_lagging) {
+		/* QoS targets are being met with >25% margin */
+		if (nr_shortages) {
+			/*
+			 * We're throttling while the device has spare
+			 * capacity.  If vrate was being slowed down, stop.
+			 */
 			ioc->busy_level = min(ioc->busy_level, 0);
-			/* redistribute surpluses first */
-			if (!nr_surpluses)
+
+			/*
+			 * If there are IOs spanning multiple periods, wait
+			 * them out before pushing the device harder.  If
+			 * there are surpluses, let redistribution work it
+			 * out first.
+			 */
+			if (!nr_lagging && !nr_surpluses)
 				ioc->busy_level--;
+		} else {
+			/*
+			 * Nobody is being throttled and the users aren't
+			 * issuing enough IOs to saturate the device.  We
+			 * simply don't know how close the device is to
+			 * saturation.  Coast.
+			 */
+			ioc->busy_level = 0;
 		}
 	} else {
+		/* inside the hysterisis margin, we're good */
 		ioc->busy_level = 0;
 	}
 

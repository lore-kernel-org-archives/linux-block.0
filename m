Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A546C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 04:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4273864D9F
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 04:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhA1EKP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 23:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1EKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 23:10:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137FBC061574
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 19:41:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so3384794pgc.8
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 19:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8gjX+jjDFMAlZkTk6jMUJPns6AHBcmdN1XMHS3UqN/A=;
        b=V0DylTMjpL5WcI72wITMJnqhWjt5RB80k11HTTxQk1QuSPO+8GNRuLhwD+E+X5DwEl
         91T6ytbzRiO1cTXCiQxwPzoAeMKChzegBnfIE6Wj2jQC3issmbg5n5yVGaFWQi72cy52
         Jk0c5rANenq/FOgB6higjUbR8B9AlpjL887l8LN3q6VCKaEQjOCjUlBZJe+Xx4aIJ23h
         lvWRHD7I6k83axGbw2IVQivf2b1cK0Te/7q+aSmVd6FE7S6X+pyFPCUy42v0fmR24HYq
         yWbJKjRa0x5wvUPu/zEu9cP445i6u/fwxyy9BkA5w8X4loZYIIsmzKQl0rTQaAp2eBw3
         ab6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8gjX+jjDFMAlZkTk6jMUJPns6AHBcmdN1XMHS3UqN/A=;
        b=fpRNnVzntpA7XmA63kOb4M4jgyKStUoRB2AuaxeADPXtFFAX4Hex4WMfryl0UgTChP
         FzZpNQq6XVh4uxaG5zmnRY+/K/4MtKs1uNWlV6ofbB8F+uWj6FFcN+3k8QHP1UHMbJ6E
         fDVaniKJFfl8spU10w+2gSZhngAUWx0iTO4jq8awgt/q9a/EKi2U06ncRcDXocZ1Cfgt
         nuXXu2RDidcZoNzQZjEPw0o/uYiO8l2Y5J4s2FkePfglV0xdfSi5mqE/cbckp1pFfIM8
         RSG2xNb28yru60Bd74H4hGzLG4W2R9Sz5qz45oa2S4ElEjYBlvKtm0K5jmw/5X+HfwvK
         yxDw==
X-Gm-Message-State: AOAM530Dr/w9Xk2QIwDDAiYjv1TFelVfUSl7f6Tjoj5/NqNVldUT1ckI
        rr0ifOMd6AX9CqJCumvcZuhnZA==
X-Google-Smtp-Source: ABdhPJxwfnr8Y68lxPXVwnOC5bnssKNqbFvjz7fbRXXlKX9S3gbqxmlRasIvx34jePQYdKknZk4cgw==
X-Received: by 2002:a62:800d:0:b029:1bc:9cd1:8ee1 with SMTP id j13-20020a62800d0000b02901bc9cd18ee1mr13845698pfd.69.1611805295395;
        Wed, 27 Jan 2021 19:41:35 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a188sm4167710pfb.108.2021.01.27.19.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 19:41:34 -0800 (PST)
Subject: Re: [PATCH v2] blk-cgroup: Use cond_resched() when destroy blkgs
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f3c12de-b5fb-a9ad-9324-55f5bf9d7453@kernel.dk>
Date:   Wed, 27 Jan 2021 20:41:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8e8a0c4644d5eb01b7f79ec9b67c2b240f4a6434.1611798287.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 8:22 PM, Baolin Wang wrote:
> On !PREEMPT kernel, we can get below softlockup when doing stress
> testing with creating and destroying block cgroup repeatly. The
> reason is it may take a long time to acquire the queue's lock in
> the loop of blkcg_destroy_blkgs(), or the system can accumulate a
> huge number of blkgs in pathological cases. We can add a need_resched()
> check on each loop and release locks and do cond_resched() if true
> to avoid this issue, since the blkcg_destroy_blkgs() is not called
> from atomic contexts.
> 
> [ 4757.010308] watchdog: BUG: soft lockup - CPU#11 stuck for 94s!
> [ 4757.010698] Call trace:
> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
> [ 4757.010702]  process_one_work+0x1bc/0x3f0
> [ 4757.010704]  worker_thread+0x164/0x468
> [ 4757.010705]  kthread+0x108/0x138

Kind of ugly with the two clauses for dropping the blkcg lock, one
being a cpu_relax() and the other a resched. How about something
like this:


diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 031114d454a6..4221a1539391 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1016,6 +1016,8 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
  */
 void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
+	might_sleep();
+
 	spin_lock_irq(&blkcg->lock);
 
 	while (!hlist_empty(&blkcg->blkg_list)) {
@@ -1023,14 +1025,20 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 						struct blkcg_gq, blkcg_node);
 		struct request_queue *q = blkg->q;
 
-		if (spin_trylock(&q->queue_lock)) {
-			blkg_destroy(blkg);
-			spin_unlock(&q->queue_lock);
-		} else {
+		if (need_resched() || !spin_trylock(&q->queue_lock)) {
+			/*
+			 * Given that the system can accumulate a huge number
+			 * of blkgs in pathological cases, check to see if we
+			 * need to rescheduling to avoid softlockup.
+			 */
 			spin_unlock_irq(&blkcg->lock);
-			cpu_relax();
+			cond_resched();
 			spin_lock_irq(&blkcg->lock);
+			continue;
 		}
+
+		blkg_destroy(blkg);
+		spin_unlock(&q->queue_lock);
 	}
 
 	spin_unlock_irq(&blkcg->lock);

-- 
Jens Axboe


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D7C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB4F64D9F
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhA1Ocs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhA1Ocp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:32:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CEC0613D6
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:32:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s23so3134023pgh.11
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9tH9YjKdu4SV5abNwwJi97SLfnNUb/O813edamRM6Q=;
        b=JDmPw59tJk29B48kwIPKMz8KmvxLlJaaL1BgF4PLqrTIPWOsd2twVS3BZHj3LqHf/U
         tVkocwsz1ijDsPRE8Lh0rHKqIaPBxD68EvPZuRDRxeyFh0/RydPe00W8XBvxCIezyQDE
         U7o4h7sq3V+jfnHYdfXa1zced+kebVZ5WwWH0AuZbpl8NrmTChkCa4zu6Pfij7OwB+Pe
         xnLp++aHRlDNuc2B9fwl5dGTmL4I8ekGdMANiQefjJt9CwRK07Xt++q6WH8YZHf1kuOQ
         CheoPG0P6G5bqkQugw+92XkrSKpZ+Q5qoio15YLoW05cd0ey4B9mSoo+ptj0jxQZyujf
         cigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9tH9YjKdu4SV5abNwwJi97SLfnNUb/O813edamRM6Q=;
        b=JqVaB8RRvfVKOMyDu0zjFq1yiLg7XVfyYw9lYzC1/aUQh0Oh7opux7fz4gghGaGRTv
         1o2Byhkr3wG6eOTpsMgqUtXPlDd84HrAIW+mnhGnfCdCw0QGU7t5HHoBq4G3SG7E9Ori
         qKb8ddIackZw5Aq3kjApeYlLPt9y/ahpSwlPS/ylNkA7GNLPUYmk3PwAsAEjWB2FPBW3
         iHfiWR51JzRvQMkPBan5+O/H8yYKzB8wH1/AJTlHCiiKMGCpulZMgfuitBOlVr8HlFN7
         ODCPv2pXUxqbJo7o3DJEQCNIWYRXvcptkTKs32u19OZw9TujkOWWjydzKs2D8IN1mqv0
         P1bA==
X-Gm-Message-State: AOAM531eKlEhajK4MhEnbxyZdViFZOEVsPnUj1PftEXnW7+63Tn0ejeC
        S41cAyL5BQyWiW8DQfUcCPX13Q==
X-Google-Smtp-Source: ABdhPJyn8mjoxYrivmEV09qI42ucQQdWuIe50sPqGBeCUhM8pOyzcP5QzWmZEXPMW98hrtXAZDR3Ig==
X-Received: by 2002:a63:4507:: with SMTP id s7mr16729858pga.390.1611844324746;
        Thu, 28 Jan 2021 06:32:04 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 6sm5827613pfz.34.2021.01.28.06.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:32:04 -0800 (PST)
Subject: Re: [PATCH v3] blk-cgroup: Use cond_resched() when destroy blkgs
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0be1a0a03367f7230497a2e7a5ed47d2a2d5ae1a.1611809091.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9087d02b-ef9b-46c4-6933-82bb3e520597@kernel.dk>
Date:   Thu, 28 Jan 2021 07:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0be1a0a03367f7230497a2e7a5ed47d2a2d5ae1a.1611809091.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 10:58 PM, Baolin Wang wrote:
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
> [ 4757.010700]  blkcg_destroy_blkgs+0x68/0x150
> [ 4757.010701]  cgwb_release_workfn+0x104/0x158
> [ 4757.010702]  process_one_work+0x1bc/0x3f0
> [ 4757.010704]  worker_thread+0x164/0x468
> [ 4757.010705]  kthread+0x108/0x138

Thanks, applied.

-- 
Jens Axboe


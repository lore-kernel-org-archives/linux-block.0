Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE613C4321E
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 14:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiK1OOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiK1OOl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 09:14:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E7659A
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:14:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b21so10253526plc.9
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSAoMPL7GoXdvi2uqHoiRe+EA22FtKTEJJ1PVxlye2M=;
        b=jgvFSL7jpl9MqLgAG6fh4zKofcwxR+/eoEoZWF/ym/LrF4fLxXEQxRLZAstmlCbqpG
         nMpiwsjL1fRDSlJmD0MHKW9gTfTjZVdQBno5hAZlMaWaeACszvKP/wx8QZpvbzNUIV3H
         bcPYyTTrny+NDOoszf8U8N1sJwKg3ibV+Q6O7XF0xWAuNAl9ZFCDKPWBC53W22952bfD
         hx2wOQyXm8IkSwtBlDs8f08Chogp6iM40tAmOO3+l9bWfELea6Z1M3qeLPjSeGMLfDoP
         Ky+sdx4pCdqhXZRA0RVg9YQQds2CJJlEDyP6tTSqeqIS6Ut4fM3+w9JSx0/apa4WJJFI
         XjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSAoMPL7GoXdvi2uqHoiRe+EA22FtKTEJJ1PVxlye2M=;
        b=yrr2BHmN0Xa0AH5TVkefDk5+9A7sYqwC+xbPKZTtUAHf+6i948U+32yx6ky12vT1ZT
         9qgrQ7654ayXWxZXq1lnEScuvKqBsraduQFmXGmk2MB5ZmTnTKJQcsTyYqQ4Hi7Inhv4
         jH0z2HaSWjqE0+20aMMMsUtoozs9y+Uzii4uWmMbfOFLZdFgti3Qx2epa0TUX+/Lb6fj
         ZaM8Ht9nT1sHf5HxdIHbHedYLdhRDtvo1ZBoi5g7R1+RbxLcTFiWvyFRsUW28M/Vjtgg
         14ecF1xkhMSepSwSeLTGixNtSsj8Z+o+x0zZ/To4BTLLHr/Nvycn1j8oMvGHq5OFu9mv
         l7Lg==
X-Gm-Message-State: ANoB5pmmia7LqsDRFBjEBpypsepuBhYU9ell+IiB9uvHSINxYg/b4wV4
        aHzg5bg/IuJbc/LFYoef/o2CeA==
X-Google-Smtp-Source: AA0mqf42bAFjdasxPY2lCmOFI93Ik9+Kku4PHtRgmzeR0hIj/0zBODaqQ3rA85YnXs6vWnHM22hVpw==
X-Received: by 2002:a17:902:8217:b0:186:a5a7:cc3d with SMTP id x23-20020a170902821700b00186a5a7cc3dmr31543252pln.42.1669644879656;
        Mon, 28 Nov 2022 06:14:39 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b00213c7cf21c0sm7679415pjt.5.2022.11.28.06.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:14:39 -0800 (PST)
Message-ID: <427068db-6695-a1e2-4aa2-033220680eb9@kernel.dk>
Date:   Mon, 28 Nov 2022 07:14:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221128033057.1279383-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/22 8:30 PM, Waiman Long wrote:
> Commit 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction
> path") incorrectly assumes that css_get() will always succeed. That may
> not be true if there is no blkg associated with the blkcg. If css_get()
> fails, the subsequent css_put() call may lead to data corruption as
> was illustrated in a test system that it crashed on bootup when that
> commit was included. Also blkcg may be freed at any time leading to
> use-after-free. Fix it by using css_tryget() instead and bail out if
> the tryget fails.
> 
> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  block/blk-cgroup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 57941d2a8ba3..74fefc8cbcdf 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1088,7 +1088,12 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>  
>  	might_sleep();
>  
> -	css_get(&blkcg->css);
> +	/*
> +	 * If css_tryget() fails, there is no blkg to destroy.
> +	 */
> +	if (!css_tryget(&blkcg->css))
> +		return;
> +
>  	spin_lock_irq(&blkcg->lock);
>  	while (!hlist_empty(&blkcg->blkg_list)) {
>  		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,

This doesn't seem safe to me, but maybe I'm missing something. A tryget
operation can be fine if we're under RCU lock and the entity is freed
appropriately, but what makes it safe here? Could blkcg already be gone
at this point?

-- 
Jens Axboe



Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EA0FA3742
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJ1SvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJ1SvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 14:51:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46B1D0676
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 11:51:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so5586910pls.9
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1N9w5Dn2FsYw8/f+nSwItPHZtomHuCdmxaBA/vYHXk=;
        b=hRIXlERU42sAphGt8ct9wE4oEYdatMqKJIa3PfnOZ46AuoizXjltzsg4WvQuEhVnrE
         4mMVel3tJ44bNhJomGtrwhk0QHPfxs+viH5e2z1JZ+gZSosbfowSsbaybq3SjWbLaof2
         /2DfyTasqYYIduSF2CrTM9A239PgVbUrTDQ67UT/Rcr3lHE2LN5PINGw4/GURZ3iPIQn
         E0OtqHYs7vLxfxD4g+sPIg/NMj/HaAlXxMwLtfySc2bBLWVEAFl/xz/bfSK6F6PL5pa0
         TsP1Q6l/rHH4oFO9qjgrxKkL7IbChfp012l1gF5IOWRQ3ba5H57lVIeEJDM4Ri3tOpc8
         3UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1N9w5Dn2FsYw8/f+nSwItPHZtomHuCdmxaBA/vYHXk=;
        b=gbm5408ynalcqpDiy/YQrW8V0XaJOZlRPif4EoJ1KYi8PTTwfjOx8LBSGtXyMnR+de
         AXQ6ctHTY9YvNtUTRlSRhf4xqccM7t478Ce5Uuq0rOlYZ7/HrfUcjFU0epj+z1rNcMQi
         LAZG8T3ZqaHALNG08GjgB9enRsg+Og0cQ0xNyu3NU8RTXHteEFgdxDsoqUGLNL0bwnXL
         hZVOjjBCK9DdBcrptw2s0+TU8VTJx5osVLaZr8e8NshA7MDg7t5C0g3lVf1z/a7QSyiO
         CZlou+nPscNOXuvEjIaJ8egWkqrsMJchJ2FEnc8+ztgptz7gNcpHRBGEF1JMkukBqcy3
         Tptw==
X-Gm-Message-State: ACrzQf0LP0By9GldC8AgmG1BF6ZcJRttDvLkPzkanREMZuCkD6Op9g6M
        kP5uDHRm7cZxZOrCHMRyHoTK5A==
X-Google-Smtp-Source: AMsMyM5z/IGhq9nr+vusRPE0QAt2jiUpmaeL87/e6HLkVWDlUA+pEi4RP1x8RObG15YUwNjR6vlogw==
X-Received: by 2002:a17:90b:378a:b0:213:803d:3389 with SMTP id mz10-20020a17090b378a00b00213803d3389mr8929350pjb.115.1666983061869;
        Fri, 28 Oct 2022 11:51:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a4b0c00b0020dd9382124sm4481080pjh.57.2022.10.28.11.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 11:51:01 -0700 (PDT)
Message-ID: <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk>
Date:   Fri, 28 Oct 2022 12:51:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn and
 max_pfn wrong way
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <Y1wZTtENDq3fvs6n@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1wZTtENDq3fvs6n@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 12:02 PM, Al Viro wrote:
> 	We have this:
> 
> static inline bool blk_queue_may_bounce(struct request_queue *q)
> {
>         return IS_ENABLED(CONFIG_BOUNCE) &&
>                 q->limits.bounce == BLK_BOUNCE_HIGH &&
>                 max_low_pfn >= max_pfn;
> }
> 
> static inline struct bio *blk_queue_bounce(struct bio *bio,
>                 struct request_queue *q)
> {
>         if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
>                 return __blk_queue_bounce(bio, q);
>         return bio;
> }
> 
> Now, the last term in expression in blk_queue_may_bounce() is
> true only on the boxen where max_pfn is no greater than max_low_pfn.
> 
> Unless I'm very confused, that's the boxen where we don't *have*
> any highmem pages.
> 
> What's more, consider this:
> 
> static __init int init_emergency_pool(void)
> {
>         int ret;
> 
> #ifndef CONFIG_MEMORY_HOTPLUG
>         if (max_pfn <= max_low_pfn)
>                 return 0;
> #endif
> 
>         ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
>         BUG_ON(ret);
>         pr_info("pool size: %d pages\n", POOL_SIZE);
> 
>         init_bounce_bioset();
>         return 0;
> }
> 
> On the same boxen (assuming we've not hotplug) page_pool won't be set up
> at all, so we wouldn't be able to bounce any highmem page if we ever
> ran into one.
> 
> AFAICS, this condition is backwards - it should be
> 
> static inline bool blk_queue_may_bounce(struct request_queue *q)
> {
>         return IS_ENABLED(CONFIG_BOUNCE) &&
>                 q->limits.bounce == BLK_BOUNCE_HIGH &&
>                 max_low_pfn < max_pfn;
> }
> 
> What am I missing here?

I don't think you're missing anything, the case we need it for is when
max_pfn > max_low_pfn. I wonder when this got botched? Because some
of those statements date back probably about 20 years when we started
allowing highmem pages to do IO.

-- 
Jens Axboe



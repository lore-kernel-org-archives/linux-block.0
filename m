Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BF0C433F5
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418596109F
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhIGOiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhIGOiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:38:15 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4FFC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:37:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b7so13126872iob.4
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/S6NVKS+rAl9aR4n3SE5uAuU4aZe4mciq8781mBYsjY=;
        b=VOSgUj1wc8knZeRVbNf3FAbpUzXJwSywrL5pYnfp/MjmVmoTrq28kVxU5DqwyIILlZ
         DT2SMXaXjzmzG4AZ7rXZwgKHeXg8KqB4S3W/w36ws2XAxAswl50Xo3REg9dt+BN3TdLW
         lmBD1A+fLx4oLlSeJVpuaGEhe/i+1snel97IOVR21KRTIlS3aFXdtIaNnIxXygIZbgXV
         cmC9VAeQ7K4sFJwKTadlgI46iF7/Uk2OrUEcLBQDiUGlQJbAu2htDS0OpSjh9tCcX0Y/
         YnCYlMXiUrsklhsGY+zQCX5/Z4Odevd6KG+8Eq5B0+D8gagDAARC/GOuTv9KYRdH0Hjx
         kzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/S6NVKS+rAl9aR4n3SE5uAuU4aZe4mciq8781mBYsjY=;
        b=G/RYoqXlWJSifcrGLAoCfHGOhQIRCt+MSArwOIX0g2ghpYWg81B/9OG7jbDHe1OA7S
         +yhHJXIL1qMA5TkdTCn1holtalCjXT5gJNjXrI/d17LLbnoGvMQKqFvNSDzT4sYChrT2
         UisE6/B1EKEg+Vu2gHbbtrrPIU8jw/zIsFkXi2A5971Qa1G+p6u8aGaiJtm/LR0klHnr
         1oXfwbW0/yY9voLgoiIpWDd7UY6NHZEC2ivCcXWoEQ6BxG14rrI66Tmis/TZr+PMUh+Y
         jZfqR/S9GNvQYJMd1jaUr9i0rOJvadU8t31U4mJAxXo9F7d78UT+DMsKM1SrkLJ7+xvr
         ByFQ==
X-Gm-Message-State: AOAM533vGb/BQCJMSA56a5CPg4YmxH47c/ao3FqzSilfLn+m9SqnDPA/
        Z8x6p8qzVKbYRPVYiYOH7BkJvQ==
X-Google-Smtp-Source: ABdhPJxCFz1RVkSXmkxnoFMSLRVGtw+KyJ9h6cFRIdCUSz6PRJxUpW/2mXD2QFUHzuf5zVNN1O6PoQ==
X-Received: by 2002:a5e:da44:: with SMTP id o4mr13768582iop.147.1631025428502;
        Tue, 07 Sep 2021 07:37:08 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u17sm6343646iln.81.2021.09.07.07.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:37:07 -0700 (PDT)
Subject: Re: [PATCH] blk-throttle: fix UAF by deleteing timer in
 blk_throtl_exit()
To:     Li Jinlin <lijinlin3@huawei.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        louhongxiang@huawei.com
References: <20210907121242.2885564-1-lijinlin3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f962850-06d6-f50b-2c2f-e6d5bfd3823a@kernel.dk>
Date:   Tue, 7 Sep 2021 08:37:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210907121242.2885564-1-lijinlin3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 6:12 AM, Li Jinlin wrote:
> From: Li Jinlin <lijinlin3@huawei.com>
> 
> The pending timer has been set up in blk_throtl_init(). However, the
> timer is not deleted in blk_throtl_exit(). This means that the timer
> handler may still be running after freeing the timer, which would
> result in a use-after-free.
> 
> Fix by calling del_timer_sync() to delete the timer in blk_throtl_exit().

Applied, thanks.

-- 
Jens Axboe


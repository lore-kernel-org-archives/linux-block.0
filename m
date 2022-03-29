Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503FC433FE
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 12:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiC2M5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiC2M4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 08:56:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339F5A08E
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:53:45 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j8so7350477pll.11
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H+yRyS1d98IcrBQFZB9iiSX2T4SDFA0//etts+xx4xA=;
        b=1pslRGrN6XglfZNraIDgwb+dTS7GLxRkQPZso9STUANxT6OprvFvoXCs5iZNULpR+X
         amHu9WaFS3xEGBVG+qwC1n7q2SOLW1qXN4uKS0gPJiWtH5bbuHalsJO9KyAv5GMzRmRT
         WwWlDk3b5j8H3ktTMVhPx7RxJqyNOqGzv30XJPiMBXhljWX3fsk40rvcHardjHedTUyK
         tXJjoRd53F/qbrbOHJrcr2ArcRtahOEeQDvSQVejEOQzxE59PylUdAPyhRLD0JqW2kmz
         cpfacwGZu5igPX9MWCW+vuY6aI46qjOswKbR/AmoLN4yE+SnQ2+HJrcwDq9cd9hZC0eG
         c11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H+yRyS1d98IcrBQFZB9iiSX2T4SDFA0//etts+xx4xA=;
        b=HI3bYP1cThfSGLDSBdEmIUqbqzhHwnPE//6GUncfRArSlm0oCwsjpVLar8d3q7rFdK
         tfylSo/k2dQT/ZzRNiJYhnZzY+KI3eEyMoL27fSWnliR8J57cWGRMsvb7X2KB6N1LsHy
         9hpBishkb9NYPoKOL8s3NiCA290okLpyxUf6gVec1vhDo8V36h60Ur8HNJAee9abutOv
         OW09a0mD0oB+HgBTKJIVEMpzooQlkTdTc4VdzYbpe5T8v7knbN4Giji9uhJ7jy8xtRPK
         uoZ5HOfZUm6tQ9IeARgvMFpVUMu24MhTtZlTkfk8JE+I3VxHINA8+xbgXi0h3RMmj9m0
         thlw==
X-Gm-Message-State: AOAM530XpMjgtCX6vNgRGXs6vEfs9ZBBlTpIJPCMkuA9ihLVWfKv9YYv
        IMAQTsT2T2AIdHd6szJdv8qaQg==
X-Google-Smtp-Source: ABdhPJxmIuKDNw+xtyBa2P/G7A0/9sbdJw2K8K/UeRrneWzIe0Wxgn+sqcZQ74rLrruxtnUkjbRnug==
X-Received: by 2002:a17:902:f70f:b0:153:ebfe:21b3 with SMTP id h15-20020a170902f70f00b00153ebfe21b3mr30462409plo.119.1648558425372;
        Tue, 29 Mar 2022 05:53:45 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm5730641pgc.80.2022.03.29.05.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:53:44 -0700 (PDT)
Message-ID: <a3e78af2-b0e3-9a97-5bbd-4bdbc5c5a58d@kernel.dk>
Date:   Tue, 29 Mar 2022 06:53:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC 0/6] improve large random io for HDD
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220329094048.2107094-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220329094048.2107094-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/22 3:40 AM, Yu Kuai wrote:
> There is a defect for blk-mq compare to blk-sq, specifically split io
> will end up discontinuous if the device is under high io pressure, while
> split io will still be continuous in sq, this is because:
> 
> 1) split bio is issued one by one, if one bio can't get tag, it will go
> to wail. - patch 2
> 2) each time 8(or wake batch) requests is done, 8 waiters will be woken up.
> Thus if a thread is woken up, it will unlikey to get multiple tags.
> - patch 3,4
> 3) new io can preempt tag even if there are lots of threads waiting for
> tags. - patch 5
> 
> Test environment:
> x86 vm, nr_requests is set to 64, queue_depth is set to 32 and
> max_sectors_kb is set to 128.
> 
> I haven't tested this patchset on physical machine yet, I'll try later
> if anyone thinks this approch is meaningful.

A real machine test would definitely be a requirement. What real world
uses cases is this solving? These days most devices have plenty of tags,
and I would not really expect tag starvation to be much of a concern.

However, I do think there's merrit in fixing the unfairness we have
here. But not at the cost of all of this. Why not just simply enforce
more strict ordering of tag allocations? If someone is waiting, you get
to wait too.

And I don't see much utility at all in tracking how many splits (and
hence tags) would be required. Is this really a common issue, tons of
splits and needing many tags? Why not just enforce the strict ordering
as mentioned above, not allowing new allocators to get a tag if others
are waiting, but perhaps allow someone submitting a string of splits to
indeed keep allocating.

Yes, it'll be less efficient to still wake one-by-one, but honestly do
we really care about that? If you're stalled on waiting for other IO to
finish and release a tag, that isn't very efficient to begin with and
doesn't seem like a case worth optimizing for me.

-- 
Jens Axboe


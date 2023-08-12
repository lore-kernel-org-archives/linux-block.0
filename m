Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0388C001B0
	for <linux-block@archiver.kernel.org>; Sat, 12 Aug 2023 13:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHLNes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Aug 2023 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Aug 2023 09:34:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E384E5F
        for <linux-block@vger.kernel.org>; Sat, 12 Aug 2023 06:34:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f74a8992so498916b3a.1
        for <linux-block@vger.kernel.org>; Sat, 12 Aug 2023 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691847290; x=1692452090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu6KYCTe3yYV+vjD7U9dsfBkqKtCevBqbtEfY4AodYs=;
        b=vgi9tpHvmPpSDbFGy6DqAGQh4+ePr41OZKekFkPcbZ+gCbQud6GMIL4bXNWm1rG9UD
         vOv2Odm8719ixKdi4QDjO0Iilweec8ic3O48BuH63MHZNHDPsMmlW6142m4JuVJAFeiq
         GO+KgxkHbV1b4pO+Q8Udb7KWG7npl2uuxIe1ZhQAzVrMWTpqren0W8aKz60b1yW5LIdx
         0tUcUCOK5SGHIo9OL0sxX3AZ8AZnx/TbC4gFvywiXbQgjMAF7mjCAty2DHfjGIq5OYUF
         m6YW4mZh0+eYukwyZsE69r7WeRS/HcKPJH5YLs6kSuqb8FuBiL7ape57rq9XBdc7dkmR
         R1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691847290; x=1692452090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu6KYCTe3yYV+vjD7U9dsfBkqKtCevBqbtEfY4AodYs=;
        b=hkDXdXtux4AfLrfmtR9xTc9y15dX4biaLfThCdcdIOyowKjtT8XG+xISBqr8h5KkZz
         Jm9057Lnf6IVHqm7u5rqL04emW6g3txI6abZP0WVK/zuK5QdskF5hbPWI58PqvePbbuN
         5PaJRlDpt7AJ45XIx4wSIlOwjcxN9PvSfiugsS9a9Pzjh3DVlgWOC6kiDGNwUbYhJvWk
         TVCMhsPx9z0oZg3Jano65uwI5Qdi8nfb4DQIoup8yHaNR5M0TOqGE3/aGkW1I/jBvRJR
         PVZ5/ObIZS7UngbpkTufvDN+N2Nn2iNfK+AbTmVwhTQmzuXqaTV4KuiLExSunFOCA1pD
         CgCw==
X-Gm-Message-State: AOJu0Yxu65YT6Er+8w0Q88PJ1bGd6P4elF3LoDgDQaUqyBNlT8AANkIy
        FDzAfuzDyVD6hKeXuEF2nj9hwg==
X-Google-Smtp-Source: AGHT+IHmmp8Sl0831SmcXnwg3VeF7EIfBZyskBepfFEfxDeOUFJ50O0HAMnGzKLfNXsbUN1PIXIZhA==
X-Received: by 2002:a17:903:32c7:b0:1b8:17e8:5472 with SMTP id i7-20020a17090332c700b001b817e85472mr5817852plr.1.1691847289948;
        Sat, 12 Aug 2023 06:34:49 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001b9de67285dsm5845999plb.156.2023.08.12.06.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 06:34:49 -0700 (PDT)
Message-ID: <00c3ae48-98c5-470d-ac0e-6096a06b7086@kernel.dk>
Date:   Sat, 12 Aug 2023 07:34:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org,
        Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     josef@toxicpanda.com, mkoutny@suse.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
 <169176317573.160467.10047297090390573799.b4-ty@kernel.dk>
 <b93e426e-d9b6-34df-be28-90b715c7a711@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b93e426e-d9b6-34df-be28-90b715c7a711@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/23 7:42 PM, Yu Kuai wrote:
> Hi, Jens
> 
> ? 2023/08/11 22:12, Jens Axboe ??:
>>
>> On Thu, 10 Aug 2023 11:51:11 +0800, Li Lingfeng wrote:
>>> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
>>> a mutex named "init_mutex" in blk_iolatency_try_init for the race
>>> condition of initializing RQ_QOS_LATENCY.
>>> Now a new lock has been add to struct request_queue by commit a13bd91be223
>>> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
>>> held in blkg_conf_open_bdev before calling blk_iolatency_init.
>>> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
>>> remove it.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] block: remove init_mutex and open-code blk_iolatency_try_init
>>        commit: 4eb44d10766ac0fae5973998fd2a0103df1d3fe1
> 
> This version has a minor problem that pss in mutex for
> lockdep_assert_held() is not a pointer:
> 
>> lockdep_assert_held(ctx.bdev->bd_queue->rq_qos_mutex);
> 
> should be:
> lockdep_assert_held(&ctx.bdev->bd_queue->rq_qos_mutex);

Yes, looked like that patch didn't get compiled... Shame.

> Perhaps can you drop this patch for now, and Lingfeng can send a v4?

I did fix that up 2 days ago myself.

-- 
Jens Axboe


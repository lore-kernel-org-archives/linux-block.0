Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B6FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1959B611CA
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 17:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhIOR7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOR7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 13:59:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7743C061575
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 10:58:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m11so4577626ioo.6
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOwjbYzeXD/cfrrWWmcbH4Jm4bi4xHQwCqaQ6FZ72ds=;
        b=ksUgv0z/jK1fFxqRkilF0js7nEYkh82ulyizoIIjjlMADlDRxN98LP8vqWZXqOfpUK
         rebMq7gdURQp/KGTbbtu3cj1dg/jPWmMq3LH+IXBQWeI5sbTSNCSMQbadXmNQ4IevXJZ
         4qiXITXxiQDdecLKSYyRoEuQFeBZZCYHTltDeLZ2LhPhcjmWNmHuWBYrO7wuoOAJjk8C
         WI6+DvREQZoXFARaGGcO+aGjvN5QK4bpqHsKiNX9mNgjfkz3+PHsTBLPP6wmDJjvvqxx
         DyTURT5ZDZJyRXsp8VsxQylRyTN+12LCG83wNy3h9wOX08uKegm2RfsPDzkV5vXYOe8B
         vS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOwjbYzeXD/cfrrWWmcbH4Jm4bi4xHQwCqaQ6FZ72ds=;
        b=sOpT60r8zaTlVXxASh/6RRhRy0+c2YaWp0PdzANB/WjktinKRzvwhm9KnluZ2nDIwg
         PMb+5jnHNaL/Iyqtu0S7GsX2eKD9vcWNprR2IvjlmfH6XXT9NBZP34aoA0WJfaAMoqvZ
         h2sWBUuOJaO41eU5NWZUezHX5RGO+EU4Yf9Eg7nU1cKgzzuebKdTwd25cOxHMAKq0pWP
         Ojq84JNFCkiXkZrrZSytYzyn5aa7NZMU/V0XIdlAZc+DAAs3bYGyfFoaInZwEyg2SzV/
         B9rRD39oiBLOSpHh0BE2UNHYdjcYpRzq2a6txNG7mgHGVCESCKQOGcIpKQXkbTO0ASJ+
         Kr8Q==
X-Gm-Message-State: AOAM531DsTEJytT9MtyQuWaUThLbrSwtLCQX62p/28/9dTH11NR0Nsz5
        Q27lt2uzmfoBaEJY2e4/kdfrbw==
X-Google-Smtp-Source: ABdhPJzPPThW3ISQZYCmaCPGxqexmco/UmMS5KLRar/rZQJrYtCxsoQ9xoUCuBaRinX0DsZZeFiaJA==
X-Received: by 2002:a05:6602:1696:: with SMTP id s22mr1106420iow.198.1631728690936;
        Wed, 15 Sep 2021 10:58:10 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z16sm331378ile.72.2021.09.15.10.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 10:58:10 -0700 (PDT)
Subject: Re: [PATCH] blkcg: fix memory leak in blk_iolatency_init
To:     Yanfei Xu <yanfei.xu@windriver.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20210915072426.4022924-1-yanfei.xu@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db4a41c9-9ba6-ea8e-8ebe-cf292d796308@kernel.dk>
Date:   Wed, 15 Sep 2021 11:58:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210915072426.4022924-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/15/21 1:24 AM, Yanfei Xu wrote:
> BUG: memory leak
> unreferenced object 0xffff888129acdb80 (size 96):
>   comm "syz-executor.1", pid 12661, jiffies 4294962682 (age 15.220s)
>   hex dump (first 32 bytes):
>     20 47 c9 85 ff ff ff ff 20 d4 8e 29 81 88 ff ff   G...... ..)....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff82264ec8>] kmalloc include/linux/slab.h:591 [inline]
>     [<ffffffff82264ec8>] kzalloc include/linux/slab.h:721 [inline]
>     [<ffffffff82264ec8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
>     [<ffffffff8225b8c4>] blkcg_init_queue+0xb4/0x1c0 block/blk-cgroup.c:1185
>     [<ffffffff822253da>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:566
>     [<ffffffff8223b175>] blk_mq_init_queue_data block/blk-mq.c:3100 [inline]
>     [<ffffffff8223b175>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3124
>     [<ffffffff826a9303>] loop_add+0x1c3/0x360 drivers/block/loop.c:2344
>     [<ffffffff826a966e>] loop_control_get_free drivers/block/loop.c:2501 [inline]
>     [<ffffffff826a966e>] loop_control_ioctl+0x17e/0x2e0 drivers/block/loop.c:2516
>     [<ffffffff81597eec>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff81597eec>] __do_sys_ioctl fs/ioctl.c:874 [inline]
>     [<ffffffff81597eec>] __se_sys_ioctl fs/ioctl.c:860 [inline]
>     [<ffffffff81597eec>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
>     [<ffffffff843fa745>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff843fa745>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Once blk_throtl_init() queue init failed, blkcg_iolatency_exit() will
> not be invoked for cleanup. That leads a memory leak. Swap the
> blk_throtl_init() and blk_iolatency_init() calls can solve this.

Applied, thanks.

-- 
Jens Axboe


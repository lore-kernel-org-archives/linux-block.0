Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AA7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB20611C4
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhIOM5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhIOM5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 08:57:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221CC061574
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 05:56:18 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b200so3217291iof.13
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DS0GjgMKbFMDMeAyVEvE1w5PgFNCaKSeyKWG/M6E9ro=;
        b=ash+W33rvxke9ncXM/dJgQwJhyNcv9DhLdsY1qOerTxBGbFw7t3sWrVK6X0RSyIMD2
         kdMb7OLraR3sCgRUzJjX+kekRJYcfNdeotdSj91bf1pVqhlpEvOBxsjJNe6d7DUJKivf
         eRQ4BgNOCTkEQaz4ekyUQS2fAtg4tYAPjjtVOEuaoPnOC8qXidRRtf0zV9jVR7diNX2h
         9F5KaxBKgZ8kpj4uml1OHjVcBUJIQX43FCDkSL4uN8YBuJVQ5yaMZ1ISWwHecpoIQy67
         qtC1Z7HViIQg2IyC4jK1dc5IRuEmZkf2AGOyoaAFXHJWZgTTAA6bMRPj4htXt72Kpuk4
         i2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DS0GjgMKbFMDMeAyVEvE1w5PgFNCaKSeyKWG/M6E9ro=;
        b=JEQt+2snZ2IOxVkmGZ/pSn+5KW7Ovljr3lTMqKSQYG9JOUXn6M87rw325MMeZJafP5
         4hIS7ZQg4vsdfUnNm4GhQtA7a0lT46mz+TPyCINoyHZL0sIdSoGcYz7TixUZulgnLuZC
         QFtifg5pfgwGZlKJ4YrGjQEfKjByymYh65qhxsl475tZY1pxNg+QW/5FxDMWIcRNq/yP
         pMdhGvY4Q4PPYAkCIbpcd+Bx3emhYLie/HXJ712XTbLYk6cOWQtQBF8z9UqlHKxbqYFn
         g4czguV3Zh9mTtwiooZBGOzojWpXrxxB7Q2qZ0oa+3lISwxl2k95nSP8iyo1CzcibcPd
         QzZA==
X-Gm-Message-State: AOAM532WsKjh/oKUHu46nVxQkz5BBESQIPp4PPDX+RxXMGkn+XTIaeii
        g8KRe1s4+lUjg64Yy9eLsaYZCrakkU/N1Q==
X-Google-Smtp-Source: ABdhPJz4ocoIOMEZt18ZomIBet6r2hROle35S3Z0bjDeMRrWkjlkns2OmC48DisXZfdShya9xf+ukw==
X-Received: by 2002:a05:6602:730:: with SMTP id g16mr17910992iox.138.1631710577082;
        Wed, 15 Sep 2021 05:56:17 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s10sm8613388iom.40.2021.09.15.05.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 05:56:16 -0700 (PDT)
Subject: Re: bfq - suspected memory leaks
To:     Guoqing Jiang <guoqing.jiang@linux.dev>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
References: <72691728-304b-a80b-5850-92879fffc61a@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <38fc74a9-f748-54b9-d072-d3fa88a3d7d8@kernel.dk>
Date:   Wed, 15 Sep 2021 06:56:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72691728-304b-a80b-5850-92879fffc61a@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/21 10:07 PM, Guoqing Jiang wrote:
> Hi,
> 
> With latest kernel (commit 4ac6d90867a4 "Merge tag 'docs-5.15' of 
> git://git.lwn.net/linux"),
> I got lots of kmemleak reports during compile kernel source code.
> 
> # dmesg |grep kmemleak
> [18234.655491] kmemleak: 1 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [18890.247552] kmemleak: 2 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [19745.602271] kmemleak: 2 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [20390.965851] kmemleak: 4 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [21150.173950] kmemleak: 4 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [21929.951448] kmemleak: 15 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [23589.726859] kmemleak: 2 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [24416.441263] kmemleak: 1 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [30400.835853] kmemleak: 10 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [68673.737862] kmemleak: 2 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [72770.498898] kmemleak: 1 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> [77046.434369] kmemleak: 7 new suspected memory leaks (see 
> /sys/kernel/debug/kmemleak)
> 
> All of them  have similar trace as follows.
> 
>    comm "sh", pid 27054, jiffies 4302241171 (age 47562.964s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 b0 20 02 80 88 ff ff  .......... .....
>      04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00 ................
>    backtrace:
>      [<000000004fa2550b>] bfq_get_queue+0x2a8/0xfd0
>      [<00000000b1757a70>] bfq_get_bfqq_handle_split+0xa4/0x240
>      [<00000000ac263274>] bfq_init_rq+0x1f7/0x1d10
>      [<00000000110283e1>] bfq_insert_requests+0xf7/0x5f0
>      [<000000002ed06e79>] blk_mq_sched_insert_requests+0xfe/0x350
>      [<000000000ebf38ac>] blk_mq_flush_plug_list+0x256/0x3e0
>      [<00000000bc647b2b>] blk_flush_plug_list+0x1ff/0x240
>      [<000000004e7e49f8>] blk_finish_plug+0x3c/0x60
>      [<000000008802f1e4>] read_pages+0x28f/0x580
>      [<000000009986d1f4>] page_cache_ra_unbounded+0x266/0x3a0
>      [<00000000492c494f>] filemap_fault+0x8a8/0xfe0
>      [<000000009cbd8d38>] __do_fault+0x70/0x150
>      [<000000002740a35f>] do_fault+0x112/0x670
>      [<00000000a74facab>] __handle_mm_fault+0x57e/0xcc0
>      [<0000000024009667>] handle_mm_fault+0xd6/0x330
>      [<00000000fb1e0780>] do_user_addr_fault+0x2a9/0x8b0
> unreferenced object 0xffff888021e5dd90 (size 560):

Paolo, are you on top of this one?

-- 
Jens Axboe


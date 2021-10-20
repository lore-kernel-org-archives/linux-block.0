Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B205C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9FF610E6
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhJTAZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhJTAZD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 20:25:03 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9B4C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 17:22:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l7so6936776iln.8
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nufXn2m9QrswO7GsvsPS2w4ZnvIpsXIW5e/QFsteCQs=;
        b=eXGVa7uj64uHmjtgH+yEoEoheTGTeHuCjMC3RZAOQD/EAGBOH0whSXb1ShOBxiv8yw
         YtjcMSSia85/9X6roXVJZ+xjn0Lh2XrvrAMB5W4divqyXd+IWSG0oFB0o2GeVfil/3ag
         HAvPD8AgzE895cAHilWhrjUB02JA1y9Ue/KEUz7ZtW6BxUoCUeHDzOdeR3LAMrgJI2YC
         NsX6/+ucTskH7JXd9qNHkdijWr/khbI0mQ4tM+zbK9SoX57RvZg9iQXMvBQ2gZjvtbM9
         LRFTi7PG+h+VlC9N5o84aDxUo5U2CARX0iOwTbVB2QXoVuli2/+1OxHcERIpTs5kjQ8H
         zj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nufXn2m9QrswO7GsvsPS2w4ZnvIpsXIW5e/QFsteCQs=;
        b=kfrG1whQR0pwS8OMJqt0Phzb0/IH4VeGWNsDyId6lkObNcgk9xZpfJAJ1EC+By5LfR
         5dk+lfyFI6OnwaKuFBY65x7rRqxPnscjP+y5s+Vy1y+bOP2ABjmDtPQWPup8fbKV9QIJ
         wGw7B0yG6TZz+FPTkSL6+D8fJZY5aw8z00zRxwlcBk4MeeteVtH0JSd0SvR40ENoL1c+
         lEcoykZTmC8T4BFahw1FRwOsiSXs17rRgYk3g8BVmG/WA3lofauTnYXvpvSY5ekk7Cly
         6aAreCRlrd16lyKH2XbqTG09cL5RSzEjR+BZ+Kp77Qt9LpuVfYQ0Bta+SF/pA6ByxVVR
         QD1w==
X-Gm-Message-State: AOAM532U13GNMpyBCEcyS9TYKgRUCX27GAi/BgB0pksrjhQcElg7fxHL
        XL8VMshfz6+gScsjM47RDRg/3KruYQl7OA==
X-Google-Smtp-Source: ABdhPJy89A657N6BNg2XtIwwD5rEc0Dt5MnnDGZZXqB702nuOvvQDvrw6ukDY458tlQty4Y6yYTgyQ==
X-Received: by 2002:a05:6e02:1c2b:: with SMTP id m11mr20988764ilh.307.1634689369298;
        Tue, 19 Oct 2021 17:22:49 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u12sm293124ioc.33.2021.10.19.17.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 17:22:48 -0700 (PDT)
Subject: Re: [PATCH 00/16] block optimisation round
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <163468930893.717031.16208964380009227106.b4-ty@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c12908a-9501-6a35-b48d-5635e2825874@kernel.dk>
Date:   Tue, 19 Oct 2021 18:22:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <163468930893.717031.16208964380009227106.b4-ty@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 6:21 PM, Jens Axboe wrote:
> On Tue, 19 Oct 2021 22:24:09 +0100, Pavel Begunkov wrote:
>> Jens tried out a similar series with some not yet sent additions:
>> 8.2-8.3 MIOPS -> ~9 MIOPS, or 8-10%.
>>
>> 12/16 is bulky, but it nicely drives the numbers. Moreover, with
>> it we can rid of some not used anymore optimisations in
>> __blkdev_direct_IO() because it awlays serve multiple bios.
>> E.g. no need in conditional referencing with DIO_MULTI_BIO,
>> and _probably_ can be converted to chained bio.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/16] block: turn macro helpers into inline functions
>         (no commit info)
> [02/16] block: convert leftovers to bdev_get_queue
>         (no commit info)
> [03/16] block: optimise req_bio_endio()
>         (no commit info)
> [04/16] block: don't bloat enter_queue with percpu_ref
>         (no commit info)
> [05/16] block: inline a part of bio_release_pages()
>         (no commit info)
> [06/16] block: clean up blk_mq_submit_bio() merging
>         (no commit info)
> [07/16] blocK: move plug flush functions to blk-mq.c
>         (no commit info)
> [08/16] block: optimise blk_flush_plug_list
>         (no commit info)
> [09/16] block: optimise boundary blkdev_read_iter's checks
>         (no commit info)
> [10/16] block: optimise blkdev_bio_end_io()
>         (no commit info)
> [11/16] block: add optimised version bio_set_dev()
>         (no commit info)
> [12/16] block: add single bio async direct IO helper
>         (no commit info)
> [13/16] block: add async version of bio_set_polled
>         (no commit info)
> [14/16] block: skip advance when async and not needed
>         (no commit info)
> [15/16] block: optimise blk_may_split for normal rw
>         (no commit info)
> [16/16] block: optimise submit_bio_checks for normal rw
>         (no commit info)

Sorry, b4 got too eager on that one, they are not applied just yet.

-- 
Jens Axboe


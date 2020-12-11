Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70695C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C8C23C18
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390711AbgLKBso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390682AbgLKBsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 20:48:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B8C0613D3
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 17:47:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a6so6268833wmc.2
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 17:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXCLaSS3UgIEFJ4EKeT932UkskOkZdXPBcpSMViITr8=;
        b=jvHM7NoItCIambM+JYyfcUZEJm0AtiRV0RuaocuCX7dkE42x/ak85HooWrwx/Q5ATB
         PyUb6d23YwtODG41HEGPJTs0B+SCnu6MSyT4S2VLTm9izD8+XlIl8YgxOjlE76033/V3
         FaG9EWuTZRcaq5BHSv1Kq3NxF1NhYS/5D1uL6i7U+SCttfAXZZS5g/AGJbwXNCagsVPz
         ZmoplPI4M9aPQlbjwWXgvUS2Q30UY0jxmFDou9XlaomVXGEvxXArdUuge0/i9g2va1K1
         uRoZKsVRj++Km9+Gc/JzDxeQGloT5gaijAEwZzI4qzPuWc8PK8MBAgPr0Zqi1IBIKewT
         JPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gXCLaSS3UgIEFJ4EKeT932UkskOkZdXPBcpSMViITr8=;
        b=Kw++Xeua5U+lugObufoL9WtsrbWK68ipiDZDIIEQR+2Z1YkOvTCe0O6n/kRVtLbXwh
         Hlio945HLdfu1Y2RWKPVsY497YtghDs3GsZoX1dcT4wR+7cXB+UARfkvSz36bHRec9wf
         n5lu/CoZ1oTz31m78IDYsxVUEKL1okWWy3+sqiEPOdqWeM60NN5UgQ56FStWeFiZxmOb
         yRcP5gYk9jA1X+k1URFwp6dXLf0D4uGjqv0GlorrR2z+H44t+jymePO74KT1uEhQa6t6
         pvCPObv/gWJVaEr2CchLTfcWlWBQGDOJf77FyYJCWo9CpZ5+6D2VjfGonHe3P1DNC5cB
         W/3A==
X-Gm-Message-State: AOAM532Yf1i0/ERWZQj/Br3OM3Ku9H28qkm6+KVV8QtHk6hR/oE7ggvO
        OuMJ5W9oSAmWVtuS0pdFw3VrQFgHZD83IA==
X-Google-Smtp-Source: ABdhPJxTWZXoamQKkSuyUkR71auZAGH/TFU1GhkNFbHyorrtU0YdfHCgPTV4RDfjmS73XtOzAPUzUA==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr10757531wmg.158.1607651274758;
        Thu, 10 Dec 2020 17:47:54 -0800 (PST)
Received: from [192.168.8.123] ([185.69.144.17])
        by smtp.gmail.com with ESMTPSA id a144sm11876743wmd.47.2020.12.10.17.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 17:47:54 -0800 (PST)
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
Date:   Fri, 11 Dec 2020 01:44:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/2020 01:19, Andres Freund wrote:
> On 2020-12-10 23:15:15 +0000, Pavel Begunkov wrote:
>> On 10/12/2020 23:12, Pavel Begunkov wrote:
>>> On 10/12/2020 20:51, Andres Freund wrote:
>>>> Hi,
>>>>
>>>> When using hybrid polling (i.e echo 0 >
>>>> /sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
>>>> an iodepth > 1. Sometimes fio hangs, other times the performance is
>>>> really poor. I reproduced this with SSDs from different vendors.
>>>
>>> Can you get poll stats from debugfs while running with hybrid?
>>> For both iodepth=1 and 32.
>>
>> Even better if for 32 you would show it in dynamic, i.e. cat it several
>> times while running it.
> 
> Should read all email before responding...
> 
> This is a loop of grepping for 4k writes (only type I am doing), with 1s
> interval. I started it before the fio run (after one with
> iodepth=1). Once the iodepth 32 run finished (--timeout 10, but took
> 42s0, I started a --iodepth 1 run.

Thanks! Your mean grows to more than 30s, so it'll sleep for 15s for each
IO. Yep, the sleep time calculation is clearly broken for you.

In general the current hybrid polling doesn't work well with high QD,
that's because statistics it based on are not very resilient to all sorts
of problems. And it might be a problem I described long ago

https://www.spinics.net/lists/linux-block/msg61479.html
https://lkml.org/lkml/2019/4/30/120


Are you interested in it just out of curiosity, or you have a good
use case? Modern SSDs are so fast that even with QD1 the sleep overhead
on sleeping getting considerable, all the more so for higher QD.
Because if there is no one who really cares, then instead of adding
elaborated correction schemes, I'd rather put max(time, 10ms) and
that's it.

> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> 
> Shortly after this I started the iodepth=1 run:
> 
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
> write (4096 Bytes): samples=1, mean=2216868822, min=2216868822, max=2216868822
> write (4096 Bytes): samples=1, mean=2216868822, min=2216868822, max=2216868822
> write (4096 Bytes): samples=1, mean=2216851683, min=2216851683, max=2216851683
> write (4096 Bytes): samples=1, mean=1108526485, min=1108526485, max=1108526485
> write (4096 Bytes): samples=1, mean=1108522634, min=1108522634, max=1108522634
> write (4096 Bytes): samples=1, mean=277274275, min=277274275, max=277274275
> write (4096 Bytes): samples=19, mean=5787160, min=5496432, max=10087444
> write (4096 Bytes): samples=1185, mean=67915, min=66408, max=145100
> write (4096 Bytes): samples=1185, mean=67915, min=66408, max=145100
> write (4096 Bytes): samples=1185, mean=67915, min=66408, max=145100
> write (4096 Bytes): samples=1703, mean=50492, min=39200, max=13155316
> write (4096 Bytes): samples=9983, mean=7408, min=6648, max=29950
> write (4096 Bytes): samples=9980, mean=7395, min=6574, max=23454
> write (4096 Bytes): samples=10011, mean=7381, min=6620, max=25533
> write (4096 Bytes): samples=9381, mean=7936, min=7270, max=47315
> write (4096 Bytes): samples=9295, mean=7377, min=6665, max=23490
> write (4096 Bytes): samples=9987, mean=7415, min=6629, max=23352
> write (4096 Bytes): samples=9992, mean=7411, min=6651, max=23071
> write (4096 Bytes): samples=9404, mean=7941, min=7234, max=24193
> write (4096 Bytes): samples=9434, mean=7942, min=7240, max=62745
> write (4096 Bytes): samples=5370, mean=7935, min=7268, max=24116
> write (4096 Bytes): samples=5370, mean=7935, min=7268, max=24116
> write (4096 Bytes): samples=5370, mean=7935, min=7268, max=24116

-- 
Pavel Begunkov

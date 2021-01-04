Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B342C433E6
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D5A2242A
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 15:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhADPui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 10:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbhADPuh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 10:50:37 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A0C061794
        for <linux-block@vger.kernel.org>; Mon,  4 Jan 2021 07:49:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id i18so25397043ioa.1
        for <linux-block@vger.kernel.org>; Mon, 04 Jan 2021 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7bOrj5NFbfU1iaPecOwGPerPa2nhKULyJEWIuFehYmw=;
        b=xyZIk+992U8/YXmiwIKamGonVEXvXbHSCAMUo+TIB36irYZ9fZFs5iY1sQKpnAVbsE
         YNB3/N29ZZH2n4v15khcuxwBYStdLNKFSBRQrDY1IUAAgtGJRGC4P/DRCuQSdvH3BcgG
         Zi0Bx10TWb/CovJBVsqVjHltBmTrWs8l/VxN6++WpWzXEQl+iRJC35AzNG4si5FExg/H
         A7bVVo/nvA9mo2vwgMPR6a5XYwum2Gu3BfAZ4b4RGqs2aCl7ksQ0SqLKcoV/EKSzfxGf
         C8s//xHCYHJSHNZccQfU9eofVI+4D32Esw5YOMh/ow7FTdia7sq7hekwCOJ7nvx1W3Kq
         mYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7bOrj5NFbfU1iaPecOwGPerPa2nhKULyJEWIuFehYmw=;
        b=Dxe300h3PjWKezJ9bcCQvmy/ZldxYfVx7tgL5LXuggTUlBfSNSOlhP+IZ8jcl6GXdA
         2e95C2lCab8RBTcai25FjymRlILfq8P8L87Rgh6ROHXz4AUJTIDfM1D/tfC62rOG/r+w
         8rMUnsrCIqQLrVcT+cv9zskp+gK7OGdbA90OWVbYI71BDmXebTgdBw3JKZMHEfQrwuZC
         NHmdFqmI5w8vxbYueBUtNc0LLQ9Z9RvflTk4hLuDp0BZOTDbVmJcJ6qUwxGXOcM+qwYF
         GJHI7vrrcibzI32kQLz3Elb+htqjZ9Mi9fbuaSayXGgzeYECKdJLArqijIXeVQHZcffX
         L5ow==
X-Gm-Message-State: AOAM530jFFy6j/imtGIQDOrObN40zSBeplczygj2bxhH06THRFC2/G7s
        EI8sA1RxXNHJbDwkY+kluf/vMCVhFu6QWA==
X-Google-Smtp-Source: ABdhPJz0n4DYoHU2SCcDw+S/KYN5yNM5cn1fLfnR7yNSdUYKzuQE3GWviiI8df9AuLHzmLNJaI7ZJA==
X-Received: by 2002:a02:c7d1:: with SMTP id s17mr63236024jao.142.1609775396680;
        Mon, 04 Jan 2021 07:49:56 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t21sm43961096ild.86.2021.01.04.07.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 07:49:56 -0800 (PST)
Subject: Re: [PATCH 6/6] block: Add n64 cart driver
To:     Lauri Kasanen <cand@gmx.com>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-block@vger.kernel.org
References: <20210104155031.9b4e39ff48a6d7accc93461d@gmx.com>
 <944dd5af-c5d0-b37c-29ca-0213ea6081db@kernel.dk>
 <20210104174348.cda010a3af0ec3d989732b37@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db1936b0-a1ab-41b3-be09-ec301ea7ebc3@kernel.dk>
Date:   Mon, 4 Jan 2021 08:49:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104174348.cda010a3af0ec3d989732b37@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/4/21 8:43 AM, Lauri Kasanen wrote:
> On Mon, 4 Jan 2021 08:40:10 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 1/4/21 6:50 AM, Lauri Kasanen wrote:
>>> Signed-off-by: Lauri Kasanen <cand@gmx.com>
>>> ---
>>>  drivers/block/Kconfig   |   6 ++
>>>  drivers/block/Makefile  |   1 +
>>>  drivers/block/n64cart.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 210 insertions(+)
>>>  create mode 100644 drivers/block/n64cart.c
>>>
>>> block folks: rest of the series is on linux-mips. Being a
>>> mips-specific driver, not sure which tree it should go to.
>>
>> It should definitely get reviewed first. One easy question - there's no
>> commit message in this one. It's a new driver, it should include some
>> documentation on what it is, etc.
> 
> It's already had one (rfc) round on linux-mips. Or do you mean by
> others (who?)

I mean the actual block driver from the block point of view. From
a quick look, looks like there's no irq or anything, so it's
strictly polled mode? Probably would make sense to push this out
of the app path then, by using BLK_MQ_F_BLOCKING.

-- 
Jens Axboe


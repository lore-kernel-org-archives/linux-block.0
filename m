Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647FC4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D3C60FC4
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhHMTJx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTJx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 15:09:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08113C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 12:09:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so22060767pjr.1
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KK5PMM54npEpLZliacDt3bjyqyNhWCWju9QlXW/gHeU=;
        b=U/guKoSq65qEHQXiT1haSu/HNuyYOFEzBcn85ZhyuHkLjJslFTSZcFnvCxO+uxJcGZ
         ED/p3mZ8czr3VfKHD8NDwnZOOpPJLvmNHKKSBIf/r4Ic1SS4na4TL3V43Jlfn8BUBLfo
         laUSw9vHzOJAsHJRLwNUgt5mz0u8UjQGJkgd2PepLnY1JNZf91p5eTRF1upcNf1mVhLA
         xJaPiV5aW4S9ofBhGURAlkz0+qh5ULHuToCTtEynzDka22ed5kBGexYIQBXGAtHDgQqR
         So1v8rCOcapmuKSzYXmBwY6o7aDoKbSIGaI2yWedwVPWit9ZRgAF7Ut9c/RKouBeXo2p
         pWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KK5PMM54npEpLZliacDt3bjyqyNhWCWju9QlXW/gHeU=;
        b=REjwxXCmxzmXFOX7P3ZyYV/obfYmcctps/YODJvfMZnuWd7TUdUBkFVwphR7g1WGVD
         ilyqM1lvK944IW2y9IBE6LN7f2RnQYG2MHHLop1vJZNZiyPIFgz4VaxpX6D9n/DuXiJv
         9tmhdBuh6NgYHPAVnHUJxMguWW+AF0178Sqv8TODEEw7OV8ebZkQnzhKEiDunKpe76Fx
         jZNhhn03hRU2PoM1qC6S9duG3McpFQ+OHKhVNKa7r2Aln1Ieu55yD4kRiv3wi7rYGxdK
         qZhK8pYxJpNtuBjatqZRAUP8mASkk7zmdlm5NplGyi+jI/6m6nQBotGzX0t4RKYQqnqA
         9Z7w==
X-Gm-Message-State: AOAM5333YVQrEnuPExJPzB3gB0VuH2MJUbwMbzscqMW9eXPhiCzh4aV9
        8G0sxJkBSb42WFW3Kfg48psNqg==
X-Google-Smtp-Source: ABdhPJxXdASnvDJiJ6fHGFND576uYst/fbUWHCZzRU/brb8tc0H0JIPhAWxB5EB9agwiBwVnP6hUkw==
X-Received: by 2002:a17:902:9b90:b029:12d:5ce1:4d99 with SMTP id y16-20020a1709029b90b029012d5ce14d99mr3193439plp.37.1628881765412;
        Fri, 13 Aug 2021 12:09:25 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d14sm2556095pjc.0.2021.08.13.12.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 12:09:25 -0700 (PDT)
Subject: Re: [PATCH -next v3] nbd: add the check to prevent overflow in
 __nbd_ioctl()
To:     Baokun Li <libaokun1@huawei.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     patchwork@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20210804021212.990223-1-libaokun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1799b798-34dc-9589-72d8-367516daf7ee@kernel.dk>
Date:   Fri, 13 Aug 2021 13:09:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804021212.990223-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 8:12 PM, Baokun Li wrote:
> If user specify a large enough value of NBD blocks option, it may trigger
> signed integer overflow which may lead to nbd->config->bytesize becomes a
> large or small value, zero in particular.
> 
> UBSAN: Undefined behaviour in drivers/block/nbd.c:325:31
> signed integer overflow:
> 1024 * 4611686155866341414 cannot be represented in type 'long long int'
> [...]
> Call trace:
> [...]
>  handle_overflow+0x188/0x1dc lib/ubsan.c:192
>  __ubsan_handle_mul_overflow+0x34/0x44 lib/ubsan.c:213
>  nbd_size_set drivers/block/nbd.c:325 [inline]
>  __nbd_ioctl drivers/block/nbd.c:1342 [inline]
>  nbd_ioctl+0x998/0xa10 drivers/block/nbd.c:1395
>  __blkdev_driver_ioctl block/ioctl.c:311 [inline]
> [...]
> 
> Although it is not a big deal, still silence the UBSAN by limit
> the input value.

Applied with unlikely() removed.

-- 
Jens Axboe


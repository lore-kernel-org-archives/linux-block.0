Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C4EC4338F
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30A360F94
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 14:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhGaO5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Jul 2021 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhGaO5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 10:57:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E12BC06175F
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 07:57:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e5so14569187pld.6
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cZF9Y6I+Qx6Gr1wByV30zO6gwQTmqMIjVaDGJsLh6xY=;
        b=BPCE/iJCz7ZZdNq+YWfPBsJCVbK2LhY4aLwn2ORBLnmHW4Yeuex9V06v9M06CixNSg
         nbPXP9LzzmsmWNN+tNuwAhjcrLuQD3F3kRf5uszwAkSjsTcBk1w1Iajjkq05Ng+6GLNK
         UkskUAmaxmIwvbzElih3EmkDWdDLN3mSQ958h9GpDPB98rOAd21WYoCsOJLHYgJvCdkY
         4zvEBMPjY8H7EfC23M2+B9Ke4I21lPkpsE27qhLeoh5vN/oH6XCSarOHOsE94Z+tMdio
         vbH/VHY4ZY7SRm9dnctPnl/6T3FiWZhFtE7roXuM82WDxxj6G5jql9Pd4FI2TbUsR9LO
         ShXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cZF9Y6I+Qx6Gr1wByV30zO6gwQTmqMIjVaDGJsLh6xY=;
        b=gNrkP7JAoF0KXt2CKQT6SXry7fnherE8hfAcFRLeINfUziw+Fa5m9P5g4da2NE+GAg
         4a/haVIddtKO6MzVl7io7elNV9gMPLUVvHYU6fdZYGJMRBC8WMJkknaXyKxL++d2rf9M
         Kfx7cIUHNhZIY2v4ILM5wSrru/swEDIwil2LyUDXCvh9ArDv9ZUYv7qs0+GOw2lUHEQq
         WSjmFflOpDk1Mj82dLDr9hD3xQunNzLMGtpyZ7x0yicCynzNeH1oiGI24H4a7IVjBsg6
         B/cSGiJeo2D5wKhcPmISQ+N7X83R0hK2rF+CBBuwsW7Gg3Dlm9NQyS2plOfXxlZgpiaW
         TqEw==
X-Gm-Message-State: AOAM531xMqcRSLz4VYDcs7y7TlszGUwyuI7KBPH1hB/0anjhKqFlwAAX
        3wD7HyANAi4zRsv1NbgpOTlo4w==
X-Google-Smtp-Source: ABdhPJyzU/6tGM56mhUxjGi31EMHcEd077Dj2ChDGqQDnO9RWpBxWW15XvR1Z01nBGYLn0FBmRv99g==
X-Received: by 2002:a17:90a:d3d2:: with SMTP id d18mr8775350pjw.102.1627743467767;
        Sat, 31 Jul 2021 07:57:47 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s31sm6998392pgm.27.2021.07.31.07.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 07:57:47 -0700 (PDT)
Subject: Re: [PATCH -next] nbd: add the check to prevent overflow in
 __nbd_ioctl()
To:     Baokun Li <libaokun1@huawei.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     patchwork@huawei.com, Hulk Robot <hulkci@huawei.com>
References: <20210731014854.3953274-1-libaokun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2582b8f-7cb8-f936-2d78-4d8b5feb0c12@kernel.dk>
Date:   Sat, 31 Jul 2021 08:57:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210731014854.3953274-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/21 7:48 PM, Baokun Li wrote:
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
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  drivers/block/nbd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..7c838bf8cc31 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1398,6 +1398,8 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  	case NBD_SET_SIZE:
>  		return nbd_set_size(nbd, arg, config->blksize);
>  	case NBD_SET_SIZE_BLOCKS:
> +		if (arg && (LLONG_MAX / arg <= config->blksize))
> +			return -EINVAL;

Use check_mul_overflow() instead?

-- 
Jens Axboe


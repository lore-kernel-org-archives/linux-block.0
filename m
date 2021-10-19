Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E495BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BB160FE8
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhJSTJT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhJSTJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 15:09:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295BFC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:07:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso4978832wms.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GE8YxdOnAWHzH/DIx6fj/sdteAcP2q6NDrSIvl8ELFQ=;
        b=EWKhLz2A09XLg3fl2zy1PBxwDq9xWCeIRgi6xV5M6FpSr3dtowb6QK6WNQXOvQQ2NW
         3OVUHWOT2wZdekm/rweegPGLByiVT9CkQZ8T3dyT0PFvOJhQo+mm30At8ZKUjBx+TD87
         cBX9jQ7Ku/kYOAP/Es5nhXkxzlnLwFbBt4BddPPx9SAMEx29neuINTW3b6T5B6ON5mUr
         awD5p7pByJhdaGXlpo2xcIEMe5E9J8Uqs0HnPoiAxxFGNMSpUa00IoyX3G5TkufBATN1
         3k1l81fksyyTv+Ck0TAK88QKHoaRqZ7aylYCYeSjbNiXNXnQt2S4Qt4FUNmnSvT4gV2k
         jxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GE8YxdOnAWHzH/DIx6fj/sdteAcP2q6NDrSIvl8ELFQ=;
        b=wUQH97vXEIknGFGS3Jkm5SE7kqTin5JgmbB3oQ+kPB3zZZoWUCQqwNqKr+uDzJjPtu
         smdj/ZvFE0ktBRSKPUfSAa2SdTtLSaswJaXvbaqLrnzBFkVYHBQZ8qmserMtupD2CmDf
         eFZFoYaWynX8rpvWQNgVQ8Oc8hpMHysSL8Hgu8XHHCPVwMHUWxHilYaaMUrmsESMnAQY
         vx59iOIAojSSWuHASfWO272nJvXYEMQ9NZS/0gYAHqYM+1mi/ZwYo04GK3HM1C+oPimW
         GyecJHQJM/shS1filXQ7gIFRfhcYuq3rpzbpIv10NCBhTJfmQeuVqEJah2XgoiEo7y0W
         ZjvQ==
X-Gm-Message-State: AOAM531qatvL1LDeVtK4O6FzFQH0zSD5G7awZZzcLZE+aG3PEeUAyb5V
        /Os0f8uBW5nSP2tltpbCtVs2EQSIdW2xGg==
X-Google-Smtp-Source: ABdhPJw7wRYgw2CxB22ybonfzQM27XDkAsACWB/1lKMzVzNfksFeVuGBsz6yVBKaWNJmcw9a30vwDw==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr8301834wmc.132.1634670423782;
        Tue, 19 Oct 2021 12:07:03 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id n11sm15164718wrw.43.2021.10.19.12.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 12:07:03 -0700 (PDT)
Message-ID: <b813826d-ce9a-c043-2d87-a7275d5df77d@gmail.com>
Date:   Tue, 19 Oct 2021 20:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] block: improve error checking in
 blkdev_bio_end_io_async()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <69df4731-3232-eb2a-664d-47d0db381843@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <69df4731-3232-eb2a-664d-47d0db381843@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 19:59, Jens Axboe wrote:
> Track the current error status of the dio with DIO_ERROR in the flags,
> which can then avoid diving into dio->bio for the fast path of not
> having any errors. This reduces the overhead of the function nicely,
> which was previously dominated by this seemingly cheap check:
> 
>       4.55%     -1.13%  [kernel.vmlinux]  [k] blkdev_bio_end_io_async

Jens, something gone wrong here. blkdev_bio_end_io_async() is a
function from my not yet published branch, the perf here is for it,
but the patch tackles blkdev_bio_end_io().

P.s. once blkdev_bio_end_io_async() doesn't need it, and once in
normal blkdev_bio_end_io() will be a slow-ish path, so probably
we don't care much.


> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/fops.c b/block/fops.c
> index d4f4fffb7d32..21d265caecff 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -127,6 +127,7 @@ enum {
>   	DIO_MULTI_BIO		= 1,
>   	DIO_SHOULD_DIRTY	= 2,
>   	DIO_IS_SYNC		= 4,
> +	DIO_ERROR		= 8,
>   };
>   
>   struct blkdev_dio {
> @@ -147,8 +148,10 @@ static void blkdev_bio_end_io(struct bio *bio)
>   	struct blkdev_dio *dio = bio->bi_private;
>   	unsigned int flags = dio->flags;
>   
> -	if (bio->bi_status && !dio->bio.bi_status)
> +	if (!(flags & DIO_ERROR) && !dio->bio.bi_status) {
>   		dio->bio.bi_status = bio->bi_status;
> +		flags |= DIO_ERROR;
> +	}
>   
>   	if (!(flags & DIO_MULTI_BIO) || atomic_dec_and_test(&dio->ref)) {
>   		if (!(flags & DIO_IS_SYNC)) {
> @@ -157,7 +160,7 @@ static void blkdev_bio_end_io(struct bio *bio)
>   
>   			WRITE_ONCE(iocb->private, NULL);
>   
> -			if (likely(!dio->bio.bi_status)) {
> +			if (likely(!(flags & DIO_ERROR))) {
>   				ret = dio->size;
>   				iocb->ki_pos += ret;
>   			} else {
> 

-- 
Pavel Begunkov

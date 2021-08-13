Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECFC4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7DD6109D
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbhHMPyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241354AbhHMPyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 11:54:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198BBC0617AD
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:53:51 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id e1so5422810qvs.13
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CwihxQvLtJhhIw8oFBGmVElpiNeOrquat4Xu9F0jAOg=;
        b=UobTjhUsdatqGjnwoy+XW7bcjQSD/T9CvT2bXzZDpMrL2ktB4pTVorEnfKGLiRVdsd
         SaCfPQUapfOVtf/dnRmTOERUsFeylckFCTl+VqV+5VK9Jk1l5lUG8GC3BbBtEvOGembA
         kCJ7V2LGik3JBVB5ag0re4REBTCXwxQpA6QyEy4WncXKDBkKjtXaIuMcE9/kNug6sx5O
         o2vYbmZZBOEW8v0h5xcAO45+OPC8p4EDjc17/i3oqbbgC583wR+6AtFLGKJJ4anAlcJY
         r4Ovg9Tg0l+YDPYnACSdAvADw1B1vrJYG/7WPco/q7rLwaVrVuCFB3Kk/drhiwO5SOZH
         CmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CwihxQvLtJhhIw8oFBGmVElpiNeOrquat4Xu9F0jAOg=;
        b=kr241QNNlf61j6KEdszQ2rJ8i5+zreOurc5wuuWbJxkxhkjigsxOJc5MuV2ZxlYktc
         jNycuQxRBp+3mT7+ky+2t37N7WDVKiq3iMuZZnD3DxhYThH6nb+PYBXq5XMv0L3obWnz
         fVFBotqptJu1wDympr7xz7JvYRgM4SPiGrY0SqpxNg6Ee8E+CNf57w01WjFPfxrGisCK
         f+/NYa5kZg7gU9H5Tua2VlNhBygmXStMd3rkaZ/gRA7EqPm/DDPl1KX2ui7pE+TcSmmI
         HjaSXrA0wCGDls3frf9R7CIo74dm1ekrhDiWhB4SQcsVn/IQZoEPH5lfoZzI5LjdMuSJ
         oaHw==
X-Gm-Message-State: AOAM533k3i6NAsDmdg4xhEpt+hACg1oVuKyXfjZIPe+vSjuniOb1WSDq
        LRIYCagDv+/X+mUIvW3NEK3eUQ==
X-Google-Smtp-Source: ABdhPJyYmLSrD3vLL1+cF8UUwaEG2k11P+wOic5kAZmLdn06ptIPRaFjlYyvsipkypN3if7BppYm7A==
X-Received: by 2002:a0c:ef84:: with SMTP id w4mr3256725qvr.34.1628870030094;
        Fri, 13 Aug 2021 08:53:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q26sm1141166qki.120.2021.08.13.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 08:53:49 -0700 (PDT)
Subject: Re: [PATCH -next v3] nbd: add the check to prevent overflow in
 __nbd_ioctl()
To:     Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     patchwork@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20210804021212.990223-1-libaokun1@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <49104529-74e4-27ed-945f-75e04c1b5968@toxicpanda.com>
Date:   Fri, 13 Aug 2021 11:53:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804021212.990223-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 10:12 PM, Baokun Li wrote:
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
>   handle_overflow+0x188/0x1dc lib/ubsan.c:192
>   __ubsan_handle_mul_overflow+0x34/0x44 lib/ubsan.c:213
>   nbd_size_set drivers/block/nbd.c:325 [inline]
>   __nbd_ioctl drivers/block/nbd.c:1342 [inline]
>   nbd_ioctl+0x998/0xa10 drivers/block/nbd.c:1395
>   __blkdev_driver_ioctl block/ioctl.c:311 [inline]
> [...]
> 
> Although it is not a big deal, still silence the UBSAN by limit
> the input value.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Use check_mul_overflow().
> V2->V3:
> 	The check_mul_overflow function requires the same input parameter type.
> 
>   drivers/block/nbd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..5a42b838d26c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1384,6 +1384,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   		       unsigned int cmd, unsigned long arg)
>   {
>   	struct nbd_config *config = nbd->config;
> +	loff_t bytesize;
>   
>   	switch (cmd) {
>   	case NBD_DISCONNECT:
> @@ -1398,8 +1399,11 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   	case NBD_SET_SIZE:
>   		return nbd_set_size(nbd, arg, config->blksize);
>   	case NBD_SET_SIZE_BLOCKS:
> -		return nbd_set_size(nbd, arg * config->blksize,
> -				    config->blksize);
> +		if (unlikely(check_mul_overflow((loff_t)arg,
> +						config->blksize,
> +						&bytesize)))
> +			return -EINVAL;
> +		return nbd_set_size(nbd, bytesize, config->blksize);

The unlikely isn't needed here, just makes it harder to read the thing, drop it 
and then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

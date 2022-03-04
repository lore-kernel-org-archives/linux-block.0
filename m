Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B37C433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 21:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiCDVkU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCDVkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 16:40:17 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD31FE560
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 13:39:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so8963950pjb.3
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 13:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O2BKVFUTad+h47EmFlT3Bh2Xc7VKQTN55LWHpLjCMzE=;
        b=sHq/wk7fidmYKpIA/TfXipoi8BFnRxPSGfU2b3kFdAzbJ6DkAhJtCIyV+EJ5XtwHje
         wyrYc/GYT3Mr2cwKOW3HovooHkyFlXMYBmTaX4MDsVY4yQ8oH1MRcbymgIBquXGhDDJi
         vQUs5Kucyqnh+5vZmSSIzQnAiPwnHeVHNnSHMzHaOVd0ewQQwsGX5P6O7EYDHq1f0bOj
         rstSX79CmdcIkLZf53P+XJyzlYgWwJLU77S/kxINa0RCI13PqFDtA5xU1c1OAzlUkcGq
         Kl8M91NxVPXHTxjXhZYvgHzc5AoezMAworrOlJNtUCvawXOmKN6rqtpwk2wL6wsyxN8i
         6j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O2BKVFUTad+h47EmFlT3Bh2Xc7VKQTN55LWHpLjCMzE=;
        b=I4Y9FPbkamJTgqEaY0VryZ3VnnPK6BPFz5ntvFFgAnEJGNz4Zoiy31xlcKRZ2EA1u3
         T+S4xf1GjVmp7SpAVKeiJ0u9Bf2IXEdtOnMUCdk/MQC5GM4XxZmqJFQWStRIMe50VD0l
         OowUwOuXElQVbw6eXXIpR4kUsFJhkiLaix71IiY/jhrXbuqcHGW4o1g4OIn1D4WZCiiD
         Ay4oFE0mvqcpXop2zrHDoRrEL+8WjeLPNTRN/Ikrmd0aRiFEYWoIWKu4vlvbpcrhOvmy
         3PH/xxdGlZai44bwNbO2PZ+RxQAY+kugOXag4MeqyzW3Az+qKF3P0toZCS7Zu+JdaV/s
         D30Q==
X-Gm-Message-State: AOAM5325dLYwOOQFE7BNvZyEBrm1518AV0A21iXa/FUUALAb9J79DH+m
        6tBnJqU2PYzKeIrr7Kkb7EYU+Q==
X-Google-Smtp-Source: ABdhPJz5FHUK82tjeB+aKmTy086tidKwDieQF9SxD+R88XPh37jukK6Rn+E4hcwg9ys6QT20CruiIA==
X-Received: by 2002:a17:90b:390c:b0:1bf:2d83:c70c with SMTP id ob12-20020a17090b390c00b001bf2d83c70cmr3837445pjb.217.1646429968664;
        Fri, 04 Mar 2022 13:39:28 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b004e19980d6cbsm6748783pfa.210.2022.03.04.13.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 13:39:28 -0800 (PST)
Message-ID: <68dc8fb0-86df-effe-4ef2-8ed9c350d836@kernel.dk>
Date:   Fri, 4 Mar 2022 14:39:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/2] block: add ->poll_bio to block_device_operations
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220304212623.34016-1-snitzer@redhat.com>
 <20220304212623.34016-2-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220304212623.34016-2-snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/22 2:26 PM, Mike Snitzer wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 94bf37f8e61d..e739c6264331 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -985,10 +985,16 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
>  
>  	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
>  		return 0;
> -	if (WARN_ON_ONCE(!queue_is_mq(q)))
> -		ret = 0;	/* not yet implemented, should not happen */
> -	else
> +	if (queue_is_mq(q)) {
>  		ret = blk_mq_poll(q, cookie, iob, flags);
> +	} else {
> +		struct gendisk *disk = q->disk;
> +
> +		if (disk && disk->fops->poll_bio)
> +			ret = disk->fops->poll_bio(bio, iob, flags);
> +		else
> +			ret = !WARN_ON_ONCE(1);

This is an odd way to do it, would be a lot more readable as

	ret = 0;
	WARN_ON_ONCE(1);

if we even need that WARN_ON?

> diff --git a/block/genhd.c b/block/genhd.c
> index e351fac41bf2..eb43fa63ba47 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -410,6 +410,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	struct device *ddev = disk_to_dev(disk);
>  	int ret;
>  
> +	WARN_ON_ONCE(queue_is_mq(disk->queue) && disk->fops->poll_bio);

Also seems kind of useless, maybe at least combine it with failing to
add the disk. This is a "I'm developing some new driver or feature"
failure, and would be more visible that way. And if you do that, then
the WARN_ON_ONCE() seems pointless anyway, and I'd just do:

	if (queue_is_mq(disk->queue) && disk->fops->poll_bio)
		return -EINVAL;

or something like that, with a comment saying why that doesn't make any
sense.

-- 
Jens Axboe


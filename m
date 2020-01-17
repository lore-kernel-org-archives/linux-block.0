Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D64C33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 14:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B8A206B7
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 14:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="eHsCIVZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgAQOSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:18:10 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41133 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 09:18:10 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so10764452qvr.8
        for <linux-block@vger.kernel.org>; Fri, 17 Jan 2020 06:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QZuEFUKjv//ibyKVev2kASTpvRJGWKtlTct99HsCngM=;
        b=eHsCIVZGsneURBSnnMRV2NrM9GAmfJxh+Z6wX5tGZ6yuKUHiDFGGeg9M5+wc7embk7
         vUUCBLrImj0GJ2uiMswlXW2SVZD+MnqK2SMD7exdwCQ9sJBPeUoIHFVitK3taC+w3mm7
         VkfQwarKOIjdASLiZ0k8jXwLqcD3xYmORlzx23HF3AIfx2Gq2Updp507eQ6xH5tsSkRe
         NC+04vKyBwJxxvo3QjZC8c9Z/38Df+LKZtQiAwgSVrFg7xoB9KcQaUScZb0g3+4cs3T/
         AKfNDgt/OQ0i3v8LT55qLwE9ZvPGA3UO8Z7CZBYKzFBlkklzWMQ43nNdVlO4fyADya30
         IlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QZuEFUKjv//ibyKVev2kASTpvRJGWKtlTct99HsCngM=;
        b=LHHzJdgDjVMsUKlfbsun/QMNY1BkagfFsbVUOnUZf0FtKyr9RE6ZDTESzYAXI0WhyT
         dbE/fjjWmFmYNWCcG3B3ZxvAKbU4XOyenhxQq+ibRWO6yK3sPYUe3Y+0OhPoBw3pS/5q
         U081bNqk3wEDuAzdls/vNdQix1GftptBDBmnQfy2PD9E1m7hczpj8FghDcF5X/xmN2iI
         khDf51sWRdwm9FcD2rVuqgq10jruhh1nI9DeATPH1qH/Rx0x8FOznnB6s+dTZVzn/cZz
         +6vGcnUpWzMWuo14rPgmrVCUYRtDDOlUbJ85lhrgU5Aq2lisz/N056XQXQIlOzXt6V9m
         fsjg==
X-Gm-Message-State: APjAAAXa34eqLJe8PoUuhfEDBIdP4jB6uTpm2vUDw4kc6CLWEK5iop9y
        OL4xeBQrq5t3st5/dVQWhbfRUA==
X-Google-Smtp-Source: APXvYqyVK4nL9OgB+euaXnwZw6RE6de018kfPkbe0U7aGHdH1reADSe2XSJ8P75DEADf92W/TOE82g==
X-Received: by 2002:a05:6214:1745:: with SMTP id dc5mr7651088qvb.230.1579270689133;
        Fri, 17 Jan 2020 06:18:09 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 206sm11803384qkf.132.2020.01.17.06.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:18:08 -0800 (PST)
Subject: Re: [PATCH] nbd: fix potential NULL pointer fault in connect and
 disconnect process
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200117115005.37006-1-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <875eaffb-d1e1-2d7e-09c9-81bab345e707@toxicpanda.com>
Date:   Fri, 17 Jan 2020 09:18:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117115005.37006-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/20 6:50 AM, Sun Ke wrote:
> Connect and disconnect a nbd device repeatedly, will cause
> NULL pointer fault.
> 
> It will appear by the steps:
> 1. Connect the nbd device and disconnect it, but now nbd device
>     is not disconnected totally.
> 2. Connect the same nbd device again immediately, it will fail
>     in nbd_start_device with a EBUSY return value.
> 3. Wait a second to make sure the last config_refs is reduced
>     and run nbd_config_put to disconnect the nbd device totally.
> 4. Start another process to open the nbd_device, config_refs
>     will increase and at the same time disconnect it.
> 
> To fix it, add a NBD_HAS_STARTED flag. Set it in nbd_start_device_ioctl
> and nbd_genl_connect if nbd device is started successfully.
> Clear it in nbd_config_put. Test it in nbd_genl_disconnect and
> nbd_genl_reconfigure.

I don't doubt what you are seeing, but what exactly are we NULL pointer 
dereferencing?  I can't quite figure it out from the steps.

> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   drivers/block/nbd.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..ddd364e208ab 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -83,6 +83,7 @@ struct link_dead_args {
>   
>   #define NBD_DESTROY_ON_DISCONNECT	0
>   #define NBD_DISCONNECT_REQUESTED	1
> +#define NBD_HAS_STARTED				2
>   
>   struct nbd_config {
>   	u32 flags;
> @@ -1215,6 +1216,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>   		nbd->disk->queue->limits.discard_alignment = 0;
>   		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
>   		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
> +		clear_bit(NBD_HAS_STARTED, &nbd->flags);
>   
>   		mutex_unlock(&nbd->config_lock);
>   		nbd_put(nbd);
> @@ -1290,6 +1292,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>   	ret = nbd_start_device(nbd);
>   	if (ret)
>   		return ret;
> +	else
> +		set_bit(NBD_HAS_STARTED, &nbd->flags);

The else is superfluous here.  Thanks,

Josef

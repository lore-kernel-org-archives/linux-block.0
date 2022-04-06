Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE5BC433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 14:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiDFOD5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiDFODo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 10:03:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECB1700BD
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 02:20:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg10so2978886ejb.4
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=cPA/bsRgdiVgbTJ1hE685J08E3jaB70rUNJ81hiw1vY=;
        b=vjJEp9awH2e6/CirKPbxJyFkWmJleCZsh+Jud/UCvf+NBBQsjRwrpJ1bs36uJsV4xH
         Kqlw1po9mhRBTqZqIDkKTh72zKTaG7KRRxNmhHOq0OoP7jpuj56QU4kAbW+Val9U7Y0g
         h7auwUj3Dlf9UifcU453hC9Ceq9y+k2MDbm8idYHIEjO79Mf0cJoBJEoOYVs+Zq2BKGL
         a7Ipsnlg/Y5kDPUyUb5uon37yifOwhUNasky7gdiL3TRXViCOcOO1/vyX0aZLMYPhnfb
         Gx9vMHW0uckmFlKfa1/xGUeWRyWZfD8BorGEVX+PnU27zmN+OeOaISp9SfbGFjb+GmXZ
         8g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=cPA/bsRgdiVgbTJ1hE685J08E3jaB70rUNJ81hiw1vY=;
        b=CfIIDukyUaBvS/KyMMl2SvuSiTVjgahBoeBK+zmP4p7laGomE6VhrXHlhwcI7kGlrR
         9yu6+NOXTOClwjOGstSW1Ce1ijDxHq0523ZfxtuIy04Zmf8p8m55aOfmNO4r8TJUleVm
         /+QsLto9U6+EOuHSyLvUvoHNJUSUtckz8yXFfGhSdIdS7cmnGOXkaB9V4LI01Vn59vSe
         xpi3jmCF9agTDeoIoTuXbvT4Nd9Ms3gT1bWBwGxNmccb8THWiPSZQl7+YJIkpfNsEZsI
         9wi020lQwk6e7N9spmqklhIIzJcjnTnv6NajzcFWsjGbcAl2y0SMyoxkvbkdd8lHmW7T
         OVWw==
X-Gm-Message-State: AOAM53094oIYg1lSBIP/xHdmO1WCraQvV4zOxG4HW+a50rcrX0K0f/+J
        UVYKOWLIeMLv8PzF+EIUnKZGXw==
X-Google-Smtp-Source: ABdhPJxDsUD/X+dseJ9Jl2i+zvLw2FFnbZ61ORhd7f4V49vtcFHIEkYYNy4/rQfmJukZXq81hn5GSg==
X-Received: by 2002:a17:907:3f86:b0:6df:ad43:583 with SMTP id hr6-20020a1709073f8600b006dfad430583mr7361894ejc.535.1649236840577;
        Wed, 06 Apr 2022 02:20:40 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id b8-20020a056402350800b00419407f0dd9sm7708780edd.0.2022.04.06.02.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:20:39 -0700 (PDT)
Message-ID: <012329f8-01db-7b17-0f64-2d63e86afc75@linbit.com>
Date:   Wed, 6 Apr 2022 11:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 05/27] drbd: use bdev based limit helpers in
 drbd_send_sizes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-6-hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 06.04.22 um 08:04 schrieb Christoph Hellwig:
> Use the bdev based limits helpers where they exist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 74b1b2424efff..d20d84ee7a88e 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -924,7 +924,9 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  
>  	memset(p, 0, packet_size);
>  	if (get_ldev_if_state(device, D_NEGOTIATING)) {
> -		struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
> +		struct block_device *bdev = device->ldev->backing_bdev;
> +		struct request_queue *q = bdev_get_queue(bdev);
> +
>  		d_size = drbd_get_max_capacity(device->ldev);
>  		rcu_read_lock();
>  		u_size = rcu_dereference(device->ldev->disk_conf)->disk_size;
> @@ -933,16 +935,15 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>  		max_bio_size = queue_max_hw_sectors(q) << 9;
>  		max_bio_size = min(max_bio_size, DRBD_MAX_BIO_SIZE);
>  		p->qlim->physical_block_size =
> -			cpu_to_be32(queue_physical_block_size(q));
> +			cpu_to_be32(bdev_physical_block_size(bdev));
>  		p->qlim->logical_block_size =
> -			cpu_to_be32(queue_logical_block_size(q));
> +			cpu_to_be32(bdev_logical_block_size(bdev));
>  		p->qlim->alignment_offset =
>  			cpu_to_be32(queue_alignment_offset(q));
> -		p->qlim->io_min = cpu_to_be32(queue_io_min(q));
> -		p->qlim->io_opt = cpu_to_be32(queue_io_opt(q));
> +		p->qlim->io_min = cpu_to_be32(bdev_io_min(bdev));
> +		p->qlim->io_opt = cpu_to_be32(bdev_io_opt(bdev));
>  		p->qlim->discard_enabled = blk_queue_discard(q);
> -		p->qlim->write_same_capable =
> -			!!q->limits.max_write_same_sectors;
> +		p->qlim->write_same_capable = 0;
>  		put_ldev(device);
>  	} else {
>  		struct request_queue *q = device->rq_queue;

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA8C07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CF86197B
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhGES2R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 14:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhGES2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 14:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625509539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1dA7LuS21CZJga9dfZTy+xFxKT35DcGT8NXfH7SV3w=;
        b=g06k/VM7aEZ6bulPGceNdaJxMn+F5wAurDqCmlmdEE8/r3EOLHoU8jFzKBqt6fQjAm4z8b
        k3jLM3AO09oTD2id2RRizJYZvQSreVmiMvh31tDLauIGElausMjrVHz+8H386TwYliI6DQ
        D8vyDlaCpyVDLGUMdBSx2VEAm5QvrlU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-6HRmLridOVK2Y3a8NzeW0A-1; Mon, 05 Jul 2021 14:25:38 -0400
X-MC-Unique: 6HRmLridOVK2Y3a8NzeW0A-1
Received: by mail-ed1-f71.google.com with SMTP id u13-20020aa7d88d0000b0290397eb800ae3so5458850edq.9
        for <linux-block@vger.kernel.org>; Mon, 05 Jul 2021 11:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1dA7LuS21CZJga9dfZTy+xFxKT35DcGT8NXfH7SV3w=;
        b=POqBBmFUwxj1VcVWGRv4VKywoseVFRDYprm+SM5tbgPGO9VJsf2tr9uHL15bw54Edv
         OrLrM6CVrNdM8cvXbIPGlQGZ3pAguqobQX34Co7SVgXZDiN6dZ20ZrNYqvRzczuSla41
         Jp03IuGL8abjKsjtgwf3u+DiRvK5VveCODknYL92GKDRb5IOOuWQiZdBtfMtRT11mvq2
         NS0mVYtQLLlJQr3EPOXK/tcBeoNOpm3MfwXTjkJL0T0c3g0I0BUiVoheW0pV5F/YuKYn
         eZZC+SsKku6xA63rbBISXcfWSyklIVEyTNaHDLaa1F/y1rbtnpmtoRR1c8Izg9QT082p
         r3UA==
X-Gm-Message-State: AOAM531A6D0+CxkxnGnyMiWHsg3ZBy0ifs9JE8A6/d+FmNN3Izxflk4n
        RpLPFXhvHxaJAlVx/9ER+0t+FHqoj8dlMHWbFRtAz14IcPRzHzGT3hErIUawPxrK08HaK143OUT
        wW6fAzS3xuP6y8/mCrqizaM0=
X-Received: by 2002:a05:6402:1c82:: with SMTP id cy2mr17477374edb.324.1625509537501;
        Mon, 05 Jul 2021 11:25:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyiqkphTkUX3OHsr5lvwvQkNygRb1AqpshkkZAXPOLJN5NLWa7fPK/aNr11ZHLweIF1oUb7w==
X-Received: by 2002:a05:6402:1c82:: with SMTP id cy2mr17477367edb.324.1625509537409;
        Mon, 05 Jul 2021 11:25:37 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id qo20sm522933ejb.106.2021.07.05.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:25:36 -0700 (PDT)
Date:   Mon, 5 Jul 2021 14:25:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210705142431-mutt-send-email-mst@kernel.org>
References: <20210705100006.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705100006.90-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 05, 2021 at 06:00:06PM +0800, Xie Yongji wrote:
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

I replied on v3.
Silently ignoring what hypervisor said is not a good idea.


> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e4bd3b1fc3c2..e9d7747c3cc0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -819,7 +819,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err && blk_size >= SECTOR_SIZE && blk_size <= PAGE_SIZE)
>  		blk_queue_logical_block_size(q, blk_size);
>  	else
>  		blk_size = queue_logical_block_size(q);
> -- 
> 2.11.0


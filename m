Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAB6C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48699610A0
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 15:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFOP3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhFOP3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 11:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623770850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBaVLpIdsAFYJF8kqK3yekJ5AzD1bcUpe8+m6jwsVLg=;
        b=fSBjcT318OH6wnTl6N7EHhkq2zdRp2JFmiKMkBfeMzkl9RXUivf4h6bBXFjih5YpZZRyd8
        tLoVHSThaHqUDfNUMCMwFZ6UhltYgi71D5VzgNamut0P9PqmnFY6t11WztoVS4WOzY1ePW
        x5PkBVmK58zFA/Gs96pwClfVxcTOklY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-u6omDxdwNRK1yTdv_VqCGA-1; Tue, 15 Jun 2021 11:27:29 -0400
X-MC-Unique: u6omDxdwNRK1yTdv_VqCGA-1
Received: by mail-ed1-f69.google.com with SMTP id s25-20020aa7c5590000b0290392e051b029so17483139edr.11
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 08:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBaVLpIdsAFYJF8kqK3yekJ5AzD1bcUpe8+m6jwsVLg=;
        b=qqBQUORLyO4is64wAK+jPbwVyIqF4FsVyRe/I8tjZbilxZVCWEXCiGlUq7CCwYYfrf
         sV6iA+d/gc7akXH4zTmT8KC4G2QT+qgB1EhmUtrBG+NBcotQUh3MJRvxXYKlw6PwWFzZ
         M0aLQrs5qfRMygjQshE8Rqi9bTAc/ABhpkQBGDpISzPVXeoYd7Opu91vTlTr5bO6KCTV
         McIiZhCAr9oLBQ93Y8JPkoebvkV6hXfGD03IB44HcPoLyo9725hQv1prLIP1S2H8hj0B
         Qrr3NJCogCqYJMEzzdQzeXtuQ+TwicXaBLzwLooAgZogqCr6U4IgkdlphcbZpdGrfqIr
         0cqQ==
X-Gm-Message-State: AOAM532hnQmL1AT2sADHHpFUrVOz2y4K5F8kVUwxnjzBkmIDWh4QtvjU
        Wt44afxs7QMY5E/LMgmwLOJk/68/us6L+pDptW3sdcksE/SkD4hNn903eJNoZdkMWbybIwZE7fa
        o7anmgwPHrUc9dT2/yzD4q7Y=
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr40598ejc.387.1623770848252;
        Tue, 15 Jun 2021 08:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyccg0L1KZ9HRDmng0aCPycLedCiLWQMiR/1yuXJ4epefHBw9Kz5GYIcrrgex/qKDfX2NhxbQ==
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr40579ejc.387.1623770848094;
        Tue, 15 Jun 2021 08:27:28 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
        by smtp.gmail.com with ESMTPSA id y10sm10323681ejm.76.2021.06.15.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:27:26 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:27:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210615112612-mutt-send-email-mst@kernel.org>
References: <20210615104810.151-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615104810.151-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 06:48:10PM +0800, Xie Yongji wrote:
> This ensures that we will not use an invalid block size
> in config space (might come from an untrusted device).
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

I'd say if device presents an unreasonable value,
and we want to ignore that, then we should not
negotiate VIRTIO_BLK_F_BLK_SIZE so that host knows.

So maybe move the logic to validate_features.

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..85ae3b27ea4b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -827,7 +827,7 @@ static int virtblk_probe(struct virtio_device *vdev)
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


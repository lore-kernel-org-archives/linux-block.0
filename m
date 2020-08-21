Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC82C433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8549720720
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANi49pA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHUIPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:15:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgHUIO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 04:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597997697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0I/pNL884gnkHmjBwkHes0nHXe8WPkrBrHsq+QyWGEw=;
        b=ANi49pA11LAb3EnUG0trwtt+/HYcFTD9AYm9txlFvlVTkRWrUy4qt4z9QA3qL1notRF1OB
        1cF6FqZbb6SHqpbiNRLWrF3tSeho+yKZdHfHXhv6cil2sXEpcuKtPiQlkfsslEEWzgNvmq
        BHeFdWXbsPVV9cIy6NMdHY4vMZ/TjWw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-hdkNvvBjOpO7k8SJROsLDQ-1; Fri, 21 Aug 2020 04:14:55 -0400
X-MC-Unique: hdkNvvBjOpO7k8SJROsLDQ-1
Received: by mail-wm1-f72.google.com with SMTP id k204so640750wmb.3
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 01:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0I/pNL884gnkHmjBwkHes0nHXe8WPkrBrHsq+QyWGEw=;
        b=lugZ9b9xL/6ryn0vwQHqu7Nkk375YLyFmvtu25aFXS2IINqqh0d1l6Vf64NznD7Y3J
         5v9MVQRICuGkGlSogFGz5chHLjk19kDgV7ptXYkq/0obksKaljzPkVObNRSfQb6gHs/p
         C6LrmoF3DSBeZ83c9Kpdp2wrM2wmBq5x1iqHfyqqrFyDhT6dUPFnGodG7pdcFMdWQIFS
         1LXY6fQGi8Mn8Lzv0fuI7PhJ8AKeUpl/HK0f6k7lvtqYOg1KJyZ+TIaxu/wQeDRLhOQL
         Qy1Qd5AVbppZwgbyMI7oUhVasQz5OWQ70ergrKpjOkn0Aq1QzHrmsjvjs7zhe2d1NARL
         ZgaA==
X-Gm-Message-State: AOAM533jXPn04Lgm8kMWZmcNOQqr1UOQq9+4NzQbgIhTSZ+Ecfzy3TdC
        1rSnZQ9p9eqSh0akZkjZKtJ8qwBaf0eHDq3pIbVQviAXgszSq+sctInw4ZxIw0ooHhBhnHjJyil
        1FcdGMNKAIPbkJ1qR8eVwqLs=
X-Received: by 2002:adf:ba52:: with SMTP id t18mr1610252wrg.26.1597997694825;
        Fri, 21 Aug 2020 01:14:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOjSXuqWXCiJ2sanB2D/fqYVUmGyFMmgD/33KFzetwXwzZI+JIqhRYkybHiV59yMxrm2afOg==
X-Received: by 2002:adf:ba52:: with SMTP id t18mr1610227wrg.26.1597997694626;
        Fri, 21 Aug 2020 01:14:54 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it. [79.33.191.244])
        by smtp.gmail.com with ESMTPSA id r206sm3363766wma.6.2020.08.21.01.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 01:14:54 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:14:51 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] virtio-blk: Use kobj_to_dev() instead of container_of()
Message-ID: <20200821081451.ell5jcyq6ozpzruo@steredhat>
References: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 09:19:15AM +0800, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 63b213e0..eb367b5 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -631,7 +631,7 @@ static struct attribute *virtblk_attrs[] = {
>  static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
>  		struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct gendisk *disk = dev_to_disk(dev);
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct virtio_device *vdev = vblk->vdev;
> -- 
> 2.7.4
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


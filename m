Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB3C433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 06:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiBCG1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 01:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231539AbiBCG1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Feb 2022 01:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643869666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Q3hJgKl1GZvpzGFs1izzlrbs0UNXcazvIKGrrx7xHU=;
        b=NDTle27wgLWvp93MGSCYusCBmWiI2+gy/xD+GZDQqSq/lNkiWDrD8erMpT56RR+PMstD7Y
        +6eXTtBZT6vsfybCocVISW3Wk+QcbvqILLZRLz/xdrkwAvfJutpYP7oiv7ogu14DxD7W6d
        tPNL1h3K69kYXLErcwmg3s34A1YHp+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-w5O8NsURMpGzrxAByWRO4g-1; Thu, 03 Feb 2022 01:27:09 -0500
X-MC-Unique: w5O8NsURMpGzrxAByWRO4g-1
Received: by mail-wr1-f71.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso273206wra.14
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 22:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Q3hJgKl1GZvpzGFs1izzlrbs0UNXcazvIKGrrx7xHU=;
        b=dx/Vk3GBgS0BVK+MUP8KK+7ZsaYNJsUA3M4PaxK8GPGoafTO1yFut94PvpGYbhswuN
         eFYW66X1l9ZabSaJDkuN40Cr5+CgiI/GZbLP0+xA908jhu6wtmObhrO84L8xvu4gaq7L
         +caFTp6kO6yRscXoIqidcBQlvfs2wyYIqqSY0M8XeF/bRd9V7ugkZ/3HjySIdfjduYMe
         Dfh6ZvOPqurx2Lwosazmk0AqVtVn1QyYTREWe6Ik4i9QRhB4Z7ZZtwhVMqUwMzADltlP
         VYZuJcxrMOY/lqPykjEnwdAKNamY06T/z7MceZ66EIi0UoWPfuXNq4WXqFbY9UwjA5ou
         n0Fg==
X-Gm-Message-State: AOAM531P4JvR1pX98ec6vXo86mryhQB05l6+v76XprIFsVENLUTSzMjl
        uaDqJMx0O72oXDYDx0bvRoe4DVPyS9iydVQIAPB67jlEMUPkFZ1ol3zNROLfm7XhZEY+tUbX6M4
        LOoVHWeiSpOkws1624EkMxEE=
X-Received: by 2002:a05:600c:19d2:: with SMTP id u18mr8762757wmq.101.1643869628587;
        Wed, 02 Feb 2022 22:27:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzwiRrXNiT1PFeEaEWqx53rsILaHA53YSG2uTc3uPWU3z3/gKj5cRHza8XX+2eY8cuzPj6uA==
X-Received: by 2002:a05:600c:19d2:: with SMTP id u18mr8762735wmq.101.1643869628366;
        Wed, 02 Feb 2022 22:27:08 -0800 (PST)
Received: from redhat.com ([2.55.131.61])
        by smtp.gmail.com with ESMTPSA id v3sm18549520wru.15.2022.02.02.22.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 22:27:07 -0800 (PST)
Date:   Thu, 3 Feb 2022 01:27:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/5] virtio_blk: simplify refcounting
Message-ID: <20220203012654-mutt-send-email-mst@kernel.org>
References: <20220202155659.107895-1-hch@lst.de>
 <20220202155659.107895-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202155659.107895-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 02, 2022 at 04:56:56PM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the virtio_blk structure only
> once the last gendisk reference goes away instead of keeping a local
> refcount.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 64 +++++++-------------------------------
>  1 file changed, 12 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b4..2d939ac1508c1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -69,13 +69,6 @@ struct virtio_blk {
>  	/* Process context for config space updates */
>  	struct work_struct config_work;
>  
> -	/*
> -	 * Tracks references from block_device_operations open/release and
> -	 * virtio_driver probe/remove so this object can be freed once no
> -	 * longer in use.
> -	 */
> -	refcount_t refs;
> -
>  	/* What host tells us, plus 2 for header & tailer. */
>  	unsigned int sg_elems;
>  
> @@ -391,43 +384,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	return err;
>  }
>  
> -static void virtblk_get(struct virtio_blk *vblk)
> -{
> -	refcount_inc(&vblk->refs);
> -}
> -
> -static void virtblk_put(struct virtio_blk *vblk)
> -{
> -	if (refcount_dec_and_test(&vblk->refs)) {
> -		ida_simple_remove(&vd_index_ida, vblk->index);
> -		mutex_destroy(&vblk->vdev_mutex);
> -		kfree(vblk);
> -	}
> -}
> -
> -static int virtblk_open(struct block_device *bd, fmode_t mode)
> -{
> -	struct virtio_blk *vblk = bd->bd_disk->private_data;
> -	int ret = 0;
> -
> -	mutex_lock(&vblk->vdev_mutex);
> -
> -	if (vblk->vdev)
> -		virtblk_get(vblk);
> -	else
> -		ret = -ENXIO;
> -
> -	mutex_unlock(&vblk->vdev_mutex);
> -	return ret;
> -}
> -
> -static void virtblk_release(struct gendisk *disk, fmode_t mode)
> -{
> -	struct virtio_blk *vblk = disk->private_data;
> -
> -	virtblk_put(vblk);
> -}
> -
>  /* We provide getgeo only to please some old bootloader/partitioning tools */
>  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
> @@ -460,11 +416,19 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  	return ret;
>  }
>  
> +static void virtblk_free_disk(struct gendisk *disk)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +
> +	ida_simple_remove(&vd_index_ida, vblk->index);
> +	mutex_destroy(&vblk->vdev_mutex);
> +	kfree(vblk);
> +}
> +
>  static const struct block_device_operations virtblk_fops = {
> -	.owner  = THIS_MODULE,
> -	.open = virtblk_open,
> -	.release = virtblk_release,
> -	.getgeo = virtblk_getgeo,
> +	.owner  	= THIS_MODULE,
> +	.getgeo		= virtblk_getgeo,
> +	.free_disk	= virtblk_free_disk,
>  };
>  
>  static int index_to_minor(int index)
> @@ -791,8 +755,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> -	/* This reference is dropped in virtblk_remove(). */
> -	refcount_set(&vblk->refs, 1);
>  	mutex_init(&vblk->vdev_mutex);
>  
>  	vblk->vdev = vdev;
> @@ -985,8 +947,6 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	kfree(vblk->vqs);
>  
>  	mutex_unlock(&vblk->vdev_mutex);
> -
> -	virtblk_put(vblk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.30.2


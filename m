Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E9C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiBII2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbiBII1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F0AAC05CB96
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 00:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644395267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QWFS2lWkJwMufiiyBv+3xLsV54GNui3YT83HssOBlE=;
        b=HLel9W6rieCD6Ml8C7+Uxt0rBUWUvGRAD/pqQhiRlvdnXbpu0HFQWTAe/VQbEz3oZaJryl
        LZQg2Ivg+xiCeLwnraVpLuKAVzqQY+IpDFu09wXlx+xLReUe9976XnjyuVMttEsujJXzCi
        MX4X1OcH/VMdzn6RlrSuqLyRVHS4zIQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-ka6FWjXaNVajbKgKV04CAA-1; Wed, 09 Feb 2022 03:27:46 -0500
X-MC-Unique: ka6FWjXaNVajbKgKV04CAA-1
Received: by mail-wm1-f69.google.com with SMTP id j39-20020a05600c1c2700b0037becd18addso191394wms.4
        for <linux-block@vger.kernel.org>; Wed, 09 Feb 2022 00:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QWFS2lWkJwMufiiyBv+3xLsV54GNui3YT83HssOBlE=;
        b=KWOaHbGUtlhKUCvG4WHHUTeuhwvPtdziUt4EqFSN5y59qmaajA0AtUj4ecdoDl+r4X
         1m1mblI35LtBKPwbYEEAHfB+2MauHp+Sb2Hst5Nz5Bz+9IqfBH8NI+ddNJzE9oxgF9e0
         hlWlw6/dNVDsBRnewCynyLoOourbAyqC4z06BxCoAG/mOp7I4eorEAikApdDcV27C9Lx
         ivsoMDMm5WjvktV2yvljFfEAlkkDwJ4xwy/qD9sMKNs8ADyvf1/ONukhuqgpE0c0adcO
         /bJlSy5A1U1dVVGdeaiJGz9f43acN1q7BNTvnZjPxnytvNBdVGxs8RDH45zcIhGq1onI
         JGbQ==
X-Gm-Message-State: AOAM533B+5mM1Jn255yv4+TEDEuLIM8u8PvizHIHkh3kZfm3LbCl9AtG
        9LjNsKC8Q6F0eYaGpl1tAtuEVvsI3bGttX0+NQ5jrY8EGOuOWwLFmFludOQbs4BvTlEMjAxZGFg
        xyiTBVFS53NkmnMgmlKpTgm8=
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr1516612wme.156.1644395264882;
        Wed, 09 Feb 2022 00:27:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz61XlLv13jFyjUak6xgKYBD8G/EHdydMsxOUqpgQlLjp1d7oGWF4hrmVdH/iwqfL5RxkmalA==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr1516594wme.156.1644395264661;
        Wed, 09 Feb 2022 00:27:44 -0800 (PST)
Received: from redhat.com ([2.52.2.146])
        by smtp.gmail.com with ESMTPSA id y3sm16442750wry.109.2022.02.09.00.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 00:27:44 -0800 (PST)
Date:   Wed, 9 Feb 2022 03:27:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] virtio_blk: simplify refcounting
Message-ID: <20220209032732-mutt-send-email-mst@kernel.org>
References: <20220209082121.2628452-1-hch@lst.de>
 <20220209082121.2628452-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209082121.2628452-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09, 2022 at 09:21:20AM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the virtio_blk structure only
> once the last gendisk reference goes away instead of keeping a local
> refcount.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 74 +++++++++++---------------------------
>  1 file changed, 21 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b4..05cc5451d6cc1 100644
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
> @@ -948,7 +910,13 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  out_cleanup_disk:
> -	blk_cleanup_disk(vblk->disk);
> +	blk_cleanup_queue(vblk->disk->queue);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +	vdev->config->del_vqs(vdev);
> +	kfree(vblk->vqs);
> +	put_disk(vblk->disk);
> +	return err;
> +
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_free_vq:
> @@ -970,7 +938,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	flush_work(&vblk->config_work);
>  
>  	del_gendisk(vblk->disk);
> -	blk_cleanup_disk(vblk->disk);
> +	blk_cleanup_queue(vblk->disk->queue);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
>  	mutex_lock(&vblk->vdev_mutex);
> @@ -986,7 +954,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  
>  	mutex_unlock(&vblk->vdev_mutex);
>  
> -	virtblk_put(vblk);
> +	put_disk(vblk->disk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.30.2
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 


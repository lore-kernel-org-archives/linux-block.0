Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B928AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 19:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B0660FC0
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 19:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbhJ0UBG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231203AbhJ0UBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 16:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635364719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gnYp+Ff4hb5nCYByl2z0UK3tRsHSwGb6NEyDFeJqpaU=;
        b=XmhgKlfulTMYnbB/j6WDfQCvSX3VMGYQ0OLvPDe/LfkRY7Be4B3LuyBvvgOLQE52haPKn3
        KAwXcb+tOmSEPw56t08VgY+R8nedp5rrNdg0SffCx+yKYcPsXO8hecIvHU0TCf+nq5uZpn
        EN5zRCp+7ku1iL/oV87HlhcwI0to6/w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-npGAc_5fMMapnAFfnM1b8Q-1; Wed, 27 Oct 2021 15:58:37 -0400
X-MC-Unique: npGAc_5fMMapnAFfnM1b8Q-1
Received: by mail-ed1-f71.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so3327452edj.21
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 12:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnYp+Ff4hb5nCYByl2z0UK3tRsHSwGb6NEyDFeJqpaU=;
        b=MThHCVJC9itSt9xijm6RYqcXhdasl8msn3KeJeUofn4miUbz5nwut+B/nEvIhIabPg
         jNiGk8ARN5VTpPDKp08Rqt3aVYyyzMGtyzWpYMHhokBu6pWt9+pgIfGfazGYQNejvkGZ
         NUlEEiV5gNKYK5Hr2LhJFocJGC7dZ9+8IjiUZwjNeb9Bxv9HbwsRQLaqHmAh9J562Mqz
         gqnjscAFBs9Q1OgEGSzaqxFQBCW3/nm8njS+c48cv3KmiFRE+beiyygfFsGfbqnwyCRx
         LzXNWbsO7QKTlrRlMsVLb1xdAQwKxRU1c1KEMFMyj9jXX5PezchcubstU0+FwuYkEFAd
         nu0Q==
X-Gm-Message-State: AOAM531wTET7RYgYCHROuoB3OqzE0E1o4zUCU0ebcwtUqrNsbXhdoyRm
        msdWND+3LGiwecBtoBBkQdAmGujApv1JebeEtG5RZO/A8FrSY4HgNxA2KrQiom227Y6iyA49q8U
        gNvgA8ysXJB3TabBeAhyUU2o=
X-Received: by 2002:aa7:db93:: with SMTP id u19mr11525968edt.179.1635364715591;
        Wed, 27 Oct 2021 12:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycH4irDBiKduRr0odmcV94oTFExCh07bjLyoBA8odK5EFPAdjJ0vRsc5zlYNzBq9zpNBJlVA==
X-Received: by 2002:aa7:db93:: with SMTP id u19mr11525950edt.179.1635364715442;
        Wed, 27 Oct 2021 12:58:35 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
        by smtp.gmail.com with ESMTPSA id x6sm507400eds.83.2021.10.27.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:58:34 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:58:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
Message-ID: <20211027155738-mutt-send-email-mst@kernel.org>
References: <20211026144015.188-1-xieyongji@bytedance.com>
 <20211026144015.188-5-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026144015.188-5-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 26, 2021 at 10:40:15PM +0800, Xie Yongji wrote:
> The block layer can't support a block size larger than
> page size yet. And a block size that's too small or
> not a power of two won't work either. If a misconfigured
> device presents an invalid block size in configuration space,
> it will result in the kernel crash something like below:
> 
> [  506.154324] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  506.160416] RIP: 0010:create_empty_buffers+0x24/0x100
> [  506.174302] Call Trace:
> [  506.174651]  create_page_buffers+0x4d/0x60
> [  506.175207]  block_read_full_page+0x50/0x380
> [  506.175798]  ? __mod_lruvec_page_state+0x60/0xa0
> [  506.176412]  ? __add_to_page_cache_locked+0x1b2/0x390
> [  506.177085]  ? blkdev_direct_IO+0x4a0/0x4a0
> [  506.177644]  ? scan_shadow_nodes+0x30/0x30
> [  506.178206]  ? lru_cache_add+0x42/0x60
> [  506.178716]  do_read_cache_page+0x695/0x740
> [  506.179278]  ? read_part_sector+0xe0/0xe0
> [  506.179821]  read_part_sector+0x36/0xe0
> [  506.180337]  adfspart_check_ICS+0x32/0x320
> [  506.180890]  ? snprintf+0x45/0x70
> [  506.181350]  ? read_part_sector+0xe0/0xe0
> [  506.181906]  bdev_disk_changed+0x229/0x5c0
> [  506.182483]  blkdev_get_whole+0x6d/0x90
> [  506.183013]  blkdev_get_by_dev+0x122/0x2d0
> [  506.183562]  device_add_disk+0x39e/0x3c0
> [  506.184472]  virtblk_probe+0x3f8/0x79b [virtio_blk]
> [  506.185461]  virtio_dev_probe+0x15e/0x1d0 [virtio]
> 
> So let's use a block layer helper to validate the block size.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Please merge through the block tree because of the
dependency.

Jens can you pick this up?

> ---
>  drivers/block/virtio_blk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 303caf2d17d0..fd086179f980 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -815,9 +815,17 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		err = blk_validate_block_size(blk_size);
> +		if (err) {
> +			dev_err(&vdev->dev,
> +				"virtio_blk: invalid block size: 0x%x\n",
> +				blk_size);
> +			goto out_cleanup_disk;
> +		}
> +
>  		blk_queue_logical_block_size(q, blk_size);
> -	else
> +	} else
>  		blk_size = queue_logical_block_size(q);
>  
>  	/* Use topology information if available */
> -- 
> 2.11.0


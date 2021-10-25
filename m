Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329B6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C02E60F6F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhJYRME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234940AbhJYRLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 13:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635181722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIsnWAzuBFe9gHiSmJ+BSqRSt/Kzk0fPACQvjnOMXwM=;
        b=Oh6sKCxC7U0dihYbfp0SzgvakwAipNOdpAdbv9tUveIhJ9pSlkfy+HplR476ovYT5Haj3J
        weSQ61Iorxo4dtXIAk7l3/jp75Vk9x2o+XBxCwUDeE5wABZiQWXhR2IuXBZmIjFOJFwCOO
        VCskU0v5IzEUykrrFSkBbiVvh76JIHA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-wGIrwEJcPKmWadUeKYjqMg-1; Mon, 25 Oct 2021 13:08:41 -0400
X-MC-Unique: wGIrwEJcPKmWadUeKYjqMg-1
Received: by mail-wr1-f71.google.com with SMTP id y1-20020a05600015c100b0016adc9e096eso455883wry.23
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 10:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIsnWAzuBFe9gHiSmJ+BSqRSt/Kzk0fPACQvjnOMXwM=;
        b=s+QxIFfsgu7jEyN5vOvh78DJaE2A5Q0X9P1Vct3WTuYDnh0TAdffKPuMawj35LCKGM
         Cr1R+ZU57krtFXJRMuyL4ShjTA5cS9EHQABTAptLHpvV0k/5z9DGUjmx6hHT6Us/SLyh
         zIsMDzFOoXE5oln/whUZZvcPOiwb8IjukeGY39lkpLMCjJLLTCRAoLebwip95CIwlCCT
         sPAF9Q6jidg7YORxWfGKkxCrp7Qhyt9r9t9sPebaLwilOPf3KIAVrAM0NIrXiHdX2J/u
         vnVUfCfEevgzIu+uW+Rl4cKxZ72EgW5bfpWgJr+CX4zMIx2FR27tmdJynYVc60lJtpyM
         +anw==
X-Gm-Message-State: AOAM533OCwtU+swnTkyqzAXsaQ0WMYeL0E9eDFQLmE866hUvYWMzE7x5
        JqlaQwfL7Xqkfc4l0kFpikub39HAuikonch9y3rns44kztzEAnK6lduup8b2M3z6lD6dy6XaxJf
        T6I35NRkf0FdgPAbu780z03U=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr21291682wmj.23.1635181719801;
        Mon, 25 Oct 2021 10:08:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyZto2WrweAcCxAfmQR9rdm2tzfsLZ7d2NbPqmOXvvnrZdmXf2381albDqxjOgnO+tqj1h8A==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr21291660wmj.23.1635181719596;
        Mon, 25 Oct 2021 10:08:39 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
        by smtp.gmail.com with ESMTPSA id w10sm9506341wrp.25.2021.10.25.10.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:08:39 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
Message-ID: <20211025130321-mutt-send-email-mst@kernel.org>
References: <20211025142506.167-1-xieyongji@bytedance.com>
 <20211025142506.167-5-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025142506.167-5-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 10:25:06PM +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than

the block size -> block sizes, or a block size

> page size yet.

And to add to that, a block size that's too small or
not a power of two won't work either, right?
Mention that too.


> If an untrusted device

nothing to do with trust. A misconfigured device.

> presents an invalid
> block size in configuration space, it will result in the
> kernel crash something like below:
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
> So this patch tries to use the block layer helper to
> validate the block size.

I know you are trying to be polite but it's misplaced here.
Just say what it is:

Use a block layer helper to validate the block size.

> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 303caf2d17d0..8b5833997f8e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -815,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		err = blk_validate_block_size(blk_size);
> +		if (err) {
> +			dev_err(&vdev->dev,
> +				"get invalid block size: %u\n", blk_size);

Probably hex. Add virtio_blk: and drop "get" here - it's ungrammatical.
	"virtio_blk: invalid block size: 0x%x\n", blk_size.

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


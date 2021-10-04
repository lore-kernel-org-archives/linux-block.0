Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D39C433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0901561216
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 15:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhJDP3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234025AbhJDP3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Oct 2021 11:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633361252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auNZYLZiQYvet1N/rTWrc/v8jISoRi7qtdbe/2SoG5w=;
        b=L08gJOPd/CfAz7uPRiTkY6Fsa80BkN5tqKuzGmOUa7RNWKJrAtzZpEMd3o1D4ITmKsGBND
        YD4oK/zOmbB3EXPi09376CENq/HpFfRLQpsUTqQ9wCiVyUZC5jP54MaCChxkdHRmGIErab
        UhzA44hGcZaT7PtfJ3JXrnYxZd4sD88=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-sbcnbxvlNlWxBzwunHVRfQ-1; Mon, 04 Oct 2021 11:27:31 -0400
X-MC-Unique: sbcnbxvlNlWxBzwunHVRfQ-1
Received: by mail-ed1-f69.google.com with SMTP id x96-20020a50bae9000000b003d871ecccd8so2607385ede.18
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 08:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auNZYLZiQYvet1N/rTWrc/v8jISoRi7qtdbe/2SoG5w=;
        b=VkNHYgNuEG9t0F2DphQ3nEeWGPnPOSF+i6gopNpMO0PaY3VU8MGIGZLk8FgTbtMBiz
         pRTORsYOFZQ3AnA6Ij319F7qodjjVU+W39W5XziEYBlXenjViGhc5hrzHYHjID7TOE1O
         oCf4mRmk0BsSyxCkWKvEALWNtiACDsJ5zFNcNrgPK4biLwwbvEqHdU+rS4zmkW/cETTC
         f5e2+WMG5s06szFfhBAZrCcnFbKz4Smh97w2uBx4CPsYD3Md2nCPoffPO20a+8A8CkLf
         J+1AWx0ymPvWi8s33WVFsbZXaQuCVdcFKzdtpQsrMCiSa08E/o4T2EUz/yDqb1yuroAO
         iAnQ==
X-Gm-Message-State: AOAM5309hVo8PXQExFG4MEbcfadW/5k7l9chJyKiyJKt1CXwLc3a/0gX
        Xu6D2rPoq4EcNmLWKoECIHYtIRyVgfZDtlksiqxZZHuIao1/XNLPv9jMb8H9IDrdkqMtX1+ss4x
        9LqyQ9C9PCQ7NmIz0FFSV+KA=
X-Received: by 2002:a50:e043:: with SMTP id g3mr18999648edl.196.1633361249579;
        Mon, 04 Oct 2021 08:27:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMJ7M+trs4RD8gzRpJQ6aRNNiNOKTOmXRorts5UQDjiCJa96uVKFhOKPZwNVjzIT+MTyscBg==
X-Received: by 2002:a50:e043:: with SMTP id g3mr18999630edl.196.1633361249409;
        Mon, 04 Oct 2021 08:27:29 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
        by smtp.gmail.com with ESMTPSA id d30sm1918863edn.49.2021.10.04.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:27:28 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:27:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211004112623-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809101609.148-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> An untrusted device might presents an invalid block size
> in configuration space. This tries to add validation for it
> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> feature bit if the value is out of the supported range.
> 
> And we also double check the value in virtblk_probe() in
> case that it's changed after the validation.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

So I had to revert this due basically bugs in QEMU.

My suggestion at this point is to try and update
blk_queue_logical_block_size to BUG_ON when the size
is out of a reasonable range.

This has the advantage of fixing more hardware, not just virtio.



> ---
>  drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..afb37aac09e8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>  
> +static int virtblk_validate(struct virtio_device *vdev)
> +{
> +	u32 blk_size;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> +		return 0;
> +
> +	blk_size = virtio_cread32(vdev,
> +			offsetof(struct virtio_blk_config, blk_size));
> +
> +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> +
> +	return 0;
> +}
> +
>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk;
> @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	u8 physical_block_exp, alignment_offset;
>  	unsigned int queue_depth;
>  
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>  	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>  			     GFP_KERNEL);
>  	if (err < 0)
> @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	else
>  		blk_size = queue_logical_block_size(q);
>  
> +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> +		dev_err(&vdev->dev,
> +			"block size is changed unexpectedly, now is %u\n",
> +			blk_size);
> +		err = -EINVAL;
> +		goto err_cleanup_disk;
> +	}
> +
>  	/* Use topology information if available */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>  				   struct virtio_blk_config, physical_block_exp,
> @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	return 0;
>  
> +err_cleanup_disk:
> +	blk_cleanup_disk(vblk->disk);
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_free_vq:
> @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
>  	.driver.name			= KBUILD_MODNAME,
>  	.driver.owner			= THIS_MODULE,
>  	.id_table			= id_table,
> +	.validate			= virtblk_validate,
>  	.probe				= virtblk_probe,
>  	.remove				= virtblk_remove,
>  	.config_changed			= virtblk_config_changed,
> -- 
> 2.11.0


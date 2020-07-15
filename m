Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE6C433E5
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C23206D5
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flmnuwma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgGOKGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:06:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47508 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728244AbgGOKGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594807604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xBNcpWQc4Ly7N1dkjlNTikVzXMkApkE+anJ2teQxPYU=;
        b=Flmnuwmaltn19XY0wyV6sx9M4AF/4LF+tyf7HoHBh6FTjlkxCgy+PPRuRqzb9hrNUQtVxN
        bY4PJSiAHTOgrYOvyINC21seJs22fkb2lcH3R1tZVGI8jX55RidNTP+r/4/PljNKWO5C8e
        fNAHJGxDgv8KArSH7lw9GWB3hdsME9U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-5hXtUfGRNiy-GKOwvuiqPw-1; Wed, 15 Jul 2020 06:06:41 -0400
X-MC-Unique: 5hXtUfGRNiy-GKOwvuiqPw-1
Received: by mail-wr1-f71.google.com with SMTP id d11so762438wrw.12
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 03:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xBNcpWQc4Ly7N1dkjlNTikVzXMkApkE+anJ2teQxPYU=;
        b=hjk/XFKEG25Gm6/OtOWJTveXZbNnQTb2mZ7sIFuMRD7zod4mnxsCPBRDtDXK0BxRBK
         x2U0dwb5cwKoewf2X95Ypshpz77ywQx+90X5tuRiXpAn6bvjisMgOenhg92ABHwd/apg
         U4g5yN4YboJaeIZzfVfaK/wa/eqxy3ONJPRzywW2O+uD7CPQzLWpbpIVTspr6mmUCw60
         VBJHLmgqJhXkUbsnvuFCmLRQQA/mrppHHFTWR05fu+J5t4+K1JkLtd2Hlqnfj9SiIWZ1
         q3YgbcPjvNxd/NYUFR28m7msXiXN3DDLTxQ+g6eGKVmCceYWTKFi/eDTGf83++UHdrkh
         xGpQ==
X-Gm-Message-State: AOAM530/h8D+9UteoEGtl/lggbCr6vjum4ONHWitS+V5Qy7sKq0hOt9E
        TtqPYkVg7ZKtLhJY2Z83TzkAkgtGBViq3+PW3aY2TxcJ/MsXqEMVJqYySOoDVzM1X1tXaVJT+HX
        +iAVuV2xYckVjHUGK6tjmmGk=
X-Received: by 2002:a5d:6846:: with SMTP id o6mr10603209wrw.370.1594807599972;
        Wed, 15 Jul 2020 03:06:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwea8LjSmMMg83WCulVLpJxzWYofbQm7iliNTI4DNdbx1Z3ZYCaB7MdTPLhYSHvHIsiYhllvA==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr10603175wrw.370.1594807599711;
        Wed, 15 Jul 2020 03:06:39 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id u15sm2743100wrm.64.2020.07.15.03.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:06:38 -0700 (PDT)
Date:   Wed, 15 Jul 2020 06:06:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio-blk: check host supplied logical block size
Message-ID: <20200715060233-mutt-send-email-mst@kernel.org>
References: <20200715095518.3724-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715095518.3724-1-mlevitsk@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 15, 2020 at 12:55:18PM +0300, Maxim Levitsky wrote:
> Linux kernel only supports logical block sizes which are power of two,
> at least 512 bytes and no more that PAGE_SIZE.
> 
> Check this instead of crashing later on.
> 
> Note that there is no need to check physical block size since it is
> only a hint, and virtio-blk already only supports power of two values.
> 
> Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 980df853ee497..36dda31cc4e96 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>  
> +
> +static bool virtblk_valid_block_size(unsigned int blksize)
> +{
> +	return blksize >= 512 && blksize <= PAGE_SIZE && is_power_of_2(blksize);
> +}
> +

Is this a blk core assumption? in that case, does not this belong
in blk core?

>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk;
> @@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		if (!virtblk_valid_block_size(blk_size)) {
> +			dev_err(&vdev->dev,
> +				"%s failure: unsupported logical block size %d\n",
> +				__func__, blk_size);
> +			err = -EINVAL;
> +			goto out_cleanup_queue;
> +		}
>  		blk_queue_logical_block_size(q, blk_size);
> -	else
> +	} else
>  		blk_size = queue_logical_block_size(q);
>  
>  	/* Use topology information if available */

OK so if we are doing this pls add {} around  blk_size = queue_logical_block_size(q);
too.

> @@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	return 0;
>  
> +out_cleanup_queue:
> +	blk_cleanup_queue(vblk->disk->queue);
> +	vblk->disk->queue = NULL;
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_put_disk:
> -- 
> 2.26.2


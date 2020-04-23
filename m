Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B933C54FCB
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A292077D
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 12:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9htQ05n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgDWMv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:51:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbgDWMv0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 08:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587646284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFynhrdn2AeeDCMTi/GbcSIhzhXYtqVnBO1H8k4rM8s=;
        b=F9htQ05nXy2kV/9bra2esbF+0idxxQGa6/ghPa53rw0b4snroPZldv5GifmTDk2voFjX+v
        3W+VoOEq4t3t+0ouOghLU+MdjtJ6JQywex+dWmAJoMcZ3k5/guXsFz4F5gTXt7hXRnzEht
        0ET/T8qmTDf3NgmaJ1Ol7euvOOU5xOg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-aC8K-M7NMy6aG0FUusb2sw-1; Thu, 23 Apr 2020 08:51:23 -0400
X-MC-Unique: aC8K-M7NMy6aG0FUusb2sw-1
Received: by mail-wr1-f69.google.com with SMTP id y10so2802200wrn.5
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2020 05:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFynhrdn2AeeDCMTi/GbcSIhzhXYtqVnBO1H8k4rM8s=;
        b=K0ibI6d2jKFlKQ/iYHzjaRYQC27u0rOcNbp0T8UW/QWnITZ4O1fqIuiC7xlbgH7OHN
         7dpF6Fc1Tosbc+0ULYMe18eeHYsWzfjF0mHw938kyMAfXeGVZ2rv14M9T3U18MFcdDvq
         Bxht0m1YpxX3xAzT+1Oy0ljVXKK+2eXKDU8ehHRjOfU0P6xsql7N75o++hd4rEoTWqRo
         DuLTg0OJ5BN5LVqM0avNeQDLc04ZlxasfqGFnB09kjvc5juJVDf6P2r1lW1UVk62XIgi
         Gzdd8iOptxFCJu1dfGr7BFI03OB74w/8d+KRk+dtX6nOysS5uq2XTOGNiA7ljK24e5wf
         GmSg==
X-Gm-Message-State: AGi0PuZeCd4xhuD89cr/s176jDzd+ylZ5miKyS0XxQR1l8x2zgPamXE0
        /0Yv/W4O+LWSCacvvGr8AQRD0kK2CS9uhhfl8H25kRCAuEpA0qAeiNlX2Keg7fW8Expel3FoLWL
        otB7wFoOPp7RbIxz7zpY4G3E=
X-Received: by 2002:adf:f34f:: with SMTP id e15mr4890720wrp.275.1587646282059;
        Thu, 23 Apr 2020 05:51:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/kzDW73KAZYZbxhnpJuArcvjawCoIOFrcjvuGR9Ia4oEPXtyQVUt1e61nouVHczLBSQLGAg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr4890704wrp.275.1587646281858;
        Thu, 23 Apr 2020 05:51:21 -0700 (PDT)
Received: from redhat.com (bzq-109-65-97-189.red.bezeqint.net. [109.65.97.189])
        by smtp.gmail.com with ESMTPSA id l4sm3745135wrv.60.2020.04.23.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 05:51:21 -0700 (PDT)
Date:   Thu, 23 Apr 2020 08:51:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200423084914-mutt-send-email-mst@kernel.org>
References: <20200423123717.139141-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423123717.139141-1-stefanha@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 23, 2020 at 01:37:17PM +0100, Stefan Hajnoczi wrote:
> A virtio_blk block device can still be referenced after hot unplug by
> userspace processes that hold the file descriptor.  In this case
> virtblk_getgeo() can be invoked after virtblk_remove() was called.  For
> example, a program that has /dev/vdb open can call ioctl(HDIO_GETGEO)
> after hot unplug.
> 
> Fix this by clearing vblk->disk->private_data and checking that the
> virtio_blk driver instance is still around in virtblk_getgeo().
> 
> Note that the virtblk_getgeo() function itself is guaranteed to remain
> in memory after hot unplug because the virtio_blk module refcount is
> still held while a block device reference exists.
> 
> Originally-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 93468b7c6701..b50cdf37a6f7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -300,6 +300,10 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
>  	struct virtio_blk *vblk = bd->bd_disk->private_data;
>  
> +	/* Driver instance has been removed */
> +	if (!vblk)
> +		return -ENOTTY;
> +
>  	/* see if the host passed in geometry config */
>  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
>  		virtio_cread(vblk->vdev, struct virtio_blk_config,

Just so I understand, what serializes this access?
See below for what looks like a race condition ...

> @@ -835,6 +839,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	vdev->config->reset(vdev);
>  
>  	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);

So what if private_data is tested at this time ...

> +	vblk->disk->private_data = NULL;
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);

... and then used at this time?

What prevents this?


> -- 
> 2.25.1
> 


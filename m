Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B5C2BA1A
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E54620736
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW70wBtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgDXImF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:42:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54935 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbgDXImF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 04:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587717724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRBkH5/Xmo1XGOKZTIj29qxMagsUMmu9LlrB6+bvzhA=;
        b=EW70wBtr1F6SmUMHajB+MYX1jdUm3XualGWMRnZ6XPeYqa1/aHrF2333ns9kJ9X4VCA7Lc
        EW/iZq4hjF/oKFyL2aSp9+dcqieufvTKwdCmJZ2Ewts8vHWmnPNwairkJ55xxF5YJ8Og5K
        7INLAC5wTiA1+Gv6VvPg7ePSYA4jpm4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-rC2jIYZHMI6yeriZj2-ZAw-1; Fri, 24 Apr 2020 04:42:02 -0400
X-MC-Unique: rC2jIYZHMI6yeriZj2-ZAw-1
Received: by mail-wm1-f71.google.com with SMTP id u11so3895204wmc.7
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 01:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRBkH5/Xmo1XGOKZTIj29qxMagsUMmu9LlrB6+bvzhA=;
        b=PEBlo3Al0gQ06zj0Ugxq/Vi0hP307z3bkTFS6+RagCjpudEyqvHxiz7ChT+DVgzPyg
         hFOQQE6z3lcLvUQnZ1y3JQzR5ej6TzbbN7D/0fJP9qb3Kj4QKFQH7bkGVRkDLSqxoZa4
         Cg7GGGdFbCcKMgCb4X4GgJzvZpbX9Zr38Fj+D2TKMQTHwSyv15nRWbdtPiZo1kW4BmNr
         BUN6jXtNMbOZotU59DNEX3SXrOT3CsE3v5wBGFwMv++wzLHXYBgjbAS2/aV/haSh4dCk
         BsWNArmxqdme9ulY98RleOWWHJ9/ryVirwOhoUGI3qxpcPNQqdTK49BrGYd01YpPD+Ue
         /YdA==
X-Gm-Message-State: AGi0Pub+2tzBLMn18BNl/QOZ9qeD2jJc9VVgr3mzhB52ykeNCO3gFXJY
        /8zoyOEqXIFhYkfsKI+E5I4Filvfg1QKDmBqPNPW7bDwcy5E6Y3eLnwAf2aGByAF3YNgtDGj4ux
        fkcH+kOblBXq7xj0QNAStzNc=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr8507232wmj.3.1587717721286;
        Fri, 24 Apr 2020 01:42:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKxuCqGvW3NHNyEw4+X3HPjqbYB2EyJcTmS/3W+wWEll8LclKWavyc7mGG0iFRlqlH/YaX6NQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr8507206wmj.3.1587717721017;
        Fri, 24 Apr 2020 01:42:01 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id s12sm1831955wmc.7.2020.04.24.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 01:42:00 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:41:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200424084158.uayekt5c3lus4532@steredhat>
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
> @@ -835,6 +839,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	vdev->config->reset(vdev);
>  
>  	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> +	vblk->disk->private_data = NULL;
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);

As pointed out, can be a race. We had a very similar issue in
virtio-vsock, and we solved using RCU to assign and get the pointer [1],
maybe the same solution can work here.

Cheers,
Stefano

[1] 0deab087b16a vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock


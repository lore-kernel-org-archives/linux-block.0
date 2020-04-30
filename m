Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E9CC47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A2220870
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 14:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3n7vW6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgD3OY4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:24:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728091AbgD3OYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 10:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588256693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5fpEhyonJNtWctr2YfWof6VRSvW/pmLq+MpDakVCl/k=;
        b=H3n7vW6pUtUm90ky1HTXNiXzoJw1LIjOVXkRCM+lLA4uRjw4FFP0FCWKNQFJPd7Emr6Y4P
        q5c2HToRT5R/+uhB8AMJLKvbP/Plk/LMTBzc/31xoeJNTp9Y60735axGSeoc3yZKWkYRfD
        PFZuMeE9CcEcY6bXGL22Hgben2gtAEU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-vGD-6NUMPfqndyj_SzL1rg-1; Thu, 30 Apr 2020 10:24:51 -0400
X-MC-Unique: vGD-6NUMPfqndyj_SzL1rg-1
Received: by mail-wr1-f70.google.com with SMTP id g7so3912532wrw.18
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 07:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fpEhyonJNtWctr2YfWof6VRSvW/pmLq+MpDakVCl/k=;
        b=sLPW/pVF+pxaX3wE6SYLkStFOziY7o2DLkJNQCUMIB4fJ1wKQBxHsTXnDMWApXXhn/
         +st0nXADSpho2X0NFZL22G0nAUMLpRagfT4lAiA+goZ1EIUKtkR8ziQF2FbaBSCpvELA
         arpAznuEqKSvsYDJ+7BGAl/Oq9/TNRSI3FqApXlM/PW0XGEeZ8DH5YHgevXQo4pfCLq4
         ER4Pxp9X5R6a5FtYYdGMIDvpt5Ncn7dU/MOh6shg7eUi4Lgi+WKs9UtdTWUgvIvdDdgz
         yA0MHjL+Pbf48O9SIjQX7xf79bjTLhCbjNj1ArEBKGA8RfQKwjCtcX3xFhjb9rEpECy3
         MiKQ==
X-Gm-Message-State: AGi0PuZ8CvInuHkrvgUuZ/kbK7RnQoWxpc1UXqeA5+TwcDrd4yd+y/lU
        tZcjb1DLkjg5FNuxYUp/NzM3L35Dc5CMq3vqvCQeTWsOzQwhelrAIlFl8Kr6wLR/E1Ov7S1TKJc
        w3nxAlyZTD6DK1RnHG4SBynM=
X-Received: by 2002:a7b:ce13:: with SMTP id m19mr3178269wmc.76.1588256689093;
        Thu, 30 Apr 2020 07:24:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRsjXvl0MScqBQ4vf9tGI+YxM90I3nk3U9F9GCf1z/+i1mDQdwcnMCAEIJ76qUYID0JqXTEg==
X-Received: by 2002:a7b:ce13:: with SMTP id m19mr3178244wmc.76.1588256688765;
        Thu, 30 Apr 2020 07:24:48 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u127sm12569469wme.8.2020.04.30.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:24:47 -0700 (PDT)
Date:   Thu, 30 Apr 2020 16:24:45 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, cohuck@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH v4] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200430142445.wbdpuwjugv5it3kh@steredhat>
References: <20200430140442.171016-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430140442.171016-1-stefanha@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 30, 2020 at 03:04:42PM +0100, Stefan Hajnoczi wrote:
> A userspace process holding a file descriptor to a virtio_blk device can
> still invoke block_device_operations after hot unplug.  This leads to a
> use-after-free accessing vblk->vdev in virtblk_getgeo() when
> ioctl(HDIO_GETGEO) is invoked:
> 
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000090
>   IP: [<ffffffffc00e5450>] virtio_check_driver_offered_feature+0x10/0x90 [virtio]
>   PGD 800000003a92f067 PUD 3a930067 PMD 0
>   Oops: 0000 [#1] SMP
>   CPU: 0 PID: 1310 Comm: hdio-getgeo Tainted: G           OE  ------------   3.10.0-1062.el7.x86_64 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   task: ffff9be5fbfb8000 ti: ffff9be5fa890000 task.ti: ffff9be5fa890000
>   RIP: 0010:[<ffffffffc00e5450>]  [<ffffffffc00e5450>] virtio_check_driver_offered_feature+0x10/0x90 [virtio]
>   RSP: 0018:ffff9be5fa893dc8  EFLAGS: 00010246
>   RAX: ffff9be5fc3f3400 RBX: ffff9be5fa893e30 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff9be5fbc10b40
>   RBP: ffff9be5fa893dc8 R08: 0000000000000301 R09: 0000000000000301
>   R10: 0000000000000000 R11: 0000000000000000 R12: ffff9be5fdc24680
>   R13: ffff9be5fbc10b40 R14: ffff9be5fbc10480 R15: 0000000000000000
>   FS:  00007f1bfb968740(0000) GS:ffff9be5ffc00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000090 CR3: 000000003a894000 CR4: 0000000000360ff0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    [<ffffffffc016ac37>] virtblk_getgeo+0x47/0x110 [virtio_blk]
>    [<ffffffff8d3f200d>] ? handle_mm_fault+0x39d/0x9b0
>    [<ffffffff8d561265>] blkdev_ioctl+0x1f5/0xa20
>    [<ffffffff8d488771>] block_ioctl+0x41/0x50
>    [<ffffffff8d45d9e0>] do_vfs_ioctl+0x3a0/0x5a0
>    [<ffffffff8d45dc81>] SyS_ioctl+0xa1/0xc0
> 
> A related problem is that virtblk_remove() leaks the vd_index_ida index
> when something still holds a reference to vblk->disk during hot unplug.
> This causes virtio-blk device names to be lost (vda, vdb, etc).
> 
> Fix these issues by protecting vblk->vdev with a mutex and reference
> counting vblk so the vd_index_ida index can be removed in all cases.
> 
> Fixes: 48e4043d4529523cbc7fa8dd745bd8e2c45ce1d3
>        ("virtio: add virtio disk geometry feature")
> Reported-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v4:
>  * Clarify vdev_mutex usage [Stefano and Michael]
> 
>  drivers/block/virtio_blk.c | 86 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 8 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 93468b7c6701..9d21bf0f155e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -33,6 +33,15 @@ struct virtio_blk_vq {
>  } ____cacheline_aligned_in_smp;
>  
>  struct virtio_blk {
> +	/*
> +	 * This mutex must be held by anything that may run after
> +	 * virtblk_remove() sets vblk->vdev to NULL.
> +	 *
> +	 * blk-mq, virtqueue processing, and sysfs attribute code paths are
> +	 * shut down before vblk->vdev is set to NULL and therefore do not need
> +	 * to hold this mutex.
> +	 */
> +	struct mutex vdev_mutex;
>  	struct virtio_device *vdev;
>  
>  	/* The disk structure for the kernel. */
> @@ -44,6 +53,13 @@ struct virtio_blk {
>  	/* Process context for config space updates */
>  	struct work_struct config_work;
>  
> +	/*
> +	 * Tracks references from block_device_operations open/release and
> +	 * virtio_driver probe/remove so this object can be freed once no
> +	 * longer in use.
> +	 */
> +	refcount_t refs;
> +
>  	/* What host tells us, plus 2 for header & tailer. */
>  	unsigned int sg_elems;
>  
> @@ -295,10 +311,55 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	return err;
>  }
>  
> +static void virtblk_get(struct virtio_blk *vblk)
> +{
> +	refcount_inc(&vblk->refs);
> +}
> +
> +static void virtblk_put(struct virtio_blk *vblk)
> +{
> +	if (refcount_dec_and_test(&vblk->refs)) {
> +		ida_simple_remove(&vd_index_ida, vblk->index);
> +		mutex_destroy(&vblk->vdev_mutex);
> +		kfree(vblk);
> +	}
> +}
> +
> +static int virtblk_open(struct block_device *bd, fmode_t mode)
> +{
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret = 0;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	if (vblk->vdev)
> +		virtblk_get(vblk);
> +	else
> +		ret = -ENXIO;
> +
> +	mutex_unlock(&vblk->vdev_mutex);
> +	return ret;
> +}
> +
> +static void virtblk_release(struct gendisk *disk, fmode_t mode)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +
> +	virtblk_put(vblk);
> +}
> +
>  /* We provide getgeo only to please some old bootloader/partitioning tools */
>  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
>  	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret = 0;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	if (!vblk->vdev) {
> +		ret = -ENXIO;
> +		goto out;
> +	}
>  
>  	/* see if the host passed in geometry config */
>  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
> @@ -314,11 +375,15 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  		geo->sectors = 1 << 5;
>  		geo->cylinders = get_capacity(bd->bd_disk) >> 11;
>  	}
> -	return 0;
> +out:
> +	mutex_unlock(&vblk->vdev_mutex);
> +	return ret;
>  }
>  
>  static const struct block_device_operations virtblk_fops = {
>  	.owner  = THIS_MODULE,
> +	.open = virtblk_open,
> +	.release = virtblk_release,
>  	.getgeo = virtblk_getgeo,
>  };
>  
> @@ -655,6 +720,10 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> +	/* This reference is dropped in virtblk_remove(). */
> +	refcount_set(&vblk->refs, 1);
> +	mutex_init(&vblk->vdev_mutex);
> +
>  	vblk->vdev = vdev;
>  	vblk->sg_elems = sg_elems;
>  
> @@ -820,8 +889,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> -	int index = vblk->index;
> -	int refc;
>  
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> @@ -831,18 +898,21 @@ static void virtblk_remove(struct virtio_device *vdev)
>  
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
> +	mutex_lock(&vblk->vdev_mutex);
> +
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
>  
> -	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> +	/* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
> +	vblk->vdev = NULL;
> +
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> -	kfree(vblk);
>  
> -	/* Only free device id if we don't have any users */
> -	if (refc == 1)
> -		ida_simple_remove(&vd_index_ida, index);
> +	mutex_unlock(&vblk->vdev_mutex);
> +
> +	virtblk_put(vblk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.25.3
> 


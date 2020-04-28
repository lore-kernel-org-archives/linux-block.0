Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8181FC83001
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B16206E2
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8TmEXof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgD1QDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:03:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbgD1QDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 12:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBJi8zIGk8WOyhlWyio6gaGrcbzBQ/4UwNnQCnZWksU=;
        b=i8TmEXof64/wG7McEK0ZtjfDRWwXKuJdTsAjYKC5vtrn31Pqdo/mRrXAO7cCX77RH8OjE8
        PrL7xJ2iWxvHp0Kyhrw+VcApnzpt9mkHLO6vuoqlfzrOHA8XX7S+eJ1U88fDz41z6wx0V3
        /Khsj4s0AUSI43zRQe1L7lZEb2ElYeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-xXX87KM6N_CvIKS8pEyEaA-1; Tue, 28 Apr 2020 12:03:18 -0400
X-MC-Unique: xXX87KM6N_CvIKS8pEyEaA-1
Received: by mail-wm1-f70.google.com with SMTP id 72so1352067wmb.1
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 09:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBJi8zIGk8WOyhlWyio6gaGrcbzBQ/4UwNnQCnZWksU=;
        b=VuUuRFB4B1iOTbnr3jpcC0HoTmVJo56hx450oS7bLBI/ZWRufkvF4bcnfF931v2xkK
         Wsp6EnoHqdLJVM23DuhzGiR1DeDaK0v9kzQTOsc2iLezW/MgQqzbVUJSCUt7cN2gy6mS
         c90Jt1L3A9s0bKpj/u4bANv8L11IQIiTDxF6pX67ESS2SVxdvBw0tU8yybc2kROVKT1g
         hrw7VGpqlNdCgtXP8BSI/v1nLhiMMU/+929/KieCzK2s4WsZqMNBr0oVGCYzjf39C3mM
         eNZkbaCPsTIKadLl/B8jhOF4p5jxb5iMRXrumYS9UusnGCiDOOcc22saQg/caTlKlY7e
         M/AA==
X-Gm-Message-State: AGi0PuZrAi3OFTsoeJ5v+C1YGQePUgQs1ED+ZA75o3i/FyWYqIfGe58e
        5d07vHi8rSb2dbq9WSl1NQnT0XFk20nCLLzgdcNq5p7z3IE52ATcngXZQtE8d0pktB0d6B/hsRF
        8pLR11/FfE/+GUGVqI8HPbmk=
X-Received: by 2002:adf:9441:: with SMTP id 59mr33346458wrq.211.1588089796855;
        Tue, 28 Apr 2020 09:03:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNhjJambiiyG5T3FZZ1d5lIJD6EM5AUWopnTqnTUlnP3xrL7KImVBSqMiGIyDR01pmOUe3Cw==
X-Received: by 2002:adf:9441:: with SMTP id 59mr33346389wrq.211.1588089796232;
        Tue, 28 Apr 2020 09:03:16 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id l4sm26559989wrv.60.2020.04.28.09.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:03:15 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:03:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200428120244-mutt-send-email-mst@kernel.org>
References: <20200428143009.107645-1-stefanha@redhat.com>
 <20200428110515-mutt-send-email-mst@kernel.org>
 <20200428155715.GA109767@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428155715.GA109767@stefanha-x1.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 04:57:15PM +0100, Stefan Hajnoczi wrote:
> On Tue, Apr 28, 2020 at 11:25:07AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2020 at 03:30:09PM +0100, Stefan Hajnoczi wrote:
> > > A userspace process holding a file descriptor to a virtio_blk device can
> > > still invoke block_device_operations after hot unplug.  For example, a
> > > program that has /dev/vdb open can call ioctl(HDIO_GETGEO) after hot
> > > unplug to invoke virtblk_getgeo().
> > 
> > 
> > which causes what? a use after free?
> 
> Yes, use after free.  I will include the kernel panic in the next
> revision.
> 
> virtio_check_driver_offered_feature() accesses vdev->dev.driver, which
> doesn't work after virtblk_remove() has freed vdev :).
> 
> > > 
> > > Introduce a reference count in struct virtio_blk so that its lifetime
> > > covers both virtio_driver probe/remove and block_device_operations
> > > open/release users.  This ensures that block_device_operations functions
> > > like virtblk_getgeo() can safely access struct virtio_blk.
> > > 
> > > Add remove_mutex to prevent block_device_operations functions from
> > > accessing vblk->vdev during virtblk_remove() and let the safely check
> > 
> > let the -> let them?
> 
> Thanks, will fix.
> 
> > 
> > > for !vblk->vdev after virtblk_remove() returns.
> > > 
> > > Switching to a reference count also solves the vd_index_ida leak where
> > > vda, vdb, vdc, etc indices were lost when the device was hot unplugged
> > > while the block device was still open.
> > 
> > Can you move this statement up so we list both issues (use after free
> > and leak) upfront, then discuss the fix?
> 
> Thanks, will fix.

Maybe add Fixes: if there's a specific commit that added geo support.

> > 
> > > 
> > > Reported-by: Lance Digby <ldigby@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > If someone has a simpler solution please let me know.  I looked at
> > > various approaches including reusing device_lock(&vblk->vdev.dev) but
> > > they were more complex and extending the lifetime of virtio_device after
> > > remove() has been called seems questionable.
> > > ---
> > >  drivers/block/virtio_blk.c | 85 ++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 77 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 93468b7c6701..3dd53b445cc1 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -44,6 +44,13 @@ struct virtio_blk {
> > >  	/* Process context for config space updates */
> > >  	struct work_struct config_work;
> > >  
> > > +	/*
> > > +	 * Tracks references from block_device_operations open/release and
> > > +	 * virtio_driver probe/remove so this object can be freed once no
> > > +	 * longer in use.
> > > +	 */
> > > +	refcount_t refs;
> > > +
> > >  	/* What host tells us, plus 2 for header & tailer. */
> > >  	unsigned int sg_elems;
> > >  
> > > @@ -53,6 +60,9 @@ struct virtio_blk {
> > >  	/* num of vqs */
> > >  	int num_vqs;
> > >  	struct virtio_blk_vq *vqs;
> > > +
> > > +	/* Provides mutual exclusion with virtblk_remove(). */
> > 
> > This is not the best way to document access rules.
> > Which fields does this protect, exactly?
> > I think it's just vdev. Right?
> > Pls add to the comment.
> 
> Yes, vblk->vdev cannot be dereferenced after virtblk_remove() is
> entered.
> 
> I'll document this mutex as protecting vdev.
> 
> > 
> > > +	struct mutex remove_mutex;
> > >  };
> > >  
> > >  struct virtblk_req {
> > > @@ -295,10 +305,54 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
> > >  	return err;
> > >  }
> > >  
> > > +static void virtblk_get(struct virtio_blk *vblk)
> > > +{
> > > +	refcount_inc(&vblk->refs);
> > > +}
> > > +
> > > +static void virtblk_put(struct virtio_blk *vblk)
> > > +{
> > > +	if (refcount_dec_and_test(&vblk->refs)) {
> > > +		ida_simple_remove(&vd_index_ida, vblk->index);
> > > +		mutex_destroy(&vblk->remove_mutex);
> > > +		kfree(vblk);
> > > +	}
> > > +}
> > > +
> > > +static int virtblk_open(struct block_device *bd, fmode_t mode)
> > > +{
> > > +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> > > +	int ret = -ENXIO;
> > 
> > 
> > It's more common to do
> > 
> > 	int ret = 0;
> > 
> > and on error:
> > 	ret = -ENXIO;
> > 
> > 
> > let's do this.
> 
> Will fix.
> 
> > > +
> > > +	mutex_lock(&vblk->remove_mutex);
> > > +
> > > +	if (vblk->vdev) {
> > > +		virtblk_get(vblk);
> > > +		ret = 0;
> > > +	}
> > 
> > I prefer
> > 	else
> > 		ret = -ENXIO
> > 
> > here.
> 
> Got it.
> 
> > > +
> > > +	mutex_unlock(&vblk->remove_mutex);
> > > +	return ret;
> > > +}
> > > +
> > > +static void virtblk_release(struct gendisk *disk, fmode_t mode)
> > > +{
> > > +	struct virtio_blk *vblk = disk->private_data;
> > > +
> > > +	virtblk_put(vblk);
> > > +}
> > > +
> > >  /* We provide getgeo only to please some old bootloader/partitioning tools */
> > >  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> > >  {
> > >  	struct virtio_blk *vblk = bd->bd_disk->private_data;
> > > +	int ret = -ENXIO;
> > 
> > It's more common to do
> > 
> > 	int ret = 0;
> > 
> > and on error:
> > 	ret = -ENXIO;
> > 
> > 
> > let's do this.
> 
> Will fix.
> 
> > 
> > > +
> > > +	mutex_lock(&vblk->remove_mutex);
> > > +
> > > +	if (!vblk->vdev) {
> > > +		goto out;
> > > +	}
> > 
> > 
> > single lines are not supposed to use {}.
> > if you add ret = -ENXIO here then it won't be a single line anymore
> > though.
> 
> Oops, a QEMU coding style habit :).
> 
> > >  
> > >  	/* see if the host passed in geometry config */
> > >  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
> > > @@ -314,11 +368,17 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> > >  		geo->sectors = 1 << 5;
> > >  		geo->cylinders = get_capacity(bd->bd_disk) >> 11;
> > >  	}
> > > -	return 0;
> > > +
> > > +	ret = 0;
> > > +out:
> > > +	mutex_unlock(&vblk->remove_mutex);
> > > +	return ret;
> > >  }
> > >  
> > >  static const struct block_device_operations virtblk_fops = {
> > >  	.owner  = THIS_MODULE,
> > > +	.open = virtblk_open,
> > > +	.release = virtblk_release,
> > >  	.getgeo = virtblk_getgeo,
> > >  };
> > >  
> > > @@ -655,6 +715,10 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >  		goto out_free_index;
> > >  	}
> > >  
> > > +	/* This reference is dropped in virtblk_remove(). */
> > > +	refcount_set(&vblk->refs, 1);
> > > +	mutex_init(&vblk->remove_mutex);
> > > +
> > >  	vblk->vdev = vdev;
> > >  	vblk->sg_elems = sg_elems;
> > >  
> > > @@ -820,8 +884,12 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >  static void virtblk_remove(struct virtio_device *vdev)
> > >  {
> > >  	struct virtio_blk *vblk = vdev->priv;
> > > -	int index = vblk->index;
> > > -	int refc;
> > > +
> > > +	/*
> > > +	 * Virtqueue processing is stopped safely here but mutual exclusion is
> > > +	 * needed for block_device_operations.
> > > +	 */
> > > +	mutex_lock(&vblk->remove_mutex);
> > >  
> > >  	/* Make sure no work handler is accessing the device. */
> > >  	flush_work(&vblk->config_work);
> > > @@ -834,15 +902,16 @@ static void virtblk_remove(struct virtio_device *vdev)
> > >  	/* Stop all the virtqueues. */
> > >  	vdev->config->reset(vdev);
> > >  
> > > -	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> > > +	/* Virtqueue are stopped, nothing can use vblk->vdev anymore. */
> > 
> > Virtqueues?
> 
> Thanks, will fix.



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B027FB31
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849453; cv=none; b=sEIqE8+CWkdGs8NAhIg23g0IEKuBg4CfQVCabXRVdAYqpUEA74yHiu56jRixfVXPpkEu658nTDUzlCvxhrgQDJYsgOZJdlMisR5iY/h1WQ2F8pO+Q0UCB0/lclSJkvebvGCzS46p0fj24qTsKzIsnb5KHfMBDsjbmbVqruempFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849453; c=relaxed/simple;
	bh=mKwqssHIkg1/6Mq0sU8nMFQjXG/ZxhERSaakamd3CIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpRrdOi7OAAhxPrEpWU5IqWWZvOyk/+pBTA6xO3f/F1wRtBucPN89DS0LDI8RuG75FRNxKZIYcOzkqONQj6eFXKBIJhZ0E2QvH8wzOvJzbS410sfAJztP6E22Xnjpuu8W/3Iq5q/WWv8tIZn9ZMIYNKlQyP8LOPrbwN4fBQ32Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAIitT21; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAIitT21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750849450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mV2L0uA46E6IR/XbwMqodk9/DnHgZWH9YL7bErGb8oc=;
	b=iAIitT21NCQu0WvBAeBhyRkPImVyHtveWf4/JqD/ubSbLewh7WfPPn6kEuJOaiZCh8jDg0
	+uDV8K4tya7Ozw+eepMcsBLNniL2nj+TNV1Zssfmelc7mCHmBBAUMdVfIhbkCv7pagTy6r
	k6ejIWR3II9kVJSvlmYVQirRl67B7Xc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-L0uIFfrKNzuT6QfqKEC6lQ-1; Wed, 25 Jun 2025 07:04:07 -0400
X-MC-Unique: L0uIFfrKNzuT6QfqKEC6lQ-1
X-Mimecast-MFC-AGG-ID: L0uIFfrKNzuT6QfqKEC6lQ_1750849446
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-adf58589c90so65810966b.0
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 04:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750849446; x=1751454246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV2L0uA46E6IR/XbwMqodk9/DnHgZWH9YL7bErGb8oc=;
        b=Q9XNkqu4RjL/NE/GibOBfeTj6QyJAmYhJg/Szhem/7KdE4MtS+OoWpZEDiqLfdYt1L
         OsGLt1Baj6O9nwxdg3bV0K3rDh6QrP18HqPn0/I53rHl4uRnALPVd2LWPg2OpY7AJ0Ln
         oyDjrd1bvM2zx4kSeoFBYqsNrzGOk0+b3Fpcy3xaRk7KHDmLC3JvUizaW/ncszQZ8uXJ
         wiouFxVRVplDaBpSD/EjTgcHPyS9meGDq3n1fdnrqQRF53ChEZmk4t+hynnuwemfHuYh
         LiLJ5fo9fiPaLNe0jF2FMKZ2Rng6+pO1bUY3GHrK4R7QJlLybG9pLABTfL89gniXOIWv
         M8aw==
X-Forwarded-Encrypted: i=1; AJvYcCV204rE92tJmGh7QcBq8MUHrGmnR5KLeTJ0wYW02IBLs9Rrkl1Ezc1NK9y+eu6BdEFzV7f6hcHD0xbJkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHpEG+T/HpSObSlnna+bKGGLqAR2NoFek+HfD9HcO4wFEsi7g
	EX9fq8bP+4sAOAm811J7VWXdmJylgZZsVMawtK3iqGGvEc3wmgcteJ/TP+KuJmz2OCE850115Ly
	SRoRo5M+ADj2aW5dZim3cbqnDX1IakX2D1yBTy+uS+obD+MxB99SrXuue/rZx6XDy
X-Gm-Gg: ASbGnctFeOqWGq5MKOcluNK7/qiFRIu4dhBYyL0SwTmK73cTn4hgb5HA969B1GMZb8r
	Sj3cfP8VLvtCGPluekWUzviIp4iXDeK+gfNR9QPpzIDEZDrp5U6CLJ3gipW0ics3POgzEZIBwTk
	ky4Nd8h/D2lChRxxk33JB7ntZiL/dbWZv1dWXg73XDeEHg3oLP4GOm+AZkkcQxYBT5MfBYDVoir
	JGDdA/lfXxwfLzWawEQv3AY+lNEEy3CnSAJJnBxkSuqyUhICoNCz8zaVHCCDhPNCxmz5j+7YGyl
	jRwCOwSUa7o=
X-Received: by 2002:a17:907:608e:b0:ad8:91e4:a92b with SMTP id a640c23a62f3a-ae0c08724d9mr208521566b.30.1750849445977;
        Wed, 25 Jun 2025 04:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkyCozBsu3cl3YVXYnP0uyrGR3WufTaS7j/pS0y6CUj4xvadg25WnCJXYeyOMN4VlSARuo2w==
X-Received: by 2002:a17:907:608e:b0:ad8:91e4:a92b with SMTP id a640c23a62f3a-ae0c08724d9mr208515766b.30.1750849445294;
        Wed, 25 Jun 2025 04:04:05 -0700 (PDT)
Received: from redhat.com ([31.187.78.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0c2812b7fsm98135966b.24.2025.06.25.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:04:04 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:04:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250625070228-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 25 June 2025 01:24 AM
> > 
> > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 25 June 2025 12:37 AM
> > > >
> > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > Sent: 25 June 2025 12:26 AM
> > > > > >
> > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > > > > > When the PCI device is surprise removed, requests may not
> > > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > > this, the disk deletion hangs.
> > > > > >
> > > > > > There are loops in the core virtio driver code that expect
> > > > > > device register reads to eventually return 0:
> > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset
> > > > > > ()
> > > > > >
> > > > > > Is there a hang if these loops are hit when a device has been
> > > > > > surprise removed? I'm trying to understand whether surprise
> > > > > > removal is fully supported or whether this patch is one step in that
> > direction.
> > > > > >
> > > > > In one of the previous replies I answered to Michael, but don't
> > > > > have the link
> > > > handy.
> > > > > It is not fully supported by this patch. It will hang.
> > > > >
> > > > > This patch restores driver back to the same state what it was
> > > > > before the fixes
> > > > tag patch.
> > > > > The virtio stack level work is needed to support surprise removal,
> > > > > including
> > > > the reset flow you rightly pointed.
> > > >
> > > > Have plans to do that?
> > > >
> > > Didn't give enough thoughts on it yet.
> > 
> > This one is kind of pointless then? It just fixes the specific race window that
> > your test harness happens to hit?
> > 
> It was reported by Li from Baidu, whose tests failed.
> I missed to tag "reported-by" in v5. I had it until v4. :(
> 
> > Maybe it's better to wait until someone does a comprehensive fix..
> > 
> >
> Oh, I was under impression is that you wanted to step forward in discussion of v4.
> If you prefer a comprehensive support across layers of virtio, I suggest you should revert the cited patch in fixes tag.
> 
> Otherwise, it is in degraded state as virtio never supported surprise removal.
> By reverting the cited patch (or with this fix), the requests and disk deletion will not hang.

But they will hung in virtio core on reset, will they not? The tests
just do not happen to trigger this?

> Please let me know if I should re-send to revert the patch listed in fixes tag.
> 
> > > > > > Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > >
> > > > > Thanks.
> > > > >
> > > > > > >
> > > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > > >
> > > > > > > With this fix now fio completes swiftly.
> > > > > > > An alternative of IO timeout has been considered, however when
> > > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > > clearing them enables users and upper layers to react quickly.
> > > > > > >
> > > > > > > Verified with multiple device unplug iterations with pending
> > > > > > > requests in virtio used ring and some pending with the device.
> > > > > > >
> > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > > virtio pci device")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > > Closes:
> > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb7
> > > > > > > 3ca9
> > > > > > > b474
> > > > > > > 1@baidu.com/
> > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > >
> > > > > > > ---
> > > > > > > v4->v5:
> > > > > > > - fixed comment style where comment to start with one empty
> > > > > > > line at start
> > > > > > > - Addressed comments from Alok
> > > > > > > - fixed typo in broken vq check
> > > > > > > v3->v4:
> > > > > > > - Addressed comments from Michael
> > > > > > > - renamed virtblk_request_cancel() to
> > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > - Added comments for virtblk_complete_request_with_ioerr()
> > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > > - Fixed comment style to have first empty line
> > > > > > > - replaced freezed to frozen
> > > > > > > - Fixed comments rephrased
> > > > > > >
> > > > > > > v2->v3:
> > > > > > > - Addressed comments from Michael
> > > > > > > - updated comment for synchronizing with callbacks
> > > > > > >
> > > > > > > v1->v2:
> > > > > > > - Addressed comments from Stephan
> > > > > > > - fixed spelling to 'waiting'
> > > > > > > - Addressed comments from Michael
> > > > > > > - Dropped checking broken vq from queue_rq() and queue_rqs()
> > > > > > >   because it is checked in lower layer routines in virtio core
> > > > > > >
> > > > > > > v0->v1:
> > > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > > - Improved logic for handling any outstanding requests
> > > > > > >   in bio layer
> > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > > ---
> > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 95 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..c5e383c0ac48
> > > > > > > 100644
> > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > > > virtio_device
> > > > > > *vdev)
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +/*
> > > > > > > + * If the vq is broken, device will not complete requests.
> > > > > > > + * So we do it for the device.
> > > > > > > + */
> > > > > > > +static bool virtblk_complete_request_with_ioerr(struct
> > > > > > > +request *rq, void *data) {
> > > > > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > > > > +	struct virtio_blk *vblk = data;
> > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > +	unsigned long flags;
> > > > > > > +
> > > > > > > +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > +
> > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > +
> > > > > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > > > > +	if (blk_mq_request_started(rq) &&
> > !blk_mq_request_completed(rq))
> > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > +
> > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > +	return true;
> > > > > > > +}
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * If the device is broken, it will not use any buffers and
> > > > > > > +waiting
> > > > > > > + * for that to happen is pointless. We'll do the cleanup in
> > > > > > > +the driver,
> > > > > > > + * completing all requests for the device.
> > > > > > > + */
> > > > > > > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk) {
> > > > > > > +	struct request_queue *q = vblk->disk->queue;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Start freezing the queue, so that new requests keeps
> > waiting at the
> > > > > > > +	 * door of bio_queue_enter(). We cannot fully freeze the
> > > > > > > +queue
> > > > > > because
> > > > > > > +	 * frozen queue is an empty queue and there are pending
> > requests, so
> > > > > > > +	 * only start freezing it.
> > > > > > > +	 */
> > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * When quiescing completes, all ongoing dispatches have
> > completed
> > > > > > > +	 * and no new dispatch will happen towards the driver.
> > > > > > > +	 */
> > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Synchronize with any ongoing VQ callbacks that may have
> > started
> > > > > > > +	 * before the VQs were marked as broken. Any outstanding
> > requests
> > > > > > > +	 * will be completed by
> > virtblk_complete_request_with_ioerr().
> > > > > > > +	 */
> > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * At this point, no new requests can enter the queue_rq()
> > and
> > > > > > > +	 * completion routine will not complete any new requests
> > > > > > > +either for
> > > > > > the
> > > > > > > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > > > > > > +	 * started.
> > > > > > > +	 */
> > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > +				virtblk_complete_request_with_ioerr,
> > vblk);
> > > > > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * All pending requests are cleaned up. Time to resume so
> > that disk
> > > > > > > +	 * deletion can be smooth. Start the HW queues so that when
> > > > > > > +queue
> > > > > > is
> > > > > > > +	 * unquiesced requests can again enter the driver.
> > > > > > > +	 */
> > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Unquiescing will trigger dispatching any pending requests
> > to the
> > > > > > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > > > > > +	 */
> > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Wait for all pending dispatches to terminate which may
> > have been
> > > > > > > +	 * initiated after unquiescing.
> > > > > > > +	 */
> > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Mark the disk dead so that once we unfreeze the queue,
> > requests
> > > > > > > +	 * waiting at the door of bio_queue_enter() can be aborted
> > > > > > > +right
> > > > > > away.
> > > > > > > +	 */
> > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > +
> > > > > > > +	/* Unfreeze the queue so that any waiting requests will be
> > aborted. */
> > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > > > >  	struct virtio_blk *vblk = vdev->priv; @@ -1561,6 +1653,9 @@
> > > > > > > static void virtblk_remove(struct virtio_device *vdev)
> > > > > > >  	/* Make sure no work handler is accessing the device. */
> > > > > > >  	flush_work(&vblk->config_work);
> > > > > > >
> > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > +
> > > > > > >  	del_gendisk(vblk->disk);
> > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD2223DE1
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791988; cv=none; b=H00arvs9wN/4CCX9o1Opo2FWS04L/aqkGCR63I6ZZOO1NPwTKsqZmAmMhtx5Hg9k2I++U+7bAhD6Qlbe9QzjCKPfayu+tpGRbG3crwsaU28iFlvHMOMCgHS+z06wykACBIHU+zz39O5RlyYx52kVAoExUGOJaljnCJY3ZD+WsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791988; c=relaxed/simple;
	bh=2vondAyJOQjOEJ/Upmm3SKYwkamKewsdIk0AER4OiNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+hBpMZ4N0TW9vU5E+cVX2px0SCorP8rfI1LdbSWaWAtzXAtsksRnnRaqyOLgICJX1lRxj5/7UFzox5EiuRa2WTselqjhbLK8TQIsFoLOeQhirKRbWeT2X2Vjr9ie7bCq/UfSQE3jNvhv5Bo1Etu4ARPJNwpSrVgxZSk6kSxfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGO3xvh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGO3xvh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750791983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQMdOUYo7v3/bu6tyaCuBGm4w8DagKvG7wDrK2N5Rug=;
	b=jGO3xvh1Oqn0qWe+i5Ozm5+9XnYmQQZboEvCUmW3LJzfcFS1uMhkDNN/bVyoTYSH4O4RLT
	bP8633ToPadp/PKdWU/YKHuuNHVtvyFdsj/03kid96ZpkrKRhNzRXOUIhMrDOJY5xdYVLa
	DIIWTC/Z/jQyPOxI4FG8ToY/ocb4SVE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-pyJiw5bTPOirDaBysVSvHg-1; Tue, 24 Jun 2025 15:06:20 -0400
X-MC-Unique: pyJiw5bTPOirDaBysVSvHg-1
X-Mimecast-MFC-AGG-ID: pyJiw5bTPOirDaBysVSvHg_1750791980
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-607ecda10fcso4146050a12.1
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791979; x=1751396779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQMdOUYo7v3/bu6tyaCuBGm4w8DagKvG7wDrK2N5Rug=;
        b=FQt4tU4ozI4868yjpGTEqjAPdUM9kRD5gzXw3dDuwmzyvOUmtsFE+M2cHKOu0/F+8n
         XaM0fktDxWKXZYM/11Zg+BEZ8GQgtK0kgNsikrow8mAP16gVgS5FTvJTyaIsOrma23DT
         TdyFo7YjE8SPjPG/NKsKEXC44nk01dTuBY+DEkPfQlXT62bNM3RL4X1kX5LwnPntmsea
         OpfuiR8yX4RxllqsIUI4wwpg1aRbwq8ZBe6myRD7DAEaUB0BjalhnkwsvGS0qWCTQjuQ
         HSlLq6HVxJCUIJhsqi1y8E7+ytng1D7zPt1xh8tYJOogM8JCYBvrMGiq+L9MVIN5G46q
         31Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVu61BxNbomqR9RJRWfzYknRSvblFd01jVkzLUzbKwFA7NdwGVTW1V7cIDGshbmdpOCIl1ln9x2UTvwcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMmprtZbmBt9cN3LpJ2yjchj53x7AF3nogx1gZ1PV8Fwky0DQ
	g30daCkIuE9vTkUlEPDL8a8M5RoZclS+wQ58Nb/h3rbFaSnph3HWiwX4EtfuDlaUBeqASZnMJRf
	gPrYq/bN9Cne9yHYGFUFQlBEAYPDn1V5yqWEftcmhR/zmPpfe35rkYIl9/6nAJd0c
X-Gm-Gg: ASbGncuTGHfi98zThzbvH9LCDqtPr2bSOTtLZ4OmNgkCVuTpOtydEtxVkXicVb30GFP
	hviCsbB55uWZH4jhDDlV7rEHw2ZFXi8GdtzhPvr9ltIUl6FUgxM8pIElvRd8uXmdGI9zi/TdzRU
	1D3FVgjNcc5V/cG3YZIGoxCNthk92B0rqmrPEfGRN60mgycojkgorBZM/67mE8hlW49pn4X+UAn
	dEeqFIr6c2/JO71afPUTg0Ny70/JqHJsX9qOLUUuKuPUiigPpA9Jg4Ypc3VXo2R0cAiH4EE9bkc
	06MXIU/QofE=
X-Received: by 2002:a17:907:3d0f:b0:ae0:bd48:b9ce with SMTP id a640c23a62f3a-ae0be7fb932mr40365866b.5.1750791979301;
        Tue, 24 Jun 2025 12:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL5dq2s+ASYpP57VdaQf7RnHFPBypwOC67UyMU5QVHdjUOvr5AKiEneZCWkOph6tAFAMZ9uQ==
X-Received: by 2002:a17:907:3d0f:b0:ae0:bd48:b9ce with SMTP id a640c23a62f3a-ae0be7fb932mr40363666b.5.1750791978746;
        Tue, 24 Jun 2025 12:06:18 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a7b0565bsm184234266b.165.2025.06.24.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:06:18 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:06:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	jasowang@redhat.com, alok.a.tiwari@oracle.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250624150435-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624185622.GB5519@fedora>

On Tue, Jun 24, 2025 at 02:56:22PM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete
> > the device as the VQ is marked as broken. Due to this, the disk
> > deletion hangs.
> 
> There are loops in the core virtio driver code that expect device
> register reads to eventually return 0:
> drivers/virtio/virtio_pci_modern.c:vp_reset()
> drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> 
> Is there a hang if these loops are hit when a device has been surprise
> removed?

Probably, yes. We can't really check broken status there though
I think - reset is called with a broken device normally.

> I'm trying to understand whether surprise removal is fully
> supported or whether this patch is one step in that direction.

I think it's a step.

> Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> > 
> > Fix it by aborting the requests when the VQ is broken.
> > 
> > With this fix now fio completes swiftly.
> > An alternative of IO timeout has been considered, however
> > when the driver knows about unresponsive block device, swiftly clearing
> > them enables users and upper layers to react quickly.
> > 
> > Verified with multiple device unplug iterations with pending requests in
> > virtio used ring and some pending with the device.
> > 
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: Li RongQing <lirongqing@baidu.com>
> > Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > ---
> > v4->v5:
> > - fixed comment style where comment to start with one empty line at start
> > - Addressed comments from Alok
> > - fixed typo in broken vq check
> > v3->v4:
> > - Addressed comments from Michael
> > - renamed virtblk_request_cancel() to
> >   virtblk_complete_request_with_ioerr()
> > - Added comments for virtblk_complete_request_with_ioerr()
> > - Renamed virtblk_broken_device_cleanup() to
> >   virtblk_cleanup_broken_device()
> > - Added comments for virtblk_cleanup_broken_device()
> > - Moved the broken vq check in virtblk_remove()
> > - Fixed comment style to have first empty line
> > - replaced freezed to frozen
> > - Fixed comments rephrased
> > 
> > v2->v3:
> > - Addressed comments from Michael
> > - updated comment for synchronizing with callbacks
> > 
> > v1->v2:
> > - Addressed comments from Stephan
> > - fixed spelling to 'waiting'
> > - Addressed comments from Michael
> > - Dropped checking broken vq from queue_rq() and queue_rqs()
> >   because it is checked in lower layer routines in virtio core
> > 
> > v0->v1:
> > - Fixed comments from Stefan to rename a cleanup function
> > - Improved logic for handling any outstanding requests
> >   in bio layer
> > - improved cancel callback to sync with ongoing done()
> > ---
> >  drivers/block/virtio_blk.c | 95 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 7cffea01d868..c5e383c0ac48 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	return err;
> >  }
> >  
> > +/*
> > + * If the vq is broken, device will not complete requests.
> > + * So we do it for the device.
> > + */
> > +static bool virtblk_complete_request_with_ioerr(struct request *rq, void *data)
> > +{
> > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > +	struct virtio_blk *vblk = data;
> > +	struct virtio_blk_vq *vq;
> > +	unsigned long flags;
> > +
> > +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> > +
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +
> > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +		blk_mq_complete_request(rq);
> > +
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> > +	return true;
> > +}
> > +
> > +/*
> > + * If the device is broken, it will not use any buffers and waiting
> > + * for that to happen is pointless. We'll do the cleanup in the driver,
> > + * completing all requests for the device.
> > + */
> > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk)
> > +{
> > +	struct request_queue *q = vblk->disk->queue;
> > +
> > +	/*
> > +	 * Start freezing the queue, so that new requests keeps waiting at the
> > +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> > +	 * frozen queue is an empty queue and there are pending requests, so
> > +	 * only start freezing it.
> > +	 */
> > +	blk_freeze_queue_start(q);
> > +
> > +	/*
> > +	 * When quiescing completes, all ongoing dispatches have completed
> > +	 * and no new dispatch will happen towards the driver.
> > +	 */
> > +	blk_mq_quiesce_queue(q);
> > +
> > +	/*
> > +	 * Synchronize with any ongoing VQ callbacks that may have started
> > +	 * before the VQs were marked as broken. Any outstanding requests
> > +	 * will be completed by virtblk_complete_request_with_ioerr().
> > +	 */
> > +	virtio_synchronize_cbs(vblk->vdev);
> > +
> > +	/*
> > +	 * At this point, no new requests can enter the queue_rq() and
> > +	 * completion routine will not complete any new requests either for the
> > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > +	 * started.
> > +	 */
> > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > +				virtblk_complete_request_with_ioerr, vblk);
> > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > +
> > +	/*
> > +	 * All pending requests are cleaned up. Time to resume so that disk
> > +	 * deletion can be smooth. Start the HW queues so that when queue is
> > +	 * unquiesced requests can again enter the driver.
> > +	 */
> > +	blk_mq_start_stopped_hw_queues(q, true);
> > +
> > +	/*
> > +	 * Unquiescing will trigger dispatching any pending requests to the
> > +	 * driver which has crossed bio_queue_enter() to the driver.
> > +	 */
> > +	blk_mq_unquiesce_queue(q);
> > +
> > +	/*
> > +	 * Wait for all pending dispatches to terminate which may have been
> > +	 * initiated after unquiescing.
> > +	 */
> > +	blk_mq_freeze_queue_wait(q);
> > +
> > +	/*
> > +	 * Mark the disk dead so that once we unfreeze the queue, requests
> > +	 * waiting at the door of bio_queue_enter() can be aborted right away.
> > +	 */
> > +	blk_mark_disk_dead(vblk->disk);
> > +
> > +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > +}
> > +
> >  static void virtblk_remove(struct virtio_device *vdev)
> >  {
> >  	struct virtio_blk *vblk = vdev->priv;
> > @@ -1561,6 +1653,9 @@ static void virtblk_remove(struct virtio_device *vdev)
> >  	/* Make sure no work handler is accessing the device. */
> >  	flush_work(&vblk->config_work);
> >  
> > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > +		virtblk_cleanup_broken_device(vblk);
> > +
> >  	del_gendisk(vblk->disk);
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >  
> > -- 
> > 2.34.1
> > 



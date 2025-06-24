Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AF291C1A
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794858; cv=none; b=qpyBfQLyakaEwwb8EAhtxnHKBOzGRnQQEvC86B/9cSg7uV57RHn3OR6wx7pBlAQ6nn1FaUKHpVjDbeoD8f5+hokHmQBrJQsIusfU5kzcrEEKb/ly2WRgslmocny8ev/mQDylgdA/p66Da1+cqhwjT9bZHvBy7yQI5Fa18GxqFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794858; c=relaxed/simple;
	bh=5voiYQ6IXhiiDEBU+Ft4xXIa5YgPiztfOrRs7eOjhjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTb4M40EGeQFSOR6HD6izf4kHai9nvsP68HkwQCeU+UUHJpG4nkhkzJQzqNbQIHY7Fsktzt+q+G8lWGpgrwNJJiLjpCJJXzYMK3lVDqXTTKbS32YukyptDDIkCWGi2DoB79eBQ7Fic6Lf0D0OkWWBgchI+Z+DQm6/BFLlIXff58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhxtiRio; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhxtiRio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750794855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=862lJ2mGggB0Qigd+WuoZWEZoGGMhi3QRbnwVZtJ23Q=;
	b=OhxtiRioWTjm7ehRymJn07JPKE2S/+uAcrzfYuuessrC2YedTjcl8HviVvWFxiNJn0DvP/
	i9SKeQDn/VRbbXCZe/wLQyK8e1+sgq2g9865QxLC5zER22HdROsNmxhZJD67AV6bDjjwhH
	KYJHOq2e9ZziVhDeCAUnys2kiDe7Mj0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-UzAOSnmYO7CHG69pAH1QBg-1; Tue, 24 Jun 2025 15:54:14 -0400
X-MC-Unique: UzAOSnmYO7CHG69pAH1QBg-1
X-Mimecast-MFC-AGG-ID: UzAOSnmYO7CHG69pAH1QBg_1750794853
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-607206f0d57so4895592a12.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 12:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794853; x=1751399653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=862lJ2mGggB0Qigd+WuoZWEZoGGMhi3QRbnwVZtJ23Q=;
        b=NTJRpB+VzJzwb0nC2cowiX/r7NjEdFzISWLsNIt2cBmtAc4hyw+CAD4ZH3CHEgv0U8
         9IDvPSt18GgER4CUGB+rfKuR5/RRxOy3EiTz4+JBk6jyXAOQ8Rxa5Lyhz9Or752g6+fg
         3WZYnVptFUQ56H6wBNnTx0SIrVyVOmpIlvOCC2BEVntaI9Cq/uen5gEGwgU4UG7gBxow
         2F1ffUhIybGbu4U39y+FKsyCSJiXxcYEKfMO1Yj9337vvI/7MndK1LR1zd8uZuD/Xrr0
         ZnUPZkDrT79xZZKM1nvQYqGZWq1oyZkeDq/r83iCA0LT2Ff8rgMJFZdxtOjoIaLMOw9Z
         CqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAtwxzs/SMIbfRKOt+gMN4e7OFKvs38z+7Y6/lXh08qaU7+osE+EEDbXutZUsM25teNl9TJpjPzkHQlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhCPkE8iZLD2BzikVy/7OYsLD1XNkvEl0aNxkx+Mspu/HEdqYT
	/wL6xgx33egMoTOc0YPFp08SoXr/cKJdalzuHMqZm7Br7ADuigLbdunK1qjI/vElazqhYop4xP2
	Ec0wdK206vFcBBYXtyX9n93Tb6/nzWvcWvsQw8rf94pYcV8oIuNGXvvsLL+FHwHhw
X-Gm-Gg: ASbGnctiE5aEWQQ+GjJVv1Zxr0YLefY5AD7gptCSXeor4BVdjBKV64heqXx/uEzVXmb
	eLivmUL+YN6EH2VDCVWJWBft8a0BJ3P8V7tUD47OxejmNKYDJcnU5P4D18JUP5JSDg2eLt/Ptil
	nad+9ZnLLuabSuucPeJjMoqKm1kFI13rhI1FDToYft9oVnTh1QEoXSTctjgm7LwH1so4swN3njq
	wT+FhbtGZbe0xC8WVzwuVVV1lPaNQ+05xmt1iNhUHGFfrUqJA80M6UlO/+1ywmsBvdEd0tJATKY
	KJ8l3VwnHek=
X-Received: by 2002:a05:6402:1ece:b0:607:16b1:7489 with SMTP id 4fb4d7f45d1cf-60c4dd008e6mr42322a12.20.1750794852719;
        Tue, 24 Jun 2025 12:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp3ZsQXe9e/SW8y0LzVBwS7X9v2rhRSVk2KrgPmbWnEn1ARP7AmHQUbtflDiGUCZbtClOTvA==
X-Received: by 2002:a05:6402:1ece:b0:607:16b1:7489 with SMTP id 4fb4d7f45d1cf-60c4dd008e6mr42301a12.20.1750794852239;
        Tue, 24 Jun 2025 12:54:12 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196e13sm1448397a12.11.2025.06.24.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:54:11 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:54:08 -0400
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
Message-ID: <20250624155157-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 25 June 2025 12:37 AM
> > 
> > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Sent: 25 June 2025 12:26 AM
> > > >
> > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > > > When the PCI device is surprise removed, requests may not complete
> > > > > the device as the VQ is marked as broken. Due to this, the disk
> > > > > deletion hangs.
> > > >
> > > > There are loops in the core virtio driver code that expect device
> > > > register reads to eventually return 0:
> > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> > > >
> > > > Is there a hang if these loops are hit when a device has been
> > > > surprise removed? I'm trying to understand whether surprise removal
> > > > is fully supported or whether this patch is one step in that direction.
> > > >
> > > In one of the previous replies I answered to Michael, but don't have the link
> > handy.
> > > It is not fully supported by this patch. It will hang.
> > >
> > > This patch restores driver back to the same state what it was before the fixes
> > tag patch.
> > > The virtio stack level work is needed to support surprise removal, including
> > the reset flow you rightly pointed.
> > 
> > Have plans to do that?
> >
> Didn't give enough thoughts on it yet.

This one is kind of pointless then? It just fixes the specific race window
that your test harness happens to hit?

Maybe it's better to wait until someone does a comprehensive fix..


> > > > Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >
> > > Thanks.
> > >
> > > > >
> > > > > Fix it by aborting the requests when the VQ is broken.
> > > > >
> > > > > With this fix now fio completes swiftly.
> > > > > An alternative of IO timeout has been considered, however when the
> > > > > driver knows about unresponsive block device, swiftly clearing
> > > > > them enables users and upper layers to react quickly.
> > > > >
> > > > > Verified with multiple device unplug iterations with pending
> > > > > requests in virtio used ring and some pending with the device.
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > Closes:
> > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > > b474
> > > > > 1@baidu.com/
> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > >
> > > > > ---
> > > > > v4->v5:
> > > > > - fixed comment style where comment to start with one empty line
> > > > > at start
> > > > > - Addressed comments from Alok
> > > > > - fixed typo in broken vq check
> > > > > v3->v4:
> > > > > - Addressed comments from Michael
> > > > > - renamed virtblk_request_cancel() to
> > > > >   virtblk_complete_request_with_ioerr()
> > > > > - Added comments for virtblk_complete_request_with_ioerr()
> > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > >   virtblk_cleanup_broken_device()
> > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > - Moved the broken vq check in virtblk_remove()
> > > > > - Fixed comment style to have first empty line
> > > > > - replaced freezed to frozen
> > > > > - Fixed comments rephrased
> > > > >
> > > > > v2->v3:
> > > > > - Addressed comments from Michael
> > > > > - updated comment for synchronizing with callbacks
> > > > >
> > > > > v1->v2:
> > > > > - Addressed comments from Stephan
> > > > > - fixed spelling to 'waiting'
> > > > > - Addressed comments from Michael
> > > > > - Dropped checking broken vq from queue_rq() and queue_rqs()
> > > > >   because it is checked in lower layer routines in virtio core
> > > > >
> > > > > v0->v1:
> > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > - Improved logic for handling any outstanding requests
> > > > >   in bio layer
> > > > > - improved cancel callback to sync with ongoing done()
> > > > > ---
> > > > >  drivers/block/virtio_blk.c | 95
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 95 insertions(+)
> > > > >
> > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..c5e383c0ac48
> > > > > 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > virtio_device
> > > > *vdev)
> > > > >  	return err;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * If the vq is broken, device will not complete requests.
> > > > > + * So we do it for the device.
> > > > > + */
> > > > > +static bool virtblk_complete_request_with_ioerr(struct request
> > > > > +*rq, void *data) {
> > > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > > +	struct virtio_blk *vblk = data;
> > > > > +	struct virtio_blk_vq *vq;
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > +
> > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > +
> > > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > > > +		blk_mq_complete_request(rq);
> > > > > +
> > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * If the device is broken, it will not use any buffers and
> > > > > +waiting
> > > > > + * for that to happen is pointless. We'll do the cleanup in the
> > > > > +driver,
> > > > > + * completing all requests for the device.
> > > > > + */
> > > > > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk) {
> > > > > +	struct request_queue *q = vblk->disk->queue;
> > > > > +
> > > > > +	/*
> > > > > +	 * Start freezing the queue, so that new requests keeps waiting at the
> > > > > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> > > > because
> > > > > +	 * frozen queue is an empty queue and there are pending requests, so
> > > > > +	 * only start freezing it.
> > > > > +	 */
> > > > > +	blk_freeze_queue_start(q);
> > > > > +
> > > > > +	/*
> > > > > +	 * When quiescing completes, all ongoing dispatches have completed
> > > > > +	 * and no new dispatch will happen towards the driver.
> > > > > +	 */
> > > > > +	blk_mq_quiesce_queue(q);
> > > > > +
> > > > > +	/*
> > > > > +	 * Synchronize with any ongoing VQ callbacks that may have started
> > > > > +	 * before the VQs were marked as broken. Any outstanding requests
> > > > > +	 * will be completed by virtblk_complete_request_with_ioerr().
> > > > > +	 */
> > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > +
> > > > > +	/*
> > > > > +	 * At this point, no new requests can enter the queue_rq() and
> > > > > +	 * completion routine will not complete any new requests either
> > > > > +for
> > > > the
> > > > > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > > > > +	 * started.
> > > > > +	 */
> > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > +				virtblk_complete_request_with_ioerr, vblk);
> > > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > +
> > > > > +	/*
> > > > > +	 * All pending requests are cleaned up. Time to resume so that disk
> > > > > +	 * deletion can be smooth. Start the HW queues so that when
> > > > > +queue
> > > > is
> > > > > +	 * unquiesced requests can again enter the driver.
> > > > > +	 */
> > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > +
> > > > > +	/*
> > > > > +	 * Unquiescing will trigger dispatching any pending requests to the
> > > > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > > > +	 */
> > > > > +	blk_mq_unquiesce_queue(q);
> > > > > +
> > > > > +	/*
> > > > > +	 * Wait for all pending dispatches to terminate which may have been
> > > > > +	 * initiated after unquiescing.
> > > > > +	 */
> > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > +
> > > > > +	/*
> > > > > +	 * Mark the disk dead so that once we unfreeze the queue, requests
> > > > > +	 * waiting at the door of bio_queue_enter() can be aborted right
> > > > away.
> > > > > +	 */
> > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > +
> > > > > +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > +}
> > > > > +
> > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > >  	struct virtio_blk *vblk = vdev->priv; @@ -1561,6 +1653,9 @@
> > > > > static void virtblk_remove(struct virtio_device *vdev)
> > > > >  	/* Make sure no work handler is accessing the device. */
> > > > >  	flush_work(&vblk->config_work);
> > > > >
> > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > +
> > > > >  	del_gendisk(vblk->disk);
> > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >


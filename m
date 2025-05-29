Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9241B67F
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748505841; cv=none; b=iOWm03O3j4kMVt1sDepSb8J++VygZm0W+ufVvyfs8VTvWKBN34zfyj7MghlLHuJxxx1VY/TZxGktjuvcbXOpBJvliPru/GxxzfWoATwlWqS6D0C+X5OEQArBrfozf8v/ilCUwpgTETuUJEdBMQzim5cnkvlGWdfXcpjPxWFuZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748505841; c=relaxed/simple;
	bh=dR9QGKE90y/lp9jy4v7nUrC3OvpRiFOEyRDIq/Mb0K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVDQCxnwpoB5fm7otRuu7q4fKT9jkMoqa7lkcUQ87spcjrkd/oO0hH9liH1yolcvypaPmEX21eTs5Yo8+FBHYi95fg90sI5FK1rORYT5qr+LRQHZIgwfE+HvpQygfpBsjslMXprf9nNKogeTsyrVYS5x/HpPScvp50c8vl+la5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NB1ESN2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB1ESN2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748505838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+E8ddedkpspBDqc7m7TRdYhn2aSST9La2vzARWwv0M=;
	b=NB1ESN2ee3IS84qjPDLDvrF8pzNjOG6KctAYAXt99ju3D8I9fryqV/eee+wnBn5jyRR87F
	fIQ+90Po70Qu40EyT/hdtIdwU+UnU/IonB+yUU0ATWItYXK5xXVskWHCrtotXW38ypLElK
	g0RmfzYr7DQk/HT70V9puo7yiZxdvwU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-qBOMnrpeNsu2gVep-1jdIA-1; Thu, 29 May 2025 04:03:57 -0400
X-MC-Unique: qBOMnrpeNsu2gVep-1jdIA-1
X-Mimecast-MFC-AGG-ID: qBOMnrpeNsu2gVep-1jdIA_1748505836
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442f90418b0so3433085e9.2
        for <linux-block@vger.kernel.org>; Thu, 29 May 2025 01:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748505836; x=1749110636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+E8ddedkpspBDqc7m7TRdYhn2aSST9La2vzARWwv0M=;
        b=XxxaUxJZqkPv52dR3l/n+ujDc9DXWzKxsVy+rH/JeHQV4PdSBhYrPFfgLUtvpPu44N
         uKBznbJOtruMzB+B4KnMEAp6kNUnhOdWyeAY8S74G7bY238dAmQ6NLbEiL2GOYPn27gs
         LRvcWO2KnVVYM8kHBpHRLHsxEp0l/InCGAb2gJVGOQsQrenjd/DIFqB/3QhFxkLrGsFX
         YNOYPeojxCOX0blCbxIENF2t7L3Qv/h+qQPcEisxot/F2OQE5b3VlrMDEY9dcBu0ESuG
         3chOfFU8JzG7wZ9cJEGNo1dzUUeaoFoEyJVOf63IOhf6GBtXVsMmpYQD6I+rlKdezyX1
         7gfw==
X-Forwarded-Encrypted: i=1; AJvYcCVcRDS4iKIY+gwnIM8xX3WIertw/wcI6/mS2VHDVc0dD/QulRRjtIidxttfWeemfe3MVgQoFyC+ORY4kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8VTkXl68dfkW0o4MOU9k/icFxJHS3CMITTEv9qBYdwgBEfYE
	wvqQsDN4cYkrTbm0HVVzfz8mnDzNMgdUX3h2UXQbUGEvOng4Wo6KQ+0P25XcCwIE36NueMV/mjz
	B5i8BGr9C8vm0IDIyrMilhTt0mJWONjwKrm1HIdiOI/VTEqqGfFgqfzh9D2Uxi7h2
X-Gm-Gg: ASbGncvlOfNsGgdUJQ0oIIAuqcKyByfyv+MXiACPUfO/GKnmkRRYuqqOza/bByLMZ+7
	ahYWJjzZOx90N8zUvx/nzkSmhHi0bjKbAY47poGoueEnhh0ti2lnfvjAufyS+q1sAF8gza19CVz
	Z1kTSDkQACOkaB98xI7fkibP4ebINoCcko0ESbUGH3n9REDpn5UQyIRAdwt5xgKeRocRAzB1zn4
	su1yFf0h/PV8NTr4K8o6W6O5J+zl8rny0YZ7XbkpzWrzBj4lOX8v1kYYdfj9TqR3FS6xRn1LMLW
	AVDcsg==
X-Received: by 2002:a05:6000:248a:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3a4dd16a2e9mr12199955f8f.38.1748505836088;
        Thu, 29 May 2025 01:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGur16GF9vO5hI+T4bVnnBBYKGhZTcRLwWon1WeRZpP41jJWLYSKKmtOvCAP2xoidG+N+83g==
X-Received: by 2002:a05:6000:248a:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3a4dd16a2e9mr12199917f8f.38.1748505835566;
        Thu, 29 May 2025 01:03:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a00d4sm1207464f8f.92.2025.05.29.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 01:03:54 -0700 (PDT)
Date: Thu, 29 May 2025 04:03:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: stefanha@redhat.com, axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, stable@vger.kernel.org,
	lirongqing@baidu.com, kch@nvidia.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, jasowang@redhat.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v3] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250529035007-mutt-send-email-mst@kernel.org>
References: <20250529061913.28868-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529061913.28868-1-parav@nvidia.com>

On Thu, May 29, 2025 at 06:19:31AM +0000, Parav Pandit wrote:
> When the PCI device is surprise removed, requests may not complete
> the device as the VQ is marked as broken. Due to this, the disk
> deletion hangs.
> 
> Fix it by aborting the requests when the VQ is broken.
> 
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
> 
> Verified with multiple device unplug iterations with pending requests in
> virtio used ring and some pending with the device.
> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> v2->v3:
> - Addressed comments from Michael
> - updated comment for synchronizing with callbacks
> 
> v1->v2:
> - Addressed comments from Stephan
> - fixed spelling to 'waiting'
> - Addressed comments from Michael
> - Dropped checking broken vq from queue_rq() and queue_rqs()
>   because it is checked in lower layer routines in virtio core
> 
> v0->v1:
> - Fixed comments from Stefan to rename a cleanup function
> - Improved logic for handling any outstanding requests
>   in bio layer
> - improved cancel callback to sync with ongoing done()


Thanks!
Something else small to improve.

> ---
>  drivers/block/virtio_blk.c | 82 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868..d37df878f4e9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1554,6 +1554,86 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +static bool virtblk_request_cancel(struct request *rq, void *data)

it is more

virtblk_request_complete_broken_with_ioerr

and maybe a comment?
/*
 * If the vq is broken, device will not complete requests.
 * So we do it for the device.
 */

> +{
> +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq;
> +	unsigned long flags;
> +
> +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +	return true;
> +}
> +
> +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)

and one goes okay what does it do exactly? cleanup device in
a broken way? turns out no, it cleans up a broken device.
And an overview would be good. Maybe, a small comment will help:

/*
 * if the device is broken, it will not use any buffers and waiting
 * for that to happen is pointless. We'll do it in the driver,
 * completing all requests for the device.
 */


> +{
> +	struct request_queue *q = vblk->disk->queue;
> +
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> +		return;

so one has to read it, and understand that we did not need to call
it in the 1st place on a non broken device.
Moving it to the caller would be cleaner.


> +
> +	/* Start freezing the queue, so that new requests keeps waiting at the

wrong style of comment for blk.

/* this is
 * net style
 */

/*
 * this is
 * rest of the linux style
 */

> +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> +	 * freezed queue is an empty queue and there are pending requests, so

a frozen queue

> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/* When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 * This ensures that later when cancel is attempted, then are not

they are not?

> +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks that may have started
> +	 * before the VQs were marked as broken. Any outstanding requests
> +	 * will be completed by virtblk_request_cancel().
> +	 */
> +	virtio_synchronize_cbs(vblk->vdev);
> +
> +	/* At this point, no new requests can enter the queue_rq() and
> +	 * completion routine will not complete any new requests either for the
> +	 * broken vq. Hence, it is safe to cancel all requests which are
> +	 * started.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel, vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/* All pending requests are cleaned up. Time to resume so that disk
> +	 * deletion can be smooth. Start the HW queues so that when queue is
> +	 * unquiesced requests can again enter the driver.
> +	 */
> +	blk_mq_start_stopped_hw_queues(q, true);
> +
> +	/* Unquiescing will trigger dispatching any pending requests to the
> +	 * driver which has crossed bio_queue_enter() to the driver.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +
> +	/* Wait for all pending dispatches to terminate which may have been
> +	 * initiated after unquiescing.
> +	 */
> +	blk_mq_freeze_queue_wait(q);
> +
> +	/* Mark the disk dead so that once queue unfreeze, the requests

... once we unfreeze the queue


> +	 * waiting at the door of bio_queue_enter() can be aborted right away.
> +	 */
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> @@ -1561,6 +1641,8 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>

I prefer simply moving the test here:
  
	if (virtqueue_is_broken(vblk->vqs[0].vq))
		virtblk_broken_device_cleanup(vblk);

makes it much clearer what is going on, imho.


>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
> -- 
> 2.34.1


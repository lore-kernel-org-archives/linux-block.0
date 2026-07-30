Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A3470435
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453249; cv=none; b=qaOih5UC27Wqa/7A7AYgLxrdgEG6m9AqbvNJayB4psnIasAjJD4DEvf3mD7hreAJ/amkBbMq4UhjsLoxD8waMuzsy4Qlqv+Wm4xhYsfmZuoLZzSOEXgS80E56L9CRmfvC9VyhKO7dvRRPbvPut9XM/XHLGQzv3Te7Zsje0fxOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453249; c=relaxed/simple;
	bh=EEUFYL23HwPB43lcPPdzpHoo82V4ls5Xt8PMeJUlkLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCSh4ibU+xyjYrG3dPxxy7h7hBJIXZvBqA6hJkzYWiwx6GChwfwDTvGR8n4USAdMaa7vCdjALgo57o+7u1oqSTXZcCuHuPHjtPi64aoXU6wkh5TVidVvsqGiirr3yVKUTukTJbvFI8/AcetyTNfxgur+kZWzo3rkSsW49M/Kv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5yC71XH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9IwiCcB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5yC71XH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9IwiCcB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785453242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKpylt9BNItQ/yUkXHhBehnJEVudegSbEoMVeY2TqkQ=;
	b=Y5yC71XHJCQrJ+W01IC0pIGGviSZUPOpR7aaUcizDnDevSgfacovouVU2c+v1e5ap1xXry
	gG3SyR8wcLTf1+rAQvbOdupQs1D8xA9DRGPEt5Mt3O5u5ga6WMOlgIVAXI8yE+NSdA2pQT
	lFkPotRe9vkVmg8bF7gCYKjd0fHPEIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-1lKfXR05M1mEBHLIA6mvXA-1; Thu, 30 Jul 2026 19:14:00 -0400
X-MC-Unique: 1lKfXR05M1mEBHLIA6mvXA-1
X-Mimecast-MFC-AGG-ID: 1lKfXR05M1mEBHLIA6mvXA_1785453239
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b4cc049fso1385105e9.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785453239; x=1786058039; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uKpylt9BNItQ/yUkXHhBehnJEVudegSbEoMVeY2TqkQ=;
        b=I9IwiCcB+c96IyoWlLwNi4tc6kewB64Dm24yf19guIUuVhErGE4cMhle8uzUEj6sJQ
         RORl58S9E046hvgkjNUvoLO4t+ta40c0Cn2hlKA6DFB6iV+m2nMaz8IlP9/K9RnIsisE
         pXu72qoHm9c6ddMgCSoI1ApzpXzA1vLqfWyjjIinIYiUZKcyJritxdoQ8OnPHA3vAeXe
         7U/P/Q0mvWAcuDH6kc0X78R6LIJ8INKbD0OmDC3ezlF2AUDMK33aY2xTeS3ZZKoawlY8
         q+19tNKUqNyy28wUFn96iwiinZJOu6aTt1J5eoUleiIhO2S47NCr8sIo3e+l/i0Fx1tJ
         0YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453239; x=1786058039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uKpylt9BNItQ/yUkXHhBehnJEVudegSbEoMVeY2TqkQ=;
        b=P299yIRtgZvSryVD5fdCHsMudT04W01oSZo0Z6e4grLv2hknW/B1GcHpubSqeT5AXz
         3rWIx61lU73N+pFdtA19zj0g5VLaI1Fa4vHne6TnVl/GGqOWebijSaqRaZDxL3hOX8TJ
         c+IOQ0nJ4EMAf0gT3FwCrTK37wjJ6R5oOfD5hzl2JUhU5Md1NmmvItNyaebueFjpZxX+
         XX+y8IcIhmjxvqDzu70FCMJK1KHG2GB/7lGJa+7RUMmqDpaHWzXt/dyg1mackTGRk43Z
         wWk5d7pDx3RSHh/a7Lh0DvJYyFZjuWP2SgwYVOkzOWP81nysAce/2+cAp5abkitc/1ee
         iegw==
X-Gm-Message-State: AOJu0YxAmO3vkp2PsqEUQ3uC/hJHpZ7D+Ty6t2gPiEwgGfCgr0C1ZerF
	fhYPDGyH3YaA/zN5+cWx1CAuYMQo4sYXUGwzUCEtPr8bq/BImi2fuuU+pVW5ebwMdZjZJv9eIc1
	uri3VU2+D1iia/6sA2O5G4A2VSUd9ZL4JxxzyazS9uSAZnjHMYWkMCDrRXhLvZpRD
X-Gm-Gg: AR+sD12BNhAOP9I/hrVeXdqZ2GHe69tUBFlQXz+qBpVL1BxjiK8q/HTJb3hys0MFoEa
	Cz1kEnYVMwSYfa+vXyXHd/+kcWrwf/otwFn4661WcsHpvGHzWz1HbA8jlE8wevR3mFU3G4YSQN4
	ePw76BPBSTgWw7MWmDCergulksfGCBhcR0w8/xdvSxLcILzlNs4aPqE8Fzd6e0npPK6yXGz/Yz4
	Gzzf/nNcRYpUT3L375mcoBi0/xgtbapZ8ooRtritr8N2tq1sU5m08Itid8Z0XE6UQUZjywQ6dJT
	dFfC1DRTTMjtsJrsmHvKNN8Nwa+yMtUHYNhGUl2UpoGteuz6EmkTwNdrho0BKe02DML/wEAy8fW
	GOx3qS/NXLMUpV6xG86a8WCk=
X-Received: by 2002:a05:600c:3151:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-49804ce5207mr34202805e9.3.1785453239298;
        Thu, 30 Jul 2026 16:13:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3151:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-49804ce5207mr34202555e9.3.1785453238844;
        Thu, 30 Jul 2026 16:13:58 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980630ec94sm4702545e9.4.2026.07.30.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:13:58 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:13:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] virtio-blk: mark disk dead on ERS permanent
 failure
Message-ID: <20260730190926-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
 <4740ae91d5be.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4740ae91d5be.1780449274.git.liuxixin@kylinos.cn>

On Fri, Jun 12, 2026 at 06:00:00PM +0800, Xixin Liu wrote:
> After ERS reports pci_channel_io_perm_failure, virtio-pci must ask the
> virtio driver to tear down the block device — not only mark virtqueues
> broken.

Can you tell me was this written with use of AI? I ask because not many
people go out of their way to put in unicode dashes. Next step is what
emojis? Let's not go there pls.
And if yes pls disclose that as per Documentation.

>  Call the virtio driver shutdown hook from virtio-pci on
> perm_failure; virtio-blk implements shutdown with blk_mark_disk_dead().
> Fail new requests early in virtio_queue_rq when the disk is dead or
> virtqueues were removed during frozen reset_prepare.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/block/virtio_blk.c         | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.c | 10 +++++++++-
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..4740ae91d5be 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> +	/* Fail fast if ERS frozen tore down VQs or the disk was marked dead. */
> +	if (unlikely(!disk_live(vblk->disk) || !vblk->vqs || !vblk->vdev)) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_IOERR;
> +	}
> +

Do we need this? virtqueue add will fail anyway.

>  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -1561,6 +1567,29 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +/* Stop I/O and mark the gendisk dead (ERS perm_failure or system shutdown). */
> +static void virtblk_shutdown(struct virtio_device *vdev)
> +{
> +	struct virtio_blk *vblk = vdev->priv;
> +	struct request_queue *q;
> +	unsigned int memflags;
> +
> +	if (!vblk || !vblk->disk)
> +		return;
> +
> +	flush_work(&vblk->config_work);
> +	virtio_break_device(vdev);

why not break first?

> +	q = vblk->disk->queue;
> +	memflags = blk_mq_freeze_queue(q);
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	blk_mq_unquiesce_queue(q);
> +	blk_mq_unfreeze_queue(q, memflags);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> @@ -1684,6 +1713,7 @@ static struct virtio_driver virtio_blk = {
>  	.probe				= virtblk_probe,
>  	.remove				= virtblk_remove,
>  	.config_changed			= virtblk_config_changed,
> +	.shutdown			= virtblk_shutdown,
>  #ifdef CONFIG_PM_SLEEP
>  	.freeze				= virtblk_freeze,
>  	.restore			= virtblk_restore,
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index e2dda946e70e..924ceead436b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -845,7 +845,15 @@ static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
>  	case pci_channel_io_perm_failure:
>  		dev_warn(&pci_dev->dev,
>  			 "permanent failure, disconnecting device\n");
> -		virtio_break_device(&vp_dev->vdev);
> +		{
> +			struct virtio_driver *drv =
> +				drv_to_virtio(vp_dev->vdev.dev.driver);
> +
> +			if (drv && drv->shutdown)
> +				drv->shutdown(&vp_dev->vdev);
> +			else
> +				virtio_break_device(&vp_dev->vdev);
> +		}
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	default:
>  		break;


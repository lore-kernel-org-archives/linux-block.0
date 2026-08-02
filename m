Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A3314A9E
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704358; cv=none; b=gQVtlKQiM8NxLE5f34xzKwvwgK771jM5A83zgy6eGkOA7VBl5eL2po5sz+vDro3ZP9L663eIuVVhWiVZTl2Fhx3KltCTOT4pj+xKFmvu+UrSGhb612sBSveip37puZ9KInkCyqhQsfpC5otL8IgYS12Nou7YMTkS8MbgzOpwixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704358; c=relaxed/simple;
	bh=TufCBztkTKH3AfRWjBpjd3FHGRl2lwcK9tWuFaY9Wt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3RqteyIscS0VhGtVotNWAO/FHzC5fFvGLwVDgxdwCefpliyNqVVkBFD3yDCMatQl+a7XIrfk/JGGV8Xwc02M8W6yBmmSqUzUjkh1zd2C+wUlNWCpxKFIjYkAeGqFg3bq2llmzYZIQxy5cd/AElLg2t5EoZvsu3oBPg0QB5/bvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iu/TRm2g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7tAgSXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu/TRm2g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7tAgSXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785704355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6aw/MfyvAQ+UMZOr4YxAOduk77RukTa3bw+TseKJQI=;
	b=Iu/TRm2gKNWTtW8CZohusyZ5Zr2KptEO4jXFrDfxfdgcBrnhAb/+5wqjfF8f3WkpdcDX8O
	VZXmaHmtfH01IVw5sNQ4ddT0PdyrwWPRKxVtabz4T85POj5nAE1e5yKLsuIAc1iMowaITY
	SbuHIRtHhVftfqEMAsW0AuOI9Z1j43w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-lZXLpDBRPH6OgMYkPcIgZw-1; Sun, 02 Aug 2026 16:59:14 -0400
X-MC-Unique: lZXLpDBRPH6OgMYkPcIgZw-1
X-Mimecast-MFC-AGG-ID: lZXLpDBRPH6OgMYkPcIgZw_1785704353
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so14780815e9.3
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785704353; x=1786309153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B6aw/MfyvAQ+UMZOr4YxAOduk77RukTa3bw+TseKJQI=;
        b=C7tAgSXWDXBaC5qpsYC13AmtUbPzOWCumGi9FQr9sXC3RetsxEA8A9Nq+JlwNSfMmy
         CPAdsSqM0qGHPAR5r/uYn3ui2+23zHxFvY3TAC7CoRNNqEUbTsz7bdzVegq/bNEe3Gxj
         zD2AWZKRLpVFisHfLP2esXRmvQ/pSf62yE3THx+/UqvDnL/7irolKQ20/2m2bQwbZtf7
         5hNiXnAz2tE/lJOSsqVK9XRjLHozTFYBLhHVCYFVCS6i0GZdyOpUDLh1LQgpH4hjU5gG
         6TeSAnk4VfYVDJF8FmVqyzpxkRQdQC0sk1eRnNojU/IGwAPuS7DezEv/pnxTvlK/vhHe
         PaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785704353; x=1786309153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B6aw/MfyvAQ+UMZOr4YxAOduk77RukTa3bw+TseKJQI=;
        b=aDp2TUMMdm6cs/YAq201nWMJ5c70HpGMiQvDdnE7SRRCm7+6r50GUWo9o11Sy11fC5
         qFQjKz9+hUaZ3xvgw+wVvRvfdack08GjlfcaCKOnK5pU2x5FfpM/ck4P2vvjFG8iKLdB
         74NgR4YP75gFqxkMMVebMmPuaMnv10nT7bCbl8UZyRoHUexetcbVLvzwP0Ni86g8NWB0
         dXZpOjTeXY5z7nJy8II7CFTK8JTPXLGjRxlVggii+o3KfsIP+k6k1qyJFoa1+SI+FYkJ
         pGQxG9y08SzvNkxUK1173embqnC6oZPidQmV5t7c8S6ktdNwGsTPNAHifqOf+xcaAM3H
         37ow==
X-Gm-Message-State: AOJu0YzuoPauUR7j7knEf1oAWi+/H4BNdqrp6AphOcsvtL0e5bRMFla0
	Bcj3ZId3m1ZJZnHaj/ektNJMM3Ji+hNXU/ohx9X/fNQNohLKNGNtBcyXwbt0xShxzL+4w6m6Whm
	qRPZ1XaLkVg/2Kdbdgw56JqZpVcHcwj/yFCwLSHRdqHCPuf85fy+5ffuFIE1k2QBvubXIyjCh
X-Gm-Gg: AR+sD13zJD41AFbxBNbiw12rr0z82GzG7ZQMiwTOF4yUcT3DgJTpwFIMwKAXILGNxvX
	ivZO1JWIIRGlyB61TJeEm/Byo+fltTJV8ekQt3JUeKJSU4/MvMu8itpa0mcDsSvM4mTnN23gy7Q
	VpZxdFKwO7D6qHsmAiFfYbO+jDbUcpsMh+/c6dBpG27rwrI1yXLI78UAPgEKwRfO0DgQ/qpKGNi
	T+c9XMdrwUF75rCErFttI8HBiZ5VtHRnJCGYsBDyHkQcntsVY7OFDhXvX9Fcdc6vVhHPybDpUWl
	oA8OiJIP54/0Vh9Rzb62A4Z5+3/ODQ1LuWRttwqOi+HsUWJv0k0EEMGDASDp/7Bqnxja4mfJdRH
	qRcY3xEAJuqMQfiso/h3ueg==
X-Received: by 2002:a05:600c:6990:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4980c673907mr169358165e9.12.1785704353034;
        Sun, 02 Aug 2026 13:59:13 -0700 (PDT)
X-Received: by 2002:a05:600c:6990:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-4980c673907mr169357715e9.12.1785704352602;
        Sun, 02 Aug 2026 13:59:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm25273135f8f.34.2026.08.02.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:59:12 -0700 (PDT)
Date: Sun, 2 Aug 2026 16:59:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
	axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio-blk: mark disk dead on ERS permanent
 failure
Message-ID: <20260802165703-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
 <cover.virtio-blk-ers-v2.1785468000.git.liuxixin@kylinos.cn>
 <4740ae91d5be.v2.1785468000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4740ae91d5be.v2.1785468000.git.liuxixin@kylinos.cn>

On Fri, Jul 31, 2026 at 11:19:00AM +0800, Xixin Liu wrote:
> After ERS reports pci_channel_io_perm_failure, virtio-pci must ask the
> virtio driver to tear down the block device, not only mark virtqueues
> broken.  Call the virtio driver shutdown hook from virtio-pci on
> perm_failure; virtio-blk implements shutdown with blk_mark_disk_dead().
> 
> Fail new requests early in virtio_queue_rq when virtqueues were removed
> during frozen reset_prepare (vqs == NULL).  A broken vq already fails in
> virtqueue_add; no separate disk_live() check is needed.
> 
> Assisted-by: DeepSeek:deepseek-v3
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/block/virtio_blk.c         | 31 ++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.c | 10 +++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..fda2d4f3c7c6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -435,6 +435,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> +	/* VQs may be gone after frozen reset_prepare; avoid NULL deref. */
> +	if (unlikely(!vblk->vqs || !vblk->vdev)) {
> +		blk_mq_start_request(req);
> +		return BLK_STS_IOERR;
> +	}
> +
>  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
>  	if (unlikely(status))
>  		return status;
> @@ -1561,6 +1567,30 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +
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
> +	virtio_break_device(vdev);
> +	flush_work(&vblk->config_work);
> +
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

what happens with requests already outstanding in the queues?
e.g. does this leak memory?

> @@ -1684,6 +1714,7 @@ static struct virtio_driver virtio_blk = {
>  	.probe				= virtblk_probe,
>  	.remove				= virtblk_remove,
>  	.config_changed			= virtblk_config_changed,
> +	.shutdown			= virtblk_shutdown,
>  #ifdef CONFIG_PM_SLEEP
>  	.freeze				= virtblk_freeze,
>  	.restore			= virtblk_restore,
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index fff6b6e2d0c5..957b3282865c 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -849,7 +849,15 @@ static pci_ers_result_t virtio_pci_error_detected(struct pci_dev *pci_dev,
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

So this is blk specifically, I am somewhat lost as to why
is blk treated differently from other drivers here.


>  	default:
>  		break;
> -- 
> 2.43.0


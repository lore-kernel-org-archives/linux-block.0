Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC56BB59
	for <linux-block@vger.kernel.org>; Sun, 18 Feb 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708262842; cv=none; b=tLqoJchgx4atEj6HnXkCU1jLDRrWbKGMn99lC0v5zYeNnu7AyS8uxww6g1dj4KiG+dOzmuAqx4WbmRXmhunh3zi9EBQxr5vx8LQEHpcBB0aXNsmO9x/qRwRGMPPkKFJdShP52sl0GvMObjxKXgBQue2fZrkFIDDJhtyNfxrqUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708262842; c=relaxed/simple;
	bh=f4Dx6hvqZVzIEqQf6wpvnSgfrPOvqhsMyQ1fiFTV+4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmjVRx1z7KkpCpB+H4OugCIcru36W747vFW951T/y2y8DcmiAo0OvU7lt82uu9puvSEbv9MboLxUJYxwNJsclDDzN8AFpxgmc+NtpZf29r+ez/RjXl55Z6LUywMHq3+2YQlJORFJsGOVoQ6CeSzpNaa9lnxmdaZnnD0/Z8m6Qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ia1yFTX9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia1yFTX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708262838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zI+zR2XXQW/D9aVyc+pEnd2ISuA9VtHk+evsQZEFp4=;
	b=ia1yFTX9HNerb/UkwDVwc2L2m/GLliASFIIXyqhlbq0Gl3BYLHiLehUpiOStqhK1u7ipGD
	t4MROtfmil38ZsYD18e1MMQjhlPQFCyxxQUG5KXGA3IwvnLztjMzDlDFZObhDw5kS4sdoI
	htAathujX5F0vJiGfAiycmNZFRz1s6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163--lTrF3NLMiec6SA7GiSFdQ-1; Sun, 18 Feb 2024 08:27:14 -0500
X-MC-Unique: -lTrF3NLMiec6SA7GiSFdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF9F9185A780;
	Sun, 18 Feb 2024 13:27:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E38471C060AF;
	Sun, 18 Feb 2024 13:27:06 +0000 (UTC)
Date: Sun, 18 Feb 2024 21:27:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org, lirongqing@baidu.com,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] virtio_blk: Fix device surprise removal
Message-ID: <ZdIFpqa23YHwJACh@fedora>
References: <20240217180848.241068-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217180848.241068-1-parav@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> When the PCI device is surprise removed, requests won't complete from
> the device. These IOs are never completed and disk deletion hangs
> indefinitely.
> 
> Fix it by aborting the IOs which the device will never complete
> when the VQ is broken.
> 
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
> 
> Verified with multiple device unplug cycles with pending IOs in virtio
> used ring and some pending with device.
> 
> In future instead of VQ broken, a more elegant method can be used. At the
> moment the patch is kept to its minimal changes given its urgency to fix
> broken kernels.
> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 54 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2bf14a0e2815..59b49899b229 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +static bool virtblk_cancel_request(struct request *rq, void *data)
> +{
> +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> +
> +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	return true;
> +}
> +
> +static void virtblk_cleanup_reqs(struct virtio_blk *vblk)
> +{
> +	struct virtio_blk_vq *blk_vq;
> +	struct request_queue *q;
> +	struct virtqueue *vq;
> +	unsigned long flags;
> +	int i;
> +
> +	vq = vblk->vqs[0].vq;
> +	if (!virtqueue_is_broken(vq))
> +		return;
> +

What if the surprise happens after the above check?


Thanks,
Ming


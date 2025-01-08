Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5138F82
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332715; cv=none; b=Mw3OV36XOiYrBLwmvjpznHHmoK+hiFXQsxE7caZ0C/tYKVrmRQn6TdSt+6P8vjqnrDa0qaW1duREt8eiNCsvOSGtWbkbLJj+lhz4/Wq2z0jyAP/Oq4RhHHbQTvNVuivNMzNAl5Wr1yhcr5YE71QxxRuG391YdJwhWPCIyMqzmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332715; c=relaxed/simple;
	bh=uV2rbLRvKErcsxIMP3CpevuVJwnhJk0Qrx+Brr7uCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4b6F/4ei9Lg8Reh8cvJ6Q2x5x9/5ASOtLWtIil39xGfYv68mV07LKHp1qEkzzM7oX6kTtfy48aD7yY0fcdXamHbzpHuIVIDElQogqZY+pozs1GrwOk2PlAs5gEXWMLQFDx2CS/drTwxMpsVq7oNI6l/AZi9Pa4n3TibVrLWk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDFYsoXt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDFYsoXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736332712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6A0lh+ndcSF6DjOirFuduftIcxun2HRRgFxH+ut8x7A=;
	b=jDFYsoXtVspl8gJDHrsAcjfnAvi3irYHk3V/KGSvuZ+XjDwGJ8iXRanIs+iF1F9srcxViQ
	fDoSZqAfSY2RAF2h0lciwZEziZRvHN3SXDDUYMID+9nip5fGKT/W8/nqhVzTdKRq7nxE2n
	ytEdZLHCLRf5fWo+hdnFR2WVLOYUsGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-nmWSk0vGN_afeSn9dDJuhA-1; Wed,
 08 Jan 2025 05:38:28 -0500
X-MC-Unique: nmWSk0vGN_afeSn9dDJuhA-1
X-Mimecast-MFC-AGG-ID: nmWSk0vGN_afeSn9dDJuhA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABD061955F39;
	Wed,  8 Jan 2025 10:38:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C154519560AA;
	Wed,  8 Jan 2025 10:38:20 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:38:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 05/10] block: fix queue freeze vs limits lock order in
 sysfs store methods
Message-ID: <Z35Vl6ob0zLH_Kh-@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-6-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jan 08, 2025 at 10:25:02AM +0100, Christoph Hellwig wrote:
> queue_attr_store() always freezes a device queue before calling the
> attribute store operation. For attributes that control queue limits, the
> store operation will also lock the queue limits with a call to
> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
> need to issue commands to a device to obtain limit values from the
> hardware with the queue limits locked. This creates a potential ABBA
> deadlock situation if a user attempts to modify a limit (thus freezing
> the device queue) while the device driver starts a revalidation of the
> device queue limits.
> 
> Avoid such deadlock by not freezing the queue before calling the
> ->store_limit() method in struct queue_sysfs_entry and instead use the
> queue_limits_commit_update_frozen helper to freeze the queue after taking
> the limits lock.
> 
> (commit log adapted from a similar patch from  Damien Le Moal)
> 
> Fixes: ff956a3be95b ("block: use queue_limits_commit_update in queue_discard_max_store")
> Fixes: 0327ca9d53bf ("block: use queue_limits_commit_update in queue_max_sectors_store")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-sysfs.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f36356cbde0b..2de405cb5f10 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -691,22 +691,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	if (entry->load_module)
>  		entry->load_module(disk, page, length);
>  
> -	mutex_lock(&q->sysfs_lock);
> -	blk_mq_freeze_queue(q);
>  	if (entry->store_limit) {
>  		struct queue_limits lim = queue_limits_start_update(q);
>  
>  		res = entry->store_limit(disk, page, length, &lim);

Looks fine, but now ->store_limit() is called without holding
->sysfs_lock, maybe it should be documented.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0737BE9B
	for <linux-block@vger.kernel.org>; Sun, 29 Mar 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795113; cv=none; b=Fd/jc8BJgpof93IjPjXAtU41n9RR/8K/rCdh2V5z6eZSfp00zy0IeVshPblKCZVRgBXT8eatFAokJiIwOtFp7mDjS51NQeJSHCWgVduB9zN542h5xAoDixACswZ78hXxWgsNZTW8JIlGAIA1ITDja22OIUl4TlhhGqAtqjs16K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795113; c=relaxed/simple;
	bh=lYXT/ySOXRF1c/LifpMq9MVbhxezwyuJmB4tkyakAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKoBCV3LL3d7RcWBiRv+Npdb3LGrVN4iz1dcPhBtUvWgowk+6GxJlh5Loo6j3jSQ7B1pIdLuYAZ7uFCMzW9jB+NgYvj0n0CIe8+DiUe/WYsF8gzLXHqtSBLuulCJ0XglnWmoPNQUgr+JgkJD7s6Zc1RKoXHLthWWBOWRmNEuQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0z7l+fb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0z7l+fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774795110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiOkT5mIz35A7YCvuIAS/P9pLPg54yp9Sb/mJ5MEYE8=;
	b=h0z7l+fblV5pWrzmjSo+LrNb8Jpe5Ci+qLDGfGIYKfBRLbiB3NnM/e5f2LeO2kIHN/fsWU
	j2gtiKhzdb/92zHMaFWJdttGAaBR6M6uf3IUukp5j6A18IbMcP+TmR+q0S6dvBglkPm78P
	HvDkB82Loqco9ESxai78cIkEQhEx8b4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-0Tt05iomML25Gh-B8oLjyw-1; Sun,
 29 Mar 2026 10:38:25 -0400
X-MC-Unique: 0Tt05iomML25Gh-B8oLjyw-1
X-Mimecast-MFC-AGG-ID: 0Tt05iomML25Gh-B8oLjyw_1774795103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A7C5180044D;
	Sun, 29 Mar 2026 14:38:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67D7A1800361;
	Sun, 29 Mar 2026 14:38:19 +0000 (UTC)
Date: Sun, 29 Mar 2026 22:38:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 4/6] block: Reduce the minimum value for the maximum
 DMA segment size
Message-ID: <ack5VqUS_gRuxodF@fedora>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327211349.2239633-5-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Mar 27, 2026 at 02:13:44PM -0700, Bart Van Assche wrote:
> All block devices that are supported by the Linux kernel have a DMA engine
> that supports DMA segments of 4 KiB or larger. Allow smaller DMA segment
> sizes because these are useful for block layer testing. Reject values below

Can you share why/what it is useful just for test purpose?

If there isn't such real device with 512 segment size, why do we want this
change for covering it?

> 512 because such values would result in an excessive number of DMA
> segments. Move the BLK_MIN_SEGMENT_SIZE definition into <linux/blkdev.h>.
> This will allow the BLK_MIN_SEGMENT_SIZE constant to be used in the
> null_blk and scsi_debug drivers.
> 
> The only code affected by this change is the following code:
> 
> 	if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
> 		return -EINVAL;
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk.h            | 1 -
>  include/linux/blkdev.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 103cb1d0b9cb..b30ff8db3cac 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -23,7 +23,6 @@ struct elv_change_ctx;
>  #define BLK_DEF_MAX_SECTORS_CAP	(SZ_4M >> SECTOR_SHIFT)
>  
>  #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
> -#define	BLK_MIN_SEGMENT_SIZE	4096
>  
>  /* Max future timer expiry for timeouts */
>  #define BLK_MAX_TIMEOUT		(5 * HZ)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b8e7f42aee71..109d5fa5e190 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1311,6 +1311,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
>  enum blk_default_limits {
>  	BLK_MAX_SEGMENTS	= 128,
>  	BLK_SAFE_MAX_SECTORS	= 255,
> +	BLK_MIN_SEGMENT_SIZE	= 512,
>  	BLK_MAX_SEGMENT_SIZE	= 65536,
>  	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,

This change actually becomes not consistent with previous patch, in which ->seg_boundary_mask
can be 4095.


Thank,
Ming


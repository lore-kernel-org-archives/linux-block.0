Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B837175A4
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708574570; cv=none; b=X2x8OQXumQqadUdT2q81icQTHQwCWKKezK8mfF8yYwZda/HqmaaHLHiFT26FdF7GNjsYAD+b37XfcSJgmc4ydMRM+FyKEBhiscA2bA/AonxizQGre4WwgAB3AkUec1OGaSXhHdP8V586s6V7mtEp3Z6vPj05ls8YqhICo5bGSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708574570; c=relaxed/simple;
	bh=gq1g55Hq+x76NcTPbCa42KxBSFkx15M0/rAbbFHY6GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXfMMTH9hxwTh5uhYghM1GxgKjZiti9G9+AG+NqpQuwMjoKMEou5iVlrddtByEN9UMrfW/r/gkZWWgP5OGOjAFoxCFFqoKj+HFcJ+ELgOr2xugKYLBhopirHR00ulLc4OGQlFUsoglPAqTSBybiscS71BlcV5z2m0cxm1LOpixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIrknc/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIrknc/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708574568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ytFsXMyry4S7SdopK8T+BQ45nCcb77fjTxsjPc2ROnU=;
	b=YIrknc/BjpSKzAxOG+sijrRSiEuWcDp8+aNVEk26cEPLxKrm4ttx39605inAFAsvBsE+Hs
	oBUBtXiL5H9wBSMcSFx/ZVG0rDb4NUkDgFJQ9xP/0T36dFWtLMXteq4zHiQug3wUoK5Z4K
	RXt+maeDVlFYjScOgI/p3bk1MWUt12U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-bBRYuP8lOuiwVlftPD9hlg-1; Wed, 21 Feb 2024 23:02:44 -0500
X-MC-Unique: bBRYuP8lOuiwVlftPD9hlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2311811E81;
	Thu, 22 Feb 2024 04:02:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.49])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A6EC185C0;
	Thu, 22 Feb 2024 04:02:39 +0000 (UTC)
Date: Thu, 22 Feb 2024 12:02:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org,
	Keith Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv2] blk-lib: check for kill signal
Message-ID: <ZdbHXDCquO23rbJk@fedora>
References: <20240221222013.582613-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221222013.582613-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Feb 21, 2024 at 02:20:13PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some of these block operations can access the entire device capacity,
> and can take a lot longer than the user expected. The user may change
> their mind about wanting to run that command and attempt to kill the
> process, but we're running uninterruptable, so they have to wait for it
> to finish, which could be hours.
> 
> Check for a fatal signal at each iteration so the user doesn't have to
> wait for their regretted operation to complete.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> Reported-by: Conrad Meyer <conradmeyer@meta.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Changes from v1:
> 
>   Check the kill signal on all the long operations, not just the
>   zero-out fallback.
> 
>   Be sure to return -EINTR on the condition.
> 
>   After the kill signal is observered, instead of submitting and waiting
>   for the current parent bio in the chain, abort it by ending it
>   immediately and do the final bio_put() after every previously submitted
>   chained bio completes.

I feel this way is fragile:

1) user sends KILL signal

2) discard API returns

3) submitted discard requests are still run in background, and there
can be thousands of such bios

4) what if application or FS code(such as meta) starts to write data to
the discard range?

> 
>  block/blk-lib.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e59c3069e8351..88f6a4aebe75e 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -35,6 +35,17 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
>  	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
>  }
>  
> +static void abort_bio_endio(struct bio *bio)
> +{
> +	bio_put(bio);
> +}
> +
> +static void abort_bio(struct bio *bio)
> +{
> +	bio->bi_end_io = abort_bio_endio;
> +	bio_endio(bio);
> +}
> +
>  int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
>  {
> @@ -77,6 +88,10 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		 * is disabled.
>  		 */
>  		cond_resched();
> +		if (fatal_signal_pending(current)) {
> +			abort_bio(bio);
> +			return -EINTR;
> +		}
>  	}
>  
>  	*biop = bio;
> @@ -146,6 +161,10 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  			nr_sects = 0;
>  		}
>  		cond_resched();
> +		if (fatal_signal_pending(current)) {
> +			abort_bio(bio);
> +			return -EINTR;
> +		}
>  	}
>  
>  	*biop = bio;
> @@ -190,6 +209,10 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
>  				break;
>  		}
>  		cond_resched();
> +		if (fatal_signal_pending(current)) {
> +			abort_bio(bio);
> +			return -EINTR;
> +		}
>  	}
>  
>  	*biop = bio;
> @@ -337,6 +360,11 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  			break;
>  		}
>  		cond_resched();
> +		if (fatal_signal_pending(current)) {
> +			abort_bio(bio);
> +			ret = -EINTR;
> +			bio = NULL;
> +		}

The handling for blkdev_issue_secure_erase is different with others, and
actually it doesn't return immediately, care to add comment?


Thanks,
Ming


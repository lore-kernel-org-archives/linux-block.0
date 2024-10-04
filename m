Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66171739
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020315; cv=none; b=fYR21XFIs5ZTBUFL9ZDDuTEq0FLsIaGUn3teHeUHjDhbgVlTVuHluaqghfdilVI64ufAISoZzW5wqUWmBZvBpiyytMO0kFQVNHQWzEbLPVxNW0W6STR2vFXhrzGTSc/i2xLeOWS+3Vgc+QfJpNUgKTG9JyeUorm2MoTm0ah+IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020315; c=relaxed/simple;
	bh=YA01kvzOPgprLZABAlrdwx1ZNwemAB3HCjaW6Xy+STo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNmeWNBBjupjRU6TeovtntJtmiWjxAaGdzVQgB1beD1xMzaNIsxlsjgwfMo4OSpsgtIdNJSwkP/KoKv9xT3ogLJtDliItd1mov0FP7OGcRDTLGsgHyb8Z3LJocJg42bk8C5yC0WvEe7gsWSxpG3YPb4T1qZAv3fyB/9tLrSLGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A578F227A87; Fri,  4 Oct 2024 07:38:29 +0200 (CEST)
Date: Fri, 4 Oct 2024 07:38:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] block: enable passthrough command statistics
Message-ID: <20241004053828.GA14377@lst.de>
References: <20241003153036.411721-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003153036.411721-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 03, 2024 at 08:30:36AM -0700, Keith Busch wrote:
> +What:		/sys/block/<disk>/queue/iostats_passthrough
> +Date:		October 2024
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] This file is used to control (on/off) the iostats
> +		accounting of the disk for passthrough commands.
> +
>  
>  What:		/sys/block/<disk>/queue/logical_block_size
>  Date:		May 2009
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 5463697a84428..d9d7fd441297e 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] = {
>  	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
>  	QUEUE_FLAG_NAME(HCTX_ACTIVE),
>  	QUEUE_FLAG_NAME(SQ_SCHED),
> +	QUEUE_FLAG_NAME(IOSTATS_PASSTHROUGH),
>  };
>  #undef QUEUE_FLAG_NAME
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8e75e3471ea58..cf309b39bac04 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -993,13 +993,38 @@ static inline void blk_account_io_done(struct request *req, u64 now)
>  	}
>  }
>  
> +static inline bool blk_rq_passthrough_stats(struct request *req)
> +{
> +	struct bio *bio = req->bio;
> +
> +	if (!blk_queue_passthrough_stat(req->q))
> +		return false;
> +
> +	/*
> +	 * Stats are accumulated in the bdev part, so must have one attached to
> +	 * a bio to do this
> +	 */
> +	if (!bio)
> +		return false;
> +	if (!bio->bi_bdev)
> +		return false;

Missing. At the end of the sentence.  But even then this doesn't
explain why not accouting these requests is fine.

 - requests without a bio are all those that don't transfer data
 - requests with a bio but not bdev are almost all passthrough requests
   as far as I can tell, with the only exception of nvme I/O command
   passthrough.

I.e. what we have here is a special casing for nvme I/O commands.  Maybe
that's fine, but the comments and commit log should leave a clearly
visible trace of that and not confuse the hell out of people trying to
understand the logic later.

> +	/*
> +	 * Ensuring the size is aligned to the block size prevents observing an
> +	 * invalid sectors stat.
> +	 */
> +	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
> +		return false;

Now this probably won't trigger anyway for the usual workload (although
it might for odd NVMe command sets like KV and the SLM), but I'd expect the
size to be rounded (probably up?) and not entirely dropped.

> +	ret = queue_var_store(&ios, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ios)
> +		blk_queue_flag_set(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
> +				   disk->queue);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
> +				     disk->queue);

Why is this using queue flags now?  This isn't really blk-mq internal,
so it should be using queue_limits->flag as pointed out last round.


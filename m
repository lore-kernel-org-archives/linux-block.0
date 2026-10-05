Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01A401492;
	Mon,  5 Oct 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190580; cv=none; b=WD8p9kWpwVvP/av52rFnPH4kbKuJ8kvkIctH0X09QaYwgkSm5opwpdkBGXCtPR6ympFOaWKP0XDFAQCZI5NdNptoAV03goQsJHSZ7AfIKGIC7Wk34xHhFBtywIC/aRMXSCC5idM8sPVXVTKWCCDyaYlAHIQluTINysE2r5EKh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190580; c=relaxed/simple;
	bh=lmzl3i3Eu5fcNfLgReC8s0rQZ7zIUSnmHYRnCTrbNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojhoCcO9ZHjswnk36wgrypIOvI3tVVaH2ajk+2vg8aD8hf6pC7a/jA7UM7LA1JOt5aeKxBz0K2/JBsOx5+3rd+cSpAlw7rE1C7JzeO1mymoQZNjXKHum0XKnvwegGVh7jXM2nAmRLZQ2luF0LugHZqtrgjmM1f7j5g56WvRed9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA0C168BFE; Mon,  5 Oct 2026 10:56:13 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:56:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v3 for-next 2/3] block: allow error injection rules to delay
 bios
Message-ID: <20261005085613.GB9160@lst.de>
References: <20260928221634.43239-1-haris.iqbal@linux.dev> <20260928221634.43239-3-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928221634.43239-3-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 29, 2026 at 12:16:33AM +0200, Md Haris Iqbal wrote:
> +static void blk_error_inject_delay_work(struct work_struct *work)
> +{
> +	struct blk_error_inject_delay *d = container_of(to_delayed_work(work),
> +			struct blk_error_inject_delay, dwork);
> +	struct bio *bio = d->bio;
> +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> +	blk_status_t status = d->status;
> +
> +	kfree(d);
> +
> +	if (status != BLK_STS_OK) {
> +		pr_info_ratelimited("%pg: injecting %s error for %s at sector %llu:%u\n",
> +				disk->part0, blk_status_to_str(status),
> +				blk_op_str(bio_op(bio)), bio->bi_iter.bi_sector,
> +				bio_sectors(bio));
> +		bio->bi_status = status;
> +		bio_endio(bio);

This duplicates the tail of __blk_error_inject, please share the code.

> +	} else {

And return after this to keep the other path straight line.

> +/*
> + * Hand the bio to a workqueue that submits or fails it once the delay has
> + * expired.  Both blk_mq_submit_bio() and ->submit_bio can sleep, so this can't
> + * be completed from the timer itself.
> + *
> + * Returns false if the bio can't be delayed, in which case the caller handles
> + * it immediately instead.
> + */

I'd drop the comment, it just states what is obvious from the code
below.

> +static bool blk_error_inject_delay(struct gendisk *disk, struct bio *bio,
> +		blk_status_t status, unsigned int delay_us)
> +{
> +	struct blk_error_inject_delay *d;
> +
> +	/* never block a bio that asked not to be blocked */
> +	if (bio->bi_opf & REQ_NOWAIT)
> +		return false;

We should probably complete it with BLK_STS_AGAIN as we would do
for a real delay? 

> +
> +	d = kmalloc_obj(*d, GFP_NOIO);
> +	if (!d)
> +		return false;

Should we log a warning that the intended delay did not happen?

> +	/*
> +	 * Mark the bio before queueing the work, which can complete it as soon
> +	 * as it is queued.  Splitting happens below the injection hook, but
> +	 * bio_submit_split_bioset() resubmits the remainder through the hook
> +	 * again, and as bio_split() only advances the original bio that
> +	 * remainder still matches the same rule.  Without this a bio would be
> +	 * delayed once per split.
> +	 */

Over-eager comment.  But we should probably also set the flag for
non-delayed bios anyway and do it as soon as any rule matches?

> +static int __init blk_error_injection_init_wq(void)
> +{
> +	/*
> +	 * WQ_MEM_RECLAIM so that a delayed bio on the reclaim path can still
> +	 * find a worker under memory pressure.  Note that this only guarantees
> +	 * a worker exists, not that it is free: submitting a bio can block on
> +	 * a queue freeze or on tag allocation, so a delayed bio can still be
> +	 * held up behind another one.
> +	 */

Very long comment explaining the obvious, everything doing I/O needs
WQ_MEM_RECLAIM.  Please drop it.

> +	blk_error_inject_wq = alloc_workqueue("blk_error_inject", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);

Overly long line.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 98e21b4cbf32..50e28dc0f1f9 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -323,6 +323,7 @@ enum {
>  	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>  	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>  	BIO_COMPLETE_IN_TASK, /* complete bi_end_io() in task context */
> +	BIO_ERROR_INJECTED, /* error injection rules already applied */
>  	BIO_FLAG_LAST
>  };

With this we've used up the last BIO_ flag.  I hope this won't
cause problems in the future..


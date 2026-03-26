Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A038C2A4
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506353; cv=none; b=CHJ80uP9NvSYo0+Y7xbVnAZyXD5eYBs430RaN2fsgmFvEovyFmttNqdMEKJhHUorPzBE/OeABxBAYTjy2vNMKe9+5wVZ6oPDdSlAAS4/wwUSZaReLSCrxmrV2lA6idNNUnZyDXszC49I7m79N7P8+CWDDydUmHkywsMVnrOqyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506353; c=relaxed/simple;
	bh=em8RyiC6zpcatH3eis8BKkRFTt4f7dPRE4bHVphFHBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBxyJ3XI9saW3PplYmzQLHluHu1PA9yhoXl66BPgNDlwadHmSku6EvVed96aXQUfvMDRijw4c6o8ZrnKvKjTfhnlUBUgNT//Jrgbkc71GjLv5+FdTAxWp/91VcvZpn9pXSfFMJ+s4qEt7E0PK+oSJgMPg+94nLOilomq6SMQ3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABCCC68B05; Thu, 26 Mar 2026 07:25:49 +0100 (CET)
Date: Thu, 26 Mar 2026 07:25:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 03/26] block/cgroup: Split blkg_conf_prep()
Message-ID: <20260326062549.GD24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:44PM -0700, Bart Van Assche wrote:
> Move the blkg_conf_open_bdev() call out of blkg_conf_prep() to make it
> possible to add lock context annotations to blkg_conf_prep(). Change an
> if-statement in blkg_conf_open_bdev() into a WARN_ON_ONCE() call. Export
> blkg_conf_open_bdev() because it is called by the BFQ I/O scheduler and
> the BFQ I/O scheduler may be built as a kernel module.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/bfq-cgroup.c |  4 ++++
>  block/blk-cgroup.c | 16 ++++++----------
>  block/blk-iocost.c |  4 ++++
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index ac83b0668764..38396df9dce7 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -1051,6 +1051,10 @@ static ssize_t bfq_io_set_device_weight(struct kernfs_open_file *of,
>  
>  	blkg_conf_init(&ctx, buf);
>  
> +	ret = blkg_conf_open_bdev(&ctx);
> +	if (ret)
> +		goto out;
> +
>  	ret = blkg_conf_prep(blkcg, &blkcg_policy_bfq, &ctx);
>  	if (ret)
>  		goto out;
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 2d7b18eb7291..8cfdbe9fffdc 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -771,10 +771,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_init);
>   * @ctx->input and get and store the matching bdev in @ctx->bdev. @ctx->body is
>   * set to point past the device node prefix.
>   *
> - * This function may be called multiple times on @ctx and the extra calls become
> - * NOOPs. blkg_conf_prep() implicitly calls this function. Use this function
> - * explicitly if bdev access is needed without resolving the blkcg / policy part
> - * of @ctx->input. Returns -errno on error.
> + * Returns: -errno on error.
>   */
>  int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
>  {
> @@ -783,8 +780,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
>  	struct block_device *bdev;
>  	int key_len;
>  
> -	if (ctx->bdev)
> -		return 0;
> +	WARN_ON_ONCE(ctx->bdev);

Return on this case?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

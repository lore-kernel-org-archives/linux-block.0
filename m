Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D34239E7D
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835410; cv=none; b=ajdo9uL1QxGrOzoVSrWmQC7niWxt5kXGbKN0XM8S9bq6kA6Vu0I2tWWr+jXzQOM5xnm0Pf7e2ZCA04uDpSY1nvemKMWPA28NDRS6RzlPcX/62NLXqHufm752g/fZen66Bz7EmCQt6MAcg4PLoMOQ91cPXnGxeM+VPVu/xmmf7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835410; c=relaxed/simple;
	bh=pza0sHlsefYrnnh/RzNe0H98jjuPtAof3ZiA2WkuHVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIBd/9CQum16lJ5mIPOqAZ5vHP3WHnHl2oXXXKM450Kt08Vv1/xNZswApAky6gP9+gooVHgfsDsokbThwWFK9dV+mNZum1BERQLgtlo/+y9eD/iAIHzecJY96FV7kxnDdLfu1nRj85iHAUUHCXI+Px9C+FtpUSm4++ZSIjBOag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F4EA227A87; Sun, 10 Aug 2025 16:16:44 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:16:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 6/8] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <20250810141643.GG4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:24AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide integrity metadata helpers equivalent to the data payload
> helpers for iterating a request for dma setup.

Can you please also convert the SG mapping helpers to use the low-level
iterator first like I've done for the data path?  That ensures we have
less code to maintain, common behavior and also smaller kernel binaries.

> +static bool __blk_map_iter_next(struct blk_map_iter *iter)
> +{
> +	if (iter->iter.bi_size)
> +		return true;
> +	if (!iter->bio || !iter->bio->bi_next)
> +		return false;
> +
> +	iter->bio = iter->bio->bi_next;
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	if (iter->is_integrity) {
> +		iter->iter = iter->bio->bi_integrity->bip_iter;
> +		iter->bvec = iter->bio->bi_integrity->bip_vec;
> +		return true;
> +	}
> +#endif
> +	iter->iter = iter->bio->bi_iter;
> +	iter->bvec = iter->bio->bi_io_vec;
> +	return true;

I wonder if we should use the bio_integrity() that would introduce two
(probably optimized down to one by the compiler) extra branches for the 
integrity mapping that are easily predicted, but make the think look much
nicer as it would kill the ifdef and the ugly structure around it:

	if (iter->is_integrity) {
		iter->iter = bio_integrity(iter->bio)->bip_iter;
		iter->bvec = bio_integrity(iter->bio)->bip_vec;
	} else {
		iter->iter = iter->bio->bi_iter;
		iter->bvec = iter->bio->bi_io_vec;
	}

	return true;

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev,  struct dma_iova_state *state,
> +		struct blk_dma_iter *iter)

Can you please add a kerneldoc comment here, which could be easily
adapter from the data mapping path.

> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,
> +               struct device *dma_dev, struct blk_dma_iter *iter)

Same here.


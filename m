Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D062E555
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084024; cv=none; b=S6EGG06eahoWoX/UqatLvwqY/bnteiTkGxtn7HwrAMRwbrSpbMkhl1qh6Q6ebNjBvhH0tp9fWzz498P9U7L8buol8uaRXRlMX7sJh2x2CemAUiDya0nAKuRODKI9WBdZyCs16oWlB26SBswHkf85vepaps5QCbZYJnxVo7EMkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084024; c=relaxed/simple;
	bh=qbl3dFGSxAjvpHe5LoN0JgPA1d4ot6RSjj9xhcRRf1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZBQi8pe2fK2ck8ZMp1DtKtqWxhKFk9jQW+FOH1YaQPM3qeoOaV7Rt0pAic9VSQw2Zxrb2KBFPGFz0eCSj8qaHdVjGdJTyS1MofWrRcK4CpPdGQyAI3GwnrZem7mvv0GyTlJWPbtZ012OIK+blGDdlSj8lXOloQ8zCSAIpKwBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 555EE68B05; Mon, 21 Jul 2025 09:46:58 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:46:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 6/7] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <20250721074658.GG32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 20, 2025 at 11:40:39AM -0700, Keith Busch wrote:
> +static bool blk_dma_iter_next(struct blk_dma_iter *iter)

This is at the blk_map_iter level and one level below dma, so it
should not have a dma in the name.  I'm not entirely sure what a good
name is, though.  Maybe blk_map_iter_next_bio wich was the original
intention behind the refactored loop, although it isn't quite true
with the later !iter->iter.bi_bvec_done addition.

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev,  struct dma_iova_state *state,
> +		struct blk_dma_iter *iter)
> +{
> +	unsigned len = bio_integrity_bytes(&req->q->limits.integrity,
> +					   blk_rq_sectors(req));
> +	iter->iter = req->bio->bi_integrity->bip_iter;
> +	iter->bvec = req->bio->bi_integrity->bip_vec;
> +	iter->integrity = true;
> +	return blk_dma_map_iter_start(req, dma_dev, state, iter, len);
> +}
> +EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
> +
> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,
> +               struct device *dma_dev, struct blk_dma_iter *iter)

The wans kernel doc comments that can be mostly copy and pasted
from the data mapping version.

Also it would be great to convert the integrity sg mapping and
count macros to blk_dma_map_iter_ just like I did for the data
version.

> +bool blk_rq_integrity_dma_map_iter_start(struct request *req,
> +		struct device *dma_dev,  struct dma_iova_state *state,
> +		struct blk_dma_iter *iter)
> +{
> +	return false;
> +}
> +bool blk_rq_integrity_dma_map_iter_next(struct request *req,

As you've probably noticed from the buildbot these need to be inline.

> @@ -18,6 +18,7 @@ struct blk_dma_iter {
>  	struct bvec_iter		iter;
>  	struct bio			*bio;
>  	struct pci_p2pdma_map_state	p2pdma;
> +	bool				integrity;

Add an is_ prefix for the new field?  Or replace it with checks
for ->bvec (or ->bvec_table as it should be) != bio->bi_io_vec?


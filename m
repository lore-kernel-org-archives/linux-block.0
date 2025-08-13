Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFC186295
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067831; cv=none; b=C8nle6az5z3/8G6Ay7z/oDwKpfBRxFRsijsPEIFpiUbf+3/MfFhUetJ3HpzjhSjbqWxw4XKTwYvy6sLFvkBYxTnHiq1zrge+47D1i4aI2s8yczDwy33fuB91nTQPkAT3SC/dRnFigrTt3UFLjNPufsXLFb9IneT6AmnBf2d3sdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067831; c=relaxed/simple;
	bh=LVhBQ/o9P5G/7E4z/duDko1BgX1uy3YBs2okd9rZOxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl2PbhLwqbm01O7MTV3Kfav1Zk7Cf25MWSH3AV+WXg18eVkHiVJoIzuD865hMh8g2eOYmGZlHYYLroCJBopDcRSY7TSEOiFqAuytkY/7wgglDzyWl+c8cnb91Q3VnmK2ovMZL3SmdjeNebDKv/WsGl+KD/SVFwcxszCvf8tbmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99004227A87; Wed, 13 Aug 2025 08:50:24 +0200 (CEST)
Date: Wed, 13 Aug 2025 08:50:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv6 6/8] blk-mq-dma: add support for mapping integrity
 metadata
Message-ID: <20250813065024.GA11825@lst.de>
References: <20250812135210.4172178-1-kbusch@meta.com> <20250812135210.4172178-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135210.4172178-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 12, 2025 at 06:52:08AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide integrity metadata helpers equivalent to the data payload
> helpers for iterating a request for dma setup.

This actually does two things:

  1) convert the existing SG helpers
  2) add the new helpers

Which probably should be split into a separate patches, and all of them
could use a more detailed commit log.

> +	struct blk_map_iter iter;
> +	struct phys_vec vec;
> +
> +	iter = (struct blk_map_iter) {
> +		.bio = bio,
> +		.iter = bio_integrity(bio)->bip_iter,
> +		.bvecs = bio_integrity(bio)->bip_vec,
> +		.is_integrity = true,
> +	};

Just initialize iter at declaration time:

> +	struct blk_map_iter iter = {
> +		.bio = bio,
> +		.iter = bio_integrity(bio)->bip_iter,
> +		.bvecs = bio_integrity(bio)->bip_vec,
> +		.is_integrity = true,
> +	};

> +static bool __blk_map_iter_next(struct blk_map_iter *iter)
> +{
> +	if (iter->iter.bi_size)
> +		return true;
> +	if (!iter->bio || !iter->bio->bi_next)
> +		return false;
> +
> +	iter->bio = iter->bio->bi_next;
> +	if (iter->is_integrity) {
> +		iter->iter = bio_integrity(iter->bio)->bip_iter;
> +		iter->bvecs = bio_integrity(iter->bio)->bip_vec;
> +	} else {
> +		iter->iter = iter->bio->bi_iter;
> +		iter->bvecs = iter->bio->bi_io_vec;
> +	}
> +	return true;
> +}

This seems unused, even with all patches applied.

> -static inline struct scatterlist *
> -blk_next_sg(struct scatterlist **sg, struct scatterlist *sglist)
> -{
> -	if (!*sg)
> -		return sglist;
> -
> -	/*
> -	 * If the driver previously mapped a shorter list, we could see a
> -	 * termination bit prematurely unless it fully inits the sg table
> -	 * on each mapping. We KNOW that there must be more entries here
> -	 * or the driver would be buggy, so force clear the termination bit
> -	 * to avoid doing a full sg_init_table() in drivers for each command.
> -	 */
> -	sg_unmark_end(*sg);
> -	return sg_next(*sg);
> -}

Maybe just add the metadata mapping helpers into this file instead of
moving stuff around?

> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -449,4 +449,30 @@ static inline bool blk_mq_can_poll(struct request_queue *q)
>  		q->tag_set->map[HCTX_TYPE_POLL].nr_queues;
>  }
>  
> +struct phys_vec {
> +	phys_addr_t	paddr;
> +	u32		len;
> +};

Leon has a patch to move this to linux/types.h, which if we have to
move it is probably a better place.

Otherwise this looks good.

Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF133ADA4
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261955; cv=none; b=ZVM8770JDe14hr9dzpJyLQ/mNBqETC3cIgm8m8nCXAFyRasrkDjSTxbwzS1ft3N+/qpVVvUBbVISG0pqlUg/PqDAAMNK+FxxRgBV3T//kKWd0Qns3Cd8l14WY0BIFvMuIMEgikkeqnvm0B4NP7b5eh0qCe11ScbEWp+GPhurLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261955; c=relaxed/simple;
	bh=5AqVvAViXK/cUM3On30aG63OxNS0lhHynXdn/VlVc74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuF6XCY37py5bH5XHQh/pNsYD+ZvNBfRZ/qX9fY5YjxbChRKD8QSca3BReIbq0GIrbFImJb8iv6O62ZzwLxNtXO5Zjf6acPyrXn3qyoQ6iEQvii+pkJ659K4zUm0DJuT4ITP47QJAfYuxXe8BVoOfs+A24lC63O872+q8wFVev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E039168BFE; Wed, 20 May 2026 09:25:48 +0200 (CEST)
Date: Wed, 20 May 2026 09:25:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com,
	coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 4/5] block: move bio validation into
 __bio_split_to_limits
Message-ID: <20260520072548.GC14937@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519172326.3462354-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Replying here, but at least the high-level issue applies to the
previous patch as well.

Moving the checking from submit_bio_noacct into __bio_split_to_limits
means that we lose it for bio-based drivers except for the few that
manuall call bio_split_to_limits.  So we'll still need a helper for
them, which could be called just before calling into ->submit_bio.

> -static inline blk_status_t blk_check_zone_append(struct request_queue *q,
> -						 struct bio *bio)
> -{

Keeping a helper for this instead of doing a lot of work in a switch
statements feels nicer.

> -static blk_status_t blk_validate_atomic_write_op_size(struct request_queue *q,
> -						 struct bio *bio)
> -{
> -	if (bio->bi_iter.bi_size > queue_atomic_write_unit_max_bytes(q))
> -		return BLK_STS_INVAL;
> -
> -	if (bio->bi_iter.bi_size % queue_atomic_write_unit_min_bytes(q))
> -		return BLK_STS_INVAL;
> -
> -	return BLK_STS_OK;
> -}

Similar for this one.


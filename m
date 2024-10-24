Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7316D9AF
	for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745793; cv=none; b=Tof/rZlFVC9IIQsQlh/28L4dVyJyuqGR0ROWTpOuw5IGETPvgUN30IsStGgTYHRZMEQS5McZ4aY2NkyZIrCr7ci6ymHQ0kvQd25pa5VCJnXyik6/L9MiFrAgatka/vPtw7VOOGOaGaov8ZVyd7dAfiLz99uJCbtdAC/f3TF7UFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745793; c=relaxed/simple;
	bh=JJWRfGo6MxzmkTOu42cGuiXZMrFR7qtIOVQBlSX2gbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8gqvSDJJOLenUP/GyfWjtbjOcUfDv3xU506mg5Q2OFBpvK3PRg+PE3MI+jG+vMfJ9CURrEMVGUjAUHkItFUbUjZ9+JeVE+Cwnpyet20zZRSscXhzcfzxPHqTm4xAb4e35kOh0Y3DHa/Kqr644IPY4EaLqikZABNpdisOIugjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14DDD227A87; Thu, 24 Oct 2024 06:56:23 +0200 (CEST)
Date: Thu, 24 Oct 2024 06:56:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Xinyu Zhang <xizhang@purestorage.com>
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Message-ID: <20241024045622.GA30309@lst.de>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023211519.4177873-1-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 23, 2024 at 03:15:19PM -0600, Uday Shankar wrote:
> @@ -600,9 +600,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
>  		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
>  			goto put_bio;
>  		if (bytes + bv->bv_len > nr_iter)
> -			goto put_bio;
> -		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
> -			goto put_bio;
> +			break;

So while this fixes NVMe, it actually breaks just about every SCSI
driver as the code will easily exceed max_segment_size now, which the
old code obeyed (although more by accident).

The right thing here is to probably remove blk_rq_map_user_bvec entirely
and rely on the ITER_BVEC extraction in iov_iter_extract_pages plus
the bio_add_hw_page in bio_map_user_iov.


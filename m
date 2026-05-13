Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE33955D1;
	Wed, 13 May 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660377; cv=none; b=EiJ++j54L7z9loZVY6fHpxyGvc38gqUzI8yQqZHXrB8+Kh+ERPn++KQotrf51RIohki7MVOlDMBrbH8fjE0C3xm38xjBVqRTJTcMsa0cdkdyhJMa+a1ocI9pVAvLdIJS0eVDFT9BFUQWHAlV8LUccOymDiTvw+CzkZhYAs+aweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660377; c=relaxed/simple;
	bh=+JQ9cLPUbeJWosEYYPdyBS9sQLzGNBxTI2epVpo/7oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BINfG6hxi81gJyIpz6/bbrwPKDyLFQFogQcq6stuhkMMm+H+DP9+KJ9U81DFLauY0O7rkxpg0dV5xNX90rc+CjXdr09CTqQTFPOykIdXdWCFczD3aGeomxJWJpkZVZO1/hgyehbSIBpLoOl6QCkH1dKdHJ2v6J41yt4vj71CFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25C4268C4E; Wed, 13 May 2026 10:19:30 +0200 (CEST)
Date: Wed, 13 May 2026 10:19:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260513081929.GD5477@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> +		bio->bi_io_vec = bio_src->bi_io_vec;
> +	} else {
> +		bio->dmabuf_map = bio_src->dmabuf_map;
> +		bio_set_flag(bio, BIO_DMABUF_MAP);
> +	}

This is backwards, please avoid pointless negations:

	if (bio_flagged(bio_src, BIO_DMABUF_MAP)) {
		bio->dmabuf_map = bio_src->dmabuf_map;
		bio_set_flag(bio, BIO_DMABUF_MAP);
	} else {
		bio->bi_io_vec = bio_src->bi_io_vec;
	}

> +	if (bio_flagged(bio, BIO_DMABUF_MAP)) {
> +		nsegs = 1;
> +
> +		if ((bio->bi_iter.bi_bvec_done & lim->dma_alignment) ||
> +		    (bio->bi_iter.bi_size & len_align_mask))
> +			return -EINVAL;
> +		if (bio->bi_iter.bi_size > max_bytes) {
> +			bytes = max_bytes;
> +			goto split;
> +		}

Please add a comment explaining why nsegs is always 1 here.

> @@ -424,7 +424,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>  	switch (bio_op(bio)) {
>  	case REQ_OP_READ:
>  	case REQ_OP_WRITE:
> -		if (bio_may_need_split(bio, lim))
> +		if (bio_may_need_split(bio, lim) ||
> +		    bio_flagged(bio, BIO_DMABUF_MAP))
>  			return bio_split_rw(bio, lim, nr_segs);

The BIO_DMABUF_MAP check should go into bio_may_need_split.

> +static inline void bio_advance_iter_dmabuf_map(struct bvec_iter *iter,
> +					       unsigned int bytes)
> +{
> +	iter->bi_bvec_done += bytes;
> +	iter->bi_size -= bytes;
> +}
> +
>  static inline void bio_advance_iter(const struct bio *bio,
>  				    struct bvec_iter *iter, unsigned int bytes)
>  {
>  	iter->bi_sector += bytes >> 9;
>  
> -	if (bio_no_advance_iter(bio))
> +	if (bio_no_advance_iter(bio)) {
>  		iter->bi_size -= bytes;
> -	else
> +	} else if (bio_flagged(bio, BIO_DMABUF_MAP)) {
> +		bio_advance_iter_dmabuf_map(iter, bytes);

This is a bit of a mess.  You're using bi_bvec_done for something that
is not bvec_done, which makes the naming very confusing.  That is even
more confusing than the existing usage, which isn't great.  Also we
add yet another conditional to heavily inlined code.  I'd suggest
the following:

 - add a prep patch to rename bi_bvec_done to bi_offset, as even for
   the existing usage it is the offset into the current bio_vec as
   much as it is the count of byes done, as those must be the same
   and it is used both ways
 - add a prep patch to also increase bi_offset for bio_no_advance_iter.
   It is not actually use there, but incrementing it is harmless and
   this will avoid a new special case
 - please also documet this new usage in the commet in struct bvec_iter.
 - then just add the dma buf mapping to the bio_no_advance_iter condition
 - figure out what to do about dm_bio_rewind_iter, which pokes into these
   things that really should be block layer internal

>  }
> @@ -391,7 +403,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
>   */
>  static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>  {
> -	if (iov_iter_is_bvec(iter))
> +	if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
>  		return 0;
>  	return iov_iter_npages(iter, max_segs);
>  }

Please update the comment for this helper.

> @@ -322,6 +327,7 @@ enum {
>  	BIO_REMAPPED,
>  	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>  	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */

Shouldn't this be a REQ_ flag as we should never mix and match bios with
and without this flag in a single request?


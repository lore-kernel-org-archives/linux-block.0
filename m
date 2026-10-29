Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278413;
	b=OdYMLlEUKNT3YvmSOQ6nNgfKnaLXCVYIREdlw5FrPsrWsH5dOO7XZvQpszXr1aFRV1kO
	 QHGiASDyvvyWNGyU0iBHhuWzMIksKXME+wvtSEC1H8PUfDNVekrFZGG7CStQMeDhv3PXc
	 Pbqb76BcVTcxpdO9KDCZ+mLPJcgzNazLQE/nq1Sw+OLBh+ZQCK2gKG3gLf9qmVjsGwmny
	 81h18ujneiRoSth/qyeLTbeKzXy99d7kWpOWEKV4LAFipPDJZUNyu8DZmhJZ0XDHlOVT6
	 RK649eNN28eMeC7okqpjgPPRzF3AX/EEqkXrf+n3Fv5a36WfW3wANME9hP+gYJB0t8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278413;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=VTSODcrg7Ynp0akL6Hqfwp05YX1snwGHIAj8tvILyLU=;
	b=i44m3R8xwtG1sLOXHjoX098iwPcL4vm3chxZXoVhQQ6kpxpyDVqOv/4gO945v2sI4QQo
	 SV0wWUITbHVx5M+zqSH7yPudtMJUPqDPFkqXLZjnX9mv6D0hmuoYjLqZMPQjbJQ134PUB
	 w64BwLqsyz1YL+XNmIZqj6nG7p4/YIv2WvP2qYUb2EHl/AfAV1LKjFhPKy9i27HBosXvr
	 UxYERtqvv+K3Q8T6DNBN40LHPVm3ZHyH7bHr9VJb0rtWuPnUAJ3VRTYXW3MmMMzQC8Zjs
	 3JXlZfW8Atd2o0E6iGNhLwTjWcfxaE8M66Z3/YAERfH5zX8DyBAjkz9RQPRxkq6cP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zQXWhDc1;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA54606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA54606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zQXWhDc1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VTSODcrg7Ynp0akL6Hqfwp05YX1snwGHIAj8tvILyLU=; b=zQXWhDc1fnFx95Ldu4llaw8ZPP
	OYtPA3saCe/PpQRW+/R8v/gtRfr9JMX3y7h++VAFCfrLe94GOl0b/u5v1OSB+bpRnWcUYY5hGpuZO
	Wmqxxbc4GVisHWfoYOgHk3ExRB+m+yfxNjZ3KwEdd7oJlIZAyOn67kY878OaqBYPWUnxKFG8KYKZ9
	xP9H5HphkzNwa57OG4SAWDA1FNKX4MZs38QKjVQUJYXAEFbZ4gj1o+bK0jziR/NQqY3kMRwsEwEjP
	upRFmPb8tPyS0s6MROTmTy8GivfUpSKWv6GJ8XRE3DrIPYO2c1bV5bJacPLSn8Gahh9VZkWFa4Jwk
	iDHvn7FQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPdL-00000009FMi-3tMk;
	Thu, 29 Oct 2026 12:53:31 +0000
Date: Thu, 29 Oct 2026 05:53:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 11/98] block: check dma alignment of bvec iters in async
 dio
Message-ID: <auNBy_Kx80VAZFnr@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-12-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-12-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:14AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> __blkdev_direct_IO_async() uses bio_iov_iter_set() for an ITER_BVEC
> iterator and never gets to the alignment check in
> bio_iov_iter_get_pages(), which is the one that exists for io_uring
> registered buffers in the first place. A bio based driver has nobody
> else to enforce its DMA alignment: a misaligned READ_FIXED from brd
> returns the wrong data, and dm-verity with panic_on_error panics.
> 
> Move bio_iov_bvec_aligned() to blk.h and check in the async path too,
> failing with -EINVAL like the other direct IO paths.

I think the theory was that bvec callers have to validate the offsets
themselves.  It looks like that doesn't always work?  Should we fix
that in the callers or do we decide we're unlikely to get all of them
right and do the checks unconditionally?

> Fixes: 5ff3f74e145a ("block: simplify direct io validity check")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/bio.c  | 33 ---------------------------------
>  block/blk.h  | 33 +++++++++++++++++++++++++++++++++
>  block/fops.c | 10 ++++++++--
>  3 files changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 06f805d3866a..57d84ca7170f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1272,39 +1272,6 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_DEBUG_KERNEL
> -static inline bool bio_iov_bvec_aligned(const struct bio *bio,
> -					unsigned mem_align_mask)
> -{
> -	struct bvec_iter iter;
> -	struct bio_vec bv;
> -
> -	/*
> -	 * Correct callers never break the alignment requirements, so this
> -	 * exhaustive check is only paid for in debug builds.
> -	 */
> -	for_each_mp_bvec(bv, bio->bi_io_vec, iter, bio->bi_iter)
> -		if ((bv.bv_offset | bv.bv_len) & mem_align_mask)
> -			return false;
> -	return true;
> -}
> -#else
> -static inline bool bio_iov_bvec_aligned(const struct bio *bio,
> -					unsigned mem_align_mask)
> -{
> -	/*
> -	 * We forward the bio_vec as-is, so ITER_BVEC callers must provide
> -	 * segments already aligned to the device's DMA alignment. The only
> -	 * unchecked user-controllable offset that reaches here is an io_uring
> -	 * registered buffer where just the first segment can be unaligned
> -	 * (the rest is virtually contiguous), so checking only that one is
> -	 * sufficient to know if the entire vector is valid.
> -	 */
> -	return !(mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> -							mem_align_mask);
> -}
> -#endif
> -
>  /**
>   * bio_iov_iter_get_pages - add user or kernel pages to a bio
>   * @bio: bio to add pages to
> diff --git a/block/blk.h b/block/blk.h
> index 2cc03aa54c53..a48665e10994 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -202,6 +202,39 @@ static inline bool rq_mergeable(struct request *rq)
>  	return true;
>  }
>  
> +#ifdef CONFIG_DEBUG_KERNEL
> +static inline bool bio_iov_bvec_aligned(const struct bio *bio,
> +					unsigned int mem_align_mask)
> +{
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +
> +	/*
> +	 * Correct callers never break the alignment requirements, so this
> +	 * exhaustive check is only paid for in debug builds.
> +	 */
> +	for_each_mp_bvec(bv, bio->bi_io_vec, iter, bio->bi_iter)
> +		if ((bv.bv_offset | bv.bv_len) & mem_align_mask)
> +			return false;
> +	return true;
> +}
> +#else
> +static inline bool bio_iov_bvec_aligned(const struct bio *bio,
> +					unsigned int mem_align_mask)
> +{
> +	/*
> +	 * We forward the bio_vec as-is, so ITER_BVEC callers must provide
> +	 * segments already aligned to the device's DMA alignment. The only
> +	 * unchecked user-controllable offset that reaches here is an io_uring
> +	 * registered buffer where just the first segment can be unaligned
> +	 * (the rest is virtually contiguous), so checking only that one is
> +	 * sufficient to know if the entire vector is valid.
> +	 */
> +	return !(mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> +							mem_align_mask);
> +}
> +#endif
> +
>  /*
>   * There are two different ways to handle DISCARD merges:
>   *  1) If max_discard_segments > 1, the driver treats every bio as a range and
> diff --git a/block/fops.c b/block/fops.c
> index 375ec2c15926..dfeac910f126 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -365,9 +365,15 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  	 * Users don't rely on the iterator being in any particular
>  	 * state for async I/O returning -EIOCBQUEUED, hence we can
>  	 * avoid expensive iov_iter_advance(). Bypass
> -	 * bio_iov_iter_get_pages() and set the bvec directly.
> +	 * bio_iov_iter_get_pages() and set the bvec directly, which leaves
> +	 * its alignment check to us.
>  	 */
> -	if (!bio_iov_iter_set(bio, iter)) {
> +	if (bio_iov_iter_set(bio, iter)) {
> +		if (!bio_iov_bvec_aligned(bio, bdev_dma_alignment(bdev))) {
> +			ret = -EINVAL;
> +			goto out_bio_put;
> +		}
> +	} else {
>  		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
>  		if (unlikely(ret))
>  			goto out_bio_put;
> -- 
> 2.56.0
> 
> 
---end quoted text---

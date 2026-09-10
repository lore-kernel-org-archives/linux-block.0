Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D54383305
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022440; cv=none; b=SrgA8Ui2yeRl5NRrWdE7pZlCAslkrcv5pxgVMi9kaZiI30H70JWXlqEALFM1uaEGU6zXHvx4NIC9meXQ0ZESjylgsmTZHe1st/XExKTq77hBIpk4gVbnR4azjlqPUobyHBPapE3avFHPeDHLXERUTaLols2grIDsDQ6g3oR6SdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022440; c=relaxed/simple;
	bh=45ddndeuvjrwAlwAAEb+M6XzqAT3yVc1IPjOk3qKoyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUvUceBznBRpkfZedgS9ZYjRg8HmpvSxxOY1aZYH6TkO3g4oVaBiAVE1RBtgNRS3T8CE27EmAod4/gXzpPPSkf1hLxd06icbNRkCznksAiS1Q+BeAG+scHsaJzXfAayJiJQnNAK1m9NvMS30CqDxA2CG2nuJI3xeL2RJ2RQ1GMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bP6IaI7M; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bP6IaI7M"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=45ddndeuvjrwAlwAAEb+M6XzqAT3yVc1IPjOk3qKoyM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789022435; v=1; x=1789627235;
 b=bP6IaI7MvvDQu2Nx2A7STmcXTR3DScJ+YO4yNsjsquc8ksTiqs2BD9Zn1T4Oyf2r6kMfmnJi
 TYTAaObmbueooKdbe0qYDYY8VPlEk8ahsrhuDi7qNubUGg+S7zEBUxlyMRJZFvaX9FR1tIhwml4
 qnUajkzhukH8gXKhr8IhsbNA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1094519f23a8d5e8;
	Thu, 10 Sep 2026 06:40:34 +0000
X-Mizu-Trace-ID: 1094519f23a8d5e8
X-Migadu-Flow: FLOW_OUT
Message-ID: <6db46600-0e39-4924-b006-92ceb9fcf5e3@linux.dev>
Date: Thu, 10 Sep 2026 07:40:34 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] block: fail atomic writes instead of falling back
 to buffered I/O
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.g.garry@oracle.com>, Christian Brauner
 <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-5-1a5222c6e8ad@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260909-blkdev-fixes-v3-5-1a5222c6e8ad@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 23:05, Tal Zussman wrote:
> An IOCB_ATOMIC direct write to a block device can silently lose its
> torn-write guarantee in two ways:
> 
>    1. blkdev_direct_write() turns an -EBUSY from page cache invalidation
>       into a 0 return, so the whole write is retried through
>       blkdev_buffered_write(), with no atomicity guarantee.
> 
>    2. On a partial page pin, __blkdev_direct_IO_simple() and
>       __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC
>       set and leave the rest to the buffered fallback.

This really should be 2x separate changes - 1x for fops.c and 1x for bio.c

> 
> The second case can be triggered deterministically. A 16K
> pwritev2(RWF_ATOMIC) whose last page is PROT_NONE, on a scsi_debug
> device with atomic_wr=1, completes short with only three of the four
> pages written, violating RWF_ATOMIC semantics.
> 
> Fail the I/O instead. Make bio_iov_iter_get_pages() release the pins
> and return -EINVAL when a REQ_ATOMIC bio doesn't cover the whole
> iterator, since an atomic write is submitted as a single bio and a
> short one would be torn. That covers iomap as well, where a partially
> unmapped buffer could trip the WARN_ON_ONCE() in
> iomap_dio_bio_iter_one(). The async block device path currently sets
> REQ_ATOMIC after pinning, so set it before.
> 
> Skip the buffered fallback in blkdev_write_iter() for IOCB_ATOMIC, as
> it already does for IOCB_NOWAIT, so the -EBUSY case returns -EAGAIN and
> the caller retries, matching __iomap_dio_rw().
> 
> ext4 has the same fallback and only warns in it. For block devices both
> ways in can be detected before any I/O is submitted, so fail early instead.
> 
> Fixes: caf336f81b3a ("block: Add fops atomic write support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/bio.c  | 29 ++++++++++++++++++++++-------
>   block/fops.c | 10 +++++-----
>   2 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 898b2f5ef8c8..63e266d861f1 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1284,6 +1284,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>   			   unsigned mem_align_mask, unsigned len_align_mask)
>   {
>   	iov_iter_extraction_t flags = 0;
> +	int ret;
>   
>   	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>   		return -EIO;
> @@ -1303,34 +1304,48 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>   		flags |= ITER_ALLOW_P2PDMA;
>   
>   	do {
> -		ssize_t ret;
> +		ssize_t len;

iov_iter_extract_bvecs() local variable is called "size", so maybe use 
the same here

>   
> -		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
> +		len = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
>   				BIO_MAX_SIZE - bio->bi_iter.bi_size,
>   				&bio->bi_vcnt, bio->bi_max_vecs,
>   				mem_align_mask, flags);
> -		if (ret <= 0) {
> +		if (len <= 0) {
>   			/*
>   			 * A misaligned vector fails the whole I/O.  Release any
>   			 * pages pinned by earlier iterations before returning
>   			 * since this bio won't be submitted to release them.
>   			 */
> -			if (ret == -EINVAL) {
> +			if (len == -EINVAL) {
>   				bio_release_pages(bio, false);
>   				bio_clear_flag(bio, BIO_PAGE_PINNED);
>   				bio->bi_vcnt = 0;
>   			}
>   			if (!bio->bi_vcnt)
> -				return ret;
> +				return len;
>   			break;
>   		}
> -		bio->bi_iter.bi_size += ret;
> +		bio->bi_iter.bi_size += len;
>   	} while (iov_iter_count(iter) && !bio_full(bio, 0));
>   
>   	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
>   		bio->bi_opf |= REQ_NOMERGE;
> -	return bio_iov_iter_align_down(bio, iter,
> +	ret = bio_iov_iter_align_down(bio, iter,
>   			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
> +	if (ret)
> +		return ret;
 > +> +	/*
> +	 * An atomic write is submitted as a single bio, so it has to cover
> +	 * the whole iterator or it would be torn.
> +	 */
> +	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
> +		bio_release_pages(bio, false);
> +		bio_clear_flag(bio, BIO_PAGE_PINNED);
> +		bio->bi_vcnt = 0;
> +		return -EINVAL;
> +	}

This all looks ok, but I'll check again ...

> +	return 0;
>   }

iomap_dio_bio_iter_one() can be updated at some stage to remove its own 
check for improper length returned from bio_iov_iter_get_pages() for 
IOCB_ATOMIC

>   
>   static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
> diff --git a/block/fops.c b/block/fops.c
> index a3a709697b40..0b614d76d128 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -341,6 +341,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>   	bio->bi_write_stream = iocb->ki_write_stream;
>   	bio->bi_end_io = blkdev_bio_end_io_async;
>   	bio->bi_ioprio = iocb->ki_ioprio;
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		bio->bi_opf |= REQ_ATOMIC;
>   
>   	/*
>   	 * Users don't rely on the iterator being in any particular
> @@ -371,9 +373,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>   			goto out_bio_put;
>   	}
>   
> -	if (iocb->ki_flags & IOCB_ATOMIC)
> -		bio->bi_opf |= REQ_ATOMIC;
> -
>   	if (iocb->ki_flags & IOCB_NOWAIT)
>   		bio->bi_opf |= REQ_NOWAIT;

I think that you relocate this as well to have similar functionality 
co-located

>   
> @@ -766,10 +765,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (iocb->ki_flags & IOCB_DIRECT) {
>   		ret = blkdev_direct_write(iocb, from);
>   		if (ret >= 0 && iov_iter_count(from)) {
> -			if (iocb->ki_flags & IOCB_NOWAIT) {
> +			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_ATOMIC)) {

An alternative could be to have iomap_file_buffered_write() reject 
IOCB_ATOMIC.

>   				/*
>   				 * The buffered fallback blocks on i_rwsem and
> -				 * on writeback of the data it copied: return
> +				 * on writeback of the data it copied, and
> +				 * can't provide torn-write protection: return
>   				 * the short direct write instead and let the
>   				 * caller retry.
>   				 */


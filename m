Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97978258F9F
	for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322716; cv=none; b=HeryHhmjOiXfXctq0hv7BXIAJ7GPyycqEUzRiKh7Csb9/ZDW3/IoWUfXWJlpn82fvcClaw7Bp3l25WnMEf3gVasHcwGlCj9AA2h3LBSNw9RX1STFwyBPUTf/TX7NVCnSdGPaz2+NkEJcsJOrOFrqq+9xsoGuwOF4mPSE2udk0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322716; c=relaxed/simple;
	bh=c7n3D01cv7O3DdgejumTO2e1fMt/KZHT9KsxQX5bhTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrdK2Z10qsvLbCEpYsSJ3QwJJAdKOSq/+qmljXmhYyb390CHtuRTwJwv7QQVmJKTsTJzQZnJx7NqGRyrsxTi85V0UAsDK84CW6ojsjvh6hKIjgH0PnZBwW1MryqBUSp5kJwd3KQsJwPn+IKl+pl0wbIkAeOpwvZm2XbBD+wucOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1O1gY0fr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1O1gY0fr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d+Tbkj5zPJ3Pp7RVKR2Lomyxox90coZlSZQ3hLzQk4c=; b=1O1gY0frY/t4HE6oflbg1+l9qu
	OVlQufRaWz0huNyvq7rFzzOdNhR9Q1r51UfC3Tx4Q/s6hsSNEDybu1Up0TkYxwxJwEWDOWeSBQqlS
	pC+IgNJ0BbJS/bfLaUz2tF1DO6AavbfihiT6N2xVkQVhWSnyYtnraWMD1wESHkxCZar+30TYFbk5I
	5EDaIjqsp0Ge4h5uuxYELJjdGwlI5bhLBJvIdgsR1B/JG7PMpKdeGVmaxFAenahGRah+1DByqJ+P9
	5d3RoJmB+KXZdxpiA1BEg5/RuUQCmU6MoR56/09KpT/HMH1e0/OEhXNi15822xVC5dIwAVVRIGPeR
	hQepqkYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roXD6-0000000Dqfk-0PSm;
	Sun, 24 Mar 2024 23:25:04 +0000
Date: Sun, 24 Mar 2024 16:25:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgC2UPEBOSLW9Xdz@infradead.org>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324133702.1328237-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 24, 2024 at 09:37:02PM +0800, Ming Lei wrote:
> +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> +{
> +	unsigned int bs = q->limits.logical_block_size;
> +
> +	if (bio->bi_iter.bi_size & (bs - 1))
> +		return false;
> +
> +	if (bio->bi_iter.bi_sector & ((bs >> SECTOR_SHIFT) - 1))
> +		return false;
> +
> +	return true;
> +}


This should still use bdev_logic_block_size.  And maybe it's just me,
but I think dropping thelines after the false returns would actually
make it more readle.

> diff --git a/block/fops.c b/block/fops.c
> index 679d9b752fe8..75595c728190 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -37,8 +37,7 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
>  static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
>  			      struct iov_iter *iter)
>  {
> -	return pos & (bdev_logical_block_size(bdev) - 1) ||
> -		!bdev_iter_is_aligned(bdev, iter);
> +	return !bdev_iter_is_aligned(bdev, iter);

If you drop this:

 - we now actually go all the way down to building and submiting a
   bio for a trivial bounds check.
 - your get a trivial to trigger WARN_ON.

I'd strongly advise against dropping this check.


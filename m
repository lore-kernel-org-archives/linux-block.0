Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B420E6
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA7184
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 06:39:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A74467373; Thu,  9 Nov 2023 15:39:30 +0100 (CET)
Date: Thu, 9 Nov 2023 15:39:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH V2 2/2] block: try to make aligned bio in case of big
 chunk IO
Message-ID: <20231109143930.GB30592@lst.de>
References: <20231109082827.2276696-1-ming.lei@redhat.com> <20231109082827.2276696-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109082827.2276696-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +/*
> + * Figure out max_size hint of iov_iter_extract_pages() for minimizing
> + * bio & iov iter revert so that bio can be aligned with max io size.
> + */
> +static unsigned int bio_get_buffer_size_hint(const struct bio *bio,
> +		unsigned int left)
> +{
> +	unsigned int nr_bvecs = bio->bi_max_vecs - bio->bi_vcnt;
> +	unsigned int size, predicted_space, max_bytes;
> +	unsigned int space = nr_bvecs << PAGE_SHIFT;
> +	unsigned int align_deviation;
> +
> +	/* If we have enough space really, just try to get all pages */
> +	if (!bio->bi_bdev || nr_bvecs >= (bio->bi_max_vecs / 4) ||
> +			!bio->bi_vcnt || left <= space)

We need to either decided if the bdev is mandatory and we can rely
on it, or stop adding conditionals based on it.  NAK for anything
adding more if bio->bi_bdev in this path.

But more important I'm not sure why we need all this extra code to
start with.  If you just did an extra for more space than we want
to submit, just release the pages that we grabbed but don't want to
add instead of adding them to be bio_vec.

Remember this is an absolute fast path for high IOPS I/O, we should
avoid adding cruft to it.


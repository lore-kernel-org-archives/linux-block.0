Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8282EBBAF
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853956; cv=none; b=X4Xffrbeq12sVnMsRyhCcF9d+h3sJJUW1kzo4L6Mi+LCyQvz3RCNckod7JA4n0SLRyA8jNF6+tnYi8v/ZnwQMDniyoZLR0Hg5MvC9isc+iXJXi2Gy8PNYBQrvQNJmr/uYb4RyfNQ5+LLRZTdrVow816PddqQLC7eT7qCkVTdZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853956; c=relaxed/simple;
	bh=IzuWBz5gYED9o9QnslycXAlrEioUcqIGM7IDy7QBMys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIODID3unDSvNw3wR6RFTV6bYDRephQF1K67t1stDJT4eZU8hIweotIEGC0no+2X4qO9Yo3yOlPeoz2uLqgn+GYCg5wtYGUqprZMCDBBNpw9J9UCoH/6qbioa7DLwPtNwwuMqw5lxxG/yBNY21j//IjS3cFm3piWtCG3sVSpH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70484227A87; Tue, 11 Nov 2025 10:39:03 +0100 (CET)
Date: Tue, 11 Nov 2025 10:39:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111093903.GB14438@lst.de>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 05:36:39PM +0800, Yu Kuai wrote:
> This can be reproduced 100% with branch for-6.19/block now, just:
> 
> blkdiscard /dev/md0
> 
> Where discard IO will be split to different underlying disks and then
> merge. And for discard bio, bio->bi_io_vec is NULL. So when discard
> bio ends up to the merge path, bio->bi_io_vec will be dereferenced
> unconditionally.

Ah, so it's not a NULL req->bio but bio->bi_io_vec.

> 
> How about following simple fix:
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3ca6fbf8b787..31f460422fe3 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -740,6 +740,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
>          gaps_bit = min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
>          gaps_bit = min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
> 
> +       if (op_is_discard(prev->bi_opf) || op_is_discard(next->bi_opf))
> +               return gaps_bit;
> +

I think the problem is how we even end up here?  The only merging
for discard should be the special multi-segment merge.  So I think
something higher up is messed up


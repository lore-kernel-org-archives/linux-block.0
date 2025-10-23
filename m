Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF062F363F
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207736; cv=none; b=EdIGXkswca4IDib9aLgAiSdwWeTtb/OLJvZ6fsFGjwuVyGzXqbqDYU3gnRpeoS84jPDH6NDcsGWxFQvGpBveFHunEuUy+XluccOKC/2LTD8rxwag9YMK86df7n3B9o0mjBpuyFxWcwsHfuUsuEwrjxqSLN/koIj6CV9BvVJD0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207736; c=relaxed/simple;
	bh=Tprl0ZbjSK1PkTFjaaA8AL03LBevi6SAVkk8/guijKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCt98pW5i7zJwXNCuyi9o6ikNEvy+nbLv5oRuCnhtEHSrosZX271afwVC2+XmKZ/6GRHcfEEfSpbbHdQ5XyYCDoMmumCNEynpC3qEf50CmCIgwA+QRLHNcnU/GAhBE/3D7CCIXiLwQJKQzi0bcnNAXnXPouA5Knrgd5HWPnA/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 006C0227A8E; Thu, 23 Oct 2025 10:22:01 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:22:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@devbig197.nha3.facebook.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: support bvec straddling block data
Message-ID: <20251023082201.GA369@lst.de>
References: <20251022235231.1334134-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022235231.1334134-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 22, 2025 at 04:52:31PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A bio segment might have only partial block data that continues into the
> next segment. User the integrity iterator to store the current checksum
> state until we've accumulated a full interval worth of data.

As mentioned in your reply having good tests for this would be really
useful..

>  	void			*data_buf;
>  	sector_t		seed;
>  	unsigned int		data_size;
> +	unsigned int		remaining;
> +	union {
> +		u64		crc64;
> +		__be16		t10pi;
> +	};

Any good reason to keep the t10pi in be format except that is how
the existing t10_pi_csum wrapper works?

> +		if (iter->remaining)
> +			continue;

I find the structure with the remaining continue here a bit confusing.
I guess the code would benefit from being split into an out loop over
the integrity intervals and an inner loop over the potentially smaller
buffers to make this clear.  Even more so with the skip case in the
verify path.

> +		iter->remaining = iter->interval;
> +		iter->t10pi = 0;

And these values basically only matter inside that outer loop, so
I'd just keep them as local variables instead of adding them to
the iter.


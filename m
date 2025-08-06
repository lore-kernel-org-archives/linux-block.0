Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D5241664
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495090; cv=none; b=ZIY8/ZlxbCswc8Aq2HKfWH6g8eJvvFGWmx1pC882ZZ1hs/AErgd3kWmRaEpf4LubGZNQxiNPcD9OKkK1NAgA/NbfotOO8rVLNocFAVzc9ylhl9oZyY+/GUCb8pDVX9yOCiarzhDGy/AcLRdfti+DClADrI8Rc4kqyiIAd2b++GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495090; c=relaxed/simple;
	bh=uKdAPwLRahqr9w+gCnjr/ezk+JdtxLnUTz4ylfHc++c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC3NNKSfDWrNyqORV2G1OEWzA9abmhlUhHWKXdnq4Z3VTrjP5zL7AWJSsl/byoRQNIi/+KruChNM4IhbA9DBdNrTqG59T4R7rjB4h/RwvF9OqFg20ifT85NsY1UpveDVHxX5pR4KuR8pvhdnnwbyn83rrkgN/sYLSFIi7oH9cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtDaW1/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtDaW1/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4825DC4CEE7;
	Wed,  6 Aug 2025 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754495089;
	bh=uKdAPwLRahqr9w+gCnjr/ezk+JdtxLnUTz4ylfHc++c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtDaW1/+e3aK9+fmIYGksRBd7sOU1DrSftOfN1AxcM/Obn/EFPFvAuoQpAV8bD5Mk
	 a660SJdCCCriKC6sCuYlNED6zd4jiRI7sI5TxuxQXFi5j3JOIEoVgmW0sXVH3hZt2P
	 xDrcMAGDQQm0PkPiLFNUvtwVNs34oT7AkRxukkZqJLZHw0q6aKwRDCBBRKVY+FL2kl
	 CCb48MzixOeTmz0Xzz9acCDpbdOp2FIcbSuvTCcfqBsbCKVkvi3wBrRxXWE8NcVDS6
	 aEWx65DS5fWRDvu3gom1zC29EluoLIqUnwR08R+t4bTZl85lQ/u4Iv11j7l6A2Bs2r
	 QVHKYzHGyGQmQ==
Date: Wed, 6 Aug 2025 09:44:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJN4b6GS30eJdQLd@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250806145621.GC20102@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145621.GC20102@lst.de>

On Wed, Aug 06, 2025 at 04:56:21PM +0200, Christoph Hellwig wrote:
> > index 0a29b20939d17..d0ed28d40fe02 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -264,6 +264,8 @@ struct bio {
> >  
> >  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> >  
> > +	unsigned int		page_gaps;	/* a mask of all the vector gaps */
> 
> Bloating the bio for the gaps, especially as the bio is otherwise not
> built to hardware limits at all seems like an odd tradeoff.

Maybe, but I don't have anywhere else to put this. We split the bio to
its hardware limits at some point, which is where this field gets
initially set.

It doesn't need to be a mask (though that conceptually is the most
intuitive). It really just needs to indicate the lowest set bit of any
page gap between segments. There is a one byte hole in the bio that can
fit it without changing the bio size.

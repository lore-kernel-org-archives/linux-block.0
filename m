Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3623958F
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837715; cv=none; b=rI/F/+NpZ8VM661YAgMLdyYg5f3pG6foYEV8ISgRlppngx717aTe7qLrJkQIimPZd9WIY+kqIc1iyQkv/HokjexkO3Hfrq6ff2cMnt0yqhPHybMk0+YJXnfh85/T2X2WdC3mrMJZR+q30hPl8lqPdqWqFQfe9syK1PEKS9ITlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837715; c=relaxed/simple;
	bh=SfA8TwiSSpFZl9fG7y5OH9V9S9D3/RMMZ0JVlZZWbIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHAcagK0gmBjYIfi5lnx5NyiMvWzZeUDOAi825Sfg6oUHj82hSA0O/CNIielmPgZKv/8SOflwx9aWqy9KN0Q6WSRFNzyw9SR+bl+YgLVRnNejJtxpBvLF71iv+zS/Q0/AaAp5p//MjcPu/T4XtqBjoKQM9qGpVTQewCpgzIGLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BF5E227A87; Sun, 10 Aug 2025 16:55:09 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:55:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250810145509.GA5444@lst.de>
References: <20250806145136.3573196-1-kbusch@meta.com> <20250806145136.3573196-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145136.3573196-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 06, 2025 at 07:51:35AM -0700, Keith Busch wrote:
> +static inline unsigned int bvec_seg_gap(struct bio_vec bv, struct bio_vec bp)
> +{
> +	return bv.bv_offset | ((bp.bv_offset + bp.bv_len) & (PAGE_SIZE - 1));
> +}

Can you just pass a pointer to the bio_vec even if the compiler
is probably optimizing away the function either way?

Also bp is a bit of an odd name for a bio_vec.  Note that bvprv flows
well, but it is what the caller uses, so mahybe stick to it?

>  	/* the following two fields are internal, NEVER access directly */
>  	unsigned int __data_len;	/* total data len */
> +	unsigned int __page_gaps;	/* a mask of all the segment gaps */
>  	sector_t __sector;		/* sector cursor */
>  
>  	struct bio *bio;
> @@ -1080,6 +1081,11 @@ static inline sector_t blk_rq_pos(const struct request *rq)
>  	return rq->__sector;
>  }
>  
> +static inline unsigned int blk_rq_page_gaps(const struct request *rq)
> +{
> +	return rq->__page_gaps;
> +}

I don't think we really need the __ and the access helper here.  This was
mostly done for fields where historically drivers accessed the field
directly, but it subtly changed semantics making these direct accesses
unsafe.  


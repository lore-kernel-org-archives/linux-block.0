Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC861DFD1;
	Tue,  8 Oct 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399130; cv=none; b=r8r/g3a9+AV4gxjAmnnq5xBQU0/7R2n4KUOrjgjdI9DuFsSxyh/BJkaPv7g4Nx0HlZVGr+YFLnxXyuNuBk6UJJa8Q09DmBRaWFkaaQ9rbez8fiop67zWU3TE6Iln2JnbCcK7T27koqa1kU2YdpratBRsS7yl/mBXw1yR1EddKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399130; c=relaxed/simple;
	bh=dqrkp2/3a4RSErawaG5/0PMhkPOSRe1WtaBNNRHUviQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTVcdvnQyUtB8kTjKgenSuDZKMma80HW/CP4eB8nNRsceCM7sh78YL9gPA/QpKK/+QwLWFTD7Ac7fcTOpHZSem9Q49F8Du9g31He7bjwJnf+mZ7gWCdOaALKVB3aMz5AVN+3s8iRyK3/td9MR+OSlGoiB3o+rmJTJTeLinXFdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diUoWpQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diUoWpQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7CAC4CEC7;
	Tue,  8 Oct 2024 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728399129;
	bh=dqrkp2/3a4RSErawaG5/0PMhkPOSRe1WtaBNNRHUviQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diUoWpQzUfkVS2zYhn8+sLGYPQCmBhTaEjiOKYuZOaBuRT1fk8egb++918ito7jSK
	 hv2yvl4zXHeGFtaGNt7vsOI4ut8NrClLjB7mxLD36G9BVJOwsoZm9HwYRl8rNWtw9t
	 eT3hi8TsWXM9bSPzqGj0yaxNmgRKk+xTEduhA8hIKe32KIEUZZD1KY/3f/D+TIWoQ7
	 CRGPcbyWHxYzyzegiMPx07Ijfr7zPvDwRbgyfeI0hUCifouSLq/UfDxb9YQflBLnLe
	 1cuReQilV0qtnXjoNZiiMMeMAOTi9UtLRuw+ZKvreZOB+HWCE7PvcmIGA3cJTfsJcp
	 iY6erFbJhmCTQ==
Date: Tue, 8 Oct 2024 08:52:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v3] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZwVHF_0Z0dNnYW58@kbusch-mbp>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008120413.16402-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008120413.16402-1-surajsonawane0215@gmail.com>

On Tue, Oct 08, 2024 at 05:34:13PM +0530, SurajSonawane2415 wrote:
> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
> to resolve the following error:
> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.

...

> @@ -3156,19 +3156,21 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  		      int (*bio_ctr)(struct bio *, struct bio *, void *),
>  		      void *data)
>  {
> -	struct bio *bio, *bio_src;
> +	struct bio *bio_src;
>  
>  	if (!bs)
>  		bs = &fs_bio_set;
>  
>  	__rq_for_each_bio(bio_src, rq_src) {
> -		bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
> +		struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
>  				      bs);
>  		if (!bio)
>  			goto free_and_out;
>  
> -		if (bio_ctr && bio_ctr(bio, bio_src, data))
> +		if (bio_ctr && bio_ctr(bio, bio_src, data)) {
> +			bio_put(bio);
>  			goto free_and_out;
> +		}
>  
>  		if (rq->bio) {
>  			rq->biotail->bi_next = bio;
> @@ -3176,7 +3178,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  		} else {
>  			rq->bio = rq->biotail = bio;
>  		}
> -		bio = NULL;
>  	}
>  
>  	/* Copy attributes of the original request to the clone request. */
> @@ -3196,8 +3197,6 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
>  	return 0;
>  
>  free_and_out:
> -	if (bio)
> -		bio_put(bio);
>  	blk_rq_unprep_clone(rq);

I think your commit message is missing the real "fix" here. The other
place that goto's this label is if blk_crypto_rq_bio_prep() fails. At
this point, the cloned 'rq' has all the bio's that get cleaned up in
blk_rq_unprep_clone(), so that failure scenario is double put'ing the
last bio.

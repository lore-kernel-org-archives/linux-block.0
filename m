Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE12CCC5
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558266; cv=none; b=uyCzKsnevykoBXgItpzxJ3x7O6nTgoKrG05AZEuH1AdpIuoUSLNMJqayW3kohqXLe4tAhzTOPKNqIQV9C5M2cOreFXjOy2DqzIJu0uysUPPE8MwemL0bbKwJoEbzMe/eATCnSFrGc+LgCFwYtCZtgPmsE+Rz2oP5OY1mOdU+WTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558266; c=relaxed/simple;
	bh=BUEmaN+WJQ9hvVn3YdE37p3862s/5r2p+ZK3zuwnHyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDzk7JW8hAJm+xkp6L0QToW9hUoebriATmDxmFubLSbDnjFnPncLID3C1g49nwDP5JiRekkh80gaHsOOr5axzKfHptItcahNz/6Y3xM6ylAnEfjR0ORqIDVVvDJ1YK/jWdpOO76oKRlGu2jYcwTQbKHhgGVjwFqeVjpZqoZCT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42FCF227AAD; Tue, 15 Jul 2025 07:44:20 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:44:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 2/2] block: Rework splitting of encrypted bios
Message-ID: <20250715054419.GB18159@lst.de>
References: <20250711171853.68596-1-bvanassche@acm.org> <20250711171853.68596-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711171853.68596-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 10:18:52AM -0700, Bart Van Assche wrote:
> @@ -289,9 +266,12 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
>  	bool ret = false;
>  	blk_status_t blk_st;
>  
> -	/* Split the bio if it's too big for single page bvec */
> -	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
> +	/* Verify that bio splitting has occurred. */
> +	if (WARN_ON_ONCE(bio_sectors(*bio_ptr) >
> +			 blk_crypto_max_io_size(*bio_ptr))) {
> +		(*bio_ptr)->bi_status = BLK_STS_IOERR;
>  		return false;
> +	}
>  
>  	src_bio = *bio_ptr;

I'd move the check below this line so that you can use src_bio instead
of dereferencing bio_ptr multiple times.

> +	if (unlikely(!blk_crypto_bio_prep(&bio)))
> +		return NULL;
> +

It feels like returning the new bio would be a better calling
convention than the in-out argument.

> @@ -355,9 +360,12 @@ EXPORT_SYMBOL_GPL(bio_split_rw_at);
>  struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *nr_segs)
>  {
> +	u32 max_sectors =
> +		min(get_max_io_size(bio, lim), blk_crypto_max_io_size(bio));

The blk_crypto_max_io_size should move into get_max_io_size to keep
this tidy.

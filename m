Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82371213E6A;
	Thu, 30 Oct 2025 06:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804189; cv=none; b=Fa6n1anRTRqeu60tpV2f+Oq6JyKEILrfkEs6ZcgtXoUeTpaHh0YjnCUVNfrFMZERujqnudh7iETneTdSF/oNJhrGazGW2qz6vNXsy0RicQMnplpgFKw5ywWalpalAKxi+E0ZaL/oyziAXWeTnPOs+qgN6BEusrfyqNnyS9AsVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804189; c=relaxed/simple;
	bh=HNWm+EqFi+Tlr/cX5S3nz4F0B1J0EtYkMwZvOUR1MF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljljwowssQj1BP2fv2isDWgSbQWBItwWtMbeRkI52pYZVyYluqWiLpRQF+XuhU5Ffm728OQYAJrcn029fnDhyReGBbHF2gWy7Y3JwtxQD07IjqwQznDEzZXZF2xnQ0nw4KN5cBtGdzl1LFMQPcH+dLvYpEqfkBznopoWTjQYcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE574227AAA; Thu, 30 Oct 2025 07:03:03 +0100 (CET)
Date: Thu, 30 Oct 2025 07:03:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Carlos Llamas <cmllamas@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
Message-ID: <20251030060303.GA12820@lst.de>
References: <20251030043919.2787231-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030043919.2787231-1-cmllamas@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 04:39:18AM +0000, Carlos Llamas wrote:
> Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
> fail the data unit alignment check.
> 
> This was flagged by an LTP test that expects EINVAL when performing an
> O_DIRECT read with a misaligned buffer [1].
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/all/aP-c5gPjrpsn0vJA@google.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  block/blk-crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 4b1ad84d1b5a..3e7bf1974cbd 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -292,7 +292,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
>  	}
>  
>  	if (!bio_crypt_check_alignment(bio)) {
> -		bio->bi_status = BLK_STS_IOERR;
> +		bio->bi_status = BLK_STS_INVAL;
>  		goto fail;

Note that the dio_mem_align reporting in ext4 and f2fs also need to
be updated to account for this.


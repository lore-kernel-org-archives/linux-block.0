Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70678313E13;
	Thu, 30 Oct 2025 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799911; cv=none; b=Yk9uSZFcq4v9Fn8NR2T8rUcfmSbyYyyjxtKo2wiSPdBa9zwOwfgeQNDlaRxpDk/MAtkfEOlur2NS4TzbKLh3OniczDsf9/59/LedLJbf+WthWzPGOEE9ivHLf32AeHS3N1+AGVZ9LOZiZblkcbvFmkBrcqv6aQKMCmo+JWVVYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799911; c=relaxed/simple;
	bh=hBFdO+eOBE/VdB7qHggbZimNEQvOGdZIYuJimDOo+/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBrBELAv6iU7GRe4XfpaSuKrRm4zQVZMqSinH27J4JL4AUTcgXSi5oVEsAS+62Nt3XJMi0rTpRzCdBm1d6w5mI5zxvOJ4tHZpdao5oysJCSa3SgmrPL6c2gW9tR1bZA5LSISoCHNxX4EwZE18R6/iEO/HI+D3Xl2/Ws2uWMs6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifp+QAXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifp+QAXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11ECC4CEF1;
	Thu, 30 Oct 2025 04:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761799911;
	bh=hBFdO+eOBE/VdB7qHggbZimNEQvOGdZIYuJimDOo+/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifp+QAXD2ykfDxV3ZbIMDTac+LJx9/fa+wflb3xQ32vKEgPgMP24Lrey+ZAOn/O5K
	 aHfPgU0E1RFxWqC0c3urP7Wh9EEJf9GA2u4tI8V1PZy0z0nqqsG4JLFeatDCStka3h
	 YfhVnsckFh8O6mHdn054oEHoreslihnAncROgNWJ4gNWLxFStPpeszf0kxaQpwdEjN
	 2cceYF2mPr8ad9qMyG5TR3LQl8vOTI0FiKzkOnsWixhiL79PG9LjbiIVM70TN8ft4l
	 YSijePFsF4Sb+if235pMh/jNnSTVvjWhzZu2H2pSd5xeKP47oiUHzhZ4kwAb9+OGi+
	 WnWaSvuJ9bA9Q==
Date: Wed, 29 Oct 2025 21:50:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
Message-ID: <20251030045013.GA9921@sol>
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

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

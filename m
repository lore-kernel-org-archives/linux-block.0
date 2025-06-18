Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1402F5300
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750222774; cv=none; b=E9QtRFpaANz7zKxY1FyBqdfIz8frmT3b6+0eZzCowykx4xz9Go9p0iVpP64s3B0PtI8Fvv6rRqiAYfqTxIfwmeLuuhYbRbYOwjWMcfT7YYmyQHW7JSDBkz6+3tBjVXOd+JdOo8t/wj5bfXgfMnrTueMpYQOpfLshJv8rPpGJJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750222774; c=relaxed/simple;
	bh=BnU97py2cQnOGygqw1rMhDx7wNIsRP4f3Tv47qAGlQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7d7k99tJQJToDNFhbbrW6r2jxWRXJPEje8HeSilO+p8R9bPp8QqYXx1sCtuxi+EJmExA7gfPC3+XD635JA9UEgv9xTjlmttWM8Rc3NQqqqbjTB28Bgi+WJwi0ANkcjMTA1OfaT65swy9IX4lyWHZ4vnpSFCRKFD54D6P5FZC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52B9F68D0E; Wed, 18 Jun 2025 06:59:28 +0200 (CEST)
Date: Wed, 18 Jun 2025 06:59:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250618045927.GA28260@lst.de>
References: <20250617063430.668899-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617063430.668899-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 03:34:30PM +0900, Damien Le Moal wrote:
> Since many block devices can benefit from a larger value of
> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
> be 4MiB, or 8192 sectors.
> 
> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 85aab8bc96e7..7c35b2462048 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1238,7 +1238,7 @@ enum blk_default_limits {
>   * Not to be confused with the max_hw_sector limit that is entirely
>   * controlled by the driver, usually based on hardware limits.
>   */
> -#define BLK_DEF_MAX_SECTORS_CAP	2560u
> +#define BLK_DEF_MAX_SECTORS_CAP	8192u

While we're at nitpicking, maybe define this as

	(SZ_4M >> SECTOR_SHIFT)

to make it a bit more readable?

Otherwise this looks good, the odd number was always rather weird.


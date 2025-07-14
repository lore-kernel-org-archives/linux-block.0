Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92762238173
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492589; cv=none; b=A5CC2x3gcPLNQx+s2jnfzJvdF4PmLAzlSQDateNcdPqz5X3l8qgTkhUxZC0knPSZSrBNkDAKaA+bZH8i8XF3aO55/0qOHOcafRVX2Gjzh/RwRIv911Ynfbgu/fWGhK3pCPBwKG8Xn0YPLzunk86u6GMPIv8g4TaVFKCMWXMXPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492589; c=relaxed/simple;
	bh=orVOTcDgJPOnTW/Edb4GK8MXgEVhJSJ2GylwTTLObEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjixVhLvuOW623JRCcfFDvxB4Y0GBLV7hZUSI6+fLwdnR6RU1Z6iHoQ4xwi//eApRrBOiOGuj9lU6JS2qm+j36/a+sbnNM5uY7hFzj0QR2BVpT9lwvqeXEGgJ2HFbIvjtdy8robgA+VI8BtIEu9gv4I2tfXx7e8UOl4//fOZ+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17373227A87; Mon, 14 Jul 2025 13:29:42 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:29:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/2] block: Split
 blk_crypto_fallback_split_bio_if_needed()
Message-ID: <20250714112941.GA1043@lst.de>
References: <20250711171853.68596-1-bvanassche@acm.org> <20250711171853.68596-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711171853.68596-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 10:18:51AM -0700, Bart Van Assche wrote:
> +static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	unsigned int num_sectors;
> +
> +	num_sectors = blk_crypto_max_io_size(bio);

This would look a little nicer if you assigned the value at declaration
time:

	unsigned int num_sectors = blk_crypto_max_io_size(bio);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

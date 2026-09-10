Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287442DC798
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789018602; cv=none; b=eK36sfUUTeM5eT3dxB1gs8kIT7m/N2ZvWPwe4fPI9lmrSx+hbXuN1J6YbPOFsBR+ObX7wUnA1kig2yDe65/peoACUju0/dnefSBCWg8XcgFaYPJ4jZi+G8AXIdFyKbSXvc3vYZOsOsGOfuwoPYULI43CoTEa35WxKtfRdX9NkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789018602; c=relaxed/simple;
	bh=SjFK6PXtSD+sC6EU0ryShisjnz2Bd/esJSg//k9ire0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBbB/Dhit8Z0bbt+CD8M+sb0VRBrJPtY7P2syPAkB6fvnosEQTZFgpaSHcsEz6vHTR68m41R6lrf++R9RnEz4BJ6/SSLERrIv3qhl0xEUY5yG3W3QJpTOhYIx8zkFSCGhQUgTDFF2Hbah2LJubuXU1c1rhf4rAm0raGQTH/qFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 976F568D05; Thu, 10 Sep 2026 07:36:36 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:36:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
Message-ID: <20260910053636.GA27408@lst.de>
References: <20260907074111.721054-1-hch@lst.de> <20260907074111.721054-3-hch@lst.de> <a17ccccc-a91c-4e45-a97e-d899c739e159@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17ccccc-a91c-4e45-a97e-d899c739e159@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 09, 2026 at 10:16:17AM +0100, John Garry wrote:
> Furthermore, I don't think that this is the change above is correct. We 
> have 4x atomic limits and I think that 3x would need updating:
> - atomic_write_max_sectors
> - atomic_write_unit_min
> - atomic_write_unit_max
>
> The expectation is that the driver sets atomic_write_hw_max, 
> atomic_write_hw_unit_min, and atomic_write_hw_unit_max individually. We 
> don't assume that atomic_write_hw_unit_max == 
> rounddown_pow_of_two(atomic_write_hw_max). The is because of SCSI and it's 
> granularity and alignment atomic limits :(

>
> Anyway, maybe this is a better change:
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8274631290db..b88744d42719 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -233,11 +233,15 @@ static void blk_atomic_writes_update_limits(struct 
> queue_limits *lim)
>  	unsigned int unit_limit = min(lim->max_hw_sectors << SECTOR_SHIFT, 
> blk_queue_max_guaranteed_bio(lim));
>
> +	unit_limit = min_not_zero(unit_limit, max_integrity_io_size(lim));
>  	unit_limit = rounddown_pow_of_two(unit_limit);
>
>  	lim->atomic_write_max_sectors =
>  		min(lim->atomic_write_hw_max >> SECTOR_SHIFT,
>  			lim->max_hw_sectors);
> +	lim->atomic_write_max_sectors =
> +		min_not_zero(lim->atomic_write_max_sectors,
> +			max_integrity_io_size(lim));

This needs to be conditional on a non-zero lim->integrity.metadata_size.

Otherwise this looks sane.

> I would (naively) assume that if the disk has integrity, then it's atomic 
> limits reported would update accordingly and lim->atomic_write_hw_max et al 
> would already have any integrity limits built in (so that we don't need to 
> do any capping of atomic limits by integrity limits).

The integrity limit is purely a software limit based on the mempool for the
max integrity data allocation.

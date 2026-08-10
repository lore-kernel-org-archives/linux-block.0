Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411113054EF
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373274; cv=none; b=WlBesbQXDymOGzhDWwwh6dXFa+EsB+XDVQYT+sC3kgqLp+BlPFoZGStKU6zeO/ArFtyMOf4TCswv8JMXPSN13mZMUZWb5RTqO8QMOIvnVMVKnLqbUTpODdYPe6Wuz16qDcwJbfTFHkAq/ZIy+5OnrUSQjFFbyKMsLSenmXE/n/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373274; c=relaxed/simple;
	bh=EyqOEoZHrqRaRfXORQn3iILM/GftJuO0NRZK46bjF2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtOcWWmATpgbbKCnxFYx5NGDwXsRTA7aEE+inLHx0gPogx5VUgg3aRUArvS+7OQiooErHIOKFlokPorAAqlJEimXmFccHsEU4FFO+BZmr0HsvssU/uoUV2SGyErxjarAxsmuAuPXTzvCXLVl9jqbEQ7pCzQPcj5lQyaExIlIU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FF2068C4E; Mon, 10 Aug 2026 16:47:48 +0200 (CEST)
Date: Mon, 10 Aug 2026 16:47:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 02/13] block: refactor
 disk_revalidate_zone_resources()
Message-ID: <20260810144747.GB16182@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org> <20260806160445.848337-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806160445.848337-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 07, 2026 at 01:04:34AM +0900, Damien Le Moal wrote:
> The function disk_revalidate_zone_resources() is misnamed as it does not
> revalidate anything but rather allocates the revalidation arguments and
> then calls disk_alloc_zone_resources() to initialize the disk zone
> resources if they are needed and not already allocated.
> 
> Make this function less confusing by renaming it
> disk_init_revalidate_args() and moving the call to
> disk_alloc_zone_resources() into blk_revalidate_disk_zones(). As before,
> this function is only called if the zone resources are needed and not yet
> allocated.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/blk-zoned.c | 69 ++++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index b47e32bf4602..0580f0bc333c 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1854,12 +1854,20 @@ static int disk_zone_wplugs_worker(void *data)
>  
>  void disk_init_zone_resources(struct gendisk *disk)
>  {
> +	atomic_set(&disk->nr_zone_wplugs, 0);

Moving this initialization is not really mention in the commit log.
I guess it makes sense to keep all these initializers together,
but it would be nice to mention it or even split it out into a
separate patch.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

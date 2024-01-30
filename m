Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B102F7CF1B
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625712; cv=none; b=vEaVbWVG7CZIkVnJa6HRmzCS808mUJj40EMItR4cgVp5CA4v81HgaTY2CzXREnAMNpwqo7MREcFDqNuEO1qgNx1wbF6P7zl8fWBSatl9WujwVGOE59IcdPaE8xzRfP2nxY7+G1ZlyuUnUWZrdT7pngEX0RjlTxxRSdyHHS21vNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625712; c=relaxed/simple;
	bh=iydZ0rk2gIoR4xHHBuhY2l4GOCJB9/obAaUcMY7Flhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxqOtk+kFKNYuVOTmpvk8VcjvbC59obnPAhR0G1BZelbrkfuN6wjUTMvd2GnlSPCTFVPr69SE5wqS2jEaR0EY8fiEDkIwLBPn/oJG9rBeuCMvc0ysZbiBZjUJoK3cAEIwgeWOBVF0SsqLcclT1+5JGxjan9Tnl/ji0HmvuaTIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE095227A87; Tue, 30 Jan 2024 15:41:44 +0100 (CET)
Date: Tue, 30 Jan 2024 15:41:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/14] block: add an API to atomically update queue
 limits
Message-ID: <20240130144144.GA32125@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-4-hch@lst.de> <c489e14c-aea7-4d76-88cd-f60026477c68@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c489e14c-aea7-4d76-88cd-f60026477c68@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 11:46:24AM +0000, John Garry wrote:
>> +{
>> +	if (!lim->zoned) {
>> +		if (WARN_ON_ONCE(lim->max_open_zones) ||
>> +		    WARN_ON_ONCE(lim->max_active_zones) ||
>> +		    WARN_ON_ONCE(lim->zone_write_granularity) ||
>> +		    WARN_ON_ONCE(lim->max_zone_append_sectors))
>
> nit: some - like me - prefer {} for multi-line if statements, but that's 
> personal taste
>
>> +			return -EINVAL;

That would be really weird and contrary to the normal Linux style.

>> +	if (!lim->logical_block_size)
>> +		lim->logical_block_size = SECTOR_SIZE;
>> +	if (lim->physical_block_size < lim->logical_block_size)
>> +		lim->physical_block_size = lim->physical_block_size;
>
> I guess that should really be:
> lim->physical_block_size = lim->logical_block_size;

Thanks, that does need fixing.

>> +	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
>> +			lim->logical_block_size >> SECTOR_SHIFT);
>> +
>> +	/*
>> +	 * The actual max_sectors value is a complex beast and also takes the
>> +	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
>> +	 * value into account.  The ->max_sectors value is always calculated
>> +	 * from these, so directly setting it won't have any effect.
>> +	 */
>> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>> +				lim->max_dev_sectors);
>
> nit: maybe we should use a different variable for this for sake of clarity

What variable name would work better for you?

>> +	/*
>> +	 * We require drivers to at least do logical block aligned I/O, but
>> +	 * historically could not check for that due to the separate calls
>> +	 * to set the limits.  Once the transition is finished the check
>> +	 * below should be narrowed down to check the logical block size.
>> +	 */
>> +	if (!lim->dma_alignment)
>> +		lim->dma_alignment = SECTOR_SIZE - 1;
>
> It would be also nice to update blk_set_default_limits to use this (and not 
> '511') or also any other instances of hard-coding SECTOR_SIZE for 512

That would be nice, but defintively not in scope for this patch.


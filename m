Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6C58106
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999496; cv=none; b=H/sJ7A1afZSKDaqg4WvFoYIs/DOTHl3lrRAv+qmG4NRvo+U9tS/w4M3apqxop3odh1Zj6hgkUStP6NO2rY4SY5xIfd/4WLz7fnFhLFKotkH3qiNPaAj9RHTRJ5og1jiTBOHa7GumxwTcq5t4YqDXq+gUmVsFWrTB2Gwp/cIImXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999496; c=relaxed/simple;
	bh=ugOBYcw21dsER4oZ/h1CZsS/s+lsc9VkuYU8YT3LDzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBwWf7XUT8tKPWW9SVdisBWEoZQlDhXGTImEMz9T70GU2QS5/U9dg4rQ0rSI1nKXhNaJZhNyVrOMO6S4eOZmtzDDdzBPwcgViLR4qtt5e7ik5gP4wT/T1Kd9CD3Ogy1DqiW7P2jtrg7hDd4bdKRuvCgFL8XMpLzVJxuUOwEBr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D8F268BEB; Tue, 23 Jan 2024 09:44:49 +0100 (CET)
Date: Tue, 23 Jan 2024 09:44:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240123084449.GB29041@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <01765807-d010-422b-97a6-3171265f36be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01765807-d010-422b-97a6-3171265f36be@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 01:50:32PM +0900, Damien Le Moal wrote:
> > +			return -EINVAL;
> > +		return 0;
> > +	}
> > +
> > +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
> > +		return -EINVAL;
> > +
> > +	if (lim->zone_write_granularity < lim->logical_block_size)
> > +		lim->zone_write_granularity = lim->logical_block_size;
> 
> This check and change needs to be against the physical block size. Otherwise,
> SMR drives will choke on it.

It probably should, but this mirrors what is done in
blk_queue_zone_write_granularity.  And I want to match that behavior
at least for now, we can then improve and document it once this is
the only interface to validate the limits.

> > +
> > +	if (lim->max_zone_append_sectors) {
> > +		if (WARN_ON_ONCE(!lim->chunk_sectors))
> > +			return -EINVAL;
> 
> chunk_sectors is the zone size. So we should probably check that it is set after
> the IS_ENABLED() check earlier in the function, no ?

Possibly.  In fact I'm wondering where the check comes from, as we
don't seem to have it in the existing helpers.

> > +	if (!lim->logical_block_size)
> > +		lim->logical_block_size = SECTOR_SIZE;
> > +
> > +	if (!lim->physical_block_size)
> > +		lim->physical_block_size = SECTOR_SIZE;
> > +	if (lim->physical_block_size < lim->logical_block_size)
> > +		lim->physical_block_size = lim->physical_block_size;
> > +
> > +	if (!lim->io_min)
> > +		lim->io_min = SECTOR_SIZE;
> 
> This should be lim->logical_block_size, no ?

This comes from the default in blk_set_default_limits.

> 
> > +	if (lim->io_min < lim->physical_block_size)
> > +		lim->io_min = lim->physical_block_size;
> 
> But then given that log <= phys, you could set io_min to physical_block_size if
> it is not set.

Which is what we do here, so the above is actually redundant and
can be removed.

> > +	if (!lim->max_hw_sectors)
> > +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> > +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
> 
> You can use PAGE_SECTORS here.

Yes.

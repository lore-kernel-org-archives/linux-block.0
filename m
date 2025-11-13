Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8B2D47F1
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045109; cv=none; b=hnpLzzlLX2SddH+BK4lDuqy+sapLOcC1TT9LttYcRap1AnwPSkWFKTkZIeIXOwC4DKfvwRhfJ+tVqAAkULLFaTtUIw8uvn7Gmxjj2LyanrKPzhcJ0eJyN43TWUGFqq0DMA61cHcvG3bwhLifq2STSSZAz+WWyQhEY/NnVLRn/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045109; c=relaxed/simple;
	bh=7Se7GqFjoSPSpFsaUkSTA8OG5xonS0Z/6rqAuAc/oOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkY4RwV+BTLCbekYEumFoxUbDFv5+UrirkTtOlTnCjjmKseqIFSXVOBBRLKGmCXkovwIMtY8tmOYfLpkLFWLi0kzO5J2l2wLYVeKi/66GyC4NkwLBrDbyZjwnje7OfUSvztHtBrrPFd3+d0bCqSKHYBGAFIbRsPBHd9Tzs/1b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E07C3227A88; Thu, 13 Nov 2025 15:44:55 +0100 (CET)
Date: Thu, 13 Nov 2025 15:44:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: fix NULL pointer dereference in
 blk_zone_reset_all_bio_endio()
Message-ID: <20251113144455.GA30779@lst.de>
References: <20251113134028.890166-1-dlemoal@kernel.org> <20251113134028.890166-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113134028.890166-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 10:40:26PM +0900, Damien Le Moal wrote:
> For zoned block devices that do not need zone write plugs (e.g. most
> device mapper devices that support zones), the disk hash table of zone
> write plugs is NULL. For such devices, blk_zone_reset_all_bio_endio()
> should not attempt to scan this has table as that causes a NULL pointer
> dereference.
> 
> Fix this by checking that the disk does have zone write plugs using the
> atomic counter. This is equivalent to checking for a non-NULL hash table
> but has the advantage to also speed up the execution of
> blk_zone_reset_all_bio_endio() for devices that do use zone write plugs
> but do not have any plug in the hash table (e.g. a disk with only full
> zones).
> 
> Fixes: efae226c2ef1 ("block: handle zone management operations completions")
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although maybe factoring that loop into helper might be a tad cleaner?


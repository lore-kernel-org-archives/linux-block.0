Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CC40BCA7;
	Mon, 12 Oct 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807679; cv=none; b=QZNozNJaWabVBLE19mLVCZrlkT/vWfmaQhwqY3DDUZIdI9W4UT3HSfAwJslJkKWu4/A1JhZ+5JxJhg2qpZM3JclwEBLx6YwYk5JQ5XytutvemKep9eReGaSXIBHKUYztUswPtr4fy8Z9HeaDq0fCcFofUCFju3acVxhP1eLgsBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807679; c=relaxed/simple;
	bh=sU8/ulOfvvA0RjtnvesKzyLY9CeEodGvb1RmtuZPKjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ9nGMUE39qCNEXFv7MHoFkSsOhMtriUQZu/2lar1PCTH/QDp5SBNtGSgKg68EoVpvC6caCeZXiQIjmv1wBbzpTDYWlB8Zknj5kCAw3Pp4O64pRUCf+lFotk9Q3ehJqE98t5HSnrk97EiaX2V9xg9dsuuToYQLNYoN0vUqmy2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D855F6732A; Mon, 12 Oct 2026 14:21:12 +0200 (CEST)
Date: Mon, 12 Oct 2026 14:21:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in
 blkdev_get_zone_info()
Message-ID: <20261012122112.GA31242@lst.de>
References: <20261011051906.60397-1-jain.sm@gmail.com> <20261011051906.60397-3-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011051906.60397-3-jain.sm@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Oct 11, 2026 at 10:49:06AM +0530, Shashank Mohan Jain wrote:
> blkdev_get_zone_info() sets the length of every zone to the zone size
> of the device. The last zone of a zoned block device may be smaller
> than the others: blk_revalidate_zone_cb() accepts that and remembers
> the capacity of that zone in disk->last_zone_capacity. For such a zone
> the length reported from the cached information is too large, and
> start + len is beyond the end of the device. A conventional last zone
> is also given the capacity of a full zone.
> 
> Example with a zoned null_blk device of 10 MiB (20480 sectors) with
> 4 MiB zones, last zone:
> 
>   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
>   BLKREPORTZONEV2 with
>   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096

Can you add this to blktests as a reproducer?

The patch looks good:


Reviewed-by: Christoph Hellwig <hch@lst.de>

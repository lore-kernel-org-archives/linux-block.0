Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4F29ACF7
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847605; cv=none; b=b4bPgLVpAoceAh7MF99kGN2JsBobrowsRmfCT4Bdmu7GkzFBBm8zaV/DS97s7UShhBYM2VLNx3905LJM4wf1Bis7kvIOwmsPZ5iCzs1oAqtcCSLtTM70nP1QWX5ZJsRV+VBhpYx8+DRZcThxT+iZ7uQP8eKm+MRHgSc75AYlkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847605; c=relaxed/simple;
	bh=A/RQo/JEvHNeslPvZwGAXy9eTBZOUDl5xzKKS73yNFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rulqQgkNYeiB2payEWiaunTrlbn8gaDa/Ie9zZgVi4T4jBVJpKWljJvG0xflmxPSrip6hJTM3uqu8fpfdPeuUSViDHABvChsRf2DGMuqh4zFJKaU9L/V9eBMVfw8iYP1eCJGc8eHObunM8XaiZHpH45nf9GiRN6YR0QOsIlh6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D8DB227A87; Tue, 11 Nov 2025 08:53:19 +0100 (CET)
Date: Tue, 11 Nov 2025 08:53:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 4/4] blk-zoned: Move code from
 disk_zone_wplug_add_bio() into its caller
Message-ID: <20251111075318.GD6596@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org> <20251110223003.2900613-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110223003.2900613-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 02:30:02PM -0800, Bart Van Assche wrote:
>  plug:
> +	schedule_bio_work = !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
> +	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
> +
>  	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
> +	if (schedule_bio_work)
> +		disk_zone_wplug_schedule_bio_work(disk, zwplug);

Given that the new disk_zone_wplug_add_bio does not touch
BLK_ZONE_WPLUG_PLUGGED, this reads odd.  Why not:

 	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
	if (!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)) {
		zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
		disk_zone_wplug_schedule_bio_work(disk, zwplug);
	}

and do away with the extra variable?

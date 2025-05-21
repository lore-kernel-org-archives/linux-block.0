Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2872309B5
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807136; cv=none; b=X6fThvlUoKmrtkOH12HI3jdLcxs8TqQxz2izDNl2S/YNziIjCrnwmDOr2UDdPAeFv4/CiocRcUdn0fVg/dNshqCzHzHF2ykvlzrJnnrmgQfC/LUxVH09b8aD+tWoAb4Lch0vUKfoA1RPI/KO6dH3huoorNXGA8o7eIlC189ZvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807136; c=relaxed/simple;
	bh=8Vco2scVau7HPWT3U0qIKL/aAKDi8UGH05ORT4lKqV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jagfby05FZNDk22KDweUpen20skC0ShUBDbjessbnSrgQ95yepLuj28FuRf8XzlreDolwWPtnjs4gLnMZ9O5sN8wYL5csV+v941M5mUHB0be1re4orChDPxwPzMvLm61nsLpvFTfNxW08uP04T53HyzvXN04GycbFK2iaycPcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D72C68D17; Wed, 21 May 2025 07:58:49 +0200 (CEST)
Date: Wed, 21 May 2025 07:58:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 1/3] blk-zoned: Move locking into
 disk_zone_wplug_set_wp_offset()
Message-ID: <20250521055849.GB3109@lst.de>
References: <20250521000626.1314859-1-bvanassche@acm.org> <20250521000626.1314859-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521000626.1314859-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 20, 2025 at 05:06:24PM -0700, Bart Van Assche wrote:
> Instead of holding zwplug->lock around disk_zone_wplug_set_wp_offset() calls,
> move zwplug->lock locking into disk_zone_wplug_set_wp_offset(). Prepare for
> reducing the amount of code protected by zwplug->lock. No functionality has
> been changed.

Please wrap your commit logs after 73 characters.

> +					  bool only_if_update_needed)

That would probably be a bit better with a bool force, that is inverted.

>  {
> -	lockdep_assert_held(&zwplug->lock);
> -
> -	/* Update the zone write pointer and abort all plugged BIOs. */
> -	zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
> -	zwplug->wp_offset = wp_offset;
> -	disk_zone_wplug_abort(zwplug);
> +	scoped_guard(spinlock_irqsave, &zwplug->lock) {

And don't randomly mess up the code to new locking methods.  Please
stick to the lock/unlock helpers here instead of starting a grand
reformatting.


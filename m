Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9813C663
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660478; cv=none; b=L1lkSQ0T03ggq0fpYsoAaDvtulxQBGR6nklGmIGgkXr89ph4AIv5wQQkfr8/meEfkq6buKAMXCrQNiJS643+uItqx3d/aZuiK7tsIlOL3BYLzEqCP9dub0tX2YRJCiVXzVKqe5hLQSGfwvcClfMyfP81vTSkYIpVXPiodhSQ+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660478; c=relaxed/simple;
	bh=Q6Ue1f3YLSKPkdpKyBXywb5N7htHk08/DkrtBJDJ4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbcQtWb+HnDJa4OMb59eh9f6UhCFuBpH7xwoAnnkz81LMdaMdiXieRm9I+jhLRgjaCJUMlWMB1lJu00RAwUK8KQ416PVtVqY23odSa5tS13BE62t7guLPc7uS0zwJOQrZ6vRXqTP15orm2USwggNKADd+MNFvmGUfBS7QAZfdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE42E68D07; Thu,  6 Jun 2024 09:54:25 +0200 (CEST)
Date: Thu, 6 Jun 2024 09:54:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v5 2/4] dm: Call dm_revalidate_zones() after setting
 the queue limits
Message-ID: <20240606075425.GA14059@lst.de>
References: <20240606073721.88621-1-dlemoal@kernel.org> <20240606073721.88621-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606073721.88621-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 06, 2024 at 04:37:19PM +0900, Damien Le Moal wrote:
> dm_revalidate_zones() is called from dm_set_zone_restrictions() when the
> mapped device queue limits are not yet set. However,
> dm_revalidate_zones() calls blk_revalidate_disk_zones() and this
> function consults and modifies the mapped device queue limits. Thus,
> currently, blk_revalidate_disk_zones() operates on limits that are not
> yet initialized.
> 
> Fix this by moving the call to dm_revalidate_zones() out of
> dm_set_zone_restrictions() and into dm_table_set_restrictions() after
> executing queue_limits_set().
> 
> To further cleanup dm_set_zones_restrictions(), the message about the
> type of zone append (native or emulated) is also moved inside
> dm_revalidate_zones().
> 
> Fixes: 1c0e720228ad ("dm: use queue_limits_set")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/md/dm-table.c | 15 +++++++++++----
>  drivers/md/dm-zone.c  | 25 ++++++++++---------------
>  drivers/md/dm.h       |  1 +
>  3 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index b2d5246cff21..f0c27d5a738b 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -2028,10 +2028,7 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  	    dm_table_any_dev_attr(t, device_is_not_random, NULL))
>  		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>  
> -	/*
> -	 * For a zoned target, setup the zones related queue attributes
> -	 * and resources necessary for zone append emulation if necessary.
> -	 */
> +	/* For a zoned table, setup the zones related queue attributes. */

s/zones/zone/ ?  Or is my grammar dector way off?


Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


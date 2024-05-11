Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D817BA8
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468095; cv=none; b=mUfp0rATEsZUTbQcT6Zu7msciDOTcBnvSZSXh1kZZwQMXUtO7yRu2KynPth+NDfVS67I6SLklYjL8lsPmxD3EOY3Hktp3ETuV8SZM1OYUl5oSM8CmivD4wbEVJn0fCSXGk448ApDO1NDwXzONCaQvYjADB81aY2SQNHxNDMrywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468095; c=relaxed/simple;
	bh=xCy4+3XZ1qV/Gr7M5RgjAaZuv4A6vKSTuHe3uAT3rsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L789HcNpAPZRWp0C9Z6tIMyR5sBo6ou4jgIgwWzoNh+kf/HPKtf3k8GXX0hqBPFD7NG6sKhfOa7jV8KSW9SlCB5gkQbEsSw0Bz1TUw2YPioJt9PySVwLJC4kuOED1aA0BHwZTExg3zAm83LgAIef/vBCRi2xSFbbnsUVRR2jVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BuRgH47Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BuRgH47Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pYqRunH9K+qBKaXoKqrBv713BL75faWgqRnl+hTvRkc=; b=BuRgH47Y5FR6+Tje3JIGDeZq5Y
	kFVEIuY1gSxbzKYle5lETIXyxCtSs/4jA+dVF/gS8PgVe0EhBVM/n1LWiBWkHAP+UMSCLz0jcysOG
	Z70rdwsOT9a/FwQ3cmNn4GrPUmtVEE/vEShzt1PRAjXgnwvne1zLM52aAbeBLiPOnt8rh3OvYf3oB
	EiGCzwthac72JzGDwAtHE6sd82NGGROc+e4HiTuzYkRrArygrGnMssgx2xP0ati8ZbFwPv/X5V92c
	itomPhfKYRLO8kJXaOmQAmixOZg5CeBQXMTGNd9Ze1fOVrLsy6wbiumJWn5j26g69PJ8SB3JKx9lM
	mVzxDA+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vcB-00000008rWx-0jL5;
	Sat, 11 May 2024 22:54:51 +0000
Date: Sat, 11 May 2024 15:54:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Message-ID: <Zj_3O8QOQ6IRZ9IK@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-4-hare@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, May 10, 2024 at 12:29:04PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> We now can support blocksizes larger than PAGE_SIZE, so lift
> the restriction.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/bdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index b8e32d933a63..d37aa51b99ed 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -146,8 +146,8 @@ static void set_init_blocksize(struct block_device *bdev)
>  
>  int set_blocksize(struct block_device *bdev, int size)
>  {
> -	/* Size must be a power of two, and between 512 and PAGE_SIZE */
> -	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> +	/* Size must be a power of two, and larger than 512 */
> +	if (size < 512 || !is_power_of_2(size))

That needs to just be replaced with:

1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)

We're not magically shooting to the sky all of a sudden. The large folio
world still has a limit. While that's 2 MiB today, yes, we can go higher
later, but even then, we still have a cap.

  Luis

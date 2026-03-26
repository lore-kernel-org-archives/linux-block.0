Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6D1A3029
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535039; cv=none; b=txT45szF89eXoIfhw+IjIHa/7n893vfGDxfvf/MYR2UX6Yu90BouicQrQ0irnL5foGzcrIZmd/D+JeHiX3tHP0b4fLBW5sEjFlbs/dRW+oJmDIP8qr3azsgqzwuVwZfhV42scnwR72hyVfkW8fn5V6Ioeq9yQXP0xM2Q0IO+fnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535039; c=relaxed/simple;
	bh=X4kWL/d79CS6h4D7YdzW+1zAMT0MpK0uvnwt/nFK8pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTKmjYcR+3ih73qoygQWQ5E5Z0dGm9/Oc3/HPFtSHvBIn/Tw3F/AEmK99r6ykt8y4FidYvgrtzfp5yOsW6yCuoayex1Rw7HJ9fq579yqbYaIHEzpz+Pb12Wobb7zOchuUsguxLv9ZbHcqUGDOdVVmmavQkDWzpiZ0Rxdg/bc2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BFA868AFE; Thu, 26 Mar 2026 15:23:55 +0100 (CET)
Date: Thu, 26 Mar 2026 15:23:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>, Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 2/5] block: Fix the max_user_sectors lower bound
Message-ID: <20260326142355.GB16940@lst.de>
References: <20260325213719.2850619-1-bvanassche@acm.org> <20260325213719.2850619-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325213719.2850619-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:37:12PM -0700, Bart Van Assche wrote:
> The lowest value that can be supported for lim->max_user_sectors is the
> logical block size. This patch prepares for reducing BLK_MIN_SEGMENT_SIZE
> to a value that may be less than the logical block size.
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Fixes: 889c57066cee ("block: make segment size limit workable for > 4K PAGE_SIZE")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-settings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 87724d30be4f..13f5457f9f4e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -403,7 +403,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>  				lim->max_dev_sectors);
>  	if (lim->max_user_sectors) {
> -		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
> +		if (lim->max_user_sectors < lim->logical_block_size / SECTOR_SIZE)

Overly long line.


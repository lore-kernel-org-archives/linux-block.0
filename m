Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF912AAF0;
	Thu, 23 May 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451936; cv=none; b=fwMHYvBqqHslnfpuJ4cOEDbe9L8gK2mEYLus8jLNe3jAcRjqqfznN5rLGWbzR522nzsGiHoSFljoJ1MRzVvkaWqxlOyenHzI0ICJUpdn369nvavLXb0UQKPyfj8jx1lhu4XGSgY46P5Y7zYNPlYHyLQMK9mTSTNYuhBxS0WCov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451936; c=relaxed/simple;
	bh=yk/uOkB+LZYStOEPQkKIZcq0XqcYySnbilurHz1b0Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBS2VfKZRCIe16w3z/P+5AUbZPXOjsETMa0TKQVJZNZFfTzoUqsuOYmPh2w+7JIavh90gMJcOU3PyDCEz0lr4e1xXH3jFzwVnK7Co8RYcZFW3y5OMPoDSzJmVmzmeUJwdL7nE79cziexqiddS71ihC018FvX+eaPBIR0zy6ULRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 352B268BFE; Thu, 23 May 2024 10:12:08 +0200 (CEST)
Date: Thu, 23 May 2024 10:12:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
	hch@lst.de
Subject: Re: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
Message-ID: <20240523081207.GB1086@lst.de>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521224249.7389-1-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 21, 2024 at 10:42:48PM +0000, Gulam Mohamed wrote:
> Description
> ===========

That's a weird way to format a patch.  Between this and the odd subject
not matching patch 2 I was tricked into thinking this was just a cover
letter and patch 1 was missing for a while.  Please take a look at other
patches/commit and try to word it similarly.

> V1->V2:
> 	Added a test case, 010, in blktests in tests/loop/

These kind of patch revision changelogs belong after the --- so that they
don't go into git history.  Or even better into the cover letter, which
is missing here.

> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
>  drivers/block/loop.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 28a95fd366fe..9a235d8c062d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>  }
>  #endif
>  
> +static int lo_open(struct gendisk *disk, blk_mode_t mode)
> +{
> +        struct loop_device *lo = disk->private_data;
> +        int err;
> +
> +        if (!lo)
> +                return -ENXIO;

->private_data is never cleared, so the NULL check here doesn't
make sense.

> +        err = mutex_lock_killable(&lo->lo_mutex);
> +        if (err)
> +                return err;
> +
> +        if (lo->lo_state == Lo_rundown)
> +                err = -ENXIO;
> +        mutex_unlock(&lo->lo_mutex);

What if we race with setting Lo_rundown and that gets set right
after we unlock here?


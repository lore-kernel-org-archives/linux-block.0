Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7832D0E2
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901211; cv=none; b=BjabCJOUO7k2ZuEWBnFiD8z0VXV65U3vVRbnmus52zae5kHq3G886LV6TB/XFB2yHmxS9v3gFkW8IVYm/jkQiIdd2qST5rVX5G1HllYr47c0c8tbW/wJp3Hv7DmTIhBb7wcM+tGG6vQkLygFNln+7cmW8EM5XorfQExEHYK9JkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901211; c=relaxed/simple;
	bh=vBKNysuoSD6e5PpzDq2N/WjxdWqn6kFqC1ZMWx4Vsgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMg/ZuVq+4ZFwXMtLI4hA+n1f3SSKy1p0JHAAEpJHCBoN7nLxHhOn1PcK61Rx9AJr1obb8rhhJ/vgOlPSjXdSiFguynmu/HClnPv2bJAO3FHLCGtiUszf0i31O8c4pjnXtblVma3HkwryNsKXl/ti0Ai6mVecsxo515J5FQ1A3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED8A16732A; Fri, 31 Oct 2025 10:00:04 +0100 (CET)
Date: Fri, 31 Oct 2025 10:00:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Message-ID: <20251031090003.GA9129@lst.de>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133956.19554-1-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Maybe you can resend this with the Fixes tag and a blurb that this path
is exercised by xfstests since  851c4c96db00
("xfs: implement XFS_IOC_DIOINFO in terms of vfs_getattr") and causes
reproducible memory corruption?  Because that might help to get it
included ASAP..

On Wed, Oct 29, 2025 at 02:39:56PM +0100, Hans Holmberg wrote:
> This driver assumes that bio vectors are memory aligned to the logical
> block size, so set the queue limit to reflect that.
> 
> Unless we set up the limit based on the logical block size, we will go
> out of page bounds in copy_to_nullb / copy_from_nullb.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
> 
> A fixes tag would be in order, but I have not figured out exactly when
> this became a problem.
> 
>  drivers/block/null_blk/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f982027e8c85..0ee55f889cfd 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1949,6 +1949,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		.logical_block_size	= dev->blocksize,
>  		.physical_block_size	= dev->blocksize,
>  		.max_hw_sectors		= dev->max_sectors,
> +		.dma_alignment		= dev->blocksize - 1,
>  	};
>  
>  	struct nullb *nullb;
> -- 
> 2.34.1
---end quoted text---

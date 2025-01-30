Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022E14D433
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738216181; cv=none; b=OUpC4ehepfKr8zRI4QQxrRGPry2goCpN+BEQv0lhVdbcVFOc3elBt2nvx1DtITNXbp621+zOlfbgqcr28JUwQM2rZ9ld+Z0f6zwAQelA0gmlSRMOLWweYhj6NXz2fERZEvmzWjb09+XOlIb7jXZSkKhTvF+VhTYzOMBbJKGp+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738216181; c=relaxed/simple;
	bh=anbYlJz8k0k9O9YrCPQ/jgqqj0HNCnUhzaKGE4G+vfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOTZdMJJnq/azRBKq6wDEzetd1kSbnMnl6MWWw7RTUFBNAzVDrPDQ2YzBmhWIsHzn8ZctuBBJyDbJoxve8imkNYYAgnOSwqa7++Wn10HxgtCYNxVQPdDORp4oWRT+j39v0ccLdFKSMNpcoPeczn7KkwNFFLM9ccdbFTTQMtH8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HykCUZRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HykCUZRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6863C4CED3;
	Thu, 30 Jan 2025 05:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738216180;
	bh=anbYlJz8k0k9O9YrCPQ/jgqqj0HNCnUhzaKGE4G+vfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HykCUZReH57WO2sDwBUJOufD0sbL8ePV0dvwbKKGmnDYIzb0UVdFhJmzJhfCUsj+A
	 0twpcnFzqhMCIZ+HhGPkhNOPpDBenkEhpqYSa+FhyFZC7sVdTHgHSFl2KOg2YJR1wO
	 YGCvzp2hllnJvfKwhXhYJ5Moj2lEXymoUQvu00ZzaTXeU/05S4HsDpQzSpMBlW+wi7
	 3mTkDTBtpR0cmYDXSbSuFi4MOV+VmHkikib6qeUEEVFq9MzleS5QIT4nLNvd5vOq93
	 3OrueI6FbUzEQR1FEDyF5Z39HTRvuipMyqLHGuFvlyphFdHcJ3lAd/UtjU0Qb8xmMS
	 Qanv4Evv40+Ug==
Message-ID: <c6603890-4b2d-4ad3-9fd0-19a6274a25d8@kernel.org>
Date: Thu, 30 Jan 2025 14:49:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: take the file system minimum dio alignment into
 account
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250127152236.612108-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250127152236.612108-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/25 00:22, Christoph Hellwig wrote:
> The loop driver currently uses the logical block size of the underlying
> bdev as the lower bound of the loop device block size.  While this works
> for many cases, it fails for file systems made up of multiple devices
> with different logic block size (e.g. XFS with a RT device that has a
> larger logical block size), or when the file systems doesn't support
> direct I/O writes at the sector size granularity (e.g. because it does
> out of place writes with a file system block size larger than the sector
> size).
> 
> Fix this by querying the minimum direct I/O alignment from statx when
> available.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 58 ++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)

[...]

> +static void loop_query_min_dio_size(struct loop_device *lo)
> +{
> +	struct file *file = lo->lo_backing_file;
> +	struct block_device *sb_bdev = file->f_mapping->host->i_sb->s_bdev;
> +	struct kstat st;
> +
> +	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
> +	    (st.result_mask & STATX_DIOALIGN))
> +		lo->lo_min_dio_size = st.dio_offset_align;

Nit: Maybe return here to avoid the else below and the comment block in the
middle of a if-else-if ?

> +	/*
> +	 * In a perfect world this wouldn't be needed, but as of Linux 6.13 only
> +	 * a handful of file systems support the STATX_DIOALIGN flag.
> +	 */
> +	else if (sb_bdev)
> +		lo->lo_min_dio_size = bdev_logical_block_size(sb_bdev);
> +	else
> +		lo->lo_min_dio_size = SECTOR_SIZE;
> +}

[...]

> -static unsigned int loop_default_blocksize(struct loop_device *lo,
> -		struct block_device *backing_bdev)
> +static unsigned int loop_default_blocksize(struct loop_device *lo)
>  {
> -	/* In case of direct I/O, match underlying block size */
> -	if ((lo->lo_backing_file->f_flags & O_DIRECT) && backing_bdev)
> -		return bdev_logical_block_size(backing_bdev);
> +	/* In case of direct I/O, match underlying minimum I/O size */
> +	if (lo->lo_backing_file->f_flags & O_DIRECT)
> +		return lo->lo_min_dio_size;

I wonder if conditionally returning lo_min_dio_size only for O_DIRECT is
correct. What if the loop dev is first started without direct IO and gets a
block size of 512B, and then later restarted with direct IO and now gets a block
size of say 4K ? That could break a file system that is already on the device
and formatted using the initial smaller block size. So shouldn't we simply
always return lo_min_dio_size here, regardless of if O_DIRECT is used or not ?

>  	return SECTOR_SIZE;
>  }
>  
> @@ -993,7 +998,7 @@ static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
>  		backing_bdev = inode->i_sb->s_bdev;
>  
>  	if (!bsize)
> -		bsize = loop_default_blocksize(lo, backing_bdev);
> +		bsize = loop_default_blocksize(lo);
>  
>  	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
>  
> @@ -1090,6 +1095,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  	lo->lo_backing_file = file;
>  	lo->old_gfp_mask = mapping_gfp_mask(mapping);
>  	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> +	loop_query_min_dio_size(lo);
>  
>  	lim = queue_limits_start_update(lo->lo_queue);
>  	loop_update_limits(lo, &lim, config->block_size);


-- 
Damien Le Moal
Western Digital Research

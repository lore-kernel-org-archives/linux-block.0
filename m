Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAEC10F9
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958258; cv=none; b=OnZ/BfOcRMgusXuRIbCryrD20zx3r5sm0Px8D6lz/M7Le2vqD4lWtBJdTRhHZgVfxX4wnJUyPWZHRznL9k28HDLVky+MGaD8ZzznoSn18b7J25isCZ0VZVP6kURUFCpGZkSk753GVJvTj8Iyb47IRgHMo3fodWj+lGbXcx+EcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958258; c=relaxed/simple;
	bh=Pe0ObNFc2c/qwR6/KiVNR4Ql0kuaCNzK22rpwzGJbt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDK+vp75bfyGzfhUdVZ+ttO+MWmpR8nZ/mFo3ErzhCHBtl+G80jk2LE2TG54Uv/Cz7Tewb5/GBjL9xuKP6y1WQiCFWTsX6bJM6wcvgOkGoa3TFn+ETAO/L+rNubybBheqOxMFdEuN5aNY0Hrc4bDQPYVQCLgBeCpA3Ob1AsTuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+Km8u4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+Km8u4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60889C4CECC;
	Thu,  7 Nov 2024 05:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730958257;
	bh=Pe0ObNFc2c/qwR6/KiVNR4Ql0kuaCNzK22rpwzGJbt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s+Km8u4XGvInK60eDoq5qm+hXPAvfWjE0ntC5iSsm0ofgmGl787mQE686eclX6Hdj
	 5hBvIk4Mh3mwdPmdcPqxFeFrmOhWjXY6qcAtv30fMrKnTz/StDGcHJsxWDFLD2hDBg
	 FUNIYmj5scWCrX2A93B6A9XCpgYkFNte7Adynn1Hfb/1RNyW2A3/x9jEeql15/pBqY
	 VDlj2oFi5qtKM4fjPFglbrdpMA8ix+2PPem3qorfYzGZEFMQQ6wjRmyZACjsefsIpe
	 aJ4GkebE9XYamzAmqcqM43BZ8EYvTkb+rgob/R2A8ZCrXI8oD7ygdIsINQa25LlwNm
	 UyLGzFYapJ/pA==
Message-ID: <ba5cecfc-2f99-49c3-97bf-2ca0364f570a@kernel.org>
Date: Thu, 7 Nov 2024 14:44:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20241106231323.8008-1-dlemoal@kernel.org>
 <20241106231323.8008-2-dlemoal@kernel.org> <20241107054028.GA2135@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241107054028.GA2135@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 14:40, Christoph Hellwig wrote:
> As sparse rcu warnings got in my radar for something else, I did
> run sparse over this and it complains.  It will need the little
> gem below to fix (and a rebase of the second patch).  Otherwise the
> series looks great and way better than my initial hack, thanks!

OK. I will integrate this and send v2.

> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 7a7855555d6d..bf4458b11720 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -350,11 +350,12 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  
>  static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
>  {
> +	unsigned long *bitmap;
>  	bool is_conv;
>  
>  	rcu_read_lock();
> -	is_conv = disk->conv_zones_bitmap &&
> -		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
> +	bitmap = rcu_dereference(disk->conv_zones_bitmap);
> +	is_conv = bitmap && test_bit(disk_zone_no(disk, sector), bitmap);
>  	rcu_read_unlock();
>  
>  	return is_conv;
> @@ -1467,11 +1468,10 @@ static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
> +	if (bitmap)
> +		nr_conv_zones = bitmap_weight(bitmap, disk->nr_zones);
>  	bitmap = rcu_replace_pointer(disk->conv_zones_bitmap, bitmap,
>  				     lockdep_is_held(&disk->zone_wplugs_lock));
> -	if (disk->conv_zones_bitmap)
> -		nr_conv_zones = bitmap_weight(disk->conv_zones_bitmap,
> -					      disk->nr_zones);
>  	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
>  
>  	kfree_rcu_mightsleep(bitmap);


-- 
Damien Le Moal
Western Digital Research

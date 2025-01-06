Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1808199391
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736143065; cv=none; b=FobNg9VAifP/ovNpgDKJyqh3eAMj1OVPuzpdrYtFsWt3FkikG3RPdXZupINtgxggaqFkJkuI49OchnrSOL/kmu6p4MaQJBhXwZ2Mibyc1i2PWX3I29pBQMj0Oo/EYeDOeWi3zJ0W3zVjS09MpnqO61lrFMgyQM24qvIX9Gs3azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736143065; c=relaxed/simple;
	bh=PE4f4lJgHUPlO21OcbkfMrGnajz12Gmaf1AnBZkzLLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDwTfXyHq/MwAhLAWgV6CBCyLL49EV6ikhQPPCWvLT+XmKY9E2CVSy3ZIYC5DMmcqK/SJ3D4iRvg355iPOyG39AjwlOYYHy0xLFcJkqsUwes2JYz8W44dG+X9WUY3OvD0tfO4aM6Zyv5/WADNqRQQqwn+TUHm4TLWrrRl0ecnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEZQB1tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEZQB1tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A35C4CED2;
	Mon,  6 Jan 2025 05:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736143064;
	bh=PE4f4lJgHUPlO21OcbkfMrGnajz12Gmaf1AnBZkzLLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WEZQB1tlOTYCVat2L5/sFLZHxKDgDDg1r07S3GsdbGKJS6DOvXfsJXbVwVNdQg7k1
	 d0xbnkFHe1k7+7FJO7DhzzWF5hZSZSgEGpg3eOqOfO9xn+cmyuMsHcKU7vSUiSTNyN
	 yUEVKD/wRGg310Zbq1iJbQUqdhxUKK8/wBIJ8o7dcE+BhLoDS1QOCid3xLBC+xy64Z
	 l/B/f+QMSpFylHQF05+Y/GGTUWSS8jmvNeCISvM4UjK09A6InBM4J4JfrURfRG4qya
	 FDzmwfor7sWZBV4BalbUZLK6vryCaxVTzE1k15zXKlyMdQDCodAu6K75TMz9ylW5dF
	 0MKqrxv3cHrrg==
Message-ID: <91b6bad9-fe99-4015-8736-d14deddb08a8@kernel.org>
Date: Mon, 6 Jan 2025 14:56:59 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 3/4] null_blk: move write pointers for partial
 writes
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-4-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241225100949.930897-4-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> The previous commit modified bad blocks handling to do the partial IOs.
> When such partial IOs happen for zoned null_blk devices, it is expected
> that the write pointers also move partially. To test and debug partial
> write by userland tools for zoned block devices, move write pointers
> partially.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/block/null_blk/main.c     |  5 ++++-
>  drivers/block/null_blk/null_blk.h |  6 ++++++
>  drivers/block/null_blk/zoned.c    | 10 ++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index d155eb040077..1675dec0b0e6 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1330,6 +1330,7 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
>  }
>  
>  static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
> +						 enum req_op op,
>  						 sector_t sector,
>  						 sector_t nr_sectors)
>  {
> @@ -1347,6 +1348,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
>  			transfer_bytes = (first_bad - sector) << SECTOR_SHIFT;
>  			__null_handle_rq(cmd, transfer_bytes);
>  		}
> +		if (dev->zoned && op == REQ_OP_WRITE)

Forgot REQ_OP_ZONE_APPEND ?

> +			null_move_zone_wp(dev, sector, first_bad - sector);
>  		return BLK_STS_IOERR;
>  	}
>  
> @@ -1413,7 +1416,7 @@ blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
>  	blk_status_t ret;
>  
>  	if (dev->badblocks.shift != -1) {
> -		ret = null_handle_badblocks(cmd, sector, nr_sectors);
> +		ret = null_handle_badblocks(cmd, op, sector, nr_sectors);
>  		if (ret != BLK_STS_OK)
>  			return ret;
>  	}
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 6f9fe6171087..c6ceede691ba 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -144,6 +144,8 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
>  				sector_t sector, unsigned int len);
>  ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
>  			size_t count, enum blk_zone_cond cond);
> +void null_move_zone_wp(struct nullb_device *dev, sector_t zone_sector,
> +		       sector_t nr_sectors);
>  #else
>  static inline int null_init_zoned_dev(struct nullb_device *dev,
>  		struct queue_limits *lim)
> @@ -173,6 +175,10 @@ static inline ssize_t zone_cond_store(struct nullb_device *dev,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline void null_move_zone_wp(struct nullb_device *dev,
> +				     sector_t zone_sector, sector_t nr_sectors)
> +{
> +}
>  #define null_report_zones	NULL
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  #endif /* __NULL_BLK_H */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 0d5f9bf95229..e2b8396aa318 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -347,6 +347,16 @@ static blk_status_t null_check_zone_resources(struct nullb_device *dev,
>  	}
>  }
>  
> +void null_move_zone_wp(struct nullb_device *dev, sector_t zone_sector,
> +		       sector_t nr_sectors)
> +{
> +	unsigned int zno = null_zone_no(dev, zone_sector);
> +	struct nullb_zone *zone = &dev->zones[zno];
> +
> +	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
> +		zone->wp += nr_sectors;
> +}

I do not think this is correct. We need to deal with the zone implicit open and
zone resources as well, exactly like for a regular write. So it is not that simple.

I think that overall, a simpler approach would be to reuse
null_handle_badblocks() inside null_process_zoned_cmd(), similar to
null_process_cmd(). If reusing null_handle_badblocks() inside
null_process_zoned_cmd() is not possible, then let's write a
null_handle_zone_badblocks() helper.

> +
>  static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  				    unsigned int nr_sectors, bool append)
>  {


-- 
Damien Le Moal
Western Digital Research

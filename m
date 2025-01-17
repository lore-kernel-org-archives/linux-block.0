Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB21CEAD3
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154814; cv=none; b=BQWZDjGdg2AB06a5MfgDn+WYJ9/qKoyfnyh3VOiaEqVjybt0mjMHl2LtGv3MGokDw+A5v6Azzjq6yVW5zh05sMoTzHfejVhdGviVC9ARb5w3BeE/IdCiuKcFyEuzTel8avmUNB7A9mHTDr8kkyZI1jFoiaXFXKMi41J0r7DfJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154814; c=relaxed/simple;
	bh=TJUyRbaLKGE7HnsY5YtnFbpmE/8ChqNKydAtHkt/IkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/3F4Z9DtrMYmg702SYnME3h69rducX1BFKTra4JIcU1ka6VOGZE/oebxYcxHei0nOV1kWBHar2DrcVO+tbgol2uPz2PzS56rAYOLQgn+8rblSyL3R+hGmgVxCamRcV9SLTYEsRvOC9ksjLk9Rz8PqFIN7OGU16DQw0MHWV0SkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmY2vdqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmY2vdqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8CAC4CEDD;
	Fri, 17 Jan 2025 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737154813;
	bh=TJUyRbaLKGE7HnsY5YtnFbpmE/8ChqNKydAtHkt/IkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GmY2vdqF0oXO1UXh5EtrSCKD9SOB3N1iT5695b/zWSXQ73Q39/DcKwBuzejqbJq3y
	 RIuDXeqdmyZkG1oCAE4iK5D2TKM9K5FNVFGOzUv8OfpnNqIWhtLFbiNgiec1rGFY8O
	 4muqNHwfi9iz7vuf6a+42BY2hW29cBTu8MgIxsaXsPhiSvV1OscJqC78tzr29B08DK
	 MwLIAm0tDfF1G+NIbUsABpXX2TJYG/0GKpxMqSl08nAZD1c1ba1B0bsazYxuAblXbF
	 CN9dpTCe7ysxpv3g49Rt5pldiq/kPN1r57oacw+9r0I+Cpqa05Wv2Hv/NQqPzzYv2H
	 pFmzGJ/5dWlGg==
Message-ID: <22e5c5a8-ad31-4a0f-a64e-33b34075a97d@kernel.org>
Date: Sat, 18 Jan 2025 08:00:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 3/5] null_blk: fix zone resource management
 for badblocks
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-4-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115042910.1149966-4-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
> When the badblocks parameter is set for zoned null_blk, zone resource
> management does not work correctly. This issue arises because
> null_zone_write() modifies the zone resource status and then call
> null_process_cmd(), which handles the badblocks parameter. When
> badblocks cause IO failures and no IO happens, the zone resource status
> should not change. However, it has already changed.

And that is correct in general. E.g. if an SMR HDD encounters a bad block while
executing a write command, the bad block may endup failing the write command but
the write operation was already started, meaning that the zone was at least
implicitly open first to start writing. So doing zone management first and then
handling the bad blocks (eventually failing the write operation) is the correct
order to do things.

I commented on the previous version that partially advancing the wp for a write
that is failed due to a bad block was incorrect because zone resource management
needed to be done. But it seems I was mistaken since you are saying here that
zone management is already done before handling bad blocks. So I do not think we
need this change. Or is it me who is completely confused ?

> 
> To fix the unexpected change in zone resource status, when writes are
> requested for sequential write required zones, handle badblocks not in
> null_process_cmd() but in null_zone_write(). Modify null_zone_write() to
> call null_handle_badblocks() before changing the zone resource status.
> Also, call null_handle_memory_backed() instead of null_process_cmd().
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/block/null_blk/main.c     | 11 ++++-------
>  drivers/block/null_blk/null_blk.h |  5 +++++
>  drivers/block/null_blk/zoned.c    | 15 ++++++++++++---
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 2a060a6ea8c0..87037cb375c9 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1309,9 +1309,8 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
>  	return sts;
>  }
>  
> -static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
> -						 sector_t sector,
> -						 sector_t nr_sectors)
> +blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
> +				   sector_t nr_sectors)
>  {
>  	struct badblocks *bb = &cmd->nq->dev->badblocks;
>  	sector_t first_bad;
> @@ -1326,10 +1325,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
>  	return BLK_STS_IOERR;
>  }
>  
> -static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
> -						     enum req_op op,
> -						     sector_t sector,
> -						     sector_t nr_sectors)
> +blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
> +				       sector_t sector, sector_t nr_sectors)
>  {
>  	struct nullb_device *dev = cmd->nq->dev;
>  
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 3c4c07f0418b..ee60f3a88796 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -132,6 +132,11 @@ blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
>  				 sector_t nr_sectors);
>  blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
>  			      sector_t sector, unsigned int nr_sectors);
> +blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
> +				   sector_t nr_sectors);
> +blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
> +				       sector_t sector, sector_t nr_sectors);
> +
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 0d5f9bf95229..09dae8d018aa 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -389,6 +389,12 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  		goto unlock_zone;
>  	}
>  
> +	if (dev->badblocks.shift != -1) {
> +		ret = null_handle_badblocks(cmd, sector, nr_sectors);
> +		if (ret != BLK_STS_OK)
> +			goto unlock_zone;
> +	}
> +
>  	if (zone->cond == BLK_ZONE_COND_CLOSED ||
>  	    zone->cond == BLK_ZONE_COND_EMPTY) {
>  		if (dev->need_zone_res_mgmt) {
> @@ -412,9 +418,12 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  		zone->cond = BLK_ZONE_COND_IMP_OPEN;
>  	}
>  
> -	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
> -	if (ret != BLK_STS_OK)
> -		goto unlock_zone;
> +	if (dev->memory_backed) {
> +		ret = null_handle_memory_backed(cmd, REQ_OP_WRITE, sector,
> +						nr_sectors);
> +		if (ret != BLK_STS_OK)
> +			goto unlock_zone;
> +	}
>  
>  	zone->wp += nr_sectors;
>  	if (zone->wp == zone->start + zone->capacity) {


-- 
Damien Le Moal
Western Digital Research

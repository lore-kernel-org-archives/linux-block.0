Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175783CC7
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603440; cv=none; b=TVaghb+B9+LrPpgmvWDYIx6wrJ6SAVCMbRxC5/aW4m48lJcm7u9Bq4WNTgVN6544JBABES+zomCQb0Jx/ZtpGM1Jk86vaV1mE7RuTnGunsFuGMhc0vRGImRMFuyx2r4Be/38ToGL8qNyTWqMYr4TyfqoLLpSR4pV/zFQgvsVQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603440; c=relaxed/simple;
	bh=3Z2lxp7mAFuaEpFGaIPnfTd0R5xlCF1+DIDl4NPIqzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5jK7+pfVbkDGUwcehra4LN2VuR4SKEepfhG/brci4cWqAf3/Kbybz8dfOOph+fAVl1NA7mz8jhLwLvDQXoHm53Z5qrjWeGqmudL3u3g3TKl2qa7gvQEvmJHVI42Ns2Yp5IL1MvdNynBiXxxZzm8O+eiF8SRtcgW+y/yKXEpkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/quUOnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/quUOnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE9BC4CED2;
	Thu, 23 Jan 2025 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737603440;
	bh=3Z2lxp7mAFuaEpFGaIPnfTd0R5xlCF1+DIDl4NPIqzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/quUOnvxGdCVfRbPjWEdQ8P4uccaBxBoDK9iZSL/qbBqGRkeqPE9ML5CvFgaJinY
	 GvAtmM59XtvLiLuHq8amyjFnynx6+tQcrAgULgT9dsw54mtyaUv9IPMrvPRRzNlktK
	 SDWpBwYMezzGxnKY90nlLOjSPBS9fC3mhmnxi6PB5/OGGoKOfTh8MsWaNRmtfr8ao+
	 LTFu+LcKY8/EWjYwz1UNU3vfKxpnYVBup2Ay5pQt3e2dP/xApiTYDmBl4Xj3V4CYvS
	 N3g/DQqe/AHjeomJ3upTHo3quf1QuKxg/kT4CdmV6zQN4FbPbz110m1TDx92I2fVTV
	 hY38m5Um+aztQ==
Message-ID: <762c1246-5436-494c-b7e0-0f4ace34e88b@kernel.org>
Date: Thu, 23 Jan 2025 12:37:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v4 3/5] null_blk: fix zone resource management
 for badblocks
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250121081517.1212575-1-shinichiro.kawasaki@wdc.com>
 <20250121081517.1212575-4-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250121081517.1212575-4-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 5:15 PM, Shin'ichiro Kawasaki wrote:
> When the badblocks parameter is set for zoned null_blk, zone resource
> management does not work correctly. This issue arises because
> null_zone_write() modifies the zone resource status and then call
> null_process_cmd(), which handles the badblocks parameter. When
> badblocks cause IO failures and no IO happens, the zone resource status
> should not change. However, it has already changed.

s/zone resource status/zone condition

s/it has already changed/it may have already changed
(because not all write operations change the zone condition)

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

This should come after the below zone condition check and change...

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

...so about here. If null_handle_badblocks() return BLK_STS_IOERR because the
first sector of the write operation is the bad one, then we will return an error
and not change the write pointer, but we do have correctly changed the zone
condition nevertheless, exactly like a real drive would.

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

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423193;
	b=0wlcA3Rg6xcaleU8Y204ZlMtHTBm69ofZgDkY72eLweYhipHkNLPqY95iRXX6XhLL/0x
	 uph1CAidQXvnjyFya6if19uzD9xKNXeYLaodRJ4iBrtKlkq8+UITelpAvMXzi8aA1+iJk
	 5pQUCEonbNSkocj242ItHfanQ0nImuCBKL1oOYdhQxI3B4Qvr0lWgnCeMgVqgmgd7loY7
	 539cDPmAEML14gI9tCL+GNoswL0CpDbYuvUF2jKWC9MkTayKLLBkliP5cSfp+i9veo2/A
	 tX/+AxxEEeUSK11yLE8HLFYwYWxw524F0OhCT3esVEyBcFhYdgFVcWg3vcW1pDbd/6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423193;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=l+IXF2dNlY5wfk1nJpwoo3b3hiOYZj6Q5ePldbB2IAc=;
	b=zfqP9aHRBlVJLUooQphKMxzvtUsaAdjNXPOwCVJ65mcNxJIoAaD/qpU9pWvSEqBKV/Ry
	 jeJ2Ct3fiQegy8Uw5nXKYDkd24OGRRhhI53Lmjg2JbyQavWV8sKTlWOar3N1kahLz5Jl+
	 6lxbPkl6171Jmb8MUwk6Hv1DkvmcE4OISOBrBbDSmQAxDiwrjNk/5QhRH3Z7ZtTSZU1XH
	 ZtPyCFsT6cFL/oVuGDr9JCBAmm14qMB7f2ptvZUifR63L8kp/kahxmLYRpkPNaZMhWQ7/
	 uAoaWX+FxnrScld5Izd9r53SSEJ+K/PygiUSis4OIpCcBavTbNHZ8wfIt4jy1ME+SVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8zTiKst;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D160A6F48
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8zTiKst
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9967A1F000C4;
	Mon, 19 Oct 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423193;
	bh=l+IXF2dNlY5wfk1nJpwoo3b3hiOYZj6Q5ePldbB2IAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q8zTiKstm1FTAtz9nuELk1ALC6KcqafDe5paQ57ZxLgmpLQV6bZQcNN26qS9NWgz4
	 u/yV1APVEJzyPnzHzwnsU4OVbXFGw9yKAFifYh7stBN56quWq2oH0Cro4TpOyOzCCL
	 Xgywylgr6KoqWI4rrAsu3KjyfzpUBVl3Lg/GQ+jeG0HNK6pc5cc1tMpd8LrZUNWM2C
	 RoUEniAaOXjmcyRZbkUY2nefwiW3OoYn2McvzZ3gHKGwVXixZ73uD+1kXWhhywlmDL
	 exVtQRJHi86nNogJF/FlB5usnqcDA4ZqlHX44FnHOyjIALOvlAnOilaqtnjelA0Dx9
	 HJA44dofT/CvQ==
Message-ID: <98713429-e513-4648-8834-71d6b2ab1d5b@kernel.org>
Date: Mon, 19 Oct 2026 17:19:50 +0200
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zloop: print device that had errors
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20261019150936.1819956-1-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261019150936.1819956-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/19 17:09, Johannes Thumshirn wrote:
> When testing zoned filesystems that span multiple zloop drives it can be
> difficult to figure out which devices access caused an error.
> 
> Prefix the error messages where we have the disk available with the disk
> name.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

A single Reviewed-by tag is enough :)

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v1:
> - Based on for-7.4/block
> - Add reviews
> 
>  drivers/block/zloop.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 509d9727835d..73d9949d01e0 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -318,22 +318,23 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
>  
>  	ret = vfs_getattr(&zone->file->f_path, &stat, STATX_SIZE, 0);
>  	if (ret < 0) {
> -		pr_err("Failed to get zone %u file stat (err=%d)\n",
> -		       zone_no, ret);
> +		pr_err("%pg: Failed to get zone %u file stat (err=%d)\n",
> +		       zlo->disk->part0, zone_no, ret);
>  		set_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
>  		return ret;
>  	}
>  
>  	file_sectors = stat.size >> SECTOR_SHIFT;
>  	if (file_sectors > zlo->zone_capacity) {
> -		pr_err("Zone %u file too large (%llu sectors > %llu)\n",
> -		       zone_no, file_sectors, zlo->zone_capacity);
> +		pr_err("%pg: Zone %u file too large (%llu sectors > %llu)\n",
> +		       zlo->disk->part0, zone_no, file_sectors,
> +		       zlo->zone_capacity);
>  		return -EINVAL;
>  	}
>  
>  	if (!IS_ALIGNED(stat.size, zlo->block_size)) {
> -		pr_err("Zone %u file size (%llu) not aligned to block size %u\n",
> -		       zone_no, stat.size, zlo->block_size);
> +		pr_err("%pg: Zone %u file size (%llu) not aligned to block size %u\n",
> +		       zlo->disk->part0, zone_no, stat.size, zlo->block_size);
>  		return -EINVAL;
>  	}
>  
> @@ -604,12 +605,14 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
>  	} else {
>  		if (cmd->sector != zone->wp) {
>  			if (zone->wp == ULLONG_MAX)
> -				pr_err("Zone %u: write to %s zone: sect %llu\n",
> -				       zone_no, blk_zone_cond_str(zone->cond),
> +				pr_err("%pg: Zone %u: write to %s zone: sect %llu\n",
> +				       zlo->disk->part0, zone_no,
> +				       blk_zone_cond_str(zone->cond),
>  				       cmd->sector);
>  			else
> -				pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
> -				       zone_no, cmd->sector, zone->wp);
> +				pr_err("%pg: Zone %u: unaligned write: sect %llu, wp %llu\n",
> +				       zlo->disk->part0, zone_no, cmd->sector,
> +				       zone->wp);
>  			ret = -EIO;
>  			goto out_unlock;
>  		}
> @@ -816,8 +819,9 @@ static void zloop_complete_rq(struct request *rq)
>  	switch (req_op(rq)) {
>  	case REQ_OP_READ:
>  		if (cmd->ret < 0)
> -			pr_err("Zone %u: failed read sector %llu, %llu sectors\n",
> -			       zone_no, cmd->sector, cmd->nr_sectors);
> +			pr_err("%pg: Zone %u: failed read sector %llu, %llu sectors\n",
> +			       zlo->disk->part0, zone_no, cmd->sector,
> +			       cmd->nr_sectors);
>  
>  		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq)) {
>  			/* short read */
> @@ -830,14 +834,15 @@ static void zloop_complete_rq(struct request *rq)
>  	case REQ_OP_WRITE:
>  	case REQ_OP_ZONE_APPEND:
>  		if (cmd->ret < 0)
> -			pr_err("Zone %u: failed %swrite sector %llu, %llu sectors\n",
> -			       zone_no,
> +			pr_err("%pg: Zone %u: failed %swrite sector %llu, %llu sectors\n",
> +			       zlo->disk->part0, zone_no,
>  			       req_op(rq) == REQ_OP_WRITE ? "" : "append ",
>  			       cmd->sector, cmd->nr_sectors);
>  
>  		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq)) {
> -			pr_err("Zone %u: partial write %ld/%u B\n",
> -			       zone_no, cmd->ret, blk_rq_bytes(rq));
> +			pr_err("%pg: Zone %u: partial write %ld/%u B\n",
> +			       zlo->disk->part0, zone_no, cmd->ret,
> +			       blk_rq_bytes(rq));
>  			cmd->ret = -EIO;
>  		}
>  
> 
> base-commit: afc9cde716b29ce814798d649a95f9128ba42b43


-- 
Damien Le Moal
Western Digital Research

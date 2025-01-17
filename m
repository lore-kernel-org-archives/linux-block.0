Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A319CC27
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155123; cv=none; b=hyr+uGMYmmNgRoXfzkY4cUpuf7LaoGxFm6zeqJKrRHmkdpmJlE7BxlHJYhCKyk5ZGeQDHPg3jQv7wtHN/0O2JnYggBLLIAwotXylRGlFMk6zjNbdiklHSr62mj2UdUevuLGS5h1dAzA3lyNU5x5yZNzX2dG+o1UmCWajmPSK5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155123; c=relaxed/simple;
	bh=2s1ljAHVcK+wYnIeNh4jIYn8XGyAIuaG/MRTEJlLufQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNT1njKG8ZIIb/1ngR8waFXsSwW8DJrRpbZLB53GAOOTZ/lAcvpnTChFErGYtuBcHRG4v2thA73RrQLGyGFSyfURewuQHSXDflthPqJtcvCVDXCQfaHX39liVs4kWPW6I8YNJxesdTx/r1n8UcF+GOCyoeKHybuuTXjr8bB8Vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeMFpEHB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeMFpEHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B992AC4CEDD;
	Fri, 17 Jan 2025 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737155122;
	bh=2s1ljAHVcK+wYnIeNh4jIYn8XGyAIuaG/MRTEJlLufQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IeMFpEHBgd2+ZVIq/3Y6UGB3/cWavExd4xo5lOidH1GBnucZQib0l8RlLlGm5yAAo
	 u89uUFPPiX6oe+0XYqDPe0caLt+JLA7CbFkYHoSRUmAmof7ryDDE+AFy5OUG5mZ5PF
	 dqB9IIvVyNliO1hc3VVMvZsMYU7CssZlcIjvrgMHYhza3LTeCxoOKB6wJ7b57w1Ueb
	 ASvPz7D5MYPMOvUwrXOf/1XP3hNwQWEYvw3jHLQnLR0anq/IB/zqSnaHRh259O5C/f
	 ezgiL0JSvuaH6kzt9tQiJrCn5FrCAooOXrRPV3uBZ8tOWZUzb35g/1KvmLuDacMHEi
	 LKBoA39IVkjCQ==
Message-ID: <6a0c5c27-81df-4fa3-bbdc-00be0d91a6ee@kernel.org>
Date: Sat, 18 Jan 2025 08:05:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 4/5] null_blk: pass transfer size to
 null_handle_rq()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-5-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115042910.1149966-5-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
> As preparation to support partial data transfer, add a new argument to
> null_handle_rq() to pass the number of sectors to transfer. This commit
> does not change the behavior.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good. As a nit, I would suggest renaming null_handle_rq() to the less
generic name null_handle_rw(), or may be, null_handle_data_transfer().

Regardless,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/null_blk/main.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 87037cb375c9..71c86775354e 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1263,25 +1263,36 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	return err;
>  }
>  
> -static blk_status_t null_handle_rq(struct nullb_cmd *cmd)
> +/*
> + * Transfer data for the given request. The transfer size is capped with the
> + * nr_sectors argument.
> + */
> +static blk_status_t null_handle_rq(struct nullb_cmd *cmd, sector_t nr_sectors)
>  {
>  	struct request *rq = blk_mq_rq_from_pdu(cmd);
>  	struct nullb *nullb = cmd->nq->dev->nullb;
>  	int err = 0;
>  	unsigned int len;
>  	sector_t sector = blk_rq_pos(rq);
> +	unsigned int max_bytes = nr_sectors << SECTOR_SHIFT;
> +	unsigned int transferred_bytes = 0;
>  	struct req_iterator iter;
>  	struct bio_vec bvec;
>  
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
>  		len = bvec.bv_len;
> +		if (transferred_bytes + len > max_bytes)
> +			len = max_bytes - transferred_bytes;
>  		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
>  				     op_is_write(req_op(rq)), sector,
>  				     rq->cmd_flags & REQ_FUA);
>  		if (err)
>  			break;
>  		sector += len >> SECTOR_SHIFT;
> +		transferred_bytes += len;
> +		if (transferred_bytes >= max_bytes)
> +			break;
>  	}
>  	spin_unlock_irq(&nullb->lock);
>  
> @@ -1333,7 +1344,7 @@ blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
>  	if (op == REQ_OP_DISCARD)
>  		return null_handle_discard(dev, sector, nr_sectors);
>  
> -	return null_handle_rq(cmd);
> +	return null_handle_rq(cmd, nr_sectors);
>  }
>  
>  static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)


-- 
Damien Le Moal
Western Digital Research

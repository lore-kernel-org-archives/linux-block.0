Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27A1A76B6
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155626; cv=none; b=B9Tirwwr9P4FqgzTdy/Jm8NCUB85+oAJekcVCHcKR5Ve4eFJ1j+BqlCnsFc9nC700UOU0PeYExwekRo6LEDduKuT543gszhgSCTnzRV0X+7ny4UnU9pED7R+Yqwdcjjls1qzRnJQg2hCqMUYG+KYfKk6wpFu5UsrRTL2B60GNGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155626; c=relaxed/simple;
	bh=hKPCSUqWJ1o0PKRCVXZYTHEFLg39ye5jncMIgLPhGdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpmXvF4C1FMLgkK9o74cUnUgDsIVpC5uO9spBncI8t5aS0dbDhpNdmFG9bGdjIxV3Etuowc+BpZovHbVZ31K8DxommMTpDMZgIuDAvkfJ838caT60578gnpItt/4cB66gPdsZ28lJJhradCl4Ax2cfd+Z6CalkhLQ/ob7jAmOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYSd6TkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYSd6TkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A870AC4CEDD;
	Fri, 17 Jan 2025 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737155625;
	bh=hKPCSUqWJ1o0PKRCVXZYTHEFLg39ye5jncMIgLPhGdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HYSd6TkS1RKbnyAwttbULsNYmBbdl7PXtpfBnAcF0UdY7QPVkAgCx5ho4zfQq3TcQ
	 yD9xEsyG3W4cpQBKzVJb5cOP5FZ4GgMnph1ptsfbBHFhNVtc8RjpKjB6OxR4ytI3Oz
	 kjjuetRhZqOMYASzxvkTBsFZx2a63ryLxstr4GXQINUB3b8PNYF4RUfLbMruXJFQAl
	 ePx8XZE4dJH0WuIwu01QtTSEQLr9xkvY1dBzybRV1DJTESLcTVJlfr9nOBXXTGdE6z
	 naegG4tOFBc9gu1XmB9/wf6dJypK54Y1+HEkeGrjL0LdhRuAwcahHlVc0lWPqTgctj
	 PsvKqAFahHjzQ==
Message-ID: <53904fc0-1505-499d-ad7f-92d4de2050bb@kernel.org>
Date: Sat, 18 Jan 2025 08:13:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 5/5] null_blk: do partial IO for bad blocks
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-6-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115042910.1149966-6-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
> The current null_blk implementation checks if any bad blocks exist in
> the target blocks of each IO. If so, the IO fails and data is not
> transferred for all of the IO target blocks. However, when real storage
> devices have bad blocks, the devices may transfer data partially up to
> the first bad blocks (e.g., SAS drives). Especially, when the IO is a
> write operation, such partial IO leaves partially written data on the
> device.
> 
> To simulate such partial IO using null_blk, introduce the new parameter
> 'badblocks_partial_io'. When this parameter is set,
> null_handle_badblocks() returns the number of the sectors for the
> partial IO as its third pointer argument. Pass the returned number of
> sectors to the following calls to null_handle_memory_backend() in
> null_process_cmd() and null_zone_write().
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

A couple of nits below. Otherwise looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> +/*
> + * Check if the command should fail for the badblocks. If so, return
> + * BLK_STS_IOERR and return number of partial I/O sectors.

...and return the number of sectors that were read or written, which may be less
than the requested number of sectors.

> + *
> + * @cmd:        The command to handle.
> + * @sector:     The start sector for I/O.
> + * @nr_sectors: The caller specifies number of sectors to write or read.
> + *              Returns number of sectors to be written or read for partial I/O.

@nr_sectors: Specifies number of sectors to read or write and returns the number
	     of sectors that were read or written.

> + */
>  blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
> -				   sector_t nr_sectors)
> +				   unsigned int *nr_sectors)
>  {
>  	struct badblocks *bb = &cmd->nq->dev->badblocks;
> +	struct nullb_device *dev = cmd->nq->dev;
> +	unsigned int block_sectors = dev->blocksize >> SECTOR_SHIFT;
>  	sector_t first_bad;
>  	int bad_sectors;
> +	unsigned int partial_io_sectors = 0;
>  
> -	if (!badblocks_check(bb, sector, nr_sectors, &first_bad, &bad_sectors))
> +	if (!badblocks_check(bb, sector, *nr_sectors, &first_bad, &bad_sectors))
>  		return BLK_STS_OK;
>  
>  	if (cmd->nq->dev->badblocks_once)
>  		badblocks_clear(bb, first_bad, bad_sectors);
>  
> +	if (cmd->nq->dev->badblocks_partial_io) {
> +		if (!IS_ALIGNED(first_bad, block_sectors))
> +			first_bad = ALIGN_DOWN(first_bad, block_sectors);
> +		if (sector < first_bad)
> +			partial_io_sectors = first_bad - sector;
> +	}
> +	*nr_sectors = partial_io_sectors;
> +
>  	return BLK_STS_IOERR;
>  }

-- 
Damien Le Moal
Western Digital Research

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AA198830;
	Fri,  9 Aug 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216978; cv=none; b=Qe6qDJZB8HIsC2cA8LjY4DHGGd0ALOAxf2jXgE5KelJJeTBBIaRn2Ijqihnx416VxypUeK9/Wb8Ph2EE1dZdsN2T8dT7tFAYN65prY4khCpS+GSV003tqWWlmhybquzto1nFh4/daclelqfbqk1eT0rTbwEJ33lxIFKSRpUFc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216978; c=relaxed/simple;
	bh=JXgqr/Sam3GPZVjYZJbudhL0ZA1FcrWTjiR3hqiEghY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8T9aQEETKo0RN/LdEwIgRpREE50awO93yZ1uED4prftvsMnzentQI2CO21rNLFzfNX5w349c1ePmoEc6MTMJTqUoEJ7HbuXp8MwMvbEA6jZJREH885Jn51VvzOwanGeYUeottkwh+jqsqACCvAUcgsy9pv7UxOcPD36b0HibS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAv7mnaA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAv7mnaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C45C32782;
	Fri,  9 Aug 2024 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216977;
	bh=JXgqr/Sam3GPZVjYZJbudhL0ZA1FcrWTjiR3hqiEghY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rAv7mnaAx8h+TX9kus/iPdwnzuZyDcrRVa/TNV+nGlio66QBggXxkw51uYO7RaA/p
	 K7Bk0uGj9g00iv2z4H1ngTnSli0hThrSAcJ5GHcz414zG0GYBgM/KdSZejHo5jlGpo
	 0cIhSVcYYYfoUJPszp2G+ZQC/F/bvEk2wlW7mt7IGsMRRSAL0R6NjSz6TQyJ+9oGPN
	 xCd9vUTPIhxdIZTY2YdD48yzO8NES6EOb6ZzjMyhFyeO8xtfC74Z4LU7tToFETEBzB
	 vlDMVS3kCl7qG7LpeT/prLVeLexrkKuVDHPCu9vtUbNVFBNpghCRifFWuph+dt3AJU
	 g99CxZHyUTj2w==
Message-ID: <43ff6de8-a4f0-4606-bfa1-15fb1be2310a@kernel.org>
Date: Fri, 9 Aug 2024 08:22:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nbd: correct the maximum value for discard sectors
To: Wouter Verhelst <w@uter.be>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org
References: <20240803130432.5952-1-w@uter.be>
 <20240808070604.179799-1-w@uter.be> <20240808070604.179799-3-w@uter.be>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240808070604.179799-3-w@uter.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/08 0:06, Wouter Verhelst wrote:
> The version of the NBD protocol implemented by the kernel driver
> currently has a 32 bit field for length values. As the NBD protocol uses
> bytes as a unit of length, length values larger than 2^32 bytes cannot
> be expressed.
> 
> Update the max_hw_discard_sectors field to match that.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46
> Cc: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index fdcf0bbedf3b..235ab5f59608 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>  
>  	lim = queue_limits_start_update(nbd->disk->queue);
>  	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
> -		lim.max_hw_discard_sectors = UINT_MAX;
> +		lim.max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
>  	else
>  		lim.max_hw_discard_sectors = 0;
>  	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH)) {

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


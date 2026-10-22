Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653335;
	b=HgWliRmxS/EDxzYbHVSGMhiysnGTgs5UTSUQDfxI3a/6KfOD2oXjB/wy3NZgyLFhF+/d
	 g+gB+hy2EyRBOk4niqGe8knOJ1/UELJkZr8uFRKAQTXAiYHY48IZFzdtpHlTFpl3f/rY9
	 r1yjOzY/W6epcFiwhgXLFK9/a0Ok4LRw/ErAqwqvSG5i8n45zisDpgBg7QdWrBqYMjZfa
	 Vp/yRzTeKpb/frvYXV7p8u2lZ1PYRQ39oyUD+gVNi8zZleU6c5OlsYMGk+ciHf3uk1WN6
	 vQ6dgsjoh+kgOCuh4rg5LVHAQTa9/2Qnr/FhcXDj6yiUZvwRndllX25hS8PykW4ORHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653335;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8Z3XZ7WxkIfTXlT8A+LoryYW+Dn9h1GWmFu9g/diiWc=;
	b=QxASKQWNwUJ68jz1y1u7vxHcLIZ3qRx54Mr60oxg+R37h9aMEP18OXbsYE/HEmqNQ1M+
	 qgOF+prFwZRNfYR0KgdjDdC84901DwYXallvH/BC1gg5DijtiFnA8DxCk2iVERYlR8c2D
	 nnSZqjXfeRpTpdAzS55pJ0j0qRBzVEh6J7lyV9Yo4dBRwxU/+++3taPH3olMAnuizW5V7
	 Ph7pg6b4L7QzTiw0ilaBTkIZ/0uebX5F8kXir/gL2rJr6ljVhJPX8E8GSbjomlJvpv2Ma
	 DFHKEn7e3DkezYr4jXD3fvux6qK4q6EfLT7kn1qxEddbQ5pFzRLpDrLocaqKUpFK1bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="htb/0AKU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A9606A323
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htb/0AKU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7F21F000C1;
	Thu, 22 Oct 2026 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792653335;
	bh=8Z3XZ7WxkIfTXlT8A+LoryYW+Dn9h1GWmFu9g/diiWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=htb/0AKUJKrRkdROUV4BUX61a39EP+94AbDYnizpS/IpacL+KvO8LmqqKviOF38nY
	 ZSV39E2+r1/amTj1NJtBXFqrFANhfGu3Ro6uVH1SOrct1GFcPOHJeS5wDdZvt37snH
	 3MwapJOFTq94FqOqOP+dJRyqqCLwUXrlyCiBhKPWN7s4bqIhnTepatCfPYFy/FTcaZ
	 vU+4dMaXo5UCqcPEv8tl/gfxc34p89XqueaaCwZJA6OnaI+DhalnaJwR+tylIaA0fw
	 TbAEBcCnsClebnknfZH3dLmydxUPJh7kp+XB/3idd1B6VEpJjOL3knRZ2r+Q4tQVvS
	 AjPKmfP3cJ6/A==
Message-ID: <3222f1e8-07a8-4948-bd95-3d816fd1d71e@kernel.org>
Date: Thu, 22 Oct 2026 09:15:32 +0200
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
Subject: Re: [PATCH 2/2] null_blk: don't finish zones to set them read-only or
 offline
To: Niklas Cassel <cassel@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-block@vger.kernel.org
References: <20261021202100.2017938-4-cassel@kernel.org>
 <20261021202100.2017938-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261021202100.2017938-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/21 22:21, Niklas Cassel wrote:
> null_set_zone_cond() calls null_finish_zone() to release the zone
> resources held by a zone before setting it read-only or offline.
> 
> For an empty or closed zone, null_finish_zone() first runs the zone
> resource checks, which can close an unrelated implicitly open zone, or
> fail. As the error is ignored, a failure for a closed zone leaks
> nr_zones_closed, permanently lowering the effective active zone limit.
> 
> Setting a zone read-only or offline requires no zone resources, so
> release the zone resources held by the zone directly instead, using a
> new helper, null_release_zone_resources().
> 
> Fixes: d3a5738849e0 ("null_blk: support read-only and offline zone conditions")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good, modulo one nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/null_blk/zoned.c | 35 +++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index ecdc8d68ca2a..015f5d304c7c 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -743,6 +743,33 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_op op,
>  	}
>  }
>  
> +/*
> + * Release the zone resources held by a zone, before changing the condition of
> + * the zone to a condition that does not hold any zone resources.
> + */
> +static void null_release_zone_resources(struct nullb_device *dev,
> +					struct nullb_zone *zone)
> +{
> +	if (!dev->need_zone_res_mgmt)
> +		return;
> +
> +	spin_lock(&dev->zone_res_lock);
> +	switch (zone->cond) {
> +	case BLK_ZONE_COND_IMP_OPEN:
> +		dev->nr_zones_imp_open--;
> +		break;
> +	case BLK_ZONE_COND_EXP_OPEN:
> +		dev->nr_zones_exp_open--;
> +		break;
> +	case BLK_ZONE_COND_CLOSED:
> +		dev->nr_zones_closed--;
> +		break;
> +	default:
> +		break;
> +	}
> +	spin_unlock(&dev->zone_res_lock);
> +}
> +
>  /*
>   * Set a zone in the read-only or offline condition.
>   */
> @@ -759,8 +786,8 @@ static void null_set_zone_cond(struct nullb_device *dev,
>  	 * If the read-only condition is requested again to zones already in
>  	 * read-only condition, restore back normal empty condition. Do the same
>  	 * if the offline condition is requested for offline zones. Otherwise,
> -	 * set the specified zone condition to the zones. Finish the zones
> -	 * beforehand to free up zone resources.
> +	 * set the specified zone condition to the zones. Release the zone
> +	 * resources held by the zones beforehand.
>  	 */
>  	if (zone->cond == cond) {
>  		zone->cond = BLK_ZONE_COND_EMPTY;
> @@ -768,9 +795,7 @@ static void null_set_zone_cond(struct nullb_device *dev,

This function is called only from zone_cond_store() with cond either
BLK_ZONE_COND_READONLY or BLK_ZONE_COND_OFFLINE. Since your change is valid only
for these 2 conditions, we really should check that cond is either of the
already used values and add a comment, to avoid invalid use of
null_set_zone_cond() in the future (without tweaking it).

>  		if (dev->memory_backed)
>  			null_handle_discard(dev, zone->start, zone->len);
>  	} else {
> -		if (zone->cond != BLK_ZONE_COND_READONLY &&
> -		    zone->cond != BLK_ZONE_COND_OFFLINE)
> -			null_finish_zone(dev, zone);
> +		null_release_zone_resources(dev, zone);
>  		zone->cond = cond;
>  		zone->wp = NULL_ZONE_INVALID_WP;
>  	}


-- 
Damien Le Moal
Western Digital Research

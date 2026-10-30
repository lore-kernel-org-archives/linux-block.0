Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322627;
	b=nhW6FzmqdygXNTPM9SkyeGpdidZATsrerZ11bXUXaLpsCSbEQYJqbONVfUO1/U7cArRe
	 vZoVLRbMPykZDjvAzdverv7PQz2qT725j+zSBiJpwMjg/YdQOJmFaQmn+WAf27iTiG8VB
	 pDD1Z7IpoZii5LYDMyixJ1FvyB0c5r8le6XxO/NFEiE403dAScjzO1Vo7KmMx0ZAAnWfZ
	 FTCk9pcouUAekrMHcaoZNxE2gyxh7+19qVGh1xL9+HWaT218iCdQKEHRu5Du1WH7l2gbz
	 6pGDb8MNx6IbEyIybd08M0W+tzhfKZviOfLgPznddKRzR8kNBa4nfB4fsOzGSS1UMAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322627;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8+eKKOOiISg8mAvlAD6ZUd8e0JEu0aLnufinXeDzUqY=;
	b=yfJ0tAElu56Ri0AzxoNqaFgRf8S8S7XO0T6LJqg3vryMUV3fK7PL2ugpyfHrbTP9rfrl
	 wm54M1o0ubIcxo+u30TzaJH85qrmdOTpE6UNug9yE/0mFf908H3cxLvrfDPjH5dZhV6d4
	 AsKXJZfr41kgSI3DryVNBSL3Z3NlqdbACnWE8+z4xI+PyZ4uxSY3CarBukL4hYyelW5RZ
	 VBXFHLPm0hrU7NYbY1mJDGRiNDbcQA7xsYofstrEDMpMQIGfZ7R65gr+MFNbiKRq4TrJ2
	 Zfg16v4h6FNWNzr6XyVig04AvFXRj+xF0BQT6NZQXgMvHWu33oQxMu92s0GhYpBQY5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxaZan3c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479D606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxaZan3c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1450F1F00919;
	Fri, 30 Oct 2026 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793322626;
	bh=8+eKKOOiISg8mAvlAD6ZUd8e0JEu0aLnufinXeDzUqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MxaZan3cx76ldToWR66jyKO6zyTCPwN3lKOOuG3XAE8GpkFXpeYE5MAlBp8kL4eUT
	 SahNk9EnVkjz/103lE9kGWZES04cW49fcuy1VTvvhfmZ3ZCIVmwK0lnAoAVpGbAxdi
	 xdtFKclrzmH0nxv+wXyVSx9boSdD7cXZTldweaczpO2OMMjmSwY3fVwrKMuccjlUvi
	 qs1T08JQ29ZhsMV+SieF37RHHDS4dZ0Dbp9YO0Zs358rsp0/Dwu9T4cG6BHGPb5yJ6
	 7/NGKwpqxtCkMzdRbQCgT4vENJaLGtf6TF4piUrWYj1MgrKsQ2zN72DXthF8qpNoqb
	 SI1++jQNuFv1A==
Message-ID: <e6bd8068-2c8a-4d96-bcaf-2191e0123026@kernel.org>
Date: Fri, 30 Oct 2026 08:10:22 +0700
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
Subject: Re: [PATCH 2/4] zloop: share more code for opening a zone backing
 file
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
References: <20261029150353.2503201-1-hch@lst.de>
 <20261029150353.2503201-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261029150353.2503201-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/29 22:03, Christoph Hellwig wrote:
> Use a common path for opening and querying the block size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/zloop.c | 65 +++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 71f7685efb13..3dc484e3c700 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1107,8 +1107,6 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
>  {
>  	struct zloop_zone *zone = &zlo->zones[zone_no];
>  	int oflags = O_RDWR;
> -	struct kstat stat;
> -	sector_t file_sectors;
>  	int ret;
>  
>  	mutex_init(&zone->lock);
> @@ -1122,27 +1120,33 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
>  	if (!opts->buffered_io)
>  		oflags |= O_DIRECT;
>  
> +	zone->file = zloop_filp_open_fmt(oflags, 0600, "%s/%u/%s-%06u",
> +				zlo->base_dir, zlo->id,
> +				zone_no < zlo->nr_conv_zones ? "cnv" : "seq",
> +				zone_no);
> +	if (IS_ERR(zone->file)) {
> +		pr_err("Failed to open zone %u file %s/%u/%s-%06u (err=%ld)",
> +		       zone_no, zlo->base_dir, zlo->id,
> +		       zone_no < zlo->nr_conv_zones ? "cnv" : "seq",
> +		       zone_no, PTR_ERR(zone->file));
> +		return PTR_ERR(zone->file);
> +	}
> +
> +	if (zlo->block_size) {

Shouldn't this be:

	if (!zlo->block_size) {

?

Not a huge problem, but no need to repeatedly get the block size for all zones.
Other than that, this is a nice cleanup!

> +		ret = zloop_get_block_size(zlo, zone);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (zone_no < zlo->nr_conv_zones) {
> +		sector_t file_sectors;
> +		struct kstat stat;
> +
>  		/* Conventional zone file. */
>  		set_bit(ZLOOP_ZONE_CONV, &zone->flags);
>  		zone->cond = BLK_ZONE_COND_NOT_WP;
>  		zone->wp = U64_MAX;
>  
> -		zone->file = zloop_filp_open_fmt(oflags, 0600, "%s/%u/cnv-%06u",
> -					zlo->base_dir, zlo->id, zone_no);
> -		if (IS_ERR(zone->file)) {
> -			pr_err("Failed to open zone %u file %s/%u/cnv-%06u (err=%ld)",
> -			       zone_no, zlo->base_dir, zlo->id, zone_no,
> -			       PTR_ERR(zone->file));
> -			return PTR_ERR(zone->file);
> -		}
> -
> -		if (!zlo->block_size) {
> -			ret = zloop_get_block_size(zlo, zone);
> -			if (ret)
> -				return ret;
> -		}
> -
>  		ret = vfs_getattr(&zone->file->f_path, &stat, STATX_SIZE, 0);
>  		if (ret < 0) {
>  			pr_err("Failed to get zone %u file stat\n", zone_no);
> @@ -1163,30 +1167,13 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
>  			       zone_no, ret);
>  			return ret;
>  		}
> -
> -		return 0;
> -	}
> -
> -	/* Sequential zone file. */
> -	zone->file = zloop_filp_open_fmt(oflags, 0600, "%s/%u/seq-%06u",
> -					 zlo->base_dir, zlo->id, zone_no);
> -	if (IS_ERR(zone->file)) {
> -		pr_err("Failed to open zone %u file %s/%u/seq-%06u (err=%ld)",
> -		       zone_no, zlo->base_dir, zlo->id, zone_no,
> -		       PTR_ERR(zone->file));
> -		return PTR_ERR(zone->file);
> -	}
> -
> -	if (!zlo->block_size) {
> -		ret = zloop_get_block_size(zlo, zone);
> -		if (ret)
> -			return ret;
> +	} else {
> +		/* Sequential zone file. */
> +		mutex_lock(&zone->lock);
> +		ret = zloop_update_seq_zone(zlo, zone_no);
> +		mutex_unlock(&zone->lock);
>  	}
>  
> -	mutex_lock(&zone->lock);
> -	ret = zloop_update_seq_zone(zlo, zone_no);
> -	mutex_unlock(&zone->lock);
> -
>  	return ret;
>  }
>  


-- 
Damien Le Moal
Western Digital Research

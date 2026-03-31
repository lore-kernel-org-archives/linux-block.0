Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE884039
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948730; cv=none; b=JbgHp6oD+qmnTDnvyUPVnK6regn/q6w/H93wc6hmEGz78+vHVKDuW+f/RnqCgrjqF63SNu1Enbfteat0YoKRQ61wIJuL8PBek3Ge32X6WjJCMpbKqUoVtmXRfgg3LF4PygUf+LOlBc55ECnKsjB/3zXmANrxoj0YnbU9Jur1BGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948730; c=relaxed/simple;
	bh=tUYM/vefnyo7GKuOVtDvVuNI+pkSwV+Yvpeg2srO70s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPfybpV8ir6LaK/+TmaAF/ucLMvDqJbUYpugxPFShEj2jk25nWZgXyczTEFS/stHVBumrdYHtdmd/uugexAtlf0AgzSuYwWDlHtn0cvvy0klT/CRM6vmsiFcgDiNqCvguF8+dWf3yc+XjxiqvloRNv1JG8dUBUoX8aHjqLlA6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3ekqOI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3ekqOI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B634CC19423;
	Tue, 31 Mar 2026 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774948730;
	bh=tUYM/vefnyo7GKuOVtDvVuNI+pkSwV+Yvpeg2srO70s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n3ekqOI28V9xXNHYQxe1Ix083Rc1LtCxvUsK/7YlEbUzYohOOobzf0+3m2eSZlNeH
	 QJ27Z1/z+OjmkSQHl95TyIajlPxfggQrWx8vVvToO3hfmbDcnn75s+wM0IGu2JV/9I
	 Okw6n9A11JaH2ngWoeJnC1kjrkBGnS28O1zBVub6zSUnzJ9GLLzz1a+EYzzOC6F8bW
	 mF+T+WZY/0rPVd8JcUfArfN6QCyJWkxfiIut3mpA5666Ku3fizR+17XTGKC9dfgBHB
	 VIwYMh28tIbjRNXnNshPMQAMOpgdVcHTSHMtWn83E8jLgkmMvCX6z/7CUw8Vj/MO/y
	 JT2u8mrLNnYaw==
Message-ID: <2e91b857-4edd-4a8a-a75c-d1569fc6f1e3@kernel.org>
Date: Tue, 31 Mar 2026 18:18:47 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: fix zones_cond memory leak in
 blk_revalidate_disk_zones()
To: Jackie Liu <liu.yun@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260331084731.45283-1-liu.yun@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260331084731.45283-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 17:47, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Fix memory leaks of args.zones_cond allocated in
> disk_revalidate_zone_resources() on multiple error paths:
> 
> 1) When disk_revalidate_zone_resources() itself fails (e.g.
>    disk_alloc_zone_resources() returns an error), blk_revalidate_disk_zones()
>    returns directly without freeing args.zones_cond.
> 
> 2) When report_zones() fails or the capacity check fails,
>    disk_free_zone_resources() only frees the old disk->zones_cond, not
>    the newly allocated args.zones_cond.
> 
> 3) When the nr_conv_zones validation fails in disk_update_zone_resources(),
>    the code jumps to unfreeze before disk_set_zones_cond_array() transfers
>    ownership of args->zones_cond to disk->zones_cond.
> 
> Fix cases 1 and 2 by adding a free_zones_cond label at the end of
> blk_revalidate_disk_zones() to centralize the cleanup. Fix case 3 by
> moving disk_set_zones_cond_array() before the nr_conv_zones check in
> disk_update_zone_resources() so that ownership is transferred early and
> disk_free_zone_resources() at the unfreeze label properly frees it.
> 
> Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  block/blk-zoned.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 9d1dd6ccfad7..2ea790e4f320 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1956,6 +1956,8 @@ static int disk_update_zone_resources(struct gendisk *disk,
>  	memflags = blk_mq_freeze_queue(q);
>  
>  	disk->nr_zones = args->nr_zones;
> +	disk_set_zones_cond_array(disk, args->zones_cond);
> +
>  	if (args->nr_conv_zones >= disk->nr_zones) {
>  		queue_limits_cancel_update(q);
>  		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
> @@ -1966,7 +1968,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
>  
>  	disk->zone_capacity = args->zone_capacity;
>  	disk->last_zone_capacity = args->last_zone_capacity;
> -	disk_set_zones_cond_array(disk, args->zones_cond);
>  
>  	/*
>  	 * Some devices can advertise zone resource limits that are larger than
> @@ -2239,7 +2240,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>  	ret = disk_revalidate_zone_resources(disk, &args);
>  	if (ret) {
>  		memalloc_noio_restore(noio_flag);
> -		return ret;
> +		goto free_zones_cond;
>  	}
>  
>  	ret = disk->fops->report_zones(disk, 0, UINT_MAX, &rep_args);
> @@ -2268,6 +2269,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>  	disk_free_zone_resources(disk);
>  	blk_mq_unfreeze_queue(q, memflags);
>  
> +free_zones_cond:
> +	kfree(args.zones_cond);

This does not look correct: on success case, this will free the array despite
that array being set already. So rather than this, I think it is better to
change disk_revalidate_zone_resources() to free the array it allocated in the
case of an error. That will be a lot cleaner than this.

>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);


-- 
Damien Le Moal
Western Digital Research

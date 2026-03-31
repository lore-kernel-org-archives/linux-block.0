Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03739258EC2
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954581; cv=none; b=PFrwhFDD6fKGvGKP/a8JnUjlasusnjFUIndAjZiiwTEw9eFrH8wptYY6GI3oWDcpQDwavV1zNLOg+Rh6f6zFmYEk7YGT/3GKfjS9ubIkkdg1UxIsJ2gz1suegW9SILUA/MT2QfhcbA2gsPgLisxIpHWlnF0Wb7wl4+PH1J8yLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954581; c=relaxed/simple;
	bh=+Yawmb3hmej1rVYsaMQVZpye71Ct8oqQ7SSZaoa3GEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6SCoBwWeXZPItiYVIUPgvu/TaHzqeO6GwZpY8NYySO3/QW+n3GCc1anmI0tZEPriUvZn2mIo03NJ2el+qUZ9HUhmXXGhvJY6WrqG4hUVECwFnNCluRHk3yny7vmjyxcY8IFmQ1SdNmgLF5ECXaSUP5fdDKzzs9kb0Yw0n/u/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeF6mk+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeF6mk+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204A6C19423;
	Tue, 31 Mar 2026 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774954580;
	bh=+Yawmb3hmej1rVYsaMQVZpye71Ct8oqQ7SSZaoa3GEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AeF6mk+wjG+18t8iaVBzFRcHjvd9KWuQiN4TdHFi9pDJJEJuFcpsXtysSvyFdb2IJ
	 1ZuPjb+c9E9F8gXMpn7D34fhEOsYWV72j1z95YUno53gZVXwtBJ06g9jeBpF3Jo6sw
	 HJ8cUZ6lyiCDqt/AWDabwpVccasgUKNOdGV3t3J8O4sqbpGqjS9yhzjeieMDK6dcdb
	 wyAyoOHvvtB8KC2NguhKorXpVMcj81JlxeAfJN9rYxbtHLN3FrKax0mj7y1Brq78yN
	 S/MwvDHA7ob0BXp5y3wg8qPCjtfpG02yqImsRgtkC2zEm/KV1FIZWYFrG8VH6ZiiIK
	 k8TuScSaYT0eg==
Message-ID: <786d65d1-acc9-4843-995d-07f0a33c937a@kernel.org>
Date: Tue, 31 Mar 2026 19:56:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix zones_cond memory leak in
 blk_revalidate_disk_zones()
To: Jackie Liu <liu.yun@linux.dev>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260331100103.82085-1-liu.yun@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260331100103.82085-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 19:01, Jackie Liu wrote:
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
> Fix this by freeing args->zones_cond at each error site: in
> blk_revalidate_disk_zones() when disk_revalidate_zone_resources() or zone
> reporting fails, and in disk_update_zone_resources() before jumping to
> the unfreeze label.
> 
> Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  block/blk-zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 9d1dd6ccfad7..be99ab785dcd 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1960,6 +1960,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
>  		queue_limits_cancel_update(q);
>  		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
>  			disk->disk_name, args->nr_conv_zones, disk->nr_zones);
> +		kfree(args->zones_cond);

Let's keep the cleanups together. So move this before pr_warn().
Also, the call to queue_limits_commit_update() may fail, so you need a free
after the unfreeze label in that function too.

>  		ret = -ENODEV;
>  		goto unfreeze;
>  	}
> @@ -2239,6 +2240,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>  	ret = disk_revalidate_zone_resources(disk, &args);
>  	if (ret) {
>  		memalloc_noio_restore(noio_flag);
> +		kfree(args.zones_cond);

This should be in disk_revalidate_zone_resources().

>  		return ret;
>  	}
>  
> @@ -2264,6 +2266,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>  
>  	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
>  
> +	kfree(args.zones_cond);
>  	memflags = blk_mq_freeze_queue(q);
>  	disk_free_zone_resources(disk);
>  	blk_mq_unfreeze_queue(q, memflags);

I thinks something like this may be cleaner as it avoids having that kfree() all
over the place:

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 10655213e8e1..18cd9a1c6c53 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2028,6 +2028,7 @@ static int disk_revalidate_zone_resources(struct gendisk
*disk,
 {
        struct queue_limits *lim = &disk->queue->limits;
        unsigned int pool_size;
+       int ret = 0;

        args->disk = disk;
        args->nr_zones =
@@ -2050,10 +2051,13 @@ static int disk_revalidate_zone_resources(struct gendisk
*disk,
                pool_size =
                        min(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE, args->nr_zones);

-       if (!disk->zone_wplugs_hash)
-               return disk_alloc_zone_resources(disk, pool_size);
+       if (!disk->zone_wplugs_hash) {
+               ret = disk_alloc_zone_resources(disk, pool_size);
+               if (ret)
+                       kfree(args->zones_cond);
+       }

-       return 0;
+       return ret;
 }

 /*
@@ -2085,6 +2089,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
        disk->zone_capacity = args->zone_capacity;
        disk->last_zone_capacity = args->last_zone_capacity;
        disk_set_zones_cond_array(disk, args->zones_cond);
+       args->zones_cond = NULL;

        /*
         * Some devices can advertise zone resource limits that are larger than
@@ -2365,21 +2370,30 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
        }
        memalloc_noio_restore(noio_flag);

+       if (ret <= 0)
+               goto free_resources;
+
        /*
         * If zones where reported, make sure that the entire disk capacity
         * has been checked.
         */
-       if (ret > 0 && args.sector != capacity) {
+       if (args.sector != capacity) {
                pr_warn("%s: Missing zones from sector %llu\n",
                        disk->disk_name, args.sector);
                ret = -ENODEV;
+               goto free_resources;
        }

-       if (ret > 0)
-               return disk_update_zone_resources(disk, &args);
+       ret = disk_update_zone_resources(disk, &args);
+       if (ret)
+               goto free_resources;
+
+       return 0;

+free_resources:
        pr_warn("%s: failed to revalidate zones\n", disk->disk_name);

+       kfree(args.zones_cond);
        memflags = blk_mq_freeze_queue(q);
        disk_free_zone_resources(disk);
        blk_mq_unfreeze_queue(q, memflags);

-- 
Damien Le Moal
Western Digital Research

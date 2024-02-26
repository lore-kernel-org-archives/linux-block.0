Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396884FD1
	for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952834; cv=none; b=i73BOWastmI+XKPTZYeMLDPEWGDGdZy4bCmz5249glBes7VnVgSNcnQhYmqF4dHKI/4mZ0YB3PIOeOm8OChBKpqtnGtlTeYTTzsQCykDuHD0K3LC+YJXe+CgcrmbS20R/I7hXvC0fq9jMT7urU9D485cm1zfKvFHj8JxE4rlY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952834; c=relaxed/simple;
	bh=XTbG026Es+hzsb7/j7Q4XoxYWKW6ZImOBAdrqNoe8OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+S7Uyh8F2fy4SMw8Y6Ix77tU6Rh5eu2GAtSRmfSH7SLoUQnruLjfcavyqWLwxh4z2zpDKWN/4ifdKmLo8IHljnzNVPXtSjXaoj5bDEXaJisZlekIpa02OJDBqtqNTKQNMfryCsRHBXsYn9LU00iBweqGMVN9rHjcHB2JvGeYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxE0QmSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxE0QmSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD0C43399;
	Mon, 26 Feb 2024 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708952833;
	bh=XTbG026Es+hzsb7/j7Q4XoxYWKW6ZImOBAdrqNoe8OQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HxE0QmSd7SIV6uFUSOlA+VhN1FQwmn4v/r7zEzw9FKlGRQbM84jBix4HnesW6KLla
	 QzpUNoTwaQlH3Q6gLqmqkSYU3p2GftPBMZ6P+zDjqWHTGFFIuZv7QoTefQ0aHC4zb7
	 xY3Ef9no2JFLA/fi6aGKnNqY7Iqmo32A6/THMg9aFicvfKLHCu9DXYXhqgOmah7xCw
	 jGebh9K5qG6zN095wa8qaGqXJO9XmIYpbg3njIth+wDBPn3dZUeX+yUNv9V0GYV8ZN
	 XBgWdbCnjHoX1oPC0HgfnmPqWRnjhMp3+pR5t51dZqvS9Iy0YEqV6oY+qpSZv0oIz0
	 GGviYnKLAgBxg==
Message-ID: <682d99ef-7773-4214-bc46-900ba4172563@kernel.org>
Date: Mon, 26 Feb 2024 05:07:12 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: add simple write-zeroes support
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 johannes.thumshirn@wdc.com, hare@suse.de, zhouchengming@bytedance.com,
 akinobu.mita@gmail.com, shinichiro.kawasaki@wdc.com, john.g.garry@oracle.com
References: <20240226071355.16723-1-kch@nvidia.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240226071355.16723-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/25 23:13, Chaitanya Kulkarni wrote:
> To test the REQ_OP_WRITE_ZEROES command and fatal signal handling in
> the code path starting from blkdev_issue_zeroout(), add a new module
> parameter when null_blk module is loaded in non-memory-backed mode.
> 
> Disable REQ_OP_WRITE_ZEROES by default to retain the existing behavior.
> 
> without this patch :-
> 
> linux-block (for-next) # modprobe null_blk
> linux-block (for-next) # blkdiscard -z -o 0 -l 40960 /dev/nullb0
> linux-block (for-next) # dmesg -c 
> [24977.282226] null_blk: null_process_cmd 1337 WRITE
> 
> with this patch :-
> 
> linux-block (for-next) # modprobe null_blk write_zeroes=1
> linux-block (for-next) # blkdiscard -z -o 0 -l 40960 /dev/nullb0
> linux-block (for-next) # dmesg -c 
> [25009.164341] null_blk: null_process_cmd 1337 WRITE_ZEROES
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c     | 14 ++++++++++++--
>  drivers/block/null_blk/null_blk.h |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 71c39bcd872c..b454f6e6c60a 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -221,6 +221,10 @@ static bool g_discard;
>  module_param_named(discard, g_discard, bool, 0444);
>  MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed null_blk device). Default: false");
>  
> +static bool g_write_zeroes;
> +module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
> +MODULE_PARM_DESC(write_zeroes, "Support write-zeroes operations (requires non-memory-backed null_blk device). Default: false");

Supporting memory backed devices is not that hard. Why not add it ? And while at
it, we could add discard support for memory backed devices as well.

> +

No need for the whiteline here to stay consistent with style.

Please also add the equivalent parameter for the configfs interface so that the
same devices can be created with both modprobe and through configfs.

Also, instead of a bool argument, why not define this as a
"write_zeroes_sectors" which defaults to 0 (disable) ? Doing so, the property is
more generic and not only allows defining thr write zeroes suported (write
zeroes sectors > 0) and not supported (write zeroes sectors == 0) but also set
the maximum size of write zeroes operations.

(note that the same could be said for discard...)

>  static unsigned long g_cache_size;
>  module_param_named(cache_size, g_cache_size, ulong, 0444);
>  MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
> @@ -742,6 +746,7 @@ static struct nullb_device *null_alloc_dev(void)
>  	dev->blocking = g_blocking;
>  	dev->memory_backed = g_memory_backed;
>  	dev->discard = g_discard;
> +	dev->write_zeroes = g_write_zeroes;
>  	dev->cache_size = g_cache_size;
>  	dev->mbps = g_mbps;
>  	dev->use_per_node_hctx = g_use_per_node_hctx;
> @@ -1684,8 +1689,13 @@ static void null_del_dev(struct nullb *nullb)
>  	dev->nullb = NULL;
>  }
>  
> -static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
> +static void null_config_discard_write_zeroes(struct nullb *nullb,
> +					     struct queue_limits *lim)
>  {
> +	/* REQ_OP_WRITE_ZEROES only supported in non memory backed mode */
> +	if (!nullb->dev->memory_backed && nullb->dev->write_zeroes)
> +		lim->max_write_zeroes_sectors = UINT_MAX >> 9;
> +
>  	if (nullb->dev->discard == false)
>  		return;
>  
> @@ -1891,7 +1901,7 @@ static int null_add_dev(struct nullb_device *dev)
>  
>  	if (dev->virt_boundary)
>  		lim.virt_boundary_mask = PAGE_SIZE - 1;
> -	null_config_discard(nullb, &lim);
> +	null_config_discard_write_zeroes(nullb, &lim);
>  	if (dev->zoned) {
>  		rv = null_init_zoned_dev(dev, &lim);
>  		if (rv)
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 477b97746823..8518b4bf2530 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -99,6 +99,7 @@ struct nullb_device {
>  	bool power; /* power on/off the device */
>  	bool memory_backed; /* if data is stored in memory */
>  	bool discard; /* if support discard */
> +	bool write_zeroes; /* if support write_zeroes */
>  	bool zoned; /* if device is zoned */
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  	bool no_sched; /* no IO scheduler for the device */

-- 
Damien Le Moal
Western Digital Research


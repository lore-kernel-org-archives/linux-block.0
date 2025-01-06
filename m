Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5248171D2
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736142248; cv=none; b=miO0crJmye3l0Yi0iS5jRqmST7UcONvKuAaOIO2ASQjEagQ5whT3640xnVG/9VccF367TJEjQCjCtcQE3ZM9vKDjUuZhV5NLgmaNfcg6IrcTyyAMrJBIwDzzhZ2AM/JDk6Z8d2iNJrNa95SrdNfjzQL8a9ds85Kn5Y/7hfJnzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736142248; c=relaxed/simple;
	bh=6fGVZi9KUXUDkTRuKpyGJp1JKymGyt/hmypoIqqY3xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z++QyrSFk8E/oHJPry981q8emga61r83S05BCAISYIiwR0e09MK2fPxHQCNOPgDFp13AQOgC2Ki1zC1F5HI8Qo9g4brswHQ/3jlpQILGSUEjo7JmzJEhbREuqqxgsTn6IHnxv5boIQEZmJswzg5EpSZGqthcXgXFpqY2ZvenjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auTKUG5s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auTKUG5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B81C4CED2;
	Mon,  6 Jan 2025 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736142247;
	bh=6fGVZi9KUXUDkTRuKpyGJp1JKymGyt/hmypoIqqY3xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auTKUG5sBHm3WWXgdkZx6tt8P5hlnHFmJkYfqxXJHmX+wuZfTo3EoeCzAC0pYOU6G
	 hD+OIwUeXISN9KD6l5ipu9c9KKxtSkqPGf6TeA0BrSINlcCe/onmym5yk86PXzsXWu
	 tuWLILzp5xCQ/knqUXvgfEGKfWV68agnKuI992d4gHAooxKFvJkkdRdVM6I+ai4BU6
	 2d2fjh6daZYJjPynSOy430XGipt3Bdw+kgGTQbhuID16XqcKY7wr8mUhRBNOFtpifl
	 KQfVLZ74FekxrS3PQlxLjJueOPkR+J3UIV8HanST2WNiUgPn9dMnOyNwkMkYk33nP0
	 8ir3MIz2cMGxQ==
Message-ID: <029d6daa-a2ee-4a5f-a529-2bd12df3018d@kernel.org>
Date: Mon, 6 Jan 2025 14:43:22 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs
 features string
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> The null_blk configfs file 'features' provides a string that lists
> available null_blk features for userspace programs to reference.
> The string is defined as a long constant in the code, which tends to be
> forgotten for updates. It also causes checkpatch.pl to report
> "WARNING: quoted string split across lines".
> 
> To avoid these drawbacks, generate the feature string on the fly. Refer
> to the ca_name field of each element in the nullb_device_attrs table and
> concatenate them in the given buffer. Also, modify order of the
> nullb_device_attrs table to not change the list order of the generated
> string.
> 
> Of note is that the feature "index" was missing before this commit.
> This commit adds it to the generated string.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Nice cleanup ! One nit below. And with that fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -704,16 +708,27 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
>  
>  static ssize_t memb_group_features_show(struct config_item *item, char *page)
>  {
> -	return snprintf(page, PAGE_SIZE,
> -			"badblocks,blocking,blocksize,cache_size,fua,"
> -			"completion_nsec,discard,home_node,hw_queue_depth,"
> -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> -			"poll_queues,power,queue_mode,shared_tag_bitmap,"
> -			"shared_tags,size,submit_queues,use_per_node_hctx,"
> -			"virt_boundary,zoned,zone_capacity,zone_max_active,"
> -			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
> -			"zone_size,zone_append_max_sectors,zone_full,"
> -			"rotational\n");
> +
> +	struct configfs_attribute **entry;
> +	const char *fmt = "%s,";
> +	size_t left = PAGE_SIZE;
> +	size_t written = 0;
> +	int ret;
> +
> +	for (entry = &nullb_device_attrs[0]; *entry && left > 0; entry++) {
> +		if (!*(entry + 1))
> +			fmt = "%s\n";
> +		ret = snprintf(page + written, left, fmt, (*entry)->ca_name);
> +		if (ret >= left) {
> +			WARN_ONCE(1, "Too many null_blk features to print\n");
> +			memzero_explicit(page, PAGE_SIZE);
> +			return 0;

Let's return an error here. Maybe "-EFBIG" ?
Note that we are nowhere near to hit this though, nor should we ever reach a 4K
string length for null_blk features :)

> +		}
> +		left -= ret;
> +		written += ret;
> +	}
> +
> +	return written;
>  }
>  
>  CONFIGFS_ATTR_RO(memb_group_, features);


-- 
Damien Le Moal
Western Digital Research

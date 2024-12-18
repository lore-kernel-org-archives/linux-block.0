Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12251B0432
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542857; cv=none; b=P6Gvdip80Iq783pfKBeLJxG427tjQXOdv8PF3Df0PwniswIb2GfUzJJq3mPY5NTbt5jqkcEDcjCLjjQGfDelhJVKmaP39Rm/9nwMM5wakOSJUj8EvR57uSGZowbbDElnwrujKAMcxMj1pmAYpdwjbSQRXdqbjRR8we8QAFlqM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542857; c=relaxed/simple;
	bh=qgPJ+8ZMEi1btZURDhccrKTafnnqXEq06nSIPngO7cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrgYv/+ylFcD+BP0ezDsBHwWfYxOhhcZY6wf3AGExPAdGJcbFWRVaV3bd7yccAp1xPl3X/DrdbhMzGaLPYMuwrtm5kzuAblZMWWkf6tGVwWke91PdTlW9t+zHVk2lONYe5BqEcY2TSzwzypzFkEcGWe2Y0nI/en7w8GbDp9qG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UJkZ0yOM; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UJkZ0yOM"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YD0xM23VYz6ClY9q;
	Wed, 18 Dec 2024 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734542852; x=1737134853; bh=qRm95/0xFF7nKex2ub6rFjrD
	XhUX4bUzactnR0Dw+WY=; b=UJkZ0yOM8S0PcU8dtVy3K0+F53OrW+nIQ2xDkELL
	mUFIzjdRBnTrfaFx8ooNoNf6RyEmlpPJoPus/StISkCiJ71Sr2zilwkYyajUCu4U
	gHLJiyCuCjKg/mkIV8Bz9tIfqZXHAG0MLRTxq0gTPeyf8QD27HqHz2cWlRTk6Gia
	rFrWzrjz1f95oagAJBOGwfgUdQNn2P7ndAhMsLt8qDkSU47tBh4vv2JnZriVx9b5
	Ohyzer4aoKsGjImSmUHOz1WvhQlx7dbJh4mdJDlx+FIubtRTXHPgEUqQPkFLA+/H
	vrqVQyz8zKrsr2JRHEwTfaRjJXqYQpi6E5TNN/WTgycKbw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id e7kHjU8LbSTE; Wed, 18 Dec 2024 17:27:32 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YD0xH5mnXz6ClY9D;
	Wed, 18 Dec 2024 17:27:31 +0000 (UTC)
Message-ID: <cccb6cb6-1582-421b-b9a5-6f0b2673f384@acm.org>
Date: Wed, 18 Dec 2024 09:27:31 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 3/3] null_blk: introduce badblocks_once parameter
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
References: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
 <20241218074914.814913-4-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241218074914.814913-4-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 11:49 PM, Shin'ichiro Kawasaki wrote:
>   static ssize_t memb_group_features_show(struct config_item *item, char *page)
>   {
>   	return snprintf(page, PAGE_SIZE,
> -			"badblocks,blocking,blocksize,cache_size,fua,"
> -			"completion_nsec,discard,home_node,hw_queue_depth,"
> -			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
> -			"poll_queues,power,queue_mode,shared_tag_bitmap,"
> -			"shared_tags,size,submit_queues,use_per_node_hctx,"
> -			"virt_boundary,zoned,zone_capacity,zone_max_active,"
> -			"zone_max_open,zone_nr_conv,zone_offline,zone_readonly,"
> -			"zone_size,zone_append_max_sectors,zone_full,"
> -			"rotational\n");
> +			"badblocks,badblocks_once,blocking,blocksize,"
> +			"cache_size,completion_nsec,"
> +			"discard,"
> +			"fua,"
> +			"home_node,hw_queue_depth,"
> +			"irqmode,"
> +			"max_sectors,mbps,memory_backed,"
> +			"no_sched,"
> +			"poll_queues,power,"
> +			"queue_mode,"
> +			"rotational,"
> +			"shared_tag_bitmap,shared_tags,size,submit_queues,"
> +			"use_per_node_hctx,"
> +			"virt_boundary,"
> +			"zoned,zone_capacity,zone_max_active,zone_max_open,"
> +			"zone_nr_conv,zone_offline,zone_readonly,zone_size,"
> +			"zone_append_max_sectors,zone_full\n");
>   }

The entire list of attributes occurs twice in the null_blk source code.
This is error prone. Has it been considered to modify
memb_group_features_show() such that it iterates over the
nullb_device_attrs array instead of duplicating information that already
exists in that array?

Thanks,

Bart.


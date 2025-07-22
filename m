Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208017A2F7
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146595; cv=none; b=GObnNHYQUBYMUDoePZoxPTcrclIswSYbZO5gwdPnp2QL1YjyVccyJyK9OKKEFUVd8ECtz5J29Gwh50yzdQKHC1+t/6kljJIzTMYxi/D5j1g2HyuBI6aKr+mqj23NA8iAwrElEMraR3icGN6KIWZLE1peKS7KJZZmO9HtsiReegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146595; c=relaxed/simple;
	bh=jFKALhnKigzWNbqhxEUSDrzQM7Z5IRR8yRSCBbOiz68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+dRruc4/FKAbU4XQfPdbkf+9tk8vmcE2vePRIMrSecrO5ZbSndjWhz96eZ9k0IiaxApllwQ2WxTB6HcyKtwDC0g5b+7NablRfTOS5BzDtkk9eyI1cUVoeUme10O+m+X7fuacKZeyo9lCaDaQnWwEi0qK+JwfEK6W1ojjMwwohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhu+xQbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhu+xQbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471B1C4CEF5;
	Tue, 22 Jul 2025 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753146595;
	bh=jFKALhnKigzWNbqhxEUSDrzQM7Z5IRR8yRSCBbOiz68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hhu+xQbU22nRihjJ45vX0xG0rglzVUqytYYsl+VU4kTY21AralW+6Ghfa2Lvcl/AZ
	 7i4ZIZoTLHWgkwyYW6mgYB4vD6zH5T1H1wCCUKFuo7E1Yanxfg3Zj6U8MwAGpvKfyK
	 UMqBVkXTLCGSp32S++q5ILwkjZvrc4iJ7mjLC6ADe2dDK+jBQh1Yl0ubJMa3TWNt1x
	 E+T0bAtrmtqT0P2m/qYXbD6HhGvy4cClIKMCWEIjF/vEHPwaYqjfblHmLuYdPyXA+M
	 anBLFwPE7tA8f3kFoG4XAArVyool4cUeiI3gb7bTqM8iSOX85QMHLqvYSPGtWayw3I
	 10d7JPRcBrCQA==
Message-ID: <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
Date: Tue, 22 Jul 2025 10:07:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250721140450.1030511-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 11:04 PM, Nilay Shroff wrote:
> When setting up a null block device, we initialize a tagset that
> includes a driver_data field—typically used by block drivers to
> store a pointer to driver-specific data. In the case of null_blk,
> this should point to the struct nullb instance.
> 
> However, due to recent tagset refactoring in the null_blk driver, we
> missed initializing driver_data when creating a shared tagset. As a
> result, software queues (ctx) fail to map correctly to new hardware
> queues (hctx). For example, increasing the number of submit queues
> triggers an nr_hw_queues update, which invokes null_map_queues() to
> remap queues. Since set->driver_data is unset, null_map_queues()
> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
> effectively making the hardware queues unusable for I/O.
> 
> This patch fixes the issue by ensuring that set->driver_data is properly
> initialized to point to the struct nullb during tagset setup.
> 
> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/block/null_blk/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index aa163ae9b2aa..fbae0427263d 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>  {
>  	if (nullb->dev->shared_tags) {
>  		nullb->tag_set = &tag_set;
> +		nullb->tag_set->driver_data = nullb;

This looks better, but in the end, why is this even needed ? Since this is a
shared tagset, multiple nullb devices can use that same tagset, so setting the
driver_data pointer to this device only seems incorrect.

Checking the code, the only function that makes use of this pointer is
null_map_queues(), which correctly test for private_data being NULL.

So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?

>  		return null_init_global_tag_set();
>  	}
>  


-- 
Damien Le Moal
Western Digital Research

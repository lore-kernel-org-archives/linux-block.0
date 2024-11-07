Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFC4A21
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942326; cv=none; b=p1KGUjsEGotL2mWifxhL7Jhjtm5AdX5dXQ071DHb8nwH3S3mS7K9jz6Aru2o5ZkOh3xbS72wQxzizEVbI0tTPnTTYF2cx/9v0SyASYy5cRXrVza/XGSoffaoTo7u8KmXBDqHB4tNx2ZZFebXFKbQ7pJRXjB+WIKwzsQ+LQ3dDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942326; c=relaxed/simple;
	bh=qWInC7zSL4Q7hkq9BFST37M+UxxipIhrOq5tr8lrhfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCWmCZ6CyRscNsEW8dFcaji5x0jMMgCMPgHyVE/uAVph/YNpYO6VZaptko+2JX8FqegF66x8WxGcPADTF9m/nbM0bp//5Xg0qj7QXZzfhHeCz3V23H3Tv6nPFbHhv7i/ra14MX+/KgDaIHgW5IilrqpwPaw0qbKQ2pDJrbSzmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2kuCHfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2kuCHfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFBFC4CEC6;
	Thu,  7 Nov 2024 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730942326;
	bh=qWInC7zSL4Q7hkq9BFST37M+UxxipIhrOq5tr8lrhfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k2kuCHfZQ7EQjcbYOqDz4in9BU64bsH3HLqRQ02AESMzTgyUIA3vrHGqG7xJp5btr
	 J3ZdbBc/NilQz0pDTSm3DVYfb8FBL9rxjvJzBbxdxyi2zhYzeVy0MrhZZf/6ySOGZP
	 OeuRXdn14uJJUuvn7h/fFFUB/tAhKPx2x5I/OeXRZb0pJIgjmYRF2FZ5Em225KpbTl
	 75PmlpYuJ0XsO+kTEyifPitMeiAO/nRVWXq7P6aNEPPCmTruOtPTB7LEfZwMbkMO4s
	 yQInDT+Mz4igIIW3FaxtYjo9Hs3/rJMHYUc3pgUCjVe48BmXRKf9LHUnpCX/13OUfJ
	 HPjL409nqqSpw==
Message-ID: <a3cceb4a-daa4-4571-b6cf-e111a15ce585@kernel.org>
Date: Thu, 7 Nov 2024 10:18:44 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: get wp_offset by bdev_offset_from_zone_start
To: LongPing Wei <weilongping@oppo.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, bvanassche@google.com
References: <20241107002312.1643655-1-weilongping@oppo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241107002312.1643655-1-weilongping@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 09:23, LongPing Wei wrote:
> It should be better to call bdev_offset_from_zone_start()
>  instead of open-coding it.

Make this simply:

Call bdev_offset_from_zone_start() instead of open-coding it.

With that, looks good to me, so feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: LongPing Wei <weilongping@oppo.com>
> ---
> v3: update commit message
> ---
>  block/blk-zoned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index af19296fa50d..77a448952bbd 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -537,7 +537,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
>  	spin_lock_init(&zwplug->lock);
>  	zwplug->flags = 0;
>  	zwplug->zone_no = zno;
> -	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
> +	zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
>  	bio_list_init(&zwplug->bio_list);
>  	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
>  	zwplug->disk = disk;


-- 
Damien Le Moal
Western Digital Research

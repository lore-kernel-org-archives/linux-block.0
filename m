Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5533439F9C
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768595; cv=none; b=KVPhFFhcD1IbuRxOK26USzyulgi6F9++pyStY1MwECX+wBe1KCZCkwz0hHbOAU/HECFIzNB1zVrnhEPWeSCqGpVwxWgQtTnV0xvKJfns3HlpLVYT9u/Y1gWbxzHW87fV8vUERL/zb+t+PfFuld7qduc6LW/A8hGIYltJ8dME2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768595; c=relaxed/simple;
	bh=xFobeviQ1ag7EB5Gzx6+lt/U+eJl+/2DhF5EFSpW2w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1EyJwa/QUGHbCYW92QKP4L5ML/uj2LAHJwG6zAUjlHVWxX3xa9WuP6KtPQMefwf5nAY/pIH+Af6Qd/JPOphgG+mrKhlGR2Fmt/PTIUe10tfTZc8fKErcpuefzw8WfM+OVXQDRKNeLr502jpYDT+G15V9R+bK7l581Bv9r0o1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uwv11h+L; arc=none smtp.client-ip=91.218.175.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uwv11h+L"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xFobeviQ1ag7EB5Gzx6+lt/U+eJl+/2DhF5EFSpW2w8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788768591; v=1; x=1789373391;
 b=Uwv11h+LXnTNWkqqUP6Kc6AflWv24W/38T7iFXHy2MW8IABOlAeI7KywjukjnrgXfPS1mYzN
 YU1oAb5zOeRISvMkno4adSg1qG26lvv/CFV7nWr8b00WDzEm22XyP0PBCw143s2yy0Jm1mxY8Wi
 2lxObyufPCAa1W8qR9vKMcMw=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id b8323acea06e66fe;
	Mon, 07 Sep 2026 08:09:51 +0000
X-Mizu-Trace-ID: b8323acea06e66fe
X-Migadu-Flow: FLOW_OUT
Message-ID: <8c16f727-c840-4a8f-94a7-fbe09bc3735a@linux.dev>
Date: Mon, 7 Sep 2026 09:09:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: John Garry <john.g.garry@oracle.com>, "Martin K. Petersen"
 <mkp@kernel.org>, linux-block@vger.kernel.org
References: <20260907074111.721054-1-hch@lst.de>
 <20260907074111.721054-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260907074111.721054-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 08:40, Christoph Hellwig wrote:
> As Sashiko points out, 

Do you have a reference for that? I'm just curious, as we don't support 
atomics for integrity writes. Well, for SCSI we don't... we impose this 
restriction via sd_config_atomic(), I need to check for the same in NVMe...

> limiting the I/O size by the size of the available
> PI buffer can cause inconsistencies for atomic writes.  This also limit
> atomic_write_max_sectors in blk_validate_integrity_limits.
> 
> Fixes: ec7f31b2a2d3 ("block: make bio auto-integrity deadlock safe")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8274631290db..e469baa1f08b 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -206,6 +206,12 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
>   	lim->max_sectors = min(lim->max_sectors,
>   		max_integrity_io_size(lim) >> SECTOR_SHIFT);
>   
> +	if (lim->features & BLK_FEAT_ATOMIC_WRITES) {
> +		lim->atomic_write_max_sectors =
> +			min(lim->atomic_write_max_sectors,
> +				max_integrity_io_size(lim) >> SECTOR_SHIFT);
> +	}
> +
>   	return 0;
>   }
>   


Received: from mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D537F300
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945386; cv=none; b=qpeuLOJpkuyj4EAe5tHMcBjszd6sdB0OdX29DN9A9L1IqD9BSm8gsyOutfzSiotrg19TAAuxtkij7EajTbo2v4BtedShLZ3cMB8X/KphpIdA+gBntvCtCxeKNk9/jVxJlrLBelqfvDIvCZPXEvDUR3JXQQnr5OzvKXy0gaAymbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945386; c=relaxed/simple;
	bh=2p12xzRGoXy1OrxANEwBJ2r2DrUF3PiGdCVZG8FN9oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAQfv89jZc9Dv4wi2Sm2vD5R0S4L2Spb2/EjVx3Q9HepxyfgJGUQMh4KczZLbeP6vEmR4zsrkxewPB7RTHV3kudrtjlCX0UOixT5Wmy/A93WWD6SjedPoSBEW36cTLui9iRSSAtPIA5W7pdigVdL9UYaGog9vVFw/iFQcb3LuPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFxCgxdB; arc=none smtp.client-ip=95.215.58.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFxCgxdB"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2p12xzRGoXy1OrxANEwBJ2r2DrUF3PiGdCVZG8FN9oE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788945379; v=1; x=1789550179;
 b=WFxCgxdBhWtkXcM9ZHYxxCXuS0D+oCaAol9JyKxFgwUKaX8dguXlmrAiPf3KRc5zntsSI8Mi
 bHFEQ160HEgMJY78i0m2vwTNBaw35iHFQmWLcrj0csnGHNeINb1ttAXU06jyTNNxgG5seIT/0/o
 wPvvkzqkAb/hnsE/mzRC1rBk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 7551a6df7cd90cfb;
	Wed, 09 Sep 2026 09:16:19 +0000
X-Mizu-Trace-ID: 7551a6df7cd90cfb
X-Migadu-Flow: FLOW_OUT
Message-ID: <a17ccccc-a91c-4e45-a97e-d899c739e159@linux.dev>
Date: Wed, 9 Sep 2026 10:16:17 +0100
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
> As Sashiko points out, limiting the I/O size by the size of the available
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

A note about the sashiko comment from earlier:
"
The block layer calculates atomic write limits (lim->atomic_write_unit_max)
before blk_validate_integrity_limits() restricts lim->max_sectors. As a
result, the filesystem permits atomic writes up to the unconstrained atomic
limit.
"

atomic writes are not limited by lim->max_sectors, but rather by 
max_hw_sectors. That decision was taken as the atomic limits for a block 
device should be fixed, and not update-able when userspace changes 
max_sectors via sysfs. See this in get_max_io_size():

	if (bio_op(bio) == REQ_OP_WRITE_ZEROES)
		max_sectors = lim->max_write_zeroes_sectors;
	else if (is_atomic)
		max_sectors = lim->atomic_write_max_sectors;
	else
		max_sectors = lim->max_sectors;

Furthermore, I don't think that this is the change above is correct. We 
have 4x atomic limits and I think that 3x would need updating:
- atomic_write_max_sectors
- atomic_write_unit_min
- atomic_write_unit_max

The expectation is that the driver sets atomic_write_hw_max, 
atomic_write_hw_unit_min, and atomic_write_hw_unit_max individually. We 
don't assume that atomic_write_hw_unit_max == 
rounddown_pow_of_two(atomic_write_hw_max). The is because of SCSI and 
it's granularity and alignment atomic limits :(

Anyway, maybe this is a better change:

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8274631290db..b88744d42719 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -233,11 +233,15 @@ static void blk_atomic_writes_update_limits(struct 
queue_limits *lim)
  	unsigned int unit_limit = min(lim->max_hw_sectors << SECTOR_SHIFT, 
blk_queue_max_guaranteed_bio(lim));

+	unit_limit = min_not_zero(unit_limit, max_integrity_io_size(lim));
  	unit_limit = rounddown_pow_of_two(unit_limit);

  	lim->atomic_write_max_sectors =
  		min(lim->atomic_write_hw_max >> SECTOR_SHIFT,
  			lim->max_hw_sectors);
+	lim->atomic_write_max_sectors =
+		min_not_zero(lim->atomic_write_max_sectors,
+			max_integrity_io_size(lim));
  	lim->atomic_write_unit_min =
  		min(lim->atomic_write_hw_unit_min, unit_limit);
  	lim->atomic_write_unit_max =
@@ -505,11 +509,12 @@ int blk_validate_limits(struct queue_limits *lim)
  	if (!(lim->features & BLK_FEAT_WRITE_CACHE))
  		lim->features &= ~BLK_FEAT_FUA;

-	blk_validate_atomic_write_limits(lim);

  	err = blk_validate_integrity_limits(lim);
  	if (err)
  		return err;
+
+	blk_validate_atomic_write_limits(lim);
  	return blk_validate_zoned_limits(lim);
  }
  EXPORT_SYMBOL_GPL(blk_validate_limits);

Side note:
I would (naively) assume that if the disk has integrity, then it's 
atomic limits reported would update accordingly and 
lim->atomic_write_hw_max et al would already have any integrity limits 
built in (so that we don't need to do any capping of atomic limits by 
integrity limits).

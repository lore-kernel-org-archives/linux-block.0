Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8D25BAC4
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710715; cv=none; b=R0aesjRjVDlPvEbrFykH7HzKXrk31ULT5RVgPRHhKh4BGMSjCoVP9EY/lWbdxuZDAhcaQlYz2vOjlmoPNG3TAgusu5clu8blTl9RTcfjCtP2kLVz8X1R/+9yiQOSxkB88xlD00d9bTyo4Lb3ToyCrw/R2XYUgA0OMnsB+URmQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710715; c=relaxed/simple;
	bh=VOK2OyWtjeX9aTkdjfM8OSqcCK8wX1uA8EMliUvQC1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7pwYBMa695h+GSAMEeSN1lN9NjtUffvusqjYWqGw8j6mKGsvMQ8pR3jil/OjbUIiLSC5ckepYK/x8x8pTXfeAWtxPO+RrpnbOouyyY6M6gYEiu+LXq197oWW0WC7zzjpwtv+d0ikO3pUK0PnhC8FasN3rByu0TmvEISQRcKFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KfH2kRCW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KfH2kRCW"
Message-ID: <407754b2-1e52-4d20-892d-524be47053c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743710709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHjk9tyXIvefyYyXbeOptYF3nU21b5sg0r8hT0A6PLY=;
	b=KfH2kRCWnTbWMeU4yZ1CAbiKyAd8PD9t8WZC0Nt+EHARmp9GlgkqEsOjbhGlZng1D3spGn
	CfzOr401ZMyheO8bW7Zdc90x75UdWxn4nkSqyzTlmaKc3tVqfUIiwgyTwup2LfMwDMLCAk
	KjckNje9XPe1R0o3wpzlZ0I9TEHxJR0=
Date: Thu, 3 Apr 2025 22:04:58 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] loop: replace freezing queue with quiesce when changing
 loop specific setting
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
 syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
References: <20250403105414.1334254-1-ming.lei@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250403105414.1334254-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/3 12:54, Ming Lei 写道:
> freeze queue should be used for changing block layer generic setting, such
> as logical block size, PI, ..., and it is enough to quiesce queue for
> changing loop specific setting.
> 
> Remove the queue freeze warning in loop_update_dio(), since it is only
> needed in loop_set_block_size(), where queue is froze obviously.
> 
> Fix reported lockdep by syszbot:
> 
> https://lore.kernel.org/linux-block/67ea99e0.050a0220.3c3d88.0042.GAE@google.com/
> 
> Reported-by: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I am fine with this commit.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/block/loop.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc..59886556f55c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -190,8 +190,6 @@ static bool lo_can_use_dio(struct loop_device *lo)
>   static inline void loop_update_dio(struct loop_device *lo)
>   {
>   	lockdep_assert_held(&lo->lo_mutex);
> -	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
> -		     lo->lo_queue->mq_freeze_depth == 0);
>   
>   	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
>   		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
> @@ -595,7 +593,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   {
>   	struct file *file = fget(arg);
>   	struct file *old_file;
> -	unsigned int memflags;
>   	int error;
>   	bool partscan;
>   	bool is_loop;
> @@ -640,11 +637,11 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>   
>   	/* and ... switch */
>   	disk_force_media_change(lo->lo_disk);
> -	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +	blk_mq_quiesce_queue(lo->lo_queue);
>   	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
>   	loop_assign_backing_file(lo, file);
>   	loop_update_dio(lo);
> -	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> +	blk_mq_unquiesce_queue(lo->lo_queue);
>   	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
>   	loop_global_unlock(lo, is_loop);
>   
> @@ -1270,7 +1267,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>   	int err;
>   	bool partscan = false;
>   	bool size_changed = false;
> -	unsigned int memflags;
>   
>   	err = mutex_lock_killable(&lo->lo_mutex);
>   	if (err)
> @@ -1287,8 +1283,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>   		invalidate_bdev(lo->lo_device);
>   	}
>   
> -	/* I/O needs to be drained before changing lo_offset or lo_sizelimit */
> -	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +	/* queue needs to be quiesced before changing lo_offset or lo_sizelimit */
> +	blk_mq_quiesce_queue(lo->lo_queue);
>   
>   	err = loop_set_status_from_info(lo, info);
>   	if (err)
> @@ -1310,7 +1306,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>   	loop_update_dio(lo);
>   
>   out_unfreeze:
> -	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> +	blk_mq_unquiesce_queue(lo->lo_queue);
>   	if (partscan)
>   		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>   out_unlock:


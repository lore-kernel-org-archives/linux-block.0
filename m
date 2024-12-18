Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD71C5CC2
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533867; cv=none; b=hY5+JL7hGDKU3OScg/LiqRo0zjWsDKQCwxaN95EAp/xnPtRUlb0RPumgT93BVX5Luz1EtHSkvDjBrTNNGb/xFuacwaoIgSn4lPhATbxszgyZ+RUhhw03v3oIDn+MW0vrcl0ENeQnkjQDlf8qhx4lvS/rfheJ3nWf4L1WxM/KZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533867; c=relaxed/simple;
	bh=IqHTGLpG+AMPT5dyVe0gpwNhxFkc7RgSaL9VMqf5biU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtYkpz4tVos99Mc2m5aehz3rpwc4JHGgyjjxdfUT9JsiiJsDMF6Ethl0/DvP82KG67kcZyleIloKavxg7qGE5QYXlimF+j0xZYDUsJQGsijezfyGsh/hxjDqfUewmIpxzbpI51qhqroA9bfbS2YSIuqtpZh8GVFzIEXqUIQsyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZayBSeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZayBSeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ECFC4CECD;
	Wed, 18 Dec 2024 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734533866;
	bh=IqHTGLpG+AMPT5dyVe0gpwNhxFkc7RgSaL9VMqf5biU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZayBSeTLk2pkA8VG+vDHUAmDAs4EsCY4U5mNFFdG7fVQ5d1E5awf/3pg32DnQXfr
	 L9KtcDycBbaKlzYwe4g0qYLOeO1TBXqV0WTC7U2cfMUuAunWxoS0ffp4GPKXhYrqZx
	 4wxMDxLHM8/QFV/hRwrFrf6OiaRQrDEEzyp6BgucMk6de9uWMMO2GW7ZSo0bKBX1v7
	 85zPTi67m6laxCkaKstQ15VYfob7gL/RE+9NDUnc70EaHgPXGMnSiWuf13yk2lwqJY
	 iXrasBNVjhE22MDpNAPit7B5ysxKCTxuUI2ERs5WAMJW1HUJwMzLxw/JqwY/BwaIBO
	 csFe4kTpzfkJQ==
Message-ID: <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
Date: Wed, 18 Dec 2024 06:57:45 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
 <Z2LQ0PYmt3DYBCi0@fedora>
 <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/18 6:05, Nilay Shroff wrote:
>>> In the above code block, we may then replace blk_mq_freeze_queue() with
>>> queue_limits_commit_update() and similarly replace blk_mq_unfreeze_queue() 
>>> with queue_limits_commit_update().
>>>
>>> {
>>>     queue_limits_start_update()
>>>     ...
>>>     ...
>>>     ...
>>>     queue_limits_commit_update()
>>
>> In sd_revalidate_disk(), blk-mq request is allocated under queue_limits_start_update(),
>> then ABBA deadlock is triggered since blk_queue_enter() implies same lock(freeze lock)
>> from blk_mq_freeze_queue().
>>
> Yeah agreed but I see sd_revalidate_disk() is probably the only exception 
> which allocates the blk-mq request. Can't we fix it? 

If we change where limits_lock is taken now, we will again introduce races
between user config and discovery/revalidation, which is what
queue_limits_start_update() and queue_limits_commit_update() intended to fix in
the first place.

So changing sd_revalidate_disk() is not the right approach.

> One simple way I could think of would be updating queue_limit_xxx() APIs and
> then use it,
> 
> queue_limits_start_update(struct request_queue *q, bool freeze) 
> {
>     ...
>     mutex_lock(&q->limits_lock);
>     if(freeze)
>         blk_mq_freeze_queue(q);
>     ...
> }
> 
> queue_limits_commit_update(struct request_queue *q,
> 		struct queue_limits *lim, bool unfreeze)
> {
>     ...
>     ...
>     if(unfreeze)
>         blk_mq_unfreeze_queue(q);
>     mutex_unlock(&q->limits_lock);
> }
> 
> sd_revalidate_disk()
> {
>     ...
>     ...
>     queue_limits_start_update(q, false);
> 
>     ...
>     ...
> 
>     blk_mq_freeze_queue(q);
>     queue_limits_commit_update(q, lim, true);    

This is overly complicated ... As I suggested, I think that a simpler approach
is to call blk_mq_freeze_queue() and blk_mq_unfreeze_queue() inside
queue_limits_commit_update(). Doing so, no driver should need to directly call
freeze/unfreeze. But that would be a cleanup. Let's first fix the few instances
that have the update/freeze order wrong. As mentioned, the pattern simply needs
to be:

	queue_limits_start_update();
	...
	blk_mq_freeze_queue();
	queue_limits_commit_update();
	blk_mq_unfreeze_queue();

I fixed blk-zoned code last week like this. But I had not noticed that other
places had a similar issue as well.

-- 
Damien Le Moal
Western Digital Research

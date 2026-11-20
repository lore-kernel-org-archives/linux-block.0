Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143401;
	b=Y/GLHxwbJNYQ1FBfgx05qfEkhvNslR6d9APp0i7vS4efvf/2TPiRKz2F1W4LHFkHb3a0
	 V/WwwAKFhN0fsi5K+ihKOEcz9u0WvO5zVEoHMa3IrhtnlD4vYigcSCw6dUegQU5JexJrc
	 hDMpnxR5pxBi/siDB3+kFd8hnPBME1HpeNDL/W1MlSvRQaQXtIQ0o6/bUyxZchDLa4S9I
	 GSMERHLPezjCudH+S0Hvy4paE97jR5INQ7IHjNttX7LkKPYHw4uaR/FuoiiQQJGrrWyI/
	 O6Vzk4fv+y4D4gkBfd9wBd2y6FgiFE4szZwTBEgq9zaqqKNsbGX+IWckPRXBndUQ3Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143401;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AGh7gO8xAUb32hxlaVb7cp0MZEDs//ukTFJwii+IUdQ=;
	b=E4ARBKpUA+sk0qB9Rim8K1iZ/RofLxMaLlG+93KQFFgGqXTPwv8x0PCoLMdW+lwF0MBg
	 aFFQqb473kqdCT7HVqjRLk3gA9fEzTLuSevyGHiKE5rTGt+CuXf2pWohurppI31Y7UBKr
	 aWtuw6gZ4KIHMMseleN5l/+ZvHGh8x6s6ZkNfb+dXrbMjxhbLEeUI90I4fmGoKtBl862N
	 LMFVua4bA5tbt87hok2hrFh1hZ1M5AXahkSbYDRHJJlv1TmPw/vs3RFXCEiOmFVf5jYR0
	 gzMUxFjFLyeyDp60KMRQB+l8Rjj7CeTYZHVoLciF8Hdgfe/FO94Q/kY26gPlPLOoVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J2Po1Ljw;
	arc=none smtp.remote-ip=91.218.175.63
Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D5606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C8D5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J2Po1Ljw
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XhRjMNS6NK3aNMlNMOlEhLqN52rU2XtXdGtW9U0p1Vw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795143398; v=1; x=1795748198;
 b=J2Po1LjwAk7su+6Sh4n9bXcuFfVUByvdRdf52ShQVAjhU24pzaAI1PJNwIy74g+Prkr1Bd47
 rFR2EqJ6DYTsonJyN8M1gqhorHEiYXC1rsVWb8/rMDVxj9dv8PbGnfhok7mPGiCLZDPqJvUfgj/
 SssP+jF5L8S1JL5VXfvuYvhc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 874576962382fad4;
	Fri, 20 Nov 2026 02:56:38 +0000
X-Mizu-Trace-ID: 874576962382fad4
X-Migadu-Flow: FLOW_OUT
Message-ID: <7106a456-8e3d-4fe2-ae7d-b8e753e2b131@linux.dev>
Date: Fri, 20 Nov 2026 10:56:17 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/7] blk-iocost: don't take rq_qos_mutex before the queue
 is frozen in cost model write
To: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
 <20261119070548.3125491-4-kanie@linux.alibaba.com>
 <473ff2e1-329f-49c0-a124-b9e2194d7bcf@linux.dev>
 <70f7faf8-e362-4a1c-ae5d-33c168337755@linux.alibaba.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <70f7faf8-e362-4a1c-ae5d-33c168337755@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Guixin,

在 2026/11/20 10:14, Guixin Liu 写道:
> 
> 
> 在 2026/11/19 21:40, Tao Cui 写道:
>> Hello, Guixin,
>>
>> 在 2026/11/19 15:05, Guixin Liu 写道:
>>> ioc_cost_model_write() freezes the queue while holding rq_qos_mutex,
>>> which blkg_conf_open_bdev() acquired first. Every other path takes
>>> rq_qos_mutex only after the queue is frozen: ioc_qos_write() releases
>>> and re-acquires the mutex around blk_mq_freeze_queue(), and rq_qos_add()
>>> documents that its caller holds the mutex with the queue frozen.
>>> Waiting for in-flight IO while holding rq_qos_mutex breaks that rule,
>>> and on the first write to a queue without iocost the path even calls
>>> blk_iocost_init() -> rq_qos_add() -> blk_mq_freeze_queue() while
>>> nothing has frozen the queue yet.
>>>
>>> Mirror the release-freeze-reacquire sequence of ioc_qos_write(). The
>>> unfreeze moves to the close_bdev label so the error exits after the
>>> freeze don't leave the queue frozen, and it runs before
>>> blkg_conf_close_bdev() drops the bdev reference, while the queue is
>>> still pinned.
>>>
>> I tried the same change in cost model write recently and it turned out flawed, these two reviews explain it better than I can [1][2].
>>
>> In short: the disk_live() check in blkg_conf_open_bdev() only holds while rq_qos_mutex is kept, and dropping it around the freeze lets the disk and the ioc go away; Tejun reproduced a use-after-free that way.
>>
>> I've been busy with another thread lately, so I'm glad to see you proposing a fix for this. Hope the links help.
>>
>> Thanks,
>> Tao
>>
>> [1] https://lore.kernel.org/all/20261111163306.GA17267@lst.de/
>> [2] https://lore.kernel.org/all/bfe5007b2758bb06504b6966abaf1f7e@kernel.org/
>>  
> Hi Tao,
>   Thanks for the review, right, this patch enter the same issue, I will drop this
> in next version.
>

Thanks for checking the history before reworking. I'm still busy with another thread, so if you have time, feel free to take this forward.

Thanks,
Tao
 
>   And about the ioc_qos_write()'s disk_live race window, My patch 6 fixed the issue,
> could you please take a look?
> 
> Best Regards,
> Guixin Liu
>>> Fixes: 2b2da2f6dc80 ("blk-iocost: prevent configuration update concurrent with io throttling")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>> ---
>>>  block/blk-iocost.c | 12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>>> index 1c1025157d8e..8e06b83691aa 100644
>>> --- a/block/blk-iocost.c
>>> +++ b/block/blk-iocost.c
>>> @@ -3589,6 +3589,15 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>>  	ret = blkg_conf_open_bdev(&ctx);
>>>  	if (ret)
>>>  		return ret;
>>> +	/*
>>> +	 * Nothing is protecting QoS state yet, so release q->rq_qos_mutex,
>>> +	 * which was first acquired in blkg_conf_open_bdev, and re-acquire it
>>> +	 * after freezing the queue to maintain the correct locking order.
>>> +	 */
>>> +	mutex_unlock(&ctx.bdev->bd_queue->rq_qos_mutex);
>>> +
>>> +	memflags = blk_mq_freeze_queue(ctx.bdev->bd_queue);
>>> +	mutex_lock(&ctx.bdev->bd_queue->rq_qos_mutex);
>>>  
>>>  	body = ctx.body;
>>>  	q = bdev_get_queue(ctx.bdev);
>>> @@ -3605,7 +3614,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>>  		ioc = q_to_ioc(q);
>>>  	}
>>>  
>>> -	memflags = blk_mq_freeze_queue(q);
>>>  	blk_mq_quiesce_queue(q);
>>>  
>>>  	spin_lock_irq(&ioc->lock);
>>> @@ -3663,9 +3671,9 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>>  	spin_unlock_irq(&ioc->lock);
>>>  
>>>  	blk_mq_unquiesce_queue(q);
>>> -	blk_mq_unfreeze_queue(q, memflags);
>>>  
>>>  close_bdev:
>>> +	blk_mq_unfreeze_queue(q, memflags);
>>>  	blkg_conf_close_bdev(&ctx);
>>>  	return ret ?: nbytes;
>>>  }
> 


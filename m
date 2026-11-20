Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795140854;
	b=sy8vplPN+I9S3eIutlgNnHiMnRJj5W6lDanNcEvzch9ScUgKJcrVesXWJ0NL59097i2l
	 7WzZqHUdWfnmsze3yq9bUgMJQHlS9tSWLGwd2cE8SEFaN7qZ3H0oTo6y4tozqrLPaHZBX
	 nZw5qYLWaIeCq7gQiJIaRfPWFtXTTPCojQS/pFiBgJ5BfOUxGXwzlsPY+cRdJKJ8nI/Zz
	 somqVA27NU39Z65m8wn7HdJn3gGqKZvkz5tGMmtVX9vVvS78OHv9EeFAX74AHWu5E2ziU
	 qw0NyDXMQdW80LwIeBv8B68kMAey/WQXyZnluum5RU4CmoGCcOVZSNMEFcVLjNNeBnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140854;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Q7GYwd9wJDw5rFiAzr4fd3C5PWqhzqBzpJi6lncFg0Y=;
	b=S5qeCoNPVacrvIPt4j36p0w4TTiCqWeE+Yqy/M/JOY3dGct3NVkqkDBCK/VuyG4ymS7j
	 WO0oX5bWfqJiO6JZDIrZauJkzUcoxr9E2ULZxc9fJRYSESXH7UXTYhzb5eRWYLTD9hATg
	 zazlb7nMxj7l6u3VuCCVW016bYoR3ZzTUoVo6Ad4uiUSjA+2d+hlqM4atiCUO1tFxms1U
	 AmD6IY8T9rx5GfzSGtIlg3qSSR7Czdns7KquSSANYsDxrC6jIT8n1bwbNeGyWnUOxWkVw
	 e7p95A0x8jcOIs0VsC+RrSfSe325eMcQ1Is822hD7My3t5dt7SQkzPLsrZkt8ad4GsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="hgS/yLHa";
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A550606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A550606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hgS/yLHa
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795140843; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q7GYwd9wJDw5rFiAzr4fd3C5PWqhzqBzpJi6lncFg0Y=;
	b=hgS/yLHavXitYKTzQnoQ3vfK50/bPFX5us5tjKlmdIgkhElgKoQO19kCZ6DgIHwp/oPh0wo0AABJ+A88WALUUlibMY+MBty0SJOCvyf/n64iMiYwbgL3kyvTCpjmIh4psQfI+Vt+RYwnZeOK7qNnDT0rbBGasXRvFO7AyiBE2nU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XF4oH9p_1795140842;
Received: from 30.178.67.37(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF4oH9p_1795140842 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 10:14:03 +0800
Message-ID: <70f7faf8-e362-4a1c-ae5d-33c168337755@linux.alibaba.com>
Date: Fri, 20 Nov 2026 10:14:01 +0800
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
Subject: Re: [PATCH 3/7] blk-iocost: don't take rq_qos_mutex before the queue
 is frozen in cost model write
To: Tao Cui <cui.tao@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
 <20261119070548.3125491-4-kanie@linux.alibaba.com>
 <473ff2e1-329f-49c0-a124-b9e2194d7bcf@linux.dev>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <473ff2e1-329f-49c0-a124-b9e2194d7bcf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/11/19 21:40, Tao Cui 写道:
> Hello, Guixin,
>
> 在 2026/11/19 15:05, Guixin Liu 写道:
>> ioc_cost_model_write() freezes the queue while holding rq_qos_mutex,
>> which blkg_conf_open_bdev() acquired first. Every other path takes
>> rq_qos_mutex only after the queue is frozen: ioc_qos_write() releases
>> and re-acquires the mutex around blk_mq_freeze_queue(), and rq_qos_add()
>> documents that its caller holds the mutex with the queue frozen.
>> Waiting for in-flight IO while holding rq_qos_mutex breaks that rule,
>> and on the first write to a queue without iocost the path even calls
>> blk_iocost_init() -> rq_qos_add() -> blk_mq_freeze_queue() while
>> nothing has frozen the queue yet.
>>
>> Mirror the release-freeze-reacquire sequence of ioc_qos_write(). The
>> unfreeze moves to the close_bdev label so the error exits after the
>> freeze don't leave the queue frozen, and it runs before
>> blkg_conf_close_bdev() drops the bdev reference, while the queue is
>> still pinned.
>>
> I tried the same change in cost model write recently and it turned out flawed, these two reviews explain it better than I can [1][2].
>
> In short: the disk_live() check in blkg_conf_open_bdev() only holds while rq_qos_mutex is kept, and dropping it around the freeze lets the disk and the ioc go away; Tejun reproduced a use-after-free that way.
>
> I've been busy with another thread lately, so I'm glad to see you proposing a fix for this. Hope the links help.
>
> Thanks,
> Tao
>
> [1] https://lore.kernel.org/all/20261111163306.GA17267@lst.de/
> [2] https://lore.kernel.org/all/bfe5007b2758bb06504b6966abaf1f7e@kernel.org/
>  
Hi Tao,
  Thanks for the review, right, this patch enter the same issue, I will drop this
in next version.

  And about the ioc_qos_write()'s disk_live race window, My patch 6 fixed the issue,
could you please take a look?

Best Regards,
Guixin Liu
>> Fixes: 2b2da2f6dc80 ("blk-iocost: prevent configuration update concurrent with io throttling")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>  block/blk-iocost.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 1c1025157d8e..8e06b83691aa 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -3589,6 +3589,15 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>  	ret = blkg_conf_open_bdev(&ctx);
>>  	if (ret)
>>  		return ret;
>> +	/*
>> +	 * Nothing is protecting QoS state yet, so release q->rq_qos_mutex,
>> +	 * which was first acquired in blkg_conf_open_bdev, and re-acquire it
>> +	 * after freezing the queue to maintain the correct locking order.
>> +	 */
>> +	mutex_unlock(&ctx.bdev->bd_queue->rq_qos_mutex);
>> +
>> +	memflags = blk_mq_freeze_queue(ctx.bdev->bd_queue);
>> +	mutex_lock(&ctx.bdev->bd_queue->rq_qos_mutex);
>>  
>>  	body = ctx.body;
>>  	q = bdev_get_queue(ctx.bdev);
>> @@ -3605,7 +3614,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>  		ioc = q_to_ioc(q);
>>  	}
>>  
>> -	memflags = blk_mq_freeze_queue(q);
>>  	blk_mq_quiesce_queue(q);
>>  
>>  	spin_lock_irq(&ioc->lock);
>> @@ -3663,9 +3671,9 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>>  	spin_unlock_irq(&ioc->lock);
>>  
>>  	blk_mq_unquiesce_queue(q);
>> -	blk_mq_unfreeze_queue(q, memflags);
>>  
>>  close_bdev:
>> +	blk_mq_unfreeze_queue(q, memflags);
>>  	blkg_conf_close_bdev(&ctx);
>>  	return ret ?: nbytes;
>>  }


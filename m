Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095621;
	b=WSa14p6SagJOnTnmX2DsKn4UUh9iqJiRdzf89FsqCfy8+jKA4Sr1GnTM5+vYWKzn4hFA
	 C7k9fHAdo6Z1+H6MZYf6E87x/0D96kTxWd8ZXO1wxSqpkZjKNjdrP3CioEeklRJyJL5ep
	 O0ZeiaJBYM8Gwe4NNpT8Sj1iurALSZt3As0Y8Gm8AB7BuE1lPMTuWopsGPHNC+gnQg97/
	 zsXTXEJ2TheQ+Xv4BeIEwjypaKIFAXTyJ8NUCS4W797w0oINSE4VBN+sPNJW/spJDDh3D
	 QsFjJCFRvldW6oyishi36zeiONjW7EVM6pk10iAUJ4n2xVEbSHhSWVBks034dxvZDoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095621;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gPl5KchtJ7gSYI9BGlQRZWaqJepQuVy2xisNPh0UVQo=;
	b=VCB47UVE1U2nCv4IV0QWCgTdlsEY0V+y4YhvT9hcJo8d/e+7t2Vet3tXgHVkvrRZ6S+T
	 0U0Kn7ViqoO8SvxIuj2NgZW58dWZITifFegoOoEv3JGdifvuvRgXSqOrFUgJO4goQcg1W
	 +ZSeSGCnEeFgwAFJTaf75N4Zxc82NbXp3omcQcIxJIbh5kqRZsNjHiLsmvZYkIldZzto5
	 8P8wUrqYXPghU9Rim8m0X8wIPCLOUS/DHPvhdi1pM27XKKZ9G6mTSlZJOJDnnE9RaqPCK
	 6qD/sDnpqOvY2u5UaKsgGu8Q/wg1ICO5OEtKtJlCjU3JViAiM1+hHKok04cqUNhLGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SydRjGah;
	arc=none smtp.remote-ip=95.215.58.22
Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E0606A338
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 453E0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SydRjGah
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AC3uZA3GEYvvmvMEJuC9OE+1bUyjPme/5LL8+pA6u7c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795095618; v=1; x=1795700418;
 b=SydRjGahMXk8uCrz7q1Dcr7oy5WSFHYTxsMZJ8WUJ9DYaGcDJVSHjmHb3u2lL1bOwAxhjzCR
 3P3tI9Yzs1SD8zL2XDwZ9xpIC3j8juOP2bUtPYFibiP98+aBPBxUoXHvfjEK9JdT8MgR7vSD5Oo
 hJlizGWrKeLKXLjw6mLiUkbU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ec6f0d9818d8147f;
	Thu, 19 Nov 2026 13:40:17 +0000
X-Mizu-Trace-ID: ec6f0d9818d8147f
X-Migadu-Flow: FLOW_OUT
Message-ID: <473ff2e1-329f-49c0-a124-b9e2194d7bcf@linux.dev>
Date: Thu, 19 Nov 2026 21:40:08 +0800
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
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261119070548.3125491-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Guixin,

在 2026/11/19 15:05, Guixin Liu 写道:
> ioc_cost_model_write() freezes the queue while holding rq_qos_mutex,
> which blkg_conf_open_bdev() acquired first. Every other path takes
> rq_qos_mutex only after the queue is frozen: ioc_qos_write() releases
> and re-acquires the mutex around blk_mq_freeze_queue(), and rq_qos_add()
> documents that its caller holds the mutex with the queue frozen.
> Waiting for in-flight IO while holding rq_qos_mutex breaks that rule,
> and on the first write to a queue without iocost the path even calls
> blk_iocost_init() -> rq_qos_add() -> blk_mq_freeze_queue() while
> nothing has frozen the queue yet.
> 
> Mirror the release-freeze-reacquire sequence of ioc_qos_write(). The
> unfreeze moves to the close_bdev label so the error exits after the
> freeze don't leave the queue frozen, and it runs before
> blkg_conf_close_bdev() drops the bdev reference, while the queue is
> still pinned.
>

I tried the same change in cost model write recently and it turned out flawed, these two reviews explain it better than I can [1][2].

In short: the disk_live() check in blkg_conf_open_bdev() only holds while rq_qos_mutex is kept, and dropping it around the freeze lets the disk and the ioc go away; Tejun reproduced a use-after-free that way.

I've been busy with another thread lately, so I'm glad to see you proposing a fix for this. Hope the links help.

Thanks,
Tao

[1] https://lore.kernel.org/all/20261111163306.GA17267@lst.de/
[2] https://lore.kernel.org/all/bfe5007b2758bb06504b6966abaf1f7e@kernel.org/
 
> Fixes: 2b2da2f6dc80 ("blk-iocost: prevent configuration update concurrent with io throttling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  block/blk-iocost.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 1c1025157d8e..8e06b83691aa 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3589,6 +3589,15 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  	ret = blkg_conf_open_bdev(&ctx);
>  	if (ret)
>  		return ret;
> +	/*
> +	 * Nothing is protecting QoS state yet, so release q->rq_qos_mutex,
> +	 * which was first acquired in blkg_conf_open_bdev, and re-acquire it
> +	 * after freezing the queue to maintain the correct locking order.
> +	 */
> +	mutex_unlock(&ctx.bdev->bd_queue->rq_qos_mutex);
> +
> +	memflags = blk_mq_freeze_queue(ctx.bdev->bd_queue);
> +	mutex_lock(&ctx.bdev->bd_queue->rq_qos_mutex);
>  
>  	body = ctx.body;
>  	q = bdev_get_queue(ctx.bdev);
> @@ -3605,7 +3614,6 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  		ioc = q_to_ioc(q);
>  	}
>  
> -	memflags = blk_mq_freeze_queue(q);
>  	blk_mq_quiesce_queue(q);
>  
>  	spin_lock_irq(&ioc->lock);
> @@ -3663,9 +3671,9 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  	spin_unlock_irq(&ioc->lock);
>  
>  	blk_mq_unquiesce_queue(q);
> -	blk_mq_unfreeze_queue(q, memflags);
>  
>  close_bdev:
> +	blk_mq_unfreeze_queue(q, memflags);
>  	blkg_conf_close_bdev(&ctx);
>  	return ret ?: nbytes;
>  }


Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3D1386A4;
	Mon, 20 May 2024 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228725; cv=none; b=qN9qvezMez9CEBrcoRpGiY5z70h58Y9rG0vTi0KtZpQx6GOd1YOo/sLeC/qLPW4xexIJKJBgacn7qWpzulmJ++8INxBX3OeT51w0izKMMJTPv6Gst6VY6UyA93c7s5EUqOaNUJb8UY7eaJKxB9gsrWeYoWu2pxdcCWnWev3VvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228725; c=relaxed/simple;
	bh=iocunVnJ+v8ee9GjUVHVr/9dpb1QjxihA8CLfmO9WYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t1YO79oxCWF9zIWoqb+PZTOKUTyeSRffSKDggHYn/1sivFjeMrhZI7cbfa173RaBg1cCbgQf6UeklJMldZ45TURGIEc6Gu+BrEZIzrg9TRnc6PAdF90dah3xPyECOXVKW9bS1c+78J5c2nDL8P23A7KXxsyz0iWZS1koQbQBT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ucF/DqQv; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ucF/DqQv"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VjlyP5bZdz6Cnk8y;
	Mon, 20 May 2024 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716228715; x=1718820716; bh=vmnp8Xofx7aq1MTYbdJagK+2
	gwvhxTDTz+NZiBzRvgY=; b=ucF/DqQvYsA5WCQX3PdgDO+ASWA5tGo/oNPZc3n4
	s8U8iXYTMosiePtvrF75C0nhoXkvzMvjYdJrTZPPQaGstg10jJlqsK32dExJcGV3
	fYnOEOIhWA0Zc1NerLi2xq4qgNhGq3g3ovsmOx1ez1qdCFA6nNKJuqB5X3Y3PfJm
	muK1EWFbjgbxSbxt7CoGGwFw3L9ejsYRR79GZXZ4ZkBLSNJmXOhQ8Y2AHCR7pRAi
	bjFhx2JQzpELxVowIA5+fwt6FabhjP1ou8HPVXNpmjrIS83j93QrGqxFMoCDlcJx
	/hyKoFS51dSHP8xkv9vtDa0XcHPI6Ox0mrKUnI8P3mznLw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6T2UuOEIh_Tj; Mon, 20 May 2024 18:11:55 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VjlyL3yBmz6Cnk8t;
	Mon, 20 May 2024 18:11:54 +0000 (UTC)
Message-ID: <24d4d60f-05f3-472b-8dfc-4edcb5f7883c@acm.org>
Date: Mon, 20 May 2024 11:11:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] blk-mq: fix potential I/O hang caused by batch wakeup
To: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240520033847.13533-1-yang.yang@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520033847.13533-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/24 20:38, Yang Yang wrote:
> The depth is 62, and the wake_batch is 8. In the following situation,
> the task would hang forever.
> 
>    t1:                 t2:                          t3:
>    blk_mq_get_tag      .                            .
>    io_schedule         .                            .
>                        elevator_switch              .
>                        blk_mq_freeze_queue          .
>                        blk_freeze_queue_start       .
>                        blk_mq_freeze_queue_wait     .
>                                                     blk_mq_submit_bio
>                                                     __bio_queue_enter
> 
> Fix this issue by waking up all the waiters sleeping on tags after
> freezing the queue.

Shouldn't blk_mq_alloc_request() be mentioned in t1 since that is the function
that calls blk_queue_enter()?

> diff --git a/block/blk-core.c b/block/blk-core.c
> index a16b5abdbbf5..e1eacfad6e5b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -298,8 +298,6 @@ void blk_queue_start_drain(struct request_queue *q)
>   	 * prevent I/O from crossing blk_queue_enter().
>   	 */
>   	blk_freeze_queue_start(q);
> -	if (queue_is_mq(q))
> -		blk_mq_wake_waiters(q);
>   	/* Make blk_queue_enter() reexamine the DYING flag. */
>   	wake_up_all(&q->mq_freeze_wq);
>   }

Why has blk_queue_start_drain() been modified? I don't see any reference
in the patch description to blk_queue_start_drain(). Am I perhaps missing
something?

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4ecb9db62337..9eb3139e713a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -125,8 +125,10 @@ void blk_freeze_queue_start(struct request_queue *q)
>   	if (++q->mq_freeze_depth == 1) {
>   		percpu_ref_kill(&q->q_usage_counter);
>   		mutex_unlock(&q->mq_freeze_lock);
> -		if (queue_is_mq(q))
> +		if (queue_is_mq(q)) {
> +			blk_mq_wake_waiters(q);
>   			blk_mq_run_hw_queues(q, false);
> +		}
>   	} else {
>   		mutex_unlock(&q->mq_freeze_lock);
>   	}

Why would the above change be necessary? If the blk_queue_enter() call
by blk_mq_alloc_request() succeeds and blk_mq_get_tag() calls
io_schedule(), io_schedule() will be woken up indirectly by the
blk_mq_run_hw_queues() call because that call will free one of the tags
that the io_schedule() call is waiting for.

Thanks,

Bart.

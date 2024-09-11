Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F941A84
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027031; cv=none; b=tucuYtGG92y3v27pMPdhv3XucfBaSmniz2QX/qhE3DaCk3rjsR+2K3JwgGKBQem1YWgFTMwV3ScQSAo1p0+4dqna7BxgKrsFvjIvrg91PeHBcgIVa2TEU0A1afbKna3bv8uNIIpFelFWPFe8SJeUH9oMIKwQjgWAtbUopUT3l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027031; c=relaxed/simple;
	bh=zeFdqktlH7fQKxhPEIAWDBZu6H66wKxEvAtvkKevV+g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TrwpZMebCn5tmw83Mx1xV2eyQCC7S+KgxL9P5COzcJip7IhmMkrJrExrw7HLlHKu8QIeX+9OmxR6J+BVeZ7UwxK2wYsPFq1jiG+G5MSMNIiWLsTrBxdZEz5J8MtTpZgG37XrewgF7LnpWESPdwf3z13xfY0WOdFbLR9korW1l+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=edRT/toH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="edRT/toH"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726027026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYKnImlZbbB/QOPfzCEtbzjjEkR0UB7l43kna4iaSlk=;
	b=edRT/toH6MRHk2sDggFa5sJjlTvUsbrcszC9TNP803nJPQmzaOtyzWvEypA2X0RuAX2QRZ
	T+IEzsSr1ATAQU+uRNA8F0r9XewK/P464EN8zOz4pf4dl86a2/Hlkdv+5fAAi8workMbVN
	YIcI8TenTk3GAzuQEA5kjq2eI7Ht/g4=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 2/3] block: fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk>
Date: Wed, 11 Sep 2024 11:56:24 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8324A81-86A2-4BC0-8713-602F05B0D11D@linux.dev>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-3-songmuchun@bytedance.com>
 <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Migadu-Flow: FLOW_OUT



> On Sep 10, 2024, at 21:22, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 9/3/24 2:16 AM, Muchun Song wrote:
>> Supposing the following scenario.
>>=20
>> CPU0                                        CPU1
>>=20
>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
>> blk_mq_run_hw_queue()                       =
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)     3) store
>>    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>>        return                                      =
blk_mq_run_hw_queue()
>>    blk_mq_sched_dispatch_requests()                    if =
(!blk_mq_hctx_has_pending())    4) load
>>                                                           return
>>=20
>> The full memory barrier should be inserted between 1) and 2), as well =
as
>> between 3) and 4) to make sure that either CPU0 sees =
QUEUE_FLAG_QUIESCED is
>> cleared or CPU1 sees dispatch list or setting of bitmap of software =
queue.
>> Otherwise, either CPU will not re-run the hardware queue causing =
starvation.
>>=20
>> So the first solution is to 1) add a pair of memory barrier to fix =
the
>> problem, another solution is to 2) use hctx->queue->queue_lock to =
synchronize
>> QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory barrier =
is not
>> easy to be maintained.
>=20
> Same comment here, 72-74 chars wide please.

OK.

>=20
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index b2d0f22de0c7f..ac39f2a346a52 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, unsigned long msecs)
>> }
>> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>>=20
>> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx =
*hctx)
>> +{
>> + 	bool need_run;
>> +
>> + 	/*
>> + 	 * When queue is quiesced, we may be switching io scheduler, or
>> + 	 * updating nr_hw_queues, or other things, and we can't run =
queue
>> + 	 * any more, even blk_mq_hctx_has_pending() can't be called =
safely.
>> + 	 *
>> + 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>> + 	 * quiesced.
>> + 	 */
>> + 	__blk_mq_run_dispatch_ops(hctx->queue, false,
>> + 				  need_run =3D =
!blk_queue_quiesced(hctx->queue) &&
>> + 			      	  blk_mq_hctx_has_pending(hctx));
>> + 	return need_run;
>> +}
>=20
> This __blk_mq_run_dispatch_ops() is also way too wide, why didn't you
> just break it like where you copied it from?

I thought the rule allows max 80 chars pre line, so I adjusted
the code to let them align with the above "(". Seems you prefer
the previous way, I can keep it the same as before.

Muchun,
Thanks.

>=20
>> +
>> /**
>>  * blk_mq_run_hw_queue - Start to run a hardware queue.
>>  * @hctx: Pointer to the hardware queue to run.
>> @@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx =
*hctx, bool async)
>>=20
>> 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
>>=20
>> - 	/*
>> - 	 * When queue is quiesced, we may be switching io scheduler, or
>> - 	 * updating nr_hw_queues, or other things, and we can't run =
queue
>> - 	 * any more, even __blk_mq_hctx_has_pending() can't be called =
safely.
>> - 	 *
>> - 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>> - 	 * quiesced.
>> - 	 */
>> - 	__blk_mq_run_dispatch_ops(hctx->queue, false,
>> - 	need_run =3D !blk_queue_quiesced(hctx->queue) &&
>> - 		blk_mq_hctx_has_pending(hctx));
>> + 		need_run =3D blk_mq_hw_queue_need_run(hctx);
>> + 	if (!need_run) {
>> + 		unsigned long flags;
>>=20
>> - 	if (!need_run)
>> - 		return;
>> + 		/*
>> + 		 * synchronize with blk_mq_unquiesce_queue(), becuase we =
check
>> + 		 * if hw queue is quiesced locklessly above, we need the =
use
>> + 		 * ->queue_lock to make sure we see the up-to-date =
status to
>> + 		 * not miss rerunning the hw queue.
>> + 		 */
>> + 		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
>> + 		need_run =3D blk_mq_hw_queue_need_run(hctx);
>> + 		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
>> +
>> + 		if (!need_run)
>> + 			return;
>> + 	}
>=20
> Is this not solvable on the unquiesce side instead? It's rather a =
shame
> to add overhead to the fast path to avoid a race with something that's
> super unlikely, like quisce.
>=20
> --=20
> Jens Axboe



Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2C126BEF
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122479; cv=none; b=t64PVmzuZV7Qr5wQRu4WdKgtWa9eZKFL+E2LPmY1DAYHTSi2sQKhUtGgnrCYyyDz8Jq4VD1T6EMa6yvEFpw1OFYy5QXNkANIVekEzhLwuaNUKyXPWaXFs7v5Tgq1eV53SDEWPReeO2FGuo0oOfS19FenYAsfEy68Sk2VXmYrvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122479; c=relaxed/simple;
	bh=UV8Al4IwO1DjjFSWj9N7d+uLTFxRD4XctO+ZTJ7KQGQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=smlBaSS1DinYKnmTkZxLye9dVKd3R7FmqxYRDNqke+YIyoy1mprhRgceAvSr6dGYpYl1bQ1YA/tqOJs/DyxwJ52r21bD+MY83L+tyaRIu9rJQ02hqYPfAeiZuGfNeDtTqp6ImuAjy4cDTBsIuqmUmyCp0+bPs1Ne3zqautzb6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxA+cnVi; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxA+cnVi"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726122475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CagaOVU4/v6KyYLVsyXE0t8Mn5rE8zJf2XbJKfyqcyY=;
	b=kxA+cnVi7IYWa82BT3k+L9qX94zY4MZGFYNckWZya0xzMMFdG1D29GcWNj5Lf6zBNuPPQX
	HtdWs5duQxQaG1jAJ/mhiTMxOW131PpbgE3GTpbM0OxkMKjm7a4ARbgYXAjr5SkjgNmEDa
	/Ik7/sD0hkDl3ExLOr4WSaDAuP7al+Q=
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
In-Reply-To: <3D6BB557-E9D1-4421-A541-CA2BF742506C@linux.dev>
Date: Thu, 12 Sep 2024 14:27:25 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <92F2578A-EA56-4904-8E96-DD2BE3B0F875@linux.dev>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-3-songmuchun@bytedance.com>
 <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk> <ZuEUiScRwuXgIrC0@fedora>
 <3D6BB557-E9D1-4421-A541-CA2BF742506C@linux.dev>
To: Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>
X-Migadu-Flow: FLOW_OUT



> On Sep 12, 2024, at 11:27, Muchun Song <muchun.song@linux.dev> wrote:
>=20
>=20
>=20
>> On Sep 11, 2024, at 11:54, Ming Lei <ming.lei@redhat.com> wrote:
>>=20
>> On Tue, Sep 10, 2024 at 07:22:16AM -0600, Jens Axboe wrote:
>>> On 9/3/24 2:16 AM, Muchun Song wrote:
>>>> Supposing the following scenario.
>>>>=20
>>>> CPU0                                        CPU1
>>>>=20
>>>> blk_mq_insert_request()         1) store    =
blk_mq_unquiesce_queue()
>>>> blk_mq_run_hw_queue()                       =
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED) 3) store
>>>>   if (blk_queue_quiesced())   2) load         =
blk_mq_run_hw_queues()
>>>>       return                                      =
blk_mq_run_hw_queue()
>>>>   blk_mq_sched_dispatch_requests()                    if =
(!blk_mq_hctx_has_pending()) 4) load
>>>>                                                          return
>>>>=20
>>>> The full memory barrier should be inserted between 1) and 2), as =
well as
>>>> between 3) and 4) to make sure that either CPU0 sees =
QUEUE_FLAG_QUIESCED is
>>>> cleared or CPU1 sees dispatch list or setting of bitmap of software =
queue.
>>>> Otherwise, either CPU will not re-run the hardware queue causing =
starvation.
>>>>=20
>>>> So the first solution is to 1) add a pair of memory barrier to fix =
the
>>>> problem, another solution is to 2) use hctx->queue->queue_lock to =
synchronize
>>>> QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory =
barrier is not
>>>> easy to be maintained.
>>>=20
>>> Same comment here, 72-74 chars wide please.
>>>=20
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index b2d0f22de0c7f..ac39f2a346a52 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, unsigned long msecs)
>>>> }
>>>> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>>>>=20
>>>> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx =
*hctx)
>>>> +{
>>>> +  	bool need_run;
>>>> +
>>>> +  	/*
>>>> +  	 * When queue is quiesced, we may be switching io =
scheduler, or
>>>> +  	 * updating nr_hw_queues, or other things, and we can't =
run queue
>>>> +  	 * any more, even blk_mq_hctx_has_pending() can't be =
called safely.
>>>> +  	 *
>>>> +  	 * And queue will be rerun in blk_mq_unquiesce_queue() =
if it is
>>>> +  	 * quiesced.
>>>> +  	 */
>>>> +  	__blk_mq_run_dispatch_ops(hctx->queue, false,
>>>> +  	need_run =3D !blk_queue_quiesced(hctx->queue) &&
>>>> +       	blk_mq_hctx_has_pending(hctx));
>>>> +  	return need_run;
>>>> +}
>>>=20
>>> This __blk_mq_run_dispatch_ops() is also way too wide, why didn't =
you
>>> just break it like where you copied it from?
>>>=20
>>>> +
>>>> /**
>>>> * blk_mq_run_hw_queue - Start to run a hardware queue.
>>>> * @hctx: Pointer to the hardware queue to run.
>>>> @@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, bool async)
>>>>=20
>>>> might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
>>>>=20
>>>> -  	/*
>>>> -  	 * When queue is quiesced, we may be switching io =
scheduler, or
>>>> -  	 * updating nr_hw_queues, or other things, and we can't =
run queue
>>>> -  	 * any more, even __blk_mq_hctx_has_pending() can't be =
called safely.
>>>> - 	 *
>>>> -  	 * And queue will be rerun in blk_mq_unquiesce_queue() =
if it is
>>>> - 	 * quiesced.
>>>> -  	 */
>>>> -  	__blk_mq_run_dispatch_ops(hctx->queue, false,
>>>> -  		need_run =3D !blk_queue_quiesced(hctx->queue) &&
>>>> -  		blk_mq_hctx_has_pending(hctx));
>>>> +  	need_run =3D blk_mq_hw_queue_need_run(hctx);
>>>> +  	if (!need_run) {
>>>> +  		unsigned long flags;
>>>>=20
>>>> -  	if (!need_run)
>>>> -  		return;
>>>> +  		/*
>>>> +  		 * synchronize with blk_mq_unquiesce_queue(), =
becuase we check
>>>> +  		 * if hw queue is quiesced locklessly above, we =
need the use
>>>> +  		 * ->queue_lock to make sure we see the =
up-to-date status to
>>>> +  		 * not miss rerunning the hw queue.
>>>> +  		 */
>>>> +  		spin_lock_irqsave(&hctx->queue->queue_lock, =
flags);
>>>> +  		need_run =3D blk_mq_hw_queue_need_run(hctx);
>>>> +  		spin_unlock_irqrestore(&hctx->queue->queue_lock, =
flags);
>>>> +
>>>> +  		if (!need_run)
>>>> +  		return;
>>>> + 	}
>>>=20
>>> Is this not solvable on the unquiesce side instead? It's rather a =
shame
>>> to add overhead to the fast path to avoid a race with something =
that's
>>> super unlikely, like quisce.
>>=20
>> Yeah, it can be solved by adding synchronize_rcu()/srcu() in =
unquiesce
>> side, but SCSI may call it in non-sleepable context via =
scsi_internal_device_unblock_nowait().
>=20
> Hi Ming and Jens,
>=20
> I use call_srcu/call_rcu to make it non-sleepable. Does this make =
sense to you?

Sorry for the noise. call_srcu/call_rcu can't be easy to do this.
Because call_srcu/call_rcu could be issued twice if users try to
unquiesce the queue again before the callback of
blk_mq_run_hw_queues_rcu has been executed.

Thanks.

>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 12bf38bec1044..86cdff28b2ce6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -247,6 +247,13 @@ void blk_mq_quiesce_queue(struct request_queue =
*q)
> }
> EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>=20
> +static void blk_mq_run_hw_queues_rcu(struct rcu_head *rh)
> +{
> +       struct request_queue *q =3D container_of(rh, struct =
request_queue,
> +                                              rcu_head);
> +       blk_mq_run_hw_queues(q, true);
> +}
> +
> /*
>  * blk_mq_unquiesce_queue() - counterpart of blk_mq_quiesce_queue()
>  * @q: request queue.
> @@ -269,8 +276,13 @@ void blk_mq_unquiesce_queue(struct request_queue =
*q)
>        spin_unlock_irqrestore(&q->queue_lock, flags);
>=20
>        /* dispatch requests which are inserted during quiescing */
> -       if (run_queue)
> -               blk_mq_run_hw_queues(q, true);
> +       if (run_queue) {
> +               if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> +                       call_srcu(q->tag_set->srcu, &q->rcu_head,
> +                                 blk_mq_run_hw_queues_rcu);
> +               else
> +                       call_rcu(&q->rcu_head, =
blk_mq_run_hw_queues_rcu);
> +       }
> }
> EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>=20
>>=20
>>=20
>> Thanks,
>> Ming



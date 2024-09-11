Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5A4AEF7
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726032073; cv=none; b=ZCQQjNChHaArG4lp3LdZCAYDtKH88eup4UAXNUbDwG1TJm7teLlp2TI57/dYIATAm8TUvyvvNsLr2KR4jAJe7xM7+SaumjM8TlCHAUhcmdD1y/gBHTBTnKtxLd9ka4YLFXVPxG419YAjVw2PMckTr+r30pPOpOZz9hGfkCMYqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726032073; c=relaxed/simple;
	bh=HJlpz8eduYiyw8yyvJNhR+nu02+JfJVfh/68TFMzlPg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cD91Z1wWLGCaBCR1JMBzW5EM5ZpqA50NTl4kSaOBeaElR7c127vy22BmtFlxxZ48trJXZlCW8/9kYE38/JmwqCzh+qqCx+uVxeiFxG4YsNrYiLPdXjCMGnSaQ+eb/bXjlmMAyV2bhG0HvlDAHhxxZn9InVirQyBQXm2M68ae+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/6TrfyO; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/6TrfyO"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726032068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IbthqVd0Y1HGEHfUp7IhQWZyBV6AeAPAti9kFjOXTU=;
	b=p/6TrfyOdz5bPa6WQHxmu5CrSrzWuD58AHrK4GL6TaXF7zIyNDidvBfFMjFvw0fjEMFWbB
	5D/70SbNDh5UHHQPaylSqV8cjcePsGHKqrL5P/jcn7NB2rinYtC5tzXKRKO7xUY764X/Te
	dYyL4fjw/KvIp2itN9TmQHps3CDGE8Q=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/3] block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests
Date: Wed, 11 Sep 2024 13:20:28 +0800
Message-Id: <12E43452-371C-495D-B06A-DC2DA92CE0E8@linux.dev>
References: <AA8B604C-4CE6-435F-8D95-1E6B88EB2B68@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Muchun Song <songmuchun@bytedance.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
In-Reply-To: <AA8B604C-4CE6-435F-8D95-1E6B88EB2B68@linux.dev>
To: Ming Lei <ming.lei@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 11, 2024, at 11:59, Muchun Song <muchun.song@linux.dev> wrote:
>=20
> =EF=BB=BF
>=20
>> On Sep 11, 2024, at 11:54, Ming Lei <ming.lei@redhat.com> wrote:
>>=20
>>> On Tue, Sep 10, 2024 at 07:22:16AM -0600, Jens Axboe wrote:
>>> On 9/3/24 2:16 AM, Muchun Song wrote:
>>>> Supposing the following scenario.
>>>>=20
>>>> CPU0                                        CPU1
>>>>=20
>>>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
>>>> blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEUE_=
FLAG_QUIESCED)   3) store
>>>>   if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>>>>       return                                      blk_mq_run_hw_queue()=

>>>>   blk_mq_sched_dispatch_requests()                    if (!blk_mq_hctx_=
has_pending()) 4) load
>>>>                                                          return
>>>>=20
>>>> The full memory barrier should be inserted between 1) and 2), as well a=
s
>>>> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCE=
D is
>>>> cleared or CPU1 sees dispatch list or setting of bitmap of software que=
ue.
>>>> Otherwise, either CPU will not re-run the hardware queue causing starva=
tion.
>>>>=20
>>>> So the first solution is to 1) add a pair of memory barrier to fix the
>>>> problem, another solution is to 2) use hctx->queue->queue_lock to synch=
ronize
>>>> QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory barrier i=
s not
>>>> easy to be maintained.
>>>=20
>>> Same comment here, 72-74 chars wide please.
>>>=20
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index b2d0f22de0c7f..ac39f2a346a52 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_=
ctx *hctx, unsigned long msecs)
>>>> }
>>>> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>>>>=20
>>>> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx=
)
>>>> +{
>>>> +    bool need_run;
>>>> +
>>>> +    /*
>>>> +     * When queue is quiesced, we may be switching io scheduler, or
>>>> +     * updating nr_hw_queues, or other things, and we can't run queue
>>>> +     * any more, even blk_mq_hctx_has_pending() can't be called safely=
.
>>>> +     *
>>>> +     * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>>>> +     * quiesced.
>>>> +     */
>>>> +    __blk_mq_run_dispatch_ops(hctx->queue, false,
>>>> +                  need_run =3D !blk_queue_quiesced(hctx->queue) &&
>>>> +                  blk_mq_hctx_has_pending(hctx));
>>>> +    return need_run;
>>>> +}
>>>=20
>>> This __blk_mq_run_dispatch_ops() is also way too wide, why didn't you
>>> just break it like where you copied it from?
>>>=20
>>>> +
>>>> /**
>>>> * blk_mq_run_hw_queue - Start to run a hardware queue.
>>>> * @hctx: Pointer to the hardware queue to run.
>>>> @@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *=
hctx, bool async)
>>>>=20
>>>> might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
>>>>=20
>>>> -    /*
>>>> -     * When queue is quiesced, we may be switching io scheduler, or
>>>> -     * updating nr_hw_queues, or other things, and we can't run queue
>>>> -     * any more, even __blk_mq_hctx_has_pending() can't be called safe=
ly.
>>>> -     *
>>>> -     * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>>>> -     * quiesced.
>>>> -     */
>>>> -    __blk_mq_run_dispatch_ops(hctx->queue, false,
>>>> -        need_run =3D !blk_queue_quiesced(hctx->queue) &&
>>>> -        blk_mq_hctx_has_pending(hctx));
>>>> +    need_run =3D blk_mq_hw_queue_need_run(hctx);
>>>> +    if (!need_run) {
>>>> +        unsigned long flags;
>>>>=20
>>>> -    if (!need_run)
>>>> -        return;
>>>> +    /*
>>>> +     * synchronize with blk_mq_unquiesce_queue(), becuase we check
>>>> +     * if hw queue is quiesced locklessly above, we need the use
>>>> +     * ->queue_lock to make sure we see the up-to-date status to
>>>> +     * not miss rerunning the hw queue.
>>>> +     */
>>>> +    spin_lock_irqsave(&hctx->queue->queue_lock, flags);
>>>> +    need_run =3D blk_mq_hw_queue_need_run(hctx);
>>>> +    spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
>>>> +
>>>> +    if (!need_run)
>>>> +        return;
>>>> +    }
>>>=20
>>> Is this not solvable on the unquiesce side instead? It's rather a shame
>>> to add overhead to the fast path to avoid a race with something that's
>>> super unlikely, like quisce.
>>=20
>> Yeah, it can be solved by adding synchronize_rcu()/srcu() in unquiesce
>> side, but SCSI may call it in non-sleepable context via scsi_internal_dev=
ice_unblock_nowait().
>=20
> Another approach will be like the fix for BLK_MQ_S_STOPPED (in patch 3),
> we could add a pair of mb into blk_queue_quiesced() and
> blk_mq_unquiesce_queue(). In which case, the fix will not affect any fast
> path, only slow path need the barrier overhead.

I misunderstood Jens=E2=80=99s question. I think Ming is right.
This approach only tries to reduce the overhead as=20
much
as possible even for slow path compared to=20
spinlock_based approach.=20
Not solving the problem only from the unquiesce side.

Muchun,
Thanks.

>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b2d0f22de0c7f..45588ddb08d6b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -264,6 +264,12 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>                ;
>        } else if (!--q->quiesce_depth) {
>                blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> +               /*
> +                * Pairs with the smp_mb() in blk_queue_quiesced() to orde=
r the
> +                * clearing of QUEUE_FLAG_QUIESCED above and the checking o=
f
> +                * dispatch list in the subsequent routine.
> +                */
> +               smp_mb__after_atomic();
>                run_queue =3D true;
>        }
>        spin_unlock_irqrestore(&q->queue_lock, flags);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b8196e219ac22..7a71462892b66 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -628,7 +628,25 @@ void blk_queue_flag_clear(unsigned int flag, struct r=
equest_queue *q);
> #define blk_noretry_request(rq) \
>        ((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
>                             REQ_FAILFAST_DRIVER))
> -#define blk_queue_quiesced(q)  test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_=
flags)
> +
> +static inline bool blk_queue_quiesced(struct request_queue *q)
> +{
> +       /* Fast path: hardware queue is unquiesced most of the time. */
> +       if (likely(!test_bit(QUEUE_FLAG_QUIESCED, &q->queue_flags)))
> +               return false;
> +
> +       /*
> +        * This barrier is used to order adding of dispatch list before an=
d
> +        * the test of QUEUE_FLAG_QUIESCED below. Pairs with the memory ba=
rrier
> +        * in blk_mq_unquiesce_queue() so that dispatch code could either s=
ee
> +        * QUEUE_FLAG_QUIESCED is cleared or dispatch list is not  empty t=
o
> +        * avoid missing dispatching requests.
> +        */
> +       smp_mb();
> +
> +       return test_bit(QUEUE_FLAG_QUIESCED, &q->queue_flags);
> +}
> +
> #define blk_queue_pm_only(q)   atomic_read(&(q)->pm_only)
> #define blk_queue_registered(q)        test_bit(QUEUE_FLAG_REGISTERED, &(q=
)->queue_flags)
> #define blk_queue_sq_sched(q)  test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_f=
lags)
>=20
> Muchun,
> Thanks.
>=20
>>=20
>>=20
>> Thanks,
>> Ming
>=20
>=20

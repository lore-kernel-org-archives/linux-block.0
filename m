Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8B40858
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027193; cv=none; b=TOvRp4f4pWuyfB5qe1113yoLrMwocItL7bhfydLQquH7Nv/LrwQbVjHOtSGYggYv2P5d0rctIzKP6dSYtUGgCLN26f6BWhAW2P6IZZb7Phl1CEo/FSauVzLUaGWRxGVhDN3Rr0wrHoWUkF7VRUVfpf5MU6oJ6RNu8jJZOLazazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027193; c=relaxed/simple;
	bh=BkyVuy1DMd0+0Cu+W+kguPMC7bkjS+tU1h91mwd6p6c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q88PhB/BSo5mUhJO3KZs7E0PqAJ+9vPsJ/yX5ot80yBbv44go3tyP/hS/cdKVLmPkQ04b6GDuf+VwUSL5SnY8Y3Tv3Gb6phyJP7kvoWdHIDg/wxoFujiLGGWJMqC+wGMECiQqhs+U5TZLMd+8ECXf4S1oA3WS0HATnj2U2BLQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KpDu5ZV9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KpDu5ZV9"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726027188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVMSz+tjhgWrKdhLZpdeKygpDaIpjPruMKweWTEuyWk=;
	b=KpDu5ZV9l3F7vfbVU9PxqXAgjsTcEso1SQXpi9ySPHEZk4QAUb8LLDkBSO5O9G+0eZFNcg
	WIScGNeBNOrsm+pYEAVKClfa4OHD8YO2EU/kc/D8muV8YfwVQOU5YGAenA2iut1VDQ2zYz
	ADusUoZz62W4mDxWKScOcp/CBv4RwAg=
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
In-Reply-To: <ZuEUiScRwuXgIrC0@fedora>
Date: Wed, 11 Sep 2024 11:59:08 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Muchun Song <songmuchun@bytedance.com>,
 Yu Kuai <yukuai1@huaweicloud.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA8B604C-4CE6-435F-8D95-1E6B88EB2B68@linux.dev>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-3-songmuchun@bytedance.com>
 <91ce06c7-6965-4d1d-8ed4-d0a6f01acecf@kernel.dk> <ZuEUiScRwuXgIrC0@fedora>
To: Ming Lei <ming.lei@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 11, 2024, at 11:54, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Tue, Sep 10, 2024 at 07:22:16AM -0600, Jens Axboe wrote:
>> On 9/3/24 2:16 AM, Muchun Song wrote:
>>> Supposing the following scenario.
>>>=20
>>> CPU0                                        CPU1
>>>=20
>>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
>>> blk_mq_run_hw_queue()                       =
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
>>>    if (blk_queue_quiesced())   2) load         =
blk_mq_run_hw_queues()
>>>        return                                      =
blk_mq_run_hw_queue()
>>>    blk_mq_sched_dispatch_requests()                    if =
(!blk_mq_hctx_has_pending()) 4) load
>>>                                                           return
>>>=20
>>> The full memory barrier should be inserted between 1) and 2), as =
well as
>>> between 3) and 4) to make sure that either CPU0 sees =
QUEUE_FLAG_QUIESCED is
>>> cleared or CPU1 sees dispatch list or setting of bitmap of software =
queue.
>>> Otherwise, either CPU will not re-run the hardware queue causing =
starvation.
>>>=20
>>> So the first solution is to 1) add a pair of memory barrier to fix =
the
>>> problem, another solution is to 2) use hctx->queue->queue_lock to =
synchronize
>>> QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory =
barrier is not
>>> easy to be maintained.
>>=20
>> Same comment here, 72-74 chars wide please.
>>=20
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index b2d0f22de0c7f..ac39f2a346a52 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, unsigned long msecs)
>>> }
>>> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>>>=20
>>> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx =
*hctx)
>>> +{
>>> + 	bool need_run;
>>> +
>>> + 	/*
>>> + 	 * When queue is quiesced, we may be switching io scheduler, or
>>> + 	 * updating nr_hw_queues, or other things, and we can't run =
queue
>>> + 	 * any more, even blk_mq_hctx_has_pending() can't be called =
safely.
>>> + 	 *
>>> + 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>>> + 	 * quiesced.
>>> + 	 */
>>> + 	__blk_mq_run_dispatch_ops(hctx->queue, false,
>>> +				  need_run =3D =
!blk_queue_quiesced(hctx->queue) &&
>>> + 				  blk_mq_hctx_has_pending(hctx));
>>> + 	return need_run;
>>> +}
>>=20
>> This __blk_mq_run_dispatch_ops() is also way too wide, why didn't you
>> just break it like where you copied it from?
>>=20
>>> +
>>> /**
>>>  * blk_mq_run_hw_queue - Start to run a hardware queue.
>>>  * @hctx: Pointer to the hardware queue to run.
>>> @@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, bool async)
>>>=20
>>> might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
>>>=20
>>> - 	/*
>>> - 	 * When queue is quiesced, we may be switching io scheduler, or
>>> - 	 * updating nr_hw_queues, or other things, and we can't run =
queue
>>> - 	 * any more, even __blk_mq_hctx_has_pending() can't be called =
safely.
>>> - 	 *
>>> - 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>>> - 	 * quiesced.
>>> - 	 */
>>> - 	__blk_mq_run_dispatch_ops(hctx->queue, false,
>>> - 		need_run =3D !blk_queue_quiesced(hctx->queue) &&
>>> - 		blk_mq_hctx_has_pending(hctx));
>>> + 	need_run =3D blk_mq_hw_queue_need_run(hctx);
>>> + 	if (!need_run) {
>>> + 		unsigned long flags;
>>>=20
>>> - 	if (!need_run)
>>> - 		return;
>>> + 	/*
>>> + 	 * synchronize with blk_mq_unquiesce_queue(), becuase we check
>>> + 	 * if hw queue is quiesced locklessly above, we need the use
>>> + 	 * ->queue_lock to make sure we see the up-to-date status to
>>> + 	 * not miss rerunning the hw queue.
>>> + 	 */
>>> + 	spin_lock_irqsave(&hctx->queue->queue_lock, flags);
>>> + 	need_run =3D blk_mq_hw_queue_need_run(hctx);
>>> + 	spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
>>> +
>>> + 	if (!need_run)
>>> + 		return;
>>> + 	}
>>=20
>> Is this not solvable on the unquiesce side instead? It's rather a =
shame
>> to add overhead to the fast path to avoid a race with something =
that's
>> super unlikely, like quisce.
>=20
> Yeah, it can be solved by adding synchronize_rcu()/srcu() in unquiesce
> side, but SCSI may call it in non-sleepable context via =
scsi_internal_device_unblock_nowait().

Another approach will be like the fix for BLK_MQ_S_STOPPED (in patch 3),
we could add a pair of mb into blk_queue_quiesced() and
blk_mq_unquiesce_queue(). In which case, the fix will not affect any =
fast
path, only slow path need the barrier overhead.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2d0f22de0c7f..45588ddb08d6b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -264,6 +264,12 @@ void blk_mq_unquiesce_queue(struct request_queue =
*q)
                ;
        } else if (!--q->quiesce_depth) {
                blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+               /*
+                * Pairs with the smp_mb() in blk_queue_quiesced() to =
order the
+                * clearing of QUEUE_FLAG_QUIESCED above and the =
checking of
+                * dispatch list in the subsequent routine.
+                */
+               smp_mb__after_atomic();
                run_queue =3D true;
        }
        spin_unlock_irqrestore(&q->queue_lock, flags);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b8196e219ac22..7a71462892b66 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -628,7 +628,25 @@ void blk_queue_flag_clear(unsigned int flag, struct =
request_queue *q);
 #define blk_noretry_request(rq) \
        ((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
                             REQ_FAILFAST_DRIVER))
-#define blk_queue_quiesced(q)  test_bit(QUEUE_FLAG_QUIESCED, =
&(q)->queue_flags)
+
+static inline bool blk_queue_quiesced(struct request_queue *q)
+{
+       /* Fast path: hardware queue is unquiesced most of the time. */
+       if (likely(!test_bit(QUEUE_FLAG_QUIESCED, &q->queue_flags)))
+               return false;
+
+       /*
+        * This barrier is used to order adding of dispatch list before =
and
+        * the test of QUEUE_FLAG_QUIESCED below. Pairs with the memory =
barrier
+        * in blk_mq_unquiesce_queue() so that dispatch code could =
either see
+        * QUEUE_FLAG_QUIESCED is cleared or dispatch list is not  empty =
to
+        * avoid missing dispatching requests.
+        */
+       smp_mb();
+
+       return test_bit(QUEUE_FLAG_QUIESCED, &q->queue_flags);
+}
+
 #define blk_queue_pm_only(q)   atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)        test_bit(QUEUE_FLAG_REGISTERED, =
&(q)->queue_flags)
 #define blk_queue_sq_sched(q)  test_bit(QUEUE_FLAG_SQ_SCHED, =
&(q)->queue_flags)

Muchun,
Thanks.

>=20
>=20
> Thanks,
> Ming



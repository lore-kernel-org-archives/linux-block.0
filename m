Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F173B295
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902889; cv=none; b=CSGXnDywfzXD8T5ejYZGHh2lXki7U/KqXQnkAlmHy5KuL5JWZNbl3tqpQ15Pn9nncJUGQXjfZhT2lxOLQTTZ4pEMKgKFf4cVp6EXRtrpOAAY7vpS4RvTw8Vick0QVBHmjP9V12LiZpOGbE7X9IKB75GR9w2Kb3Uc6MR7Q4og2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902889; c=relaxed/simple;
	bh=wIrIsLTLZ1XDvBcMBmE4ZLcmFnvgNL1uskhsI9hwViU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Vhy0B4NQICBrHYFn/7rBgtnWDhjKXciv/csN+Hf2/l1owcupUvGfiWp8nIdeXZHdNEGfT7Aq1+vhrRhkeo/NftP+AoWUiP+MtN7BcjJ6L6YW8YFC7cIQNbP8J9I71IVqK4fz/Uiwi8oWa2NN+P9Opk6lhPMpoYB33dxtubx2HBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WTWJcT1L; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WTWJcT1L"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724902885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzK+RLaMMU9MnsEr4uXkSXswp6Kv6SSXBnbWQHGYAFc=;
	b=WTWJcT1L/o4XAwYEG2y1T32mcN4p6ib5IiCU/EMymMqRoEtU5nfGGQH+A52Et1YlzvPXvj
	rsK14Z5Eh5vaoZceuBA2Az9yENw+YLzXSQi1T0Resp2ZzmInqLM3Knp1QS/N9Ga797CDIP
	sf0NKsmAH8wEUkyiNQe2tZq01/bzjjo=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAFj5m9KmQZM8+nMORaQOJC-tzM0AOMz+kUyDa1r8V0NTcOVXtg@mail.gmail.com>
Date: Thu, 29 Aug 2024 11:40:50 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88D82529-3D30-401A-B94B-7E8964D51AF0@linux.dev>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com> <ZshyPVEc9w4sqXJy@fedora>
 <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
 <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev> <ZsxI6uCbGpQh1XrF@fedora>
 <1929CA74-3770-4B5D-B0A5-759911E97815@linux.dev>
 <D53C1E55-80A4-4F71-B93D-D357F424D2FF@linux.dev>
 <CAFj5m9KmQZM8+nMORaQOJC-tzM0AOMz+kUyDa1r8V0NTcOVXtg@mail.gmail.com>
To: Ming Lei <ming.lei@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 29, 2024, at 10:51, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Tue, Aug 27, 2024 at 4:17=E2=80=AFPM Muchun Song =
<muchun.song@linux.dev> wrote:
>>=20
>>=20
>>=20
>>> On Aug 27, 2024, at 15:24, Muchun Song <muchun.song@linux.dev> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On Aug 26, 2024, at 17:20, Ming Lei <ming.lei@redhat.com> wrote:
>>>>=20
>>>> On Mon, Aug 26, 2024 at 03:33:18PM +0800, Muchun Song wrote:
>>>>>=20
>>>>>=20
>>>>>> On Aug 26, 2024, at 15:06, Muchun Song <songmuchun@bytedance.com> =
wrote:
>>>>>>=20
>>>>>> On Fri, Aug 23, 2024 at 7:28=E2=80=AFPM Ming Lei =
<ming.lei@redhat.com> wrote:
>>>>>>>=20
>>>>>>> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
>>>>>>>> Supposing the following scenario.
>>>>>>>>=20
>>>>>>>> CPU0                                                            =
    CPU1
>>>>>>>>=20
>>>>>>>> blk_mq_request_issue_directly()                                 =
    blk_mq_unquiesce_queue()
>>>>>>>> if (blk_queue_quiesced())                                       =
    blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
>>>>>>>>     blk_mq_insert_request()                                     =
    blk_mq_run_hw_queues()
>>>>>>>>         /*                                                      =
        blk_mq_run_hw_queue()
>>>>>>>>          * Add request to dispatch list or set bitmap of        =
            if (!blk_mq_hctx_has_pending())     4) load
>>>>>>>>          * software queue.                  1) store            =
                return
>>>>>>>>          */
>>>>>>>>     blk_mq_run_hw_queue()
>>>>>>>>         if (blk_queue_quiesced())           2) load
>>>>>>>>             return
>>>>>>>>         blk_mq_sched_dispatch_requests()
>>>>>>>>=20
>>>>>>>> The full memory barrier should be inserted between 1) and 2), =
as well as
>>>>>>>> between 3) and 4) to make sure that either CPU0 sees =
QUEUE_FLAG_QUIESCED is
>>>>>>>> cleared or CPU1 sees dispatch list or setting of bitmap of =
software queue.
>>>>>>>> Otherwise, either CPU will not re-run the hardware queue =
causing starvation.
>>>>>>>=20
>>>>>>> Memory barrier shouldn't serve as bug fix for two slow code =
paths.
>>>>>>>=20
>>>>>>> One simple fix is to add helper of blk_queue_quiesced_lock(), =
and
>>>>>>> call the following check on CPU0:
>>>>>>>=20
>>>>>>>     if (blk_queue_quiesced_lock())
>>>>>>>      blk_mq_run_hw_queue();
>>>>>>=20
>>>>>> This only fixes blk_mq_request_issue_directly(), I think anywhere =
that
>>>>>> matching this
>>>>>> pattern (inserting a request to dispatch list and then running =
the
>>>>>> hardware queue)
>>>>>> should be fixed. And I think there are many places which match =
this
>>>>>> pattern (E.g.
>>>>>> blk_mq_submit_bio()). The above graph should be adjusted to the =
following.
>>>>>>=20
>>>>>> CPU0                                        CPU1
>>>>>>=20
>>>>>> blk_mq_insert_request()         1) store    =
blk_mq_unquiesce_queue()
>>>>>> blk_mq_run_hw_queue()
>>>>>> blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>>>>>> if (blk_queue_quiesced())   2) load         =
blk_mq_run_hw_queues()
>>>>>>     return                                      =
blk_mq_run_hw_queue()
>>>>>> blk_mq_sched_dispatch_requests()                    if
>>>>>> (!blk_mq_hctx_has_pending())     4) load
>>>>>>                                                         return
>>>>>=20
>>>>> Sorry. There is something wrong with my email client. Resend the =
graph.
>>>>>=20
>>>>> CPU0                                        CPU1
>>>>>=20
>>>>> blk_mq_insert_request()         1) store    =
blk_mq_unquiesce_queue()
>>>>> blk_mq_run_hw_queue()                       =
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>>>>>  if (blk_queue_quiesced())   2) load         =
blk_mq_run_hw_queues()
>>>>>      return                                      =
blk_mq_run_hw_queue()
>>>>>  blk_mq_sched_dispatch_requests()                    if =
(!blk_mq_hctx_has_pending())     4) load
>>>>>                                                          return
>>>>=20
>>>> OK.
>>>>=20
>>>> The issue shouldn't exist if blk_queue_quiesced() return false in
>>>> blk_mq_run_hw_queue(), so it is still one race in two slow paths?
>>>>=20
>>>> I guess the barrier-less approach should work too, such as:
>>>>=20
>>>=20
>>> If we prefer barrier-less approach, I think the following solution
>>> will work as well, I'll use it in v2. Thanks.
>>>=20
>>>>=20
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index e3c3c0c21b55..632261982a77 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -2202,6 +2202,12 @@ void blk_mq_delay_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, unsigned long msecs)
>>>> }
>>>> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>>>>=20
>>>> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx =
*hctx)
>>>> +{
>>>> +    return !blk_queue_quiesced(hctx->queue) &&
>>>> +            blk_mq_hctx_has_pending(hctx);
>>>> +}
>>>> +
>>>> /**
>>>> * blk_mq_run_hw_queue - Start to run a hardware queue.
>>>> * @hctx: Pointer to the hardware queue to run.
>>>> @@ -2231,11 +2237,19 @@ void blk_mq_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, bool async)
>>>> * quiesced.
>>>> */
>>>>     __blk_mq_run_dispatch_ops(hctx->queue, false,
>>>> -            need_run =3D !blk_queue_quiesced(hctx->queue) &&
>>>> -            blk_mq_hctx_has_pending(hctx));
>>>> +            need_run =3D blk_mq_hw_queue_need_run(hctx));
>>>>=20
>>>> -    if (!need_run)
>>>> -            return;
>>>> +    if (!need_run) {
>>>> +            unsigned long flags;
>>>> +
>>>> +            /* sync with unquiesce */
>>>> +            spin_lock_irqsave(&hctx->queue->queue_lock, flags);
>>=20
>> After some time thought, I think here we need a big comment to =
explain
>> why we need to sync. Because there are other caller of =
blk_queue_quiesced()
>> which do not need to hold ->queue_lock to sync. Then, I am thinking
>> is ->queue_lock really easier to be maintained than mb? For =
developers,
>> we still need to care about this, right? I don't see any obvious =
benefit.
>> And the mb approach seems more efficient than spinlock. Something =
like:
>>=20
>>        if (!need_run) {
>>                /* Add a comment here to explain what's going on here. =
*/
>>                smp_mb();
>>                need_run =3D blk_mq_hw_queue_need_run(hctx);
>>                if (!need_run)
>>                        return;
>>        }
>>=20
>> I am not objecting to your approach, I want to know if you insist on
>> barrier-less approach here. If yes, I'm fine with this approach. I =
can
>> use it in v2.
>=20
> Yes, as I mentioned, the race only exists on two slow code paths,
> we seldom use barrier in slow paths, in which traditional lock
> can provide a simpler & more readable solution.  Anytime,
> READ/WRITE dependency implied in any barrier is hard to follow.

Got it. Thanks for your reply.

>=20
> Thanks,



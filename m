Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B56C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758E264E6C
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 17:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBIRJy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhBIRJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 12:09:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B974C06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Feb 2021 09:09:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y134so4206680wmd.3
        for <linux-block@vger.kernel.org>; Tue, 09 Feb 2021 09:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aBr6GX1t0DbmGYQZj2syOaC1BHRtQOb9QGFOfiYgdH8=;
        b=ISPpCRB/6jZK4VEFzmu4LYNCM8oElLCoED1ifm5BeidAZ3iHEcbh5u/3WdBjx238Ij
         xGC420j4RVg+hh+jBaq6OcJ4lTJxx7BTBfh+cC1fVxGFmBLilXh9qMgH+km0JPcWZLjk
         JThVBhz5Ex6XdyKLMTpEA3rJILZAN25norm1wzQBc0CmSBqCWd9YR2sa/IQEmAZm+RC+
         svQvw70u/rcpZJ+4rX2LMioOZWfXe6uyAnBvZM0nOjwkrnA5sDEFz5rJ3hyy7NE/JKTj
         8+GfNsXJzT2u8LvXhh20k6Wi9MSZeBY7EO0HjQXmEnoJ+XHZ3183JIsAA9gI0DJs0CiM
         vOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aBr6GX1t0DbmGYQZj2syOaC1BHRtQOb9QGFOfiYgdH8=;
        b=s+oHWj5j7+OolhmT0X9b6hUuWNVA/4l3LSbHmHiVyoRBfj1kZmo9xPUAM6ccBy801K
         5VuYVIzQptzTJNCBZSM2dHk/o9c7yjdz2xiQvjSBFXsWzOYclrYH+wO5IHVFuvukMYeQ
         N04IXGfmgj0x3zBuG5lcD9AsroCBSMAtd06CtmFbykwbT4JzYhaI3F1zE9CJumf7vOfy
         bzlI2OeHNHUP6a1m6oAD7B77uP6JrQEj3o82NwiqmLRtJs2KoqFeUpvefQtLaDRb9fsT
         b8uXSF8xqypWrwmgfg4bi0Ll1x4QoZ9BSVW/YeURqWt3V8yQqghXu0KXd3HXJ1x7FAzL
         7drA==
X-Gm-Message-State: AOAM5325nSSfbM1+Rdy6a6+6Idg6jYloPAQcMoIuNL2LiZQIoVr1QgOD
        LPz1Dg1w59H7ERfRjoZlpOr8P4o3z5UxjQ==
X-Google-Smtp-Source: ABdhPJyUxBmLda1bBgmGP+hu0dVi16wc0ximZhHq7xJR1YgaTGCoYva4X2/n1v9KFJJ7DZNqqQ7TYQ==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr4364732wmb.155.1612890546672;
        Tue, 09 Feb 2021 09:09:06 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id g15sm19198482wrx.1.2021.02.09.09.09.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 09:09:05 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and
 woken in dispatch list
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <EC22F02F-B215-4836-88F5-207FDFDED56B@linaro.org>
Date:   Tue, 9 Feb 2021 18:09:13 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEFA776D-8A50-4DDF-B5C5-025A644FDF88@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-3-paolo.valente@linaro.org>
 <36ecc71d-ef51-c667-74f8-d8f289e2f7db@kernel.dk>
 <A5A6D401-D774-4D9E-A68B-08D46368653E@linaro.org>
 <20210203114308.GB7094@quack2.suse.cz>
 <EC22F02F-B215-4836-88F5-207FDFDED56B@linaro.org>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 5 feb 2021, alle ore 11:16, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 3 feb 2021, alle ore 12:43, Jan Kara <jack@suse.cz> ha =
scritto:
>>=20
>> On Thu 28-01-21 18:54:05, Paolo Valente wrote:
>>>=20
>>>=20
>>>> Il giorno 26 gen 2021, alle ore 17:18, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>>=20
>>>> On 1/26/21 3:50 AM, Paolo Valente wrote:
>>>>> Consider a new I/O request that arrives for a bfq_queue bfqq. If, =
when
>>>>> this happens, the only active bfq_queues are bfqq and either its =
waker
>>>>> bfq_queue or one of its woken bfq_queues, then there is no point =
in
>>>>> queueing this new I/O request in bfqq for service. In fact, the
>>>>> in-service queue and bfqq agree on serving this new I/O request as
>>>>> soon as possible. So this commit puts this new I/O request =
directly
>>>>> into the dispatch list.
>>>>>=20
>>>>> Tested-by: Jan Kara <jack@suse.cz>
>>>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>>>> ---
>>>>> block/bfq-iosched.c | 17 ++++++++++++++++-
>>>>> 1 file changed, 16 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>> index a83149407336..e5b83910fbe0 100644
>>>>> --- a/block/bfq-iosched.c
>>>>> +++ b/block/bfq-iosched.c
>>>>> @@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>>>>=20
>>>>> 	spin_lock_irq(&bfqd->lock);
>>>>> 	bfqq =3D bfq_init_rq(rq);
>>>>> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>>>>> +
>>>>> +	/*
>>>>> +	 * Additional case for putting rq directly into the dispatch
>>>>> +	 * queue: the only active bfq_queues are bfqq and either its
>>>>> +	 * waker bfq_queue or one of its woken bfq_queues. In this
>>>>> +	 * case, there is no point in queueing rq in bfqq for
>>>>> +	 * service. In fact, the in-service queue and bfqq agree on
>>>>> +	 * serving this new I/O request as soon as possible.
>>>>> +	 */
>>>>> +	if (!bfqq ||
>>>>> +	    (bfqq !=3D bfqd->in_service_queue &&
>>>>> +	     bfqd->in_service_queue !=3D NULL &&
>>>>> +	     bfq_tot_busy_queues(bfqd) =3D=3D 1 + bfq_bfqq_busy(bfqq) &&
>>>>> +	     (bfqq->waker_bfqq =3D=3D bfqd->in_service_queue ||
>>>>> +	      bfqd->in_service_queue->waker_bfqq =3D=3D bfqq)) ||
>>>>> +	    at_head || blk_rq_is_passthrough(rq)) {
>>>>> 		if (at_head)
>>>>> 			list_add(&rq->queuelist, &bfqd->dispatch);
>>>>> 		else
>>>>>=20
>>>>=20
>>>> This is unreadable... Just seems like you are piling heuristics in =
to
>>>> catch some case, and it's neither readable nor clean.
>>>>=20
>>>=20
>>> Yeah, these comments inappropriately assume that the reader knows =
the
>>> waker mechanism in depth.  And they do not stress at all how =
important
>>> this improvement is.
>>>=20
>>> I'll do my best to improve these comments.
>>>=20
>>> To try to do a better job, let me also explain the matter early =
here.
>>> Maybe you or others can give me some early feedback (or just tell me
>>> to proceed).
>>>=20
>>> This change is one of the main improvements that boosted
>>> throughput in Jan's tests.  Here is the rationale:
>>> - consider a bfq_queue, say Q1, detected as a waker of another
>>> bfq_queue, say Q2
>>> - by definition of a waker, Q1 blocks the I/O of Q2, i.e., some I/O =
of
>>> of Q1 needs to be completed for new I/O of Q1 to arrive.  A notable
>> 					       ^^ Q2?
>>=20
>=20
> Yes, thank you!
>=20
> (after this interaction, I'll fix and improve all this description,
> according to your comments)
>=20
>>> example is journald
>>> - so, Q1 and Q2 are in any respect two cooperating processes: if the
>>> service of Q1's I/O is delayed, Q2 can only suffer from it.
>>> Conversely, if Q2's I/O is delayed, the purpose of Q1 is just =
defeated.
>>=20
>> What do you exactly mean by this last sentence?
>=20
> By definition of waker, the purpose of Q1's I/O is doing what needs to
> be done, so that new Q2's I/O can finally be issued.  Delaying Q2's =
I/O
> is the opposite of this goal.
>=20
>>=20
>>> - as a consequence if some I/O of Q1/Q2 arrives while Q2/Q1 is the
>>> only queue in service, there is absolutely no point in delaying the
>>> service of such an I/O.  The only possible result is a throughput
>>> loss, detected by Jan's test
>>=20
>> If we are idling at that moment waiting for more IO from in service =
queue,
>> I agree.
>=20
> And I agree too, if the drive has no internal queueing, has no
> parallelism or pipeline, or is at least one order of magnitude slower
> than the CPU is processing I/O.  In all other cases, serving the I/O
> of only one queue at a time means throwing away throughput.  For
> example, on a consumer SSD, moving from one to two I/O threads served
> in parallel usually means doubling the throughput.
>=20
> So, the best thing to do, if all the above conditions are met, is to
> have this new I/O dispatched as soon as possible.
>=20
> The most efficient way to attain this goal is to just put the new I/O
> directly into the dispatch list.
>=20
>> But that doesn't seem to be part of your condition above?
>>=20
>>> - so, when the above condition holds, the most effective and =
efficient
>>> action is to put the new I/O directly in the dispatch list
>>> - as an additional restriction, Q1 and Q2 must be the only busy =
queues
>>> for this commit to put the I/O of Q2/Q1 in the dispatch list.  This =
is
>>> necessary, because, if also other queues are waiting for service, =
then
>>> putting new I/O directly in the dispatch list may evidently cause a
>>> violation of service guarantees for the other queues
>>=20
>> This last restriction is not ideal for cases like jbd2 thread since =
it may
>> still lead to pointless idling but I understand that without some
>> restriction like this several waking threads could just starve other =
ones.
>=20
> Yeah, the goal here is to reduce a little bit false positives.
>=20
>> So I guess it's fine for now.
>>=20
>=20
> Yes, hopefully experience will lead us to even improvements or even
> better solutions.
>=20

Hi Jens,
on a separate thread, Jan told me that my last reply, and therefore
also this patch are ok for him.  May I now proceed with a V2, in which
I'll report my extra comments? Or are there some other issues for you?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> 								Honza
>> --=20
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR


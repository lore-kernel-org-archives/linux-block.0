Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69DAC4320D
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 19:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951D5214DA
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 19:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pgas3t9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410290AbfIXTc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:32:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41643 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410224AbfIXTc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 15:32:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so3299893wrw.8
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cA8IQc84E5RSkNbWvmCzRFr+G9jaBPf2YktK5OCp14Q=;
        b=pgas3t9XEV7VmJ4qUpsOOHak91bTgUYQVYgBRjaQ7mFjX9x3P9XBSsm+tkQ/qWivXV
         dKeMqiibae20yKuaomEQ303gi5ciaTUGz9KgfOMzQgAWJgN2Hdl9AuK+dum02E/vw7Hw
         Sp1Hi7Rotk0e9Rnd4b/ZODV3TqOccixiJVG3ym0FDsVlskNtrLG03XlHs0cfWLDfP07+
         MAkThfA3id/QvLLDtpEMTTL5U4Sfb6cT3CFNpANUPU2jQiO2+wtA1Dx4cGt48n0K7K9M
         Sp74BKrWnDqj3SRJey8KtQbLtLYGhejXHvYBOesCOZTAuE4eePtmmqkhQStibVJPk8BD
         Ibyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cA8IQc84E5RSkNbWvmCzRFr+G9jaBPf2YktK5OCp14Q=;
        b=kt1B/L+MbXqJga+2XD4GtgCS9hft25lS/R0L66WyN330orxt1dqtv4ZQlS5FSdahkT
         Y7MMA3yy+m1gVEcnYPddCLgykh1svlmo/wLbUg0NDVoDt9cqsqo49LftzH00j7ghYsR3
         LOP3sQFbk+FtfhJR93Afbkn0BIxNSY/0dzXlvANxq6mZhnMLTbVE5YnJuZq+f968SMD5
         tNmmwQwiMXO9ay9HM7Qs8urmWKh42RWYncUgsKlWAcuLOjJTF6fEpjEwjJY9ZxMLaCeS
         Zgavj6sNB+PLWCmSL+lxJmIZKzDQ5CRhulbecqouo6UM4xOmLS/+/+VpCT3tH8B9X54R
         HcyA==
X-Gm-Message-State: APjAAAXmSjyXbyq4A69wOCUwiuScfizXiBBmqBqleynsCmDBtPFOGUBh
        ar2B/aYDm1YmuwKv5VyMtQow5kqEj3wn7iAu
X-Google-Smtp-Source: APXvYqxUnCZ1P9ZIumhunglbiN1/6gOlEVG7HllLkl8PlFxiCOpqRT8db7dLg/jEFWSkSaUCbweXzg==
X-Received: by 2002:adf:f949:: with SMTP id q9mr4440358wrr.382.1569353544815;
        Tue, 24 Sep 2019 12:32:24 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id k24sm3901160wmi.1.2019.09.24.12.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:32:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
 <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
 <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
 <79fa9cc2-e0cc-922f-89d3-9ace59abb2e8@gmail.com>
 <82f95b0f-8dd5-2fb5-7e17-b77072e86093@kernel.dk>
 <a307986b-94aa-f26f-fc5b-d0865083d060@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b896ca1-f2a1-8133-3a91-3512bb86a2ac@kernel.dk>
Date:   Tue, 24 Sep 2019 21:32:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a307986b-94aa-f26f-fc5b-d0865083d060@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 12:28 PM, Pavel Begunkov wrote:
> On 24/09/2019 20:46, Jens Axboe wrote:
>> On 9/24/19 11:33 AM, Pavel Begunkov wrote:
>>> On 24/09/2019 16:13, Jens Axboe wrote:
>>>> On 9/24/19 5:23 AM, Pavel Begunkov wrote:
>>>>>> Yep that should do it, and saves 8 bytes of stack as well.
>>>>>>
>>>>>> BTW, did you test my patch, this one or the previous? Just curious if it
>>>>>> worked for you.
>>>>>>
>>>>> Not yet, going to do that tonight
>>>>
>>>> Thanks! For reference, the final version is below. There was still a
>>>> signal mishap in there, now it should all be correct afaict.
>>>>
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index 9b84232e5cc4..d2a86164d520 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -2768,6 +2768,38 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
>>>>    	return submit;
>>>>    }
>>>>    
>>>> +struct io_wait_queue {
>>>> +	struct wait_queue_entry wq;
>>>> +	struct io_ring_ctx *ctx;
>>>> +	unsigned to_wait;
>>>> +	unsigned nr_timeouts;
>>>> +};
>>>> +
>>>> +static inline bool io_should_wake(struct io_wait_queue *iowq)
>>>> +{
>>>> +	struct io_ring_ctx *ctx = iowq->ctx;
>>>> +
>>>> +	/*
>>>> +	 * Wake up if we have enough events, or if a timeout occured since we
>>>> +	 * started waiting. For timeouts, we always want to return to userspace,
>>>> +	 * regardless of event count.
>>>> +	 */
>>>> +	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
>>>> +			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
>>>> +}
>>>> +
>>>> +static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
>>>> +			    int wake_flags, void *key)
>>>> +{
>>>> +	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
>>>> +							wq);
>>>> +
>>>> +	if (!io_should_wake(iowq))
>>>> +		return -1;
>>>
>>> It would try to schedule only the first task in the wait list. Is that the
>>> semantic you want?
>>> E.g. for waiters=[32,8] and nr_events == 8, io_wake_function() returns
>>> after @32, and won't wake up the second one.
>>
>> Right, those are the semantics I want. We keep the list ordered by using
>> the exclusive wait addition. Which means that for the case you list,
>> waiters=32 came first, and we should not wake others before that task
>> gets the completions it wants. Otherwise we could potentially starve
>> higher count waiters, if we always keep going and new waiters come in.
>>
> Yes. I think It would better to be documented in userspace API. I
> could imagine some crazy case deadlocking userspace. E.g.
> thread 1: wait_events(8), reap_events
> thread 2: wait_events(32), wait(thread 1), reap_events

No matter how you handle cases like this, there will always be deadlocks
possible... So I don't think that's a huge concern. It's more important
to not have intentional livelocks, which we would have if we always
allowed the lowest wait count to get woken and steal the budget
everytime.

> works well
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Tested-by: Pavel Begunkov <asml.silence@gmail.com>

Thanks, will add!

> BTW, I searched for wait_event*(), and it seems there are plenty of
> similar use cases. So, generic case would be useful, but this is for
> later.

Agree, it would undoubtedly be useful.

-- 
Jens Axboe


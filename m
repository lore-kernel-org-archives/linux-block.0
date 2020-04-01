Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32055C2D0F1
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A80206CC
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sTbjAvAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgDABVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:21:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46185 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgDABVh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:21:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so11222532pff.13
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HScuquiREHE4S8rWy0Ix4F53byaCqgwH2GZ46SK14GQ=;
        b=sTbjAvAjgf6dW3sc+cIevkOeVoaL96dT0IgLNTFWsFSIZ6HpyOjas1THhMmtyLFtaO
         OXAfIyKEnys0ftuPAwd6enwHru6PnnOO0+FV7HKmQhXd8YhH73OisxNFvueIWCe2f8AG
         Yg+oCZjxxdIMEo09kMY1Sbwa0BSY2oSDYUDIsk6KpzcAKJCgvo6VCjpoUh75BGXpUhkv
         kclRl4ccx86g8/5hGYSQlFVvT/ByGyNWTMEQtmSy5AL/ixO4J3eaBXqk58aQ4U+/OKD6
         U2BkxgXhab0ZFLFJ+z6wivDIxElF6jam7of49pOuGQmhuvpPvzxiPtOuvAa1LEyHGyZu
         pa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HScuquiREHE4S8rWy0Ix4F53byaCqgwH2GZ46SK14GQ=;
        b=NxQEnbBUpaPHSWEF1sYgrdLSqEmjkY0J+EJukjLXJqapAHL7+5FZlo3XO9B5epd8Nu
         4YZ4AoWCssXuCO8/8zj1A7WT4pwIWzjjn8wW30pTaHZn/BfTZxr0bZLmASMMJ8RZxjTd
         v9orNj7azZDhhMbUTJmJfrTzYJWRYe2JsjntU2hJY5duyHpXVhqu4bJbs9SaoR7eTLt5
         gARaNvJCm8xiyOQ+oNeNpA6lWIDE4W93drw7lkfUV0KM3cvYmmgOj7gx7Dd9olw1QESS
         JqusWV4F/MuDgePImOL4/ebEdZPda3HygkzpRUkMQmU7n0O2DhqYsq9QHaszr0OPf/yg
         2TFQ==
X-Gm-Message-State: ANhLgQ1o+QcuGuZYCrk2ixVEd+1LLbQb4JFrYPRZqw5D7mIQwUamcQjp
        Fc9JQ7xAZG1J8wHpyFLqM/8L/w==
X-Google-Smtp-Source: ADFU+vtkac8oluJOp2a7ANV9LlS6fPh7HbBbMT7hmDVkafTbFdRJQaku/ziQ7Qg1x2DVsC2KFEiCUQ==
X-Received: by 2002:a63:f258:: with SMTP id d24mr20949669pgk.307.1585704093805;
        Tue, 31 Mar 2020 18:21:33 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m68sm283813pjb.0.2020.03.31.18.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 18:21:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] scsi: core: Fix stall if two threads request budget
 at the same time
To:     Doug Anderson <dianders@chromium.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-scsi@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200330144907.13011-1-dianders@chromium.org>
 <20200330074856.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200331014109.GA20230@ming.t460p>
 <D38AB98D-7F6A-4C61-8A8F-C22C53671AC8@linaro.org>
 <d6af2344-11f7-5862-daed-e21cbd496d92@kernel.dk>
 <CAD=FV=WHYFDoUKLnwMCm-o=gEQDCzZFeMAvia3wpJzm9XX7Bow@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02968c1d-bd3a-af9c-77e7-23a9d9aa9af4@kernel.dk>
Date:   Tue, 31 Mar 2020 19:21:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WHYFDoUKLnwMCm-o=gEQDCzZFeMAvia3wpJzm9XX7Bow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/20 5:51 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Mar 31, 2020 at 11:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/31/20 12:07 PM, Paolo Valente wrote:
>>>> Il giorno 31 mar 2020, alle ore 03:41, Ming Lei <ming.lei@redhat.com> ha scritto:
>>>>
>>>> On Mon, Mar 30, 2020 at 07:49:06AM -0700, Douglas Anderson wrote:
>>>>> It is possible for two threads to be running
>>>>> blk_mq_do_dispatch_sched() at the same time with the same "hctx".
>>>>> This is because there can be more than one caller to
>>>>> __blk_mq_run_hw_queue() with the same "hctx" and hctx_lock() doesn't
>>>>> prevent more than one thread from entering.
>>>>>
>>>>> If more than one thread is running blk_mq_do_dispatch_sched() at the
>>>>> same time with the same "hctx", they may have contention acquiring
>>>>> budget.  The blk_mq_get_dispatch_budget() can eventually translate
>>>>> into scsi_mq_get_budget().  If the device's "queue_depth" is 1 (not
>>>>> uncommon) then only one of the two threads will be the one to
>>>>> increment "device_busy" to 1 and get the budget.
>>>>>
>>>>> The losing thread will break out of blk_mq_do_dispatch_sched() and
>>>>> will stop dispatching requests.  The assumption is that when more
>>>>> budget is available later (when existing transactions finish) the
>>>>> queue will be kicked again, perhaps in scsi_end_request().
>>>>>
>>>>> The winning thread now has budget and can go on to call
>>>>> dispatch_request().  If dispatch_request() returns NULL here then we
>>>>> have a potential problem.  Specifically we'll now call
>>>>
>>>> I guess this problem should be BFQ specific. Now there is definitely
>>>> requests in BFQ queue wrt. this hctx. However, looks this request is
>>>> only available from another loser thread, and it won't be retrieved in
>>>> the winning thread via e->type->ops.dispatch_request().
>>>>
>>>> Just wondering why BFQ is implemented in this way?
>>>>
>>>
>>> BFQ inherited this powerful non-working scheme from CFQ, some age ago.
>>>
>>> In more detail: if BFQ has at least one non-empty internal queue, then
>>> is says of course that there is work to do.  But if the currently
>>> in-service queue is empty, and is expected to receive new I/O, then
>>> BFQ plugs I/O dispatch to enforce service guarantees for the
>>> in-service queue, i.e., BFQ responds NULL to a dispatch request.
>>
>> What BFQ is doing is fine, IFF it always ensures that the queue is run
>> at some later time, if it returns "yep I have work" yet returns NULL
>> when attempting to retrieve that work. Generally this should happen from
>> subsequent IO completion, or whatever else condition will resolve the
>> issue that is currently preventing dispatch of that request. Last resort
>> would be a timer, but that can happen if you're slicing your scheduling
>> somehow.
> 
> I've been poking more at this today trying to understand why the idle
> timer that Paolo says is in BFQ isn't doing what it should be doing.
> I've been continuing to put most of my stream-of-consciousness at
> <https://crbug.com/1061950> to avoid so much spamming of this thread.
> In the trace I looked at most recently it looks like BFQ does try to
> ensure that the queue is run at a later time, but at least in this
> trace the later time is not late enough.  Specifically the quick
> summary of my recent trace:
> 
> 28977309us - PID 2167 got the budget.
> 28977518us - BFQ told PID 2167 that there was nothing to dispatch.
> 28977702us - BFQ idle timer fires.
> 28977725us - We start to try to dispatch as a result of BFQ's idle timer.
> 28977732us - Dispatching that was a result of BFQ's idle timer can't get
>              budget and thus does nothing.
> 28977780us - PID 2167 put the budget and exits since there was nothing
>              to dispatch.
> 
> This is only one particular trace, but in this case BFQ did attempt to
> rerun the queue after it returned NULL, but that ran almost
> immediately after it returned NULL and thus ran into the race.  :(

OK, and then it doesn't trigger again? It's key that it keeps doing this
timeout and re-dispatch if it fails, not just once.

But BFQ really should be smarter here. It's the same caller etc that
asks whether it has work and whether it can dispatch, yet the answer is
different. That's just kind of silly, and it'd make more sense if BFQ
actually implemented the ->has_work() as a "would I actually dispatch
for this guy, now".

>>> It would be very easy to change bfq_has_work so that it returns false
>>> in case the in-service queue is empty, even if there is I/O
>>> backlogged.  My only concern is: since everything has worked with the
>>> current scheme for probably 15 years, are we sure that everything is
>>> still ok after we change this scheme?
>>
>> You're comparing apples to oranges, CFQ never worked within the blk-mq
>> scheduling framework.
>>
>> That said, I don't think such a change is needed. If we currently have a
>> hang due to this discrepancy between has_work and gets_work, then it
>> sounds like we're not always re-running the queue as we should. From the
>> original patch, the budget putting is not something the scheduler is
>> involved with. Do we just need to ensure that if we put budget without
>> having dispatched a request, we need to kick off dispatching again?
> 
> By this you mean a change like this in blk_mq_do_dispatch_sched()?
> 
>   if (!rq) {
>     blk_mq_put_dispatch_budget(hctx);
> +    ret = true;
>     break;
>   }
> 
> I'm pretty sure that would fix the problems and I'd be happy to test,
> but it feels like a heavy hammer.  IIUC we're essentially going to go
> into a polling loop and keep calling has_work() and dispatch_request()
> over and over again until has_work() returns false or we manage to
> dispatch something...

We obviously have to be careful not to introduce a busy-loop, where we
just keep scheduling dispatch, only to fail.

-- 
Jens Axboe


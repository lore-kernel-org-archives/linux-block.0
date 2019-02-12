Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B59C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 23:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D909D222C9
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 23:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ut85YgTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBLXTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:19:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBLXTa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 18:19:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so184562pls.13
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2czr79EtOCK8nZFhxYac+Y8eOfCSC7YIRqZ5uI1RBcg=;
        b=Ut85YgTnGhkIWtv8chMEWQNnxRWzp8oq6euMv2RcjvrwOSa5Q2rmCd+0kWHHB4ekQs
         dZVOFxbZEPR8I6pp0wHCV3gBpkC1Y9Dnjoo2HNkJ41nuR32QYlDPuW+mRju4cNZpPe7O
         9+AXCE1ELRRim6umoXf5tkZNox1ZW2HFvHTZ3AoZArRO4SVYKjFcBl077+T1kutegW9I
         DLZOy+rnzDHRda9nQEttvI7+TcZFsyKnUK9UAaXqzs1/g8AakVvKpCn6ZMSeNs0Ib1oU
         LcdUnJNkfLvM9F5wOchTmG64DWQCWIGWeJAYcCh1QCrB+fvWYTlYGX0/auwbap0BHG9D
         9ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2czr79EtOCK8nZFhxYac+Y8eOfCSC7YIRqZ5uI1RBcg=;
        b=oSKgQNYjgVh4ADYwzRRxeHQt10wEMlalYK/2Vhc/o7C6bX9uPJWuzSHGsPQjYYNh51
         A60+HM6GO+m3XBjEKEN/qWERzH7TbtOHJL/WJbXJkjMLh1UKUlzZsoCoInynJ3x67Jv6
         bPP7xqee+y2VUGtSthwKpzajg+4xm7QsfNMc4awL4chBTbJjMU/+krIXkRTPYqREJVhb
         F9nTd7LSlSEVVgResghRYUxuC/Z3Ab6LuXgkNcK/KtPHmNdq/LDHgfBg6cWTnejQyJdf
         RkhK2viTU1iGKXboIx+ccMGpoQ55M6zdsFv8BzW4PU6YZfDROd4zBdMipGMwAPMQJBTZ
         y+0g==
X-Gm-Message-State: AHQUAuYO8HG8bjxa51qTfRS+ijc7orlZY8tisEOJQ/1wCOE3t4mLyZkY
        rv/Q+EuePu24Vk43qzh+nlks3g==
X-Google-Smtp-Source: AHgI3IYQZD8r8f3y51yeoywPETFjJxH16WvKTkQl/CQKmWkj5hNS9fU6giOVjEfntkC5NpokecEEOQ==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr6538498plt.157.1550013569948;
        Tue, 12 Feb 2019 15:19:29 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n6sm15892922pgv.86.2019.02.12.15.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 15:19:28 -0800 (PST)
Subject: Re: [PATCH 05/19] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-6-axboe@kernel.dk>
 <CAG48ez2Qc9XOApLRb5fnNiOjxaURO8vjZ-EHX7g25gje3weZ6A@mail.gmail.com>
 <42eea00c-81fb-2e28-d884-03be5bb229c8@kernel.dk>
 <CAG48ez2c=7f34AX_FFKTFFnNqJojULs9GwdqaMv=WO2tYLZE3g@mail.gmail.com>
 <1ca9f039-c6f0-cae7-8484-7db0a4e4e213@kernel.dk>
 <f20b8e79-d10f-6316-561f-3c77cab71ee0@kernel.dk>
 <CAG48ez0rJU8bx4EFJwzXOpUX1C2J86pDFHtwEdvKf2K2tsWuig@mail.gmail.com>
 <041f1c67-b62e-a593-fdc0-b44e35a4da4e@kernel.dk>
 <7149d509-25a1-eb3b-b4c6-6bb2d7a87465@kernel.dk>
 <CAG48ez09zTXuxEJE4KKfv-9yeYPGbFm_b9YnYK70csTQ1UXiuA@mail.gmail.com>
 <beb052ba-2c4a-0201-d673-c7b8eef294dd@kernel.dk>
 <CAG48ez22G1orwZ43tZ6VK3rngQitar0qH9zJXdTv8kX2e2HqOQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0641e74d-0277-9cdb-2b13-63ee60f9196d@kernel.dk>
Date:   Tue, 12 Feb 2019 16:19:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez22G1orwZ43tZ6VK3rngQitar0qH9zJXdTv8kX2e2HqOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/19 4:11 PM, Jann Horn wrote:
> On Wed, Feb 13, 2019 at 12:00 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/12/19 3:57 PM, Jann Horn wrote:
>>> On Tue, Feb 12, 2019 at 11:52 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 2/12/19 3:45 PM, Jens Axboe wrote:
>>>>> On 2/12/19 3:40 PM, Jann Horn wrote:
>>>>>> On Tue, Feb 12, 2019 at 11:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>
>>>>>>> On 2/12/19 3:03 PM, Jens Axboe wrote:
>>>>>>>> On 2/12/19 2:42 PM, Jann Horn wrote:
>>>>>>>>> On Sat, Feb 9, 2019 at 5:15 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>>> On 2/8/19 3:12 PM, Jann Horn wrote:
>>>>>>>>>>> On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>>>>> The submission queue (SQ) and completion queue (CQ) rings are shared
>>>>>>>>>>>> between the application and the kernel. This eliminates the need to
>>>>>>>>>>>> copy data back and forth to submit and complete IO.
>>>>>>>>>>>>
>>>>>>>>>>>> IO submissions use the io_uring_sqe data structure, and completions
>>>>>>>>>>>> are generated in the form of io_uring_cqe data structures. The SQ
>>>>>>>>>>>> ring is an index into the io_uring_sqe array, which makes it possible
>>>>>>>>>>>> to submit a batch of IOs without them being contiguous in the ring.
>>>>>>>>>>>> The CQ ring is always contiguous, as completion events are inherently
>>>>>>>>>>>> unordered, and hence any io_uring_cqe entry can point back to an
>>>>>>>>>>>> arbitrary submission.
>>>>>>>>>>>>
>>>>>>>>>>>> Two new system calls are added for this:
>>>>>>>>>>>>
>>>>>>>>>>>> io_uring_setup(entries, params)
>>>>>>>>>>>>         Sets up an io_uring instance for doing async IO. On success,
>>>>>>>>>>>>         returns a file descriptor that the application can mmap to
>>>>>>>>>>>>         gain access to the SQ ring, CQ ring, and io_uring_sqes.
>>>>>>>>>>>>
>>>>>>>>>>>> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
>>>>>>>>>>>>         Initiates IO against the rings mapped to this fd, or waits for
>>>>>>>>>>>>         them to complete, or both. The behavior is controlled by the
>>>>>>>>>>>>         parameters passed in. If 'to_submit' is non-zero, then we'll
>>>>>>>>>>>>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>>>>>>>>>>>>         kernel will wait for 'min_complete' events, if they aren't
>>>>>>>>>>>>         already available. It's valid to set IORING_ENTER_GETEVENTS
>>>>>>>>>>>>         and 'min_complete' == 0 at the same time, this allows the
>>>>>>>>>>>>         kernel to return already completed events without waiting
>>>>>>>>>>>>         for them. This is useful only for polling, as for IRQ
>>>>>>>>>>>>         driven IO, the application can just check the CQ ring
>>>>>>>>>>>>         without entering the kernel.
>>>>>>>>>>>>
>>>>>>>>>>>> With this setup, it's possible to do async IO with a single system
>>>>>>>>>>>> call. Future developments will enable polled IO with this interface,
>>>>>>>>>>>> and polled submission as well. The latter will enable an application
>>>>>>>>>>>> to do IO without doing ANY system calls at all.
>>>>>>>>>>>>
>>>>>>>>>>>> For IRQ driven IO, an application only needs to enter the kernel for
>>>>>>>>>>>> completions if it wants to wait for them to occur.
>>>>>>>>>>>>
>>>>>>>>>>>> Each io_uring is backed by a workqueue, to support buffered async IO
>>>>>>>>>>>> as well. We will only punt to an async context if the command would
>>>>>>>>>>>> need to wait for IO on the device side. Any data that can be accessed
>>>>>>>>>>>> directly in the page cache is done inline. This avoids the slowness
>>>>>>>>>>>> issue of usual threadpools, since cached data is accessed as quickly
>>>>>>>>>>>> as a sync interface.
>>>>>>>>> [...]
>>>>>>>>>>>> +static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +       struct io_kiocb *req;
>>>>>>>>>>>> +       ssize_t ret;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       /* enforce forwards compatibility on users */
>>>>>>>>>>>> +       if (unlikely(s->sqe->flags))
>>>>>>>>>>>> +               return -EINVAL;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       req = io_get_req(ctx);
>>>>>>>>>>>> +       if (unlikely(!req))
>>>>>>>>>>>> +               return -EAGAIN;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       req->rw.ki_filp = NULL;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       ret = __io_submit_sqe(ctx, req, s, true);
>>>>>>>>>>>> +       if (ret == -EAGAIN) {
>>>>>>>>>>>> +               memcpy(&req->submit, s, sizeof(*s));
>>>>>>>>>>>> +               INIT_WORK(&req->work, io_sq_wq_submit_work);
>>>>>>>>>>>> +               queue_work(ctx->sqo_wq, &req->work);
>>>>>>>>>>>> +               ret = 0;
>>>>>>>>>>>> +       }
>>>>>>>>>>>> +       if (ret)
>>>>>>>>>>>> +               io_free_req(req);
>>>>>>>>>>>> +
>>>>>>>>>>>> +       return ret;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +static void io_commit_sqring(struct io_ring_ctx *ctx)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +       struct io_sq_ring *ring = ctx->sq_ring;
>>>>>>>>>>>> +
>>>>>>>>>>>> +       if (ctx->cached_sq_head != ring->r.head) {
>>>>>>>>>>>> +               WRITE_ONCE(ring->r.head, ctx->cached_sq_head);
>>>>>>>>>>>> +               /* write side barrier of head update, app has read side */
>>>>>>>>>>>> +               smp_wmb();
>>>>>>>>>>>
>>>>>>>>>>> Can you elaborate on what this memory barrier is doing? Don't you need
>>>>>>>>>>> some sort of memory barrier *before* the WRITE_ONCE(), to ensure that
>>>>>>>>>>> nobody sees the updated head before you're done reading the submission
>>>>>>>>>>> queue entry? Or is that barrier elsewhere?
>>>>>>>>>>
>>>>>>>>>> The matching read barrier is in the application, it must do that before
>>>>>>>>>> reading ->head for the SQ ring.
>>>>>>>>>>
>>>>>>>>>> For the other barrier, since the ring->r.head now has a READ_ONCE(),
>>>>>>>>>> that should be all we need to ensure that loads are done.
>>>>>>>>>
>>>>>>>>> READ_ONCE() / WRITE_ONCE are not hardware memory barriers that enforce
>>>>>>>>> ordering with regard to concurrent execution on other cores. They are
>>>>>>>>> only compiler barriers, influencing the order in which the compiler
>>>>>>>>> emits things. (Well, unless you're on alpha, where READ_ONCE() implies
>>>>>>>>> a memory barrier that prevents reordering of dependent reads.)
>>>>>>>>>
>>>>>>>>> As far as I can tell, between the READ_ONCE(ring->array[...]) in
>>>>>>>>> io_get_sqring() and the WRITE_ONCE() in io_commit_sqring(), you have
>>>>>>>>> no *hardware* memory barrier that prevents reordering against
>>>>>>>>> concurrently running userspace code. As far as I can tell, the
>>>>>>>>> following could happen:
>>>>>>>>>
>>>>>>>>>  - The kernel reads from ring->array in io_get_sqring(), then updates
>>>>>>>>> the head in io_commit_sqring(). The CPU reorders the memory accesses
>>>>>>>>> such that the write to the head becomes visible before the read from
>>>>>>>>> ring->array has completed.
>>>>>>>>>  - Userspace observes the write to the head and reuses the array slots
>>>>>>>>> the kernel has freed with the write, clobbering ring->array before the
>>>>>>>>> kernel reads from ring->array.
>>>>>>>>
>>>>>>>> I'd say this is highly theoretical for the normal use case, as we
>>>>>>>> will have submitted IO in between. Hence the load must have been done.
>>>>>>
>>>>>> Sorry, I'm confused. Who is "we", and which load are you referring to?
>>>>>> io_sq_thread() goes directly from io_get_sqring() to
>>>>>> io_commit_sqring(), with only a conditional io_sqe_needs_user() in
>>>>>> between, if the `i == ARRAY_SIZE(sqes)` check triggers. There is no
>>>>>> "submitting IO" in the middle.
>>>>>
>>>>> You are right, the patch I sent IS needed for the sq thread case! It's
>>>>> only true for the "normal" case that we don't need the smp_mb() before
>>>>> writing the sq ring head, as sqes are fully consumed at that point.
>>>
>>> Hmm... does that actually matter? As long as you don't have an
>>> explicit barrier for this, the CPU could still reorder things, right?
>>> Pull the store in front of everything else?
>>
>> If the IO has been submitted, by definition the loads have completed.
>> At that point it should be fine to commit the ring head that the
>> application sees.
> 
> What exactly do you mean by "the IO has been submitted"? Are you
> talking about interaction with hardware, or about the end of the
> syscall, or something else?

I mean that the loads from the sqe, which the IO is made of, have been
done. That's what we care about here, right? The sqe has either been
turned into an io request and has been submitted, or it has been copied.

-- 
Jens Axboe


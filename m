Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6400AC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC57222CB
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rUL5yaZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfBLWpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:45:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39717 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfBLWpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 17:45:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so158902pgp.6
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 14:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=31xpVzdlcohi8Do1qzajWrsdNgcWeaCUA8pWdh4iYTM=;
        b=rUL5yaZbq5GAw4WLrNkjyN2N6msTL1t3cJJZ9d8QHFdt701ulwe7XimofzpS7THyVp
         FPkqsNhQwKOvyLpDeWVpqOcrUyq50MyCSPaz5knu1OdwCfOrXRrW0R6a7uwYVLHTdJi1
         o2aUIdeG1efA2cjnNiyHPlo95z74EIi6+5gJ2vPZ04kPdNDE/vTM4YrBOvutQTsJsSqo
         NgSBfxsMDIeGXhDjpNdtYVl9BrLnXersxd0M2TvMqF0bnUd/q6JFSlTQubxDdUy7Z28C
         OIoO91argE2Fkk0/wzop4SNBGHLzYetJPrDAl/nLQA8yTGBJsOD8+W9s1iOajSPT/MOe
         r+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=31xpVzdlcohi8Do1qzajWrsdNgcWeaCUA8pWdh4iYTM=;
        b=pUmlZKJ5lmjUgASzkUqahBmvqaVmlnxaoT72Mc2BZfGYmO6ZXMP+376EDAsO77t2HG
         ruvBJGUlclZPD0N4QemwTUXwwndGgM2DpbjoFfg6KVAdBxc2X6Y66hDN03NyaaosRK8J
         AkhIOi45Ltx5RWoPuHCpbrLYgAtoWAfoqmJ2VO4CsDucF8kmNnpSEbTfIXyjQSmjfeSN
         irwqQ9le9oL/yVs9h7PUqgRawIqGAGUgiSI55Bt6HrBhwYtKv3Rt5eXctF934VYTBkea
         /qlIfOrOy8jmht9CyfpTNJSIaeTp26Nb7LHhURi9PnvMK0RXlurxZ9nKkeznRKemJWVK
         YNnA==
X-Gm-Message-State: AHQUAubXn8on229wivrpv6/1wpQA9dcR6l4klwTG28kXsfP2o6zzQhoW
        iX77UUdYihMHJJvwV57RPDAXjA==
X-Google-Smtp-Source: AHgI3IZXGI2E4i/0VU1rvoBGoQXvV2ZITdNZ7VoMMiygNm28yWo/5cagc3OYV81VvqrIsbjA7IgNaw==
X-Received: by 2002:a65:4904:: with SMTP id p4mr5819813pgs.384.1550011545868;
        Tue, 12 Feb 2019 14:45:45 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n11sm1448960pff.32.2019.02.12.14.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:45:44 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <041f1c67-b62e-a593-fdc0-b44e35a4da4e@kernel.dk>
Date:   Tue, 12 Feb 2019 15:45:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0rJU8bx4EFJwzXOpUX1C2J86pDFHtwEdvKf2K2tsWuig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/19 3:40 PM, Jann Horn wrote:
> On Tue, Feb 12, 2019 at 11:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/12/19 3:03 PM, Jens Axboe wrote:
>>> On 2/12/19 2:42 PM, Jann Horn wrote:
>>>> On Sat, Feb 9, 2019 at 5:15 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>> On 2/8/19 3:12 PM, Jann Horn wrote:
>>>>>> On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>> The submission queue (SQ) and completion queue (CQ) rings are shared
>>>>>>> between the application and the kernel. This eliminates the need to
>>>>>>> copy data back and forth to submit and complete IO.
>>>>>>>
>>>>>>> IO submissions use the io_uring_sqe data structure, and completions
>>>>>>> are generated in the form of io_uring_cqe data structures. The SQ
>>>>>>> ring is an index into the io_uring_sqe array, which makes it possible
>>>>>>> to submit a batch of IOs without them being contiguous in the ring.
>>>>>>> The CQ ring is always contiguous, as completion events are inherently
>>>>>>> unordered, and hence any io_uring_cqe entry can point back to an
>>>>>>> arbitrary submission.
>>>>>>>
>>>>>>> Two new system calls are added for this:
>>>>>>>
>>>>>>> io_uring_setup(entries, params)
>>>>>>>         Sets up an io_uring instance for doing async IO. On success,
>>>>>>>         returns a file descriptor that the application can mmap to
>>>>>>>         gain access to the SQ ring, CQ ring, and io_uring_sqes.
>>>>>>>
>>>>>>> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
>>>>>>>         Initiates IO against the rings mapped to this fd, or waits for
>>>>>>>         them to complete, or both. The behavior is controlled by the
>>>>>>>         parameters passed in. If 'to_submit' is non-zero, then we'll
>>>>>>>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>>>>>>>         kernel will wait for 'min_complete' events, if they aren't
>>>>>>>         already available. It's valid to set IORING_ENTER_GETEVENTS
>>>>>>>         and 'min_complete' == 0 at the same time, this allows the
>>>>>>>         kernel to return already completed events without waiting
>>>>>>>         for them. This is useful only for polling, as for IRQ
>>>>>>>         driven IO, the application can just check the CQ ring
>>>>>>>         without entering the kernel.
>>>>>>>
>>>>>>> With this setup, it's possible to do async IO with a single system
>>>>>>> call. Future developments will enable polled IO with this interface,
>>>>>>> and polled submission as well. The latter will enable an application
>>>>>>> to do IO without doing ANY system calls at all.
>>>>>>>
>>>>>>> For IRQ driven IO, an application only needs to enter the kernel for
>>>>>>> completions if it wants to wait for them to occur.
>>>>>>>
>>>>>>> Each io_uring is backed by a workqueue, to support buffered async IO
>>>>>>> as well. We will only punt to an async context if the command would
>>>>>>> need to wait for IO on the device side. Any data that can be accessed
>>>>>>> directly in the page cache is done inline. This avoids the slowness
>>>>>>> issue of usual threadpools, since cached data is accessed as quickly
>>>>>>> as a sync interface.
>>>> [...]
>>>>>>> +static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
>>>>>>> +{
>>>>>>> +       struct io_kiocb *req;
>>>>>>> +       ssize_t ret;
>>>>>>> +
>>>>>>> +       /* enforce forwards compatibility on users */
>>>>>>> +       if (unlikely(s->sqe->flags))
>>>>>>> +               return -EINVAL;
>>>>>>> +
>>>>>>> +       req = io_get_req(ctx);
>>>>>>> +       if (unlikely(!req))
>>>>>>> +               return -EAGAIN;
>>>>>>> +
>>>>>>> +       req->rw.ki_filp = NULL;
>>>>>>> +
>>>>>>> +       ret = __io_submit_sqe(ctx, req, s, true);
>>>>>>> +       if (ret == -EAGAIN) {
>>>>>>> +               memcpy(&req->submit, s, sizeof(*s));
>>>>>>> +               INIT_WORK(&req->work, io_sq_wq_submit_work);
>>>>>>> +               queue_work(ctx->sqo_wq, &req->work);
>>>>>>> +               ret = 0;
>>>>>>> +       }
>>>>>>> +       if (ret)
>>>>>>> +               io_free_req(req);
>>>>>>> +
>>>>>>> +       return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void io_commit_sqring(struct io_ring_ctx *ctx)
>>>>>>> +{
>>>>>>> +       struct io_sq_ring *ring = ctx->sq_ring;
>>>>>>> +
>>>>>>> +       if (ctx->cached_sq_head != ring->r.head) {
>>>>>>> +               WRITE_ONCE(ring->r.head, ctx->cached_sq_head);
>>>>>>> +               /* write side barrier of head update, app has read side */
>>>>>>> +               smp_wmb();
>>>>>>
>>>>>> Can you elaborate on what this memory barrier is doing? Don't you need
>>>>>> some sort of memory barrier *before* the WRITE_ONCE(), to ensure that
>>>>>> nobody sees the updated head before you're done reading the submission
>>>>>> queue entry? Or is that barrier elsewhere?
>>>>>
>>>>> The matching read barrier is in the application, it must do that before
>>>>> reading ->head for the SQ ring.
>>>>>
>>>>> For the other barrier, since the ring->r.head now has a READ_ONCE(),
>>>>> that should be all we need to ensure that loads are done.
>>>>
>>>> READ_ONCE() / WRITE_ONCE are not hardware memory barriers that enforce
>>>> ordering with regard to concurrent execution on other cores. They are
>>>> only compiler barriers, influencing the order in which the compiler
>>>> emits things. (Well, unless you're on alpha, where READ_ONCE() implies
>>>> a memory barrier that prevents reordering of dependent reads.)
>>>>
>>>> As far as I can tell, between the READ_ONCE(ring->array[...]) in
>>>> io_get_sqring() and the WRITE_ONCE() in io_commit_sqring(), you have
>>>> no *hardware* memory barrier that prevents reordering against
>>>> concurrently running userspace code. As far as I can tell, the
>>>> following could happen:
>>>>
>>>>  - The kernel reads from ring->array in io_get_sqring(), then updates
>>>> the head in io_commit_sqring(). The CPU reorders the memory accesses
>>>> such that the write to the head becomes visible before the read from
>>>> ring->array has completed.
>>>>  - Userspace observes the write to the head and reuses the array slots
>>>> the kernel has freed with the write, clobbering ring->array before the
>>>> kernel reads from ring->array.
>>>
>>> I'd say this is highly theoretical for the normal use case, as we
>>> will have submitted IO in between. Hence the load must have been done.
> 
> Sorry, I'm confused. Who is "we", and which load are you referring to?
> io_sq_thread() goes directly from io_get_sqring() to
> io_commit_sqring(), with only a conditional io_sqe_needs_user() in
> between, if the `i == ARRAY_SIZE(sqes)` check triggers. There is no
> "submitting IO" in the middle.

You are right, the patch I sent IS needed for the sq thread case! It's
only true for the "normal" case that we don't need the smp_mb() before
writing the sq ring head, as sqes are fully consumed at that point.

>>> The only case that needs it is the sq thread case, since we bundle
>>> those up. This should do it:
>>
>> Actually, I take that back, as in this particular case the sq thread
>> is the only one that reads it.
> 
> What is "it"? The head pointer is written by the sq thread and read by
> userspace, not the other way around. Are you talking about
> ring->array? Sorry, I'm lost.

I think we're on the same page, even if it doesn't necessarily sound
like it. We do need the smp_mb() before witing io_commit_sqring()
for the thread case.

I guess what confused me is that your commenting on the main patch,
the case that needs it isn't introduced until later in the series.
I'll fold the fix into that patch.

-- 
Jens Axboe


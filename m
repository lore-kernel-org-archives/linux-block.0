Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E3C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB0C222B1
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 22:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g9s8dH7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfBLWDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:03:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBLWDT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 17:03:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so104980pfi.9
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3odYAMCuS2jwyGtQuJsuFL9I81CiEASbv9i3SPXKo6M=;
        b=g9s8dH7cwgeIgcVRz11XXBq05FwVjmy0DvjZPDrzSARV65Vn/BMe6sAPxRq5TT9dIY
         yZGJrKsVTbSkXtZmxmeuzYY8icoqXhR14hmatTAEjgsPjMKd6UU6vEdoWPv36BJviH0I
         lAsYR/50Y+p4F4bVLeGYinpbnLg5WQCRek+CIItc+ksP4iJ7sug5x4lFbRh5TvWQJ9hY
         ci3X6RCiREjiYXo/B+4IAjiFjU1W8xe6W2DkLN2gd08kpwPrLw7mTY+KzTalASSnXqgy
         qT7YsF894qAbS2XJX2nnrPmmene16MuWrF1ayvHe0Jw5/6pSatLOFxzvzF0LEssoQVZP
         2Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3odYAMCuS2jwyGtQuJsuFL9I81CiEASbv9i3SPXKo6M=;
        b=r1WdibK6hgWVHFzUes+UbOLNP0WEa1J3PBBG7Xsm40RWRuHbYzhuK6RAYomi5cpfsf
         92jyM2iydCFNHsT6pKfGVIZVOrTli8lTHCi/EwpxL1rBb+eeC6C7mwSYMYXPpL6avwtc
         UFK46re2sXIvKE5GhSunKyswC8vP7WCw5+wjuZzbYhHrYr1Mo3AXswj0D5umixaBJ3Gg
         Ap64PDW1c+KYDiKVgKY+6Bfv5fI82iJQF2VXzPv7PtcSf3Co9v2jZnQ3QzouwpZo6xiK
         PoCyP7cRDD/HHWNeue3fMMShK9PzpuOUXszwB2J/zRnhpQVTjx/489UrJjlJK67RWAuA
         IzTQ==
X-Gm-Message-State: AHQUAuberleXPOdV0F2nN/cLklXgAdIqe0yFrJUktE85WXfqP7eveCMK
        wjuqHn2nJw+nsZgJMsrbOSkgdQ==
X-Google-Smtp-Source: AHgI3IY9SgG9RELhdw5Y1OVYfqcw37kIB9GOH4C422VTnkvfa3WcdsCJq+Ij3Nn2fZNN63xsT5u3GQ==
X-Received: by 2002:a62:445a:: with SMTP id r87mr1876148pfa.13.1550008998547;
        Tue, 12 Feb 2019 14:03:18 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g87sm25947589pfe.43.2019.02.12.14.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:03:17 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ca9f039-c6f0-cae7-8484-7db0a4e4e213@kernel.dk>
Date:   Tue, 12 Feb 2019 15:03:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2c=7f34AX_FFKTFFnNqJojULs9GwdqaMv=WO2tYLZE3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/19 2:42 PM, Jann Horn wrote:
> On Sat, Feb 9, 2019 at 5:15 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 2/8/19 3:12 PM, Jann Horn wrote:
>>> On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> The submission queue (SQ) and completion queue (CQ) rings are shared
>>>> between the application and the kernel. This eliminates the need to
>>>> copy data back and forth to submit and complete IO.
>>>>
>>>> IO submissions use the io_uring_sqe data structure, and completions
>>>> are generated in the form of io_uring_cqe data structures. The SQ
>>>> ring is an index into the io_uring_sqe array, which makes it possible
>>>> to submit a batch of IOs without them being contiguous in the ring.
>>>> The CQ ring is always contiguous, as completion events are inherently
>>>> unordered, and hence any io_uring_cqe entry can point back to an
>>>> arbitrary submission.
>>>>
>>>> Two new system calls are added for this:
>>>>
>>>> io_uring_setup(entries, params)
>>>>         Sets up an io_uring instance for doing async IO. On success,
>>>>         returns a file descriptor that the application can mmap to
>>>>         gain access to the SQ ring, CQ ring, and io_uring_sqes.
>>>>
>>>> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
>>>>         Initiates IO against the rings mapped to this fd, or waits for
>>>>         them to complete, or both. The behavior is controlled by the
>>>>         parameters passed in. If 'to_submit' is non-zero, then we'll
>>>>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>>>>         kernel will wait for 'min_complete' events, if they aren't
>>>>         already available. It's valid to set IORING_ENTER_GETEVENTS
>>>>         and 'min_complete' == 0 at the same time, this allows the
>>>>         kernel to return already completed events without waiting
>>>>         for them. This is useful only for polling, as for IRQ
>>>>         driven IO, the application can just check the CQ ring
>>>>         without entering the kernel.
>>>>
>>>> With this setup, it's possible to do async IO with a single system
>>>> call. Future developments will enable polled IO with this interface,
>>>> and polled submission as well. The latter will enable an application
>>>> to do IO without doing ANY system calls at all.
>>>>
>>>> For IRQ driven IO, an application only needs to enter the kernel for
>>>> completions if it wants to wait for them to occur.
>>>>
>>>> Each io_uring is backed by a workqueue, to support buffered async IO
>>>> as well. We will only punt to an async context if the command would
>>>> need to wait for IO on the device side. Any data that can be accessed
>>>> directly in the page cache is done inline. This avoids the slowness
>>>> issue of usual threadpools, since cached data is accessed as quickly
>>>> as a sync interface.
> [...]
>>>> +static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s)
>>>> +{
>>>> +       struct io_kiocb *req;
>>>> +       ssize_t ret;
>>>> +
>>>> +       /* enforce forwards compatibility on users */
>>>> +       if (unlikely(s->sqe->flags))
>>>> +               return -EINVAL;
>>>> +
>>>> +       req = io_get_req(ctx);
>>>> +       if (unlikely(!req))
>>>> +               return -EAGAIN;
>>>> +
>>>> +       req->rw.ki_filp = NULL;
>>>> +
>>>> +       ret = __io_submit_sqe(ctx, req, s, true);
>>>> +       if (ret == -EAGAIN) {
>>>> +               memcpy(&req->submit, s, sizeof(*s));
>>>> +               INIT_WORK(&req->work, io_sq_wq_submit_work);
>>>> +               queue_work(ctx->sqo_wq, &req->work);
>>>> +               ret = 0;
>>>> +       }
>>>> +       if (ret)
>>>> +               io_free_req(req);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static void io_commit_sqring(struct io_ring_ctx *ctx)
>>>> +{
>>>> +       struct io_sq_ring *ring = ctx->sq_ring;
>>>> +
>>>> +       if (ctx->cached_sq_head != ring->r.head) {
>>>> +               WRITE_ONCE(ring->r.head, ctx->cached_sq_head);
>>>> +               /* write side barrier of head update, app has read side */
>>>> +               smp_wmb();
>>>
>>> Can you elaborate on what this memory barrier is doing? Don't you need
>>> some sort of memory barrier *before* the WRITE_ONCE(), to ensure that
>>> nobody sees the updated head before you're done reading the submission
>>> queue entry? Or is that barrier elsewhere?
>>
>> The matching read barrier is in the application, it must do that before
>> reading ->head for the SQ ring.
>>
>> For the other barrier, since the ring->r.head now has a READ_ONCE(),
>> that should be all we need to ensure that loads are done.
> 
> READ_ONCE() / WRITE_ONCE are not hardware memory barriers that enforce
> ordering with regard to concurrent execution on other cores. They are
> only compiler barriers, influencing the order in which the compiler
> emits things. (Well, unless you're on alpha, where READ_ONCE() implies
> a memory barrier that prevents reordering of dependent reads.)
> 
> As far as I can tell, between the READ_ONCE(ring->array[...]) in
> io_get_sqring() and the WRITE_ONCE() in io_commit_sqring(), you have
> no *hardware* memory barrier that prevents reordering against
> concurrently running userspace code. As far as I can tell, the
> following could happen:
> 
>  - The kernel reads from ring->array in io_get_sqring(), then updates
> the head in io_commit_sqring(). The CPU reorders the memory accesses
> such that the write to the head becomes visible before the read from
> ring->array has completed.
>  - Userspace observes the write to the head and reuses the array slots
> the kernel has freed with the write, clobbering ring->array before the
> kernel reads from ring->array.

I'd say this is highly theoretical for the normal use case, as we
will have submitted IO in between. Hence the load must have been done.
The only case that needs it is the sq thread case, since we bundle
those up. This should do it:


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9c5f93f6e3d9..b291796081b6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1889,6 +1889,9 @@ static int io_sq_thread(void *data)
 				break;
 		} while (io_get_sqring(ctx, &sqes[i]));
 
+		/* order the below ring head store with the SQE loads */
+		smp_mb();
+
 		io_commit_sqring(ctx);
 
 		/* Unless all new commands are FIXED regions, grab mm */

-- 
Jens Axboe


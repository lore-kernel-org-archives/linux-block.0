Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525AEC282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E8420869
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DPdPKgEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfA2U4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:56:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55773 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfA2U4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 15:56:33 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so6806305ith.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4PHYmKDjmESDkNQP79piyNHlmwRzOENr6zuCSC7hWkc=;
        b=DPdPKgEhs/+MF79XiJU8FMfD7FSl+ffAD2Rb5nvDpeu+xouIKVNXMQ+BD2VKNA9Mcd
         P+i7nhRTgxtqSesAF42x/+p/KcoAv/5sDY7pUVpklXnrSHWlGdaBA/UqmkNS4896k5VA
         kEBFNEE6huBsIVShp1Zp/PXjia5/BQw3Se6pQTWDBIY2R9BupWpxYFnrgWqGdQaFVzLh
         vHt8PCN3rJhlIbGmbs9ZzIypyUFe5Fy0Dtj0g/iKeykd/QAx1u92yPi7xWbyGZovAXP5
         10+R9a4aBfPVhjrOEj9jLZIs5XZtBoGY/TtBeAMHxUEatcKuNRlkj1S1/NzhVFY1+U1C
         0JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4PHYmKDjmESDkNQP79piyNHlmwRzOENr6zuCSC7hWkc=;
        b=FlnSELiQqnYQwRBTqESQQ/BrtVbpD6kcOdsWEV9h93EmfFyvKSL1kG4qve5tPQuQTG
         mii2kEypfdSR7Stz1bbND/CBLRcMZy5eWRD7J4aCqdEuGiqm4b+vfwm4TKlni+8a1M5T
         fAOZi8CqY0GiWN3sJ+UWoHgHivoieaYRPDWdeAw5mDb50mbMpdazyZswpqF+PJmGSEGB
         mQfrqTVsLISlDs+oeMUWH8e36Y6oeu900FmbmeE28rY0ML1xBKOm4XhsqNGGDTab6tBB
         UAI2n7Ax5WhSDVA1pqzzCVInqI2heMjpzUxqjyk1hLF/RTooGCcTJJ1vwxKZfe99a2Zs
         qUbA==
X-Gm-Message-State: AJcUukdhcIzWUJ9X3Pn4XwIjY3JTGxgM/D3KTrLt3tYzrrWsui7oJxKz
        GaX5dkvO11EEwge94RKlJi1Zsg==
X-Google-Smtp-Source: ALg8bN5fEPEYXYhdaxGo67sEeLmVeu0y4RTp0dAbGntzdD5igsYMaGIxEX+jev16VxuSXW6N3Snw/g==
X-Received: by 2002:a24:2f82:: with SMTP id j124mr12520082itj.166.1548795392353;
        Tue, 29 Jan 2019 12:56:32 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m37sm2239611iti.6.2019.01.29.12.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:56:31 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-8-axboe@kernel.dk>
 <CAG48ez270gG64wmHtG8pNUoBWiSwYiGxsyuSCQ_4wn7v_n_h_w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7337bdfc-39b5-2383-4b58-a9efc3dea1cb@kernel.dk>
Date:   Tue, 29 Jan 2019 13:56:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez270gG64wmHtG8pNUoBWiSwYiGxsyuSCQ_4wn7v_n_h_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 1:47 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Add support for a polled io_uring context. When a read or write is
>> submitted to a polled context, the application must poll for completions
>> on the CQ ring through io_uring_enter(2). Polled IO may not generate
>> IRQ completions, hence they need to be actively found by the application
>> itself.
>>
>> To use polling, io_uring_setup() must be used with the
>> IORING_SETUP_IOPOLL flag being set. It is illegal to mix and match
>> polled and non-polled IO on an io_uring.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [...]
>> @@ -102,6 +102,8 @@ struct io_ring_ctx {
>>
>>         struct {
>>                 spinlock_t              completion_lock;
>> +               bool                    poll_multi_file;
>> +               struct list_head        poll_list;
> 
> Please add a comment explaining what protects poll_list against
> concurrent modification, and ideally also put lockdep asserts in the
> functions that access the list to allow the kernel to sanity-check the
> locking at runtime.

Not sure that's needed, and it would be a bit difficult with the SQPOLL
thread and non-thread being different cases.

But comments I can definitely add.

> As far as I understand:
> Elements are added by io_iopoll_req_issued(). io_iopoll_req_issued()
> can't race with itself because, depending on IORING_SETUP_SQPOLL,
> either you have to come through sys_io_uring_enter() (which takes the
> uring_lock), or you have to come from the single-threaded
> io_sq_thread().
> io_do_iopoll() iterates over the list and removes completed items.
> io_do_iopoll() is called through io_iopoll_getevents(), which can be
> invoked in two ways during normal operation:
>  - sys_io_uring_enter -> __io_uring_enter -> io_iopoll_check
> ->io_iopoll_getevents; this is only protected by the uring_lock
>  - io_sq_thread -> io_iopoll_check ->io_iopoll_getevents; this doesn't
> hold any locks
> Additionally, the following exit paths:
>  - io_sq_thread -> io_iopoll_reap_events -> io_iopoll_getevents
>  - io_uring_release -> io_ring_ctx_wait_and_kill ->
> io_iopoll_reap_events -> io_iopoll_getevents
>  - io_uring_release -> io_ring_ctx_wait_and_kill -> io_ring_ctx_free
> -> io_iopoll_reap_events -> io_iopoll_getevents

Yes, your understanding is correct. But of important note, those two
cases don't co-exist. If you are using SQPOLL, then only the thread
itself is the one that modifies the list. The only valid call of
io_uring_enter(2) is to wakeup the thread, the task itself will NOT be
doing any issues. If you are NOT using SQPOLL, then any access is inside
the ->uring_lock.

For the reap cases, we don't enter those at shutdown for SQPOLL, we
expect the thread to do it. Hence we wait for the thread to exit before
we do our final release.

> So as far as I can tell, you can have various races around access to
> the poll_list.

How did you make that leap?

>> +static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
>> +{
>> +       if (*nr) {
>> +               kmem_cache_free_bulk(req_cachep, *nr, reqs);
>> +               io_ring_drop_ctx_refs(ctx, *nr);
>> +               *nr = 0;
>> +       }
>> +}
> [...]
>> +static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
>> +                              struct list_head *done)
>> +{
>> +       void *reqs[IO_IOPOLL_BATCH];
>> +       struct io_kiocb *req;
>> +       int to_free = 0;
>> +
>> +       while (!list_empty(done)) {
>> +               req = list_first_entry(done, struct io_kiocb, list);
>> +               list_del(&req->list);
>> +
>> +               io_cqring_fill_event(ctx, req->user_data, req->error, 0);
>> +
>> +               reqs[to_free++] = req;
>> +               (*nr_events)++;
>> +
>> +               fput(req->rw.ki_filp);
>> +               if (to_free == ARRAY_SIZE(reqs))
>> +                       io_free_req_many(ctx, reqs, &to_free);
>> +       }
>> +       io_commit_cqring(ctx);
>> +
>> +       if (to_free)
>> +               io_free_req_many(ctx, reqs, &to_free);
> 
> Nit: You check here whether to_free==0, and then io_free_req_many()
> does that again. You can delete one of those checks; I'd probably
> delete this one.

Agree, I'll kill it.

-- 
Jens Axboe


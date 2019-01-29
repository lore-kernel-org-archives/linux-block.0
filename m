Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CEBC282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C9D21738
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="igIZOpBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfA2BZx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:25:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40503 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfA2BZx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:25:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so8579597plq.7
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=repgRY9i+M9YOjxTHoAD6cKCqr63YGzJChE5nQNvIXI=;
        b=igIZOpBx6HakwgC4diRKwix3tW6P8lCahZQSIUJO5SSMfBem6o8JNQoJaTqfDdUYF2
         QlfauWGctA8JMR2+mRBeWnEpG5cBaTKf9zHzRXbcnQKFcxNwqe2dwUY3CgXgoT2AxL9I
         Sz6kZZYnnZQvf+bunmr68k741Q4Su52LHIStqecefpM3aNe/xnL4m9DVIl8g8n4sePk9
         SYPype/YZl8499Hv+WW7ixNvHXlUGMBrs6/8C/bFS50NTxRKCekBW4BuGMgzRl2iQVqF
         l578wXfBZcpFxARwTGvIB7ZIRX889QtpmRCVCQbYUXYTr2H600cmn3ehHammtlwWU6LH
         /CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=repgRY9i+M9YOjxTHoAD6cKCqr63YGzJChE5nQNvIXI=;
        b=VD8snhMXmc5D7z53W252GdZYN6pNzfTplm3TXUsCM8xh1qSyiV2PIsJh1CwlbOHUNx
         WBEkcg+RWJVGAnefUWxKS4c66veKJxUm482NzK4M85Y0mIYHM9KlWVn/60EpU4CpLRUi
         JPZyRyc0PvvHpyLISAaGOk0LNRRmJK753eNkTrgIeVb6d4ESzdqBFsfM1ow9aaCR32wK
         l7j/JdgaZjBbO194f13ouX7sHTyEuRINDwSYYKVWvvXhLQOKumpM3XPLhwTR3S+L1s1P
         +FHaeOkS8W84OdrFZqFfGRxywPhXx1MtMJ4w3YcTtiSHJlE/iy+qgOrV/IsTkhgP4WJK
         jz7Q==
X-Gm-Message-State: AJcUukcmIDX5q8cnMl8JKg42DCY70RCZDtlyQB1JDUMBcDB/VI0cKSkz
        CloaVMu5PUwgG+KwS4fhpWlcXw==
X-Google-Smtp-Source: ALg8bN6JrISrYkSn7en5WQBRLnyQ0bi315IBhr4A7tT534B7+E3dy8S8c/opK47YWz/twi3slegxQw==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr24136012plr.128.1548725152685;
        Mon, 28 Jan 2019 17:25:52 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g190sm50504963pgc.28.2019.01.28.17.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:25:51 -0800 (PST)
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO
 buffers
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-13-axboe@kernel.dk>
 <CAG48ez3cJS=RUqyP630du3pNw_wBdM82KOtbX=YY6U4LxfMBew@mail.gmail.com>
 <cb243bfc-0e3a-d5a4-3087-90af1a1824a0@kernel.dk>
 <CAG48ez0JjCDtAwbYRKcEOjsMDWmEWKUYHo4nLEDbXmQ9N9Ca=w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <512f5084-3185-f7dd-80a6-b418ca6534db@kernel.dk>
Date:   Mon, 28 Jan 2019 18:25:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0JjCDtAwbYRKcEOjsMDWmEWKUYHo4nLEDbXmQ9N9Ca=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 5:36 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 12:50 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/28/19 4:35 PM, Jann Horn wrote:
>>> On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> If we have fixed user buffers, we can map them into the kernel when we
>>>> setup the io_context. That avoids the need to do get_user_pages() for
>>>> each and every IO.
>>> [...]
>>>> +static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
>>>> +                              void __user *arg, unsigned nr_args)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       /* Drop our initial ref and wait for the ctx to be fully idle */
>>>> +       percpu_ref_put(&ctx->refs);
>>>
>>> The line above drops a reference that you just got in the caller...
>>
>> Right
>>
>>>> +       percpu_ref_kill(&ctx->refs);
>>>> +       wait_for_completion(&ctx->ctx_done);
>>>> +
>>>> +       switch (opcode) {
>>>> +       case IORING_REGISTER_BUFFERS:
>>>> +               ret = io_sqe_buffer_register(ctx, arg, nr_args);
>>>> +               break;
>>>> +       case IORING_UNREGISTER_BUFFERS:
>>>> +               ret = -EINVAL;
>>>> +               if (arg || nr_args)
>>>> +                       break;
>>>> +               ret = io_sqe_buffer_unregister(ctx);
>>>> +               break;
>>>> +       default:
>>>> +               ret = -EINVAL;
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       /* bring the ctx back to life */
>>>> +       reinit_completion(&ctx->ctx_done);
>>>> +       percpu_ref_resurrect(&ctx->refs);
>>>> +       percpu_ref_get(&ctx->refs);
>>>
>>> And then this line takes a reference that the caller will immediately
>>> drop again? Why?
>>
>> Just want to keep it symmetric and avoid having weird "this function drops
>> a reference" use cases.
>>
>>>
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>>>> +               void __user *, arg, unsigned int, nr_args)
>>>> +{
>>>> +       struct io_ring_ctx *ctx;
>>>> +       long ret = -EBADF;
>>>> +       struct fd f;
>>>> +
>>>> +       f = fdget(fd);
>>>> +       if (!f.file)
>>>> +               return -EBADF;
>>>> +
>>>> +       ret = -EOPNOTSUPP;
>>>> +       if (f.file->f_op != &io_uring_fops)
>>>> +               goto out_fput;
>>>> +
>>>> +       ret = -ENXIO;
>>>> +       ctx = f.file->private_data;
>>>> +       if (!percpu_ref_tryget(&ctx->refs))
>>>> +               goto out_fput;
>>>
>>> If you are holding the uring_lock of a ctx that can be accessed
>>> through a file descriptor (which you do just after this point), you
>>> know that the percpu_ref isn't zero, right? Why are you doing the
>>> tryget here?
>>
>> Not sure I follow... We don't hold the lock at this point. I guess your
>> point is that since the descriptor is open (or we'd fail the above
>> check), then there's no point doing the tryget variant here? That's
>> strictly true, that could just be a get().
> 
> As far as I can tell, you could do the following without breaking anything:
> 
> ========================
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6916dc3222cf..c2d82765eefe 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2485,7 +2485,6 @@ static int __io_uring_register(struct
> io_ring_ctx *ctx, unsigned opcode,
>         int ret;
> 
>         /* Drop our initial ref and wait for the ctx to be fully idle */
> -       percpu_ref_put(&ctx->refs);
>         percpu_ref_kill(&ctx->refs);
>         wait_for_completion(&ctx->ctx_done);
> 
> @@ -2516,7 +2515,6 @@ static int __io_uring_register(struct
> io_ring_ctx *ctx, unsigned opcode,
>         /* bring the ctx back to life */
>         reinit_completion(&ctx->ctx_done);
>         percpu_ref_resurrect(&ctx->refs);
> -       percpu_ref_get(&ctx->refs);
>         return ret;
>  }
> 
> @@ -2535,17 +2533,13 @@ SYSCALL_DEFINE4(io_uring_register, unsigned
> int, fd, unsigned int, opcode,
>         if (f.file->f_op != &io_uring_fops)
>                 goto out_fput;
> 
> -       ret = -ENXIO;
>         ctx = f.file->private_data;
> -       if (!percpu_ref_tryget(&ctx->refs))
> -               goto out_fput;
> 
>         ret = -EBUSY;
>         if (mutex_trylock(&ctx->uring_lock)) {
>                 ret = __io_uring_register(ctx, opcode, arg, nr_args);
>                 mutex_unlock(&ctx->uring_lock);
>         }
> -       io_ring_drop_ctx_refs(ctx, 1);
>  out_fput:
>         fdput(f);
>         return ret;
> ========================
> 
> The two functions that can drop the initial ref of the percpu refcount are:
> 
> 1. io_ring_ctx_wait_and_kill(); this is only used on ->release() or on
> setup failure, meaning that as long as you have a reference to the
> file from fget()/fdget(), io_ring_ctx_wait_and_kill() can't have been
> called on your context
> 2. __io_uring_register(); this temporarily kills the percpu refcount
> and resurrects it, all under ctx->uring_lock, meaning that as long as
> you're holding ctx->uring_lock, __io_uring_register() can't have
> killed the percpu refcount
> 
> Therefore, I think that as long as you're in sys_io_uring_register and
> holding the ctx->uring_lock, you know that the percpu refcount is
> alive, and bumping and dropping non-initial references has no effect.
> 
> Perhaps this makes more sense when you view the percpu refcount as a
> read/write lock - percpu_ref_tryget() takes a read lock, the
> percpu_ref_kill() dance takes a write lock.

This looks good, I'll fold it in. Thanks!

-- 
Jens Axboe


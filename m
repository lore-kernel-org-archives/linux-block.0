Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33EBC282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15D82171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xpWr3iD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfA1XrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36739 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfA1XrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so8759897pfc.3
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 15:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8nO5KrZxX4nYBeqUlg6SIMhAny8geOqKcXVgBtRr4Q=;
        b=xpWr3iD0WDmtZefrwqj3w3vXUfJcWfrazyrZm10n86UKxTlAIwm7WRGuI2scRHxsEs
         sJn/0WBnlgjU1tvsOfx/XVolTLxc9Gcwsex2L6M8H7mvNDsv3JDa5ler7m7BuGjAgL0W
         T491wTxDsqrukdhzr6LeQGKhd7iz68om+H2Qq/VTgvFXEK/lXX7oA92NK2MPQqgUUktS
         WoBTko5x3Fq/ZPxXy8ynX7MsLM8i9+LFtDeirta56IEbr6AZmogbsDi813O3veESAYMg
         07o1ewed1xdA+9QTNIps6uUOcSQ8CyUVQea97ikggHG+wVOW/IzaEgG/umQuwTkG2ntR
         w7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8nO5KrZxX4nYBeqUlg6SIMhAny8geOqKcXVgBtRr4Q=;
        b=rTLiv7zieM3zx8Vo0zaA8YemMpr3xE8g/d3FGS7KKQ3Ag+NRSkOB0tTGgyNGUqMsfw
         ekiGYt8ubFZtwat+tYkHLvgL6VqPwVCGZ9/OWYNisuckHMyuTiQZ2zvxDWqbPUmhz3UR
         EpLOGKhabEbY6HXaATn35jG9p03WMYk/rIv/95MjZ1uFqhnzX+v/Gfvq8Xa9cydwvsYk
         +dHn1yjfcethx68a+TVhWQfPd8+8XvuGh7gWnvJccRQ5XpbdIQzmQ+FPsasx8HHc3zKO
         tgOwh6vSNI6XBmdxw+D4WbLCji0oW3FtRHa1XEGXCMVH6mhvZcBlFBLfivwPxMbNQMsm
         pPDQ==
X-Gm-Message-State: AJcUukfjYfPEx1PG2yyVBi5SJ94Yij9BDA2mvxRaJMYiSYtXF8AQf3Eo
        9v2A3jl4Gmvu3GvyKj3kxQM0kA==
X-Google-Smtp-Source: ALg8bN4f7SLufO6TqpIbB3REzNkOkRK4kRSkHLGMeZvjWUShhh79MUJilB4vHoYvdxEXqfDoU3yGZA==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr24016391pfv.82.1548719220365;
        Mon, 28 Jan 2019 15:47:00 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w184sm40635861pgd.34.2019.01.28.15.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 15:46:58 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk>
Date:   Mon, 28 Jan 2019 16:46:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 3:32 PM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO.
>>
>> IO submissions use the io_uring_sqe data structure, and completions
>> are generated in the form of io_uring_sqe data structures. The SQ
>> ring is an index into the io_uring_sqe array, which makes it possible
>> to submit a batch of IOs without them being contiguous in the ring.
>> The CQ ring is always contiguous, as completion events are inherently
>> unordered, and hence any io_uring_cqe entry can point back to an
>> arbitrary submission.
>>
>> Two new system calls are added for this:
>>
>> io_uring_setup(entries, params)
>>         Sets up a context for doing async IO. On success, returns a file
>>         descriptor that the application can mmap to gain access to the
>>         SQ ring, CQ ring, and io_uring_sqes.
>>
>> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
>>         Initiates IO against the rings mapped to this fd, or waits for
>>         them to complete, or both. The behavior is controlled by the
>>         parameters passed in. If 'to_submit' is non-zero, then we'll
>>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>>         kernel will wait for 'min_complete' events, if they aren't
>>         already available. It's valid to set IORING_ENTER_GETEVENTS
>>         and 'min_complete' == 0 at the same time, this allows the
>>         kernel to return already completed events without waiting
>>         for them. This is useful only for polling, as for IRQ
>>         driven IO, the application can just check the CQ ring
>>         without entering the kernel.
>>
>> With this setup, it's possible to do async IO with a single system
>> call. Future developments will enable polled IO with this interface,
>> and polled submission as well. The latter will enable an application
>> to do IO without doing ANY system calls at all.
>>
>> For IRQ driven IO, an application only needs to enter the kernel for
>> completions if it wants to wait for them to occur.
>>
>> Each io_uring is backed by a workqueue, to support buffered async IO
>> as well. We will only punt to an async context if the command would
>> need to wait for IO on the device side. Any data that can be accessed
>> directly in the page cache is done inline. This avoids the slowness
>> issue of usual threadpools, since cached data is accessed as quickly
>> as a sync interface.
>>
>> Sample application: http://git.kernel.dk/cgit/fio/plain/t/io_uring.c
> [...]
>> +static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>> +                     bool force_nonblock)
>> +{
>> +       struct kiocb *kiocb = &req->rw;
>> +       int ret;
>> +
>> +       kiocb->ki_filp = fget(sqe->fd);
>> +       if (unlikely(!kiocb->ki_filp))
>> +               return -EBADF;
>> +       kiocb->ki_pos = sqe->off;
>> +       kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
>> +       kiocb->ki_hint = ki_hint_validate(file_write_hint(kiocb->ki_filp));
>> +       if (sqe->ioprio) {
>> +               ret = ioprio_check_cap(sqe->ioprio);
>> +               if (ret)
>> +                       goto out_fput;
>> +
>> +               kiocb->ki_ioprio = sqe->ioprio;
>> +       } else
>> +               kiocb->ki_ioprio = get_current_ioprio();
>> +
>> +       ret = kiocb_set_rw_flags(kiocb, sqe->rw_flags);
>> +       if (unlikely(ret))
>> +               goto out_fput;
>> +       if (force_nonblock) {
>> +               kiocb->ki_flags |= IOCB_NOWAIT;
>> +               req->flags |= REQ_F_FORCE_NONBLOCK;
>> +       }
>> +       if (kiocb->ki_flags & IOCB_HIPRI) {
>> +               ret = -EINVAL;
>> +               goto out_fput;
>> +       }
>> +
>> +       kiocb->ki_complete = io_complete_rw;
>> +       return 0;
>> +out_fput:
>> +       fput(kiocb->ki_filp);
>> +       return ret;
>> +}
> [...]
>> +static ssize_t io_read(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>> +                      bool force_nonblock)
>> +{
>> +       struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
>> +       struct kiocb *kiocb = &req->rw;
>> +       struct iov_iter iter;
>> +       struct file *file;
>> +       ssize_t ret;
>> +
>> +       ret = io_prep_rw(req, sqe, force_nonblock);
>> +       if (ret)
>> +               return ret;
>> +       file = kiocb->ki_filp;
>> +
>> +       ret = -EBADF;
>> +       if (unlikely(!(file->f_mode & FMODE_READ)))
>> +               goto out_fput;
>> +       ret = -EINVAL;
>> +       if (unlikely(!file->f_op->read_iter))
>> +               goto out_fput;
>> +
>> +       ret = io_import_iovec(req->ctx, READ, sqe, &iovec, &iter);
>> +       if (ret)
>> +               goto out_fput;
>> +
>> +       ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_iter_count(&iter));
>> +       if (!ret) {
>> +               ssize_t ret2;
>> +
>> +               /* Catch -EAGAIN return for forced non-blocking submission */
>> +               ret2 = call_read_iter(file, kiocb, &iter);
>> +               if (!force_nonblock || ret2 != -EAGAIN)
>> +                       io_rw_done(kiocb, ret2);
>> +               else
>> +                       ret = -EAGAIN;
>> +       }
>> +       kfree(iovec);
>> +out_fput:
>> +       if (unlikely(ret))
>> +               fput(file);
>> +       return ret;
>> +}
> [...]
>> +static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>> +                          struct sqe_submit *s, bool force_nonblock)
>> +{
>> +       const struct io_uring_sqe *sqe = s->sqe;
>> +       ssize_t ret;
>> +
>> +       if (unlikely(s->index >= ctx->sq_entries))
>> +               return -EINVAL;
>> +       req->user_data = sqe->user_data;
>> +
>> +       ret = -EINVAL;
>> +       switch (sqe->opcode) {
>> +       case IORING_OP_NOP:
>> +               ret = io_nop(req, sqe);
>> +               break;
>> +       case IORING_OP_READV:
>> +               ret = io_read(req, sqe, force_nonblock);
>> +               break;
>> +       case IORING_OP_WRITEV:
>> +               ret = io_write(req, sqe, force_nonblock);
>> +               break;
>> +       default:
>> +               ret = -EINVAL;
>> +               break;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void io_sq_wq_submit_work(struct work_struct *work)
>> +{
>> +       struct io_kiocb *req = container_of(work, struct io_kiocb, work);
>> +       struct sqe_submit *s = &req->submit;
>> +       u64 user_data = s->sqe->user_data;
>> +       struct io_ring_ctx *ctx = req->ctx;
>> +       mm_segment_t old_fs = get_fs();
>> +       struct files_struct *old_files;
>> +       int ret;
>> +
>> +        /* Ensure we clear previously set forced non-block flag */
>> +       req->flags &= ~REQ_F_FORCE_NONBLOCK;
>> +
>> +       old_files = current->files;
>> +       current->files = ctx->sqo_files;
> 
> I think you're not supposed to twiddle with current->files without
> holding task_lock(current).

'current' is the work queue item in this case, do we need to protect
against anything else? I can add the locking around the assignments
(both places).

>> +       if (!mmget_not_zero(ctx->sqo_mm)) {
>> +               ret = -EFAULT;
>> +               goto err;
>> +       }
>> +
>> +       use_mm(ctx->sqo_mm);
>> +       set_fs(USER_DS);
>> +
>> +       ret = __io_submit_sqe(ctx, req, s, false);
>> +
>> +       set_fs(old_fs);
>> +       unuse_mm(ctx->sqo_mm);
>> +       mmput(ctx->sqo_mm);
>> +err:
>> +       if (ret) {
>> +               io_cqring_add_event(ctx, user_data, ret, 0);
>> +               io_free_req(req);
>> +       }
>> +       current->files = old_files;
>> +}
> [...]
>> +static int io_sq_offload_start(struct io_ring_ctx *ctx)
>> +{
>> +       int ret;
>> +
>> +       ctx->sqo_mm = current->mm;
> 
> What keeps this thing alive?

I think we're deadling with the same thing as the files below, I'll
defer to that.

>> +       /*
>> +        * This is safe since 'current' has the fd installed, and if that gets
>> +        * closed on exit, then fops->release() is invoked which waits for the
>> +        * async contexts to flush and exit before exiting.
>> +        */
>> +       ret = -EBADF;
>> +       ctx->sqo_files = current->files;
>> +       if (!ctx->sqo_files)
>> +               goto err;
> 
> That's gnarly. Adding Al Viro to the thread.
> 
> I think you misunderstand the semantics of f_op->release. The ->flush
> handler is invoked whenever a file descriptor is closed through
> filp_close() (via deletion of the files_struct, sys_close(),
> sys_dup2(), ...), so if you had used that one, _maybe_ this would
> work. But the ->release handler only runs when the _last_ reference to
> a struct file has been dropped - so you can, for example, fork() a
> child, then exit() in the parent, and the ->release handler isn't
> invoked. So I don't see how this can work.

The anonfd is CLOEXEC. The idea is exactly that it only runs when the
last reference to the file has been dropped. Not sure why you think I
need ->flush() here?

> But even if you had abused ->flush for this instead: close_files()
> currently has a comment in it that claims that "this is the last
> reference to the files structure"; this change would make that claim
> untrue.

Let me see if I can explain my intent better than that comment... We
know the parent who set up the io_uring instance will be around for as
long as io_uring instance persists. When we are tearing down the
io_uring, then we wait for any async contexts (like the one above) to
exit. Once they are exited, it's safe to proceed with the exit and
teardown ->files[].

That's the idea... Not trying to be clever, some of this dates back to
the aio weirdness where it was impossible to have cross references like
this, since it would lead to teardown deadlocks with how exit_aio() is
used. I can probably grab a struct files reference above, but currently
I don't see why it's needed.

>> +       /* Do QD, or 2 * CPUS, whatever is smallest */
>> +       ctx->sqo_wq = alloc_workqueue("io_ring-wq", WQ_UNBOUND | WQ_FREEZABLE,
>> +                       min(ctx->sq_entries - 1, 2 * num_online_cpus()));
>> +       if (!ctx->sqo_wq) {
>> +               ret = -ENOMEM;
>> +               goto err;
>> +       }
>> +
>> +       return 0;
>> +err:
>> +       if (ctx->sqo_files)
>> +               ctx->sqo_files = NULL;
>> +       ctx->sqo_mm = NULL;
>> +       return ret;
>> +}
> [...]
>> +static const struct file_operations io_uring_fops = {
>> +       .release        = io_uring_release,
>> +       .mmap           = io_uring_mmap,
>> +       .poll           = io_uring_poll,
>> +       .fasync         = io_uring_fasync,
>> +};
> [...]
> 


-- 
Jens Axboe


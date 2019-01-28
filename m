Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B16C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 23:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C032175B
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 23:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oOpC3IiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfA1XgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:36:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35460 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfA1XgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 18:36:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so16323564otj.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQIDq6ClBgggejiPZ9U1GYAYyrne8cJ3+jqu+8cslzo=;
        b=oOpC3IiX08kAgsrmlAZCiFEkuZ2GJHsezPUimQ+rte148nSigOe5poUKmqKwBtmO7+
         ze2O9SD9dV2+FlLBhk/oWOcdHnBMg0gFs47+vS1B47y2fVn76jlVgbuLcb+pAeWcsiRs
         A+dyCTVWAEyaAiEoelvBmSidRyRfGMSCUws0seP5t9G1Z8M/ASkMHUsR72GA5bdgE62u
         zduePFBbk//X6uxcq7yqj8n4EWhszWuqswRtqJqFUTYR+30xgjSSbdVbzGdWeA7T974u
         TiaWqHNkEKb0hHxo/yu9gAZOixcAKd4NTA9lSWW/x87dPZcMxXhbMx+j2ROo9HHYaPrq
         8XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQIDq6ClBgggejiPZ9U1GYAYyrne8cJ3+jqu+8cslzo=;
        b=Ur/z82nfDAwHjwDxcKoI4gHEyxWucRF1ZADWrcYfaChsGJXvUmqipRX4iEvfDJHT7c
         RmGrb1C4EZl9b9R+Ws4mA+rNUYB+BNm+xWkchMUrFAOoQuOZqmfdpjI8EpMGOVdThYIZ
         HBDMC5GZC2hbSvPrMyNurF0fAt0V9vcBtxuxo7IQ5qhrUyYJ11YPFvezgwPf9Evb4geV
         GT35llfrGbKXyKednLFuQUddmtb0E1YK3ztsbdKZ8k07N1avxc5GZ4g2Mrf7WWTKxbTZ
         Fes2XSLLvRwSUkTetQ55aw9kr1ZZA5b6BMZ1msYPFxB1Dbb2ndv4OnNvQAsyWAu58//P
         onTA==
X-Gm-Message-State: AJcUukdTgNBZQxoa93FlyJHzxyTgRfStPgtElXsZ/RTdMH2oxaT5JxW4
        HdmqSjbxOYDfa3gTWRMtYNmhXiYMCq1DdNcFR59zBvlWluU=
X-Google-Smtp-Source: ALg8bN6j7H+JmmP+h1+gQ0SvbZQK2S2j03qF/Szfeh8lloZS440SXE3TIOfUvReIxaNLUHKqgUwUR0ucNxcFcyWqnZw=
X-Received: by 2002:a9d:4e06:: with SMTP id p6mr18976867otf.73.1548718576370;
 Mon, 28 Jan 2019 15:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-13-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-13-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 00:35:50 +0100
Message-ID: <CAG48ez3cJS=RUqyP630du3pNw_wBdM82KOtbX=YY6U4LxfMBew@mail.gmail.com>
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
> If we have fixed user buffers, we can map them into the kernel when we
> setup the io_context. That avoids the need to do get_user_pages() for
> each and every IO.
[...]
> +static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
> +                              void __user *arg, unsigned nr_args)
> +{
> +       int ret;
> +
> +       /* Drop our initial ref and wait for the ctx to be fully idle */
> +       percpu_ref_put(&ctx->refs);

The line above drops a reference that you just got in the caller...

> +       percpu_ref_kill(&ctx->refs);
> +       wait_for_completion(&ctx->ctx_done);
> +
> +       switch (opcode) {
> +       case IORING_REGISTER_BUFFERS:
> +               ret = io_sqe_buffer_register(ctx, arg, nr_args);
> +               break;
> +       case IORING_UNREGISTER_BUFFERS:
> +               ret = -EINVAL;
> +               if (arg || nr_args)
> +                       break;
> +               ret = io_sqe_buffer_unregister(ctx);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       /* bring the ctx back to life */
> +       reinit_completion(&ctx->ctx_done);
> +       percpu_ref_resurrect(&ctx->refs);
> +       percpu_ref_get(&ctx->refs);

And then this line takes a reference that the caller will immediately
drop again? Why?

> +       return ret;
> +}
> +
> +SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
> +               void __user *, arg, unsigned int, nr_args)
> +{
> +       struct io_ring_ctx *ctx;
> +       long ret = -EBADF;
> +       struct fd f;
> +
> +       f = fdget(fd);
> +       if (!f.file)
> +               return -EBADF;
> +
> +       ret = -EOPNOTSUPP;
> +       if (f.file->f_op != &io_uring_fops)
> +               goto out_fput;
> +
> +       ret = -ENXIO;
> +       ctx = f.file->private_data;
> +       if (!percpu_ref_tryget(&ctx->refs))
> +               goto out_fput;

If you are holding the uring_lock of a ctx that can be accessed
through a file descriptor (which you do just after this point), you
know that the percpu_ref isn't zero, right? Why are you doing the
tryget here?

> +       ret = -EBUSY;
> +       if (mutex_trylock(&ctx->uring_lock)) {
> +               ret = __io_uring_register(ctx, opcode, arg, nr_args);
> +               mutex_unlock(&ctx->uring_lock);
> +       }
> +       io_ring_drop_ctx_refs(ctx, 1);
> +out_fput:
> +       fdput(f);
> +       return ret;
> +}

Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C90C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876D1217F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpFa8Guk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfA2BHf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:07:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34205 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfA2BHf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:07:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so16487440otk.1
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwKltPVXhUpDZi2Uc99nBaYl8yLTNtE+xKTaGDVKYDE=;
        b=CpFa8Guk9zlt7ut4LJYeMaXW1W36YOc0zu3b5fpAIheHGX/uS/v+5/1hK4ZQ7+EJNE
         AGp8n4PJEcvMhPD0OknkZAC5PGgcjuBsZfoGnpxlw8RwYJYJUq/aXT5XtudVZGs81MfC
         rvTmHF6yhlDlfhREXP92fSBYx13kfTXUDolr5SRlL/48JCaprKTFJYG8yzJfQ22BrvPb
         nfEe1q7Rf/Hd8WnRamnO09MmJc+HqdGqnWWdwRVvelxxNXfaTELsm9es703ReLv7XKIb
         CAJ9gjF223X9cF+3OrEPFw7jUUDv/j1nZgZQMakPrXIotH8mGvGqetp/BF48D6qToWQE
         4tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwKltPVXhUpDZi2Uc99nBaYl8yLTNtE+xKTaGDVKYDE=;
        b=PNG52vwmY7LBHs7fdxu0gqtNmOB7VsbcQ6Ahz2jWO73+xbNTdVU9RVn+nS1ZgCBZs5
         ygOwaD7XxDmMVKO69lpEAS8kmk+iMHN17ybVY5K0zueWOgs9iAHHfrqUgFsXYa5AtRTE
         ZFkgpiVzOVpEU9epyQueXlukQ73r4nHlbaBhXMPtrDFa2KDMw10y7ju9xqR6/rVHK5kJ
         lqUjroHFQ1a5z0Y+rzdH0zu1u9b2dfulFvoNnasKZnANZr3+Pn5Fa69Sym132jPmQSNb
         3M9Cq6p+sPrb5HhOAk8x93TQYwA7EiNPmoRcrSZhNv2xYbfxY9wjCtGBGmM6VGPo5qN+
         hbXQ==
X-Gm-Message-State: AJcUukdix4x2wzuGPwBW5osZNgtbgKfi+Jiia30j6//WtI853XJSDWVC
        joYcjpHgqr00/mHej9EY/XdK6OAjfkKVb0dWv/Z2xcNIJ0WOeA==
X-Google-Smtp-Source: ALg8bN5/I+E6Dzfm9sr5qDXzMWvnlE2rl01Dd6azFBb7fTOSUjSdo+csvTOOIyGLV1zBbb+RzwW4rLXaT1PkvOzEY7o=
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr18188583otf.242.1548724054847;
 Mon, 28 Jan 2019 17:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-6-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 02:07:08 +0100
Message-ID: <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
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

On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO.
[...]
> +static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
> +{
> +       struct io_sq_ring *ring = ctx->sq_ring;
> +       unsigned head;
> +
> +       /*
> +        * The cached sq head (or cq tail) serves two purposes:
> +        *
> +        * 1) allows us to batch the cost of updating the user visible
> +        *    head updates.
> +        * 2) allows the kernel side to track the head on its own, even
> +        *    though the application is the one updating it.
> +        */
> +       head = ctx->cached_sq_head;
> +       smp_rmb();
> +       if (head == READ_ONCE(ring->r.tail))
> +               return false;
> +
> +       head = ring->array[head & ctx->sq_mask];
> +       if (head < ctx->sq_entries) {
> +               s->index = head;
> +               s->sqe = &ctx->sq_sqes[head];

ring->array can be mapped writable into userspace, right? If so: This
looks like a double-read issue; the compiler might assume that
ring->array is not modified concurrently and perform separate memory
accesses for the "if (head < ctx->sq_entries)" check and the
"&ctx->sq_sqes[head]" computation. Please use READ_ONCE()/WRITE_ONCE()
for all accesses to memory that userspace could concurrently modify in
a malicious way.

There have been some pretty severe security bugs caused by missing
READ_ONCE() annotations around accesses to shared memory; see, for
example, https://www.blackhat.com/docs/us-16/materials/us-16-Wilhelm-Xenpwn-Breaking-Paravirtualized-Devices.pdf
. Slides 35-48 show how the code "switch (op->cmd)", where "op" is a
pointer to shared memory, allowed an attacker to break out of a Xen
virtual machine because the compiler generated multiple memory
accesses.

> +               ctx->cached_sq_head++;
> +               return true;
> +       }
> +
> +       /* drop invalid entries */
> +       ctx->cached_sq_head++;
> +       ring->dropped++;
> +       smp_wmb();
> +       return false;
> +}
[...]
> +SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
> +               u32, min_complete, u32, flags, const sigset_t __user *, sig,
> +               size_t, sigsz)
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

Oh, by the way: If you feel like it, maybe you could add a helper
fdget_typed(int fd, struct file_operations *f_op), or something like
that, so that there is less boilerplate code for first doing fdget(),
then checking ->f_op, and then coding an extra bailout path for that?
But that doesn't really have much to do with your patchset, feel free
to ignore this comment.

[...]
> +out_fput:
> +       fdput(f);
> +       return ret;
> +}

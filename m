Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF9C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 10:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2BC206C2
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391943AbfAPKmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:42:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43014 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389215AbfAPKmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 05:42:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so6541977qtj.10;
        Wed, 16 Jan 2019 02:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyzXhbvcepQQpuyPPelqDLA3ieThKlMwr1szUbLyaLw=;
        b=ZzFsDYa8CKtkVhhgWIozU8Gkz0i8ABsPOQDxQJCYDlWdOumA8FXbq6n760ghmDFuOf
         OiTn6OmcqwliBqB0hCr59QjGy7lajCW+E7jpTQbrnw1NS8jFOEsCcGwsymC3tvBtRlYx
         iOr22TSjxcKLih+QdyFNuon85mnlKAFimoaDBB+RNKsoRpjE+arFxydzl9ZkWyNM8Lmg
         rHWJRdHvvx8JdmeW6RKZfK1uv0KmFLNf6zNEQqNWsgatYrViKHXTwMFkJDVj8ad9RjY5
         5Yc5dDcXlyb0nvpj/xZLk/3/qoGlRpuywent/myIqZ5jlTxYFTx1T2y1l7gm1vjoGdlI
         Ds+g==
X-Gm-Message-State: AJcUukcHI+lR4lTlJZeZbcoAj7YT/Rq8GsPN279jPA8PnNb3z9apaJHg
        EaRsol0SZyXJRxNK+FV9mDrUbKyjPrnmXVi7PEoXby2Z
X-Google-Smtp-Source: ALg8bN4l+kfYXzooUW9E1C1xgyI3Dz3mnf08a/xj1HrdQlwN6iYHC27bypuTpVIi55Z4QuBIHe2ykrGRY1s+tEFmKLM=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr6388363qtl.343.1547635325078;
 Wed, 16 Jan 2019 02:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-6-axboe@kernel.dk>
In-Reply-To: <20190115025531.13985-6-axboe@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 11:41:48 +0100
Message-ID: <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 3:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 3cf7b533b3d1..194e79c0032e 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -398,3 +398,5 @@
>  384    i386    arch_prctl              sys_arch_prctl                  __ia32_compat_sys_arch_prctl
>  385    i386    io_pgetevents           sys_io_pgetevents               __ia32_compat_sys_io_pgetevents
>  386    i386    rseq                    sys_rseq                        __ia32_sys_rseq
> +387    i386    io_uring_setup          sys_io_uring_setup              __ia32_compat_sys_io_uring_setup
> +388    i386    io_uring_enter          sys_io_uring_enter              __ia32_sys_io_uring_enter
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f0b1709a5ffb..453ff7a79002 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,8 @@
>  332    common  statx                   __x64_sys_statx
>  333    common  io_pgetevents           __x64_sys_io_pgetevents
>  334    common  rseq                    __x64_sys_rseq
> +335    common  io_uring_setup          __x64_sys_io_uring_setup
> +336    common  io_uring_enter          __x64_sys_io_uring_enter

In my series for the y2038 system calls, I'm trying to move to having the
same numbers across all architectures. Unfortunately, that clashes
with newly assigned numbers here, so one of us needs to pick new
numbers.

If my series gets merged without other changes to the numbers, the next
available numbers on all architectures become 424 and 425.

Could you use those here?

> +SYSCALL_DEFINE2(io_uring_setup, u32, entries,
> +               struct io_uring_params __user *, params)
> +{
> +       return io_uring_setup(entries, params, false);
> +}
> +
> +#ifdef CONFIG_COMPAT
> +COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
> +                      struct io_uring_params __user *, params)
> +{
> +       return io_uring_setup(entries, params, true);
> +}
> +#endif

The compat syscall has the same calling conventions as the
native one here, so I think you can just use that directly.

> +/*
> + * IO submission data structure (Submission Queue Entry)
> + */
> +struct io_uring_sqe {
> +       __u8    opcode;         /* type of operation for this sqe */
> +       __u8    flags;          /* as of now unused */
> +       __u16   ioprio;         /* ioprio for the request */
> +       __s32   fd;             /* file descriptor to do IO on */
> +       __u64   off;            /* offset into file */
> +       union {
> +               void    *addr;  /* buffer or iovecs */
> +               __u64   __pad;
> +       };

It seems a bit unfortunate to keep the pointer field only
almost compatible between 32-bit and 64-bit big-endian
architectures, as that requires an in_compat_syscall()
check whenever we access the pointer from the kernel.

Could you use a __u64 field to store the pointer itself
instead?

> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index ab9d0e3c6d50..ee5e523564bb 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -46,6 +46,8 @@ COND_SYSCALL(io_getevents);
>  COND_SYSCALL(io_pgetevents);
>  COND_SYSCALL_COMPAT(io_getevents);
>  COND_SYSCALL_COMPAT(io_pgetevents);
> +COND_SYSCALL(io_uring_setup);
> +COND_SYSCALL(io_uring_enter);

Unless you remove the compat_sys_io_uring_setup() definition,
this should also have a corresponding COND_SYSCALL_COMPAT()
entry.

      Arnd

Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D417C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 07:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BA2183F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 07:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XxENKgEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfA2HMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:12:22 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33448 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfA2HMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 02:12:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so11392433vsc.0;
        Mon, 28 Jan 2019 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTe7TSL+0D5eUgEiuXks8Jgl++Ywx0wT2C+uwgn9ByE=;
        b=XxENKgEyFpO1XmyxkUfWzs7X0jEByRGukCsvIdNGm5p3TkQsV0TH1ZnoDQREACaSnx
         N49pvvrSpnw/vIVmAAxA5hzR0At463K/5GJ3ptP1y+RH9ZIRVZcwzvCZOTpEa4L/5BRF
         JOx6uBGORz37amCtDKyoyuysRWWbvlKnHF5pvR7WOjf4HocghmwsimKNuHHkTHd4sPJ8
         3mADwl0baED9aoThrUiiDMNZ5hTwGXWQVzdO3MbuEeDFmsO1K6io6MlcvA6FPxUOQcbq
         /xORZvvwO/5qq0plIHLMfaf5ZXctoZMRFpwXcsWk74FyAnCsNPVM2bP8Uba6JqUhcktw
         n5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTe7TSL+0D5eUgEiuXks8Jgl++Ywx0wT2C+uwgn9ByE=;
        b=BZX1I+yFf2ibjZw3cwspKr/90IFmmv/3hZLuXdlz9B8ROe0cyOjT1TuQ0CBUsPRJsQ
         xBmOtrWH4/I+0oUxtdR35rVXMjJ4OTT8vD9SNeQlNcP2cdZyGLYvxSE8Iv12uZgFDR6M
         kcetrYDOK64mqXM5GPREC2/+t0AiCHqEe949AsCXhPdjp2W1WK3yX/1CEkJeU/8Ckiwk
         Lu5yEqRmd+xPNYEaQkNCOFqZTAdSG8rX/XzwtZuOKwF3V8lCAUX8skWxLvChiyIUnC23
         X3wTVzvLzjs59Li3apCzuJ3WX7TGlHkYUr1Gg0niVYmndEO6nIsUPHT2gaYPhnCxCKe6
         S6XQ==
X-Gm-Message-State: AJcUukfOROy8ldylJYYWInQ3Ef+SM9BJA42T7qnvcicwOVOF7tT6cCnD
        gLmHqdgZsATZzbOVLPN6zzlnmEy0qyVKW/VEoJI=
X-Google-Smtp-Source: ALg8bN6Ro0wU33EjYOY+29RyQ904Yp989qMznYUFnK9PYbOCcdkCzDmdjaglw3UYKMFZ3Ns8bZ6dm3hR9WQEpM69osE=
X-Received: by 2002:a67:d119:: with SMTP id u25mr9496308vsi.63.1548745940374;
 Mon, 28 Jan 2019 23:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-6-axboe@kernel.dk>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 29 Jan 2019 08:12:08 +0100
Message-ID: <CAKPyHN2UyExWDRqO=oTZP2UdR8naYO_Tv2eVw+CQBEfs7_uuVg@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO.
>
> IO submissions use the io_uring_sqe data structure, and completions
> are generated in the form of io_uring_sqe data structures. The SQ
> ring is an index into the io_uring_sqe array, which makes it possible
> to submit a batch of IOs without them being contiguous in the ring.
> The CQ ring is always contiguous, as completion events are inherently
> unordered, and hence any io_uring_cqe entry can point back to an
> arbitrary submission.
>
> Two new system calls are added for this:
>
> io_uring_setup(entries, params)
>         Sets up a context for doing async IO. On success, returns a file
>         descriptor that the application can mmap to gain access to the
>         SQ ring, CQ ring, and io_uring_sqes.
>
> io_uring_enter(fd, to_submit, min_complete, flags, sigset, sigsetsize)
>         Initiates IO against the rings mapped to this fd, or waits for
>         them to complete, or both. The behavior is controlled by the
>         parameters passed in. If 'to_submit' is non-zero, then we'll
>         try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>         kernel will wait for 'min_complete' events, if they aren't
>         already available. It's valid to set IORING_ENTER_GETEVENTS
>         and 'min_complete' == 0 at the same time, this allows the
>         kernel to return already completed events without waiting
>         for them. This is useful only for polling, as for IRQ
>         driven IO, the application can just check the CQ ring
>         without entering the kernel.
>
> With this setup, it's possible to do async IO with a single system
> call. Future developments will enable polled IO with this interface,
> and polled submission as well. The latter will enable an application
> to do IO without doing ANY system calls at all.
>
> For IRQ driven IO, an application only needs to enter the kernel for
> completions if it wants to wait for them to occur.
>
> Each io_uring is backed by a workqueue, to support buffered async IO
> as well. We will only punt to an async context if the command would
> need to wait for IO on the device side. Any data that can be accessed
> directly in the page cache is done inline. This avoids the slowness
> issue of usual threadpools, since cached data is accessed as quickly
> as a sync interface.
>
> Sample application: http://git.kernel.dk/cgit/fio/plain/t/io_uring.c
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |    2 +
>  arch/x86/entry/syscalls/syscall_64.tbl |    2 +
>  fs/Makefile                            |    1 +
>  fs/io_uring.c                          | 1090 ++++++++++++++++++++++++
>  include/linux/syscalls.h               |    6 +
>  include/uapi/asm-generic/unistd.h      |    6 +-
>  include/uapi/linux/io_uring.h          |   96 +++
>  init/Kconfig                           |    9 +
>  kernel/sys_ni.c                        |    2 +
>  9 files changed, 1213 insertions(+), 1 deletion(-)
>  create mode 100644 fs/io_uring.c
>  create mode 100644 include/uapi/linux/io_uring.h
>
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> new file mode 100644
> index 000000000000..ce65db9269a8
> --- /dev/null
> +++ b/include/uapi/linux/io_uring.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Header file for the io_uring interface.
> + *
> + * Copyright (C) 2019 Jens Axboe
> + * Copyright (C) 2019 Christoph Hellwig
> + */
> +#ifndef LINUX_IO_URING_H
> +#define LINUX_IO_URING_H
> +
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +
> +#define IORING_MAX_ENTRIES     4096
> +
> +/*
> + * IO submission data structure (Submission Queue Entry)
> + */
> +struct io_uring_sqe {
> +       __u8    opcode;         /* type of operation for this sqe */
> +       __u8    flags;          /* as of now unused */
> +       __u16   ioprio;         /* ioprio for the request */
> +       __s32   fd;             /* file descriptor to do IO on */
> +       __u64   off;            /* offset into file */
> +       __u64   addr;           /* pointer to buffer or iovecs */
> +       __u32   len;            /* buffer size or number of iovecs */
> +       union {
> +               __kernel_rwf_t  rw_flags;
> +               __u32           __resv;
> +       };
> +       __u64   user_data;      /* data to be passed back at completion time */
> +       __u64   __pad2[3];
> +};
> +
> +#define IORING_OP_NOP          0
> +#define IORING_OP_READV                1
> +#define IORING_OP_WRITEV       2
> +
> +/*
> + * IO completion data structure (Completion Queue Entry)
> + */
> +struct io_uring_cqe {
> +       __u64   user_data;      /* sqe->data submission passed back */
> +       __s32   res;            /* result code for this event */
> +       __u32   flags;
> +};
> +
> +/*
> + * Magic offsets for the application to mmap the data it needs
> + */
> +#define IORING_OFF_SQ_RING             0ULL
> +#define IORING_OFF_CQ_RING             0x8000000ULL
> +#define IORING_OFF_SQES                        0x10000000ULL
> +
> +/*
> + * Filled with the offset for mmap(2)
> + */
> +struct io_sqring_offsets {
> +       __u32 head;
> +       __u32 tail;
> +       __u32 ring_mask;
> +       __u32 ring_entries;
> +       __u32 flags;
> +       __u32 dropped;
> +       __u32 array;
> +       __u32 resv[3];
> +};
> +
> +struct io_cqring_offsets {
> +       __u32 head;
> +       __u32 tail;
> +       __u32 ring_mask;
> +       __u32 ring_entries;
> +       __u32 overflow;
> +       __u32 cqes;
> +       __u32 resv[4];
> +};
> +
> +/*
> + * io_uring_enter(2) flags
> + */
> +#define IORING_ENTER_GETEVENTS (1 << 0)
> +
> +/*
> + * Passed in for io_uring_setup(2). Copied back with updated info on success
> + */
> +struct io_uring_params {
> +       __u32 sq_entries;
> +       __u32 cq_entries;
> +       __u32 flags;
> +       __u16 resv[10];
> +       struct io_sqring_offsets sq_off;
> +       struct io_cqring_offsets cq_off;
> +};
> +
> +#endif

from a user perspective, it should always be easier if all exported
symbols and macros have a common prefix. Here it seems particular
worrisome, because of the missing 'u' in in the defines.

Best,
Bert

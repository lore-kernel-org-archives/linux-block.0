Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B0FC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D320859
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393979AbfAPPRG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:17:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45449 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbfAPPRF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 10:17:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so7451985qtr.12;
        Wed, 16 Jan 2019 07:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAjDxTjXzm9sSrq9C1TboywdVjXzrQ81+FZzqFDpZZ4=;
        b=RzzOgn1HODjc0VoJUGMb3ym3Yc/+LFWihQqNyQrq190TJBRW4moFSKjdGiQ52B0gkd
         bvgZV8dTRFe/xYOmwXuoCW0y4tdPPDlYE8xkTg/vQnoXYakCHHCPTIVv7c+6PYNfr5L9
         v0DNm2sOdDPFBQCl96mRWzg+9nPhD5+f8ZZEijjPg+dAbEgu8sH/OJUhaU4C6tpFQwKn
         gAymVZjvI2eJYjX1JiX2eoWMxL1EnWTFTlhKkQyzO2X5+ojnmi3gv3YJ7bI/xMRBYK0l
         MzdqlC96QE4nF4Rq3AcMPY9LfUs2dbaJVm1BCTfdCdOeve+kk5eoICFH+FzQAyRq/ur2
         3yMQ==
X-Gm-Message-State: AJcUukd29Jw3qwSgK3Z7jIHUd1GJtTqzZaiRlEAsdNKiBr+Lu6Y5b6lv
        htfjXDyQRU+2iRsO0XHyRFXIcHMEix1EYTc2uPJKAD0f
X-Google-Smtp-Source: ALg8bN6fiHZ5nrWzJTAj97xl2bdSo2JEyUifuTIq9AuQq3Ygx+/40DcCrOFO1ahcYl2Ei7FvZ/xstGCTXX0mP46ehOI=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7297457qtl.343.1547651824170;
 Wed, 16 Jan 2019 07:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-6-axboe@kernel.dk>
 <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com> <15b06ccb-4501-f104-9a3a-f028218a0d70@kernel.dk>
In-Reply-To: <15b06ccb-4501-f104-9a3a-f028218a0d70@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 16:16:47 +0100
Message-ID: <CAK8P3a2MuO-wRjYxscP-AOAUjwg6fHRc99Am6xqUmXYrJRt44w@mail.gmail.com>
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

On Wed, Jan 16, 2019 at 4:12 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/16/19 3:41 AM, Arnd Bergmann wrote:
> > On Tue, Jan 15, 2019 at 3:55 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> >> index 3cf7b533b3d1..194e79c0032e 100644
> >> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> >> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> >> +SYSCALL_DEFINE2(io_uring_setup, u32, entries,
> >> +               struct io_uring_params __user *, params)
> >> +{
> >> +       return io_uring_setup(entries, params, false);
> >> +}
> >> +
> >> +#ifdef CONFIG_COMPAT
> >> +COMPAT_SYSCALL_DEFINE2(io_uring_setup, u32, entries,
> >> +                      struct io_uring_params __user *, params)
> >> +{
> >> +       return io_uring_setup(entries, params, true);
> >> +}
> >> +#endif
> >
> > The compat syscall has the same calling conventions as the
> > native one here, so I think you can just use that directly.
>
> Not sure I understand what you mean here. I need to know if it's the
> compat one, hence 'true' vs 'false', so I know what the size of the user
> pointers/structs are.

My mistake, I missed the true/false difference between the two
functions.

> >> +/*
> >> + * IO submission data structure (Submission Queue Entry)
> >> + */
> >> +struct io_uring_sqe {
> >> +       __u8    opcode;         /* type of operation for this sqe */
> >> +       __u8    flags;          /* as of now unused */
> >> +       __u16   ioprio;         /* ioprio for the request */
> >> +       __s32   fd;             /* file descriptor to do IO on */
> >> +       __u64   off;            /* offset into file */
> >> +       union {
> >> +               void    *addr;  /* buffer or iovecs */
> >> +               __u64   __pad;
> >> +       };
> >
> > It seems a bit unfortunate to keep the pointer field only
> > almost compatible between 32-bit and 64-bit big-endian
> > architectures, as that requires an in_compat_syscall()
> > check whenever we access the pointer from the kernel.
> >
> > Could you use a __u64 field to store the pointer itself
> > instead?
>
> I feel like I'm missing something here, we'll still need the compat code
> on the kernel side for 32-bit app on 64-bit kernel, so what would we
> solve by making this an __u64?

It means you don't have to define a compat_io_uring_sqe
structure with a compat_uptr_t member in it.

      Arnd

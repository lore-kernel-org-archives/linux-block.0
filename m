Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21251C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 11:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E1620859
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 11:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbfAPLA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:00:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39779 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPLA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 06:00:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so6630039qtj.6;
        Wed, 16 Jan 2019 03:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EE1Vl4tpp+aRqI7b0ycGAXQ7yS0cVzVTqKrf2bfaL6M=;
        b=ivXBXGz+s2SU3Z0G7pUy5bQrECCbpvttCnwG7359nvRzmyeqbJQ98WoStQj2Te2v7I
         b6VmbKIgduULKC/6A/ca4HD9001XHpGdHeSWKVM+6ngm2ucCERGcSWVtj5PzdCxTr/Qj
         WquEdCvHrR+SacIVtNegR1cw3ZjyHwq35yp+gyHP00jR+Bq5EtOsMd2ib6aq+BOAs/Ps
         WgwuXQgIx+GYYkawN8gKiYWCxl6wQGiJfiaFzO5SC4tHXOeaadaeGPDcP2JboJk7IZK3
         FHR2tQxMuruquCmIi+WPR+3AgejpcPjllRnmkbKz4Wx31r56SQ2JdHJfp3R0Z8Tx92kG
         TsAQ==
X-Gm-Message-State: AJcUukf0gzdMCA2dOMbIOxbapVEUDj7bRb2lkZeUZ+g9gazV2onNTsa5
        Dg46p8CIfB3lkOyCYlVqfDuh/+5dcEcetW1ai58=
X-Google-Smtp-Source: ALg8bN4SC6Y3tAJL/EOFVlf0SPAKQFft22MrSe8mqX8J6auhqIm6HO4/n8pFQG3ZLIPzXw1J0erjDkrTg6dBjcwGipk=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr6433817qtl.343.1547636456498;
 Wed, 16 Jan 2019 03:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20190115025531.13985-1-axboe@kernel.dk> <20190115025531.13985-6-axboe@kernel.dk>
 <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
In-Reply-To: <CAK8P3a19ie7wcndDW7oxmUGh5c9aaarJycKBVOQ2F9+eHj=nsg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 12:00:40 +0100
Message-ID: <CAK8P3a1=-=8YZ+9wsCGJ+gS3G5axHAKXA4XVcEQnyzwHD6fO6A@mail.gmail.com>
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

On Wed, Jan 16, 2019 at 11:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > +/*
> > + * IO submission data structure (Submission Queue Entry)
> > + */
> > +struct io_uring_sqe {
> > +       __u8    opcode;         /* type of operation for this sqe */
> > +       __u8    flags;          /* as of now unused */
> > +       __u16   ioprio;         /* ioprio for the request */
> > +       __s32   fd;             /* file descriptor to do IO on */
> > +       __u64   off;            /* offset into file */
> > +       union {
> > +               void    *addr;  /* buffer or iovecs */
> > +               __u64   __pad;
> > +       };
>
> It seems a bit unfortunate to keep the pointer field only
> almost compatible between 32-bit and 64-bit big-endian
> architectures, as that requires an in_compat_syscall()
> check whenever we access the pointer from the kernel.
>
> Could you use a __u64 field to store the pointer itself
> instead?

To clarify: Using the u64_to_user_ptr() helper function,
you can interpret a __u64 field in a uapi data structure
directly as a pointer. The user space side needs a similar
wrapper though.

     Arnd

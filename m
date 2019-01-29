Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4403C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEAC2147A
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sz5Amy9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfA2XEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:04:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43718 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2XEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:04:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so19459399otr.10
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STIiqkaPYQTMvXf+wVh/AMRq/xKLKGmW+cnmGj29gP4=;
        b=Sz5Amy9RZ26UAyRsdJ9iXyDEOwFZIOmcTbU3+nfNRZnVieHrulJuM4wb7g8xgLtzRn
         +mjnjT4MvlWggckLUAvKKuDy2elHakmu+b8bV6YnoiwxOFr06wZI1+LOY0Q0sRK2MiPx
         6JURywrsO9iC7znAqw0sjTUJJBoqU4UVwhPcoofoARuSPZ/GbBgo6MCDxIKb6iszDCpn
         rSys6q6F4hkEcp+zJ1GjJd/+HGkB8l0sbH08ZmPxBrI2cIEvN45e8+T5RdpEoC3ulpd+
         gBXSIknh2ZwBEVxEAMUTqXmE8zPrdU/GV4GYHNMRz4kK2bwtKw0SRORqGrBSn8R9Fk7J
         lgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STIiqkaPYQTMvXf+wVh/AMRq/xKLKGmW+cnmGj29gP4=;
        b=JpYe5dU5/fCGYZk0F0vIKB7w9WTqDC+LSKYeF4b7QItGUUgecjjaXVF0zY1HT2s9sM
         LeqZE1z28aJJYE2cjOmAN/2cJ14TMUdEVcyRJRmJW1LXLs/OasLl2jeVWyyGyOY7m7qN
         ua4vAvR2BZzoz+it/3eDKmAP0ZPbnO5h3WputnJnYtEy4UGRS4JiBFbzYHatCXRkazPU
         tP5gB0aIlbWh7oJeXxIMeB46SSkX4Islu70ypYhBdAZ4EOqqEtNrg+T73z6Rz70kyxB5
         omu8L9sQ+l7+CBpArDPp+GlRQG46jmGj5Hm2wlx6IBTNUXP4OjqgiXJsEiTiYOCz7TMr
         ZtgQ==
X-Gm-Message-State: AJcUukc2n+lkFDdOTS7Y/+9tqQnk6S7FR3RtYXecsWk01K+gGD5klNia
        2JNIBDaCzPRcH0TPPAljJELMzcqM4u1NDxA3lFhPQ/PPLq34bQ==
X-Google-Smtp-Source: ALg8bN4NF0ClllmMxn+0dkDPNDwNkietdfdiYXNjyv7Rmmx2mVpYm8Sg0NyVUqPoHnIxp+FFzPRre1E+o+Xd1FzKxhs=
X-Received: by 2002:a9d:aa9:: with SMTP id 38mr22221872otq.255.1548803051187;
 Tue, 29 Jan 2019 15:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20190129192702.3605-1-axboe@kernel.dk> <20190129192702.3605-13-axboe@kernel.dk>
 <CAG48ez2VkeSEZA+9H4UAcg86uC77gU=UkTG8L1V58TuR9pDEqg@mail.gmail.com> <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk>
In-Reply-To: <dd366179-c003-752f-743d-2bea4f6b796c@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Jan 2019 00:03:44 +0100
Message-ID: <CAG48ez3x5x+P=8L1p-bHvcUnypeT1TizkXq2+Q0bCP0GdE-bog@mail.gmail.com>
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO buffers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/29/19 3:44 PM, Jann Horn wrote:
> > On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> If we have fixed user buffers, we can map them into the kernel when we
> >> setup the io_context. That avoids the need to do get_user_pages() for
> >> each and every IO.
> >>
> >> To utilize this feature, the application must call io_uring_register()
> >> after having setup an io_uring context, passing in
> >> IORING_REGISTER_BUFFERS as the opcode. The argument must be a pointer
> >> to an iovec array, and the nr_args should contain how many iovecs the
> >> application wishes to map.
> >>
> >> If successful, these buffers are now mapped into the kernel, eligible
> >> for IO. To use these fixed buffers, the application must use the
> >> IORING_OP_READ_FIXED and IORING_OP_WRITE_FIXED opcodes, and then
> >> set sqe->index to the desired buffer index. sqe->addr..sqe->addr+seq->len
> >> must point to somewhere inside the indexed buffer.
> >>
> >> The application may register buffers throughout the lifetime of the
> >> io_uring context. It can call io_uring_register() with
> >> IORING_UNREGISTER_BUFFERS as the opcode to unregister the current set of
> >> buffers, and then register a new set. The application need not
> >> unregister buffers explicitly before shutting down the io_uring context.
[...]
> >> +       imu = &ctx->user_bufs[index];
> >> +       buf_addr = READ_ONCE(sqe->addr);
> >> +       if (buf_addr < imu->ubuf || buf_addr + len > imu->ubuf + imu->len)
> >
> > This can wrap around if `buf_addr` or `len` is very big, right? Then
> > you e.g. get past the first check because `buf_addr` is sufficiently
> > big, and get past the second check because `buf_addr + len` wraps
> > around and becomes small.
>
> Good point. I wonder if we have a verification helper for something like
> this?

check_add_overflow() exists, I guess that might help a bit. I don't
think I've seen a more specific helper for this situation.

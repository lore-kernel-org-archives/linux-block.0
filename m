Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A38C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF0F206A3
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AoUJPIJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfBVPBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:01:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39529 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBVPBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 10:01:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so2777310qtk.6
        for <linux-block@vger.kernel.org>; Fri, 22 Feb 2019 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snXbdXoTsl9AL8sdXnVKZJkHqG3rjy+YCWplazeYIZs=;
        b=AoUJPIJOzQ8QYbSmKcRlK6KkGSI1wXVz40z2VOEcMS08VUos0bbPnuCEMYu/kGyB0z
         XEBLWPJlAaPtPG9CSAnIA37fI3YMkfalWvqdhnkehYwXXib1mRN4trSsxKjoAmzYagSd
         KUmwYEbVHjd6vA5O7PRI48PGaIrXzEIg91sJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snXbdXoTsl9AL8sdXnVKZJkHqG3rjy+YCWplazeYIZs=;
        b=UIT0kgAA/+VJBOdeBu0vzCDxI8kOJUqz1AtJ5MEJ4XNf7ZkDAdi6qIlZRe5/rzTvHK
         Wo11Mj/hMaoYqKGflZwKsY+PE3VZKoUEyH78tt6Wu/HsQcI0ow91FVAQ/qNXSrlQPOEs
         YZVorsSvq3OyTVBqd89Y9a/ebbw08c94+eMj0/zyW8eCkKPXDktgwFnZPA8ZR8ntbfLq
         OCDmVZXXP3/jb4L1vLXHvzO55lXJL0XYzQgSoh5nsp2y2u+TcydReR6SEWkJggr9mt9m
         Nhf0SfHdnpO93IceLXn8gkRLMN2f7oTqWzihnY8drKdvHFL1qwoQ3Vuq7SSnFKBJnYff
         l+VA==
X-Gm-Message-State: AHQUAuanC0tHrhyRYNRoMCRIpr7wyZ4qVSa6KL7DmAhwMKcZ0gc37B3F
        JJkNl2J/KFSkrnDGfvAA4TMDAL1FhB3Ue5vOLtpcTg==
X-Google-Smtp-Source: AHgI3IbVj7pNKswEu0DjFpnzC7E0/ttO0hxTjqEQL/s1CF04iu2Y+5qcXJqHZYQZtCVYCHnZwJZrTWN5f183w1dOX6Y=
X-Received: by 2002:ac8:3802:: with SMTP id q2mr3300495qtb.325.1550847672913;
 Fri, 22 Feb 2019 07:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20190211190049.7888-1-axboe@kernel.dk> <20190221121022.7867-1-marek@cloudflare.com>
 <e9b96cd8-71a1-d5bc-e3cf-8248f9654deb@kernel.dk>
In-Reply-To: <e9b96cd8-71a1-d5bc-e3cf-8248f9654deb@kernel.dk>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Fri, 22 Feb 2019 16:01:00 +0100
Message-ID: <CAJPywTLGBRviKYSf+AQg-0eOZ3pnyTFEhr28no9Zrh8ftsSxmQ@mail.gmail.com>
Subject: Re: [PATCHSET v15] io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Avi Kivity <avi@scylladb.com>, hch@lst.de,
        Jann Horn <jannh@google.com>, jmoyer@redhat.com,
        linux-aio@kvack.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 21, 2019 at 6:48 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/21/19 5:10 AM, Marek Majkowski wrote:
> >> From: Jens Axboe <axboe@kernel.dk>
> >> Subject: [PATCHSET v15] io_uring IO interface
> >> Message-ID: <20190211190049.7888-1-axboe@kernel.dk> (raw)
> >>
> >> Some final tweaks, mostly cosmetic, but also two important fixes:
> >>
> >> 1) Ensure that we account the skb appropriately against the socket.
> >>    Some network config options apparently return is an skb with
> >>    ->truesize != 0 when allocated with a size of 0, ensure we add
> >>    those as references against sock->sk_wmem_alloc. Reported by
> >>    Matt Mullins.
> >
> > Jens,
> >
> > I tried using io_uring with network sockets. It seem to be doing the
> > right thing. One bit is missing though: "flags" as in recv(2).
> >
> > In perfect world I would like to specify at least:
> >  - MSG_DONTWAIT
> >  - MSG_WAITALL
> >  - MSG_NOSIGNAL
> >
> > Right now, unless I'm missing something, io_uring_sqe doesn't have a
> > place where we could store these. "flags" is needed for any
> > non-trivial network I/O.
>
> We have flags for sqes, depending on the type. You can add to the
> union that already holds rw_flags/fsync_flags/poll_events? There's
> also a (smaller) flags field that applies for all types, which
> currently only holds the fixed file flag.

The "sqe->flags" right now is used by the IOSQE_FIXED_FILE which has
the same value as MSG_OOB.

Sticking recv/send flags into the "rw_flags" union perhaps could work,
barring the discussion about naming. The obvious names don't make
sense. recv_flags, send_flags or socket_flags don't sound right.

If we tried to add networking stuff to io_uring (for batchinig and async), then:
 - send()/recv() could work, only needs the "flags" field
 - sendmsg()/recvmsg() likewise
 - sendto()/recvfrom() require two more pointers: (struct sockaddr
*dest_addr, socklen_t addrlen)
 - sendmmsg() / recvmmsg() are perhaps irrelevant

Non-blocking stuff like socket(), setsockopt(), bind() perhaps don't
need to be considered, although could benefit from batching.

Not sure what to think about connect() and accept(). In the
prehistoric days there seem to have been an attempt to add socket
things to libaio struct iocb. See:

https://code.woboq.org/linux/include/libaio.h.html#iocb::(anonymous)::saddr

struct iocb {
    ...
    union {
        ...
        struct io_iocb_sockaddr    saddr;
    } u;
};

Are there chances of reserving space for two pointers in io_uring_sqe,
which could be used for sendto/recvfrom/accept if we decided to add
more network support?

Cheers,
    Marek

> If you're talking on a per-syscall type of flag, io_uring_enter(2)
> does take a flags member.
>
> --
> Jens Axboe
>

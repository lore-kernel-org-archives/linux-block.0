Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCDC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhLUQEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhLUQEJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:04:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F3C06173F
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:04:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 131so40099553ybc.7
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0roCqRwBVDlG3ZY65wGgF0zPM6igK5cwoWbgit1/YI4=;
        b=ivqIGI/KEh3aqvtfjIDOc/Es6avHmhJ8sdvnEc9Ai/lVNTM6sXIhd7yyVJkd0zJfVc
         Gj7NjooTymJGQ++gTM7x7xQxtsN+uvQD1TfM9U2SaNJozKgKseF+z4aC3zPe/Hiyo1lA
         xo0oYvohryFUtbZJh61O2widNyobZBGA1oAQVnjMM7imhIOoUpP/Er2U0o5jv2M9zyMH
         OuM0PviL4m8wy30aSqh0E31abJOKeh2RH71+HAV/ZujEV9zwL6QcT7x4I15HgAiCQjyi
         lbWZpWxs2LVQj4rLzZznhPun9nh+JqmejVgHODL/amc2mt6HqijdOs8eQJAEZrSY0SiS
         T6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0roCqRwBVDlG3ZY65wGgF0zPM6igK5cwoWbgit1/YI4=;
        b=sAPVeNx70FZJXZsYS/30RxdA25foVcna9nPEr0U2mhJdo8ctsTCM35etVvTwkCbuOK
         Y4VviE6LruZz5tVCSHllA4c7+I9DhPThS7Vw+GrMvomCjwYny45PUSZQAn7wOVkr5LRo
         9Mx87peVyQeYkwlYErD3BP8Ge2jk9MM0xU1d3TMkQQBMTDW2WcvKT5wylLNRtRqANjIh
         Gfaz5F740kutbVnPzG9NbYsRw38ypyHz3fmaUOOkdlFHEWQNHwDdGGZ04KqyldKoixhg
         vw69mGOeCeiiY5Qa2hAU4zguDs2+mkcV3XXxRJR9zOIxOJD8m3tN3Q7Ondtm2mJfkbex
         dedQ==
X-Gm-Message-State: AOAM531DcE3G6yCGdbW7fKcCpWrxcBrz3rLm+O7NBaRGoNjMwYct2v0o
        o/Yjss55+M9rLAHL3Sr7A3CI3ajv4Tij1qQ9VcsGwg==
X-Google-Smtp-Source: ABdhPJzzns+hChUDZbOHQEm/E9TmmuZM8sZ7oacian8uS0tNDMDu1xMFR62ZsNiEzzke81Jc3knotpgxEeZ8ttZAfl4=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr5545758ybt.156.1640102647638;
 Tue, 21 Dec 2021 08:04:07 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c70eef05d39f42a5@google.com> <00000000000066073805d3a4f598@google.com>
 <CANn89i++5O_4_j3KO0wAiJHkEj=1zAeAHv=s9Lub_B6=cguwXQ@mail.gmail.com> <e3a30c8c-3f1a-47b5-57e7-1b456bbc8719@kernel.dk>
In-Reply-To: <e3a30c8c-3f1a-47b5-57e7-1b456bbc8719@kernel.dk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Dec 2021 08:03:56 -0800
Message-ID: <CANn89iJfEgkJCBqO9d7t9BHHMEh-6DQ1BJkqkiOQ59dxSHB2EQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in set_task_ioprio
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>,
        Christoph Hellwig <hch@lst.de>, changbin.du@intel.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yajun Deng <yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 7:25 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/21/21 3:44 AM, Eric Dumazet wrote:
> > On Tue, Dec 21, 2021 at 1:52 AM syzbot
> > <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com> wrote:
> >>
> >> syzbot has bisected this issue to:
> >>
> >> commit e4b8954074f6d0db01c8c97d338a67f9389c042f
> >> Author: Eric Dumazet <edumazet@google.com>
> >> Date:   Tue Dec 7 01:30:37 2021 +0000
> >>
> >>     netlink: add net device refcount tracker to struct ethnl_req_info
> >>
> >
> > Unfortunately this commit will be in the way of many bisections.
> >
> > Real bug was added in
> >
> > commit 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Thu Dec 9 07:31:29 2021 +0100
> >
> >     block: open code create_task_io_context in set_task_ioprio
> >
> >     The flow in set_task_ioprio can be simplified by simply open coding
> >     create_task_io_context, which removes a refcount roundtrip on the I/O
> >     context.
> >
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> >     Reviewed-by: Jan Kara <jack@suse.cz>
> >     Link: https://lore.kernel.org/r/20211209063131.18537-10-hch@lst.de
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> There are only really 5 patches in between the broken commit and the one
> that fixes it, and it only affects things trying to set the ioprio with
> a dead task. Is this a huge issue? I don't see why this would cause a
> lot of bisection headaches.
>

I was saying that my commit was polluting syzbot bisection, this is a
distraction in this report.
(Or if you prefer, please ignore syzbot bisection)

linux-next has still this bug in set_task_ioprio()


> --
> Jens Axboe
>

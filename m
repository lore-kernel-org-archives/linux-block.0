Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34ADC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CCD20657
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yqjdboxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfCLQVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:21:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39863 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCLQVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 12:21:36 -0400
Received: by mail-it1-f196.google.com with SMTP id l15so5439953iti.4
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tawD2D2yhPxJ6jVXdtHNzTe8sO1hTye0ddBxemZiBK0=;
        b=YqjdboxfbzNopV2x9tMkBvHEJbeEETBfuKrR724GZBynKUEkKw8bhWCs/cXMaZaqh5
         SqPg4ybL65uJ3DELHxUp1gO18+ChmybO41/MrzeHwf67CE7ifx5j8OZ/wrhB/uyVHK7C
         LscohqQm2NR/vhYni5KBEmiOn6kJYmhlBwBa6n+x9xAqVgzYfBPc6I9oGkGZ452XXSM3
         DERK2nDBJUYXoh5ioWq7qES+9dHLOlH6lr7QopZLcyaSR9zM9lPn9O89HVa6146Le78L
         gfADH6PaRS/S6+otmKDpA9/ZARjKj+lWSYH8iprM9tsVNeLMedjCNnJJ9QzjnyekXqTM
         3DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tawD2D2yhPxJ6jVXdtHNzTe8sO1hTye0ddBxemZiBK0=;
        b=WfQwT7zhBCNiOIniqBPmqzaZxYkcDtYyOpqQy3Iq5OTx32sO2+3S4M2oHH4DqUa4na
         x334KZsUeRRdMpRitzYoMFgeISE3CcUrRjG3d9SNSjqlvBawtQcyDzjA5yP7i50Az2Io
         Xxes6w+XRwVrnqWINvNp7XA4SmZhymiU9OYEGxpRTb75xfbiFl/T1qnr6pgbSB0zvMxc
         8wIGVLfbofZ3tzop25IAybEcshdx5zgd6OT9NGWUErgkHk8ofx12y2W6BgJVVZQibcQy
         3Lvj0iqWT9HJ0gBLIZ0q5/XiFD29uvS6kp5Qb+7w126QXNNu5LaqwORBSwZ1UK2Hmdf4
         MAMQ==
X-Gm-Message-State: APjAAAWpW1zueb8EHQkes1Ymad6n2pxH0u54chH0sqKru6zP3MXArSFd
        B5wN30PlYhJ+qMKrqboUQ2XQzCPy1IFUZU85YQE/lA==
X-Google-Smtp-Source: APXvYqxZqJuNvoPlZ3IOIz9BjknrvsaJ96W7l03bb8D4EOLmlNa3I1X5HOC7soEMtdHoeGrvjq7QOf3Q+27pWMVKaVc=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr2338356itl.166.1552407695236;
 Tue, 12 Mar 2019 09:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004cfa120583e1dfc3@google.com> <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
 <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
In-Reply-To: <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 17:21:24 +0100
Message-ID: <CACT4Y+ayyFe6oek8MdnUd1LsB_+1kpJatBLnmF_jCttQPyCK0g@mail.gmail.com>
Subject: Re: WARNING in hsr_forward_skb
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>,
        arvid.brodin@alten.se, Jens Axboe <axboe@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Miller <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 12, 2019 at 5:09 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Mar 12, 2019 at 1:02 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >
> > Hi all,
> >
> > I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any
> > problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly
> > assume this patch showing up in 4.12-rc6
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169
> >
> > fixes the problem.
>
>
> Hi Oliver,
>
> You can see how bisection progressed and got to 4.12.0-rc2+ in the
> bisection log.
>
> The commit that it come up with looks unrelated.
> I've started collecting such cases at:
> https://github.com/google/syzkaller/issues/1051
> and added for this case:
>
> =====
> Bisected to wrong commit.
> Root cause: broken kernel boots, bugs that happen on all tests.
> Boot is broken for several releases with "WARNING in hsr_forward_skb",
> this switches to a bug that happens during every test "INFO: trying to
> register non-static key in can_notifier", which then leads to a
> completely random commit.
> =====

Broken boots did not happen here. "WARNING in hsr_forward_skb" is the
crash that we pursued, so it started correctly. But then diverged to
an unrelated "INFO: trying to register non-static key in
can_notifier".

> > On 3/12/19 9:57 AM, syzbot wrote:
> > > syzbot has bisected this bug to:
> > >
> > > commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> > > Author: Ming Lei <ming.lei@redhat.com>
> > > Date:   Fri May 26 11:53:19 2017 +0000
> > >
> > >      blk-mq: merge bio into sw queue before plugging
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
> > > start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
> > > userspace arch: amd64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000
> > >
> > > Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
> > > Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/7dd5ffca-803d-9d5e-7fa4-f9eed2249d26%40hartkopp.net.
> > For more options, visit https://groups.google.com/d/optout.

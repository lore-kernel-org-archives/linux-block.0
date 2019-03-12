Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DEDC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 16:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF9A2054F
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juse9bYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCLQJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:09:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36899 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfCLQJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 12:09:50 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so2591601ioh.4
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kh8bQb4mSaWARPNhMLszRALRE3JH2YOmK726nx76yqY=;
        b=juse9bYmNattHX7FRGXyyQybHV0LWbrpvDBsBMN7P2U4PhLRnPEyz8y17Kv4b32o41
         2hh9grK48fofde1N17Gvh8dedawDyV/z1xWW8EXuu4o96WXsaS2m8sGIH/ZR7Jqsjhyi
         nIzEUszuNXAGqQ7WYI2IHyokbKjECjGVVEZ5RBVBJHabnk+sp5n8b75VtOzGC/tME/mD
         ps3Fbc70rBLkZLLa6Yo4r4pctOi28vU4UlL6jrWtRop7+fhTCoL+OtTibq5WsVF7XE5x
         mb+3nBEycv+wS8Q0Zzx2rPAan7wdk8VyNJ5kk/xC+sfis9GyGOgJkxhpF/nDaWhN82GQ
         rEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kh8bQb4mSaWARPNhMLszRALRE3JH2YOmK726nx76yqY=;
        b=iM5k0jEsfwGNxUsAcUwWgSuhWOX4V3K16Xev6MdHe90qhMtDcpGcE7zZWVMUfwUrAU
         8YRGsXUyLnC+IXbl+Xzh7sqL0D/xK/t16UD1FX+XzKTrICuYpYzBO3yDRCSZsAFizZur
         KYOEzOFzr7/FqgIZYO9uyfCPepeZZ+UfsJpWZ5kYF97K7Ea8fuUUL6Y59hP4NSZ8KSDr
         86vQ6kB34x45oQbNunuIrBQ3+0w2A9eIc5OGOhrA26gXySt6TGACfaeUDcZTcM9HpVAC
         IgL/kwXEolTLNhTNMOljyZG+x2oaK8HDp10AcHi/wBBtKgXgzC5onwnGUvMjvEuu07EC
         J0Ew==
X-Gm-Message-State: APjAAAVN6ybxgE+7DWAiqpmNu8YntdyXSzkmFHJ9wA3WlgD6b7a37WB4
        SKhXAO5ndQCbVoTqMdpZP39+4XqqnCMa/D1owmZQ5g==
X-Google-Smtp-Source: APXvYqzsmCOIOoae8MQsMGmR6tOnBXtoJNEOJuyIrNLm+28Xyy6W4DqxyD8yBfCU2sIDXiM/xhJMQ8qyBYg8lzJC+uU=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr10893949ioa.282.1552406989491;
 Tue, 12 Mar 2019 09:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004cfa120583e1dfc3@google.com> <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
In-Reply-To: <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 17:09:38 +0100
Message-ID: <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 1:02 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi all,
>
> I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any
> problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly
> assume this patch showing up in 4.12-rc6
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169
>
> fixes the problem.


Hi Oliver,

You can see how bisection progressed and got to 4.12.0-rc2+ in the
bisection log.

The commit that it come up with looks unrelated.
I've started collecting such cases at:
https://github.com/google/syzkaller/issues/1051
and added for this case:

=====
Bisected to wrong commit.
Root cause: broken kernel boots, bugs that happen on all tests.
Boot is broken for several releases with "WARNING in hsr_forward_skb",
this switches to a bug that happens during every test "INFO: trying to
register non-static key in can_notifier", which then leads to a
completely random commit.
=====


> On 3/12/19 9:57 AM, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Fri May 26 11:53:19 2017 +0000
> >
> >      blk-mq: merge bio into sw queue before plugging
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
> > start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
> > userspace arch: amd64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000
> >
> > Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
> > Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/7dd5ffca-803d-9d5e-7fa4-f9eed2249d26%40hartkopp.net.
> For more options, visit https://groups.google.com/d/optout.

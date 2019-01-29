Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCFDC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA6D21473
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfA2QTJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:19:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41805 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA2QTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:19:08 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so22825002qtf.8;
        Tue, 29 Jan 2019 08:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G78Lj7zpbKs+j8sT7EfxpP9X3HCG8CZfVgj/dWq6DtQ=;
        b=mNCkOXurRNDqb3o71yVGl7UMDPqDHW5PXk/vXGIH1KBIwbC52R7ViaILP/GaDjPcAZ
         CnUkOITvtDXiTCudx6rHP7siF7CrT5kdTdJf8FURLq01HopgyX7jFAc5aELgcTY8SS9a
         BeFtAPdFZ1h3lhBP2PJkYS/Znm2u7iR4BrjaAuTrlcx6fLSJ/1TWetAWwklI6cUzseHm
         WlWVPpLhchZ4FXlq3zmuYIoFUQIaysk9cAqi1jkOsCn3Pt+aSQ4jfKc7PM8FWCH7y7X/
         HV14zHPjvHzoAUnpMhNoHoXmkb76pDnd3YEwA34KVMWbbjjGrPOhKs+jtB9vpS11YDpx
         cm+g==
X-Gm-Message-State: AJcUukft2WntmaE9j3CdgjgJB+j/bpyqLB86YVrUn0zEzGICmiXbZtBU
        H9Z/ZqgTwdacXIDMBjVNLrBbamdGM+a65yVHTNU=
X-Google-Smtp-Source: ALg8bN7SKgnnUB+QLzJ8uHl82pfXdRKzFhZFbsTliTUkXR4QKr0vKHbPSZzdtN3TamwiNMf96kETkUcYxmqXngT20IE=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr24544482qvk.40.1548778747352;
 Tue, 29 Jan 2019 08:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de> <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de> <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
 <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk>
In-Reply-To: <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Jan 2019 17:18:50 +0100
Message-ID: <CAK8P3a38-FLBH0sp0vaebv29M5oDyiUkwwmVY+9_S3vSER9n5Q@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/29/19 4:58 AM, Arnd Bergmann wrote:
> > On Tue, Jan 29, 2019 at 7:30 AM Christoph Hellwig <hch@lst.de> wrote:
> >>> On Mon, Jan 28, 2019 at 11:25:12AM -0700, Jens Axboe wrote:
> >>>> Especially with poll support now in the series, don't we need a ѕigmask
> >>>> argument similar to pselect/ppoll/io_pgetevents now to deal with signal
> >>>> blocking during waiting for events?
> >>>
> >>> Is there any way to avoid passing in the sigset_t size? If it's just a
> >>> 32-bit/64-bit thing, surely the in_compat_syscall() could cover it? Or
> >>> are there other cases that need to be catered to?
> >>
> >> As far as I can tell we never look at it, never looked at it and don't
> >> have any plans to look at it anytime soon.  But when I tried to omit
> >> it for io_pgetevents I got stong pushback and thus had to add the
> >> crazy double indirection calling convention.
>
> That's good info. I am currently using set_user_sigmask() for it.
> I'd really like to avoid having to pass in a sigset_t size for the
> system call, however.

I really wouldn't do it, given that all other signal handling interfaces
are prepared for longer signal masks. You /could/ probably extend
it later with a flags bit to signify a longer mask instead of using
the entire register to hold the bit length, it just seems really
inconsistent with all other system calls.

      Arnd




> What's the best way of achieving that? Can I get
> away with doing something like this:
>
>         if (in_compat_syscall()) {
>                 const compat_sigset_t __user *compat_sig;
>
>                 compat_sig = (const compat_sigset_t __user *) sig;
>                 ret = set_compat_user_sigmask(compat_sig, &ksigmask,
>                                                 &sigsaved, _NSIG_WORDS);
>         } else {
>                 ret = set_user_sigmask(sig, &ksigmask, &sigsaved,
>                                                 _NSIG_WORDS);
>         }

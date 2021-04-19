Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B93C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 18:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFCD61245
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 18:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhDSSjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhDSSjN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 14:39:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CA2C06174A
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 11:38:43 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so7577650otp.11
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FfwCKpFu+KZSiZGRhLsDEaWnJCMxD66Q3cGmOFACWNo=;
        b=VVu0gpiJqae8kMOBe3aDoFrfxAJ3CsuWnw/mVM0x2Z7j9Kh1L+a5E/FDbWgD6rgsVm
         xWkAw3UyDrgeEodgkivfkgeWUpFIZj3cv0PmNYBSTH+belJAxn5QW2PlLRt0UgoTrDv5
         0x5nDJ1N/+aRG0EgnyT6c++v3qNrGPxcxXxRTZvXpMyHLin7GgDgqj4r7LI1VqOL0RQv
         ocM2LSAu5c5RloYOUUTO8qKnT7g1GEjeBBaLKI+Cbqu56ssKJDDwlmPPVgoVfysj5TR7
         hx8nLvlSeJC0XW45MYQ79CM4QHh+WODF74bdw1UhZAdSKKVE11zugbKcQLUSOXTRC7JE
         8X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FfwCKpFu+KZSiZGRhLsDEaWnJCMxD66Q3cGmOFACWNo=;
        b=o0IgivuSEz7aS/UDs1aDopInLXYD4ulPa81Vm3QQow37P6tffs1JuDGtsFbM3OsTwm
         0MBF/vmZskEnHDmdsMpuv75gtF2Y5V3mnBJoGDPOAVnuaU5JSiFkQydm3/xKc7SzgvDF
         tHcxqIJVNSVWII/ADupl6xGwuqNEaX1S04AQ9MBzvf39/WV8HtiwXndVydB6X0Ryuk8n
         97INFhi0Af1Y3pS7W9wqePdruoypGOaziFskLNcRjOmnM6LqnWgun7ELyPScDlyF8LXF
         qLXsu6Aj/FTLhudpf+8mTSmV+opyOOXfcmzQgVC6X5thM1ieAZztlViP8Ml9JHrsjcfU
         tXPg==
X-Gm-Message-State: AOAM532gVkEwU6DZRT2Ll/rUyj7G9UTfFLQn1hk2cIVajgOrWMuS7FK4
        LiVJSqRL1JbiE2G11bcQsZKCFmMubbpxRx1XdQw=
X-Google-Smtp-Source: ABdhPJx2CALHMdl0YTYheEWUOspDwJAYIiUnXjQC1cHydsMuDCE23XQKA+W65BYcjCq7gm4tbCWTdvidw9HXnc7VGLI=
X-Received: by 2002:a9d:12e:: with SMTP id 43mr16342012otu.90.1618857523078;
 Mon, 19 Apr 2021 11:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210413150319.764600-1-stefanha@redhat.com> <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
In-Reply-To: <YH2VE2RdcH0ISvxH@stefanha-x1.localdomain>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 19 Apr 2021 11:38:07 -0700
Message-ID: <CAMe9rOpK08CJ5TdQ1fZJ2sGUVjHqoTHS2kT8EzDEejuodu8Ksg@mail.gmail.com>
Subject: Re: [PATCH liburing] examples/ucontext-cp.c: cope with variable SIGSTKSZ
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     libc-alpha@sourceware.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 7:35 AM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> On Tue, Apr 13, 2021 at 04:03:19PM +0100, Stefan Hajnoczi wrote:
> > The size of C arrays at file scope must be constant. The following
> > compiler error occurs with recent upstream glibc (2.33.9000):
> >
> >   CC ucontext-cp
> >   ucontext-cp.c:31:23: error: variably modified =E2=80=98stack_buf=E2=
=80=99 at file scope
> >   31 |         unsigned char stack_buf[SIGSTKSZ];
> >      |                       ^~~~~~~~~
> >   make[1]: *** [Makefile:26: ucontext-cp] Error 1
> >
> > The following glibc commit changed SIGSTKSZ from a constant value to a
> > variable:
> >
> >   commit 6c57d320484988e87e446e2e60ce42816bf51d53
> >   Author: H.J. Lu <hjl.tools@gmail.com>
> >   Date:   Mon Feb 1 11:00:38 2021 -0800
> >
> >     sysconf: Add _SC_MINSIGSTKSZ/_SC_SIGSTKSZ [BZ #20305]
> >   ...
> >   +# define SIGSTKSZ sysconf (_SC_SIGSTKSZ)
> >
> > Allocate the stack buffer explicitly to avoid declaring an array at fil=
e
> > scope.
> >
> > Cc: H.J. Lu <hjl.tools@gmail.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Perhaps the glibc change needs to be revised before releasing glibc 2.3=
4
> > since it might break applications. That's up to the glibc folks. It
> > doesn't hurt for liburing to take a safer approach that copes with the
> > SIGSTKSZ change in any case.
>
> glibc folks, please take a look. The commit referenced above broke
> compilation of liburing's tests. It's possible that applications will
> hit similar issues. Can you check whether the SIGSTKSZ change needs to
> be reverted/fixed before releasing glibc 2.34?
>

It won't be changed for glibc 2.34.

--=20
H.J.

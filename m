Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFEC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13DB23B01
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbhAVUcv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 15:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbhAVUa2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 15:30:28 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742D6C06174A;
        Fri, 22 Jan 2021 12:29:18 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x6so6710227ybr.1;
        Fri, 22 Jan 2021 12:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=00n2hrND1c+2yc6bRKCXZsmM9chMlRVzMA68fmp8a9Q=;
        b=KAh/3Gnwj/k+vxMnlmuVhuOzZIHVPwKl3PCpGu0lrp0r8Hv/Aor/Kw2/fQKHToJlZH
         LCUaMJdnY06/dQ7Dqx7ZnO816fvPmCyQbZvToDmMzy4cK270t66My3atYRWQoVget3hI
         WjM+SbDwtUgPfHn6jDCDbyZuepDqDaT/TBrc2GJFHVN4kqw/MjakjBhbWkRd3vT7W81Y
         yhd9BEMOAeG15ATofHPHgJZW8i7fDRALtOuaf5Njfwo84Dw82/Ovwp4iEg4GsX5s8HjU
         LrMjqogcIHg9xhBwg0MUUqkMELJqMx5O//sLs3PBusZbtLLyKdUQajmrqptAD12kD1xo
         yDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=00n2hrND1c+2yc6bRKCXZsmM9chMlRVzMA68fmp8a9Q=;
        b=SowOoMtHflqcOGoe4l83SFfz4BdDwikRvYJt8u3bdIIXPv1QoPotglp3fuG+vVUSsk
         BHP3emfcMIIl7rLd/KReCyYYjhNitYqE6Oe6Z4ck9AH5mQsozEs/4HeYxOSwyz4gv7Sr
         QehLK5YDvCg7pum2G63pA2Lj7BlVzQsr2RkErQ8Is1NgonXAt1ILyz94OwSjhi2Hfmp5
         DE0DP3dl9k3piaguNFD2RPLlRW8d4bVLDDYIqGZqmlkTmtdOo17xROuvJSUs/e37hW3A
         UmoL2qn+quVGSym7iX5ZKt4mZpre9kJUFvvmWMPdGuuvxTxZXIdjfdt1/iebWOQ+J6V+
         KMiA==
X-Gm-Message-State: AOAM5319NCHzHofrYmgLHlcxiI1hDAGYpI9137r4iZOZtVsfB7zcv/DK
        8uuuR07rvOEkuZZbZ6F47wXsSljYkiKM9IWp99o=
X-Google-Smtp-Source: ABdhPJwMnRSh9Qy9DsHqtNZ1ALa5pnNf6DxZ3rfBDbNwLZjYn4s2wgLwFuRLXFgf1umRiAd3cn3milbx8byEhWxRmbg=
X-Received: by 2002:a25:5583:: with SMTP id j125mr8289674ybb.307.1611347357428;
 Fri, 22 Jan 2021 12:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20210119105727.95173-1-roger.pau@citrix.com> <CALUcmUkd9Eeau6tC9ZWHbLdvHTYfY34LvK6KKpOOxreYF67Myg@mail.gmail.com>
 <20210120143515.v2vgyhcxrhnnng6r@Air-de-Roger> <CALUcmU=6aAUrkg8KkJQvsQvNr1yL3E88Uy5xsD+u+XOrbUAhCQ@mail.gmail.com>
In-Reply-To: <CALUcmU=6aAUrkg8KkJQvsQvNr1yL3E88Uy5xsD+u+XOrbUAhCQ@mail.gmail.com>
From:   Arthur Borsboom <arthurborsboom@gmail.com>
Date:   Fri, 22 Jan 2021 21:29:01 +0100
Message-ID: <CALUcmUmBz76p_kHy2yA1v-F_vuTtMwORsqH4gtS04wvV4nQosw@mail.gmail.com>
Subject: Re: [PATCH v2] xen-blkfront: allow discard-* nodes to be optional
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any chance of getting this backported to stable?
I believe the previous attempt by CC-ing stable was not following the
correct procedure and probably rejected.

https://lkml.org/lkml/2021/1/19/543

On Wed, 20 Jan 2021 at 16:17, Arthur Borsboom <arthurborsboom@gmail.com> wr=
ote:
>
> This time the patch applied cleanly.
>
> The trim command seems to work as well, meaning no error messages and
> a certain amount of blocks (5GB) is trimmed.
> The trimming did consume a bit of time (10-20 seconds), assuming it is
> actually discarding the blocks at the host.
>
> First run:
>
> [arthur@test-arch ~]$ sudo fstrim -v /
> /: 5.7 GiB (6074368000 bytes) trimmed
>
> Second run:
>
> [arthur@test-arch ~]$ sudo fstrim -v /
> /: 0 B (0 bytes) trimmed
>
> No errors were reported in the dmesg of the VM; no errors in Dom0 and
> no errors in dmesg of Xen (xl dmesg).
>
> Based on this single test, it seems to work.
> You can add me as Tested-By.
>
> On Wed, 20 Jan 2021 at 15:35, Roger Pau Monn=C3=A9 <roger.pau@citrix.com>=
 wrote:
> >
> > On Wed, Jan 20, 2021 at 03:23:30PM +0100, Arthur Borsboom wrote:
> > > Hi Roger,
> > >
> > > I have set up a test environment based on Linux 5.11.0-rc4.
> > > The patch did not apply clean, so I copied/pasted the patch manually.
> > >
> > > Without the patch the call trace (as reported) is visible in dmesg.
> > > With the patch the call trace in dmesg is gone, but ... (there is alw=
ays a
> > > but) ...
> > >
> > > Now the discard action returns the following.
> > >
> > > [arthur@test-arch ~]$ sudo fstrim -v /
> > > fstrim: /: the discard operation is not supported
> > >
> > > It might be correct, but of course I was hoping the Xen VM guest woul=
d pass
> > > on the discard request to the block device in the Xen VM host, which =
is a
> > > disk partition.
> > > Any suggestions?
> >
> > Hm, that's not what I did see on my testing, the operation worked OK,
> > and that's what I would expect to happen in your case also, since I
> > know the xenstore keys.
> >
> > I think it's possible your email client has mangled the patch, I'm
> > attaching the same patch to this email, could you try to apply it
> > again and report back? (this time it should apply cleanly)
> >
> > Thanks, Roger.
>
>
>
> --
> Arthur Borsboom



--=20
Arthur Borsboom

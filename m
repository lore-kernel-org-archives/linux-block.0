Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E79C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D2F20872
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrS34rOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfCYLKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:10:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40662 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLKQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:10:16 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so7229614iof.7;
        Mon, 25 Mar 2019 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oAueFEIqCD9AhXmVlTTPGBWAf4NW1uC3bpMLU2svQXw=;
        b=qrS34rOikrfVr5ZViCsef8iowfUfG+rwWJqB+oI7kwL5X79mlZVc5jlKzjEP4YcqaS
         rjJvLkVmXgUlsBdAzdWNuRkn8pzmLCkqWhm6PSKADeuYIbpCTuxgl9HX/Id/J/SG2pR3
         fFsUFq0NICyrEQHiyRBRHVwBBW3W0TWTvota064CEBNApAxbLIsKKfmd7X2VmwZpWnPm
         Zr+Zsx7GdxAVP9jLNKpYS9lmL2fwyXvZ8mBgtztO2Ft384tVvzT16rf3694Fqf8rIlsD
         q0SMJ+3e3J10MVtKrHjzP+Fn/1Gb5dbRMun5NUD8CXQrqMx/h5rkYapNLzOLCB1N62B4
         2YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAueFEIqCD9AhXmVlTTPGBWAf4NW1uC3bpMLU2svQXw=;
        b=eUGagWnaRp+YXxi4k/rdckc3nf2mh59yeQ5s0YVVSpdRzxTftpd6yrtyvAgbxVYjA5
         g5LlHn0NdWQUmPUSYYTeXm36QGAGD3DMTs4dL1IxNICFOs+wqjmjdgAG0p4/46c/0R/5
         AoGf71vOpTE2j/5uXOJcmqoTR+7p2pPegac3ewE2Rzt3n/M6JOG7mOYhCyFkws+liSn1
         c8pTGjgJsp1dUnQdpna2yqm/V5k6gIKUHlik4VT0jw8I/nwDYCf9dykxY0aDqy+2nqw4
         jUO/i+901h1/66ruoauBpq0gs7E+6Kh1nuvu2O1bB0l0Y2YoYnB73bD/PwalCVGmWh7G
         LpGQ==
X-Gm-Message-State: APjAAAUikaV5Xs/bmnIGRDvjqbmU/o2EJkANu8vSGThgptSkhu1TPg9u
        kWKOpmuEUHezcaxU/+OjOxtxnOY4OvZHIJ9SoE2JIZDV
X-Google-Smtp-Source: APXvYqxurMcVvllu5vSwBlwo1iIIHbjfzW6jz4eekPxogfbBvPT53bFo/zuysyB2/qZX381CSibLA4DoJhvkSOPDkPc=
X-Received: by 2002:a5d:984a:: with SMTP id p10mr16351129ios.217.1553512216107;
 Mon, 25 Mar 2019 04:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143643.1317312-1-arnd@arndb.de> <CAOi1vP9scH+DECa1udToEvtYMRTZ1-VMuVajAh8uwpxzuMq0RA@mail.gmail.com>
 <CAK8P3a2mZ-zyAMrR2zesAUoLO0BiDcmr6VnJzuJb=PFSHj4PWg@mail.gmail.com>
In-Reply-To: <CAK8P3a2mZ-zyAMrR2zesAUoLO0BiDcmr6VnJzuJb=PFSHj4PWg@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 25 Mar 2019 12:11:34 +0100
Message-ID: <CAOi1vP9GdfiT5WffcdRN=dLYpW8dwocO8sHLw_S0FphiJjPvbQ@mail.gmail.com>
Subject: Re: [PATCH] rbd: avoid clang -Wuninitialized warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Dillaman <dillaman@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 5:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 22, 2019 at 5:33 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2019 at 3:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > > index 4ba967d65cf9..cbcc3baf3807 100644
> > > --- a/drivers/block/rbd.c
> > > +++ b/drivers/block/rbd.c
> > > @@ -2399,7 +2399,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
> > >                                                       &obj_req->bvec_pos);
> > >                         break;
> > >                 default:
> > > -                       rbd_assert(0);
> > > +                       BUG();
> > >                 }
> > >         } else {
> > >                 ret = rbd_img_fill_from_bvecs(child_img_req,
> >
> > Hi Arnd,
> >
> > You did a couple of these last year in commit c6244b3b2377 ("rbd: avoid
> > Wreturn-type warnings").
>
> Ah, I had completely forgotten about that. Different bug and different
> compiler, but same solution ;-)
>
> >  Let's change all of those default cases to BUG
> > in one go.  Do you want to do that or should I?
>
> I've prepared another patch now and sent it out, please
> apply it on top. I'd like this one-line patch to stay separate though
> since it captures the warning message and may need to
> be backported to stable kernels later.

Applied.

Thanks,

                Ilya

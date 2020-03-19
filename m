Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D1AC4332B
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 06:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E9B2072C
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 06:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe3+r1sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSGjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:39:24 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:38672 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCSGjY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 02:39:24 -0400
Received: by mail-pf1-f170.google.com with SMTP id z5so894458pfn.5
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2020 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cs2JS7SxxXEam4zQmdJwymUz7varQNA+UZqCpvuDnkY=;
        b=pe3+r1swhNDhhXDPo47a6N470FaAQpvv3WXL3lhAB1PmYKk7+9718xEjh3glbGMHCU
         d8saFPb/w0/PCUUTX1vcfzwsAgF82zHYhA39GDltUillNakoupBz4njopb3/0/aW6HgI
         YFnUDE29PIMYi2aA3tGkFrKKrN16IIU5wb+x4/4iFBkvkxy5SHgc4A1CWftkuDfNmWpP
         y5Igi8X0PrJ/T2PerWb9MaibEf11aRejbkcNt8M90vn3ZdrTO0Qw+Unk6abKnJPDQ/ra
         RiTowhHMCP1ry2ioVx2PCv0UCNfKL7fs2q3KS3uZnw7NN9oI6ou+5dGHtSNAxUitouxk
         e76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cs2JS7SxxXEam4zQmdJwymUz7varQNA+UZqCpvuDnkY=;
        b=i5MbzvZktja3DXh3M9mAWzsY++ZFBM7MYzrWRjg4lKLeLZkGrbOm1KXT/xLMgOhnQ8
         07xwma8GP5zg3cEbwJwgbFaIqpThmKFD4eaVPiy2LNwOxsQiGOYqbubaYMotYaaZz39Q
         N4B/sk4czEyO++7we5kIAYwzwKObx3eMbcePQsyD/bFZP0Mjo8Hz4/mON4dDcIA+SDnQ
         Wchotqn3g7ycUqSGOWewtHZsZEEV+cWNwNxc5FD3rIbAA11L5Ep3dbW9Omv+cnyLvh5E
         9c4f+W0c2Epumi+c2kWnyavQIN1HYEibO5hq6+Ba0sr73IyPRI6CL+/n49bfxzOOmqWB
         XnJA==
X-Gm-Message-State: ANhLgQ3GGRtsoxfNsLnZuEgzSb5oo32qE59zZn7qjGfuSRYGWqd+QXlq
        wka70YqWA4zJ2DGYSEMrEPTVnt5m6gYVKXemsb4=
X-Google-Smtp-Source: ADFU+vt/4deYrdol+wNErKNEJe9OIIv7yBKUd0XByng90KTZViuxqlhNyRcigyrQYEc3zqY9PXZBQlNvvZ06+DbNVYk=
X-Received: by 2002:a65:64ca:: with SMTP id t10mr1847940pgv.190.1584599962848;
 Wed, 18 Mar 2020 23:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p> <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p> <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
 <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
 <CAEK8JBCKH8-tiUj1W6CB_wAx2xF4osDLXG3GNzuAySrgsqp=yQ@mail.gmail.com>
 <20200317102643.GA8721@ming.t460p> <CAEK8JBChFOkNTi99CVwXbQZ+9R4OB79SeOy=s0rbNnZnQT+DFA@mail.gmail.com>
 <20200318073630.GA18460@ming.t460p>
In-Reply-To: <20200318073630.GA18460@ming.t460p>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Thu, 19 Mar 2020 14:38:55 +0800
Message-ID: <CAEK8JBDG+BrMH+j-41K-KNO=w80Gr7zqY=nO-Dh_SXPYse3Krw@mail.gmail.com>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ok, thanks.

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 18, 2020 at 02:29:17PM +0800, Feng Li wrote:
> > Hi Ming,
> > What I need is that always get contiguous pages in one bvec.
> > Maybe currently it's hard to satisfy this requirement.
> > About huge pages, I know the userspace processes could use huge pages
> > that kernel reserved.
> > Could bio/block layer support use huge pages?
>
> Yes, you will see all pages in one huge page are stored in one single
> bvec.
>
> >
> > Thanks again for your help.
> >
> > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:27=E5=86=99=E9=81=93=EF=BC=9A
> >
> > >
> > > On Tue, Mar 17, 2020 at 04:19:44PM +0800, Feng Li wrote:
> > > > Thanks.
> > > > Sometimes when I observe multipage bvec on 5.3.7-301.fc31.x86_64.
> > > > This log is from Qemu virtio-blk.
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
> > > >       0: size: 229376 addr: 0x7fff6a7c8000
> > > >       1: size: 32768 addr: 0x7fff64c00000
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
> > > >       0: size: 229376 addr: 0x7fff6a7c8000
> > > >       1: size: 32768 addr: 0x7fff64c00000
> > >
> > > Then it is working.
> > >
> > > >
> > > > I also tested on 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64.
> > > > And observe 64 iovcnt.
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 64
> > > >       0: size: 4096 addr: 0x7fffb5ece000
> > > >       1: size: 4096 addr: 0x7fffb5ecd000
> > > > ...
> > > >       63: size: 4096 addr: 0x7fff8baec000
> > > >
> > > > So I think this is a common issue of the upstream kernel, from 5.3 =
to 5.6.
> > >
> > > As I mentioned before, it is because the pages aren't contiguous
> > > physically.
> > >
> > > If you enable hugepage, you will see lot of pages in one single bvec.
> > >
> > > >
> > > > BTW, I have used your script on 5.3.7-301.fc31.x86_64, it works wel=
l.
> > > > However, when updating to kernel 5.6.0-0.rc6.git0.1.vanilla.knurd.1=
.fc31.x86_64.
> > > > It complains:
> > > >
> > > > root@192.168.19.239 16:57:23 ~ $ ./bvec_avg_pages.py
> > > > In file included from /virtual/main.c:2:
> > > > In file included from
> > > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/i=
nclude/uapi/linux/ptrace.h:142:
> > > > In file included from
> > > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/a=
rch/x86/include/asm/ptrace.h:5:
> > > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/a=
rch/x86/include/asm/segment.h:266:2:
> > > > error: expected '(' after 'asm'
> > > >         alternative_io ("lsl %[seg],%[p]",
> > >
> > > It can be workaround by commenting the following line in
> > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/inc=
lude/generated/autoconf.h:
> > >
> > > #define CONFIG_CC_HAS_ASM_INLINE 1
> > >
> > >
> > > Thanks,
> > > Ming
> > >
> >
>
> --
> Ming
>

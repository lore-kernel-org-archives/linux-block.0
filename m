Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA7BC10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 06:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFB32076A
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 06:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEiq/Dj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgCRG3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:29:45 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43812 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCRG3p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 02:29:45 -0400
Received: by mail-pf1-f172.google.com with SMTP id f206so2335964pfa.10
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2020 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u047cB8yDBpPqDutJpXDnsma04HGIiDhsreyouMKx7E=;
        b=kEiq/Dj0Gwe6jusCPtETgjtkFbJsJOEea31PlzHY31H6h29hK0gkBbf0519hMOzjBG
         Qlj9dF5F2u2pBXuCeUT1rwQE66h5GPkg0KamsfuXYM2Rexkfm7uUK2ZxnR6wRdyXW0CJ
         rTjrXtxQns7rHhqHW0LS/34mg4l9GMPkswYqlBranbM09a059drNVmgp5osPzwliUSEf
         cK2nWTLrxseC6HrpiHCswbPG4Po3xA3R7bFw+TQ1gGao2+XRtUB4bT3I+uyDoqyT3veg
         s+S/hM8ISdiqMXRjAtiGtppW323l13AnrENJFbfCWtORi3+dLz9HONeplVHcRvM/jGsx
         HKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u047cB8yDBpPqDutJpXDnsma04HGIiDhsreyouMKx7E=;
        b=e3s313eq28y4QTDlDhQ5/GnlEYYcXoPMP2zYVQpVclW2xF5aLTC3G9XWLoIqdSTP00
         JiRvVQY3CP+p3JEZ5fL3XcbVDaZFSxrUBduf8yONLfQBuZWpLlw62eYiZysoAPvCh5On
         9K3fUib53SPYoUZF9lI+YLFnJdV4r8XvQMXQO7/ugtdA+W2BikKk9Dh363sMOPT653KY
         b+TKLEcdqMD+UxD0utWdI0DNEz4icbkgvpvanXMZEUBq7sqAR/frbbD7JVs+Q15vX3K4
         S+EeDRlVkYKrgMZGYCqIAAN9EQWCbK85BoXDkYVu2O7c0cldvbjPKxAtvtn2irs1F1c7
         T+ww==
X-Gm-Message-State: ANhLgQ3u6VPRA/DT2uhWDFCdboDF7XvwgihgkhWnoL9plIbfGWs/uwsA
        TuGQPxX7GsD2Ydcy8s+dZ3rVzc4yQv3RX5Qd4PA=
X-Google-Smtp-Source: ADFU+vsBC4Ze0e5MicOWZI0IAO3EszHEUI5f2DOjCEasNa26TRxEb86E6bud2DuMXQsnIE4CmtP6VNNqEKYQVHQkj6k=
X-Received: by 2002:a63:1517:: with SMTP id v23mr2946208pgl.89.1584512983745;
 Tue, 17 Mar 2020 23:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p> <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p> <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
 <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
 <CAEK8JBCKH8-tiUj1W6CB_wAx2xF4osDLXG3GNzuAySrgsqp=yQ@mail.gmail.com> <20200317102643.GA8721@ming.t460p>
In-Reply-To: <20200317102643.GA8721@ming.t460p>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Wed, 18 Mar 2020 14:29:17 +0800
Message-ID: <CAEK8JBChFOkNTi99CVwXbQZ+9R4OB79SeOy=s0rbNnZnQT+DFA@mail.gmail.com>
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

Hi Ming,
What I need is that always get contiguous pages in one bvec.
Maybe currently it's hard to satisfy this requirement.
About huge pages, I know the userspace processes could use huge pages
that kernel reserved.
Could bio/block layer support use huge pages?

Thanks again for your help.

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:27=E5=86=99=E9=81=93=EF=BC=9A

>
> On Tue, Mar 17, 2020 at 04:19:44PM +0800, Feng Li wrote:
> > Thanks.
> > Sometimes when I observe multipage bvec on 5.3.7-301.fc31.x86_64.
> > This log is from Qemu virtio-blk.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
> >       0: size: 229376 addr: 0x7fff6a7c8000
> >       1: size: 32768 addr: 0x7fff64c00000
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
> >       0: size: 229376 addr: 0x7fff6a7c8000
> >       1: size: 32768 addr: 0x7fff64c00000
>
> Then it is working.
>
> >
> > I also tested on 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64.
> > And observe 64 iovcnt.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 64
> >       0: size: 4096 addr: 0x7fffb5ece000
> >       1: size: 4096 addr: 0x7fffb5ecd000
> > ...
> >       63: size: 4096 addr: 0x7fff8baec000
> >
> > So I think this is a common issue of the upstream kernel, from 5.3 to 5=
.6.
>
> As I mentioned before, it is because the pages aren't contiguous
> physically.
>
> If you enable hugepage, you will see lot of pages in one single bvec.
>
> >
> > BTW, I have used your script on 5.3.7-301.fc31.x86_64, it works well.
> > However, when updating to kernel 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc3=
1.x86_64.
> > It complains:
> >
> > root@192.168.19.239 16:57:23 ~ $ ./bvec_avg_pages.py
> > In file included from /virtual/main.c:2:
> > In file included from
> > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/inclu=
de/uapi/linux/ptrace.h:142:
> > In file included from
> > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/=
x86/include/asm/ptrace.h:5:
> > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/arch/=
x86/include/asm/segment.h:266:2:
> > error: expected '(' after 'asm'
> >         alternative_io ("lsl %[seg],%[p]",
>
> It can be workaround by commenting the following line in
> /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/include=
/generated/autoconf.h:
>
> #define CONFIG_CC_HAS_ASM_INLINE 1
>
>
> Thanks,
> Ming
>

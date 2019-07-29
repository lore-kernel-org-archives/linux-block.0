Return-Path: <SRS0=KgRV=V2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAD8C7618B
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC62075C
	for <linux-block@archiver.kernel.org>; Mon, 29 Jul 2019 10:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYdDTlVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfG2KW7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:22:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38615 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfG2KW7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jul 2019 06:22:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so61203580wrr.5
        for <linux-block@vger.kernel.org>; Mon, 29 Jul 2019 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gXrwLkOA/d+4lB1YOBJpb2JG11kD392j7b+agBQniOA=;
        b=uYdDTlVv8l+xglbRt4AB6IAV3d4mlfwcZd+rSqx+RBCoQtB3qnY02XDSxoByUxUEdc
         akNfWRzt1ylgaJ28LzmCTRuzY8Zq/nxDbi189MxzJ/Tfk+q9ZQpjzMEZlo5mcaXppBdU
         bPRz/oCfxDVzNEmbkdT8+xUV9kyvUNs6lIfYZ48gFh8dDs04OllOtIQxqbaV0H38KZUi
         ZiGHyIt4amUDcxpWxffCt6v/wD27JXzYrZ9EhwYTWppdgu5jEZN/gynNZWXjt7/go9Ka
         I+i9bnSs0++HI+EGBTbaWytLUxFhCNmqQW+6HPyIcnEwMbDKW3BF67o6nuvfEiv9SWtO
         F4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gXrwLkOA/d+4lB1YOBJpb2JG11kD392j7b+agBQniOA=;
        b=Bkih8S8OGkXWJ8iqGE2zw19yUw0GvvFOR/8gXH+X1dYXMdTOZT8/b8/BbqMoy1ZFPB
         i/zrh7bZAspYX78ojQfkeIRrdmNnsY+gAhUoTi4pepYoGsCZmUvKasZsvUHPxfuLhMM4
         ps7zyEkoUekJbnlVDUelfgyy09B/ON3MVsSJJcwDNhl3IEL/N5s0GNOFQclPMOa4tfLT
         wAMtupVTSlhkaB8ZCxHpPTEhlmDBRJee1AfbzeUjOLyjW9Tt4ON8TPMRboW29DWcvihA
         2jeFGPblgLfnJPW+9hWiIewLtf8rU44iXLMOOameed3ybTXhh41/CCd0/fGywXKwhNYo
         xhpg==
X-Gm-Message-State: APjAAAWvx5mU+ymOt4PtiH+fAfNywMMNK68VeyIX5095A1WDjS5EZYOw
        QiP1TopegStTL8TlmUAOTAY97j62zeRqC3yyWg0=
X-Google-Smtp-Source: APXvYqxklhaLvMJhhCU7fnNczFNHbGQlDK1E1YVS4OGpW18SNiYiFXFNoVsdCA4ALV+7rSoKSVHOUSUgys26t0mNLwY=
X-Received: by 2002:adf:da4d:: with SMTP id r13mr16835505wrl.281.1564395777469;
 Mon, 29 Jul 2019 03:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
 <20190627103719.GC4421@minwooim-desktop> <20190627110342.GA13612@lst.de>
 <CAA70yB5uve6x-t56u7RcM8=JNSXh644uErC5z4m5h2C1rkSuvA@mail.gmail.com> <CAA70yB7-mLguBM=RxHeGzpDrrvnvdOaK3A32k4bdFc3uOvKaiQ@mail.gmail.com>
In-Reply-To: <CAA70yB7-mLguBM=RxHeGzpDrrvnvdOaK3A32k4bdFc3uOvKaiQ@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Mon, 29 Jul 2019 18:22:46 +0800
Message-ID: <CAA70yB4FjB+Lh6R92syPztpXswNzNk7rqyAqhaiojC4h5aE1kg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] nvme: add support weighted round robin queue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>, keith.busch@intel.com,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Weiping Zhang <zwp10758@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Weiping Zhang <zwp10758@gmail.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:57=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Christoph Hellwig <hch@lst.de> =E4=BA=8E2019=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:06=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Jun 27, 2019 at 07:37:19PM +0900, Minwoo Im wrote:
> > > > Hi, Maintainers
> > > >
> > > > Would you guys please give some thoughts about this patch?  I like =
this
> > > > feature WRR addition to the driver so I really want to hear somethi=
ng
> > > > from you guys.
> > >
> > > We are at the end of the merge window with tons of things to sort out=
.
> > > A giant feature series with a lot of impact is not at the top of the
> > > priority list right now.
> >
> > Hi Christoph,
> >
> > There are some feedback in V3, I really want to get some more feedback =
from you
> > and other people, at that time I post V4.
> >
> > So please give some comments for V3 at your convenience after this merg=
e window.
> >
> Hi Christoph,
>
> Ping

Hi Christoph,

Ping

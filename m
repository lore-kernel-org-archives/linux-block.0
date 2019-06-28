Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3692C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DA020828
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 15:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jICs71dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF1P5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:57:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfF1P5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 11:57:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so9661934wme.0
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wxiJ0Py1BE8Z+8GDLum/znTVbocpCo+0p2g4WsgPq+U=;
        b=jICs71drass6uhcYgQQFV2jNMq8bgE9CQj2JLq45S6AEcOTeEpKEcrRV27dcaf+KNX
         3idpVKIsXoISGszBSW2pM6qRHFEYV2xYVbg6n9i/bu3krm3uMrQoiFjZG0LRQn4jaS0f
         bwiYr+oxeaa2eXfPO1qSPi+b8+M3cF9JTo/jYyhpYJ8/ifN6e0cleUYJ2rG2RBGisDv1
         7F0IE8woPzqlBMeMEhDqpRMNbpbSTc0XYMYwh/vkoJElnnzz3agy+mtA0EU7t3rHiVke
         0N4jKvd760uNv+XB5vqF8jsSYCTRXHhi0g/PGzwjJHmFHb0SdJBDLXSwKLhZfV7tP1A2
         UZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wxiJ0Py1BE8Z+8GDLum/znTVbocpCo+0p2g4WsgPq+U=;
        b=T5WNemCr8cT6oon0hHIoKwm++NeJtBNyBYNqx8SEGpVkHfmL0XnHZbhp6ZTPbalEGf
         TLxSZE3NB1f8Yekv2/CVouK3NSL3rLhGYlY1PIeOM8tsUrdu+Z5O2q8e/lT6zEKQYL6g
         O1K7PhqeiyN6wpeQxzYI7lhinM2mIGFegdLuTbIdtnb8WNuyNKCERXlHmZk/DpC21TxM
         Mq2CfkD4mbHTyUlG8BnEncLGEDumDlDVwDedHeS4VkU9LwGaS63VdHzQwREUex9piV1N
         nLkoTSUC9M/xZaHEfoo99Yb4IrCxMEYDAGhXxI8OcL2SGVXq3pAmlK3rBAhQrl+9cScF
         tjoA==
X-Gm-Message-State: APjAAAVynPloB4yrYXDB4Y1Q8RVKnTNXoifQL247UZ5tD9N8g3fMbjRR
        u28wwyyyP59DbxqwJ/JBcSv2bSABPSoptoAmkI4=
X-Google-Smtp-Source: APXvYqzbI8iEqZSPn8N/P8HKRn/KFRnWNx4EPochs9CsAZYejtmbHcrhuW0jBHi4fSpRq32xxlUk4EWFspZuSQPj1sQ=
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr7552427wmj.94.1561737433931;
 Fri, 28 Jun 2019 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
 <20190627103719.GC4421@minwooim-desktop> <20190627110342.GA13612@lst.de>
In-Reply-To: <20190627110342.GA13612@lst.de>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 28 Jun 2019 23:57:01 +0800
Message-ID: <CAA70yB5uve6x-t56u7RcM8=JNSXh644uErC5z4m5h2C1rkSuvA@mail.gmail.com>
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2019=E5=B9=B46=E6=9C=8827=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 27, 2019 at 07:37:19PM +0900, Minwoo Im wrote:
> > Hi, Maintainers
> >
> > Would you guys please give some thoughts about this patch?  I like this
> > feature WRR addition to the driver so I really want to hear something
> > from you guys.
>
> We are at the end of the merge window with tons of things to sort out.
> A giant feature series with a lot of impact is not at the top of the
> priority list right now.

Hi Christoph,

There are some feedback in V3, I really want to get some more feedback from=
 you
and other people, at that time I post V4.

So please give some comments for V3 at your convenience after this merge wi=
ndow.

Thanks a ton
Weiping

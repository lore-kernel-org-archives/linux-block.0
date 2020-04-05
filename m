Return-Path: <SRS0=lh2f=5V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B1C2BA15
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 02:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE1F20672
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 02:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT7i2dGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDECBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:01:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34962 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDECBR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 22:01:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id k134so1955585qke.2
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2020 19:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9tTFeTJCNm9ueBmVbdLbEXDemgjgTcU5urpmJjuhRE=;
        b=iT7i2dGu3zRFq5MPbvYkHtmTmjsa4+lCHk2Xol+gEEt63TRZy3lXno5nVHr7JMQk/P
         7iL+nEVBvv1AOYSJpalJH02peIcQtmCKQR2s+nVGQdtrIeUGX69UpYQeGOpYT8cq1sPe
         W+u9jYLvTkw5Gg2DA89mKpafENNbWpq7ctug610pXQBmOWAGYgLGGTgtIjCZd+KXAmdp
         7xlxn3VPVkwuGwbhI6IHSkHmQrJ1q1xK291yGvwcYoKY4XFPs/Jb9lSNEdMdyk7LwbSG
         3BVHB2/TVM1jZDfSgw781i6Sh0deSQmbZ3wd5TmwbkwwWe1TqXHQJzcHAFREUSTI5TaF
         bMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9tTFeTJCNm9ueBmVbdLbEXDemgjgTcU5urpmJjuhRE=;
        b=qWn1Tquotu8Nq7RCqrfvcPbBCLNrbwO3dQLPiFPHSqmzsk5Xgwin2UVyR+N+D79BKJ
         gwYTJJig0RB/w1FC7hR+/Hx46b7mFTwrBz3oxAx/g4eJVIClgFj1yfHRgO7fNYWq+GyY
         aAAqbqlRjZ2w6nhJTyvVpXkeI/k1MD6X2PRXur7TAyQdMjztgMhJg5KD6VXOEfQVSCY1
         UF85JvwK/F3LgldOvLGMV9klYmVtGpxiqq3lGcFwquIyxZxjhuRFFR6useTnW9lmEinC
         2UuFd9bA66f5TTTz88qTjGnApbkNEsk70LMRRbc5y4T6TzEmWyBA4DD3g0pH85kJ6+gl
         PLhg==
X-Gm-Message-State: AGi0PuYFik6gSHhj1AiGS14NjW+kHONsXOr7k9O8YWUDbv/BrccqEIzF
        TuFdGFwYAzgfVRAz1FR1JfQdoWiRS9AJ4U9koNk=
X-Google-Smtp-Source: APiQypK0Ea5u/GvHgwdxFFqYpQNYK8ee52qXTmlO7MRROZtpzvhk0Q6Zb5Pz0CSpo7JuOPDvys15dsaGN7U0M0jCNMY=
X-Received: by 2002:a37:bf06:: with SMTP id p6mr16177259qkf.477.1586052076281;
 Sat, 04 Apr 2020 19:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586006904.git.zhangweiping@didiglobal.com> <3f9abe8e-9017-410c-f0eb-a80e1c232e61@acm.org>
In-Reply-To: <3f9abe8e-9017-410c-f0eb-a80e1c232e61@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Sun, 5 Apr 2020 10:01:05 +0800
Message-ID: <CAA70yB46ijZU=yCMSxA6qAAROefivDCjPveHBbunxK=tagsDxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix potential kernel panic when increase hardware queue
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2020=E5=B9=B44=E6=9C=885=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=881:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2020-04-04 06:35, Weiping Zhang wrote:
> > This patchset fix a potential kernel panic when increase more hardware
> > queue at runtime.
> >
> > Patch1 fix a seperate issue, since patch2 depends on it, so I send a
> > new patchset.
> >
> > Change since V1:
> >  * Add second patch to fix kernel panic when update hardware queue
> >
> > Weiping Zhang (2):
> >   block: save previous hardware queue count before udpate
> >   block: alloc map and request for new hardware queue
>
> On top of which kernel version have these patches been prepared and
> tested? v5.5, v5.6, Jens' for-next branch or perhaps yet another kernel
> version? I'm asking this since recently a fix for
> blk_mq_realloc_hw_ctxs() has been accepted in Jens' tree.
>
Hi Bart,

It's tested on commit "4308a434e" of block-5.7 branch, this branch has
include the commit
"blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()".

Thanks
Weiping

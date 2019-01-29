Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A563C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9EB21473
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 10:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="xiCEzuES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfA2KPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:15:50 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39221 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2KPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 05:15:50 -0500
Received: by mail-vs1-f66.google.com with SMTP id h78so11612159vsi.6
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k0XWW5vTZEN8PQRidLNZvioNgfxoXAfPl8JcM/wNqN0=;
        b=xiCEzuESx1bO9xlmLJ3q+OSFIUyKE20c6FK3MhZ6P/NKOcDjgCBZZG99Q53Ie6Fl/I
         QqujM/X8A2QaSR6uePGLiy3Xwmq1icDQ3v8OXlxi1Rt8khYqvDp8qNmjBYRz29z00ahC
         C8IDClClzb3h/x3gkqknVLpG1E7nPZhDhaCnCmwDJqP2ziiwfw08DrmuQMI4g16F7j1+
         7bbNtyOiAq6v8cBKusROhRw3MRP2wFnm1XkkjMUh5YOR2qKQd/fcgyylokt9wbn4J/sJ
         xSNP2N+R8tLStMsvDTwQArSS4D7FWxXOcZ8AURct4xWSLOznTl1/oU41cxF5nIY+bwCN
         t+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0XWW5vTZEN8PQRidLNZvioNgfxoXAfPl8JcM/wNqN0=;
        b=m+p/9Lf4zqURxlFXWE6DIYRqQda3QA1hl3mewUSFClZFKN/vE/xSTSx3n1pGPcPa9z
         JAlb/29hT6dEGjA7zbHpaiPmUnuK1W9NcP8uzpAoge2i9niGuM7F9yzC16VuGavdStBp
         H8QDk9hwFK40q/ojIuehTx2zZHSwJKcVwUUx9IogRlOSax8JWtGZ1vcpLljsDDi6bt7t
         mOEz2/CYfnPYv7p0WOfoe1nnaELHsdK3ldbcpZJ2fyJgv8/aUphXeo8OAqiUEWhkp8Yj
         4dDVpFaO20up4Uc6h3ogMHrz8wF8K3tupW+ZkZJ5PJx/jKAMbGDM04851jCEmUHHYSP2
         jA0Q==
X-Gm-Message-State: AJcUukflD6MOsQyl7zL1JM6GH8y+ALdwhZhSubFbGgPv8/w5kpfzpnCe
        eFNmT1OlFdGU1tFyrgPOyntf2co10DrV41NNi5luoA==
X-Google-Smtp-Source: ALg8bN5pQjhbd7TdY/wTmk4a1CuKmto/vfFPgLiyDzuL4+R+p4DbZQJi2mJnYFNHXp1/M/mXrqdCKfcsTvrgyTo3XHo=
X-Received: by 2002:a67:24c6:: with SMTP id k189mr10944191vsk.16.1548756948550;
 Tue, 29 Jan 2019 02:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20190125100943.28743-1-javier@javigon.com> <a712d1f5-2d82-2879-b220-4c6790fdc56a@lightnvm.io>
In-Reply-To: <a712d1f5-2d82-2879-b220-4c6790fdc56a@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Tue, 29 Jan 2019 11:15:37 +0100
Message-ID: <CANr-nt3KXtTOP44342b_SR5dcvJk1_XnP256d2FxN7Kkb1MZ_w@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: prevent stall due to wb threshold
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 2:08 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 1/25/19 11:09 AM, Javier Gonz=C3=A1lez wrote:
> > In order to respect mw_cuinits, pblk's write buffer maintains a
> > backpointer to protect data not yet persisted; when writing to the writ=
e
> > buffer, this backpointer defines a threshold that pblk's rate-limiter
> > enforces.
> >
> > On small PU configurations, the following scenarios might take place: (=
i)
> > the threshold is larger than the write buffer and (ii) the threshold is
> > smaller than the write buffer, but larger than the maximun allowed
> > split bio - 256KB at this moment (Note that writes are not always
> > split - we only do this when we the size of the buffer is smaller
> > than the buffer). In both cases, pblk's rate-limiter prevents the I/O t=
o
> > be written to the buffer, thus stalling.

I'll start a regression test run.
Do you have a way of reproducing these issues? It would be great to
add regression test(s) covering the two cases you list.

A general comment on the write buffer and rate limiter:  What is the
rationale of rounding up the write buffer size to a power of two?
We can end up allocating almost twice as much memory as we need, and
all this power-of-two-arithmetic makes the code hard to read.

> > This patch fixes the original backpointer implementation by considering
> > the threshold both on buffer creation and on the rate-limiters path,
> > when bio_split is triggered (case (ii) above).
> >
> > Fixes: 766c8ceb16fc ("lightnvm: pblk: guarantee that backpointer is res=
pected on writer stall")
> > Signed-off-by: Javier Gonz=C3=A1lez <javier@javigon.com>
> > ---
> >   drivers/lightnvm/pblk-rb.c | 25 +++++++++++++++++++------
> >   drivers/lightnvm/pblk-rl.c |  5 ++---
> >   drivers/lightnvm/pblk.h    |  2 +-
> >   3 files changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> > index d4ca8c64ee0f..a6133b50ed9c 100644
> > --- a/drivers/lightnvm/pblk-rb.c
> > +++ b/drivers/lightnvm/pblk-rb.c
> > @@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
> >   /*
> >    * pblk_rb_calculate_size -- calculate the size of the write buffer
> >    */
> > -static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
> > +static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
> > +                                        unsigned int threshold)
> >   {
> > -     /* Alloc a write buffer that can at least fit 128 entries */
> > -     return (1 << max(get_count_order(nr_entries), 7));
> > +     unsigned int thr_sz =3D 1 << (get_count_order(threshold + NVM_MAX=
_VLBA));
> > +     unsigned int max_sz =3D max(thr_sz, nr_entries);
> > +     unsigned int max_io;
> > +
> > +     /* Alloc a write buffer that can (i) fit at least two split bios
> > +      * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee tha=
t the
> > +      * threshold will be respected
> > +      */
> > +     max_io =3D (1 << max((int)(get_count_order(max_sz)),
> > +                             (int)(get_count_order(NVM_MAX_VLBA << 1))=
));
> > +     if ((threshold + NVM_MAX_VLBA) >=3D max_io)
> > +             max_io <<=3D 1;
> > +
> > +     return max_io;
> >   }
> >
> >   /*
> > @@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int s=
ize, unsigned int threshold,
> >       unsigned int alloc_order, order, iter;
> >       unsigned int nr_entries;
> >
> > -     nr_entries =3D pblk_rb_calculate_size(size);
> > +     nr_entries =3D pblk_rb_calculate_size(size, threshold);
> >       entries =3D vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_=
entry)));
> >       if (!entries)
> >               return -ENOMEM;
> >
> > -     power_size =3D get_count_order(size);
> > +     power_size =3D get_count_order(nr_entries);
> >       power_seg_sz =3D get_count_order(seg_size);
> >
> >       down_write(&pblk_rb_lock);
> > @@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int s=
ize, unsigned int threshold,
> >        * Initialize rate-limiter, which controls access to the write bu=
ffer
> >        * by user and GC I/O
> >        */
> > -     pblk_rl_init(&pblk->rl, rb->nr_entries);
> > +     pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
> >
> >       return 0;
> >   }
> > diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> > index 76116d5f78e4..f81d8f0570ef 100644
> > --- a/drivers/lightnvm/pblk-rl.c
> > +++ b/drivers/lightnvm/pblk-rl.c
> > @@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
> >       del_timer(&rl->u_timer);
> >   }
> >
> > -void pblk_rl_init(struct pblk_rl *rl, int budget)
> > +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
> >   {
> >       struct pblk *pblk =3D container_of(rl, struct pblk, rl);
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> > @@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> >       int sec_meta, blk_meta;
> >       unsigned int rb_windows;
> >
> > -
> >       /* Consider sectors used for metadata */
> >       sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_l=
ines;
> >       blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
> > @@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> >       /* To start with, all buffer is available to user I/O writers */
> >       rl->rb_budget =3D budget;
> >       rl->rb_user_max =3D budget;
> > -     rl->rb_max_io =3D budget >> 1;
> > +     rl->rb_max_io =3D (budget >> 1) - get_count_order(threshold);

Hmm? How can this work? get_count_order returns a bit index, and
budget is a size.

Also, what happens during garbage collection? Won't we risk stalling
anyway when GC consumes most of the budget?

For user writes to be inserted into the write buffer, they need to
pass the check pblk_rl_user_may_insert, which checks rb_user_max(which
is tuned depending on gc pressure) , not rb_max_io.

> >       rl->rb_gc_max =3D 0;
> >       rl->rb_state =3D PBLK_RL_HIGH;
> >
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index 85e38ed62f85..752cd40e4ae6 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int forc=
e);
> >   /*
> >    * pblk rate limiter
> >    */
> > -void pblk_rl_init(struct pblk_rl *rl, int budget);
> > +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
> >   void pblk_rl_free(struct pblk_rl *rl);
> >   void pblk_rl_update_rates(struct pblk_rl *rl);
> >   int pblk_rl_high_thrs(struct pblk_rl *rl);
> >
>
> + Hans

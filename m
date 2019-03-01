Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B00C43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D992084D
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 12:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Y+VWfcrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfCAMvM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:51:12 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38152 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387735AbfCAMvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 07:51:10 -0500
Received: by mail-ua1-f68.google.com with SMTP id d4so11205390uap.5
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2019 04:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ITabl/cYkf49s/ykEjejB9SZ9cQe6+bDxqb+J58pesY=;
        b=Y+VWfcrXJ+CU8OVgOGrKbAtgW93Ka3TgY/xG9HXqrJ+0PYOnA2z17hj37jf8DgbT/v
         W0TxKHC+VsEQB5GGThvw8K83mYC6dhk4oBqzvG1j64AdsnKI0DDYWprdnKzBI8QWSK0O
         V6TpHdXWt0XmdylJR/FvqtSVjAlBnes5jthORqzXXlp7FJ85M/aE+aOES2lvBC1CEuRa
         b8xwkZvapTM0EZSwMCJdU7pJFcBDJO+Q1xJnCm0Q2ptmgSbuQ+Pu9aOWmzQYsIg5Mr/r
         dvYWfIDlq7XJmq2SPCdqsmmpD50naDzwG4eG636sNr61ygudCNXOXPYbpdNuDccVh9IS
         x/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ITabl/cYkf49s/ykEjejB9SZ9cQe6+bDxqb+J58pesY=;
        b=FxALd+ziTOYVcr9z4Bknv9umJFOcA64J2f1T+Cvh11ejPmD/loVtJtK7/HI1tp1GVs
         fNTDnFtV1lkDLZBEsv9V70XaI9DHvXgM5NlZ1WvSdk0h+3RTLL8evLrdGS6pjiuUttMY
         Et6f4GfzAULlPJIv0VeZgQkktSXiZLGgW5ngpw4cpUmwxnuVni9NzY6WzmoofSvYspCn
         M0FpCtEVzj/gIozNq8BMRLAu8unadRZmzk+NDh8ee5s5QCEoz2p1amcvThoSfJlPX2nF
         P9YXh8hZUkHw5nzHFoYoNwwJy0laHr42wmDlbakhPpC4zyZsDNuT2/QOBJSUwN55pJED
         hVIw==
X-Gm-Message-State: APjAAAWGvJmTmllrwGBRJhLC9hB+9d1VzZlPQCXjYSIbWU2Bqltgep55
        u99O1UV44smCOX/NSa1NO2IooPv4nDcMnfC9fqYroA==
X-Google-Smtp-Source: APXvYqwFi29eQifPm4n9AMSAr3YX8v1Ou2bvSooTjXa2IIQwoveB7VI/6VYDT/PSL/78rbEEUNKPHFR3FYTxu9mM/gM=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr2573789vsr.42.1551444668652;
 Fri, 01 Mar 2019 04:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-3-igor.j.konopko@intel.com> <7EEAD803-201C-477E-8ACA-7F152BC3C455@javigon.com>
In-Reply-To: <7EEAD803-201C-477E-8ACA-7F152BC3C455@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 1 Mar 2019 13:50:57 +0100
Message-ID: <CANr-nt3w4UmOeRVeXLdq+yLGgLqcJ7Xa_Mvba=xqm1QoaUKMEw@mail.gmail.com>
Subject: Re: [PATCH 02/13] lightnvm: pblk: Gracefully handle GC data malloc fail
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 28, 2019 at 6:09 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
>
>
> > On 27 Feb 2019, at 12.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Currently when we fail on gc rq data allocation
> > we simply skip the data which we wanted to move
> > and finally move the line to free state and lose
> > that data due to that. This patch move the data
> > allocation to some earlier phase of GC, where we
> > can still fail gracefully by moving line back
> > to closed state.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-gc.c | 19 +++++++++----------
> > 1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> > index 3feadfd9418d..31fc1339faa8 100644
> > --- a/drivers/lightnvm/pblk-gc.c
> > +++ b/drivers/lightnvm/pblk-gc.c
> > @@ -84,8 +84,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
> >       struct pblk_line_ws *gc_rq_ws =3D container_of(work,
> >                                               struct pblk_line_ws, ws);
> >       struct pblk *pblk =3D gc_rq_ws->pblk;
> > -     struct nvm_tgt_dev *dev =3D pblk->dev;
> > -     struct nvm_geo *geo =3D &dev->geo;
> >       struct pblk_gc *gc =3D &pblk->gc;
> >       struct pblk_line *line =3D gc_rq_ws->line;
> >       struct pblk_gc_rq *gc_rq =3D gc_rq_ws->priv;
> > @@ -93,13 +91,6 @@ static void pblk_gc_line_ws(struct work_struct *work=
)
> >
> >       up(&gc->gc_sem);
> >
> > -     gc_rq->data =3D vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
> > -     if (!gc_rq->data) {
> > -             pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
> > -                                     line->id, *line->vsc, gc_rq->nr_s=
ecs);
> > -             goto out;
> > -     }
> > -
> >       /* Read from GC victim block */
> >       ret =3D pblk_submit_read_gc(pblk, gc_rq);
> >       if (ret) {
> > @@ -189,6 +180,8 @@ static void pblk_gc_line_prepare_ws(struct work_str=
uct *work)
> >       struct pblk_line *line =3D line_ws->line;
> >       struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> >       struct pblk_line_meta *lm =3D &pblk->lm;
> > +     struct nvm_tgt_dev *dev =3D pblk->dev;
> > +     struct nvm_geo *geo =3D &dev->geo;
> >       struct pblk_gc *gc =3D &pblk->gc;
> >       struct pblk_line_ws *gc_rq_ws;
> >       struct pblk_gc_rq *gc_rq;
> > @@ -247,9 +240,13 @@ static void pblk_gc_line_prepare_ws(struct work_st=
ruct *work)
> >       gc_rq->nr_secs =3D nr_secs;
> >       gc_rq->line =3D line;
> >
> > +     gc_rq->data =3D vmalloc(gc_rq->nr_secs * geo->csecs);

Why not use array_size to do the size calculation as before? It checks
for overflows.
Apart from this, the patch looks good to me.

> > +     if (!gc_rq->data)
> > +             goto fail_free_gc_rq;
> > +
> >       gc_rq_ws =3D kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
> >       if (!gc_rq_ws)
> > -             goto fail_free_gc_rq;
> > +             goto fail_free_gc_data;
> >
> >       gc_rq_ws->pblk =3D pblk;
> >       gc_rq_ws->line =3D line;
> > @@ -281,6 +278,8 @@ static void pblk_gc_line_prepare_ws(struct work_str=
uct *work)
> >
> >       return;
> >
> > +fail_free_gc_data:
> > +     vfree(gc_rq->data);
> > fail_free_gc_rq:
> >       kfree(gc_rq);
> > fail_free_lba_list:
> > --
> > 2.17.1
>
> Looks good to me.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

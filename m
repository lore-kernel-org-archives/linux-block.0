Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AF7C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A5D2082E
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 21:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="EMQnQdQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfBDVB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:01:57 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44090 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBDVB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 16:01:57 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so445319uaq.11
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 13:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u2uaSjFTAzt74S+zPV9Y6fyT0EjStLAXSexFtbRvYAM=;
        b=EMQnQdQeni3x54I+xDOZTgPtcT91nrrjdFWw1PIo5qmd7b2O6VQDW7SYf+4U1TO7jd
         wZEfgEKvJHWcI7oh2TYlDXsRBTN6UpTk3nVtYJMH+fq3JgCjW/wdXBFDFV5/WKBHL/uU
         R0DirO/r1JLNrBvWmONXP+snEAtNVar8jM7enOJhh7dEtic1F46ZZn6CJzSmbunr5zHJ
         HNwgW2GN+JoPYsjlsi/YHv0cwIgl/ePbMmNtpVRW641p+VWfwDsZGcNWpddNFf5Dy+U1
         +BA4XcwNOM4VTKc7XS8x12v3Tdc7/998FdhQLxEUo6mS9yzqFfqTDmm/A2hb5PWeZjPN
         XJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u2uaSjFTAzt74S+zPV9Y6fyT0EjStLAXSexFtbRvYAM=;
        b=lP7ARx47Vfb+FPmD152qTtJwTiwUmlZKMCCxWvCV44ARci6uOOUAC7iWabPSewzOG/
         L9fjLgIEWOlbykXB4lEIt5h3874ZymvtwKm+Q5izx8JRUUHImXmSbMGH81gu/jkZou0N
         gDtxg91rs5lCM/QcxBsJ4rP3B7WHtxhd2Zi0KFxq2h2AuMsrkaVY6YBcrrzEBmEEbvH2
         L8pIKQj0PHgti8VjVk2lIIoMFpR5PrlNPbOWZbpFnHol9seNnqaB8bMWPvV2dIO3NPyy
         vtnvY6x0zzbUrLbvGkP+ujaIw/vGt2/OmSEwJkNydzgh6JYtkzb/RpReUaHU757cVIb5
         WmEA==
X-Gm-Message-State: AHQUAuZBXCzGaAKFAtRAQh1BJseSkswlLxrB5DwlEVjVj7h8fiVTrE5v
        b8JmiRzmyn4/kT+s//stlEzdzMvRm1EUdy9qZWhZKQ==
X-Google-Smtp-Source: AHgI3IafxGZ+72mlT4jEytAbbMasVSX5F1ZvLq3cpS1QEtMRJl8NsOqjBmpP0IfonNGJjWruX1acPM4dy3BBFaADHDQ=
X-Received: by 2002:ab0:77c4:: with SMTP id y4mr578797uar.45.1549314115981;
 Mon, 04 Feb 2019 13:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20190201023806.39895-1-hlitz@ucsc.edu> <7BC68605-5E76-4E0D-8C3E-29B2CB329FEB@javigon.com>
In-Reply-To: <7BC68605-5E76-4E0D-8C3E-29B2CB329FEB@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Feb 2019 22:01:45 +0100
Message-ID: <CANr-nt0uVoOhObd7rh2o9z1EYbHRPxszUwGbstaDnKrjP4v_sQ@mail.gmail.com>
Subject: Re: [PATCH V2] lightnvm: pblk: fix race condition on GC
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Heiner, it's awesome to get this fixed!

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Mon, Feb 4, 2019 at 9:19 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 1 Feb 2019, at 03.38, Heiner Litz <hlitz@ucsc.edu> wrote:
> >
> > This patch fixes a race condition where a write is mapped to the last
> > sectors of a line. The write is synced to the device but the L2P is not
> > updated yet. When the line is garbage collected before the L2P update i=
s
> > performed, the sectors are ignored by the GC logic and the line is free=
d
> > before all sectors are moved. When the L2P is finally updated, it conta=
ins
> > a mapping to a freed line, subsequent reads of the corresponding LBAs f=
ail.
> >
> > This patch introduces a per line counter specifying the number of secto=
rs
> > that are synced to the device but have not been updated in the L2P. Lin=
es
> > with a counter of greater than zero will not be selected for GC.
> >
> > Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> > ---
> >
> > v2: changed according to Javier's comment. Instead of performing check
> > while holding the trans_lock, add an atomic per line counter
> >
> > drivers/lightnvm/pblk-core.c  |  1 +
> > drivers/lightnvm/pblk-gc.c    | 20 +++++++++++++-------
> > drivers/lightnvm/pblk-map.c   |  1 +
> > drivers/lightnvm/pblk-rb.c    |  1 +
> > drivers/lightnvm/pblk-write.c |  1 +
> > drivers/lightnvm/pblk.h       |  1 +
> > 6 files changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index eabcbc119681..b7ed0502abef 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -1278,6 +1278,7 @@ static int pblk_line_prepare(struct pblk *pblk, s=
truct pblk_line *line)
> >       spin_unlock(&line->lock);
> >
> >       kref_init(&line->ref);
> > +     atomic_set(&line->sec_to_update, 0);
> >
> >       return 0;
> > }
> > diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> > index 2fa118c8eb71..26a52ea7ec45 100644
> > --- a/drivers/lightnvm/pblk-gc.c
> > +++ b/drivers/lightnvm/pblk-gc.c
> > @@ -365,16 +365,22 @@ static struct pblk_line *pblk_gc_get_victim_line(=
struct pblk *pblk,
> >                                                struct list_head *group_=
list)
> > {
> >       struct pblk_line *line, *victim;
> > -     int line_vsc, victim_vsc;
> > +     unsigned int line_vsc =3D ~0x0L, victim_vsc =3D ~0x0L;
> >
> >       victim =3D list_first_entry(group_list, struct pblk_line, list);
> > +
> >       list_for_each_entry(line, group_list, list) {
> > -             line_vsc =3D le32_to_cpu(*line->vsc);
> > -             victim_vsc =3D le32_to_cpu(*victim->vsc);
> > -             if (line_vsc < victim_vsc)
> > +             if (!atomic_read(&line->sec_to_update))
> > +                     line_vsc =3D le32_to_cpu(*line->vsc);
> > +             if (line_vsc < victim_vsc) {
> >                       victim =3D line;
> > +                     victim_vsc =3D le32_to_cpu(*victim->vsc);
> > +             }
> >       }
> >
> > +     if (victim_vsc =3D=3D ~0x0)
> > +             return NULL;
> > +
> >       return victim;
> > }
> >
> > @@ -448,13 +454,13 @@ static void pblk_gc_run(struct pblk *pblk)
> >
> >       do {
> >               spin_lock(&l_mg->gc_lock);
> > -             if (list_empty(group_list)) {
> > +
> > +             line =3D pblk_gc_get_victim_line(pblk, group_list);
> > +             if (!line) {
> >                       spin_unlock(&l_mg->gc_lock);
> >                       break;
> >               }
> >
> > -             line =3D pblk_gc_get_victim_line(pblk, group_list);
> > -
> >               spin_lock(&line->lock);
> >               WARN_ON(line->state !=3D PBLK_LINESTATE_CLOSED);
> >               line->state =3D PBLK_LINESTATE_GC;
> > diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> > index 79df583ea709..7fbc99b60cac 100644
> > --- a/drivers/lightnvm/pblk-map.c
> > +++ b/drivers/lightnvm/pblk-map.c
> > @@ -73,6 +73,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsi=
gned int sentry,
> >                */
> >               if (i < valid_secs) {
> >                       kref_get(&line->ref);
> > +                     atomic_inc(&line->sec_to_update);
> >                       w_ctx =3D pblk_rb_w_ctx(&pblk->rwb, sentry + i);
> >                       w_ctx->ppa =3D ppa_list[i];
> >                       meta->lba =3D cpu_to_le64(w_ctx->lba);
> > diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> > index a6133b50ed9c..03c241b340ea 100644
> > --- a/drivers/lightnvm/pblk-rb.c
> > +++ b/drivers/lightnvm/pblk-rb.c
> > @@ -260,6 +260,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb,=
 unsigned int to_update)
> >                                                       entry->cacheline)=
;
> >
> >               line =3D pblk_ppa_to_line(pblk, w_ctx->ppa);
> > +             atomic_dec(&line->sec_to_update);
> >               kref_put(&line->ref, pblk_line_put);
> >               clean_wctx(w_ctx);
> >               rb->l2p_update =3D pblk_rb_ptr_wrap(rb, rb->l2p_update, 1=
);
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-writ=
e.c
> > index 06d56deb645d..6593deab52da 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -177,6 +177,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk=
, unsigned int sentry,
> >                * re-map these entries
> >                */
> >               line =3D pblk_ppa_to_line(pblk, w_ctx->ppa);
> > +             atomic_dec(&line->sec_to_update);
> >               kref_put(&line->ref, pblk_line_put);
> >       }
> >       spin_unlock(&pblk->trans_lock);
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index a6386d5acd73..ac3ab778e976 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -487,6 +487,7 @@ struct pblk_line {
> >       __le32 *vsc;                    /* Valid sector count in line */
> >
> >       struct kref ref;                /* Write buffer L2P references */
> > +     atomic_t sec_to_update;         /* Outstanding L2P updates to ppa=
 */
> >
> >       struct pblk_w_err_gc *w_err_gc; /* Write error gc recovery metada=
ta */
> >
> > --
> > 2.17.1
>
>
> Looks good to me. Again, good marathon-catch! :)
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>
>

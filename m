Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BE8C282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2948720844
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 12:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="U2UAgSpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfA2MtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:49:15 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41668 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfA2MtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 07:49:15 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so11838757vsc.8
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=no+1oS4s347G7gknih83cWmNsSUn8v8xk/1BuDFSPFA=;
        b=U2UAgSpoWIi3HVQAxj0CknNsg59AiX9gJp2xCNzzZ9cjYPj564cMioogfZX7EahEIH
         sgf34BIR/cYFhEo4MQW4IHlD/5k83AdRIkfYmu1scuOEZ3EIOCw+NrdbygfmzUTwgnhg
         zdAAnGEmUBOnKhhM1tAX9OkSPfGROaMZ5S+SyvHp0JNa69IHd+H7e2mrs7XDkdDO5fUi
         FOgt9uLcTtGzicCGBM9eoNfnsbJ3cPqrKaDssrI1Bzf2OXim4lLI+yOFEH72Wt9/0Ngh
         5pW1GKWroG+H7O2gAqxzwe1ngGLVQ6eUTRcHGNV6uR9FhORR/fcLbdDRccVYVkAKhRL7
         L7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=no+1oS4s347G7gknih83cWmNsSUn8v8xk/1BuDFSPFA=;
        b=q0AmZ8Ylb6wSw1y6mKZXUnrvUJkoD5bcs4TjHPPuA9c2UsXIYS1lvnRNLWFzC6p+0K
         RBGq0kH+F9UOCQqRcLRQjWkZb+K4XsJ2Mn6VAnLHYpE2lC/v7ZvXzNYwraXBOn5IN98T
         wF0ZseXlAHXrUSHR60zmE4J/vzaawFu9CiwRi/94l4zVsWGkpxxQH5XLf3kp226Vsdsb
         qD9R2gP2TOT/SAPNWqDbA515xkeooGJv90klZ5VHSGR0YGoSiH8fy3iZfF4sqSk8tANT
         q4xi9y9XZ+jZTWdLwbYjY8dTXSGpLXNIMsqKmJ1mDPwzQyqLsX289+9wTaF34SAbjeZQ
         iAdQ==
X-Gm-Message-State: AJcUukcSjSt+3lfqGLbB4NH3BM1rlqdKOa2NWJAjb/Fc2IyZtNNZzwbN
        4Hq2MpfiD5nisLPNZ3DTewCQX8TT6IaWKSAse7WZZw==
X-Google-Smtp-Source: ALg8bN6WHUc+vdfNx/Aqhk0NQr+hsOhLiqjzyd1Qp0V55bfkPhg8kh9iqMfWNlRj07PZmg65suaQBoUSmqKnqj8Pyz4=
X-Received: by 2002:a67:6f82:: with SMTP id k124mr10474631vsc.42.1548766153268;
 Tue, 29 Jan 2019 04:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20190129084737.718-1-hans@owltronix.com> <FDFE70E2-CA70-456F-8507-94BF822BF9A7@javigon.com>
In-Reply-To: <FDFE70E2-CA70-456F-8507-94BF822BF9A7@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 29 Jan 2019 13:49:02 +0100
Message-ID: <CANr-nt34gCrRWsNrAfKS1Opy=kV5EwuR_C1VDjQbBP5MnfdgpA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: extend line wp balance check
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 12:19 PM Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>
>
> > On 29 Jan 2019, at 09.47, hans@owltronix.com wrote:
> >
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > pblk stripes writes of minimal write size across all non-offline chunks
> > in a line, which means that the maximum write pointer delta should not
> > exceed the minimal write size. Extend the line write pointer balance ch=
eck
> > to cover this case.
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >
> > This patch applies on top of Zhoujie's V3 of
> > "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
> >
> > drivers/lightnvm/pblk-recovery.c | 60 ++++++++++++++++++++------------
> > 1 file changed, 37 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-r=
ecovery.c
> > index 02d466e6925e..d86f580036d3 100644
> > --- a/drivers/lightnvm/pblk-recovery.c
> > +++ b/drivers/lightnvm/pblk-recovery.c
> > @@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, s=
truct pblk_line *line)
> >       return (distance > line->left_msecs) ? line->left_msecs : distanc=
e;
> > }
> >
> > -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
> > -                                   struct pblk_line *line)
> > +/* Return a chunk belonging to a line by stripe(write order) index */
> > +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
> > +                                               struct pblk_line *line,
> > +                                               int index)
> > {
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> >       struct nvm_geo *geo =3D &dev->geo;
> > -     struct pblk_line_meta *lm =3D &pblk->lm;
> >       struct pblk_lun *rlun;
> > -     struct nvm_chk_meta *chunk;
> >       struct ppa_addr ppa;
> > -     u64 line_wp;
> > -     int pos, i, bit;
> > +     int pos;
> >
> > -     bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
> > -     if (bit >=3D lm->blk_per_line)
> > -             return 0;
> > -     rlun =3D &pblk->luns[bit];
> > +     rlun =3D &pblk->luns[index];
> >       ppa =3D rlun->bppa;
> >       pos =3D pblk_ppa_to_pos(geo, ppa);
> > -     chunk =3D &line->chks[pos];
> >
> > -     line_wp =3D chunk->wp;
> > +     return &line->chks[pos];
> > +}
> >
> > -     for (i =3D bit + 1; i < lm->blk_per_line; i++) {
> > -             rlun =3D &pblk->luns[i];
> > -             ppa =3D rlun->bppa;
> > -             pos =3D pblk_ppa_to_pos(geo, ppa);
> > -             chunk =3D &line->chks[pos];
> > +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
> > +                                   struct pblk_line *line)
> > +{
> > +     struct pblk_line_meta *lm =3D &pblk->lm;
> > +     int blk_in_line =3D lm->blk_per_line;
> > +     struct nvm_chk_meta *chunk;
> > +     u64 max_wp, min_wp;
> > +     int i;
> >
> > -             if (chunk->state & NVM_CHK_ST_OFFLINE)
> > -                     continue;
> > +     i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
> > +
> > +     /* If there is one or zero good chunks in the line,
> > +      * the write pointers can't be unbalanced.
> > +      */
> > +     if (i >=3D (blk_in_line - 1))
> > +             return 0;
> >
> > -             if (chunk->wp > line_wp)
> > +     chunk =3D pblk_get_stripe_chunk(pblk, line, i);
> > +     max_wp =3D chunk->wp;
> > +     if (max_wp > pblk->max_write_pgs)
> > +             min_wp =3D max_wp - pblk->max_write_pgs;
> > +     else
> > +             min_wp =3D 0;
> > +
> > +     i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
> > +     while (i < blk_in_line) {
> > +             chunk =3D pblk_get_stripe_chunk(pblk, line, i);
> > +             if (chunk->wp > max_wp || chunk->wp < min_wp)
> >                       return 1;
> > -             else if (chunk->wp < line_wp)
> > -                     line_wp =3D chunk->wp;
> > +
> > +             i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i=
 + 1);
> >       }
> >
> >       return 0;
> > @@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, s=
truct pblk_line *line,
> >       int ret;
> >       u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - lm->smeta_s=
ec;
> >
> > -     if (pblk_line_wp_is_unbalanced(pblk, line))
> > +     if (pblk_line_wps_are_unbalanced(pblk, line))
> >               pblk_warn(pblk, "recovering unbalanced line (%d)\n", line=
->id);
> >
> >       ppa_list =3D p.ppa_list;
> > --
> > 2.17.1
>
> If I am understanding correctly, you want to protect against the case
> where a pfail has broken the ws_min partition of a chunk, right? I say
> this because there is a guarantee that the minimal write size and pblk's
> write size align with ws_min and ws_opt. Even if we have grown bad
> blocks on pfail for the current line (which is a bigger problem because
> we have potentially lost data), this guarantee would remain.
>
> If this is the case, my first reaction would be to say that the
> controller is responsible for guaranteeing atomicity for both scalar and
> vector I/Os. If this is not guaranteed, we have bigger problems than
> this (e.g., for the write error recovery path).
>
> Are you thinking of a different case?

The write pointer check triggers a warning if something unexpected has
happened to the chunks.
i.e. if something else than pblk messed with the disk, or if the user
tries to recover a pblk instance with an invalid lun configuration.

This patch adds a warning if a chunk wp is too small(i.e. if a chunk
was unexpectedly reset)

>
> Javier
>

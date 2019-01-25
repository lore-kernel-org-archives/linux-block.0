Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA7C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 12:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1C4218DE
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="RghXM9T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfAYM71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:59:27 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46832 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYM71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 07:59:27 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so5580125vso.13
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wUbXWqr9BTzyETvw+qRWdGyul5H0Fbq00aR87XzsIAI=;
        b=RghXM9T0jFTOSxj6DiL93Kcjpf6asbB36zG9iTD0MExj6pawXSnwq06EU2Y4ikqQjC
         Rg/VSlOoQp9K3X95nETYCDCmJozfbOTZDiZCC7KPOBvRIxWY7kPn4RzZp/pW1xhTZSem
         NmUd7JtVkBocsWuSuicDcjaIyychokr5bDw1AlXPl1vBmVQcrMh54FaPdUhgMmaBAnl0
         ZXQDZ0RT1ooMnIM2/C9NBpO6m9MIiqf4m80jIGe6AfhruA2ganxaEsjIXTTe/r+itbEB
         Kl29u3tsFtfN+YjPk4yYeftwMv+toPXPonVzID5Q+Xoc/WWxvL2R+UBHLU/i+xZpIdrN
         TfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wUbXWqr9BTzyETvw+qRWdGyul5H0Fbq00aR87XzsIAI=;
        b=TphBmGMT9tSB0D6spkVKJ1+V5yZ1QE9jsKb2FLKIDlD7sUYzQ3e/Sda2DUnoytbfy7
         W8Bl2QFQHFOoqx0I15q9tB7agLzimCA6IWQ9FFTTO5OACJrF2e540SAuQngkuPXoxtsH
         Gve9mLrD13aKFdiC2qX9sxPZxeP77wPZPbD3DUi8BcUHjkCMmQA8SUhqlMYGU9uBxBZX
         FwF69yyBWF+9HQSwb0vYZigK0dTLwasPxiyGnPIFZwxYVYpQDGYUaXrP98S43WinQRrM
         oFSmje8y8Tgl9wOJeR3btQD75l0uDgocBoTW5u1PWCzmN71YHmJhwd71IFkE2pAF5W00
         +VIw==
X-Gm-Message-State: AJcUukdOtbcCDtXY5cxlqS34390+QptBlqfK0QKmBIG6AzK56fsc3Uj8
        XPHknwst9PpU540Ta17SurXaO11B5vzY+DWtVGhl4FfB
X-Google-Smtp-Source: ALg8bN4UhhsikJcErGib8CZbtsJj60RcI+acM+hhJAnR15/4ppSl9YBOIfU2Jw//UaKP68SYK8mTei3IMYR64adrAkk=
X-Received: by 2002:a67:2584:: with SMTP id l126mr4470355vsl.153.1548421165634;
 Fri, 25 Jan 2019 04:59:25 -0800 (PST)
MIME-Version: 1.0
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com> <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com>
In-Reply-To: <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 25 Jan 2019 13:59:14 +0100
Message-ID: <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Zhoujie Wu <zjwu@marvell.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, hongd@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 10:41 AM Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>
>
> > On 25 Jan 2019, at 09.47, Hans Holmberg <hans.ml.holmberg@owltronix.com=
> wrote:
> >
> > On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrote:
> >> The write pointer of the bad block could be 0 or undefined, ignore
> >> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
> >> avoid fake warning.
> >
> > fake -> spurious?
> >
> >> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> >> ---
> >> v3: return in case bit >=3D lm->blk_per_line.
> >> v2: changed according to Javier's comments.
> >>
> >> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
> >> 1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-=
recovery.c
> >> index 6761d2a..02d466e 100644
> >> --- a/drivers/lightnvm/pblk-recovery.c
> >> +++ b/drivers/lightnvm/pblk-recovery.c
> >> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct pbl=
k *pblk,
> >>        struct nvm_chk_meta *chunk;
> >>        struct ppa_addr ppa;
> >>        u64 line_wp;
> >> -       int pos, i;
> >> +       int pos, i, bit;
> >
> > We don't need both bit and i, one of them is enough.
> >
> >> -       rlun =3D &pblk->luns[0];
> >> +       bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line=
);
> >> +       if (bit >=3D lm->blk_per_line)
> >> +               return 0;
> >
> > If there is only one non-offline chunk in the line, the wp can't be unb=
alanced,
> > so it should be safe to return 0 here if bit >=3D lm->blk_per_line - 1
> >
> > If you change this please document why using a comment, as it might
> > not be obvious
> >
> >> +       rlun =3D &pblk->luns[bit];
> >>        ppa =3D rlun->bppa;
> >>        pos =3D pblk_ppa_to_pos(geo, ppa);
> >>        chunk =3D &line->chks[pos];
> >
> >>        line_wp =3D chunk->wp;
> >>
> >> -       for (i =3D 1; i < lm->blk_per_line; i++) {
> >> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
> >
> >>                rlun =3D &pblk->luns[i];
> >>                ppa =3D rlun->bppa;
> >>                pos =3D pblk_ppa_to_pos(geo, ppa);
> >>                chunk =3D &line->chks[pos];
> >
> > This code is a copy of the code above, it'd be nice to refactor it
> > into a helper function or just do the chunk lookups in one place.
> >
> >> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
> >> +                       continue;
> >> +
> >
> > Since we rely on the block bitmap anyway, we might as well just
> > iterate over the zeroes in the block bitmap using find_next_zero_bit
> > instead.
> > We do this in lots of other places, see: git grep -n
> > find_next_zero_bit -- drivers/lightnvm
> >
>
> Hans, I proposed him to use the chunk->state instead. I think it is way
> more robust. We introduced the block bitmap for OCSSD 1.2, because there
> was no state. Now that we have state, it is better to use it instead. In
> fact, we should remove the bock bitmap as we have to check for the state
> either way - note that this aligns also very well with you patches
> removing the other bitmaps.

These are just nitpicks.

Relying on two data structures(chunks, block bitmap) to be in sync in
this function in stead of one does not make it more robust imho.
Either or (checking chunks or the block bitmap) is fine by me.
Searching the bitmap is more efficient, so that is what I proposed.

If we want to remove the block bitmap, we can do that as a separate patch(s=
et)
I do agree, having two copies of the chunk state is something worth
getting rid of :)

>
> Javier

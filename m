Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E59C4360F
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F3120823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="B7oUP03m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCDJlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:41:11 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36647 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDJlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:41:11 -0500
Received: by mail-ua1-f66.google.com with SMTP id e15so3830217uam.3
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6tR+ArB1d0oQQpXaavFx/fSXPSXwQehUgRF+rzlu5kA=;
        b=B7oUP03meddEeqbyGPVv3QKGSxE2jl3HMYJPNPmDUJqos10c0HRQZowMfyv0GTnXu0
         SOcOob0xSXGRp3aMVDTU7M3ieXndduuNYpIw1qq4Y817s6Ss42RcXF68xpw4n/gP1HD1
         nFw+jfb0tmq+0IY22/lk6MnhMINN/oBH6Z1T1UHkbo8j326FvbChU1WYIo+uJ4wFBZ3b
         ovFO7Tj2wS2l1hYn6iMRvqyO+twTrvpDhNS0hhO6SX+uzN1kG7FZvId4cwYuzL0Q21pf
         rYdaiW8sH6bT52bYP5ZGfUqI2JU2jPQd9M77d57b4cDHZj4lSGanIgNuaHsG9vTaxKfS
         YY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6tR+ArB1d0oQQpXaavFx/fSXPSXwQehUgRF+rzlu5kA=;
        b=Gv+64nqiCao6uPTdgeqKi+cK98nsPl7/Pha14hE41DzxRjDQ20mUzyvmzryIG1z5Mt
         91tYLxD8L3ZxUk0M63uMfaYwnuEfbjNIXPiB11u3fm+HQOBFOxjAGeTKRPwN+tk7jC7I
         MkeMRGz8liFJqXH1rLSVxLobBt5BlqyITOkr7cgq1au1LQrECXnY57neT8dlhCgmXnI3
         QtRQGTXdUOe80fzYyaqgFFFD1vILJc0TQ99zBWeY3O/0larbBbg10yIBvmCEl9+B2KXn
         5YL7zxMAa+M9C6UsrrhsMn4pX7ArkTP7tJWgoIw6UgX+VzPVmgfRl5P2AU6SsdfzyudK
         kngw==
X-Gm-Message-State: APjAAAWTLCRnsSuav7VFOzKd6iCSGB0dyZ2GAwZRYq5COysddzKalNCq
        uwBvlkCnCjapNT3GQ95TLfYNK8WIKGf/C8KJ+axupQ==
X-Google-Smtp-Source: APXvYqz46HwHla2jDg+7VVEVQSqGp15leC13mBy6BnCnnQg0L63TrrVc77H1XXqFfavk6lZAQfbkPMnPBGOivW45qMU=
X-Received: by 2002:a67:f409:: with SMTP id p9mr9070895vsn.213.1551692470287;
 Mon, 04 Mar 2019 01:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-12-igor.j.konopko@intel.com> <598BE9AB-6D64-43A4-A4BA-4B74EA8C4EEB@javigon.com>
In-Reply-To: <598BE9AB-6D64-43A4-A4BA-4B74EA8C4EEB@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 10:40:59 +0100
Message-ID: <CANr-nt1=ax4mW0zCjbSXSzqDj7WKoRXh-+ZkNa4r3AKR3kt43w@mail.gmail.com>
Subject: Re: [PATCH 11/13] lightnvm: pblk: Remove unused smeta_ssec field
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

Good riddance!

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Mon, Mar 4, 2019 at 9:21 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Smeta_ssec field in pblk_line is set once and
> > never used, since it was replaced by function
> > pblk_line_smeta_start(). This patch removes
> > this no longer needed field
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 1 -
> > drivers/lightnvm/pblk.h      | 1 -
> > 2 files changed, 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index 2e424c0275c1..fa4dc05608ff 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -1165,7 +1165,6 @@ static int pblk_line_init_bb(struct pblk *pblk, s=
truct pblk_line *line,
> >       off =3D bit * geo->ws_opt;
> >       bitmap_set(line->map_bitmap, off, lm->smeta_sec);
> >       line->sec_in_line -=3D lm->smeta_sec;
> > -     line->smeta_ssec =3D off;
> >       line->cur_sec =3D off + lm->smeta_sec;
> >
> >       if (init && pblk_line_smeta_write(pblk, line, off)) {
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index a92377530930..b266563508e6 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -464,7 +464,6 @@ struct pblk_line {
> >       int meta_line;                  /* Metadata line id */
> >       int meta_distance;              /* Distance between data and meta=
data */
> >
> > -     u64 smeta_ssec;                 /* Sector where smeta starts */
> >       u64 emeta_ssec;                 /* Sector where emeta starts */
> >
> >       unsigned int sec_in_line;       /* Number of usable secs in line =
*/
> > --
> > 2.17.1
>
> Looks good to me.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

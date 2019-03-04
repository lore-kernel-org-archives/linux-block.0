Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC0DC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D59E20815
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="V0UJXXhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfCDMms (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:42:48 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38636 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDMms (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 07:42:48 -0500
Received: by mail-ua1-f67.google.com with SMTP id d4so4243287uap.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 04:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gzOlCLaBDcRafSW2CGv0UV4snOmBRy53fuZQiSwyNHI=;
        b=V0UJXXhRmQPzaR4Ho2l1K6eUUk1KnV0aPmRZZdIyrvJViYoVM7bmSmRtUHbvJO/7R7
         fmJUG8W557Ty3HohdMu+OacYd+ruSStlgO0+2fQiolKkSiwtlIowkmKM1Q2CkSZ7pfaR
         QZce6k02IR02Ql3q7yoSr8m1hVZNBf4LEyBz62Qsa2R4GLx3bDPO3+hntGMe+sWLXcB/
         0l+nd3JCzYgfNY9aa0+zzxg2Q067UBZbReRyzpXVtybOKcDfBtjMwBrMvYnHPbKL888B
         lWgYKo2NzKuifKZmk2SZ8L4Da3U526FqXgLW8APsK9M8YOvN4KW/gD0MJ7RQON8O+4Cc
         xCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gzOlCLaBDcRafSW2CGv0UV4snOmBRy53fuZQiSwyNHI=;
        b=nVbiUb/G/SmSf+bIUU2KK5B+aslB3fR70Gt/0qycBJsK/hdGB1MflplCc3cjjuCBI9
         UwDI3E9h+a8jY4cU3kIFw5CzS31OG8QG7itSZpgP0rXO8HTkX/ERMw1jWTg4ihT6Fk/L
         b7TYdmbT97tv5Qrl/6GGPIkC5OkAyA7Zczyt9z5Nm91Y7FLc2UBSaJmh1Md7VyWEjRcD
         Eu9vsSlt6Ce8xtTvM7AsOBHjjwkQN0jF29CFfwEUQ4jPsm/WXvbGSlTvioWFlvx5v8u1
         BcBNvYfeHgA5ncPl1otDVnMEOmkzXjE5MOuCyEwOuk1pRmAQjl/peEh/Y82B46Q0DywQ
         nZnQ==
X-Gm-Message-State: APjAAAUjfl9M9dwTKQz6R0nlLGqnbTExBvi3wDZr/JkWhLkMpT7vbjcl
        X7nTvUGINn1PsRLSNk/LMcXJPcH/vubwwFp+Nkwvnw==
X-Google-Smtp-Source: APXvYqz86XgpbPb102sClZs87PeL5X4jrk5nm3H45wyWdE40lYJ8MolkeBiJkztmyJVN9CK5HJ3RU1hEEMuIXXe9e9Q=
X-Received: by 2002:a67:f744:: with SMTP id w4mr9818226vso.16.1551703366879;
 Mon, 04 Mar 2019 04:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-5-igor.j.konopko@intel.com> <2DABC388-6D60-4253-9DD0-5FD2FDEED619@javigon.com>
 <CANr-nt2U760+wpF_KvY2vSAqt9eSnynUsisoTAADjhj12BYJEg@mail.gmail.com> <e7517ee3-8310-f513-e0f8-6d2c5b19e868@intel.com>
In-Reply-To: <e7517ee3-8310-f513-e0f8-6d2c5b19e868@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 13:42:36 +0100
Message-ID: <CANr-nt0OwOMWCL7XT5nSSZ-giQkh1xX-fq9T0dRrNPh7Nzbfcw@mail.gmail.com>
Subject: Re: [PATCH 04/13] lightnvm: pblk: Rollback in gc read
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 1:39 PM Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
>
>
>
> On 04.03.2019 09:44, Hans Holmberg wrote:
> > Did you ever see this in the wild?
> > The only time pblk_gc_line returns an error is if
> > kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL); fails, and then
> > we're in real trouble :)
>
> I never saw this in real life, but still probably good to have a
> "proper" handling - since we already have "some" handling.

Yes!


>
> >
> > Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > On Mon, Mar 4, 2019 at 8:38 AM Javier Gonz=C3=A1lez <javier@javigon.com=
> wrote:
> >>
> >>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
> >>>
> >>> Currently in case of error returned by pblk_gc_line
> >>> to pblk_gc_read we leave current line unassigned
> >>> from all the lists. This patch fixes that issue.
> >>>
> >>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>> ---
> >>> drivers/lightnvm/pblk-gc.c | 7 ++++++-
> >>> 1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> >>> index 511ed0d5333c..533da6ea3e15 100644
> >>> --- a/drivers/lightnvm/pblk-gc.c
> >>> +++ b/drivers/lightnvm/pblk-gc.c
> >>> @@ -361,8 +361,13 @@ static int pblk_gc_read(struct pblk *pblk)
> >>>
> >>>        pblk_gc_kick(pblk);
> >>>
> >>> -     if (pblk_gc_line(pblk, line))
> >>> +     if (pblk_gc_line(pblk, line)) {
> >>>                pblk_err(pblk, "failed to GC line %d\n", line->id);
> >>> +             /* rollback */
> >>> +             spin_lock(&gc->r_lock);
> >>> +             list_add_tail(&line->list, &gc->r_list);
> >>> +             spin_unlock(&gc->r_lock);
> >>> +     }
> >>>
> >>>        return 0;
> >>> }
> >>> --
> >>> 2.17.1
> >>
> >> Looks good to me.
> >>
> >> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

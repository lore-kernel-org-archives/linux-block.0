Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8CC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E30220823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="uYMR0eiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCDJj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:39:58 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37587 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDJj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:39:58 -0500
Received: by mail-ua1-f67.google.com with SMTP id x1so3818945uaj.4
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4xksPjJv7G4ghrjrRKOdobngVcmqMVIgotuxGBKvAKs=;
        b=uYMR0eivW3W+70YrZ712CcmWpkiyaABvWBDhoes6sT34etvG3ooToJe7m37NKHv7nu
         Rz+gvl1A4H3qBgiAwVA1tbvzrEQQQAbVdbGsZ6rtsbV00uaguoSPQYsD+cATL7FbUFDQ
         PUBwbhkq7kEnUC0JYzl82ns2FzP6H71KSN+YBtq6oiK36i0Lsk1hevNWDmDvq5O3t+eP
         0P3KSeCcOVJPbUelYPpmYaoQu2053ZiQY4vtPrFLEWcJu5g6Kc5kfxETKhcBez0GPWJF
         KESte3gwbSHzsQzigu4thPMT4SekrT+cRcRxffbDX+vm/vHECV9BxumUjJbO7kQmy4rP
         DQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4xksPjJv7G4ghrjrRKOdobngVcmqMVIgotuxGBKvAKs=;
        b=A8m5SWTlzbbPytpGMzQD7avhPw6wZ2OVtnRYaPmN9ZodvriMbcpIMC7hoqKNz/9AgN
         zmy7HdilPCaKxpUgdcIZ5MDP7jJnaIc2N7+UpSJHcP+borbFVrA3rJMLhSu0Cy1tL4sb
         ZQVDplM+Lvp6ul5QvkfsHE9b+uWoil2dGY6GLQpsb65H9xKUMfIfZw+bTgzCxAgY1AWp
         X3CGmrzc/K7AFj5QPXErPhePpdUFRktr3mr9ph5BO67r3rhTHkLgAhHIxzeYTOXMKLEH
         6etTi9ROIS1l1ZbQ5SUPRA+kj8/9mbVEnZL0JFx5ptG/0b6RX/0m6Do3gfDpw6nk1/yk
         fZrg==
X-Gm-Message-State: APjAAAVOhTMHFrcavJe+UNKWF694+gHdQGdCMS97EhEGrjhyi82dxWyk
        R5SysBiWUrH90yeI696a4IDN3QOeL9NexD7lUJO3SQ==
X-Google-Smtp-Source: APXvYqx2HQpznvAW1GBU6lp8jxAisZ0EBrTfPHzJMlvuYPIACza6yB9mqgVBrEP3O2dKQwJCVcT+fXSmBqTK7EFQE6w=
X-Received: by 2002:a67:f409:: with SMTP id p9mr9068881vsn.213.1551692396771;
 Mon, 04 Mar 2019 01:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-10-igor.j.konopko@intel.com> <453C3B14-BF3A-4463-9137-326C458AB851@javigon.com>
In-Reply-To: <453C3B14-BF3A-4463-9137-326C458AB851@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Mar 2019 10:39:45 +0100
Message-ID: <CANr-nt0QgTH1mJmwz+gseXKv+qidkrscXPmhZyUounOw-eRyHA@mail.gmail.com>
Subject: Re: [PATCH 09/13] lightnvm: pblk: Kick writer for flush requests
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

On Mon, Mar 4, 2019 at 9:08 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > In case when there is no enough sector available in rwb
> > and there is flush request send we should kick write thread
> > which is not a case in current implementation. This patch
> > fixes that issue.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index 78b1eea4ab67..f48f2e77f770 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -375,8 +375,9 @@ void pblk_write_timer_fn(struct timer_list *t)
> > void pblk_write_should_kick(struct pblk *pblk)
> > {
> >       unsigned int secs_avail =3D pblk_rb_read_count(&pblk->rwb);
> > +     unsigned int secs_to_flush =3D pblk_rb_flush_point_count(&pblk->r=
wb);
> >
> > -     if (secs_avail >=3D pblk->min_write_pgs_data)
> > +     if (secs_avail >=3D pblk->min_write_pgs_data || secs_to_flush)
> >               pblk_write_kick(pblk);
> > }
> >
> > --
> > 2.17.1
>
> We already kick the write thread in case of REQ_PREFLUSH in
> pblk_write_cache(), so no need to kick again.

Yeah, I thought i fixed this issue in:

cc9c9a00b10e ("lightnvm: pblk: kick writer on new flush points")

That commit brought down the test time of some of the xfs sync tests
with a factor of 20 or so.

Igor: Have you seen any case of delayed syncs?

>
> Javier

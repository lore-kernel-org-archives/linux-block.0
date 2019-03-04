Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84822C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4435020823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="L7grHSJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCDIo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:44:59 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46468 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfCDIo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 03:44:59 -0500
Received: by mail-ua1-f68.google.com with SMTP id j8so3667749uae.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r0vkCEBGvbPG9wJ+uG5oXTcl+UjNSXVxpI0Nti+OcWU=;
        b=L7grHSJenqw4xQz9vKXgO3+hMnT6NlCMjrRt2nc+kZcRybtC3WWc3qm2ezyp6Bi3FA
         i9hvqXtWd2E5P3XCsu+mWRMAyUNVqhNXEh1EVFkeORg24hNdpxDXVgBdLXzej5LyVexW
         vk42i7d587SqGZuDwkpQyHEv3GGhWsvRd+JZqWvh6HS4t1ARO3x2Sh5EC5HrLcBvMLEr
         xrd7kLn7cUD/edDxCkWJX1VFPBuiETNDLcUO7yJunZE+KSnlaB9unp8UI8xrW4oVmpXD
         9QE7InSTHZ6yPOhsYRBee0/HJqTintnmH40C13It8B9MA+ynkzaEILmWNI45R3Jih7sN
         mdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r0vkCEBGvbPG9wJ+uG5oXTcl+UjNSXVxpI0Nti+OcWU=;
        b=NKh0CZ4yXsBpwR6FyZhdYPQfTWmcx+xB+5YOi2BBiPy9isyso6R/DlVicBuAlAyVat
         M/XRsF4+pacis5uhnY4C7EG2sl4PwIhF3Rk3i2YXS167Jkl1zNQmdEgXpvgmbUw17Grh
         je4jHGPCd+im0y+SS+874kH1Ms00nPtf4UaPifakb1wKh9Q01bnCpoupe4gQJtZWGW9T
         /HSquMFT1eN/d7aHP5rYmHSJ0BURmyNT0ofwGIGNase5X2Cho875qJvvbgTCLXyQdAss
         FyXwI/1ay+ALRMtt7jZHgDvm/GTQGT6n5mt4dz3/vP9lhUi0Fjtcs28h39Ue+tm9cE5u
         xpiQ==
X-Gm-Message-State: APjAAAW5cA30UKRLvcPw5hdWtAF5UB7uX8wcCgHgyIIfAYA+w7TDsrJB
        1YRAH23LS1Vepy/Y2txkLmXH/oakYkw/CVhKT9cExg==
X-Google-Smtp-Source: APXvYqwVs/SeEIWo8wWE9d4CII2bQscxxkw/bY69JeUmTwHK/8qwfgci99tKz0PCZ363Dp1qOvsuPZRCaKBKsD76VlA=
X-Received: by 2002:a67:f744:: with SMTP id w4mr9380190vso.16.1551689097475;
 Mon, 04 Mar 2019 00:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-5-igor.j.konopko@intel.com> <2DABC388-6D60-4253-9DD0-5FD2FDEED619@javigon.com>
In-Reply-To: <2DABC388-6D60-4253-9DD0-5FD2FDEED619@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Mar 2019 09:44:46 +0100
Message-ID: <CANr-nt2U760+wpF_KvY2vSAqt9eSnynUsisoTAADjhj12BYJEg@mail.gmail.com>
Subject: Re: [PATCH 04/13] lightnvm: pblk: Rollback in gc read
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

Did you ever see this in the wild?
The only time pblk_gc_line returns an error is if
kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL); fails, and then
we're in real trouble :)

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Mon, Mar 4, 2019 at 8:38 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Currently in case of error returned by pblk_gc_line
> > to pblk_gc_read we leave current line unassigned
> > from all the lists. This patch fixes that issue.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-gc.c | 7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> > index 511ed0d5333c..533da6ea3e15 100644
> > --- a/drivers/lightnvm/pblk-gc.c
> > +++ b/drivers/lightnvm/pblk-gc.c
> > @@ -361,8 +361,13 @@ static int pblk_gc_read(struct pblk *pblk)
> >
> >       pblk_gc_kick(pblk);
> >
> > -     if (pblk_gc_line(pblk, line))
> > +     if (pblk_gc_line(pblk, line)) {
> >               pblk_err(pblk, "failed to GC line %d\n", line->id);
> > +             /* rollback */
> > +             spin_lock(&gc->r_lock);
> > +             list_add_tail(&line->list, &gc->r_list);
> > +             spin_unlock(&gc->r_lock);
> > +     }
> >
> >       return 0;
> > }
> > --
> > 2.17.1
>
> Looks good to me.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

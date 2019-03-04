Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB4C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19A620449
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="RYlsXJe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDJYT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:24:19 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38335 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDJYT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:24:19 -0500
Received: by mail-ua1-f65.google.com with SMTP id d4so3779370uap.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57Jf4rQCDRVR7rMSWjk9Ownqrh/6+/fYfFUN3DcKsko=;
        b=RYlsXJe7ZB9kjnXd1m1qHh6n8dNAsnWGMLfZ6nRLsYmIUe0fSGE9CL7nEqtu//6zNH
         cLvo5DcQBw+FKJTNoBKQ5wKf9K3aYVXpX9HCnt8ZfC47H6PV++fqpTl3OYqZvTsupwno
         QsXPkAdgGJf/BgwG7OJWMiZmAXTr5ukGlziwyNm/E5YhReV5MjpSXz6oaXsQ1w7hPNtM
         503jeXci9vT7NB5fQYf+jpklJZgUcFPUYxYuqjI9NNsC4gO3Y1GqQymfT/BG86D5UziZ
         Cl2y253VgylkUKYMgSR34VgqoNd2CK5xohPWWhVV2aQXSoJ/JQsB9sBQcxQz/r+53n8+
         SFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57Jf4rQCDRVR7rMSWjk9Ownqrh/6+/fYfFUN3DcKsko=;
        b=A87YurGLZ3fagZaPDfEX1I6Wy2Jva6P1kChnbsjiObWBwr4z/bCP/bvG/5Py3vdfB0
         4XaV8zsQGEGNmzRz6jDZ6Ci4H0wuKy4DAgiA9xVxLvNcCvjsZok/9IrQKtKPtL5kqU6i
         GX6w2nKNZ6Fi8DxoTFyCy6EqgGjhTyhq3ITaNRqzETWsYbGAEOMvwr92UCsA5K/qSAyC
         sxzr3Ygne1tYnuPyHKOubKPVA9KtBH7vn46ayWPdF1KVsHs333jJlAT+JgyTr3H/VK37
         yquXavCwLAbf6ILZMORI0XVZpbeznv6FryqULjPdxnVDTuAwFHhSR+NiJsWxsWTQrVU2
         FprQ==
X-Gm-Message-State: APjAAAVLZYYu2736bV78IrsXkEZHs35YEQhcYiuBP14dUfB50HRgL9V6
        xNoOUsjw6gYXTnZaeULdEcpmkkf4NjQ1p3VASDDqLA==
X-Google-Smtp-Source: APXvYqwMwXTyrPliJHFFWEbNvl+Z0tVHVQxQNIpEPDfV/v8zOC0PJCtDGUEp2CLdJdVacRRrKJ0aHe2aP5QnghnBq5w=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr8489904vsb.184.1551691457748;
 Mon, 04 Mar 2019 01:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-8-igor.j.konopko@intel.com> <02F6919F-62BE-4501-BD6E-406E32DB9ABB@javigon.com>
In-Reply-To: <02F6919F-62BE-4501-BD6E-406E32DB9ABB@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 10:24:07 +0100
Message-ID: <CANr-nt2Enyog9dyZHDJs0Jsge-0g1oQ5gpkYiZ=rw+QytNW68Q@mail.gmail.com>
Subject: Re: [PATCH 07/13] lightnvm: pblk: Cleanly fail when there is not
 enough memory
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

Hi Igor,

I think you need to motivate (and document) why each of the new flags
are needed.

Thanks,
Hans

On Mon, Mar 4, 2019 at 8:53 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > L2P table can be huge in many cases, since
> > it typically requires 1GB of DRAM for 1TB
> > of drive. When there is not enough memory
> > available, OOM killer turns on and kills
> > random processes, which can be very annoying
> > for users. This patch changes the flag for
> > L2P table allocation on order to handle this
> > situation in more user friendly way
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-init.c | 9 +++++++--
> > 1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
> > index 8b643d0bffae..e553105b7ba1 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -164,9 +164,14 @@ static int pblk_l2p_init(struct pblk *pblk, bool f=
actory_init)
> >       int ret =3D 0;
> >
> >       map_size =3D pblk_trans_map_size(pblk);
> > -     pblk->trans_map =3D vmalloc(map_size);
> > -     if (!pblk->trans_map)
> > +     pblk->trans_map =3D __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN
> > +                                     | __GFP_RETRY_MAYFAIL | __GFP_HIG=
HMEM,
> > +                                     PAGE_KERNEL);
> > +     if (!pblk->trans_map) {
> > +             pblk_err(pblk, "failed to allocate L2P (need %ld of memor=
y)\n",
> > +                             map_size);
> >               return -ENOMEM;
> > +     }
> >
> >       pblk_ppa_set_empty(&ppa);
> >
> > --
> > 2.17.1
>
> Is there any extra consideration we should take when enabling high
> memory for the L2P table? If not, looks good to me.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

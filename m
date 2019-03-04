Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53286C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E9C21019
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="cMung/G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfCDJFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:05:34 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42075 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDJFe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:05:34 -0500
Received: by mail-ua1-f68.google.com with SMTP id s26so3723259uao.9
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p1c0n9VcE+Q8mIz5t/fHHR6y8niA4Xgu4Iyjua8YnCI=;
        b=cMung/G9N18ZabdrWYp644dSgPYSxKi7rWGTQGn2SMAybbuby5YrVIpVdZ49MPSAVi
         a0s5dn1056DMW4I4ivm0K4TVLRKDaEdsqjTVmXifReZVdRaOY8sruLjrwjk3bhJeSnSo
         LvlbxsjNip6u+Pj1XZTJQ84K29B12m5xLJRJSqwqwahT/wZGATIiCcQIfT6CgvUnHUG4
         5NvrhLyAt4BIHDt7JOStK5EW7p0tlXh5lpIyS3JsD6mSZ48KpjfMCUKmj0yhN20IHw9D
         pvLhwYWtO6OzO/ITIWj2WqeCKHvXq+SwR0lmrR4ILd/wm3KcX1iN6TQpzcZHlLKjCzGk
         s6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p1c0n9VcE+Q8mIz5t/fHHR6y8niA4Xgu4Iyjua8YnCI=;
        b=WF8mdoJigBVBpliY3GwYp4dbQ/2IqjfVpZt+SCQ/sI5BqiX4oS9dpifVPG/2YaTGVe
         BV1LZSnc9YumuziJKmdx7CQLqg6wVJZhLd6BWuImgP70NQ/pKjD7I2k9zZmCBVoYrt24
         ZWA4bZVuCgj31hcpfeN/ljIdXXp1lAcbMilOxrkJ13ViusOlw6YtKDz0Sx09qmm2Z9kV
         dUrkECbCeI7Yy2La3jZ/Udq6dU8SfdcSrn2i0ru1Cm+HeYqU96kzD3UQd5hIvSKCDmO8
         zrOH1jjZL1nsC/Vj6siUd6sa6dHjpOR+gGv8Fwt/qxXZW+4vM3+o2Je2990CpFoMh/KH
         CNsw==
X-Gm-Message-State: APjAAAVV9Y3ArNNRaeESgi+gsr5twW2GMn6mAWu7zwso4DZ6791t6oUe
        zcVPVf8vWZaRwfzszdp55z2XmHUBFay0ktIXXhhPdiYxKfVC/A==
X-Google-Smtp-Source: APXvYqyGq87A3i0aio40fBgO6/Asaj6+C0RRmnDLBLE/Q1U4KOVgBbT+Pp/FRH+pwmeuDJtNcLbaRAWsJLDhbdeM6J0=
X-Received: by 2002:a67:f744:: with SMTP id w4mr9417077vso.16.1551690332947;
 Mon, 04 Mar 2019 01:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com> <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
In-Reply-To: <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Mar 2019 10:05:22 +0100
Message-ID: <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
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

I strongly disagree with adding code that would mask implantation errors.

If we want more internal checks, we could add an if statement that
would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.


On Mon, Mar 4, 2019 at 8:48 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > In current pblk implementation of erase command
> > there is a chance tha sector bits are set to some
> > random values for erase PPA. This is unexpected
> > situation, since erase shall be always chunk
> > aligned. This patch fixes that issue
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 1 +
> > drivers/lightnvm/pblk-map.c  | 2 ++
> > 2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index a98b2255f963..78b1eea4ab67 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_=
line *line)
> >
> >               ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> >               ppa.a.blk =3D line->id;
> > +             ppa.a.reserved =3D 0;
> >
> >               atomic_dec(&line->left_eblks);
> >               WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> > diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> > index 79df583ea709..aea46b4ec40f 100644
> > --- a/drivers/lightnvm/pblk-map.c
> > +++ b/drivers/lightnvm/pblk-map.c
> > @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm=
_rq *rqd,
> >
> >                       *erase_ppa =3D ppa_list[i];
> >                       erase_ppa->a.blk =3D e_line->id;
> > +                     erase_ppa->a.reserved =3D 0;
> >
> >                       spin_unlock(&e_line->lock);
> >
> > @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm=
_rq *rqd,
> >               atomic_dec(&e_line->left_eblks);
> >               *erase_ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> >               erase_ppa->a.blk =3D e_line->id;
> > +             erase_ppa->a.reserved =3D 0;
> >       }
> >
> >       return 0;
> > --
> > 2.17.1
>
> I=E2=80=99m fine with adding this, but note that there is actually no
> requirement for the erase to be chunk aligned - the only bits that
> should be looked at are group, PU and chunk.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>
>
>

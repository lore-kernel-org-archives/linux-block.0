Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417EFC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097F320661
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 11:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="16t5gSXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCDLn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:43:57 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37931 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 06:43:57 -0500
Received: by mail-ua1-f65.google.com with SMTP id d4so4104705uap.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RpV/yh+GsZucf+mttJzK0HM9++qHu2YfPl4nKRkGNpQ=;
        b=16t5gSXqmsTTceXi5fF8A07SZDUaM1ytYJ7nTuo5X3DVP+piEvaMEtZLCgbYWyYZpy
         8hj2JOZnTKsTyZs1AG6bCxcQmtOIVQ/1egqzIWBbAliAYsCNucJfqv60R97et306g1ZJ
         zA3zY4maVqFdR2FlERr9vSjFym6JzdQjzhX0rJ9GGbhVuRGCjZ4R0hlb4JOVPfu0Z9J7
         qNewlyHPicaUJykUemf3mN+fF2tmZS7kQX5FmiphLRtrk7AQjrBvoRGDTyYjqPqXwfa/
         0njCbUBubzuVm6pGUgy0z2LwvBBkEr0cj9fl8cXKilykZhahL25BMttRIYHbMbsI8Kys
         zDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RpV/yh+GsZucf+mttJzK0HM9++qHu2YfPl4nKRkGNpQ=;
        b=pZv2wnmsVQSZk5dvWH4GLpmYK38OxjckLMpJZ61yRe+CMUyijiXwHXK5Q3F3S5hNwS
         ciBJobqEVBgmeiI4vHj5CT+Z9cb03TX2gFAj0bJMAi6ZIGP/nO3wPyO9E5ji1eWgxmMW
         jZ7gWHFldRFGyqBor7WNFVHxACRWZ4PFXarlEUfcraDWrxauY1TuVUHok8YhQQW4FT8g
         Lv3yBWW59umyUGd6i5/Z9FiLXyPs/ZQDQojWE8q/jpBAa2RLwRdH6fizDDDRPdx6vnAt
         DYNNy51I4KpZvGb56bQnOjX4zihOuTuUyxkWdUmAcdD7xeYyIqRRQ+e4t1e8IMrFQU53
         yT7A==
X-Gm-Message-State: APjAAAWak6vSQPDDvaf6XKb8JRmi5u5mYhNwAQVayjMnsubMY1z05fdA
        V1YsMfLdFpg84iS/Fzfj4qmhroDBr3Gd3CmBJTIvzw==
X-Google-Smtp-Source: APXvYqzLqVqQ6MyRYdQVJtyrZxbZ+4pyPuJRDxxRScrQEjD9vfKIvMmuK3TX9d5C63yQdwOPXleKHHC4m+VGQE6K4vA=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr9488113vsr.42.1551699835958;
 Mon, 04 Mar 2019 03:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com> <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com> <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com>
In-Reply-To: <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 12:43:45 +0100
Message-ID: <CANr-nt30zr_5sMEAK4Uk7VCRJPWr30zjPUVrQPA_H5kBU-nfrQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Igor Konopko <igor.j.konopko@intel.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 10:11 AM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 4 Mar 2019, at 10.05, Hans Holmberg <hans.ml.holmberg@owltronix.com>=
 wrote:
> >
> > I strongly disagree with adding code that would mask implantation error=
s.
> >
> > If we want more internal checks, we could add an if statement that
> > would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
> >
>
> Not sure who this is for - better not to top post.
>
> In any case, this is a spec grey zone. I=E2=80=99m ok with cleaning the b=
its as
> they mean nothing for the reset command. If you feel that strongly about
> this, you can take if with Igor.

Pardon the top-post. It was meant for both you and Igor.

>
> >
> > On Mon, Mar 4, 2019 at 8:48 AM Javier Gonz=C3=A1lez <javier@javigon.com=
> wrote:
> >>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
> >>>
> >>> In current pblk implementation of erase command
> >>> there is a chance tha sector bits are set to some
> >>> random values for erase PPA. This is unexpected
> >>> situation, since erase shall be always chunk
> >>> aligned. This patch fixes that issue
> >>>
> >>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>> ---
> >>> drivers/lightnvm/pblk-core.c | 1 +
> >>> drivers/lightnvm/pblk-map.c  | 2 ++
> >>> 2 files changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-cor=
e.c
> >>> index a98b2255f963..78b1eea4ab67 100644
> >>> --- a/drivers/lightnvm/pblk-core.c
> >>> +++ b/drivers/lightnvm/pblk-core.c
> >>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct pbl=
k_line *line)
> >>>
> >>>              ppa =3D pblk->luns[bit].bppa; /* set ch and lun */
> >>>              ppa.a.blk =3D line->id;
> >>> +             ppa.a.reserved =3D 0;
> >>>
> >>>              atomic_dec(&line->left_eblks);
> >>>              WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
> >>> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.=
c
> >>> index 79df583ea709..aea46b4ec40f 100644
> >>> --- a/drivers/lightnvm/pblk-map.c
> >>> +++ b/drivers/lightnvm/pblk-map.c
> >>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct n=
vm_rq *rqd,
> >>>
> >>>                      *erase_ppa =3D ppa_list[i];
> >>>                      erase_ppa->a.blk =3D e_line->id;
> >>> +                     erase_ppa->a.reserved =3D 0;
> >>>
> >>>                      spin_unlock(&e_line->lock);
> >>>
> >>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct n=
vm_rq *rqd,
> >>>              atomic_dec(&e_line->left_eblks);
> >>>              *erase_ppa =3D pblk->luns[bit].bppa; /* set ch and lun *=
/
> >>>              erase_ppa->a.blk =3D e_line->id;
> >>> +             erase_ppa->a.reserved =3D 0;
> >>>      }
> >>>
> >>>      return 0;
> >>> --
> >>> 2.17.1
> >>
> >> I=E2=80=99m fine with adding this, but note that there is actually no
> >> requirement for the erase to be chunk aligned - the only bits that
> >> should be looked at are group, PU and chunk.
> >>
> >> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

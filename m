Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4532C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C83320823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="a/a+T/Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfCDJaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:30:05 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35725 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDJaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:30:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id f88so3800577uaf.2
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lQUh2qu44cW3NZwHZ0EwJqBzKRZh/wuyaLaLETDsfi0=;
        b=a/a+T/Mv5xxOSNVj5EWHtgjOZKc7s9QMvg+wZw3HReRez7E3H4OW4m2fnAu1zkxAI5
         s5xdTvqKVJUdpvLe0UKXUnlqZzX2n3kEAiRyvbaw55pg1tQjHxcAMqrCOrGTrYlaybIT
         CIYM6H4A6Lw9YBaTPNtWY1RWtpmHFogad1USGho0NVoBEZB0ReToiyOonYYqKdA64IAt
         3Y25T6Y0iAIH4gXXRmemesWOpbkS0dQgc7RzFZ5uML57FIexIHz7jY3OAiquZuePGaZe
         WrK5BYIJj3rwR/XXIxh+C5dJ8ir/pIcGlhX4XFJtpn1z39V8lDiVfxLbcUKAzQvNYf9n
         cD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lQUh2qu44cW3NZwHZ0EwJqBzKRZh/wuyaLaLETDsfi0=;
        b=IUvbh4tdELzbvpmPdCaPqrAQhDPrLHAuWfuAX2tuyfaQBQ3QKr3sbUJm0VKJyRzJCJ
         UmigQ7Rx+Q+Xv9Gxm/WKXbdILw65n81dTVOGlqw+mK8/4BhCQpNlbmmup73cU6/68RSG
         DMCcXXsgk80fghZN0OQlsY2CkSbjv9Wp19rAQD1ZuVKs+1Hjo12Eg+zG6qJ2qrKxL2Xv
         4G9C9617cU/zezpL2RZFXJPFqYJP2ArRC4e/ALg8YcJbDY5PA88FYA+0TZnQ35sDA2c6
         LBsx+WXwtbFUFLpYqvhnuG9acoRfTUzI4L7JRh73NkPAbUUzfjSYcDKlu8FyJm/8TBOG
         cspg==
X-Gm-Message-State: APjAAAXB9avPDi3VfGWzoXWzSVUzlMZF/S1aswAeIo6RIIKO21ckc5Ju
        AGGzqaAlliB3rFj/cFB0mth4y7N7JZaYoxNMDDsNKQ==
X-Google-Smtp-Source: APXvYqw+jUtU2KVbaCpQ6dsoC/bzzbwWav9mETU21iRAqsHZT59HJkCZpSLoAOo0lrOix1vrXNGrEMJKh+dc1NzvHLw=
X-Received: by 2002:a67:bb16:: with SMTP id m22mr9243830vsn.153.1551691804322;
 Mon, 04 Mar 2019 01:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-11-igor.j.konopko@intel.com> <21B438F5-31C8-4500-AE2C-E41D8B7EE73F@javigon.com>
In-Reply-To: <21B438F5-31C8-4500-AE2C-E41D8B7EE73F@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 4 Mar 2019 10:29:53 +0100
Message-ID: <CANr-nt2=AYQuNumR_ArzVAKt14nQBWEY9g9VGUvqtg0vJGxn1A@mail.gmail.com>
Subject: Re: [PATCH 10/13] lightnvm: pblk: Reduce L2P DRAM footprint
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

Great!

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Mon, Mar 4, 2019 at 9:17 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > Currently L2P map size is calculated based on
> > the total number of available sectors, which is
> > redundant, since it contains some number of
> > over provisioning (11% by default).
> >
> > The goal of this patch is to change this size
> > to the real capacity and thus reduce the DRAM
> > footprint significantly - with default op value
> > it is approx. 110MB of DRAM less for every 1TB
> > of pblk drive.
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c     | 8 ++++----
> > drivers/lightnvm/pblk-init.c     | 7 +++----
> > drivers/lightnvm/pblk-read.c     | 2 +-
> > drivers/lightnvm/pblk-recovery.c | 2 +-
> > drivers/lightnvm/pblk.h          | 1 -
> > 5 files changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index f48f2e77f770..2e424c0275c1 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -2024,7 +2024,7 @@ void pblk_update_map(struct pblk *pblk, sector_t =
lba, struct ppa_addr ppa)
> >       struct ppa_addr ppa_l2p;
> >
> >       /* logic error: lba out-of-bounds. Ignore update */
> > -     if (!(lba < pblk->rl.nr_secs)) {
> > +     if (!(lba < pblk->capacity)) {
> >               WARN(1, "pblk: corrupted L2P map request\n");
> >               return;
> >       }
> > @@ -2064,7 +2064,7 @@ int pblk_update_map_gc(struct pblk *pblk, sector_=
t lba, struct ppa_addr ppa_new,
> > #endif
> >
> >       /* logic error: lba out-of-bounds. Ignore update */
> > -     if (!(lba < pblk->rl.nr_secs)) {
> > +     if (!(lba < pblk->capacity)) {
> >               WARN(1, "pblk: corrupted L2P map request\n");
> >               return 0;
> >       }
> > @@ -2110,7 +2110,7 @@ void pblk_update_map_dev(struct pblk *pblk, secto=
r_t lba,
> >       }
> >
> >       /* logic error: lba out-of-bounds. Ignore update */
> > -     if (!(lba < pblk->rl.nr_secs)) {
> > +     if (!(lba < pblk->capacity)) {
> >               WARN(1, "pblk: corrupted L2P map request\n");
> >               return;
> >       }
> > @@ -2168,7 +2168,7 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, stru=
ct ppa_addr *ppas,
> >               lba =3D lba_list[i];
> >               if (lba !=3D ADDR_EMPTY) {
> >                       /* logic error: lba out-of-bounds. Ignore update =
*/
> > -                     if (!(lba < pblk->rl.nr_secs)) {
> > +                     if (!(lba < pblk->capacity)) {
> >                               WARN(1, "pblk: corrupted L2P map request\=
n");
> >                               continue;
> >                       }
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
> > index e553105b7ba1..9913a4514eb6 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -105,7 +105,7 @@ static size_t pblk_trans_map_size(struct pblk *pblk=
)
> >       if (pblk->addrf_len < 32)
> >               entry_size =3D 4;
> >
> > -     return entry_size * pblk->rl.nr_secs;
> > +     return entry_size * pblk->capacity;
> > }
> >
> > #ifdef CONFIG_NVM_PBLK_DEBUG
> > @@ -175,7 +175,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool fa=
ctory_init)
> >
> >       pblk_ppa_set_empty(&ppa);
> >
> > -     for (i =3D 0; i < pblk->rl.nr_secs; i++)
> > +     for (i =3D 0; i < pblk->capacity; i++)
> >               pblk_trans_map_set(pblk, i, ppa);
> >
> >       ret =3D pblk_l2p_recover(pblk, factory_init);
> > @@ -706,7 +706,6 @@ static int pblk_set_provision(struct pblk *pblk, in=
t nr_free_chks)
> >        * on user capacity consider only provisioned blocks
> >        */
> >       pblk->rl.total_blocks =3D nr_free_chks;
> > -     pblk->rl.nr_secs =3D nr_free_chks * geo->clba;
> >
> >       /* Consider sectors used for metadata */
> >       sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_l=
ines;
> > @@ -1289,7 +1288,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, s=
truct gendisk *tdisk,
> >
> >       pblk_info(pblk, "luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
> >                       geo->all_luns, pblk->l_mg.nr_lines,
> > -                     (unsigned long long)pblk->rl.nr_secs,
> > +                     (unsigned long long)pblk->capacity,
> >                       pblk->rwb.nr_entries);
> >
> >       wake_up_process(pblk->writer_ts);
> > diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.=
c
> > index 39c1d6ccaedb..65697463def8 100644
> > --- a/drivers/lightnvm/pblk-read.c
> > +++ b/drivers/lightnvm/pblk-read.c
> > @@ -561,7 +561,7 @@ static int read_rq_gc(struct pblk *pblk, struct nvm=
_rq *rqd,
> >               goto out;
> >
> >       /* logic error: lba out-of-bounds */
> > -     if (lba >=3D pblk->rl.nr_secs) {
> > +     if (lba >=3D pblk->capacity) {
> >               WARN(1, "pblk: read lba out of bounds\n");
> >               goto out;
> >       }
> > diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-r=
ecovery.c
> > index d86f580036d3..83b467b5edc7 100644
> > --- a/drivers/lightnvm/pblk-recovery.c
> > +++ b/drivers/lightnvm/pblk-recovery.c
> > @@ -474,7 +474,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, s=
truct pblk_line *line,
> >
> >               lba_list[paddr++] =3D cpu_to_le64(lba);
> >
> > -             if (lba =3D=3D ADDR_EMPTY || lba > pblk->rl.nr_secs)
> > +             if (lba =3D=3D ADDR_EMPTY || lba >=3D pblk->capacity)
> >                       continue;
> >
> >               line->nr_valid_lbas++;
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index a6386d5acd73..a92377530930 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -305,7 +305,6 @@ struct pblk_rl {
> >
> >       struct timer_list u_timer;
> >
> > -     unsigned long long nr_secs;
> >       unsigned long total_blocks;
> >
> >       atomic_t free_blocks;           /* Total number of free blocks (+=
 OP) */
> > --
> > 2.17.1
>
> Looks good to me.
>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

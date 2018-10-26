Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42489 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeJZU0E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 16:26:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so500325vsc.9
        for <linux-block@vger.kernel.org>; Fri, 26 Oct 2018 04:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <1540510706-32603-1-git-send-email-zjwu@marvell.com> <98c75976-6d6e-d4ae-01f8-2c3e92f752ee@lightnvm.io>
In-Reply-To: <98c75976-6d6e-d4ae-01f8-2c3e92f752ee@lightnvm.io>
From: Hans Holmberg <hans@owltronix.com>
Date: Fri, 26 Oct 2018 13:49:04 +0200
Message-ID: <CANr-nt3YdEhRdvMD=MbXxKz0xj1z5BJ5GQa5p5zs0Bn2MNDvcw@mail.gmail.com>
Subject: Re: [PATCH v2] lightnvm: pblk: ignore the smeta oob area scan
To: Matias Bjorling <mb@lightnvm.io>
Cc: zjwu@marvell.com, Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org, hongd@marvell.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Yes, please do.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
On Fri, Oct 26, 2018 at 10:08 AM Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
>
> On 10/26/2018 01:38 AM, Zhoujie Wu wrote:
> > The smeta area l2p mapping is empty, and actually the
> > recovery procedure only need to restore data sector's l2p
> > mapping. So ignore the smeta oob scan.
> >
> > Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> > ---
> > v2: Modified based on suggestion from Hans. The smeta may not start fro=
m
> > paddr 0 if the first block is bad. Use pblk_line_smeta_start to calcula=
te
> > the smeta start address.
> >
> >   drivers/lightnvm/pblk-recovery.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-r=
ecovery.c
> > index 5740b75..0fbd30e 100644
> > --- a/drivers/lightnvm/pblk-recovery.c
> > +++ b/drivers/lightnvm/pblk-recovery.c
> > @@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, s=
truct pblk_line *line,
> >                              struct pblk_recov_alloc p)
> >   {
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> > +     struct pblk_line_meta *lm =3D &pblk->lm;
> >       struct nvm_geo *geo =3D &dev->geo;
> >       struct ppa_addr *ppa_list;
> >       struct pblk_sec_meta *meta_list;
> > @@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk,=
 struct pblk_line *line,
> >       void *data;
> >       dma_addr_t dma_ppa_list, dma_meta_list;
> >       __le64 *lba_list;
> > -     u64 paddr =3D 0;
> > +     u64 paddr =3D pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
> >       bool padded =3D false;
> >       int rq_ppas, rq_len;
> >       int i, j;
> >       int ret;
> > -     u64 left_ppas =3D pblk_sec_in_open_line(pblk, line);
> > +     u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - lm->smeta_s=
ec;
> >
> >       if (pblk_line_wp_is_unbalanced(pblk, line))
> >               pblk_warn(pblk, "recovering unbalanced line (%d)\n", line=
->id);
> >
>
> Looks good to me. Hans, can I add your reviewed by?

Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C5C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 10:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5CD2082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 10:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="a4a1OErP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDKGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:06:07 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33665 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDKGH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 05:06:07 -0500
Received: by mail-ua1-f65.google.com with SMTP id q17so3888076uam.0
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 02:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=As0EvbWDS/tzZyI0+I0Dcq5PD5f9nxINJm7Z6m97B8Q=;
        b=a4a1OErPsIa01y+m4xLL2vaHOgN1pZpGeVFo/8MG+HgJkzEd2n0bPQJK0owTNj7a6m
         FKUollGGajVSm3md7+rwvjiXDaTRqnX/wbp2E919gEoGjYqdaCN2RjPHa0wzvRCO8Ior
         iT9/654EupwN1d4MW9b/02TSWq3r5QM8SkgE12rxL1AQqEajZssY5OtWDxqZqQXOc8Gg
         /zsOPFAcbp/x3HdvOUKyBdD38VzObqJ8JutRdtYB+q5IOyQHcsh59BXe7OmDfDnYMknR
         AUhv9UgvaK+ce1HkG12nMK+pmsGfCaANcsVyjb/wLlIv3QTpJ99Ru0p+PdIY7tftXkGe
         qEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=As0EvbWDS/tzZyI0+I0Dcq5PD5f9nxINJm7Z6m97B8Q=;
        b=Mf4oXiL7Wb0NMwqs/+QjS2RHs0724dDX2uYxpITgNVRr3rdX2svUl9uWU5lMsQ1oeU
         T6XuOEdyRrmxDgIhWP5Pd/z6XxbeVAjMKHoyLgt8kxDLZrHFNgKmkH3qFlkFXqDnD0TN
         7g2CerWOmoM7nr5xl13jDk76A+Urih7qC+1xzjt9EtXxxbeXLtMEO3ce+nc78kQEJAhT
         doeeokeIKiBrWRy0oBSMiLUSrPidBU3+PNYZ6FAwBp9fWm9tef5s8kCin0W7E4ojHI7J
         ayvPHpiDIc72rPQGsUp1X5+WhsX6Mfxn+CDhGUWVqVFKNN8JWkhYYFubA4fK9frSz6VP
         MY+g==
X-Gm-Message-State: APjAAAVbaQVqTmXYfW22RV3TtAkSkmF3Lq5GtGqTnGXgv9nbM9VbISe8
        6zTBVsjSoc5/l91V15PDlBjVxBhdBK05ztO9UxSnHw==
X-Google-Smtp-Source: APXvYqzsc/O9Wk3oNXBzSlLVVH/noiTF42glOYdA2lDD25GxqWJC0ZcsEvjd7V+FjU5rDA/1vhMBuVfkVcLu8Rrd1Rw=
X-Received: by 2002:a67:f409:: with SMTP id p9mr9114335vsn.213.1551693966056;
 Mon, 04 Mar 2019 02:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-13-igor.j.konopko@intel.com> <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
In-Reply-To: <C2286529-B0FE-4DFE-8CD1-5BB6591549A4@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 4 Mar 2019 11:05:55 +0100
Message-ID: <CANr-nt1kkQ1H4TgF9-3yR-_S+-HkNwEnGu_t5Z607jAV30cpqw@mail.gmail.com>
Subject: Re: [PATCH 12/13] lightnvm: pblk: close opened chunks
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Matias Bjorling <mb@lightnvm.io>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Klaus Jensen <klaus.jensen@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 4, 2019 at 9:46 AM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> > On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote=
:
> >
> > When we creating pblk instance with factory
> > flag, there is a possibility that some chunks
> > are in open state, which does not allow to
> > issue erase request to them directly. Such a
> > chunk should be filled with some empty data in
> > order to achieve close state. Without that we
> > are risking that some erase operation will be
> > rejected by the drive due to inproper chunk
> > state.
> >
> > This patch implements closing chunk logic in pblk
> > for that case, when creating instance with factory
> > flag in order to fix that issue
> >
> > Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 114 +++++++++++++++++++++++++++++++++++
> > drivers/lightnvm/pblk-init.c |  14 ++++-
> > drivers/lightnvm/pblk.h      |   2 +
> > 3 files changed, 128 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index fa4dc05608ff..d3c45393f093 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -161,6 +161,120 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pb=
lk *pblk,
> >       return meta + ch_off + lun_off + chk_off;
> > }
> >
> > +static void pblk_close_chunk(struct pblk *pblk, struct ppa_addr ppa, i=
nt count)
> > +{
> > +     struct nvm_tgt_dev *dev =3D pblk->dev;
> > +     struct nvm_geo *geo =3D &dev->geo;
> > +     struct bio *bio;
> > +     struct ppa_addr *ppa_list;
> > +     struct nvm_rq rqd;
> > +     void *meta_list, *data;
> > +     dma_addr_t dma_meta_list, dma_ppa_list;
> > +     int i, rq_ppas, rq_len, ret;
> > +
> > +     meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_met=
a_list);
> > +     if (!meta_list)
> > +             return;
> > +
> > +     ppa_list =3D meta_list + pblk_dma_meta_size(pblk);
> > +     dma_ppa_list =3D dma_meta_list + pblk_dma_meta_size(pblk);
> > +
> > +     rq_ppas =3D pblk_calc_secs(pblk, count, 0, false);
> > +     if (!rq_ppas)
> > +             rq_ppas =3D pblk->min_write_pgs;
> > +     rq_len =3D rq_ppas * geo->csecs;
> > +
> > +     data =3D kzalloc(rq_len, GFP_KERNEL);
> > +     if (!data)
> > +             goto free_meta_list;
> > +
> > +     memset(&rqd, 0, sizeof(struct nvm_rq));
> > +     rqd.opcode =3D NVM_OP_PWRITE;
> > +     rqd.nr_ppas =3D rq_ppas;
> > +     rqd.meta_list =3D meta_list;
> > +     rqd.ppa_list =3D ppa_list;
> > +     rqd.dma_ppa_list =3D dma_ppa_list;
> > +     rqd.dma_meta_list =3D dma_meta_list;
> > +
> > +next_rq:
> > +     bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> > +     if (IS_ERR(bio))
> > +             goto out_next;
> > +
> > +     bio->bi_iter.bi_sector =3D 0; /* artificial bio */
> > +     bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> > +
> > +     rqd.bio =3D bio;
> > +     for (i =3D 0; i < rqd.nr_ppas; i++) {
> > +             rqd.ppa_list[i] =3D ppa;
> > +             rqd.ppa_list[i].m.sec +=3D i;
> > +             pblk_get_meta(pblk, meta_list, i)->lba =3D
> > +                                     cpu_to_le64(ADDR_EMPTY);
> > +     }
> > +
> > +     ret =3D nvm_submit_io_sync(dev, &rqd);
> > +     if (ret) {
> > +             bio_put(bio);
> > +             goto out_next;
> > +     }
> > +
> > +     if (rqd.error)
> > +             goto free_data;
> > +
> > +out_next:
> > +     count -=3D rqd.nr_ppas;
> > +     ppa.m.sec +=3D rqd.nr_ppas;
> > +     if (count > 0)
> > +             goto next_rq;
> > +
> > +free_data:
> > +     kfree(data);
> > +free_meta_list:
> > +     nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
> > +}
> > +
> > +void pblk_close_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *=
meta)
> > +{
> > +     struct nvm_tgt_dev *dev =3D pblk->dev;
> > +     struct nvm_geo *geo =3D &dev->geo;
> > +     struct nvm_chk_meta *chunk_meta;
> > +     struct ppa_addr ppa;
> > +     int i, j, k, count;
> > +
> > +     for (i =3D 0; i < geo->num_chk; i++) {
> > +             for (j =3D 0; j < geo->num_lun; j++) {
> > +                     for (k =3D 0; k < geo->num_ch; k++) {
> > +                             ppa.ppa =3D 0;
> > +                             ppa.m.grp =3D k;
> > +                             ppa.m.pu =3D j;
> > +                             ppa.m.chk =3D i;
> > +
> > +                             chunk_meta =3D pblk_chunk_get_off(pblk,
> > +                                                             meta, ppa=
);
> > +                             if (chunk_meta->state =3D=3D NVM_CHK_ST_O=
PEN) {
> > +                                     ppa.m.sec =3D chunk_meta->wp;
> > +                                     count =3D geo->clba - chunk_meta-=
>wp;
> > +                                     pblk_close_chunk(pblk, ppa, count=
);
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +}
> > +
> > +bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *me=
ta)
> > +{
> > +     struct nvm_tgt_dev *dev =3D pblk->dev;
> > +     struct nvm_geo *geo =3D &dev->geo;
> > +     int i;
> > +
> > +     for (i =3D 0; i < geo->all_luns; i++) {
> > +             if (meta[i].state =3D=3D NVM_CHK_ST_OPEN)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > void __pblk_map_invalidate(struct pblk *pblk, struct pblk_line *line,
> >                          u64 paddr)
> > {
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
> > index 9913a4514eb6..83abe6960b46 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -1028,13 +1028,14 @@ static int pblk_line_meta_init(struct pblk *pbl=
k)
> >       return 0;
> > }
> >
> > -static int pblk_lines_init(struct pblk *pblk)
> > +static int pblk_lines_init(struct pblk *pblk, bool factory_init)
> > {
> >       struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> >       struct pblk_line *line;
> >       void *chunk_meta;
> >       int nr_free_chks =3D 0;
> >       int i, ret;
> > +     bool retry =3D false;
> >
> >       ret =3D pblk_line_meta_init(pblk);
> >       if (ret)
> > @@ -1048,12 +1049,21 @@ static int pblk_lines_init(struct pblk *pblk)
> >       if (ret)
> >               goto fail_free_meta;
> >
> > +get_chunk_meta:
> >       chunk_meta =3D pblk_get_chunk_meta(pblk);
> >       if (IS_ERR(chunk_meta)) {
> >               ret =3D PTR_ERR(chunk_meta);
> >               goto fail_free_luns;
> >       }
> >
> > +     if (factory_init && !retry &&
> > +         pblk_are_opened_chunks(pblk, chunk_meta)) {
> > +             pblk_close_opened_chunks(pblk, chunk_meta);
> > +             retry =3D true;
> > +             vfree(chunk_meta);
> > +             goto get_chunk_meta;
> > +     }
> > +
> >       pblk->lines =3D kcalloc(l_mg->nr_lines, sizeof(struct pblk_line),
> >                                                               GFP_KERNE=
L);
> >       if (!pblk->lines) {
> > @@ -1244,7 +1254,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, s=
truct gendisk *tdisk,
> >               goto fail;
> >       }
> >
> > -     ret =3D pblk_lines_init(pblk);
> > +     ret =3D pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
> >       if (ret) {
> >               pblk_err(pblk, "could not initialize lines\n");
> >               goto fail_free_core;
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index b266563508e6..b248642c4dfb 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -793,6 +793,8 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pbl=
k *pblk);
> > struct nvm_chk_meta *pblk_chunk_get_off(struct pblk *pblk,
> >                                             struct nvm_chk_meta *lp,
> >                                             struct ppa_addr ppa);
> > +void pblk_close_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *=
_meta);
> > +bool pblk_are_opened_chunks(struct pblk *pblk, struct nvm_chk_meta *_m=
eta);
> > void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
> > void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
> > int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
> > --
> > 2.17.1
>
> I know that the OCSSD 2.0 spec does not allow to transition from open to
> free, but to me this is a spec bug as there is no underlying issue in
> reading an open block. Note that all controllers I know support this,
> and the upcoming Denali spec. fixes this too.

+ Klaus whom I discussed this with.
Yeah, i think that "early reset" is a nice feature. It would be nice
to extend the OCSSD spec with a new capabilities bit indicating if
this is indeed supported or not.
Matias: what do you think?

>
> Besides, the factory flag is intended to start a pblk instance
> immediately, without having to pay the price of padding any past device
> state.  If you still want to do this, I think this belongs in a user spac=
e tool.
>

Hear, hear!

Serially padding any open chunks during -f create call would be
terrible user experience.
Lets say that padding a chunk takes one second, we would, in a
worst-case scenario in an example disk, be stuck in a syscall for
1*64*1000 seconds ~ 17 hours.

A tool, like dm-zoned's dmzadm would be the right approach, see
Documentation/device-mapper/dm-zoned.txt
All new pblk instances would then have to be pre-formatted with "pblkadm"

A new physical storage format containing a superblock would also be a good =
idea.

/ Hans

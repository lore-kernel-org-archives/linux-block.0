Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5484C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 07:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F9B206B8
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 07:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="IxKkRs5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfHAHQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:16:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40462 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfHAHQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 03:16:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so34691893lji.7
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 00:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GhebAp7r7HG/k/rmqeZdou7X2gNvPCmvV74PBZem6+E=;
        b=IxKkRs5xCMIDf+6rmBxKtWXHvL4vV/YXkr5WhH/2Bs/USYHY/4u/mEdZSYCD9iNtIi
         EKZabYLgRgoEKN9c06YR7n2W5MISx2HQ92g1sAx0EBufwybTc9GlE1NInasCVbv0roi4
         znC2/T8RDG9+xAJn95a1SjEwVl+41N8a4gwPwh9614tIsw2wjJKeyb2WpCYzycBMFMrG
         uDawype7LE31C2ceavOwV9eqNQPHSsEPsnF+Oh3PzdDwEUlJsCw3rvKBW87YW1fqMV9Q
         o/baQ5lVPlwG4OZWNO0G5VSLr39/tHMHGQRBah+O6KLzUtVrHqH5bT6mmMq4wXMpQbuh
         xqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GhebAp7r7HG/k/rmqeZdou7X2gNvPCmvV74PBZem6+E=;
        b=dWuEOpnflp9HNUX9KLVnAQPALjXZT4o98KzGf3P3uwI3958kS5p5a2nBrA9ww+nWJd
         fnZG+uNJAPJhx9nn7oLN28bWosINzXN+RwYRGu6KHDZ7vOfoN+WmpgSl8PTJ96TYRFVW
         fHPXOHkUYbKva1nAAysKBN5WYSpvtsOTJMIFg/+I4vSSaLGsTlcXCBWSmQ72ZlwIC/bV
         HRm5XMpklwHY77eHhndbod/IA6L6lPAToeA+e6UlalKzxWw9m6W6uOnJAdRdCBcfxK5I
         Gt+EM8qz5LeNzHD7yL2AvW0nyT2amK0ES3TlerswT5jqFbDTykebrtldCl8LQNoDFVJa
         mrpw==
X-Gm-Message-State: APjAAAWT8dwS3I5XfGlpHhi/4bjVNLR4uC0LZ+if6fqoPdVexiKei6rj
        X2ckBZkskMNEB7LgUc+S+jVuTBFCZhYwOqWN46Q=
X-Google-Smtp-Source: APXvYqwWUCbWY2mLFZuA4xJkzowvKhMM2y64o0zv9GsPfFdisHgKby9UbLDbyTinYUQ+y59sw6gEd8rc11mGJdnakb8=
X-Received: by 2002:a2e:868e:: with SMTP id l14mr18772979lji.16.1564643770605;
 Thu, 01 Aug 2019 00:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
 <1564566096-28756-3-git-send-email-hans@owltronix.com> <69EAD2D8-72B5-4EC1-99EE-1436D1FF9241@javigon.com>
In-Reply-To: <69EAD2D8-72B5-4EC1-99EE-1436D1FF9241@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Thu, 1 Aug 2019 09:15:59 +0200
Message-ID: <CANr-nt2EAkd7uqCe2W14wxzYC3fSTCCHRJs65Zh_S4UrPfg6Hw@mail.gmail.com>
Subject: Re: [PATCH 2/4] lightnvm: move metadata mapping to lower level driver
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 3:59 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
> > On 31 Jul 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
> >
> > Now that blk_rq_map_kern can map both kmem and vmem, move
> > internal metadata mapping down to the lower level driver.
> >
> > Signed-off-by: Hans Holmberg <hans@owltronix.com>
> > ---
> > drivers/lightnvm/core.c          |  16 +++---
> > drivers/lightnvm/pblk-core.c     | 113 +++++---------------------------=
-------
> > drivers/lightnvm/pblk-read.c     |  22 ++------
> > drivers/lightnvm/pblk-recovery.c |  39 ++------------
> > drivers/lightnvm/pblk-write.c    |  20 ++-----
> > drivers/lightnvm/pblk.h          |   8 +--
> > drivers/nvme/host/lightnvm.c     |  20 +++++--
> > include/linux/lightnvm.h         |   6 +--
> > 8 files changed, 54 insertions(+), 190 deletions(-)
> >
> > diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> > index 01d098fb96ac..3cd03582a2ed 100644
> > --- a/drivers/lightnvm/core.c
> > +++ b/drivers/lightnvm/core.c
> > @@ -731,7 +731,7 @@ static int nvm_set_flags(struct nvm_geo *geo, struc=
t nvm_rq *rqd)
> >       return flags;
> > }
> >
> > -int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
> > +int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd, voi=
d *buf)
> > {
> >       struct nvm_dev *dev =3D tgt_dev->parent;
> >       int ret;
> > @@ -745,7 +745,7 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, stru=
ct nvm_rq *rqd)
> >       rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
> >
> >       /* In case of error, fail with right address format */
> > -     ret =3D dev->ops->submit_io(dev, rqd);
> > +     ret =3D dev->ops->submit_io(dev, rqd, buf);
> >       if (ret)
> >               nvm_rq_dev_to_tgt(tgt_dev, rqd);
> >       return ret;
> > @@ -759,7 +759,8 @@ static void nvm_sync_end_io(struct nvm_rq *rqd)
> >       complete(waiting);
> > }
> >
> > -static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd)
> > +static int nvm_submit_io_wait(struct nvm_dev *dev, struct nvm_rq *rqd,
> > +                           void *buf)
> > {
> >       DECLARE_COMPLETION_ONSTACK(wait);
> >       int ret =3D 0;
> > @@ -767,7 +768,7 @@ static int nvm_submit_io_wait(struct nvm_dev *dev, =
struct nvm_rq *rqd)
> >       rqd->end_io =3D nvm_sync_end_io;
> >       rqd->private =3D &wait;
> >
> > -     ret =3D dev->ops->submit_io(dev, rqd);
> > +     ret =3D dev->ops->submit_io(dev, rqd, buf);
> >       if (ret)
> >               return ret;
> >
> > @@ -776,7 +777,8 @@ static int nvm_submit_io_wait(struct nvm_dev *dev, =
struct nvm_rq *rqd)
> >       return 0;
> > }
> >
> > -int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd=
)
> > +int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd=
,
> > +                    void *buf)
> > {
> >       struct nvm_dev *dev =3D tgt_dev->parent;
> >       int ret;
> > @@ -789,7 +791,7 @@ int nvm_submit_io_sync(struct nvm_tgt_dev *tgt_dev,=
 struct nvm_rq *rqd)
> >       rqd->dev =3D tgt_dev;
> >       rqd->flags =3D nvm_set_flags(&tgt_dev->geo, rqd);
> >
> > -     ret =3D nvm_submit_io_wait(dev, rqd);
> > +     ret =3D nvm_submit_io_wait(dev, rqd, buf);
> >
> >       return ret;
> > }
> > @@ -816,7 +818,7 @@ static int nvm_submit_io_sync_raw(struct nvm_dev *d=
ev, struct nvm_rq *rqd)
> >       rqd->dev =3D NULL;
> >       rqd->flags =3D nvm_set_flags(&dev->geo, rqd);
> >
> > -     return nvm_submit_io_wait(dev, rqd);
> > +     return nvm_submit_io_wait(dev, rqd, NULL);
> > }
> >
> > static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr ppa)
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index f546e6f28b8a..a58d3c84a3f2 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -507,7 +507,7 @@ void pblk_set_sec_per_write(struct pblk *pblk, int =
sec_per_write)
> >       pblk->sec_per_write =3D sec_per_write;
> > }
> >
> > -int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
> > +int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd, void *buf)
> > {
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> >
> > @@ -518,7 +518,7 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq=
 *rqd)
> >               return NVM_IO_ERR;
> > #endif
> >
> > -     return nvm_submit_io(dev, rqd);
> > +     return nvm_submit_io(dev, rqd, buf);
> > }
> >
> > void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rq=
d)
> > @@ -541,7 +541,7 @@ void pblk_check_chunk_state_update(struct pblk *pbl=
k, struct nvm_rq *rqd)
> >       }
> > }
> >
> > -int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
> > +int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd, void *b=
uf)
> > {
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> >       int ret;
> > @@ -553,7 +553,7 @@ int pblk_submit_io_sync(struct pblk *pblk, struct n=
vm_rq *rqd)
> >               return NVM_IO_ERR;
> > #endif
> >
> > -     ret =3D nvm_submit_io_sync(dev, rqd);
> > +     ret =3D nvm_submit_io_sync(dev, rqd, buf);
> >
> >       if (trace_pblk_chunk_state_enabled() && !ret &&
> >           rqd->opcode =3D=3D NVM_OP_PWRITE)
> > @@ -562,65 +562,19 @@ int pblk_submit_io_sync(struct pblk *pblk, struct=
 nvm_rq *rqd)
> >       return ret;
> > }
> >
> > -int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> > +static int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *r=
qd,
> > +                                void *buf)
> > {
> >       struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
> >       int ret;
> >
> >       pblk_down_chunk(pblk, ppa_list[0]);
> > -     ret =3D pblk_submit_io_sync(pblk, rqd);
> > +     ret =3D pblk_submit_io_sync(pblk, rqd, buf);
> >       pblk_up_chunk(pblk, ppa_list[0]);
> >
> >       return ret;
> > }
> >
> > -static void pblk_bio_map_addr_endio(struct bio *bio)
> > -{
> > -     bio_put(bio);
> > -}
> > -
> > -struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
> > -                           unsigned int nr_secs, unsigned int len,
> > -                           int alloc_type, gfp_t gfp_mask)
> > -{
> > -     struct nvm_tgt_dev *dev =3D pblk->dev;
> > -     void *kaddr =3D data;
> > -     struct page *page;
> > -     struct bio *bio;
> > -     int i, ret;
> > -
> > -     if (alloc_type =3D=3D PBLK_KMALLOC_META)
> > -             return bio_map_kern(dev->q, kaddr, len, gfp_mask);
> > -
> > -     bio =3D bio_kmalloc(gfp_mask, nr_secs);
> > -     if (!bio)
> > -             return ERR_PTR(-ENOMEM);
> > -
> > -     for (i =3D 0; i < nr_secs; i++) {
> > -             page =3D vmalloc_to_page(kaddr);
> > -             if (!page) {
> > -                     pblk_err(pblk, "could not map vmalloc bio\n");
> > -                     bio_put(bio);
> > -                     bio =3D ERR_PTR(-ENOMEM);
> > -                     goto out;
> > -             }
> > -
> > -             ret =3D bio_add_pc_page(dev->q, bio, page, PAGE_SIZE, 0);
> > -             if (ret !=3D PAGE_SIZE) {
> > -                     pblk_err(pblk, "could not add page to bio\n");
> > -                     bio_put(bio);
> > -                     bio =3D ERR_PTR(-ENOMEM);
> > -                     goto out;
> > -             }
> > -
> > -             kaddr +=3D PAGE_SIZE;
> > -     }
> > -
> > -     bio->bi_end_io =3D pblk_bio_map_addr_endio;
> > -out:
> > -     return bio;
> > -}
> > -
> > int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
> >                  unsigned long secs_to_flush, bool skip_meta)
> > {
> > @@ -722,9 +676,7 @@ u64 pblk_line_smeta_start(struct pblk *pblk, struct=
 pblk_line *line)
> >
> > int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
> > {
> > -     struct nvm_tgt_dev *dev =3D pblk->dev;
> >       struct pblk_line_meta *lm =3D &pblk->lm;
> > -     struct bio *bio;
> >       struct ppa_addr *ppa_list;
> >       struct nvm_rq rqd;
> >       u64 paddr =3D pblk_line_smeta_start(pblk, line);
> > @@ -736,16 +688,6 @@ int pblk_line_smeta_read(struct pblk *pblk, struct=
 pblk_line *line)
> >       if (ret)
> >               return ret;
> >
> > -     bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERN=
EL);
> > -     if (IS_ERR(bio)) {
> > -             ret =3D PTR_ERR(bio);
> > -             goto clear_rqd;
> > -     }
> > -
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_READ, 0);
> > -
> > -     rqd.bio =3D bio;
> >       rqd.opcode =3D NVM_OP_PREAD;
> >       rqd.nr_ppas =3D lm->smeta_sec;
> >       rqd.is_seq =3D 1;
> > @@ -754,10 +696,9 @@ int pblk_line_smeta_read(struct pblk *pblk, struct=
 pblk_line *line)
> >       for (i =3D 0; i < lm->smeta_sec; i++, paddr++)
> >               ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, line->id);
> >
> > -     ret =3D pblk_submit_io_sync(pblk, &rqd);
> > +     ret =3D pblk_submit_io_sync(pblk, &rqd, line->smeta);
> >       if (ret) {
> >               pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
> > -             bio_put(bio);
> >               goto clear_rqd;
> >       }
> >
> > @@ -776,9 +717,7 @@ int pblk_line_smeta_read(struct pblk *pblk, struct =
pblk_line *line)
> > static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *l=
ine,
> >                                u64 paddr)
> > {
> > -     struct nvm_tgt_dev *dev =3D pblk->dev;
> >       struct pblk_line_meta *lm =3D &pblk->lm;
> > -     struct bio *bio;
> >       struct ppa_addr *ppa_list;
> >       struct nvm_rq rqd;
> >       __le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> > @@ -791,16 +730,6 @@ static int pblk_line_smeta_write(struct pblk *pblk=
, struct pblk_line *line,
> >       if (ret)
> >               return ret;
> >
> > -     bio =3D bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERN=
EL);
> > -     if (IS_ERR(bio)) {
> > -             ret =3D PTR_ERR(bio);
> > -             goto clear_rqd;
> > -     }
> > -
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> > -
> > -     rqd.bio =3D bio;
> >       rqd.opcode =3D NVM_OP_PWRITE;
> >       rqd.nr_ppas =3D lm->smeta_sec;
> >       rqd.is_seq =3D 1;
> > @@ -814,10 +743,9 @@ static int pblk_line_smeta_write(struct pblk *pblk=
, struct pblk_line *line,
> >               meta->lba =3D lba_list[paddr] =3D addr_empty;
> >       }
> >
> > -     ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
> > +     ret =3D pblk_submit_io_sync_sem(pblk, &rqd, line->smeta);
> >       if (ret) {
> >               pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
> > -             bio_put(bio);
> >               goto clear_rqd;
> >       }
> >
> > @@ -838,10 +766,8 @@ int pblk_line_emeta_read(struct pblk *pblk, struct=
 pblk_line *line,
> > {
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> >       struct nvm_geo *geo =3D &dev->geo;
> > -     struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> >       struct pblk_line_meta *lm =3D &pblk->lm;
> >       void *ppa_list_buf, *meta_list;
> > -     struct bio *bio;
> >       struct ppa_addr *ppa_list;
> >       struct nvm_rq rqd;
> >       u64 paddr =3D line->emeta_ssec;
> > @@ -867,17 +793,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct=
 pblk_line *line,
> >       rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> >       rq_len =3D rq_ppas * geo->csecs;
> >
> > -     bio =3D pblk_bio_map_addr(pblk, emeta_buf, rq_ppas, rq_len,
> > -                                     l_mg->emeta_alloc_type, GFP_KERNE=
L);
> > -     if (IS_ERR(bio)) {
> > -             ret =3D PTR_ERR(bio);
> > -             goto free_rqd_dma;
> > -     }
> > -
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_READ, 0);
> > -
> > -     rqd.bio =3D bio;
> >       rqd.meta_list =3D meta_list;
> >       rqd.ppa_list =3D ppa_list_buf;
> >       rqd.dma_meta_list =3D dma_meta_list;
> > @@ -896,7 +811,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> >               while (test_bit(pos, line->blk_bitmap)) {
> >                       paddr +=3D min;
> >                       if (pblk_boundary_paddr_checks(pblk, paddr)) {
> > -                             bio_put(bio);
> >                               ret =3D -EINTR;
> >                               goto free_rqd_dma;
> >                       }
> > @@ -906,7 +820,6 @@ int pblk_line_emeta_read(struct pblk *pblk, struct =
pblk_line *line,
> >               }
> >
> >               if (pblk_boundary_paddr_checks(pblk, paddr + min)) {
> > -                     bio_put(bio);
> >                       ret =3D -EINTR;
> >                       goto free_rqd_dma;
> >               }
> > @@ -915,10 +828,9 @@ int pblk_line_emeta_read(struct pblk *pblk, struct=
 pblk_line *line,
> >                       ppa_list[i] =3D addr_to_gen_ppa(pblk, paddr, line=
_id);
> >       }
> >
> > -     ret =3D pblk_submit_io_sync(pblk, &rqd);
> > +     ret =3D pblk_submit_io_sync(pblk, &rqd, emeta_buf);
> >       if (ret) {
> >               pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
> > -             bio_put(bio);
> >               goto free_rqd_dma;
> >       }
> >
> > @@ -963,7 +875,7 @@ static int pblk_blk_erase_sync(struct pblk *pblk, s=
truct ppa_addr ppa)
> >       /* The write thread schedules erases so that it minimizes disturb=
ances
> >        * with writes. Thus, there is no need to take the LUN semaphore.
> >        */
> > -     ret =3D pblk_submit_io_sync(pblk, &rqd);
> > +     ret =3D pblk_submit_io_sync(pblk, &rqd, NULL);
> >       rqd.private =3D pblk;
> >       __pblk_end_io_erase(pblk, &rqd);
> >
> > @@ -1792,7 +1704,7 @@ int pblk_blk_erase_async(struct pblk *pblk, struc=
t ppa_addr ppa)
> >       /* The write thread schedules erases so that it minimizes disturb=
ances
> >        * with writes. Thus, there is no need to take the LUN semaphore.
> >        */
> > -     err =3D pblk_submit_io(pblk, rqd);
> > +     err =3D pblk_submit_io(pblk, rqd, NULL);
> >       if (err) {
> >               struct nvm_tgt_dev *dev =3D pblk->dev;
> >               struct nvm_geo *geo =3D &dev->geo;
> > @@ -1923,7 +1835,6 @@ void pblk_line_close_meta(struct pblk *pblk, stru=
ct pblk_line *line)
> > static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *lin=
e)
> > {
> >       struct pblk_line_meta *lm =3D &pblk->lm;
> > -     struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> >       unsigned int lba_list_size =3D lm->emeta_len[2];
> >       struct pblk_w_err_gc *w_err_gc =3D line->w_err_gc;
> >       struct pblk_emeta *emeta =3D line->emeta;
> > diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.=
c
> > index d98ea392fe33..d572d4559e4e 100644
> > --- a/drivers/lightnvm/pblk-read.c
> > +++ b/drivers/lightnvm/pblk-read.c
> > @@ -342,7 +342,7 @@ void pblk_submit_read(struct pblk *pblk, struct bio=
 *bio)
> >               bio_put(int_bio);
> >               int_bio =3D bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set=
);
> >               goto split_retry;
> > -     } else if (pblk_submit_io(pblk, rqd)) {
> > +     } else if (pblk_submit_io(pblk, rqd, NULL)) {
> >               /* Submitting IO to drive failed, let's report an error *=
/
> >               rqd->error =3D -ENODEV;
> >               pblk_end_io_read(rqd);
> > @@ -419,7 +419,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct p=
blk_gc_rq *gc_rq)
> > {
> >       struct nvm_tgt_dev *dev =3D pblk->dev;
> >       struct nvm_geo *geo =3D &dev->geo;
> > -     struct bio *bio;
> >       struct nvm_rq rqd;
> >       int data_len;
> >       int ret =3D NVM_IO_OK;
> > @@ -447,25 +446,12 @@ int pblk_submit_read_gc(struct pblk *pblk, struct=
 pblk_gc_rq *gc_rq)
> >               goto out;
> >
> >       data_len =3D (gc_rq->secs_to_gc) * geo->csecs;
> > -     bio =3D pblk_bio_map_addr(pblk, gc_rq->data, gc_rq->secs_to_gc, d=
ata_len,
> > -                                             PBLK_VMALLOC_META, GFP_KE=
RNEL);
> > -     if (IS_ERR(bio)) {
> > -             pblk_err(pblk, "could not allocate GC bio (%lu)\n",
> > -                                                             PTR_ERR(b=
io));
> > -             ret =3D PTR_ERR(bio);
> > -             goto err_free_dma;
> > -     }
> > -
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_READ, 0);
> > -
> >       rqd.opcode =3D NVM_OP_PREAD;
> >       rqd.nr_ppas =3D gc_rq->secs_to_gc;
> > -     rqd.bio =3D bio;
> >
> > -     if (pblk_submit_io_sync(pblk, &rqd)) {
> > +     if (pblk_submit_io_sync(pblk, &rqd, gc_rq->data)) {
> >               ret =3D -EIO;
> > -             goto err_free_bio;
> > +             goto err_free_dma;
> >       }
> >
> >       pblk_read_check_rand(pblk, &rqd, gc_rq->lba_list, gc_rq->nr_secs)=
;
> > @@ -489,8 +475,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct p=
blk_gc_rq *gc_rq)
> >       pblk_free_rqd_meta(pblk, &rqd);
> >       return ret;
> >
> > -err_free_bio:
> > -     bio_put(bio);
> > err_free_dma:
> >       pblk_free_rqd_meta(pblk, &rqd);
> >       return ret;
> > diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-r=
ecovery.c
> > index e6dda04de144..d5e210c3c5b7 100644
> > --- a/drivers/lightnvm/pblk-recovery.c
> > +++ b/drivers/lightnvm/pblk-recovery.c
> > @@ -178,12 +178,11 @@ static int pblk_recov_pad_line(struct pblk *pblk,=
 struct pblk_line *line,
> >       void *meta_list;
> >       struct pblk_pad_rq *pad_rq;
> >       struct nvm_rq *rqd;
> > -     struct bio *bio;
> >       struct ppa_addr *ppa_list;
> >       void *data;
> >       __le64 *lba_list =3D emeta_to_lbas(pblk, line->emeta->buf);
> >       u64 w_ptr =3D line->cur_sec;
> > -     int left_line_ppas, rq_ppas, rq_len;
> > +     int left_line_ppas, rq_ppas;
> >       int i, j;
> >       int ret =3D 0;
> >
> > @@ -212,28 +211,15 @@ static int pblk_recov_pad_line(struct pblk *pblk,=
 struct pblk_line *line,
> >               goto fail_complete;
> >       }
> >
> > -     rq_len =3D rq_ppas * geo->csecs;
> > -
> > -     bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
> > -                                             PBLK_VMALLOC_META, GFP_KE=
RNEL);
> > -     if (IS_ERR(bio)) {
> > -             ret =3D PTR_ERR(bio);
> > -             goto fail_complete;
> > -     }
> > -
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> > -
> >       rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
> >
> >       ret =3D pblk_alloc_rqd_meta(pblk, rqd);
> >       if (ret) {
> >               pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> > -             bio_put(bio);
> >               goto fail_complete;
> >       }
> >
> > -     rqd->bio =3D bio;
> > +     rqd->bio =3D NULL;
> >       rqd->opcode =3D NVM_OP_PWRITE;
> >       rqd->is_seq =3D 1;
> >       rqd->nr_ppas =3D rq_ppas;
> > @@ -275,13 +261,12 @@ static int pblk_recov_pad_line(struct pblk *pblk,=
 struct pblk_line *line,
> >       kref_get(&pad_rq->ref);
> >       pblk_down_chunk(pblk, ppa_list[0]);
> >
> > -     ret =3D pblk_submit_io(pblk, rqd);
> > +     ret =3D pblk_submit_io(pblk, rqd, data);
> >       if (ret) {
> >               pblk_err(pblk, "I/O submission failed: %d\n", ret);
> >               pblk_up_chunk(pblk, ppa_list[0]);
> >               kref_put(&pad_rq->ref, pblk_recov_complete);
> >               pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> > -             bio_put(bio);
> >               goto fail_complete;
> >       }
> >
> > @@ -375,7 +360,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, s=
truct pblk_line *line,
> >       struct ppa_addr *ppa_list;
> >       void *meta_list;
> >       struct nvm_rq *rqd;
> > -     struct bio *bio;
> >       void *data;
> >       dma_addr_t dma_ppa_list, dma_meta_list;
> >       __le64 *lba_list;
> > @@ -407,15 +391,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> >       rq_len =3D rq_ppas * geo->csecs;
> >
> > retry_rq:
> > -     bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> > -     if (IS_ERR(bio))
> > -             return PTR_ERR(bio);
> > -
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_READ, 0);
> > -     bio_get(bio);
> > -
> > -     rqd->bio =3D bio;
> > +     rqd->bio =3D NULL;
> >       rqd->opcode =3D NVM_OP_PREAD;
> >       rqd->meta_list =3D meta_list;
> >       rqd->nr_ppas =3D rq_ppas;
> > @@ -445,10 +421,9 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> >                               addr_to_gen_ppa(pblk, paddr + j, line->id=
);
> >       }
> >
> > -     ret =3D pblk_submit_io_sync(pblk, rqd);
> > +     ret =3D pblk_submit_io_sync(pblk, rqd, data);
> >       if (ret) {
> >               pblk_err(pblk, "I/O submission failed: %d\n", ret);
> > -             bio_put(bio);
> >               return ret;
> >       }
> >
> > @@ -460,24 +435,20 @@ static int pblk_recov_scan_oob(struct pblk *pblk,=
 struct pblk_line *line,
> >
> >               if (padded) {
> >                       pblk_log_read_err(pblk, rqd);
> > -                     bio_put(bio);
> >                       return -EINTR;
> >               }
> >
> >               pad_distance =3D pblk_pad_distance(pblk, line);
> >               ret =3D pblk_recov_pad_line(pblk, line, pad_distance);
> >               if (ret) {
> > -                     bio_put(bio);
> >                       return ret;
> >               }
> >
> >               padded =3D true;
> > -             bio_put(bio);
> >               goto retry_rq;
> >       }
> >
> >       pblk_get_packed_meta(pblk, rqd);
> > -     bio_put(bio);
> >
> >       for (i =3D 0; i < rqd->nr_ppas; i++) {
> >               struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, meta_l=
ist, i);
> > diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-writ=
e.c
> > index 4e63f9b5954c..b9a2aeba95ab 100644
> > --- a/drivers/lightnvm/pblk-write.c
> > +++ b/drivers/lightnvm/pblk-write.c
> > @@ -373,7 +373,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct p=
blk_line *meta_line)
> >       struct pblk_emeta *emeta =3D meta_line->emeta;
> >       struct ppa_addr *ppa_list;
> >       struct pblk_g_ctx *m_ctx;
> > -     struct bio *bio;
> >       struct nvm_rq *rqd;
> >       void *data;
> >       u64 paddr;
> > @@ -391,20 +390,9 @@ int pblk_submit_meta_io(struct pblk *pblk, struct =
pblk_line *meta_line)
> >       rq_len =3D rq_ppas * geo->csecs;
> >       data =3D ((void *)emeta->buf) + emeta->mem;
> >
> > -     bio =3D pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
> > -                                     l_mg->emeta_alloc_type, GFP_KERNE=
L);
> > -     if (IS_ERR(bio)) {
> > -             pblk_err(pblk, "failed to map emeta io");
> > -             ret =3D PTR_ERR(bio);
> > -             goto fail_free_rqd;
> > -     }
> > -     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> > -     bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> > -     rqd->bio =3D bio;
> > -
> >       ret =3D pblk_alloc_w_rq(pblk, rqd, rq_ppas, pblk_end_io_write_met=
a);
> >       if (ret)
> > -             goto fail_free_bio;
> > +             goto fail_free_rqd;
> >
> >       ppa_list =3D nvm_rq_to_ppa_list(rqd);
> >       for (i =3D 0; i < rqd->nr_ppas; ) {
> > @@ -423,7 +411,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct p=
blk_line *meta_line)
> >
> >       pblk_down_chunk(pblk, ppa_list[0]);
> >
> > -     ret =3D pblk_submit_io(pblk, rqd);
> > +     ret =3D pblk_submit_io(pblk, rqd, data);
> >       if (ret) {
> >               pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
> >               goto fail_rollback;
> > @@ -437,8 +425,6 @@ int pblk_submit_meta_io(struct pblk *pblk, struct p=
blk_line *meta_line)
> >       pblk_dealloc_page(pblk, meta_line, rq_ppas);
> >       list_add(&meta_line->list, &meta_line->list);
> >       spin_unlock(&l_mg->close_lock);
> > -fail_free_bio:
> > -     bio_put(bio);
> > fail_free_rqd:
> >       pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> >       return ret;
> > @@ -523,7 +509,7 @@ static int pblk_submit_io_set(struct pblk *pblk, st=
ruct nvm_rq *rqd)
> >       meta_line =3D pblk_should_submit_meta_io(pblk, rqd);
> >
> >       /* Submit data write for current data line */
> > -     err =3D pblk_submit_io(pblk, rqd);
> > +     err =3D pblk_submit_io(pblk, rqd, NULL);
> >       if (err) {
> >               pblk_err(pblk, "data I/O submission failed: %d\n", err);
> >               return NVM_IO_ERR;
> > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > index a67855387f53..d515d3409a74 100644
> > --- a/drivers/lightnvm/pblk.h
> > +++ b/drivers/lightnvm/pblk.h
> > @@ -783,14 +783,10 @@ struct nvm_chk_meta *pblk_chunk_get_off(struct pb=
lk *pblk,
> >                                             struct ppa_addr ppa);
> > void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
> > void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
> > -int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
> > -int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> > -int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
> > +int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd, void *buf);
> > +int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd, void *b=
uf);
> > int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)=
;
> > void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rq=
d);
> > -struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
> > -                           unsigned int nr_secs, unsigned int len,
> > -                           int alloc_type, gfp_t gfp_mask);
> > struct pblk_line *pblk_line_get(struct pblk *pblk);
> > struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
> > struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
> > diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.=
c
> > index d6f121452d5d..ec46693f6b64 100644
> > --- a/drivers/nvme/host/lightnvm.c
> > +++ b/drivers/nvme/host/lightnvm.c
> > @@ -667,11 +667,14 @@ static struct request *nvme_nvm_alloc_request(str=
uct request_queue *q,
> >       return rq;
> > }
> >
> > -static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
> > +static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
> > +                           void *buf)
> > {
> > +     struct nvm_geo *geo =3D &dev->geo;
> >       struct request_queue *q =3D dev->q;
> >       struct nvme_nvm_command *cmd;
> >       struct request *rq;
> > +     int ret;
> >
> >       cmd =3D kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
> >       if (!cmd)
> > @@ -679,8 +682,15 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev,=
 struct nvm_rq *rqd)
> >
> >       rq =3D nvme_nvm_alloc_request(q, rqd, cmd);
> >       if (IS_ERR(rq)) {
> > -             kfree(cmd);
> > -             return PTR_ERR(rq);
> > +             ret =3D PTR_ERR(rq);
> > +             goto err_free_cmd;
> > +     }
> > +
> > +     if (buf) {
> > +             ret =3D blk_rq_map_kern(q, rq, buf, geo->csecs * rqd->nr_=
ppas,
> > +                             GFP_KERNEL);
> > +             if (ret)
> > +                     goto err_free_cmd;
> >       }
> >
> >       rq->end_io_data =3D rqd;
> > @@ -688,6 +698,10 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev,=
 struct nvm_rq *rqd)
> >       blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
> >
> >       return 0;
> > +
> > +err_free_cmd:
> > +     kfree(cmd);
> > +     return ret;
> > }
> >
> > static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *nam=
e,
> > diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> > index 8891647b24b1..ee8ec2e68055 100644
> > --- a/include/linux/lightnvm.h
> > +++ b/include/linux/lightnvm.h
> > @@ -88,7 +88,7 @@ typedef int (nvm_op_bb_tbl_fn)(struct nvm_dev *, stru=
ct ppa_addr, u8 *);
> > typedef int (nvm_op_set_bb_fn)(struct nvm_dev *, struct ppa_addr *, int=
, int);
> > typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
> >                                                       struct nvm_chk_me=
ta *);
> > -typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
> > +typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *, void=
 *);
> > typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
> > typedef void (nvm_destroy_dma_pool_fn)(void *);
> > typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
> > @@ -680,8 +680,8 @@ extern int nvm_get_chunk_meta(struct nvm_tgt_dev *,=
 struct ppa_addr,
> >                             int, struct nvm_chk_meta *);
> > extern int nvm_set_chunk_meta(struct nvm_tgt_dev *, struct ppa_addr *,
> >                             int, int);
> > -extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *);
> > -extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *);
> > +extern int nvm_submit_io(struct nvm_tgt_dev *, struct nvm_rq *, void *=
);
> > +extern int nvm_submit_io_sync(struct nvm_tgt_dev *, struct nvm_rq *, v=
oid *);
> > extern void nvm_end_io(struct nvm_rq *);
> >
> > #else /* CONFIG_NVM */
> > --
> > 2.7.4
>
> It=E2=80=99s very good to get rid of pblk_bio_map_addr(). Need to look at=
 this
> closer because I remember a number of corner cases due to the metadata
> allocation. Have you tested the vmalloc allocation path? Note that you
> need big lines for this to happen as it will try to do kmalloc if
> possible

Yeah, i checked that vmalloc worked for the emeta buffers(by switching
over manually), so we should be good.

>
> Javier

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUFpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Sep 2018 01:45:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id r1-v6so2780925wmh.0
        for <linux-block@vger.kernel.org>; Thu, 20 Sep 2018 16:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180917052939.4776-1-hlitz@ucsc.edu> <20180917052939.4776-6-hlitz@ucsc.edu>
 <CANr-nt0mqkt+CsCsKXG=h8LP3=dw0BC2FpPxar4aiGR96B=m5Q@mail.gmail.com>
 <CAJbgVnVn+ryw_3PawRNQJBYoQUpYRFK_-7NzX=jht7xP85mhLQ@mail.gmail.com> <CANr-nt1kBAsMUNL1MFnGmczzzL8Y5Sq30JdtybiW5JxTZcsO5A@mail.gmail.com>
In-Reply-To: <CANr-nt1kBAsMUNL1MFnGmczzzL8Y5Sq30JdtybiW5JxTZcsO5A@mail.gmail.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Thu, 20 Sep 2018 16:58:57 -0700
Message-ID: <CAJbgVnUk_vFhNzwddENEoEhgBSBgCfcfjx80JVZHEOerpy1iAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] lightnvm: pblk: Add RAIL interface
To: hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        igor.j.konopko@intel.com, marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 19, 2018 at 12:53 AM Hans Holmberg
<hans.ml.holmberg@owltronix.com> wrote:
>
> On Tue, Sep 18, 2018 at 6:11 PM Heiner Litz <hlitz@ucsc.edu> wrote:
> >
> > On Tue, Sep 18, 2018 at 4:28 AM Hans Holmberg
> > <hans.ml.holmberg@owltronix.com> wrote:
> > >
> > > On Mon, Sep 17, 2018 at 7:30 AM Heiner Litz <hlitz@ucsc.edu> wrote:
> > > >
> > > > In prepartion of supporting RAIL, add the RAIL API.
> > > >
> > > > Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> > > > ---
> > > >  drivers/lightnvm/pblk-rail.c | 808 +++++++++++++++++++++++++++++++++++
> > > >  drivers/lightnvm/pblk.h      |  63 ++-
> > > >  2 files changed, 870 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/lightnvm/pblk-rail.c
> > > >
> > > > diff --git a/drivers/lightnvm/pblk-rail.c b/drivers/lightnvm/pblk-rail.c
> > > > new file mode 100644
> > > > index 000000000000..a48ed31a0ba9
> > > > --- /dev/null
> > > > +++ b/drivers/lightnvm/pblk-rail.c
> > > > @@ -0,0 +1,808 @@
> > > > +/*
> > > > + * Copyright (C) 2018 Heiner Litz
> > > > + * Initial release: Heiner Litz <hlitz@ucsc.edu>
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > + * modify it under the terms of the GNU General Public License version
> > > > + * 2 as published by the Free Software Foundation.
> > > > + *
> > > > + * This program is distributed in the hope that it will be useful, but
> > > > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > > + * General Public License for more details.
> > > > + *
> > > > + * pblk-rail.c - pblk's RAIL path
> > > > + */
> > > > +
> > > > +#include "pblk.h"
> > > > +
> > > > +#define PBLK_RAIL_EMPTY ~0x0
> > > This constant is not being used.
> >
> > thanks, will remove
> >
> > > > +#define PBLK_RAIL_PARITY_WRITE 0x8000
> > > Where does this magic number come from? Please document.
> >
> > ok , will document
> >
> > >
> > > > +
> > > > +/* RAIL auxiliary functions */
> > > > +static unsigned int pblk_rail_nr_parity_luns(struct pblk *pblk)
> > > > +{
> > > > +       struct pblk_line_meta *lm = &pblk->lm;
> > > > +
> > > > +       return lm->blk_per_line / PBLK_RAIL_STRIDE_WIDTH;
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_nr_data_luns(struct pblk *pblk)
> > > > +{
> > > > +       struct pblk_line_meta *lm = &pblk->lm;
> > > > +
> > > > +       return lm->blk_per_line - pblk_rail_nr_parity_luns(pblk);
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_sec_per_stripe(struct pblk *pblk)
> > > > +{
> > > > +       struct pblk_line_meta *lm = &pblk->lm;
> > > > +
> > > > +       return lm->blk_per_line * pblk->min_write_pgs;
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_psec_per_stripe(struct pblk *pblk)
> > > > +{
> > > > +       return pblk_rail_nr_parity_luns(pblk) * pblk->min_write_pgs;
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_dsec_per_stripe(struct pblk *pblk)
> > > > +{
> > > > +       return pblk_rail_sec_per_stripe(pblk) - pblk_rail_psec_per_stripe(pblk);
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_wrap_lun(struct pblk *pblk, unsigned int lun)
> > > > +{
> > > > +       struct pblk_line_meta *lm = &pblk->lm;
> > > > +
> > > > +       return (lun & (lm->blk_per_line - 1));
> > > > +}
> > > > +
> > > > +bool pblk_rail_meta_distance(struct pblk_line *data_line)
> > > > +{
> > > > +       return (data_line->meta_distance % PBLK_RAIL_STRIDE_WIDTH) == 0;
> > > > +}
> > > > +
> > > > +/* Notify readers that LUN is serving high latency operation */
> > > > +static void pblk_rail_notify_reader_down(struct pblk *pblk, int lun)
> > > > +{
> > > > +       WARN_ON(test_and_set_bit(lun, pblk->rail.busy_bitmap));
> > > > +       /* Make sure that busy bit is seen by reader before proceeding */
> > > > +       smp_mb__after_atomic();
> > > > +}
> > > > +
> > > > +static void pblk_rail_notify_reader_up(struct pblk *pblk, int lun)
> > > > +{
> > > > +       /* Make sure that write is completed before releasing busy bit */
> > > > +       smp_mb__before_atomic();
> > > > +       WARN_ON(!test_and_clear_bit(lun, pblk->rail.busy_bitmap));
> > > > +}
> > > > +
> > > > +int pblk_rail_lun_busy(struct pblk *pblk, struct ppa_addr ppa)
> > > > +{
> > > > +       struct nvm_tgt_dev *dev = pblk->dev;
> > > > +       struct nvm_geo *geo = &dev->geo;
> > > > +       int lun_pos = pblk_ppa_to_pos(geo, ppa);
> > > > +
> > > > +       return test_bit(lun_pos, pblk->rail.busy_bitmap);
> > > > +}
> > > > +
> > > > +/* Enforces one writer per stride */
> > > > +int pblk_rail_down_stride(struct pblk *pblk, int lun_pos, int timeout)
> > > > +{
> > > > +       struct pblk_lun *rlun;
> > > > +       int strides = pblk_rail_nr_parity_luns(pblk);
> > > > +       int stride = lun_pos % strides;
> > > > +       int ret;
> > > > +
> > > > +       rlun = &pblk->luns[stride];
> > > > +       ret = down_timeout(&rlun->wr_sem, timeout);
> > > > +       pblk_rail_notify_reader_down(pblk, lun_pos);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +void pblk_rail_up_stride(struct pblk *pblk, int lun_pos)
> > > > +{
> > > > +       struct pblk_lun *rlun;
> > > > +       int strides = pblk_rail_nr_parity_luns(pblk);
> > > > +       int stride = lun_pos % strides;
> > > > +
> > > > +       pblk_rail_notify_reader_up(pblk, lun_pos);
> > > > +       rlun = &pblk->luns[stride];
> > > > +       up(&rlun->wr_sem);
> > > > +}
> > > > +
> > > > +/* Determine whether a sector holds data, meta or is bad*/
> > > > +bool pblk_rail_valid_sector(struct pblk *pblk, struct pblk_line *line, int pos)
> > > > +{
> > > > +       struct pblk_line_meta *lm = &pblk->lm;
> > > > +       struct nvm_tgt_dev *dev = pblk->dev;
> > > > +       struct nvm_geo *geo = &dev->geo;
> > > > +       struct ppa_addr ppa;
> > > > +       int lun;
> > > > +
> > > > +       if (pos >= line->smeta_ssec && pos < (line->smeta_ssec + lm->smeta_sec))
> > > > +               return false;
> > > > +
> > > > +       if (pos >= line->emeta_ssec &&
> > > > +           pos < (line->emeta_ssec + lm->emeta_sec[0]))
> > > > +               return false;
> > > > +
> > > > +       ppa = addr_to_gen_ppa(pblk, pos, line->id);
> > > > +       lun = pblk_ppa_to_pos(geo, ppa);
> > > > +
> > > > +       return !test_bit(lun, line->blk_bitmap);
> > > > +}
> > > > +
> > > > +/* Delay rb overwrite until whole stride has been written */
> > > > +int pblk_rail_rb_delay(struct pblk_rb *rb)
> > > > +{
> > > > +       struct pblk *pblk = container_of(rb, struct pblk, rwb);
> > > > +
> > > > +       return pblk_rail_sec_per_stripe(pblk);
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_sec_to_stride(struct pblk *pblk, unsigned int sec)
> > > > +{
> > > > +       unsigned int sec_in_stripe = sec % pblk_rail_sec_per_stripe(pblk);
> > > > +       int page = sec_in_stripe / pblk->min_write_pgs;
> > > > +
> > > > +       return page % pblk_rail_nr_parity_luns(pblk);
> > > > +}
> > > > +
> > > > +static unsigned int pblk_rail_sec_to_idx(struct pblk *pblk, unsigned int sec)
> > > > +{
> > > > +       unsigned int sec_in_stripe = sec % pblk_rail_sec_per_stripe(pblk);
> > > > +
> > > > +       return sec_in_stripe / pblk_rail_psec_per_stripe(pblk);
> > > > +}
> > > > +
> > > > +static void pblk_rail_data_parity(void *dest, void *src)
> > > > +{
> > > > +       unsigned int i;
> > > > +
> > > > +       for (i = 0; i < PBLK_EXPOSED_PAGE_SIZE / sizeof(unsigned long); i++)
> > > > +               ((unsigned long *)dest)[i] ^= ((unsigned long *)src)[i];
> > > > +}
> > > > +
> > > > +static void pblk_rail_lba_parity(u64 *dest, u64 *src)
> > > > +{
> > > > +       *dest ^= *src;
> > > > +}
> > > > +
> > > > +/* Tracks where a sector is located in the rwb */
> > > > +void pblk_rail_track_sec(struct pblk *pblk, struct pblk_line *line, int cur_sec,
> > > > +                        int sentry, int nr_valid)
> > > > +{
> > > > +       int stride, idx, pos;
> > > > +
> > > > +       stride = pblk_rail_sec_to_stride(pblk, cur_sec);
> > > > +       idx = pblk_rail_sec_to_idx(pblk, cur_sec);
> > > > +       pos = pblk_rb_wrap_pos(&pblk->rwb, sentry);
> > > > +       pblk->rail.p2b[stride][idx].pos = pos;
> > > > +       pblk->rail.p2b[stride][idx].nr_valid = nr_valid;
> > > > +}
> > > > +
> > > > +/* RAIL's sector mapping function */
> > > > +static void pblk_rail_map_sec(struct pblk *pblk, struct pblk_line *line,
> > > > +                             int sentry, struct pblk_sec_meta *meta_list,
> > > > +                             __le64 *lba_list, struct ppa_addr ppa)
> > > > +{
> > > > +       struct pblk_w_ctx *w_ctx;
> > > > +       __le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
> > > > +
> > > > +       kref_get(&line->ref);
> > > > +
> > > > +       if (sentry & PBLK_RAIL_PARITY_WRITE) {
> > > > +               u64 *lba;
> > > > +
> > > > +               sentry &= ~PBLK_RAIL_PARITY_WRITE;
> > > > +               lba = &pblk->rail.lba[sentry];
> > > > +               meta_list->lba = cpu_to_le64(*lba);
> > > > +               *lba_list = cpu_to_le64(*lba);
> > > > +               line->nr_valid_lbas++;
> > > > +       } else {
> > > > +               w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry);
> > > > +               w_ctx->ppa = ppa;
> > > > +               meta_list->lba = cpu_to_le64(w_ctx->lba);
> > > > +               *lba_list = cpu_to_le64(w_ctx->lba);
> > > > +
> > > > +               if (*lba_list != addr_empty)
> > > > +                       line->nr_valid_lbas++;
> > > > +               else
> > > > +                       atomic64_inc(&pblk->pad_wa);
> > > > +       }
> > > > +}
> > > > +
> > > > +int pblk_rail_map_page_data(struct pblk *pblk, unsigned int sentry,
> > > > +                           struct ppa_addr *ppa_list,
> > > > +                           unsigned long *lun_bitmap,
> > > > +                           struct pblk_sec_meta *meta_list,
> > > > +                           unsigned int valid_secs)
> > > > +{
> > > > +       struct pblk_line *line = pblk_line_get_data(pblk);
> > > > +       struct pblk_emeta *emeta;
> > > > +       __le64 *lba_list;
> > > > +       u64 paddr;
> > > > +       int nr_secs = pblk->min_write_pgs;
> > > > +       int i;
> > > > +
> > > > +       if (pblk_line_is_full(line)) {
> > > > +               struct pblk_line *prev_line = line;
> > > > +
> > > > +               /* If we cannot allocate a new line, make sure to store metadata
> > > > +                * on current line and then fail
> > > > +                */
> > > > +               line = pblk_line_replace_data(pblk);
> > > > +               pblk_line_close_meta(pblk, prev_line);
> > > > +
> > > > +               if (!line)
> > > > +                       return -EINTR;
> > > > +       }
> > > > +
> > > > +       emeta = line->emeta;
> > > > +       lba_list = emeta_to_lbas(pblk, emeta->buf);
> > > > +
> > > > +       paddr = pblk_alloc_page(pblk, line, nr_secs);
> > > > +
> > > > +       pblk_rail_track_sec(pblk, line, paddr, sentry, valid_secs);
> > > > +
> > > > +       for (i = 0; i < nr_secs; i++, paddr++) {
> > > > +               __le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
> > > > +
> > > > +               /* ppa to be sent to the device */
> > > > +               ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
> > > > +
> > > > +               /* Write context for target bio completion on write buffer. Note
> > > > +                * that the write buffer is protected by the sync backpointer,
> > > > +                * and a single writer thread have access to each specific entry
> > > > +                * at a time. Thus, it is safe to modify the context for the
> > > > +                * entry we are setting up for submission without taking any
> > > > +                * lock or memory barrier.
> > > > +                */
> > > > +               if (i < valid_secs) {
> > > > +                       pblk_rail_map_sec(pblk, line, sentry + i, &meta_list[i],
> > > > +                                         &lba_list[paddr], ppa_list[i]);
> > > > +               } else {
> > > > +                       lba_list[paddr] = meta_list[i].lba = addr_empty;
> > > > +                       __pblk_map_invalidate(pblk, line, paddr);
> > > > +               }
> > > > +       }
> > > > +
> > > > +       pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
> > > > +       return 0;
> > > > +}
> > >
> > > This is a lot of duplication of code from the "normal" pblk map
> > > function -  could you refactor to avoid this?
> >
> > I wanted to keep the mapping function as general as possible in case
> > we want to support other mapping functions at some point. If you think
> > this is not needed I can reduce the mapping func to only code that
> > differs between the mapping function. E.g. we could turn
> > pblk_map_page_data into a pblk_map_sec_data
>
> I think it would be better to try to keep common code as far as we
> can, and if we would introduce other mapping functions in the future
> we'll rework the common denominator.
>
> >
> > >
> > > > +
> > > > +/* RAIL Initialization and tear down */
> > > > +int pblk_rail_init(struct pblk *pblk)
> > > > +{
> > > > +       struct pblk_line_meta *lm = &pblk->lm;
> > > > +       int i, p2be;
> > > > +       unsigned int nr_strides;
> > > > +       unsigned int psecs;
> > > > +       void *kaddr;
> > > > +
> > > > +       if (!PBLK_RAIL_STRIDE_WIDTH)
> > > > +               return 0;
> > > > +
> > > > +       if (((lm->blk_per_line % PBLK_RAIL_STRIDE_WIDTH) != 0) ||
> > > > +           (lm->blk_per_line < PBLK_RAIL_STRIDE_WIDTH)) {
> > > > +               pr_err("pblk: unsupported RAIL stride %i\n", lm->blk_per_line);
> > > > +               return -EINVAL;
> > > > +       }
> > >
> > > This is just a check of the maximum blocks per line - bad blocks will
> > > reduce the number of writable blocks. What happens when a line goes
> > > below PBLK_RAIL_STRIDE_WIDTH writable blocks?
> >
> > This check just guarantees that lm->blk_per_line is a multiple of
> > PBLK_RAIL_STRIDE_WIDTH. Bad blocks are handled dynamically at runtime
> > via pblk_rail_valid_sector(pblk, line, cur) which skips parity
> > computation if the parity block is bad. In theory a line can have
> > fewer writable blocks than PBLK_RAIL_STRIDE_WIDTH, in this case parity
> > is computed based on fewer number of blocks.
>
> Yes, I see now, it should work.
>
> The only case i see that is problematic is if only the parity block(s)
> are non-bad in a line, resulting in no data being written, just parity
> (adding a huge write latency penalty) - we could either disable RAIL
> for that class of lines or mark them as bad.
>
> >
> > >
> > > > +
> > > > +       psecs = pblk_rail_psec_per_stripe(pblk);
> > > > +       nr_strides = pblk_rail_sec_per_stripe(pblk) / PBLK_RAIL_STRIDE_WIDTH;
> > > > +
> > > > +       pblk->rail.p2b = kmalloc_array(nr_strides, sizeof(struct p2b_entry *),
> > > > +                                      GFP_KERNEL);
> > > > +       if (!pblk->rail.p2b)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       for (p2be = 0; p2be < nr_strides; p2be++) {
> > > > +               pblk->rail.p2b[p2be] = kmalloc_array(PBLK_RAIL_STRIDE_WIDTH - 1,
> > > > +                                              sizeof(struct p2b_entry),
> > > > +                                              GFP_KERNEL);
> > > > +               if (!pblk->rail.p2b[p2be])
> > > > +                       goto free_p2b_entries;
> > > > +       }
> > > > +
> > > > +       pblk->rail.data = kmalloc(psecs * sizeof(void *), GFP_KERNEL);
> > > > +       if (!pblk->rail.data)
> > > > +               goto free_p2b_entries;
> > > > +
> > > > +       pblk->rail.pages = alloc_pages(GFP_KERNEL, get_count_order(psecs));
> > > > +       if (!pblk->rail.pages)
> > > > +               goto free_data;
> > > > +
> > > > +       kaddr = page_address(pblk->rail.pages);
> > > > +       for (i = 0; i < psecs; i++)
> > > > +               pblk->rail.data[i] = kaddr + i * PBLK_EXPOSED_PAGE_SIZE;
> > > > +
> > > > +       pblk->rail.lba = kmalloc_array(psecs, sizeof(u64 *), GFP_KERNEL);
> > > > +       if (!pblk->rail.lba)
> > > > +               goto free_pages;
> > > > +
> > > > +       /* Subtract parity bits from device capacity */
> > > > +       pblk->capacity = pblk->capacity * (PBLK_RAIL_STRIDE_WIDTH - 1) /
> > > > +               PBLK_RAIL_STRIDE_WIDTH;
> > > > +
> > > > +       pblk->map_page = pblk_rail_map_page_data;
> > > > +
> > > > +       return 0;
> > > > +
> > > > +free_pages:
> > > > +       free_pages((unsigned long)page_address(pblk->rail.pages),
> > > > +                  get_count_order(psecs));
> > > > +free_data:
> > > > +       kfree(pblk->rail.data);
> > > > +free_p2b_entries:
> > > > +       for (p2be = p2be - 1; p2be >= 0; p2be--)
> > > > +               kfree(pblk->rail.p2b[p2be]);
> > > > +       kfree(pblk->rail.p2b);
> > > > +
> > > > +       return -ENOMEM;
> > > > +}
> > > > +
> > > > +void pblk_rail_free(struct pblk *pblk)
> > > > +{
> > > > +       unsigned int i;
> > > > +       unsigned int nr_strides;
> > > > +       unsigned int psecs;
> > > > +
> > > > +       psecs = pblk_rail_psec_per_stripe(pblk);
> > > > +       nr_strides = pblk_rail_sec_per_stripe(pblk) / PBLK_RAIL_STRIDE_WIDTH;
> > > > +
> > > > +       kfree(pblk->rail.lba);
> > > > +       free_pages((unsigned long)page_address(pblk->rail.pages),
> > > > +                  get_count_order(psecs));
> > > > +       kfree(pblk->rail.data);
> > > > +       for (i = 0; i < nr_strides; i++)
> > > > +               kfree(pblk->rail.p2b[i]);
> > > > +       kfree(pblk->rail.p2b);
> > > > +}
> > > > +
> > > > +/* PBLK supports 64 ppas max. By performing RAIL reads, a sector is read using
> > > > + * multiple ppas which can lead to violation of the 64 ppa limit. In this case,
> > > > + * split the bio
> > > > + */
> > > > +static void pblk_rail_bio_split(struct pblk *pblk, struct bio **bio, int sec)
> > > > +{
> > > > +       struct nvm_tgt_dev *dev = pblk->dev;
> > > > +       struct bio *split;
> > > > +
> > > > +       sec *= (dev->geo.csecs >> 9);
> > > > +
> > > > +       split = bio_split(*bio, sec, GFP_KERNEL, &pblk_bio_set);
> > > > +       /* there isn't chance to merge the split bio */
> > > > +       split->bi_opf |= REQ_NOMERGE;
> > > > +       bio_set_flag(*bio, BIO_QUEUE_ENTERED);
> > > > +       bio_chain(split, *bio);
> > > > +       generic_make_request(*bio);
> > > > +       *bio = split;
> > > > +}
> > > > +
> > > > +/* RAIL's Write Path */
> > > > +static int pblk_rail_sched_parity(struct pblk *pblk)
> > > > +{
> > > > +       struct pblk_line *line = pblk_line_get_data(pblk);
> > > > +       unsigned int sec_in_stripe;
> > > > +
> > > > +       while (1) {
> > > > +               sec_in_stripe = line->cur_sec % pblk_rail_sec_per_stripe(pblk);
> > > > +
> > > > +               /* Schedule parity write at end of data section */
> > > > +               if (sec_in_stripe >= pblk_rail_dsec_per_stripe(pblk))
> > > > +                       return 1;
> > > > +
> > > > +               /* Skip bad blocks and meta sectors until we find a valid sec */
> > > > +               if (test_bit(line->cur_sec, line->map_bitmap))
> > > > +                       line->cur_sec += pblk->min_write_pgs;
> > > > +               else
> > > > +                       break;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/* Mark RAIL parity sectors as invalid sectors so they will be gc'ed */
> > > > +void pblk_rail_line_close(struct pblk *pblk, struct pblk_line *line)
> > > > +{
> > > > +       int off, bit;
> > > > +
> > > > +       for (off = pblk_rail_dsec_per_stripe(pblk);
> > > > +            off < pblk->lm.sec_per_line;
> > > > +            off += pblk_rail_sec_per_stripe(pblk)) {
> > > > +               for (bit = 0; bit < pblk_rail_psec_per_stripe(pblk); bit++)
> > > > +                       set_bit(off + bit, line->invalid_bitmap);
> > > > +       }
> > > > +}
> > > > +
> > > > +void pblk_rail_end_io_write(struct nvm_rq *rqd)
> > > > +{
> > > > +       struct pblk *pblk = rqd->private;
> > > > +       struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
> > > > +
> > > > +       if (rqd->error) {
> > > > +               pblk_log_write_err(pblk, rqd);
> > > > +               return pblk_end_w_fail(pblk, rqd);
> > >
> > > The write error recovery path relies on that that sentry in c_ctx is
> > > an index in the write buffer, so this won't work.
> >
> > You mean a RAIL parity write? Yes, good catch.
> >
>
> It does not make sense to re-issue failing parity writes anyway, right?

Yes this is correct. I think I can just take out end_w_fail, but we
need to let readers know that the page is bad (see below).

>
> > >
> > > Additionally, If a write(data or parity) fails, the whole stride would
> > > be broken and need to fall back on "normal" reads, right?
> > > One solution could be to check line->w_err_gc->has_write_err on the read path.
> >
> > when a data write fails it is remapped and the rail mapping function
> > tracks that new location in the r2b. The page will be marked bad and
> > hence taken into account when computing parity in the case of parity
> > writes and RAIL reads, so the line should still be intact. This might
> > be insufficiently tested but in theory it should work.
>
> As far as I can tell from the code, pblk_rail_valid_sector only checks
> if the sector is occupied by metadata or if the whole block is bad.
> In the case of a write failure, the block will not be marked bad. What
> we could do is to keep track of the write pointer internally to check
> if the sector had been successfully written.
>
> I can create a patch for keeping track of the write pointer for each
> block - this would be useful for debugging purposes in any case. Once
> this is in place it would be easy to add a check in
> pblk_rail_valid_sector ensuring that the sector has actually been
> written successfully.

Hmm, I don't think keeping track of the write pointer is sufficient. Readers
need to be able to determine whether a page is bad at any time. So I
believe we need a per-line bitmap telling us which stripes (horizontal pages)
are bad, or am I missing something?

>
> >
> > >
> > > > +       }
> > > > +#ifdef CONFIG_NVM_DEBUG
> > > > +       else
> > > > +               WARN_ONCE(rqd->bio->bi_status, "pblk: corrupted write error\n");
> > > > +#endif
> > > > +
> > > > +       pblk_up_rq(pblk, c_ctx->lun_bitmap);
> > > > +
> > > > +       pblk_rq_to_line_put(pblk, rqd);
> > > > +       bio_put(rqd->bio);
> > > > +       pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> > > > +
> > > > +       atomic_dec(&pblk->inflight_io);
> > > > +}
> > > > +
> > > > +static int pblk_rail_read_to_bio(struct pblk *pblk, struct nvm_rq *rqd,
> > > > +                         struct bio *bio, unsigned int stride,
> > > > +                         unsigned int nr_secs, unsigned int paddr)
> > > > +{
> > > > +       struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
> > > > +       int sec, i;
> > > > +       int nr_data = PBLK_RAIL_STRIDE_WIDTH - 1;
> > > > +       struct pblk_line *line = pblk_line_get_data(pblk);
> > > > +
> > > > +       c_ctx->nr_valid = nr_secs;
> > > > +       /* sentry indexes rail page buffer, instead of rwb */
> > > > +       c_ctx->sentry = stride * pblk->min_write_pgs;
> > > > +       c_ctx->sentry |= PBLK_RAIL_PARITY_WRITE;
> > > > +
> > > > +       for (sec = 0; sec < pblk->min_write_pgs; sec++) {
> > > > +               void *pg_addr;
> > > > +               struct page *page;
> > > > +               u64 *lba;
> > > > +
> > > > +               lba = &pblk->rail.lba[stride * pblk->min_write_pgs + sec];
> > > > +               pg_addr = pblk->rail.data[stride * pblk->min_write_pgs + sec];
> > > > +               page = virt_to_page(pg_addr);
> > > > +
> > > > +               if (!page) {
> > > > +                       pr_err("pblk: could not allocate RAIL bio page %p\n",
> > > > +                              pg_addr);
> > > > +                       return -NVM_IO_ERR;
> > > > +               }
> > > > +
> > > > +               if (bio_add_page(bio, page, pblk->rwb.seg_size, 0) !=
> > > > +                   pblk->rwb.seg_size) {
> > > > +                       pr_err("pblk: could not add page to RAIL bio\n");
> > > > +                       return -NVM_IO_ERR;
> > > > +               }
> > > > +
> > > > +               *lba = 0;
> > > > +               memset(pg_addr, 0, PBLK_EXPOSED_PAGE_SIZE);
> > > > +
> > > > +               for (i = 0; i < nr_data; i++) {
> > > > +                       struct pblk_rb_entry *entry;
> > > > +                       struct pblk_w_ctx *w_ctx;
> > > > +                       u64 lba_src;
> > > > +                       unsigned int pos;
> > > > +                       unsigned int cur;
> > > > +                       int distance = pblk_rail_psec_per_stripe(pblk);
> > > > +
> > > > +                       cur = paddr - distance * (nr_data - i) + sec;
> > > > +
> > > > +                       if (!pblk_rail_valid_sector(pblk, line, cur))
> > > > +                               continue;
> > > > +
> > > > +                       pos = pblk->rail.p2b[stride][i].pos;
> > > > +                       pos = pblk_rb_wrap_pos(&pblk->rwb, pos + sec);
> > > > +                       entry = &pblk->rwb.entries[pos];
> > > > +                       w_ctx = &entry->w_ctx;
> > > > +                       lba_src = w_ctx->lba;
> > > > +
> > > > +                       if (sec < pblk->rail.p2b[stride][i].nr_valid &&
> > > > +                           lba_src != ADDR_EMPTY) {
> > > > +                               pblk_rail_data_parity(pg_addr, entry->data);
> > > > +                               pblk_rail_lba_parity(lba, &lba_src);
> > >
> > > What keeps the parity lba values from invalidating "real" data lbas
> > > during recovery?
> >
> > The RAIL geometry is known during recovery so the parity LBAs can be
> > ignored, not implemented yet.
>
> Ah, it's not in place yet, then it makes sense.
> It would be straight forward to implement, using something like
> sector_is_parity(line, paddr) to avoid mapping parity sectors during
> recovery.
>
> >
> > >
> > > > +                       }
> > > > +               }
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +int pblk_rail_submit_write(struct pblk *pblk)
> > > > +{
> > > > +       int i;
> > > > +       struct nvm_rq *rqd;
> > > > +       struct bio *bio;
> > > > +       struct pblk_line *line = pblk_line_get_data(pblk);
> > > > +       int start, end, bb_offset;
> > > > +       unsigned int stride = 0;
> > > > +
> > > > +       if (!pblk_rail_sched_parity(pblk))
> > > > +               return 0;
> > > > +
> > > > +       start = line->cur_sec;
> > > > +       bb_offset = start % pblk_rail_sec_per_stripe(pblk);
> > > > +       end = start + pblk_rail_sec_per_stripe(pblk) - bb_offset;
> > > > +
> > > > +       for (i = start; i < end; i += pblk->min_write_pgs, stride++) {
> > > > +               /* Do not generate parity in this slot if the sec is bad
> > > > +                * or reserved for meta.
> > > > +                * We check on the read path and perform a conventional
> > > > +                * read, to avoid reading parity from the bad block
> > > > +                */
> > > > +               if (!pblk_rail_valid_sector(pblk, line, i))
> > > > +                       continue;
> > > > +
> > > > +               rqd = pblk_alloc_rqd(pblk, PBLK_WRITE);
> > > > +               if (IS_ERR(rqd)) {
> > > > +                       pr_err("pblk: cannot allocate parity write req.\n");
> > > > +                       return -ENOMEM;
> > > > +               }
> > > > +
> > > > +               bio = bio_alloc(GFP_KERNEL, pblk->min_write_pgs);
> > > > +               if (!bio) {
> > > > +                       pr_err("pblk: cannot allocate parity write bio\n");
> > > > +                       pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> > > > +                       return -ENOMEM;
> > > > +               }
> > > > +
> > > > +               bio->bi_iter.bi_sector = 0; /* internal bio */
> > > > +               bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> > > > +               rqd->bio = bio;
> > > > +
> > > > +               pblk_rail_read_to_bio(pblk, rqd, bio, stride,
> > > > +                                     pblk->min_write_pgs, i);
> > > > +
> > > > +               if (pblk_submit_io_set(pblk, rqd, pblk_rail_end_io_write)) {
> > > > +                       bio_put(rqd->bio);
> > > > +                       pblk_free_rqd(pblk, rqd, PBLK_WRITE);
> > > > +
> > > > +                       return -NVM_IO_ERR;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/* RAIL's Read Path */
> > > > +static void pblk_rail_end_io_read(struct nvm_rq *rqd)
> > > > +{
> > > > +       struct pblk *pblk = rqd->private;
> > > > +       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
> > > > +       struct pblk_pr_ctx *pr_ctx = r_ctx->private;
> > > > +       struct bio *new_bio = rqd->bio;
> > > > +       struct bio *bio = pr_ctx->orig_bio;
> > > > +       struct bio_vec src_bv, dst_bv;
> > > > +       struct pblk_sec_meta *meta_list = rqd->meta_list;
> > > > +       int bio_init_idx = pr_ctx->bio_init_idx;
> > > > +       int nr_secs = pr_ctx->orig_nr_secs;
> > > > +       __le64 *lba_list_mem, *lba_list_media;
> > > > +       __le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
> > > > +       void *src_p, *dst_p;
> > > > +       int i, r, rail_ppa = 0;
> > > > +       unsigned char valid;
> > > > +
> > > > +       if (unlikely(rqd->nr_ppas == 1)) {
> > > > +               struct ppa_addr ppa;
> > > > +
> > > > +               ppa = rqd->ppa_addr;
> > > > +               rqd->ppa_list = pr_ctx->ppa_ptr;
> > > > +               rqd->dma_ppa_list = pr_ctx->dma_ppa_list;
> > > > +               rqd->ppa_list[0] = ppa;
> > > > +       }
> > > > +
> > > > +       /* Re-use allocated memory for intermediate lbas */
> > > > +       lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
> > > > +       lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
> > > > +
> > > > +       for (i = 0; i < rqd->nr_ppas; i++)
> > > > +               lba_list_media[i] = meta_list[i].lba;
> > > > +       for (i = 0; i < nr_secs; i++)
> > > > +               meta_list[i].lba = lba_list_mem[i];
> > > > +
> > > > +       for (i = 0; i < nr_secs; i++) {
> > > > +               struct pblk_line *line;
> > > > +               u64 meta_lba = 0x0UL, mlba;
> > > > +
> > > > +               line = pblk_ppa_to_line(pblk, rqd->ppa_list[rail_ppa]);
> > > > +
> > > > +               valid = bitmap_weight(pr_ctx->bitmap, PBLK_RAIL_STRIDE_WIDTH);
> > > > +               bitmap_shift_right(pr_ctx->bitmap, pr_ctx->bitmap,
> > > > +                                  PBLK_RAIL_STRIDE_WIDTH, PR_BITMAP_SIZE);
> > > > +
> > > > +               if (valid == 0) /* Skip cached reads */
> > > > +                       continue;
> > > > +
> > > > +               kref_put(&line->ref, pblk_line_put);
> > > > +
> > > > +               dst_bv = bio->bi_io_vec[bio_init_idx + i];
> > > > +               dst_p = kmap_atomic(dst_bv.bv_page);
> > > > +
> > > > +               memset(dst_p + dst_bv.bv_offset, 0, PBLK_EXPOSED_PAGE_SIZE);
> > > > +               meta_list[i].lba = cpu_to_le64(0x0UL);
> > > > +
> > > > +               for (r = 0; r < valid; r++, rail_ppa++) {
> > > > +                       src_bv = new_bio->bi_io_vec[rail_ppa];
> > > > +
> > > > +                       if (lba_list_media[rail_ppa] != addr_empty) {
> > > > +                               src_p = kmap_atomic(src_bv.bv_page);
> > > > +                               pblk_rail_data_parity(dst_p + dst_bv.bv_offset,
> > > > +                                                     src_p + src_bv.bv_offset);
> > > > +                               mlba = le64_to_cpu(lba_list_media[rail_ppa]);
> > > > +                               pblk_rail_lba_parity(&meta_lba, &mlba);
> > > > +                               kunmap_atomic(src_p);
> > > > +                       }
> > > > +
> > > > +                       mempool_free(src_bv.bv_page, &pblk->page_bio_pool);
> > > > +               }
> > > > +               meta_list[i].lba = cpu_to_le64(meta_lba);
> > > > +               kunmap_atomic(dst_p);
> > > > +       }
> > > > +
> > > > +       bio_put(new_bio);
> > > > +       rqd->nr_ppas = pr_ctx->orig_nr_secs;
> > > > +       kfree(pr_ctx);
> > > > +       rqd->bio = NULL;
> > > > +
> > > > +       bio_endio(bio);
> > > > +       __pblk_end_io_read(pblk, rqd, false);
> > > > +}
> > > > +
> > > > +/* Converts original ppa into ppa list of RAIL reads */
> > > > +static int pblk_rail_setup_ppas(struct pblk *pblk, struct ppa_addr ppa,
> > > > +                               struct ppa_addr *rail_ppas,
> > > > +                               unsigned char *pvalid, int *nr_rail_ppas,
> > > > +                               int *rail_reads)
> > > > +{
> > > > +       struct nvm_tgt_dev *dev = pblk->dev;
> > > > +       struct nvm_geo *geo = &dev->geo;
> > > > +       struct ppa_addr rail_ppa = ppa;
> > > > +       unsigned int lun_pos = pblk_ppa_to_pos(geo, ppa);
> > > > +       unsigned int strides = pblk_rail_nr_parity_luns(pblk);
> > > > +       struct pblk_line *line;
> > > > +       unsigned int i;
> > > > +       int ppas = *nr_rail_ppas;
> > > > +       int valid = 0;
> > > > +
> > > > +       for (i = 1; i < PBLK_RAIL_STRIDE_WIDTH; i++) {
> > > > +               unsigned int neighbor, lun, chnl;
> > > > +               int laddr;
> > > > +
> > > > +               neighbor = pblk_rail_wrap_lun(pblk, lun_pos + i * strides);
> > > > +
> > > > +               lun = pblk_pos_to_lun(geo, neighbor);
> > > > +               chnl = pblk_pos_to_chnl(geo, neighbor);
> > > > +               pblk_dev_ppa_set_lun(&rail_ppa, lun);
> > > > +               pblk_dev_ppa_set_chnl(&rail_ppa, chnl);
> > > > +
> > > > +               line = pblk_ppa_to_line(pblk, rail_ppa);
> > > > +               laddr = pblk_dev_ppa_to_line_addr(pblk, rail_ppa);
> > > > +
> > > > +               /* Do not read from bad blocks */
> > > > +               if (!pblk_rail_valid_sector(pblk, line, laddr)) {
> > > > +                       /* Perform regular read if parity sector is bad */
> > > > +                       if (neighbor >= pblk_rail_nr_data_luns(pblk))
> > > > +                               return 0;
> > > > +
> > > > +                       /* If any other neighbor is bad we can just skip it */
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               rail_ppas[ppas++] = rail_ppa;
> > > > +               valid++;
> > > > +       }
> > > > +
> > > > +       if (valid == 1)
> > > > +               return 0;
> > > > +
> > > > +       *pvalid = valid;
> > > > +       *nr_rail_ppas = ppas;
> > > > +       (*rail_reads)++;
> > > > +       return 1;
> > > > +}
> > > > +
> > > > +static void pblk_rail_set_bitmap(struct pblk *pblk, struct ppa_addr *ppa_list,
> > > > +                                int ppa, struct ppa_addr *rail_ppa_list,
> > > > +                                int *nr_rail_ppas, unsigned long *read_bitmap,
> > > > +                                unsigned long *pvalid, int *rail_reads)
> > > > +{
> > > > +       unsigned char valid;
> > > > +
> > > > +       if (test_bit(ppa, read_bitmap))
> > > > +               return;
> > > > +
> > > > +       if (pblk_rail_lun_busy(pblk, ppa_list[ppa]) &&
> > > > +           pblk_rail_setup_ppas(pblk, ppa_list[ppa],
> > > > +                                rail_ppa_list, &valid,
> > > > +                                nr_rail_ppas, rail_reads)) {
> > > > +               WARN_ON(test_and_set_bit(ppa, read_bitmap));
> > > > +               bitmap_set(pvalid, ppa * PBLK_RAIL_STRIDE_WIDTH, valid);
> > > > +       } else {
> > > > +               rail_ppa_list[(*nr_rail_ppas)++] = ppa_list[ppa];
> > > > +               bitmap_set(pvalid, ppa * PBLK_RAIL_STRIDE_WIDTH, 1);
> > > > +       }
> > > > +}
> > > > +
> > > > +int pblk_rail_read_bio(struct pblk *pblk, struct nvm_rq *rqd, int blba,
> > > > +                      unsigned long *read_bitmap, int bio_init_idx,
> > > > +                      struct bio **bio)
> > > > +{
> > > > +       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
> > > > +       struct pblk_pr_ctx *pr_ctx;
> > > > +       struct ppa_addr rail_ppa_list[NVM_MAX_VLBA];
> > > > +       DECLARE_BITMAP(pvalid, PR_BITMAP_SIZE);
> > > > +       int nr_secs = rqd->nr_ppas;
> > > > +       bool read_empty = bitmap_empty(read_bitmap, nr_secs);
> > > > +       int nr_rail_ppas = 0, rail_reads = 0;
> > > > +       int i;
> > > > +       int ret;
> > > > +
> > > > +       /* Fully cached reads should not enter this path */
> > > > +       WARN_ON(bitmap_full(read_bitmap, nr_secs));
> > > > +
> > > > +       bitmap_zero(pvalid, PR_BITMAP_SIZE);
> > > > +       if (rqd->nr_ppas == 1) {
> > > > +               pblk_rail_set_bitmap(pblk, &rqd->ppa_addr, 0, rail_ppa_list,
> > > > +                                    &nr_rail_ppas, read_bitmap, pvalid,
> > > > +                                    &rail_reads);
> > > > +
> > > > +               if (nr_rail_ppas == 1) {
> > > > +                       memcpy(&rqd->ppa_addr, rail_ppa_list,
> > > > +                              nr_rail_ppas * sizeof(struct ppa_addr));
> > > > +               } else {
> > > > +                       rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> > > > +                       rqd->dma_ppa_list = rqd->dma_meta_list +
> > > > +                         pblk_dma_meta_size;
> > > > +                       memcpy(rqd->ppa_list, rail_ppa_list,
> > > > +                              nr_rail_ppas * sizeof(struct ppa_addr));
> > > > +               }
> > > > +       } else {
> > > > +               for (i = 0; i < rqd->nr_ppas; i++) {
> > > > +                       pblk_rail_set_bitmap(pblk, rqd->ppa_list, i,
> > > > +                                            rail_ppa_list, &nr_rail_ppas,
> > > > +                                            read_bitmap, pvalid, &rail_reads);
> > > > +
> > > > +                       /* Don't split if this it the last ppa of the rqd */
> > > > +                       if (((nr_rail_ppas + PBLK_RAIL_STRIDE_WIDTH) >=
> > > > +                            NVM_MAX_VLBA) && (i + 1 < rqd->nr_ppas)) {
> > > > +                               struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
> > > > +
> > > > +                               pblk_rail_bio_split(pblk, bio, i + 1);
> > > > +                               rqd->nr_ppas = pblk_get_secs(*bio);
> > > > +                               r_ctx->private = *bio;
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +               memcpy(rqd->ppa_list, rail_ppa_list,
> > > > +                      nr_rail_ppas * sizeof(struct ppa_addr));
> > > > +       }
> > > > +
> > > > +       if (bitmap_empty(read_bitmap, rqd->nr_ppas))
> > > > +               return NVM_IO_REQUEUE;
> > > > +
> > > > +       if (read_empty && !bitmap_empty(read_bitmap, rqd->nr_ppas))
> > > > +               bio_advance(*bio, (rqd->nr_ppas) * PBLK_EXPOSED_PAGE_SIZE);
> > > > +
> > > > +       if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap,
> > > > +                                   nr_rail_ppas))
> > > > +               return NVM_IO_ERR;
> > > > +
> > > > +       rqd->end_io = pblk_rail_end_io_read;
> > > > +       pr_ctx = r_ctx->private;
> > > > +       bitmap_copy(pr_ctx->bitmap, pvalid, PR_BITMAP_SIZE);
> > > > +
> > > > +       ret = pblk_submit_io(pblk, rqd);
> > > > +       if (ret) {
> > > > +               bio_put(rqd->bio);
> > > > +               pr_err("pblk: partial RAIL read IO submission failed\n");
> > > > +               /* Free allocated pages in new bio */
> > > > +               pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
> > > > +               kfree(pr_ctx);
> > > > +               __pblk_end_io_read(pblk, rqd, false);
> > > > +               return NVM_IO_ERR;
> > > > +       }
> > > > +
> > > > +       return NVM_IO_OK;
> > > > +}
> > > > diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> > > > index bd88784e51d9..01fe4362b27e 100644
> > > > --- a/drivers/lightnvm/pblk.h
> > > > +++ b/drivers/lightnvm/pblk.h
> > > > @@ -28,6 +28,7 @@
> > > >  #include <linux/vmalloc.h>
> > > >  #include <linux/crc32.h>
> > > >  #include <linux/uuid.h>
> > > > +#include <linux/log2.h>
> > > >
> > > >  #include <linux/lightnvm.h>
> > > >
> > > > @@ -45,7 +46,7 @@
> > > >  #define PBLK_COMMAND_TIMEOUT_MS 30000
> > > >
> > > >  /* Max 512 LUNs per device */
> > > > -#define PBLK_MAX_LUNS_BITMAP (4)
> > > > +#define PBLK_MAX_LUNS_BITMAP (512)
> > >
> > > 512 is probably enough for everyone for now, but why not make this dynamic?
> > > Better not waste memory and introduce an artificial limit on number of luns.
> >
> > I can make it dynamic. It just makes the init path more messy as
> > meta_init takes the write semaphore (and hence busy bitmap) so I have
> > to init RAIL in the middle of everything else.
> >
> > >
> > > >
> > > >  #define NR_PHY_IN_LOG (PBLK_EXPOSED_PAGE_SIZE / PBLK_SECTOR)
> > > >
> > > > @@ -123,6 +124,13 @@ struct pblk_g_ctx {
> > > >         u64 lba;
> > > >  };
> > > >
> > > > +#ifdef CONFIG_NVM_PBLK_RAIL
> > > > +#define PBLK_RAIL_STRIDE_WIDTH 4
> > > > +#define PR_BITMAP_SIZE (NVM_MAX_VLBA * PBLK_RAIL_STRIDE_WIDTH)
> > > > +#else
> > > > +#define PR_BITMAP_SIZE NVM_MAX_VLBA
> > > > +#endif
> > > > +
> > > >  /* partial read context */
> > > >  struct pblk_pr_ctx {
> > > >         struct bio *orig_bio;
> > > > @@ -604,6 +612,39 @@ struct pblk_addrf {
> > > >         int sec_ws_stripe;
> > > >  };
> > > >
> > > > +#ifdef CONFIG_NVM_PBLK_RAIL
> > > > +
> > > > +struct p2b_entry {
> > > > +       int pos;
> > > > +       int nr_valid;
> > > > +};
> > > > +
> > > > +struct pblk_rail {
> > > > +       struct p2b_entry **p2b;         /* Maps RAIL sectors to rb pos */
> > > > +       struct page *pages;             /* Pages to hold parity writes */
> > > > +       void **data;                    /* Buffer that holds parity pages */
> > > > +       DECLARE_BITMAP(busy_bitmap, PBLK_MAX_LUNS_BITMAP);
> > > > +       u64 *lba;                       /* Buffer to compute LBA parity */
> > > > +};
> > > > +
> > > > +/* Initialize and tear down RAIL */
> > > > +int pblk_rail_init(struct pblk *pblk);
> > > > +void pblk_rail_free(struct pblk *pblk);
> > > > +/* Adjust some system parameters */
> > > > +bool pblk_rail_meta_distance(struct pblk_line *data_line);
> > > > +int pblk_rail_rb_delay(struct pblk_rb *rb);
> > > > +/* Core */
> > > > +void pblk_rail_line_close(struct pblk *pblk, struct pblk_line *line);
> > > > +int pblk_rail_down_stride(struct pblk *pblk, int lun, int timeout);
> > > > +void pblk_rail_up_stride(struct pblk *pblk, int lun);
> > > > +/* Write path */
> > > > +int pblk_rail_submit_write(struct pblk *pblk);
> > > > +/* Read Path */
> > > > +int pblk_rail_read_bio(struct pblk *pblk, struct nvm_rq *rqd, int blba,
> > > > +                      unsigned long *read_bitmap, int bio_init_idx,
> > > > +                      struct bio **bio);
> > > > +#endif /* CONFIG_NVM_PBLK_RAIL */
> > > > +
> > > >  typedef int (pblk_map_page_fn)(struct pblk *pblk, unsigned int sentry,
> > > >                                struct ppa_addr *ppa_list,
> > > >                                unsigned long *lun_bitmap,
> > > > @@ -1115,6 +1156,26 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
> > > >         return paddr;
> > > >  }
> > > >
> > > > +static inline int pblk_pos_to_lun(struct nvm_geo *geo, int pos)
> > > > +{
> > > > +       return pos >> ilog2(geo->num_ch);
> > > > +}
> > > > +
> > > > +static inline int pblk_pos_to_chnl(struct nvm_geo *geo, int pos)
> > > > +{
> > > > +       return pos % geo->num_ch;
> > > > +}
> > > > +
> > > > +static inline void pblk_dev_ppa_set_lun(struct ppa_addr *p, int lun)
> > > > +{
> > > > +       p->a.lun = lun;
> > > > +}
> > > > +
> > > > +static inline void pblk_dev_ppa_set_chnl(struct ppa_addr *p, int chnl)
> > > > +{
> > > > +       p->a.ch = chnl;
> > > > +}
> > >
> > > What is the motivation for adding the lun and chnl setters? They seem
> > > uncalled for.
> >
> > They are used in RAIL's read path to generate the ppas for RAIL reads
>
> It's just a style thing, but they seem a bit redundant to me.
>
> >
> > >
> > > > +
> > > >  static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
> > > >  {
> > > >         struct nvm_tgt_dev *dev = pblk->dev;
> > > > --
> > > > 2.17.1
> > > >

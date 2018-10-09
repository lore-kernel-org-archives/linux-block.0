Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37582 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJIQSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 12:18:09 -0400
Received: by mail-vs1-f66.google.com with SMTP id r83so762455vsc.4
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 02:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181005133437.25255-1-igor.j.konopko@intel.com> <20181005133437.25255-3-igor.j.konopko@intel.com>
In-Reply-To: <20181005133437.25255-3-igor.j.konopko@intel.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Tue, 9 Oct 2018 11:02:03 +0200
Message-ID: <CANr-nt1Hc88Sm_e7GYpYqbzXa67zQnGjqHgH3aEo2ARKMZEGeg@mail.gmail.com>
Subject: Re: [PATCH 2/5] lightnvm: pblk: Helpers for OOB metadata
To: igor.j.konopko@intel.com
Cc: Matias Bjorling <mb@lightnvm.io>,
        Javier Gonzalez <javier@cnexlabs.com>,
        linux-block@vger.kernel.org, marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Igor!

One important thing: this patch breaks the on-disk-storage format so
that needs to be handled(see my comment on this) and  some additional
nitpicks below.

Thanks,
Hans

On Fri, Oct 5, 2018 at 3:38 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> Currently pblk assumes that size of OOB metadata on drive is always
> equal to size of pblk_sec_meta struct. This commit add helpers which will
> allow to handle different sizes of OOB metadata on drive.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-core.c     |  6 ++---
>  drivers/lightnvm/pblk-map.c      | 21 ++++++++++------
>  drivers/lightnvm/pblk-read.c     | 41 +++++++++++++++++++-------------
>  drivers/lightnvm/pblk-recovery.c | 14 ++++++-----
>  drivers/lightnvm/pblk.h          | 37 +++++++++++++++++++++++++++-
>  5 files changed, 86 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 6944aac43b01..7cb39d84c833 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -743,7 +743,6 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>         rqd.opcode = NVM_OP_PREAD;
>         rqd.nr_ppas = lm->smeta_sec;
>         rqd.is_seq = 1;
> -
>         for (i = 0; i < lm->smeta_sec; i++, paddr++)
>                 rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
>
> @@ -796,10 +795,11 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
>         rqd.is_seq = 1;
>
>         for (i = 0; i < lm->smeta_sec; i++, paddr++) {
> -               struct pblk_sec_meta *meta_list = rqd.meta_list;
> +               void *meta_list = rqd.meta_list;
>
>                 rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
> -               meta_list[i].lba = lba_list[paddr] = addr_empty;
> +               pblk_set_meta_lba(pblk, meta_list, i, ADDR_EMPTY);
> +               lba_list[paddr] = addr_empty;
>         }
>
>         ret = pblk_submit_io_sync_sem(pblk, &rqd);
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 6dcbd44e3acb..4c7a9909308e 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -22,7 +22,7 @@
>  static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>                               struct ppa_addr *ppa_list,
>                               unsigned long *lun_bitmap,
> -                             struct pblk_sec_meta *meta_list,
> +                             void *meta_list,
>                               unsigned int valid_secs)
>  {
>         struct pblk_line *line = pblk_line_get_data(pblk);
> @@ -68,14 +68,15 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>                         kref_get(&line->ref);
>                         w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
>                         w_ctx->ppa = ppa_list[i];
> -                       meta_list[i].lba = cpu_to_le64(w_ctx->lba);
> +                       pblk_set_meta_lba(pblk, meta_list, i, w_ctx->lba);
>                         lba_list[paddr] = cpu_to_le64(w_ctx->lba);
>                         if (lba_list[paddr] != addr_empty)
>                                 line->nr_valid_lbas++;
>                         else
>                                 atomic64_inc(&pblk->pad_wa);
>                 } else {
> -                       lba_list[paddr] = meta_list[i].lba = addr_empty;
> +                       lba_list[paddr] = addr_empty;
> +                       pblk_set_meta_lba(pblk, meta_list, i, ADDR_EMPTY);
>                         __pblk_map_invalidate(pblk, line, paddr);
>                 }
>         }
> @@ -88,7 +89,7 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
>                  unsigned long *lun_bitmap, unsigned int valid_secs,
>                  unsigned int off)
>  {
> -       struct pblk_sec_meta *meta_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>         unsigned int map_secs;
>         int min = pblk->min_write_pgs;
> @@ -97,7 +98,10 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
>         for (i = off; i < rqd->nr_ppas; i += min) {
>                 map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
>                 if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
> -                                       lun_bitmap, &meta_list[i], map_secs)) {
> +                                       lun_bitmap,
> +                                       pblk_get_meta_buffer(pblk,
> +                                                            meta_list, i),
> +                                       map_secs)) {
>                         bio_put(rqd->bio);
>                         pblk_free_rqd(pblk, rqd, PBLK_WRITE);
>                         pblk_pipeline_stop(pblk);
> @@ -113,7 +117,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>         struct nvm_tgt_dev *dev = pblk->dev;
>         struct nvm_geo *geo = &dev->geo;
>         struct pblk_line_meta *lm = &pblk->lm;
> -       struct pblk_sec_meta *meta_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
>         struct pblk_line *e_line, *d_line;
>         unsigned int map_secs;
> @@ -123,7 +127,10 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>         for (i = 0; i < rqd->nr_ppas; i += min) {
>                 map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
>                 if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
> -                                       lun_bitmap, &meta_list[i], map_secs)) {
> +                                       lun_bitmap,
> +                                       pblk_get_meta_buffer(pblk,
> +                                                            meta_list, i),
> +                                       map_secs)) {
>                         bio_put(rqd->bio);
>                         pblk_free_rqd(pblk, rqd, PBLK_WRITE);
>                         pblk_pipeline_stop(pblk);
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 08f6ebd4bc48..6584a2588f61 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>                                  struct bio *bio, sector_t blba,
>                                  unsigned long *read_bitmap)
>  {
> -       struct pblk_sec_meta *meta_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         struct ppa_addr ppas[NVM_MAX_VLBA];
>         int nr_secs = rqd->nr_ppas;
>         bool advanced_bio = false;
> @@ -58,7 +58,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>  retry:
>                 if (pblk_ppa_empty(p)) {
>                         WARN_ON(test_and_set_bit(i, read_bitmap));
> -                       meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
> +                       pblk_set_meta_lba(pblk, meta_list, i, ADDR_EMPTY);
>
>                         if (unlikely(!advanced_bio)) {
>                                 bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
> @@ -78,7 +78,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>                                 goto retry;
>                         }
>                         WARN_ON(test_and_set_bit(i, read_bitmap));
> -                       meta_list[i].lba = cpu_to_le64(lba);
> +                       pblk_set_meta_lba(pblk, meta_list, i, lba);
>                         advanced_bio = true;
>  #ifdef CONFIG_NVM_PBLK_DEBUG
>                         atomic_long_inc(&pblk->cache_reads);
> @@ -105,12 +105,15 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
>  static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
>                                 sector_t blba)
>  {
> -       struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         int nr_lbas = rqd->nr_ppas;
>         int i;
>
> +       if (!pblk_is_oob_meta_supported(pblk))
> +               return;
> +
>         for (i = 0; i < nr_lbas; i++) {
> -               u64 lba = le64_to_cpu(meta_lba_list[i].lba);
> +               u64 lba = pblk_get_meta_lba(pblk, meta_list, i);
>
>                 if (lba == ADDR_EMPTY)
>                         continue;
> @@ -134,9 +137,12 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
>  static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>                                  u64 *lba_list, int nr_lbas)
>  {
> -       struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
> +       void *meta_lba_list = rqd->meta_list;
>         int i, j;
>
> +       if (!pblk_is_oob_meta_supported(pblk))
> +               return;
> +
>         for (i = 0, j = 0; i < nr_lbas; i++) {
>                 u64 lba = lba_list[i];
>                 u64 meta_lba;
> @@ -144,7 +150,7 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>                 if (lba == ADDR_EMPTY)
>                         continue;
>
> -               meta_lba = le64_to_cpu(meta_lba_list[j].lba);
> +               meta_lba = pblk_get_meta_lba(pblk, meta_lba_list, j);
>
>                 if (lba != meta_lba) {
>  #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -219,7 +225,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>         struct bio *new_bio = rqd->bio;
>         struct bio *bio = pr_ctx->orig_bio;
>         struct bio_vec src_bv, dst_bv;
> -       struct pblk_sec_meta *meta_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         int bio_init_idx = pr_ctx->bio_init_idx;
>         unsigned long *read_bitmap = pr_ctx->bitmap;
>         int nr_secs = pr_ctx->orig_nr_secs;
> @@ -237,8 +243,10 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>         }
>
>         for (i = 0; i < nr_secs; i++) {
> -               pr_ctx->lba_list_media[i] = meta_list[i].lba;
> -               meta_list[i].lba = pr_ctx->lba_list_mem[i];
> +               pr_ctx->lba_list_media[i] = pblk_get_meta_lba(pblk,
> +                                                       meta_list, i);
> +               pblk_set_meta_lba(pblk, meta_list, i,
> +                                 pr_ctx->lba_list_mem[i]);
>         }
>
>         /* Fill the holes in the original bio */
> @@ -250,7 +258,8 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>                 line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
>                 kref_put(&line->ref, pblk_line_put);
>
> -               meta_list[hole].lba = pr_ctx->lba_list_media[i];
> +               pblk_set_meta_lba(pblk, meta_list, hole,
> +                                 pr_ctx->lba_list_media[i]);
>
>                 src_bv = new_bio->bi_io_vec[i++];
>                 dst_bv = bio->bi_io_vec[bio_init_idx + hole];
> @@ -286,7 +295,7 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>                             unsigned long *read_bitmap,
>                             int nr_holes)
>  {
> -       struct pblk_sec_meta *meta_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>         struct pblk_pr_ctx *pr_ctx;
>         struct bio *new_bio, *bio = r_ctx->private;
> @@ -308,7 +317,7 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
>                 goto fail_free_pages;
>
>         for (i = 0; i < nr_secs; i++)
> -               pr_ctx->lba_list_mem[i] = meta_list[i].lba;
> +               pr_ctx->lba_list_mem[i] = pblk_get_meta_lba(pblk, meta_list, i);
>
>         new_bio->bi_iter.bi_sector = 0; /* internal bio */
>         bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
> @@ -373,7 +382,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
>  static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>                          sector_t lba, unsigned long *read_bitmap)
>  {
> -       struct pblk_sec_meta *meta_list = rqd->meta_list;
> +       void *meta_list = rqd->meta_list;
>         struct ppa_addr ppa;
>
>         pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
> @@ -385,7 +394,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>  retry:
>         if (pblk_ppa_empty(ppa)) {
>                 WARN_ON(test_and_set_bit(0, read_bitmap));
> -               meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
> +               pblk_set_meta_lba(pblk, meta_list, 0, ADDR_EMPTY);
>                 return;
>         }
>
> @@ -399,7 +408,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
>                 }
>
>                 WARN_ON(test_and_set_bit(0, read_bitmap));
> -               meta_list[0].lba = cpu_to_le64(lba);
> +               pblk_set_meta_lba(pblk, meta_list, 0, lba);
>
>  #ifdef CONFIG_NVM_PBLK_DEBUG
>                 atomic_long_inc(&pblk->cache_reads);
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 5740b7509bd8..fa63f9fa5ba8 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -124,7 +124,7 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>
>  struct pblk_recov_alloc {
>         struct ppa_addr *ppa_list;
> -       struct pblk_sec_meta *meta_list;
> +       void *meta_list;
>         struct nvm_rq *rqd;
>         void *data;
>         dma_addr_t dma_ppa_list;
> @@ -158,7 +158,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>  {
>         struct nvm_tgt_dev *dev = pblk->dev;
>         struct nvm_geo *geo = &dev->geo;
> -       struct pblk_sec_meta *meta_list;
> +       void *meta_list;
>         struct pblk_pad_rq *pad_rq;
>         struct nvm_rq *rqd;
>         struct bio *bio;
> @@ -242,7 +242,8 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>                         dev_ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
>
>                         pblk_map_invalidate(pblk, dev_ppa);
> -                       lba_list[w_ptr] = meta_list[i].lba = addr_empty;
> +                       lba_list[w_ptr] = addr_empty;
> +                       pblk_set_meta_lba(pblk, meta_list, i, ADDR_EMPTY);
>                         rqd->ppa_list[i] = dev_ppa;
>                 }
>         }
> @@ -325,6 +326,7 @@ static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
>                         return 1;
>                 else if (chunk->wp < line_wp)
>                         line_wp = chunk->wp;
> +

Please remove the introduced newline

>         }
>
>         return 0;
> @@ -336,7 +338,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>         struct nvm_tgt_dev *dev = pblk->dev;
>         struct nvm_geo *geo = &dev->geo;
>         struct ppa_addr *ppa_list;
> -       struct pblk_sec_meta *meta_list;
> +       void *meta_list;
>         struct nvm_rq *rqd;
>         struct bio *bio;
>         void *data;
> @@ -434,7 +436,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>         }
>
>         for (i = 0; i < rqd->nr_ppas; i++) {
> -               u64 lba = le64_to_cpu(meta_list[i].lba);
> +               u64 lba = pblk_get_meta_lba(pblk, meta_list, i);
>
>                 lba_list[paddr++] = cpu_to_le64(lba);
>
> @@ -463,7 +465,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>         struct nvm_geo *geo = &dev->geo;
>         struct nvm_rq *rqd;
>         struct ppa_addr *ppa_list;
> -       struct pblk_sec_meta *meta_list;
> +       void *meta_list;
>         struct pblk_recov_alloc p;
>         void *data;
>         dma_addr_t dma_ppa_list, dma_meta_list;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index aea09879636f..53156b6f99a3 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -87,7 +87,6 @@ enum {
>  };
>
>  struct pblk_sec_meta {
> -       u64 reserved;
>         __le64 lba;
>  };

It's nice to reduce the required metadata size, but this silently
breaks pblk the on-disk-storage format. We can't have that.

I suggest breaking out this change as a separate patch that also
increases SMETA_VERSION_MAJOR and instructs the user via the kernel
log to migrate the data manually (or factory reset the decice/pblk
instance).


>
> @@ -1366,4 +1365,40 @@ static inline char *pblk_disk_name(struct pblk *pblk)
>
>         return disk->disk_name;
>  }
> +
> +static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
> +{
> +       struct nvm_tgt_dev *dev = pblk->dev;
> +       struct nvm_geo *geo = &dev->geo;
> +
> +       /* Pblk uses OOB meta to store LBA of given physical sector.
> +        * The LBA is eventually used in recovery mode and/or for handling
> +        * telemetry events (e.g., relocate sector).
> +        */
> +
> +       return (geo->sos >= sizeof(struct pblk_sec_meta));
> +}
> +
> +static inline struct pblk_sec_meta *pblk_get_meta_buffer(struct pblk *pblk,
> +                                                        void *meta_ptr,

_ptr is surperflous, we know it's a pointer already.

> +                                                        int index)

The name of the function is misleading, maybe pblk_get_sec_meta instead?

> +{
> +       struct nvm_tgt_dev *dev = pblk->dev;
> +       struct nvm_geo *geo = &dev->geo;
> +
> +       return meta_ptr + max_t(int, geo->sos, sizeof(struct pblk_sec_meta))
> +               * index;

What is the max_t for? How could pblk_sec_meta ever be bigger than geo->sos?

> +}
> +
> +static inline void pblk_set_meta_lba(struct pblk *pblk, void *meta_ptr,
> +                                    int index, u64 lba)
> +{
> +       pblk_get_meta_buffer(pblk, meta_ptr, index)->lba = cpu_to_le64(lba);
> +}
> +
> +static inline u64 pblk_get_meta_lba(struct pblk *pblk, void *meta_ptr,
> +                                   int index)
> +{
> +       return le64_to_cpu(pblk_get_meta_buffer(pblk, meta_ptr, index)->lba);
> +}

I would prefer having these functions get/set lbas of type __le64
instead, as we always have to update the emeta lba list at the same
time we set the oob metadata, and the emeta lba list is __le64,
It's easy to mess this up and byte-ordering bugs are hard to detect.

>  #endif /* PBLK_H_ */
> --
> 2.17.1
>

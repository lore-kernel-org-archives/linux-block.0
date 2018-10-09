Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41316 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJIT1j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 15:27:39 -0400
Received: by mail-vs1-f67.google.com with SMTP id w1so1218562vsj.8
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 05:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-4-igor.j.konopko@intel.com> <CANr-nt2xoSM60je_EpK0UAvhf2-0=9GPiUsisppoMfNKYT_dhA@mail.gmail.com>
 <76a225ff-b375-4464-c184-a642be3c27c0@intel.com>
In-Reply-To: <76a225ff-b375-4464-c184-a642be3c27c0@intel.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Tue, 9 Oct 2018 14:10:46 +0200
Message-ID: <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
Subject: Re: [PATCH 3/5] lightnvm: Flexible DMA pool entry size
To: igor.j.konopko@intel.com, Matias Bjorling <mb@lightnvm.io>
Cc: Javier Gonzalez <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 9, 2018 at 12:03 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
>
>
> On 09.10.2018 11:16, Hans Holmberg wrote:
> > On Fri, Oct 5, 2018 at 3:38 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
> >>
> >> Currently whole lightnvm and pblk uses single DMA pool,
> >> for which entry size is always equal to PAGE_SIZE.
> >> PPA list always needs 8b*64, so there is only 56b*64
> >> space for OOB meta. Since NVMe OOB meta can be bigger,
> >> such as 128b, this solution is not robustness.
> >>
> >> This patch add the possiblity to support OOB meta above
> >> 56b by creating separate DMA pool for PBLK with entry
> >> size which is big enough to store both PPA list and such
> >> a OOB metadata.
> >>
> >> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >> ---
> >>   drivers/lightnvm/core.c          | 33 +++++++++++++++++++++++---------
> >>   drivers/lightnvm/pblk-core.c     | 19 +++++++++---------
> >>   drivers/lightnvm/pblk-init.c     | 11 +++++++++++
> >>   drivers/lightnvm/pblk-read.c     |  3 ++-
> >>   drivers/lightnvm/pblk-recovery.c |  9 +++++----
> >>   drivers/lightnvm/pblk.h          | 11 ++++++++++-
> >>   drivers/nvme/host/lightnvm.c     |  6 ++++--
> >>   include/linux/lightnvm.h         |  8 +++++---
> >>   8 files changed, 71 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >> index efb976a863d2..48db7a096257 100644
> >> --- a/drivers/lightnvm/core.c
> >> +++ b/drivers/lightnvm/core.c
> >> @@ -641,20 +641,33 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
> >>   }
> >>   EXPORT_SYMBOL(nvm_unregister_tgt_type);
> >>
> >> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
> >> -                                                       dma_addr_t *dma_handler)
> >> +void *nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
> >> +                               gfp_t mem_flags, dma_addr_t *dma_handler)
> >>   {
> >> -       return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
> >> -                                                               dma_handler);
> >> +       return dev->ops->dev_dma_alloc(dev, pool ?: dev->dma_pool,
> >> +                                               mem_flags, dma_handler);
> >>   }
> >>   EXPORT_SYMBOL(nvm_dev_dma_alloc);
> >>
> >> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
> >> +void nvm_dev_dma_free(struct nvm_dev *dev, void *pool,
> >> +                               void *addr, dma_addr_t dma_handler)
> >>   {
> >> -       dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
> >> +       dev->ops->dev_dma_free(pool ?: dev->dma_pool, addr, dma_handler);
> >>   }
> >>   EXPORT_SYMBOL(nvm_dev_dma_free);
> >>
> >> +void *nvm_dev_dma_create(struct nvm_dev *dev, int size, char *name)
> >> +{
> >> +       return dev->ops->create_dma_pool(dev, name, size);
> >> +}
> >> +EXPORT_SYMBOL(nvm_dev_dma_create);
> >> +
> >> +void nvm_dev_dma_destroy(struct nvm_dev *dev, void *pool)
> >> +{
> >> +       dev->ops->destroy_dma_pool(pool);
> >> +}
> >> +EXPORT_SYMBOL(nvm_dev_dma_destroy);
> >> +
> >>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
> >>   {
> >>          struct nvm_dev *dev;
> >> @@ -682,7 +695,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
> >>          }
> >>
> >>          rqd->nr_ppas = nr_ppas;
> >> -       rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
> >> +       rqd->ppa_list = nvm_dev_dma_alloc(dev, NULL, GFP_KERNEL,
> >> +                                               &rqd->dma_ppa_list);
> >>          if (!rqd->ppa_list) {
> >>                  pr_err("nvm: failed to allocate dma memory\n");
> >>                  return -ENOMEM;
> >> @@ -708,7 +722,8 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
> >>          if (!rqd->ppa_list)
> >>                  return;
> >>
> >> -       nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
> >> +       nvm_dev_dma_free(tgt_dev->parent, NULL, rqd->ppa_list,
> >> +                               rqd->dma_ppa_list);
> >>   }
> >>
> >>   static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
> >> @@ -1145,7 +1160,7 @@ int nvm_register(struct nvm_dev *dev)
> >>          if (!dev->q || !dev->ops)
> >>                  return -EINVAL;
> >>
> >> -       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
> >> +       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist", PAGE_SIZE);
> >>          if (!dev->dma_pool) {
> >>                  pr_err("nvm: could not create dma pool\n");
> >>                  return -ENOMEM;
> >
> > Why hack the nvm_dev_ interfaces when you are not using the dev pool anyway?
> > Wouldn't it be more straightforward to use dma_pool_* instead?
> >
>
> In order to call dma_pool_create() I need NVMe device structure, which
> in my understanding is not public, so this is why I decided to reuse
> plumbing which was available in nvm_dev_* interfaces.

Hmm, yes, I see now.

>
> If there is some easy way to call dma_pool_create() from pblk module and
> I'm missing that - let me know. I can rewrite this part, if there is
> some better way to do so.

Create and destroy needs to go through dev->ops, but once you have
allocated the pool, there is no need for going through the dev->ops
for allocate/free as far as I can see.
Matias: can't we just replace .dev_dma_alloc / .dev_dma_free  by calls
to dma_pool_alloc/free ?


>
> >> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> >> index 7cb39d84c833..131972b13e27 100644
> >> --- a/drivers/lightnvm/pblk-core.c
> >> +++ b/drivers/lightnvm/pblk-core.c
> >> @@ -242,16 +242,16 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
> >>   {
> >>          struct nvm_tgt_dev *dev = pblk->dev;
> >>
> >> -       rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> >> -                                                       &rqd->dma_meta_list);
> >> +       rqd->meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> >> +                                          GFP_KERNEL, &rqd->dma_meta_list);
> >>          if (!rqd->meta_list)
> >>                  return -ENOMEM;
> >>
> >>          if (rqd->nr_ppas == 1)
> >>                  return 0;
> >>
> >> -       rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
> >> -       rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
> >> +       rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size(pblk);
> >> +       rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size(pblk);
> >>
> >>          return 0;
> >>   }
> >> @@ -261,7 +261,7 @@ void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
> >>          struct nvm_tgt_dev *dev = pblk->dev;
> >>
> >>          if (rqd->meta_list)
> >> -               nvm_dev_dma_free(dev->parent, rqd->meta_list,
> >> +               nvm_dev_dma_free(dev->parent, pblk->dma_pool, rqd->meta_list,
> >>                                  rqd->dma_meta_list);
> >>   }
> >>
> >> @@ -840,13 +840,13 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
> >>          int i, j;
> >>          int ret;
> >>
> >> -       meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> >> +       meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool, GFP_KERNEL,
> >>                                                          &dma_meta_list);
> >>          if (!meta_list)
> >>                  return -ENOMEM;
> >>
> >> -       ppa_list = meta_list + pblk_dma_meta_size;
> >> -       dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> >> +       ppa_list = meta_list + pblk_dma_meta_size(pblk);
> >> +       dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
> >>
> >>   next_rq:
> >>          memset(&rqd, 0, sizeof(struct nvm_rq));
> >> @@ -919,7 +919,8 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
> >>                  goto next_rq;
> >>
> >>   free_rqd_dma:
> >> -       nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
> >> +       nvm_dev_dma_free(dev->parent, pblk->dma_pool,
> >> +                        rqd.meta_list, rqd.dma_meta_list);
> >>          return ret;
> >>   }
> >>
> >> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> >> index e3573880dbda..b794e279da31 100644
> >> --- a/drivers/lightnvm/pblk-init.c
> >> +++ b/drivers/lightnvm/pblk-init.c
> >> @@ -1087,6 +1087,7 @@ static void pblk_free(struct pblk *pblk)
> >>          pblk_l2p_free(pblk);
> >>          pblk_rwb_free(pblk);
> >>          pblk_core_free(pblk);
> >> +       nvm_dev_dma_destroy(pblk->dev->parent, pblk->dma_pool);
> >>
> >>          kfree(pblk);
> >>   }
> >> @@ -1178,6 +1179,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
> >>          atomic_long_set(&pblk->write_failed, 0);
> >>          atomic_long_set(&pblk->erase_failed, 0);
> >>
> >> +       pblk->dma_pool = nvm_dev_dma_create(dev->parent, (pblk_dma_ppa_size +
> >> +                                           pblk_dma_meta_size(pblk)),
> >> +                                           tdisk->disk_name);
> >> +       if (!pblk->dma_pool) {
> >> +               pblk_err(pblk, "could not allocate dma pool\n");
> >> +               kfree(pblk);
> >> +               return ERR_PTR(-ENOMEM);
> >> +       }
> >> +
> >>          ret = pblk_core_init(pblk);
> >>          if (ret) {
> >>                  pblk_err(pblk, "could not initialize core\n");
> >> @@ -1249,6 +1259,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
> >>   fail_free_core:
> >>          pblk_core_free(pblk);
> >>   fail:
> >> +       nvm_dev_dma_destroy(dev->parent, pblk->dma_pool);
> >>          kfree(pblk);
> >>          return ERR_PTR(ret);
> >>   }
> >> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> >> index 6584a2588f61..5d213c4f83c1 100644
> >> --- a/drivers/lightnvm/pblk-read.c
> >> +++ b/drivers/lightnvm/pblk-read.c
> >> @@ -499,7 +499,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
> >>          return NVM_IO_OK;
> >>
> >>   fail_meta_free:
> >> -       nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
> >> +       nvm_dev_dma_free(dev->parent, pblk->dma_pool,
> >> +                        rqd->meta_list, rqd->dma_meta_list);
> >>   fail_rqd_free:
> >>          pblk_free_rqd(pblk, rqd, PBLK_READ);
> >>          return ret;
> >> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> >> index fa63f9fa5ba8..4b703877907b 100644
> >> --- a/drivers/lightnvm/pblk-recovery.c
> >> +++ b/drivers/lightnvm/pblk-recovery.c
> >> @@ -471,12 +471,13 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
> >>          dma_addr_t dma_ppa_list, dma_meta_list;
> >>          int ret = 0;
> >>
> >> -       meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
> >> +       meta_list = nvm_dev_dma_alloc(dev->parent, pblk->dma_pool,
> >> +                                        GFP_KERNEL, &dma_meta_list);
> >>          if (!meta_list)
> >>                  return -ENOMEM;
> >>
> >> -       ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
> >> -       dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
> >> +       ppa_list = (void *)(meta_list) + pblk_dma_meta_size(pblk);
> >> +       dma_ppa_list = dma_meta_list + pblk_dma_meta_size(pblk);
> >>
> >>          data = kcalloc(pblk->max_write_pgs, geo->csecs, GFP_KERNEL);
> >>          if (!data) {
> >> @@ -507,7 +508,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
> >>          mempool_free(rqd, &pblk->r_rq_pool);
> >>          kfree(data);
> >>   free_meta_list:
> >> -       nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
> >> +       nvm_dev_dma_free(dev->parent, pblk->dma_pool, meta_list, dma_meta_list);
> >>
> >>          return ret;
> >>   }
> >> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> >> index 53156b6f99a3..6e4a63fd4c49 100644
> >> --- a/drivers/lightnvm/pblk.h
> >> +++ b/drivers/lightnvm/pblk.h
> >> @@ -103,7 +103,6 @@ enum {
> >>          PBLK_RL_LOW = 4
> >>   };
> >>
> >> -#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
> >>   #define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
> >>
> >>   /* write buffer completion context */
> >> @@ -711,6 +710,7 @@ struct pblk {
> >>          struct timer_list wtimer;
> >>
> >>          struct pblk_gc gc;
> >> +       void *dma_pool;
> >>   };
> >>
> >>   struct pblk_line_ws {
> >> @@ -1401,4 +1401,13 @@ static inline u64 pblk_get_meta_lba(struct pblk *pblk, void *meta_ptr,
> >>   {
> >>          return le64_to_cpu(pblk_get_meta_buffer(pblk, meta_ptr, index)->lba);
> >>   }
> >> +
> >> +static inline int pblk_dma_meta_size(struct pblk *pblk)
> >> +{
> >> +       struct nvm_tgt_dev *dev = pblk->dev;
> >> +       struct nvm_geo *geo = &dev->geo;
> >> +
> >> +       return max_t(int, sizeof(struct pblk_sec_meta), geo->sos)
> >> +                               * NVM_MAX_VLBA;
> >> +}
> >>   #endif /* PBLK_H_ */
> >> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> >> index 986526ff1521..e370793f52d5 100644
> >> --- a/drivers/nvme/host/lightnvm.c
> >> +++ b/drivers/nvme/host/lightnvm.c
> >> @@ -736,11 +736,13 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev *dev, struct nvm_rq *rqd)
> >>          return ret;
> >>   }
> >>
> >> -static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name)
> >> +static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
> >> +                                       int size)
> >>   {
> >>          struct nvme_ns *ns = nvmdev->q->queuedata;
> >>
> >> -       return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, PAGE_SIZE, 0);
> >> +       size = round_up(size, PAGE_SIZE);
> >> +       return dma_pool_create(name, ns->ctrl->dev, size, PAGE_SIZE, 0);
> >>   }
> >>
> >>   static void nvme_nvm_destroy_dma_pool(void *pool)
> >> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> >> index 36a84180c1e8..c6c998716ee7 100644
> >> --- a/include/linux/lightnvm.h
> >> +++ b/include/linux/lightnvm.h
> >> @@ -90,7 +90,7 @@ typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, sector_t, int,
> >>                                                          struct nvm_chk_meta *);
> >>   typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
> >>   typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
> >> -typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
> >> +typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
> >>   typedef void (nvm_destroy_dma_pool_fn)(void *);
> >>   typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
> >>                                                                  dma_addr_t *);
> >> @@ -668,8 +668,10 @@ struct nvm_tgt_type {
> >>   extern int nvm_register_tgt_type(struct nvm_tgt_type *);
> >>   extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
> >>
> >> -extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
> >> -extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
> >> +extern void *nvm_dev_dma_alloc(struct nvm_dev *, void *, gfp_t, dma_addr_t *);
> >> +extern void nvm_dev_dma_free(struct nvm_dev *, void *, void *, dma_addr_t);
> >> +extern void *nvm_dev_dma_create(struct nvm_dev *, int, char *);
> >> +extern void nvm_dev_dma_destroy(struct nvm_dev *, void *);
> >>
> >>   extern struct nvm_dev *nvm_alloc_dev(int);
> >>   extern int nvm_register(struct nvm_dev *);
> >> --
> >> 2.17.1
> >>

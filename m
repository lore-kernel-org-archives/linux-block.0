Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38513 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJIUNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 16:13:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so807682plr.5
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 05:57:00 -0700 (PDT)
Subject: Re: [PATCH 3/5] lightnvm: Flexible DMA pool entry size
To: hans.ml.holmberg@owltronix.com, igor.j.konopko@intel.com
Cc: javier@cnexlabs.com, linux-block@vger.kernel.org,
        marcin.dziegielewski@intel.com
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-4-igor.j.konopko@intel.com>
 <CANr-nt2xoSM60je_EpK0UAvhf2-0=9GPiUsisppoMfNKYT_dhA@mail.gmail.com>
 <76a225ff-b375-4464-c184-a642be3c27c0@intel.com>
 <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e5fcd475-09e9-8e25-2e02-3897b9331d8b@lightnvm.io>
Date: Tue, 9 Oct 2018 14:56:54 +0200
MIME-Version: 1.0
In-Reply-To: <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/09/2018 02:10 PM, Hans Holmberg wrote:
> On Tue, Oct 9, 2018 at 12:03 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>>
>>
>> On 09.10.2018 11:16, Hans Holmberg wrote:
>>> On Fri, Oct 5, 2018 at 3:38 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>
>>>> Currently whole lightnvm and pblk uses single DMA pool,
>>>> for which entry size is always equal to PAGE_SIZE.
>>>> PPA list always needs 8b*64, so there is only 56b*64
>>>> space for OOB meta. Since NVMe OOB meta can be bigger,
>>>> such as 128b, this solution is not robustness.
>>>>
>>>> This patch add the possiblity to support OOB meta above
>>>> 56b by creating separate DMA pool for PBLK with entry
>>>> size which is big enough to store both PPA list and such
>>>> a OOB metadata.
>>>>
>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>> ---
>>>>    drivers/lightnvm/core.c          | 33 +++++++++++++++++++++++---------
>>>>    drivers/lightnvm/pblk-core.c     | 19 +++++++++---------
>>>>    drivers/lightnvm/pblk-init.c     | 11 +++++++++++
>>>>    drivers/lightnvm/pblk-read.c     |  3 ++-
>>>>    drivers/lightnvm/pblk-recovery.c |  9 +++++----
>>>>    drivers/lightnvm/pblk.h          | 11 ++++++++++-
>>>>    drivers/nvme/host/lightnvm.c     |  6 ++++--
>>>>    include/linux/lightnvm.h         |  8 +++++---
>>>>    8 files changed, 71 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>> index efb976a863d2..48db7a096257 100644
>>>> --- a/drivers/lightnvm/core.c
>>>> +++ b/drivers/lightnvm/core.c
>>>> @@ -641,20 +641,33 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
>>>>    }
>>>>    EXPORT_SYMBOL(nvm_unregister_tgt_type);
>>>>
>>>> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
>>>> -                                                       dma_addr_t *dma_handler)
>>>> +void *nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
>>>> +                               gfp_t mem_flags, dma_addr_t *dma_handler)
>>>>    {
>>>> -       return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
>>>> -                                                               dma_handler);
>>>> +       return dev->ops->dev_dma_alloc(dev, pool ?: dev->dma_pool,
>>>> +                                               mem_flags, dma_handler);
>>>>    }
>>>>    EXPORT_SYMBOL(nvm_dev_dma_alloc);
>>>>
>>>> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
>>>> +void nvm_dev_dma_free(struct nvm_dev *dev, void *pool,
>>>> +                               void *addr, dma_addr_t dma_handler)
>>>>    {
>>>> -       dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
>>>> +       dev->ops->dev_dma_free(pool ?: dev->dma_pool, addr, dma_handler);
>>>>    }
>>>>    EXPORT_SYMBOL(nvm_dev_dma_free);
>>>>
>>>> +void *nvm_dev_dma_create(struct nvm_dev *dev, int size, char *name)
>>>> +{
>>>> +       return dev->ops->create_dma_pool(dev, name, size);
>>>> +}
>>>> +EXPORT_SYMBOL(nvm_dev_dma_create);
>>>> +
>>>> +void nvm_dev_dma_destroy(struct nvm_dev *dev, void *pool)
>>>> +{
>>>> +       dev->ops->destroy_dma_pool(pool);
>>>> +}
>>>> +EXPORT_SYMBOL(nvm_dev_dma_destroy);
>>>> +
>>>>    static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>>>>    {
>>>>           struct nvm_dev *dev;
>>>> @@ -682,7 +695,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>>>           }
>>>>
>>>>           rqd->nr_ppas = nr_ppas;
>>>> -       rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
>>>> +       rqd->ppa_list = nvm_dev_dma_alloc(dev, NULL, GFP_KERNEL,
>>>> +                                               &rqd->dma_ppa_list);
>>>>           if (!rqd->ppa_list) {
>>>>                   pr_err("nvm: failed to allocate dma memory\n");
>>>>                   return -ENOMEM;
>>>> @@ -708,7 +722,8 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>>>>           if (!rqd->ppa_list)
>>>>                   return;
>>>>
>>>> -       nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
>>>> +       nvm_dev_dma_free(tgt_dev->parent, NULL, rqd->ppa_list,
>>>> +                               rqd->dma_ppa_list);
>>>>    }
>>>>
>>>>    static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
>>>> @@ -1145,7 +1160,7 @@ int nvm_register(struct nvm_dev *dev)
>>>>           if (!dev->q || !dev->ops)
>>>>                   return -EINVAL;
>>>>
>>>> -       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
>>>> +       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist", PAGE_SIZE);
>>>>           if (!dev->dma_pool) {
>>>>                   pr_err("nvm: could not create dma pool\n");
>>>>                   return -ENOMEM;
>>>
>>> Why hack the nvm_dev_ interfaces when you are not using the dev pool anyway?
>>> Wouldn't it be more straightforward to use dma_pool_* instead?
>>>
>>
>> In order to call dma_pool_create() I need NVMe device structure, which
>> in my understanding is not public, so this is why I decided to reuse
>> plumbing which was available in nvm_dev_* interfaces.
> 
> Hmm, yes, I see now.
> 
>>
>> If there is some easy way to call dma_pool_create() from pblk module and
>> I'm missing that - let me know. I can rewrite this part, if there is
>> some better way to do so.
> 
> Create and destroy needs to go through dev->ops, but once you have
> allocated the pool, there is no need for going through the dev->ops
> for allocate/free as far as I can see.
> Matias: can't we just replace .dev_dma_alloc / .dev_dma_free  by calls
> to dma_pool_alloc/free ?
> 

Better to make the initial dma alloc better. I don't want targets to 
play around with their own DMA pools.

Something like the below (only compile tested :)):

diff --git i/drivers/lightnvm/core.c w/drivers/lightnvm/core.c
index efb976a863d2..f87696aa6b57 100644
--- i/drivers/lightnvm/core.c
+++ w/drivers/lightnvm/core.c
@@ -1141,11 +1141,17 @@ EXPORT_SYMBOL(nvm_alloc_dev);
  int nvm_register(struct nvm_dev *dev)
  {
         int ret;
+       int meta_sz;

         if (!dev->q || !dev->ops)
                 return -EINVAL;

-       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
+       /* Allow room for both metadata and ppa list in the dma pool */
+       meta_sz = (dev->geo.sos * NVM_MAX_VLBA) +
+                                       (sizeof(uint64_t) * NVM_MAX_VLBA);
+       meta_sz = PAGE_SIZE * (meta_sz >> PAGE_SHIFT);
+
+       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist", meta_sz);
         if (!dev->dma_pool) {
                 pr_err("nvm: could not create dma pool\n");
                 return -ENOMEM;
diff --git i/drivers/nvme/host/lightnvm.c w/drivers/nvme/host/lightnvm.c
index a4f3b263cd6c..31715c0cd8f2 100644
--- i/drivers/nvme/host/lightnvm.c
+++ w/drivers/nvme/host/lightnvm.c
@@ -731,11 +731,12 @@ static int nvme_nvm_submit_io_sync(struct nvm_dev 
*dev, struct nvm_rq *rq
         return ret;
  }

-static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name)
+static void *nvme_nvm_create_dma_pool(struct nvm_dev *nvmdev, char *name,
+                                     int size)
  {
         struct nvme_ns *ns = nvmdev->q->queuedata;

-       return dma_pool_create(name, ns->ctrl->dev, PAGE_SIZE, 
PAGE_SIZE, 0);
+       return dma_pool_create(name, ns->ctrl->dev, size, size, 0);
  }

  static void nvme_nvm_destroy_dma_pool(void *pool)
diff --git i/include/linux/lightnvm.h w/include/linux/lightnvm.h
index 2fdeac1a420d..7afedaddbd15 100644
--- i/include/linux/lightnvm.h
+++ w/include/linux/lightnvm.h
@@ -90,7 +90,7 @@ typedef int (nvm_get_chk_meta_fn)(struct nvm_dev *, 
sector_t, int,
                                                         struct 
nvm_chk_meta *);
  typedef int (nvm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
  typedef int (nvm_submit_io_sync_fn)(struct nvm_dev *, struct nvm_rq *);
-typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *);
+typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
  typedef void (nvm_destroy_dma_pool_fn)(void *);
  typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
 
dma_addr_t *);

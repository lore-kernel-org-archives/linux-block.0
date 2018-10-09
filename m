Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:31589 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIURU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Oct 2018 16:17:20 -0400
Subject: Re: [PATCH 3/5] lightnvm: Flexible DMA pool entry size
To: Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>
Cc: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-4-igor.j.konopko@intel.com>
 <CANr-nt2xoSM60je_EpK0UAvhf2-0=9GPiUsisppoMfNKYT_dhA@mail.gmail.com>
 <76a225ff-b375-4464-c184-a642be3c27c0@intel.com>
 <CANr-nt3doDy2mPmrrgR3aSbG7pPAct+OBRTWGL5s+fQf+h+NuA@mail.gmail.com>
 <6F3973DD-EE38-4250-9D0A-094EAFEF5C20@cnexlabs.com>
From: Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <29fb5b3a-3340-dae6-1d9f-6ca7c7692095@intel.com>
Date: Tue, 9 Oct 2018 14:54:26 +0200
MIME-Version: 1.0
In-Reply-To: <6F3973DD-EE38-4250-9D0A-094EAFEF5C20@cnexlabs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 09.10.2018 14:36, Javier Gonzalez wrote:
>> On 9 Oct 2018, at 21.10, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>
>> On Tue, Oct 9, 2018 at 12:03 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>> On 09.10.2018 11:16, Hans Holmberg wrote:
>>>> On Fri, Oct 5, 2018 at 3:38 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>> Currently whole lightnvm and pblk uses single DMA pool,
>>>>> for which entry size is always equal to PAGE_SIZE.
>>>>> PPA list always needs 8b*64, so there is only 56b*64
>>>>> space for OOB meta. Since NVMe OOB meta can be bigger,
>>>>> such as 128b, this solution is not robustness.
>>>>>
>>>>> This patch add the possiblity to support OOB meta above
>>>>> 56b by creating separate DMA pool for PBLK with entry
>>>>> size which is big enough to store both PPA list and such
>>>>> a OOB metadata.
>>>>>
>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>> ---
>>>>>   drivers/lightnvm/core.c          | 33 +++++++++++++++++++++++---------
>>>>>   drivers/lightnvm/pblk-core.c     | 19 +++++++++---------
>>>>>   drivers/lightnvm/pblk-init.c     | 11 +++++++++++
>>>>>   drivers/lightnvm/pblk-read.c     |  3 ++-
>>>>>   drivers/lightnvm/pblk-recovery.c |  9 +++++----
>>>>>   drivers/lightnvm/pblk.h          | 11 ++++++++++-
>>>>>   drivers/nvme/host/lightnvm.c     |  6 ++++--
>>>>>   include/linux/lightnvm.h         |  8 +++++---
>>>>>   8 files changed, 71 insertions(+), 29 deletions(-)
>>>>>
>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>> index efb976a863d2..48db7a096257 100644
>>>>> --- a/drivers/lightnvm/core.c
>>>>> +++ b/drivers/lightnvm/core.c
>>>>> @@ -641,20 +641,33 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
>>>>>   }
>>>>>   EXPORT_SYMBOL(nvm_unregister_tgt_type);
>>>>>
>>>>> -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
>>>>> -                                                       dma_addr_t *dma_handler)
>>>>> +void *nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
>>>>> +                               gfp_t mem_flags, dma_addr_t *dma_handler)
>>>>>   {
>>>>> -       return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
>>>>> -                                                               dma_handler);
>>>>> +       return dev->ops->dev_dma_alloc(dev, pool ?: dev->dma_pool,
>>>>> +                                               mem_flags, dma_handler);
>>>>>   }
>>>>>   EXPORT_SYMBOL(nvm_dev_dma_alloc);
>>>>>
>>>>> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
>>>>> +void nvm_dev_dma_free(struct nvm_dev *dev, void *pool,
>>>>> +                               void *addr, dma_addr_t dma_handler)
>>>>>   {
>>>>> -       dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
>>>>> +       dev->ops->dev_dma_free(pool ?: dev->dma_pool, addr, dma_handler);
>>>>>   }
>>>>>   EXPORT_SYMBOL(nvm_dev_dma_free);
>>>>>
>>>>> +void *nvm_dev_dma_create(struct nvm_dev *dev, int size, char *name)
>>>>> +{
>>>>> +       return dev->ops->create_dma_pool(dev, name, size);
>>>>> +}
>>>>> +EXPORT_SYMBOL(nvm_dev_dma_create);
>>>>> +
>>>>> +void nvm_dev_dma_destroy(struct nvm_dev *dev, void *pool)
>>>>> +{
>>>>> +       dev->ops->destroy_dma_pool(pool);
>>>>> +}
>>>>> +EXPORT_SYMBOL(nvm_dev_dma_destroy);
>>>>> +
>>>>>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>>>>>   {
>>>>>          struct nvm_dev *dev;
>>>>> @@ -682,7 +695,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>>>>          }
>>>>>
>>>>>          rqd->nr_ppas = nr_ppas;
>>>>> -       rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
>>>>> +       rqd->ppa_list = nvm_dev_dma_alloc(dev, NULL, GFP_KERNEL,
>>>>> +                                               &rqd->dma_ppa_list);
>>>>>          if (!rqd->ppa_list) {
>>>>>                  pr_err("nvm: failed to allocate dma memory\n");
>>>>>                  return -ENOMEM;
>>>>> @@ -708,7 +722,8 @@ static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>>>>>          if (!rqd->ppa_list)
>>>>>                  return;
>>>>>
>>>>> -       nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
>>>>> +       nvm_dev_dma_free(tgt_dev->parent, NULL, rqd->ppa_list,
>>>>> +                               rqd->dma_ppa_list);
>>>>>   }
>>>>>
>>>>>   static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
>>>>> @@ -1145,7 +1160,7 @@ int nvm_register(struct nvm_dev *dev)
>>>>>          if (!dev->q || !dev->ops)
>>>>>                  return -EINVAL;
>>>>>
>>>>> -       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist");
>>>>> +       dev->dma_pool = dev->ops->create_dma_pool(dev, "ppalist", PAGE_SIZE);
>>>>>          if (!dev->dma_pool) {
>>>>>                  pr_err("nvm: could not create dma pool\n");
>>>>>                  return -ENOMEM;
>>>>
>>>> Why hack the nvm_dev_ interfaces when you are not using the dev pool anyway?
>>>> Wouldn't it be more straightforward to use dma_pool_* instead?
>>>
>>> In order to call dma_pool_create() I need NVMe device structure, which
>>> in my understanding is not public, so this is why I decided to reuse
>>> plumbing which was available in nvm_dev_* interfaces.
>>
>> Hmm, yes, I see now.
>>
>>> If there is some easy way to call dma_pool_create() from pblk module and
>>> I'm missing that - let me know. I can rewrite this part, if there is
>>> some better way to do so.
>>
>> Create and destroy needs to go through dev->ops, but once you have
>> allocated the pool, there is no need for going through the dev->ops
>> for allocate/free as far as I can see.
>> Matias: can't we just replace .dev_dma_alloc / .dev_dma_free  by calls
>> to dma_pool_alloc/free ?
>>
> 
> When we implemented this, we thought we might need some extra driver
> specific code, but it has not been the case.
> 
> I'm ok with making the allocations directly once your have the pool
> provided by the driver lightnvm bits.
> 
> Igor: can you integrate this on the patches for next revision (still
> some extra feedback to come though).
>

Sure, I will integrate this changes for next revision and will wait for 
more feedback before publishing V2.

> Thanks,
> Javier
> 

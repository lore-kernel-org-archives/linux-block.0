Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60538C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF5B2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF5B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeK1Lrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:47:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:35521 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1Lrg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 06:47:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 16:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="94639440"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.227.25.68]) ([10.227.25.68])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2018 16:47:53 -0800
Subject: Re: [PATCH] lightnvm: remove dma alloc/free helpers
To:     Javier Gonzalez <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     "javier@javigon.com" <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1543325972-15136-1-git-send-email-javier@cnexlabs.com>
 <1543325972-15136-2-git-send-email-javier@cnexlabs.com>
 <ccb9584d-a262-366b-fe2d-605311c2b593@lightnvm.io>
 <F94C907C-3729-40A7-8774-B3FD3755F5F6@cnexlabs.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <d9d2c189-3b0d-c038-d592-d0dc6b0bc8ef@intel.com>
Date:   Wed, 28 Nov 2018 01:47:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <F94C907C-3729-40A7-8774-B3FD3755F5F6@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 27.11.2018 15:22, Javier Gonzalez wrote:
> 
> 
>> On 27 Nov 2018, at 15.18, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>>> On 11/27/2018 02:39 PM, Javier González wrote:
>>> Time has shown that the LightNVM alloc/free dma helpers are merely
>>> replacements of the native dma_pool operations. Thus, remove them and
>>> let targets manage the LightNVM dma pool directly.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/lightnvm/core.c          | 25 +++++++------------------
>>>   drivers/lightnvm/pblk-core.c     | 10 +++++-----
>>>   drivers/lightnvm/pblk-read.c     |  3 ++-
>>>   drivers/lightnvm/pblk-recovery.c |  5 +++--
>>>   drivers/nvme/host/lightnvm.c     | 16 +---------------
>>>   include/linux/lightnvm.h         |  8 +-------
>>>   6 files changed, 19 insertions(+), 48 deletions(-)
>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>> index c3650b141a30..8b6ee35e4356 100644
>>> --- a/drivers/lightnvm/core.c
>>> +++ b/drivers/lightnvm/core.c
>>> @@ -641,20 +641,6 @@ void nvm_unregister_tgt_type(struct nvm_tgt_type *tt)
>>>   }
>>>   EXPORT_SYMBOL(nvm_unregister_tgt_type);
>>>   -void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
>>> -                            dma_addr_t *dma_handler)
>>> -{
>>> -    return dev->ops->dev_dma_alloc(dev, dev->dma_pool, mem_flags,
>>> -                                dma_handler);
>>> -}
>>> -EXPORT_SYMBOL(nvm_dev_dma_alloc);
>>> -
>>> -void nvm_dev_dma_free(struct nvm_dev *dev, void *addr, dma_addr_t dma_handler)
>>> -{
>>> -    dev->ops->dev_dma_free(dev->dma_pool, addr, dma_handler);
>>> -}
>>> -EXPORT_SYMBOL(nvm_dev_dma_free);
>>> -
>>>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>>>   {
>>>       struct nvm_dev *dev;
>>> @@ -682,7 +668,8 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>>       }
>>>         rqd->nr_ppas = nr_ppas;
>>> -    rqd->ppa_list = nvm_dev_dma_alloc(dev, GFP_KERNEL, &rqd->dma_ppa_list);
>>> +    rqd->ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL,
>>> +                            &rqd->dma_ppa_list);
>>>       if (!rqd->ppa_list) {
>>>           pr_err("nvm: failed to allocate dma memory\n");
>>>           return -ENOMEM;
>>> @@ -705,10 +692,12 @@ static int nvm_set_rqd_ppalist(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd,
>>>   static void nvm_free_rqd_ppalist(struct nvm_tgt_dev *tgt_dev,
>>>               struct nvm_rq *rqd)
>>>   {
>>> +    struct nvm_dev *dev = tgt_dev->parent;
>>> +
>>>       if (!rqd->ppa_list)
>>>           return;
>>>   -    nvm_dev_dma_free(tgt_dev->parent, rqd->ppa_list, rqd->dma_ppa_list);
>>> +    dma_pool_free(dev->dma_pool, rqd->ppa_list, rqd->dma_ppa_list);
>>>   }
>>>     static int nvm_set_flags(struct nvm_geo *geo, struct nvm_rq *rqd)
>>> @@ -1178,7 +1167,7 @@ void nvm_unregister(struct nvm_dev *dev)
>>>   }
>>>   EXPORT_SYMBOL(nvm_unregister);
>>>   -int nvm_alloc_dma_pool(struct nvm_dev *dev)
>>> +int nvm_create_dma_pool(struct nvm_dev *dev)
>>>   {
>>>       int exp_pool_size;
>>>   @@ -1195,7 +1184,7 @@ int nvm_alloc_dma_pool(struct nvm_dev *dev)
>>>         return 0;
>>>   }
>>> -EXPORT_SYMBOL(nvm_alloc_dma_pool);
>>> +EXPORT_SYMBOL(nvm_create_dma_pool);
>>>     static int __nvm_configure_create(struct nvm_ioctl_create *create)
>>>   {
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 615817bf97e3..61a2a5330ecf 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -242,7 +242,7 @@ int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
>>>   {
>>>       struct nvm_tgt_dev *dev = pblk->dev;
>>>   -    rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>>> +    rqd->meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
>>>                               &rqd->dma_meta_list);
>>>       if (!rqd->meta_list)
>>>           return -ENOMEM;
>>> @@ -261,8 +261,8 @@ void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
>>>       struct nvm_tgt_dev *dev = pblk->dev;
>>>         if (rqd->meta_list)
>>> -        nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>> -                rqd->dma_meta_list);
>>> +        dma_pool_free(dev->parent->dma_pool, rqd->meta_list,
>>> +                            rqd->dma_meta_list);
>>>   }
>>>     /* Caller must guarantee that the request is a valid type */
>>> @@ -846,7 +846,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>       int i, j;
>>>       int ret;
>>>   -    meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>>> +    meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
>>>                               &dma_meta_list);
>>>       if (!meta_list)
>>>           return -ENOMEM;
>>> @@ -925,7 +925,7 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>>>           goto next_rq;
>>>     free_rqd_dma:
>>> -    nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
>>> +    dma_pool_free(dev->parent->dma_pool, rqd.meta_list, rqd.dma_meta_list);
>>>       return ret;
>>>   }
>>>   diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>>> index 32b285cf5846..1576f357c9af 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -507,7 +507,8 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>>>       return NVM_IO_OK;
>>>     fail_meta_free:
>>> -    nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
>>> +    dma_pool_free(dev->parent->dma_pool, rqd->meta_list,
>>> +                            rqd->dma_meta_list);
>>>   fail_rqd_free:
>>>       pblk_free_rqd(pblk, rqd, PBLK_READ);
>>>       return ret;
>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>>> index 65abc043e268..80d5b5bd4ab7 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -472,7 +472,8 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>>>       dma_addr_t dma_ppa_list, dma_meta_list;
>>>       int ret = 0;
>>>   -    meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
>>> +    meta_list = dma_pool_alloc(dev->parent->dma_pool, GFP_KERNEL,
>>> +                                &dma_meta_list);
>>>       if (!meta_list)
>>>           return -ENOMEM;
>>>   @@ -508,7 +509,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
>>>       mempool_free(rqd, &pblk->r_rq_pool);
>>>       kfree(data);
>>>   free_meta_list:
>>> -    nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
>>> +    dma_pool_free(dev->parent->dma_pool, meta_list, dma_meta_list);
>>>         return ret;
>>>   }
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index 049425ad8592..dd300ce9983f 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -747,18 +747,6 @@ static void nvme_nvm_destroy_dma_pool(void *pool)
>>>       dma_pool_destroy(dma_pool);
>>>   }
>>>   -static void *nvme_nvm_dev_dma_alloc(struct nvm_dev *dev, void *pool,
>>> -                    gfp_t mem_flags, dma_addr_t *dma_handler)
>>> -{
>>> -    return dma_pool_alloc(pool, mem_flags, dma_handler);
>>> -}
>>> -
>>> -static void nvme_nvm_dev_dma_free(void *pool, void *addr,
>>> -                            dma_addr_t dma_handler)
>>> -{
>>> -    dma_pool_free(pool, addr, dma_handler);
>>> -}
>>> -
>>>   static struct nvm_dev_ops nvme_nvm_dev_ops = {
>>>       .identity        = nvme_nvm_identity,
>>>   @@ -772,8 +760,6 @@ static struct nvm_dev_ops nvme_nvm_dev_ops = {
>>>         .create_dma_pool    = nvme_nvm_create_dma_pool,
>>>       .destroy_dma_pool    = nvme_nvm_destroy_dma_pool,
>>> -    .dev_dma_alloc        = nvme_nvm_dev_dma_alloc,
>>> -    .dev_dma_free        = nvme_nvm_dev_dma_free,
>>>   };
>>>     static int nvme_nvm_submit_user_cmd(struct request_queue *q,
>>> @@ -985,7 +971,7 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>>           geo->ext = ns->ext;
>>>       }
>>>   -    if (nvm_alloc_dma_pool(ndev))
>>> +    if (nvm_create_dma_pool(ndev))
>>>           nvm_unregister(ndev);
>>>   }
>>>   diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index fd7b519f3ad2..7ca38b8bf133 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -94,7 +94,6 @@ typedef void *(nvm_create_dma_pool_fn)(struct nvm_dev *, char *, int);
>>>   typedef void (nvm_destroy_dma_pool_fn)(void *);
>>>   typedef void *(nvm_dev_dma_alloc_fn)(struct nvm_dev *, void *, gfp_t,
>>>                                   dma_addr_t *);
>>> -typedef void (nvm_dev_dma_free_fn)(void *, void*, dma_addr_t);
>>>     struct nvm_dev_ops {
>>>       nvm_id_fn        *identity;
>>> @@ -108,8 +107,6 @@ struct nvm_dev_ops {
>>>         nvm_create_dma_pool_fn    *create_dma_pool;
>>>       nvm_destroy_dma_pool_fn    *destroy_dma_pool;
>>> -    nvm_dev_dma_alloc_fn    *dev_dma_alloc;
>>> -    nvm_dev_dma_free_fn    *dev_dma_free;
>>>   };
>>>     #ifdef CONFIG_NVM
>>> @@ -669,11 +666,8 @@ struct nvm_tgt_type {
>>>   extern int nvm_register_tgt_type(struct nvm_tgt_type *);
>>>   extern void nvm_unregister_tgt_type(struct nvm_tgt_type *);
>>>   -extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
>>> -extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
>>> -
>>>   extern struct nvm_dev *nvm_alloc_dev(int);
>>> -extern int nvm_alloc_dma_pool(struct nvm_dev *);
>>> +extern int nvm_create_dma_pool(struct nvm_dev *);
>>>   extern int nvm_register(struct nvm_dev *);
>>>   extern void nvm_unregister(struct nvm_dev *);
>>>   
>>
>> I kindly would like to reject this patch. One reason is that target's should not have direct access to DMA pools and another reason is that the code changes when OCSSD is used over Fabrics. The DMA pool is no longer available and data has to be allocated differently. This code does not belong inside a target.
> 
> Ok. I just sent it based on the discussion we had around the dma pools during the review of Igor’s patches. If I remember correctly, you backed this at that time... Anyway, there is no behavior change, so just ignore.
> 
> Igor: can you still make the name change on the dma pool creation?
> 

Sure, I'll change the name of that function together with other 
suggested changes and will send V4 of my series.

Igor

> Javier.
> 

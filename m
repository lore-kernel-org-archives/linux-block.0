Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33793 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeHaS04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 14:26:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id c29-v6so3975187lfj.1
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 07:19:12 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move ppa transformations to core
To: javier@cnexlabs.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535551926-4731-1-git-send-email-javier@cnexlabs.com>
 <e40fc6c5-3cc7-89bc-089f-0c9882324d32@lightnvm.io>
 <7CC06FE6-1678-4AC5-A249-893AF36A30E9@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9856c21d-a790-623a-e3e7-d9af4135e98e@lightnvm.io>
Date: Fri, 31 Aug 2018 16:19:09 +0200
MIME-Version: 1.0
In-Reply-To: <7CC06FE6-1678-4AC5-A249-893AF36A30E9@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 10:27 PM, Javier Gonzalez wrote:
> 
>> On 29 Aug 2018, at 16.30, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 04:12 PM, Javier González wrote:
>>> Continuing the effort of moving 1.2 and 2.0 specific code to core, move
>>> 64_to_32 and 32_to_64 ppa helpers from pblk to core.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/lightnvm/pblk.h  | 78 +++------------------------------------------
>>>   include/linux/lightnvm.h | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 87 insertions(+), 74 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index f95fe75fef6e..88ff529290f8 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -1086,86 +1086,16 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
>>>     static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
>>>   {
>>> -	struct ppa_addr ppa64;
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>>   -	ppa64.ppa = 0;
>>> -
>>> -	if (ppa32 == -1) {
>>> -		ppa64.ppa = ADDR_EMPTY;
>>> -	} else if (ppa32 & (1U << 31)) {
>>> -		ppa64.c.line = ppa32 & ((~0U) >> 1);
>>> -		ppa64.c.is_cached = 1;
>>> -	} else {
>>> -		struct nvm_tgt_dev *dev = pblk->dev;
>>> -		struct nvm_geo *geo = &dev->geo;
>>> -
>>> -		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> -			struct nvm_addrf_12 *ppaf =
>>> -					(struct nvm_addrf_12 *)&pblk->addrf;
>>> -
>>> -			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
>>> -							ppaf->ch_offset;
>>> -			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
>>> -							ppaf->lun_offset;
>>> -			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
>>> -							ppaf->blk_offset;
>>> -			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
>>> -							ppaf->pg_offset;
>>> -			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
>>> -							ppaf->pln_offset;
>>> -			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
>>> -							ppaf->sec_offset;
>>> -		} else {
>>> -			struct nvm_addrf *lbaf = &pblk->addrf;
>>> -
>>> -			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
>>> -							lbaf->ch_offset;
>>> -			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
>>> -							lbaf->lun_offset;
>>> -			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
>>> -							lbaf->chk_offset;
>>> -			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
>>> -							lbaf->sec_offset;
>>> -		}
>>> -	}
>>> -
>>> -	return ppa64;
>>> +	return ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
>>>   }
>>>     static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
>>>   {
>>> -	u32 ppa32 = 0;
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>>   -	if (ppa64.ppa == ADDR_EMPTY) {
>>> -		ppa32 = ~0U;
>>> -	} else if (ppa64.c.is_cached) {
>>> -		ppa32 |= ppa64.c.line;
>>> -		ppa32 |= 1U << 31;
>>> -	} else {
>>> -		struct nvm_tgt_dev *dev = pblk->dev;
>>> -		struct nvm_geo *geo = &dev->geo;
>>> -
>>> -		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> -			struct nvm_addrf_12 *ppaf =
>>> -					(struct nvm_addrf_12 *)&pblk->addrf;
>>> -
>>> -			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
>>> -			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
>>> -			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
>>> -			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
>>> -			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
>>> -			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
>>> -		} else {
>>> -			struct nvm_addrf *lbaf = &pblk->addrf;
>>> -
>>> -			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
>>> -			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
>>> -			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
>>> -			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
>>> -		}
>>> -	}
>>> -
>>> -	return ppa32;
>>> +	return ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
>>>   }
>>>     static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 77743a02ec0d..7107a8b84039 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -506,6 +506,89 @@ static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
>>>   	return caddr;
>>>   }
>>>   +static inline struct ppa_addr ppa32_to_ppa64(struct nvm_dev *dev,
>>> +					     void *addrf, u32 ppa32)
>>> +{
>>> +	struct ppa_addr ppa64;
>>> +
>>> +	ppa64.ppa = 0;
>>> +
>>> +	if (ppa32 == -1) {
>>> +		ppa64.ppa = ADDR_EMPTY;
>>> +	} else if (ppa32 & (1U << 31)) {
>>> +		ppa64.c.line = ppa32 & ((~0U) >> 1);
>>> +		ppa64.c.is_cached = 1;
>>> +	} else {
>>> +		struct nvm_geo *geo = &dev->geo;
>>> +
>>> +		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> +			struct nvm_addrf_12 *ppaf = addrf;
>>> +
>>> +			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
>>> +							ppaf->ch_offset;
>>> +			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
>>> +							ppaf->lun_offset;
>>> +			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
>>> +							ppaf->blk_offset;
>>> +			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
>>> +							ppaf->pg_offset;
>>> +			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
>>> +							ppaf->pln_offset;
>>> +			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
>>> +							ppaf->sec_offset;
>>> +		} else {
>>> +			struct nvm_addrf *lbaf = addrf;
>>> +
>>> +			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
>>> +							lbaf->ch_offset;
>>> +			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
>>> +							lbaf->lun_offset;
>>> +			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
>>> +							lbaf->chk_offset;
>>> +			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
>>> +							lbaf->sec_offset;
>>> +		}
>>> +	}
>>> +
>>> +	return ppa64;
>>> +}
>>> +
>>> +static inline u32 ppa64_to_ppa32(struct nvm_dev *dev,
>>> +				 void *addrf, struct ppa_addr ppa64)
>>> +{
>>> +	u32 ppa32 = 0;
>>> +
>>> +	if (ppa64.ppa == ADDR_EMPTY) {
>>> +		ppa32 = ~0U;
>>> +	} else if (ppa64.c.is_cached) {
>>> +		ppa32 |= ppa64.c.line;
>>> +		ppa32 |= 1U << 31;
>>> +	} else {
>>> +		struct nvm_geo *geo = &dev->geo;
>>> +
>>> +		if (geo->version == NVM_OCSSD_SPEC_12) {
>>> +			struct nvm_addrf_12 *ppaf = addrf;
>>> +
>>> +			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
>>> +			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
>>> +			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
>>> +			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
>>> +			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
>>> +			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
>>> +		} else {
>>> +			struct nvm_addrf *lbaf = addrf;
>>> +
>>> +			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
>>> +			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
>>> +			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
>>> +			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
>>> +		}
>>> +	}
>>> +
>>> +	return ppa32;
>>> +}
>>> +
>>> +
>>>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>>>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
>>>   typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
>>
>> Thanks. Applied for 4.20. I've updated the global ppa[32/64]_to_ppa[64/32] to prepend nvm_.
> 
> Cool, thanks. Should we do the same for the rest of the helpers dev_to_*?
> 

It's fine by me either way. At some point I'll properly do a larger 
cleanup to fix it all.

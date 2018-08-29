Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
To: javier@cnexlabs.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
 <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
 <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
Date: Wed, 29 Aug 2018 15:36:24 +0200
MIME-Version: 1.0
In-Reply-To: <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/29/2018 03:18 PM, Javier Gonzalez wrote:
>> On 29 Aug 2018, at 15.00, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 10:56 AM, Javier González wrote:
>>> dma allocations for ppa_list and meta_list in rqd are replicated in
>>> several places across the pblk codebase. Make helpers to encapsulate
>>> creation and deletion to simplify the code.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c     | 69 +++++++++++++++++++++++++---------------
>>>   drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>>>   drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>>>   drivers/lightnvm/pblk-write.c    | 15 ++-------
>>>   drivers/lightnvm/pblk.h          |  3 ++
>>>   5 files changed, 74 insertions(+), 77 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 09160ec02c5f..767178185f19 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
>>>   	spin_unlock(&pblk->trans_lock);
>>>   }
>>>   +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t mem_flags,
>>> +		   bool is_vector)
>>
>>
>> The mem_flags argument can be removed. It is GFP_KERNEL from all the
>> places it is called.
>>
> 
> Thought it was better to have the flexibility in a helper function, but
> we can always add it later on if needed...
> 
>> is_vector, will be better to do nr_ppas (or similar name). Then
>> pblk_submit_read/pblk_submit_read_gc are a bit cleaner.
>>
> 
> We can do that too, yes.
> 
> 
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +
>>> +	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, mem_flags,
>>> +							&rqd->dma_meta_list);
>>> +	if (!rqd->meta_list)
>>> +		return -ENOMEM;
>>> +
>>> +	if (!is_vector)
>>> +		return 0;
>>> +
>>> +	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
>>> +	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
>>
>> Wrt to is_vector, does it matter if we just set ppa_list and
>> dma_ppa_list? If we have them, we use them, else leave them alone?
>>
> 
> If we only have 1 address then ppa_addr is set and the ppa_list attempt
> to free in the completion path interpreting ppa_addr as the dma address.
> So I don't think so - unless I'm missing something?

In that case, we could drop is_vector/nr_ppas all together? That would 
be nice.

> 
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +
>>> +	if (rqd->meta_list)
>>> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>> +				rqd->dma_meta_list);
>>> +}
>>
>> Looks like setup/clear is mainly about managing the metadata. Would
>> pblk_alloc_rqd_meta()/pblk_free/rqd_meta be better names? Unless we
>> can fold it all into pblk_alloc_rqd/pblk_free_rqd.
>>
> 
> It's not easy to fold them there as we use nvm_rq allocations without
> extra space in the rqd for metadata. This is also a problem for rqd
> allocated in the stack. But I can change the names to make the
> functionality more clear.

Yep, that was what I felt as well. Renaming will be good.

> 
> Javier
> 

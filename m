Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36649 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIENJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Sep 2018 09:09:18 -0400
Subject: Re: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in
 pblk_line_submit_smeta_io()
To: Javier Gonzalez <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20180901115318.30416-1-baijiaju1990@gmail.com>
 <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
 <EFBE4E08-0A3E-442B-BD23-4E79042D2A05@cnexlabs.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <8c3d9191-a3c1-2a6c-a7f1-b0baf50e95e9@gmail.com>
Date: Wed, 5 Sep 2018 16:40:04 +0800
MIME-Version: 1.0
In-Reply-To: <EFBE4E08-0A3E-442B-BD23-4E79042D2A05@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2018/9/5 1:52, Javier Gonzalez wrote:
>> On 4 Sep 2018, at 03.11, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 09/01/2018 01:53 PM, Jia-Ju Bai wrote:
>>> The driver may sleep with holding a spinlock.
>>> The function call paths (from bottom to top) in Linux-4.16 are:
>>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>>> drivers/lightnvm/pblk-core.c, 754:
>>> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>>> drivers/lightnvm/pblk-core.c, 1048:
>>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>>> drivers/lightnvm/pblk-core.c, 1434:
>>> 	pblk_line_init_bb in pblk_line_replace_data
>>> drivers/lightnvm/pblk-recovery.c, 980:
>>> 	pblk_line_replace_data in pblk_recov_l2p
>>> drivers/lightnvm/pblk-recovery.c, 976:
>>> 	spin_lock in pblk_recov_l2p
>>> [FUNC] bio_map_kern(GFP_KERNEL)
>>> drivers/lightnvm/pblk-core.c, 762:
>>> 	bio_map_kern in pblk_line_submit_smeta_io
>>> drivers/lightnvm/pblk-core.c, 1048:
>>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>>> drivers/lightnvm/pblk-core.c, 1434:
>>> 	pblk_line_init_bb in pblk_line_replace_data
>>> drivers/lightnvm/pblk-recovery.c, 980:
>>> 	pblk_line_replace_data in pblk_recov_l2p
>>> drivers/lightnvm/pblk-recovery.c, 976:
>>> 	spin_lock in pblk_recov_l2p
>>> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
>>> These bugs are found by my static analysis tool DSAC.
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index ed9cc977c8b3..5d915c93b6cf 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>>>     	memset(&rqd, 0, sizeof(struct nvm_rq));
>>>   -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>>> +	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
>>>   							&rqd.dma_meta_list);
>>>   	if (!rqd.meta_list)
>>>   		return -ENOMEM;
>>> @@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>>>   	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
>>>   	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
>>>   -	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>>> +	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_ATOMIC);
>>>   	if (IS_ERR(bio)) {
>>>   		ret = PTR_ERR(bio);
>>>   		goto free_ppa_list;
>> Javier,
>>
>> What do you think? I'm OK with applying this, but one could also move
>> the allocs outside the spinlocks?
>>
> Definitely better to take the allocation out of the spin_lock(), as all
> line preparations are made to be lock free.
>
> It is fairly simple to fix this, as it only occurs when calling
> pblk_line_replace_data() from pblk_recov_l2p(). Here the lock can be
> inside the if statement to only cover text_and_clear_bit() and to the
> else statement to cover it entirely.
>
>   Jia-Ju Bai: Do you want to send a patch for this?

Okay, Javier.
I sent a patch just now, please have a look.


Best wishes,
Jia-Ju Bai

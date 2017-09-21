Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50077 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdIULOu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 07:14:50 -0400
Received: by mail-wm0-f48.google.com with SMTP id r74so778090wme.4
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2017 04:14:49 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix error path in
 pblk_lines_alloc_metadata
To: Rakesh Pandit <rakesh@tuxera.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170920195019.GA25759@dhcp-216.srv.tuxera.com>
 <032D1EF1-4F4A-45E1-BE6C-B8C9C9E0F6F7@lightnvm.io>
 <20170921101504.GA27665@dhcp-216.srv.tuxera.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <252b5d61-bc34-3c1c-db25-3cc9bba1b053@lightnvm.io>
Date: Thu, 21 Sep 2017 13:14:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170921101504.GA27665@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/21/2017 12:15 PM, Rakesh Pandit wrote:
> On Thu, Sep 21, 2017 at 11:56:46AM +0200, Javier González wrote:
>>> On 20 Sep 2017, at 21.50, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>>
>>> Use appropriate memory free calls based on allocation type used and
>>> also fix number of times free is called if kmalloc fails.
>>>
>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 8 ++++++--
>>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 7cf4b53..470ef04 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -624,12 +624,16 @@ static int pblk_lines_alloc_metadata(struct pblk *pblk)
>>>
>>> fail_free_emeta:
>>> 	while (--i >= 0) {
>>> -		vfree(l_mg->eline_meta[i]->buf);
>>> +		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
>>> +			vfree(l_mg->eline_meta[i]->buf);
>>> +		else
>>> +			kfree(l_mg->eline_meta[i]->buf);
>>> 		kfree(l_mg->eline_meta[i]);
>>> 	}
>>>
>>> +	i = PBLK_DATA_LINES;
>>> fail_free_smeta:
>>> -	for (i = 0; i < PBLK_DATA_LINES; i++)
>>> +	while (--i >= 0)
>>> 		kfree(l_mg->sline_meta[i]);
>>
>> It is safe to use kfree on NULL pointers. No need to do this. You can
>> either send a new patch, or we can change it when picking it up.
> 
> Yes, that would be great if this is adjusted while picking up.
> 
>>
>>>
>>> 	return -ENOMEM;
>>> --
>>> 2.5.0
>>
>> Rest looks good.
>>
>>
>> Reviewed-by: Javier González <javier@cnexlabs.com>
>>
> 
> Thanks,
> 

Thanks Rakesh. I queued it up.

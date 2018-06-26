Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:38922 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934324AbeFZKig (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 06:38:36 -0400
Received: by mail-io0-f196.google.com with SMTP id f1-v6so15500089ioh.6
        for <linux-block@vger.kernel.org>; Tue, 26 Jun 2018 03:38:35 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To: javier@cnexlabs.com
Cc: hans.ml.holmberg@owltronix.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
 <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
Date: Tue, 26 Jun 2018 12:38:29 +0200
MIME-Version: 1.0
In-Reply-To: <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/26/2018 11:37 AM, Javier Gonzalez wrote:
> 
> 
>> On 26 Jun 2018, at 10.41, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> We can't know if a block is closed or not on 1.2 devices, so assume
>>> closed state to make sure that blocks are erased before writing.
>>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> ---
>>> This patch applies on:
>>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>>   drivers/lightnvm/pblk-init.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index aa24264..3b8aa4a 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
>>>     		/*
>>>   		 * In 1.2 spec. chunk state is not persisted by the device. Thus
>>> -		 * some of the values are reset each time pblk is instantiated.
>>> +		 * some of the values are reset each time pblk is instantiated,
>>> +		 * so we have to assume that the block is closed.
>>>   		 */
>>>   		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
>>> -			chunk->state =  NVM_CHK_ST_FREE;
>>> +			chunk->state =  NVM_CHK_ST_CLOSED;
>>>   		else
>>>   			chunk->state = NVM_CHK_ST_OFFLINE;
>>>
>>
>> pblk should scan (or the lightnvm subsystem) the blocks for their
>> state, such that it doesn't have to reinitialize a full drive if it is
>> already in a closed state. If marking closed, it does a full erase
>> cycle on initialization, which should be avoided since it is a limited
>> resource.
> 
> In 1.2 there is no such state unfortunately. However, pblk will never
> attempt to reinitialize the whole drive - metadata for closed blocks
> will be recovered and only those going to GC will be erased before
> usage. In fact, a full close drive is the state pblk expects.
> 
> This patch only affects "unknown blocks", thus the only case in which
> pblk would attempt to double erase is when blocks have been pre-erased
> (e.g., factory or through liblightnvm). After an erase round though,
> pblk will only erase pre-usage. One thing we could do is attempting to
> read the first page of these unknown blocks and mark them as free if
> "empty page" is returned. Is this what you mean? 

Yes, that is what I mean.

Note that this can be
> costly on large drives; this is the reason we returned to the pre-2.0
> behaviour with this patch. We are implementing a log that, among other
> things, keeps the state so that pblk can have an accurate state for the
> cases this can be a problem.

Yep, it will take some time. Good to hear with the log.

-Matias

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45983 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934694AbeFZMNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 08:13:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi1-v6so420757plb.12
        for <linux-block@vger.kernel.org>; Tue, 26 Jun 2018 05:13:34 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To: javier@cnexlabs.com
Cc: hans.ml.holmberg@owltronix.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
 <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
 <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
 <CANr-nt3Qzp-brMa16NAVa=E6eRCfpNyV44cmRoaxYUV0J7zStA@mail.gmail.com>
 <4bcd22df-3899-fc87-d558-27754befae5e@lightnvm.io>
 <D165FE85-ED96-4E1E-85C3-D4C0C52B8E24@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f000c5f3-27f4-489c-5e6e-99921f456954@lightnvm.io>
Date: Tue, 26 Jun 2018 14:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <D165FE85-ED96-4E1E-85C3-D4C0C52B8E24@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/26/2018 01:54 PM, Javier Gonzalez wrote:
> 
>> On 26 Jun 2018, at 13.44, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>>> On 06/26/2018 01:31 PM, Hans Holmberg wrote:
>>>> On Tue, Jun 26, 2018 at 1:38 PM, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>> On 06/26/2018 11:37 AM, Javier Gonzalez wrote:
>>>>>
>>>>>
>>>>>
>>>>>> On 26 Jun 2018, at 10.41, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>
>>>>>> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>>>>>>>
>>>>>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>>>> We can't know if a block is closed or not on 1.2 devices, so assume
>>>>>>> closed state to make sure that blocks are erased before writing.
>>>>>>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
>>>>>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>>>>>> ---
>>>>>>> This patch applies on:
>>>>>>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>>>>>>    drivers/lightnvm/pblk-init.c | 5 +++--
>>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>>>>>> index aa24264..3b8aa4a 100644
>>>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>>>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk
>>>>>>> *pblk, struct pblk_line *line,
>>>>>>>                  /*
>>>>>>>                   * In 1.2 spec. chunk state is not persisted by the
>>>>>>> device. Thus
>>>>>>> -                * some of the values are reset each time pblk is
>>>>>>> instantiated.
>>>>>>> +                * some of the values are reset each time pblk is
>>>>>>> instantiated,
>>>>>>> +                * so we have to assume that the block is closed.
>>>>>>>                   */
>>>>>>>                  if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
>>>>>>> -                       chunk->state =  NVM_CHK_ST_FREE;
>>>>>>> +                       chunk->state =  NVM_CHK_ST_CLOSED;
>>>>>>>                  else
>>>>>>>                          chunk->state = NVM_CHK_ST_OFFLINE;
>>>>>>>
>>>>>>
>>>>>> pblk should scan (or the lightnvm subsystem) the blocks for their
>>>>>> state, such that it doesn't have to reinitialize a full drive if it is
>>>>>> already in a closed state. If marking closed, it does a full erase
>>>>>> cycle on initialization, which should be avoided since it is a limited
>>>>>> resource.
>>>>>
>>>>>
>>>>> In 1.2 there is no such state unfortunately. However, pblk will never
>>>>> attempt to reinitialize the whole drive - metadata for closed blocks
>>>>> will be recovered and only those going to GC will be erased before
>>>>> usage. In fact, a full close drive is the state pblk expects.
>>>>>
>>>>> This patch only affects "unknown blocks", thus the only case in which
>>>>> pblk would attempt to double erase is when blocks have been pre-erased
>>>>> (e.g., factory or through liblightnvm). After an erase round though,
>>>>> pblk will only erase pre-usage. One thing we could do is attempting to
>>>>> read the first page of these unknown blocks and mark them as free if
>>>>> "empty page" is returned. Is this what you mean?
>>>>
>>>>
>>>> Yes, that is what I mean.
>>>>
>>>> Note that this can be
>>>>>
>>>>> costly on large drives; this is the reason we returned to the pre-2.0
>>>>> behaviour with this patch. We are implementing a log that, among other
>>>>> things, keeps the state so that pblk can have an accurate state for the
>>>>> cases this can be a problem.
>>>>
>>>>
>>>> Yep, it will take some time. Good to hear with the log.
>>> Until we have a log in place, this patch unbreaks 1.2 support and has
>>> no negative impact on performance (as compared to pre 2.0 support), so
>>> please consider it for the next window.
>>> The current state is that if a pblk instance is created on a 1.2 disk
>>> with written blocks, writes will fail.
>>>   / Hans
>>
>> The negative impact is that all blocks are erased, even if they are in free state. This is a showstopper. We cannot throw out 1/X of the lifetime of the drive on each initialization. The 1.2 spec is made such that a scan can recover the block state accurately.
> 
> This fixes patch returns to the original behavior, so it’s not introducing a worse behavior than before 2.0. But you’re right, it is not the way it should be.
> 
> Can you consider taking this as a fix for 4.18 to avoid writes failing on 1.2 devices and I promise to send a patch this week to implement the state based on reads? This new patch would be for 4.19.
> 
> Javier
> 

Okay, sounds good to me. Thanks

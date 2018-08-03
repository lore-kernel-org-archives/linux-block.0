Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44859 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeHCNxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 09:53:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so3841574lfb.11
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 04:57:34 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
To: javier@cnexlabs.com
Cc: hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
 <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
 <19b2f125-d373-cf2b-43c7-140b3872cd64@lightnvm.io>
 <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8c2fc1ff-e2ea-499e-3699-39622d00be9e@lightnvm.io>
Date: Fri, 3 Aug 2018 13:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <D6AFE2C1-D273-4945-9A12-D4A0A57FD108@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/24/2018 09:54 AM, Javier Gonzalez wrote:
>> On 29 Jun 2018, at 13.28, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 06/29/2018 01:22 PM, Javier Gonzalez wrote:
>>>> On 29 Jun 2018, at 13.14, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> On 06/28/2018 11:12 AM, Javier González wrote:
>>>>> The Open-Channel 1.2 spec does not define a mechanism for the host to
>>>>> recover the block (chunk) state. As a consequence, a newly format device
>>>>> will need to reconstruct the state. Currently, pblk assumes that blocks
>>>>> are not erased, which might cause double-erases in case that the device
>>>>> does not protect itself against them (which is not specified in the spec
>>>>> either).
>>>>
>>>> It should not be specified in the spec. It is up to the device to handle
>>>> double erases and not do it.
>>>>
>>>>> This patch, reconstructs the state based on read errors. If the first
>>>>> sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), then
>>>>> the block s marked free, i.e., erased and ready to be used
>>>>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>>>>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not fully
>>>>> written, it has to be erased in order to be used again.
>>>>
>>>> Should we extend it to do the scan, and update the write pointer as
>>>> well? I think this kind of feature already is baked into pblk?
>>> This is already in place: we scan until empty page and take it from
>>> there. This patch is only for the case in which we start a pblk instance
>>> form scratch. On a device already owned by pblk, we would not have the
>>> problem we are trying to solve here because we know the state.
>>
>> Agree. What I meant was that when we anyway are recovering the state,
>> we could just as well update ->wp and set to NVM_CHK_ST_OPEN and so
>> forth for the initialization phase.
>>
> 
> In 1.2 the use of chunk metadata is purely fictional. We respect the
> chunk state machine as we transition lines, but all the write pointers
> are ignored. Instead, we use the line bitmap to point to the next
> writable entry. This is BTW the same way we it in open lines on 2.0 too.
> 

Now I understand where you are coming from. I had the understanding that 
we where using the write pointer now that we moved to 2.0, looking 
through the code, that wasn't the case. :) Which means that pblk doesn't 
work with a devices that implements 2.0. Yikes... I knew I had forgot a 
detail when support was added into pblk.

There are no empty sector marker in the 2.0 spec, since it uses the 
write pointer to know where it is in the chunk. So there is a bit of 
work to do there.

Since this properly is a bit more work to do, I'll look into it after FMS.

I'm also moving the explicit coding of 1.2/2.0 chunk / bad block fixing 
into core, so pblk can be simplfied, and doesn't have to think to manage 
each version separately.


> Chunk metadata is only used to setup the bitmaps on init/recovery. From
> here on, we use the bitmap to find the next writable sector, without
> worrying about the specific per-chunk write pointer. Thus, updating
> chunk metadata here has no effect.
> 
> Does this make sense to you?
> 
> Javier
> 

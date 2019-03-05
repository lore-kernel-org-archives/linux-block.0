Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8EC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0DA206DD
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 08:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfCEI0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:26:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:49607 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfCEI0X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 03:26:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 00:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,443,1544515200"; 
   d="scan'208";a="121073915"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.88]) ([10.237.142.88])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2019 00:26:20 -0800
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
To:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com>
 <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
 <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com>
 <CANr-nt30zr_5sMEAK4Uk7VCRJPWr30zjPUVrQPA_H5kBU-nfrQ@mail.gmail.com>
 <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com>
 <387c3a1d-efe7-36c5-6233-f262f27a64a7@lightnvm.io>
 <CANr-nt0HuEnEPhAQC10xEFud4SHqcC662==1njSP8Ag2ue4UKA@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <0cd6b922-c622-6946-b182-77176967e63b@intel.com>
Date:   Tue, 5 Mar 2019 09:26:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0HuEnEPhAQC10xEFud4SHqcC662==1njSP8Ag2ue4UKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 05.03.2019 09:20, Hans Holmberg wrote:
> On Mon, Mar 4, 2019 at 2:00 PM Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 3/4/19 1:44 PM, Igor Konopko wrote:
>>>
>>>
>>> On 04.03.2019 12:43, Hans Holmberg wrote:
>>>> On Mon, Mar 4, 2019 at 10:11 AM Javier González <javier@javigon.com>
>>>> wrote:
>>>>>
>>>>>> On 4 Mar 2019, at 10.05, Hans Holmberg
>>>>>> <hans.ml.holmberg@owltronix.com> wrote:
>>>>>>
>>>>>> I strongly disagree with adding code that would mask implantation
>>>>>> errors.
>>>>>>
>>>>>> If we want more internal checks, we could add an if statement that
>>>>>> would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
>>>>>>
>>>>>
>>>>> Not sure who this is for - better not to top post.
>>>>>
>>>>> In any case, this is a spec grey zone. I’m ok with cleaning the bits as
>>>>> they mean nothing for the reset command. If you feel that strongly about
>>>>> this, you can take if with Igor.
>>>>
>>>> Pardon the top-post. It was meant for both you and Igor.
>>>>
>>>
>>> OCSSD 2.0 spec for vector chunk reset (chapter 2.2.2) explicitly says
>>> "The addresses in the LBA list shall be the first logical block address
>>> of each chunk to be reset.". So in my understanding we suppose to clear
>>> the sectors bits of the PPA address in order to be spec compliant.
>>>
>>
>> Agree. And since ppa_addr is allocated on the stack, it should be either
>> memset or the remaining fields should be set to 0. Maybe better to zero
>> initialize in declaration?
> 
> Ah, I thought this was not needed, as ppa is initialized as:
> 
> ppa = pblk->luns[bit].bppa; /* set ch and lun */
> 
> and luns[bit].bppa is initialized to on a value that originally comes
> from drivers/lightnvm/core.c:196
> (and that's explicitly zeroing all 64 bits before setting ch and lun)
> 
> Let me know if i don't make sense here.
> 

I just noticed the same.

In two places (pblk-core:1095 and pblk-map:205) we are using values 
initialized previously in core.c - so my changes are not needed here.

But still there is one place (pblk-map:163) where we initializing 
erase_ppa based on ppa_list[i], which has PPA sector set in most of the 
cases, so this zeroing is still needed here.

>>
>>>>>
>>>>>>
>>>>>> On Mon, Mar 4, 2019 at 8:48 AM Javier González <javier@javigon.com>
>>>>>> wrote:
>>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>> In current pblk implementation of erase command
>>>>>>>> there is a chance tha sector bits are set to some
>>>>>>>> random values for erase PPA. This is unexpected
>>>>>>>> situation, since erase shall be always chunk
>>>>>>>> aligned. This patch fixes that issue
>>>>>>>>
>>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>>> ---
>>>>>>>> drivers/lightnvm/pblk-core.c | 1 +
>>>>>>>> drivers/lightnvm/pblk-map.c  | 2 ++
>>>>>>>> 2 files changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/lightnvm/pblk-core.c
>>>>>>>> b/drivers/lightnvm/pblk-core.c
>>>>>>>> index a98b2255f963..78b1eea4ab67 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>>>>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct
>>>>>>>> pblk_line *line)
>>>>>>>>
>>>>>>>>                ppa = pblk->luns[bit].bppa; /* set ch and lun */
>>>>>>>>                ppa.a.blk = line->id;
>>>>>>>> +             ppa.a.reserved = 0;
>>>>>>>>
>>>>>>>>                atomic_dec(&line->left_eblks);
>>>>>>>>                WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
>>>>>>>> diff --git a/drivers/lightnvm/pblk-map.c
>>>>>>>> b/drivers/lightnvm/pblk-map.c
>>>>>>>> index 79df583ea709..aea46b4ec40f 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-map.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-map.c
>>>>>>>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk,
>>>>>>>> struct nvm_rq *rqd,
>>>>>>>>
>>>>>>>>                        *erase_ppa = ppa_list[i];
>>>>>>>>                        erase_ppa->a.blk = e_line->id;
>>>>>>>> +                     erase_ppa->a.reserved = 0;
>>>>>>>>
>>>>>>>>                        spin_unlock(&e_line->lock);
>>>>>>>>
>>>>>>>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk,
>>>>>>>> struct nvm_rq *rqd,
>>>>>>>>                atomic_dec(&e_line->left_eblks);
>>>>>>>>                *erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
>>>>>>>>                erase_ppa->a.blk = e_line->id;
>>>>>>>> +             erase_ppa->a.reserved = 0;
>>>>>>>>        }
>>>>>>>>
>>>>>>>>        return 0;
>>>>>>>> --
>>>>>>>> 2.17.1
>>>>>>>
>>>>>>> I’m fine with adding this, but note that there is actually no
>>>>>>> requirement for the erase to be chunk aligned - the only bits that
>>>>>>> should be looked at are group, PU and chunk.
>>>>>>>
>>>>>>> Reviewed-by: Javier González <javier@javigon.com>
>>

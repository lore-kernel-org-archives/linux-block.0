Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26441 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934880AbeFRUuW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jun 2018 16:50:22 -0400
Subject: Re: [PATCH 2/5] lightnvm: pblk: Remove resv field for sec meta
To: Javier Gonzalez <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "michal.sorn@intel.com" <michal.sorn@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>
References: <20180615222706.3801-1-igor.j.konopko@intel.com>
 <20180615222706.3801-3-igor.j.konopko@intel.com>
 <c3723e66-9183-6ee3-c780-06e4f012a844@lightnvm.io>
 <40AA2413-9E0B-4079-AE14-703902324CF5@cnexlabs.com>
From: Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <d1dbd70b-7f2b-33a7-7e92-771ee0088599@intel.com>
Date: Mon, 18 Jun 2018 13:50:21 -0700
MIME-Version: 1.0
In-Reply-To: <40AA2413-9E0B-4079-AE14-703902324CF5@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 18.06.2018 07:25, Javier Gonzalez wrote:
>> On 16 Jun 2018, at 21.27, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 06/16/2018 12:27 AM, Igor Konopko wrote:
>>> Since we have flexible size of pblk_sec_meta
>>> which depends on drive metadata size we can
>>> remove not needed reserved field from that
>>> structure
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>>   drivers/lightnvm/pblk.h | 1 -
>>>   1 file changed, 1 deletion(-)
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index f82c3a0b0de5..27658dc6fc1a 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -82,7 +82,6 @@ enum {
>>>   };
>>>     struct pblk_sec_meta {
>>> -	u64 reserved;
>>>   	__le64 lba;
>>>   };
>>>
>>
>> Looks good to me. Javier may have some comment on this, since it is
>> not completely obvious from the code why that reserved attribute is
>> there. I do like the change to go in, as it needlessly extends the
>> requirement from 8 to 16bytes.
> 
> Looks good to me. Maybe marge this patch with 1/5? It was actually a
> comment I added to it.
> 

Sure, can merge it.

Igor

Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45536C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 09:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F920873
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 09:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfEBJIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 05:08:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:3307 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfEBJIR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 May 2019 05:08:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 02:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="136182103"
Received: from ikonopko-mobl.ger.corp.intel.com (HELO [10.237.142.30]) ([10.237.142.30])
  by orsmga007.jf.intel.com with ESMTP; 02 May 2019 02:08:15 -0700
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
To:     Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190425052152.6571-1-hlitz@ucsc.edu>
 <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com>
 <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
 <CAJbgVnWsHQRpEPkd77E6u0hoW5jKQaOGR-3dW9+drGNq_JYpfA@mail.gmail.com>
 <139AF16B-E69C-4AA5-A9AC-38576BB9BD4B@javigon.com>
 <CAJbgVnWTRWZB_Dc7F1cvtgWdYPCbJ_aJJ_mas01m51+8siHvHA@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <b7c03f26-90bb-ffd6-e744-6daf3bbe348d@intel.com>
Date:   Thu, 2 May 2019 11:08:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWTRWZB_Dc7F1cvtgWdYPCbJ_aJJ_mas01m51+8siHvHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 01.05.2019 22:20, Heiner Litz wrote:
> Javier, Igor,
> you are correct. The problem exists if we have a power loss and we
> have an open gc and an open user line and both contain the same LBA.
> In that case, I think we need to care about the 4 scenarios:
> 
> 1. user_seq_id > gc_seq_id and user_write after gc_write: No issue
> 2. user_seq_id > gc_seq_id and gc_write > user_write: Cannot happen,
> open user lines are not gc'ed

Maybe it would be just a theoretical scenario, but I'm not seeing any 
reason why this cannot happen in pblk implementation:
Let assume that user line X+1 is opened when GC line X is already open 
and the user line is closed when GC line X is still in use. Then GC 
quickly choose user line X+1 as a GC victim and we are hitting 2nd case.

> 3. gc_seq_id > user_seq_id and user_write after gc_write: RACE
> 4. gc_seq_id > user_seq_id and gc_write after user_write: No issue
> 
> To address 3.) we can do the following:
> Whenever a gc line is opened, determine all open user lines and store
> them in a field of pblk_line. When choosing a victim for GC, ignore
> those lines.

Your solution sounds right, but I would extend this based on my previous 
comment to 2nd case by sth like: during opening new user data also add 
this line ID to this "blacklist" for the GC selection.

Igor

> 
> Let me know if that sounds good and I will send a v2
> Heiner
> 
> On Tue, Apr 30, 2019 at 11:19 PM Javier González <javier@javigon.com> wrote:
>>
>>> On 26 Apr 2019, at 18.23, Heiner Litz <hlitz@ucsc.edu> wrote:
>>>
>>> Nice catch Igor, I hadn't thought of that.
>>>
>>> Nevertheless, here is what I think: In the absence of a flush we don't
>>> need to enforce ordering so we don't care about recovering the older
>>> gc'ed write. If we completed a flush after the user write, we should
>>> have already invalidated the gc mapping and hence will not recover it.
>>> Let me know if I am missing something.
>>
>> I think that this problem is orthogonal to a flush on the user path. For example
>>
>>     - Write to LBA0 + completion to host
>>     - […]
>>     - GC LBA0
>>     - Write to LBA0 + completion to host
>>     - fsync() + completion
>>     - Power Failure
>>
>> When we power up and do recovery in the current implementation, you
>> might get the old LBA0 mapped correctly in the L2P table.
>>
>> If we enforce ID ordering for GC lines this problem goes away as we can
>> continue ordering lines based on ID and then recovering sequentially.
>>
>> Thoughts?
>>
>> Thanks,
>> Javier
>>
>>>
>>> On Fri, Apr 26, 2019 at 6:46 AM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>> On 26.04.2019 12:04, Javier González wrote:
>>>>>> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>>
>>>>>> On 25.04.2019 07:21, Heiner Litz wrote:
>>>>>>> Introduce the capability to manage multiple open lines. Maintain one line
>>>>>>> for user writes (hot) and a second line for gc writes (cold). As user and
>>>>>>> gc writes still utilize a shared ring buffer, in rare cases a multi-sector
>>>>>>> write will contain both gc and user data. This is acceptable, as on a
>>>>>>> tested SSD with minimum write size of 64KB, less than 1% of all writes
>>>>>>> contain both hot and cold sectors.
>>>>>>
>>>>>> Hi Heiner
>>>>>>
>>>>>> Generally I really like this changes, I was thinking about sth similar since a while, so it is very good to see that patch.
>>>>>>
>>>>>> I have a one question related to this patch, since it is not very clear for me - how you ensure the data integrity in following scenarios:
>>>>>> -we have open line X for user data and line Y for GC
>>>>>> -GC writes LBA=N to line Y
>>>>>> -user writes LBA=N to line X
>>>>>> -we have power failure when both line X and Y were not written completely
>>>>>> -during pblk creation we are executing OOB metadata recovery
>>>>>> And here is the question, how we distinguish whether LBA=N from line Y or LBA=N from line X is the valid one?
>>>>>> Line X and Y might have seq_id either descending or ascending - this would create two possible scenarios too.
>>>>>>
>>>>>> Thanks
>>>>>> Igor
>>>>>
>>>>> You are right, I think this is possible in the current implementation.
>>>>>
>>>>> We need an extra constrain so that we only GC lines above the GC line
>>>>> ID. This way, when we order lines on recovery, we can guarantee
>>>>> consistency. This means potentially that we would need several open
>>>>> lines for GC to avoid padding in case this constrain forces to choose a
>>>>> line with an ID higher than the GC line ID.
>>>>>
>>>>> What do you think?
>>>>
>>>> I'm not sure yet about your approach, I need to think and analyze this a
>>>> little more.
>>>>
>>>> I also believe that probably we need to ensure that current user data
>>>> line seq_id is always above the current GC line seq_id or sth like that.
>>>> We cannot also then GC any data from the lines which are still open, but
>>>> I believe that this is a case even right now.
>>>>
>>>>> Thanks,
>>>>> Javier

Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E48C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C915206E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 13:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDZNql (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:46:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:38269 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfDZNql (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 09:46:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 06:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="153986651"
Received: from ikonopko-mobl.ger.corp.intel.com (HELO [10.237.142.109]) ([10.237.142.109])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2019 06:46:39 -0700
Subject: Re: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190425052152.6571-1-hlitz@ucsc.edu>
 <66434cc7-2bac-dd10-6edc-4560e6a0f89f@intel.com>
 <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <a1df8967-2169-1c43-c55a-e2144fa53b9a@intel.com>
Date:   Fri, 26 Apr 2019 15:46:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <F305CAB7-F566-40D7-BC91-E88DE821520B@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 26.04.2019 12:04, Javier González wrote:
> 
>> On 26 Apr 2019, at 11.11, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> On 25.04.2019 07:21, Heiner Litz wrote:
>>> Introduce the capability to manage multiple open lines. Maintain one line
>>> for user writes (hot) and a second line for gc writes (cold). As user and
>>> gc writes still utilize a shared ring buffer, in rare cases a multi-sector
>>> write will contain both gc and user data. This is acceptable, as on a
>>> tested SSD with minimum write size of 64KB, less than 1% of all writes
>>> contain both hot and cold sectors.
>>
>> Hi Heiner
>>
>> Generally I really like this changes, I was thinking about sth similar since a while, so it is very good to see that patch.
>>
>> I have a one question related to this patch, since it is not very clear for me - how you ensure the data integrity in following scenarios:
>> -we have open line X for user data and line Y for GC
>> -GC writes LBA=N to line Y
>> -user writes LBA=N to line X
>> -we have power failure when both line X and Y were not written completely
>> -during pblk creation we are executing OOB metadata recovery
>> And here is the question, how we distinguish whether LBA=N from line Y or LBA=N from line X is the valid one?
>> Line X and Y might have seq_id either descending or ascending - this would create two possible scenarios too.
>>
>> Thanks
>> Igor
>>
> 
> You are right, I think this is possible in the current implementation.
> 
> We need an extra constrain so that we only GC lines above the GC line
> ID. This way, when we order lines on recovery, we can guarantee
> consistency. This means potentially that we would need several open
> lines for GC to avoid padding in case this constrain forces to choose a
> line with an ID higher than the GC line ID.
> 
> What do you think?

I'm not sure yet about your approach, I need to think and analyze this a 
little more.

I also believe that probably we need to ensure that current user data 
line seq_id is always above the current GC line seq_id or sth like that. 
We cannot also then GC any data from the lines which are still open, but 
I believe that this is a case even right now.

> 
> Thanks,
> Javier
> 

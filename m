Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53FDC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4692075E
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 10:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEBKDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 06:03:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:40232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEBKDK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 May 2019 06:03:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 03:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="166849674"
Received: from ikonopko-mobl.ger.corp.intel.com (HELO [10.237.142.30]) ([10.237.142.30])
  by fmsmga002.fm.intel.com with ESMTP; 02 May 2019 03:03:08 -0700
Subject: Re: [PATCH v5 0/3] lightnvm: next set of improvements for 5.2
To:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org
References: <20190426133513.23966-1-igor.j.konopko@intel.com>
 <087e8d6e-8cdc-87ff-6e2f-cb1fa2fd0396@lightnvm.io>
 <CANr-nt0c-4H5PfaH=b-CPrLbMhs=r4skr-oskOGQsyNB=gOMug@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <cc51f4ad-ba78-ed2b-ca4b-a028ab99b271@intel.com>
Date:   Thu, 2 May 2019 12:03:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0c-4H5PfaH=b-CPrLbMhs=r4skr-oskOGQsyNB=gOMug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 29.04.2019 13:13, Hans Holmberg wrote:
> On Fri, Apr 26, 2019 at 3:54 PM Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> Thanks Igor. I've picked up 1 + 2.
>>
>> The third I'm still noodling on. I think maybe one should bump the disk
>> format, since it's changed. Also, if it is, it should be a static setup
>> (i.e., 1,2,3), and not user configurable. Although, I do expect the
>> separate parallel units to have enough device-side redundancy to provide
>> adequate UBER.
> 
> The change is backwards- and forwards-compatible (a disk written with
> both an older and a newer
> kernel would be readable, since smeta sectors are marked as ADD_EMPTY)
>   as far as I can tell,
> buy did you test this Igor?

It suppose to work, but I didn't test such a scenario. Generally this 
patch is not so crucial for now, so I can tune it up for 5.3 maybe.
> 
> I think we might as well bump SMETA_VERSION_MINOR anyway, so we can keep
> track of this format change for the future(i.e if we build an offline
> recovery tool)
> 
> Thanks,
> Hans
>>
>>
>>
>> On 4/26/19 3:35 PM, Igor Konopko wrote:
>>> This is another set of fixes and improvements to both pblk and lightnvm
>>> core.
>>>
>>> Changes v4 -> v5:
>>> -dropped patches which were already pulled into for-5.2/core branch
>>> -rebasing of other patches
>>> -multiple copies of smeta patch moved into last position in series
>>> so it would be easier to pull only previous patches if needed
>>>
>>> Changes v3 -> v4:
>>> -dropped patches which were already pulled into for-5.2/core branch
>>> -major changes for patch #2 based on code review
>>> -patch #6 modified to use krefs
>>> -new patch #7 which extends the patch #6
>>>
>>> Changes v2 -> v3:
>>> -dropped some not needed patches
>>> -dropped patches which were already pulled into for-5.2/core branch
>>> -commit messages cleanup
>>>
>>> Changes v1 -> v2:
>>> -dropped some not needed patches
>>> -review feedback incorporated for some of the patches
>>> -partial read path changes patch splited into two patches
>>>
>>>
>>> Igor Konopko (3):
>>>     lightnvm: pblk: simplify partial read path
>>>     lightnvm: pblk: use nvm_rq_to_ppa_list()
>>>     lightnvm: pblk: store multiple copies of smeta
>>>
>>>    drivers/lightnvm/pblk-core.c     | 159 ++++++++++++++----
>>>    drivers/lightnvm/pblk-init.c     |  23 ++-
>>>    drivers/lightnvm/pblk-rb.c       |  11 +-
>>>    drivers/lightnvm/pblk-read.c     | 339 ++++++++++-----------------------------
>>>    drivers/lightnvm/pblk-recovery.c |  27 ++--
>>>    drivers/lightnvm/pblk-rl.c       |   3 +-
>>>    drivers/lightnvm/pblk.h          |  19 +--
>>>    7 files changed, 252 insertions(+), 329 deletions(-)
>>>
>>

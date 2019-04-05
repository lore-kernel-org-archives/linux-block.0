Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B89C4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 06:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3138217D4
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 06:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfDEGbX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:31:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:63146 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfDEGbX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 02:31:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 23:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; 
   d="scan'208";a="140183673"
Received: from ssayana-mobl.ger.corp.intel.com (HELO [10.249.46.55]) ([10.249.46.55])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2019 23:31:20 -0700
Subject: Re: [PATCH v3 00/10] lightnvm: next set of improvements for 5.2
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
 <CANr-nt0d7DJ_-gYPKiJXBAUopSTATXVM7X5_=BeqDH-dZq-A8Q@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <302dd514-2b52-6669-0764-5b91c22704df@intel.com>
Date:   Fri, 5 Apr 2019 08:31:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CANr-nt0d7DJ_-gYPKiJXBAUopSTATXVM7X5_=BeqDH-dZq-A8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03.04.2019 09:12, Hans Holmberg wrote:
> On Wed, Mar 27, 2019 at 1:41 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> This is another set of fixes and improvements to both pblk and lightnvm
>> core.
>>
>> First & second patches are the most crutial, since they changes the approach
>> to the partial read path, so detailed review is needed especially here.
>>
>> Other patches are my other findings related to some bugs or potential
>> improvements, mostly related to some corner cases.
>>
>> Changes v2 -> v3;
>> -dropped some not needed patches
>> -dropped patches which were already pulled into for-5.2/core branch
>> -commit messages cleanup
>>
>> Changes v1 -> v2:
>> -dropped some not needed patches
>> -review feedback incorporated for some of the patches
>> -partial read path changes patch splitted into two patches
>>
> 
> Hi Igor,
> 
> I ran the quick xfstests and generic/247 hangs with this patchset on qemu:
> 
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 u1804-qatd 5.0.0-rc6_for-5.2/core_igor_v3
> 
> generic/247 95s ...
> <hang>
> 
> Note: If i run it with Matias 5.2 core branch with my biovec fix, it
> completes successfully, but with this in dmesg:
> 
> [  358.028158] Page cache invalidation failure on direct I/O.
> Possible data corruption due to collision with buffered I/O!
> [  358.030768] File: /mnt/247 PID: 4431 Comm: dd
> 
> (I have not looked into that any further)
> 

Thanks Hans for testing that and reporting back. Will definitely look 
into that and resubmit when fixed.
Igor

> Best regards,
> Hans
> 
> 
>> Igor Konopko (10):
>>    lightnvm: pblk: IO path reorganization
>>    lightnvm: pblk: simplify partial read path
>>    lightnvm: pblk: propagate errors when reading meta
>>    lightnvm: pblk: recover only written metadata
>>    lightnvm: pblk: wait for inflight IOs in recovery
>>    lightnvm: pblk: remove internal IO timeout
>>    lightnvm: pblk: store multiple copies of smeta
>>    lightnvm: pblk: GC error handling
>>    lightnvm: pblk: use nvm_rq_to_ppa_list()
>>    lightnvm: track inflight target creations
>>
>>   drivers/lightnvm/core.c          |  19 ++-
>>   drivers/lightnvm/pblk-cache.c    |   8 +-
>>   drivers/lightnvm/pblk-core.c     | 179 +++++++++++++++++----
>>   drivers/lightnvm/pblk-gc.c       |   5 +-
>>   drivers/lightnvm/pblk-init.c     |  37 +++--
>>   drivers/lightnvm/pblk-read.c     | 336 +++++++++++----------------------------
>>   drivers/lightnvm/pblk-recovery.c |  69 ++++----
>>   drivers/lightnvm/pblk-rl.c       |   3 +-
>>   drivers/lightnvm/pblk.h          |  31 ++--
>>   include/linux/lightnvm.h         |   2 +
>>   10 files changed, 343 insertions(+), 346 deletions(-)
>>
>> --
>> 2.9.5
>>

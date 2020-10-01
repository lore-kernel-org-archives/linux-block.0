Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC7C47420
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649BF21707
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 07:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgJAHDc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:03:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:4236 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbgJAHDb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 03:03:31 -0400
IronPort-SDR: m9uhc6p3nb7haiZMambYtucL7Cs7CopoWiarARH7fYszyG6FcfcAZs7Yka1DAJWPCOhiaeqHlx
 WiH1JK1LlQxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="150432178"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="150432178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 00:03:28 -0700
IronPort-SDR: gwm++hiDFy9+iEO+P2oYXrYRgBmdazSUgOiEJatzVlmjyMNOKQquYlBxzWq6atxzGjtNbS00/X
 1ePdxBsE7tLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="457999882"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2020 00:03:23 -0700
Subject: Re: [PATCH] mmc: core: don't set limits.discard_granularity as 0
To:     Coly Li <colyli@suse.de>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20200930160854.65710-1-colyli@suse.de>
 <5178b9e0-6b95-45ef-80f1-862de554e625@intel.com>
 <026e4bab-5d1d-50b9-29c4-e871fcd27b8b@suse.de>
 <3cc59ace-d4b5-d10b-05a0-8677c95515ff@intel.com>
 <2dad99ac-ae48-09a3-ed3b-c021214d7951@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <794af2df-3bd7-43c2-e5ff-9453cba1d424@intel.com>
Date:   Thu, 1 Oct 2020 10:02:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2dad99ac-ae48-09a3-ed3b-c021214d7951@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/20 9:29 am, Coly Li wrote:
> On 2020/10/1 14:14, Adrian Hunter wrote:
>> On 1/10/20 7:36 am, Coly Li wrote:
>>> On 2020/10/1 01:23, Adrian Hunter wrote:
>>>> On 30/09/20 7:08 pm, Coly Li wrote:
>>>>> In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
>>>>> might be set as 0 (when card->pref_erase > max_discard) while the mmc
>>>>> device still declares to support discard operation. This is buggy and
>>>>> triggered the following kernel warning message,
>>>>>
>>>>> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
>>>>> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
>>>>> Hardware name: Google Kevin (DT)
>>>>> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
>>>>> pc : __blkdev_issue_discard+0x200/0x294
>>>>> lr : __blkdev_issue_discard+0x54/0x294
>>>>> sp : ffff800011dd3b10
>>>>> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f1926400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 : 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
>>>>> __blkdev_issue_discard+0x200/0x294
>>>>> __submit_discard_cmd+0x128/0x374
>>>>> __issue_discard_cmd_orderly+0x188/0x244
>>>>> __issue_discard_cmd+0x2e8/0x33c
>>>>> issue_discard_thread+0xe8/0x2f0
>>>>> kthread+0x11c/0x120
>>>>> ret_from_fork+0x10/0x1c
>>>>> ---[ end trace e4c8023d33dfe77a ]---
>>>>>
>>>>> This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
>>>>> instead of 0 when (card->pref_erase > max_discard) is true. Now no more
>>>>> complain from __blkdev_issue_discard() for the improper value of discard
>>>>> granularity.
>>>>>
>>>>> Fixes: commit e056a1b5b67b ("mmc: queue: let host controllers specify maximum discard timeout")
>>>>
>>>> That "Fixes" tag is a bit misleading.  For some time, the block layer had
>>>> no problem with discard_granularity of zero, and blk_bio_discard_split()
>>>> still doesn't (see below).
>>>>
>>>> static struct bio *blk_bio_discard_split(struct request_queue *q,
>>>> 					 struct bio *bio,
>>>> 					 struct bio_set *bs,
>>>> 					 unsigned *nsegs)
>>>> {
>>>> 	unsigned int max_discard_sectors, granularity;
>>>> 	int alignment;
>>>> 	sector_t tmp;
>>>> 	unsigned split_sectors;
>>>>
>>>> 	*nsegs = 1;
>>>>
>>>> 	/* Zero-sector (unknown) and one-sector granularities are the same.  */
>>>> 	granularity = max(q->limits.discard_granularity >> 9, 1U);
>>>>
>>>
>>> >From Documentation/block/queue-sysfs.rst, the discard_granularity is
>>> described as,
>>>
>>> discard_granularity (RO)
>>> ------------------------
>>> This shows the size of internal allocation of the device in bytes, if
>>> reported by the device. A value of '0' means device does not support
>>> the discard functionality.
>>>
>>>
>>> And from Documentation/ABI/testing/sysfs-block, the discard_granularity
>>> is described as,
>>>
>>> What:           /sys/block/<disk>/queue/discard_granularity
>>> Date:           May 2011
>>> Contact:        Martin K. Petersen <martin.petersen@oracle.com>
>>> Description:
>>>                 Devices that support discard functionality may
>>>                 internally allocate space using units that are bigger
>>>                 than the logical block size. The discard_granularity
>>>                 parameter indicates the size of the internal allocation
>>>                 unit in bytes if reported by the device. Otherwise the
>>>                 discard_granularity will be set to match the device's
>>>                 physical block size. A discard_granularity of 0 means
>>>                 that the device does not support discard functionality.
>>>
>>>
>>> Therefore I took it as a bug when a driver sets its queue
>>> discard_granularity as 0 but still announces to support discard operation.
>>>
>>> But if you don't like the Fixes: tag, it is OK for me to remove it in
>>> next version.
>>
>> Not at all.  I just wrote "a bit misleading" because people might also want
>> to know from what patch things stopped working.
> 
> Oh maybe I understand you. Yes, although this fixed patch was bug, but
> the warning was triggered since the new discard alignment changes got
> merged.
> 
> Hmm, maybe I should add the Fixes tag to commit b35fd7422c2f ("block:
> check queue's limits.discard_granularity in __blkdev_issue_discard()").
> 
> How do you think of this commit id ?

Yes that could be mentioned in the commit message or Fixes or both.
With that:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>



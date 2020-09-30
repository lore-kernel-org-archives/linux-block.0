Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23BC4727E
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE04207F7
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 10:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3KtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 06:49:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:21934 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3KtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 06:49:14 -0400
IronPort-SDR: Lrb1qldQTy32GZDkTCJhl8TyxzREPKZ0SXhShojRwFLQlKImNmWVCJq7R5cdOBNvZPFzaUOdbd
 QV75KLuCr2cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="142430931"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="142430931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 03:49:13 -0700
IronPort-SDR: TsKFdgTsgr+ChlO3qd3ZuVPjETFCcfg8jX3vNKMTCOxqnmcKFIbdJ+jwbrGeK5MMcd069zEojf
 0xeuapz3te9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457608168"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 03:49:10 -0700
Subject: Re: [BUG] discard_granularity is 0 on rk3399-gru-kevin
To:     Coly Li <colyli@suse.de>, Vicente Bergas <vicencb@gmail.com>,
        cjb@laptop.org
Cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <2438c500-eb41-4ae2-b890-83d287ad3bcd@gmail.com>
 <32986577-b2c2-98ac-1a30-28790414b25d@suse.de>
 <ba57d7a8-bafc-e06e-8ed2-87db4ff96904@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a2b74575-3899-8450-8d11-10d6524cfc41@intel.com>
Date:   Wed, 30 Sep 2020 13:48:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ba57d7a8-bafc-e06e-8ed2-87db4ff96904@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/09/20 8:02 am, Coly Li wrote:
> On 2020/9/28 11:15, Coly Li wrote:
>> On 2020/9/28 04:29, Vicente Bergas wrote:
>>> Hi,
>>> since recently the rk3399-gru-kevin is reporting the trace below.
>>> The issue has been uncovered by
>>>  b35fd7422c2f8e04496f5a770bd4e1a205414b3f
>>>  block: check queue's limits.discard_granularity in
>>> __blkdev_issue_discard()
>>
>> Hi Vicente,
>>
>> Thanks for the information. It seems the device with f2fs declares to
>> support DISCARD but don't initialize discard_granularity for its queue.
>>
>> Can I know which block driver is under f2fs ?
> 
> Maybe it is the mmc driver. A zero value discard_granularity is from the
> following commit:
> 
> commit e056a1b5b67b4e4bfad00bf143ab14f634777705
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Tue Jun 28 17:16:02 2011 +0300
> 
>     mmc: queue: let host controllers specify maximum discard timeout
> 
>     Some host controllers will not operate without a hardware
>     timeout that is limited in value.  However large discards
>     require large timeouts, so there needs to be a way to
>     specify the maximum discard size.
> 
>     A host controller driver may now specify the maximum discard
>     timeout possible so that max_discard_sectors can be calculated.
> 
>     However, for eMMC when the High Capacity Erase Group Size
>     is not in use, the timeout calculation depends on clock
>     rate which may change.  For that case Preferred Erase Size
>     is used instead.
> 
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
> 
> 
> Hi Adrian and Chris,
> 
> I am not familiar with mmc driver, therefore I won't provide a quick fix
> like this (which might probably wrong),
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct
> request_queue *q,
>         q->limits.discard_granularity = card->pref_erase << 9;
>         /* granularity must not be greater than max. discard */
>         if (card->pref_erase > max_discard)
> -               q->limits.discard_granularity = 0;
> +               q->limits.discard_granularity = SECTOR_SIZE;
>         if (mmc_can_secure_erase_trim(card))
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
> 
> 
> It is improper for a device driver to declare to support DISCARD but set
> queue's discard_granularity as 0.
> 
> Could you please to take a look for mmc_queue_setup_discard() ?

This should be OK.

> 
> Thanks in advance.
> 
> Coly Li
> 
> 
>>
>>>
>>> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
>>> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
>>> Hardware name: Google Kevin (DT)
>>> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
>>> pc : __blkdev_issue_discard+0x200/0x294
>>> lr : __blkdev_issue_discard+0x54/0x294
>>> sp : ffff800011dd3b10
>>> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26:
>>> ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23:
>>> ffff0000f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20:
>>> 0000000000000008 x19: 0000000000000000 x18: 0000000000000000 x17:
>>> 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14:
>>> 0000000000000394 x13: 0000000000000000 x12: 0000000000000000 x11:
>>> 0000000000000000 x10: 00000000000008b0 x9 : ffff800011dd3cb0 x8 :
>>> 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f1926400 x5 :
>>> ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 :
>>> 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
>>> __blkdev_issue_discard+0x200/0x294
>>> __submit_discard_cmd+0x128/0x374
>>> __issue_discard_cmd_orderly+0x188/0x244
>>> __issue_discard_cmd+0x2e8/0x33c
>>> issue_discard_thread+0xe8/0x2f0
>>> kthread+0x11c/0x120
>>> ret_from_fork+0x10/0x1c
>>> ---[ end trace e4c8023d33dfe77a ]---
>>> mmcblk1p2: Error: discard_granularity is 0.
>>> mmcblk1p2: Error: discard_granularity is 0.
>>> <last message repeated multiple times>
>>
> 


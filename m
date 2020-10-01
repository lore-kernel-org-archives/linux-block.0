Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE524C4727E
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 07:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC0421481
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 07:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAHNq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:13:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:5771 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAHNq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 03:13:46 -0400
IronPort-SDR: kpsAF4EyWg/u1ggPocHHqz6mmsFh5pRewCSkt0+StU7NsR6qXHBT2MtqVo+7rQms0nmhLAIZ1c
 3zEtJYvpG+tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="150433356"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="150433356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 00:13:46 -0700
IronPort-SDR: 8aN7VyV3EimkkLyP7R0V+fDmzOOxgeKmllxlDZNhDJF/YWM4MGOOV+Q5121rRPudnd/ZI6B6hr
 SU76V3G1sKrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="502072813"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2020 00:13:43 -0700
Subject: Re: [PATCH v2] mmc: core: don't set limits.discard_granularity as 0
To:     Coly Li <colyli@suse.de>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Vicente Bergas <vicencb@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20201001065914.24526-1-colyli@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e1c558b6-f33f-a4d6-64fc-ba157d4dcb83@intel.com>
Date:   Thu, 1 Oct 2020 10:13:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001065914.24526-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/20 9:59 am, Coly Li wrote:
> In mmc_queue_setup_discard() the mmc driver queue's discard_granularity
> might be set as 0 (when card->pref_erase > max_discard) while the mmc
> device still declares to support discard operation. This is buggy and
> triggered the following kernel warning message,
> 
> WARNING: CPU: 0 PID: 135 at __blkdev_issue_discard+0x200/0x294
> CPU: 0 PID: 135 Comm: f2fs_discard-17 Not tainted 5.9.0-rc6 #1
> Hardware name: Google Kevin (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO BTYPE=--)
> pc : __blkdev_issue_discard+0x200/0x294
> lr : __blkdev_issue_discard+0x54/0x294
> sp : ffff800011dd3b10
> x29: ffff800011dd3b10 x28: 0000000000000000 x27: ffff800011dd3cc4 x26: ffff800011dd3e18 x25: 000000000004e69b x24: 0000000000000c40 x23: ffff0000f1deaaf0 x22: ffff0000f2849200 x21: 00000000002734d8 x20: 0000000000000008 x19: 0000000000000000 x18: 0000000000000000 x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000 x14: 0000000000000394 x13: 0000000000000000 x12: 0000000000000000 x11: 0000000000000000 x10: 00000000000008b0 x9 : ffff800011dd3cb0 x8 : 000000000004e69b x7 : 0000000000000000 x6 : ffff0000f1926400 x5 : ffff0000f1940800 x4 : 0000000000000000 x3 : 0000000000000c40 x2 : 0000000000000008 x1 : 00000000002734d8 x0 : 0000000000000000 Call trace:
> __blkdev_issue_discard+0x200/0x294
> __submit_discard_cmd+0x128/0x374
> __issue_discard_cmd_orderly+0x188/0x244
> __issue_discard_cmd+0x2e8/0x33c
> issue_discard_thread+0xe8/0x2f0
> kthread+0x11c/0x120
> ret_from_fork+0x10/0x1c
> ---[ end trace e4c8023d33dfe77a ]---
> 
> This patch fixes the issue by setting discard_granularity as SECTOR_SIZE
> instead of 0 when (card->pref_erase > max_discard) is true. Now no more
> complain from __blkdev_issue_discard() for the improper value of discard
> granularity.
> 
> This issue is explored after commit b35fd7422c2f ("block: check queue's

explored -> exposed

> limits.discard_granularity in __blkdev_issue_discard()"), therefore add
> a "Fixes:" tag for the commit to make sure people won't miss this patch
> after applying the change of __blkdev_issue_discard().
> 
> Fixes: b35fd7422c2f ("block: check queue's limits.discard_granularity in __blkdev_issue_discard()").

I thought you would keep the other fixes tag also

> Reported-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog,
> v2, change commit id of the Fixes tag.
> v1, initial version.
> 
>  drivers/mmc/core/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 6c022ef0f84d..350d0cc4ee62 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>  	q->limits.discard_granularity = card->pref_erase << 9;
>  	/* granularity must not be greater than max. discard */
>  	if (card->pref_erase > max_discard)
> -		q->limits.discard_granularity = 0;
> +		q->limits.discard_granularity = SECTOR_SIZE;
>  	if (mmc_can_secure_erase_trim(card))
>  		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
> 


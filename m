Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CCC4360C
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3158A20872
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 08:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfJPI6i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:58:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388817AbfJPI6i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 04:58:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 18EE1BDB72AB2273BE37;
        Wed, 16 Oct 2019 16:58:36 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:58:33 +0800
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20191014015043.25029-1-ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
Date:   Wed, 16 Oct 2019 09:58:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191014015043.25029-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/10/2019 02:50, Ming Lei wrote:
> Hi,
>
> Thomas mentioned:
>     "
>      That was the constraint of managed interrupts from the very beginning:
>
>       The driver/subsystem has to quiesce the interrupt line and the associated
>       queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>       until it's restarted by the core when the CPU is plugged in again.
>     "
>
> But no drivers or blk-mq do that before one hctx becomes dead(all
> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>
> This patchset tries to address the issue by two stages:
>
> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>
> - mark the hctx as internal stopped, and drain all in-flight requests
> if the hctx is going to be dead.
>
> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead
>
> - steal bios from the request, and resubmit them via generic_make_request(),
> then these IO will be mapped to other live hctx for dispatch
>
> Please comment & review, thanks!
>
> John, I don't add your tested-by tag since V3 have some changes,
> and I appreciate if you may run your test on V3.

Hi Ming,

So I got around to doing some testing. The good news is that issue which 
we were experiencing in v3 series seems to have has gone away - alot 
more stable.

However, unfortunately, I did notice some SCSI timeouts:

15508.615074] CPU2: shutdown
[15508.617778] psci: CPU2 killed.
[15508.651220] CPU1: shutdown
[15508.653924] psci: CPU1 killed.
[15518.406229] sas: Enter sas_scsi_recover_host busy: 63 failed: 63
Jobs: 1 (f=1): [R] [0.0% done] [0[15518.412239] sas: sas_scsi_find_task: 
aborting task 0x00000000a7159744
KB/0KB/0KB /s] [0/0/0 iops] [eta [15518.421708] sas: 
sas_eh_handle_sas_errors: task 0x00000000a7159744 is done
[15518.431266] sas: sas_scsi_find_task: aborting task 0x00000000d39731eb
[15518.442539] sas: sas_eh_handle_sas_errors: task 0x00000000d39731eb is 
done
[15518.449407] sas: sas_scsi_find_task: aborting task 0x000000009f77c9bd
[15518.455899] sas: sas_eh_handle_sas_errors: task 0x000000009f77c9bd is 
done

A couple of things to note:
- I added some debug prints in blk_mq_hctx_drain_inflight_rqs() for when 
inflights rqs !=0, and I don't see them for this timeout
- 0 datarate reported from fio

I'll have a look...

Thanks,
John

>
> V4:
> 	- resubmit IOs in dispatch list in case that this hctx is dead
>
> V3:
> 	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
> 	- fix patch 4 for avoiding potential deadlock, as found by Hannes
>
> V2:
> 	- patch4 & patch 5 in V1 have been merged to block tree, so remove
> 	  them
> 	- address comments from John Garry and Minwoo
>
>
>
> Ming Lei (5):
>   blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
>   blk-mq: prepare for draining IO when hctx's all CPUs are offline
>   blk-mq: stop to handle IO and drain IO before hctx becomes dead
>   blk-mq: re-submit IO in case that hctx is dead
>   blk-mq: handle requests dispatched from IO scheduler in case that hctx
>     is dead
>
>  block/blk-mq-debugfs.c     |   2 +
>  block/blk-mq-tag.c         |   2 +-
>  block/blk-mq-tag.h         |   2 +
>  block/blk-mq.c             | 137 ++++++++++++++++++++++++++++++++++---
>  block/blk-mq.h             |   3 +-
>  drivers/block/loop.c       |   2 +-
>  drivers/md/dm-rq.c         |   2 +-
>  include/linux/blk-mq.h     |   5 ++
>  include/linux/cpuhotplug.h |   1 +
>  9 files changed, 141 insertions(+), 15 deletions(-)
>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>
>



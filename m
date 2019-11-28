Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA26C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FB32158A
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 01:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK1BJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:09:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbfK1BJa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 20:09:30 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DA17E9765A0C8A35A9DA;
        Thu, 28 Nov 2019 09:09:26 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 09:09:13 +0800
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20191014015043.25029-1-ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, John Garry <john.garry@huawei.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <b3d90798-484f-09f5-a22f-f3ed3701f0d4@hisilicon.com>
Date:   Thu, 28 Nov 2019 09:09:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191014015043.25029-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2019/10/14 9:50, Ming Lei 写道:
> Hi,
>
> Thomas mentioned:
>      "
>       That was the constraint of managed interrupts from the very beginning:
>      
>        The driver/subsystem has to quiesce the interrupt line and the associated
>        queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>        until it's restarted by the core when the CPU is plugged in again.
>      "
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

I tested those patchset with John's testcase, except dump_stack() in 
function __blk_mq_run_hw_queue() sometimes occurs  which don't
affect the function, it solves the CPU hotplug issue, so add tested-by 
for those patchset:

Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

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
>    blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
>    blk-mq: prepare for draining IO when hctx's all CPUs are offline
>    blk-mq: stop to handle IO and drain IO before hctx becomes dead
>    blk-mq: re-submit IO in case that hctx is dead
>    blk-mq: handle requests dispatched from IO scheduler in case that hctx
>      is dead
>
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |   2 +-
>   block/blk-mq-tag.h         |   2 +
>   block/blk-mq.c             | 137 ++++++++++++++++++++++++++++++++++---
>   block/blk-mq.h             |   3 +-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |   5 ++
>   include/linux/cpuhotplug.h |   1 +
>   9 files changed, 141 insertions(+), 15 deletions(-)
>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>
>



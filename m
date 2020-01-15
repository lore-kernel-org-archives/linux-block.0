Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE56C32771
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 17:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FE5214AF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAORAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:00:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgAORAp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 12:00:45 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0E4C86383B86AF809F22;
        Wed, 15 Jan 2020 17:00:43 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Jan 2020 17:00:42 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 17:00:42 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
Date:   Wed, 15 Jan 2020 17:00:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/01/2020 11:44, Ming Lei wrote:
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
> But no drivers or blk-mq do that before one hctx becomes inactive(all
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
> V5:
> 	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
> 	- re-factor code for re-submit requests in cpu dead hotplug handler
> 	- address requeue corner case
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

thanks Ming, we'll have a look at this new series and test it again.

John

> 
> Ming Lei (6):
>    blk-mq: add new state of BLK_MQ_S_INACTIVE
>    blk-mq: prepare for draining IO when hctx's all CPUs are offline
>    blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>    blk-mq: re-submit IO in case that hctx is inactive
>    blk-mq: handle requests dispatched from IO scheduler in case of
>      inactive hctx
>    block: deactivate hctx when all its CPUs are offline when running
>      queue
> 
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |   2 +-
>   block/blk-mq-tag.h         |   2 +
>   block/blk-mq.c             | 172 +++++++++++++++++++++++++++++++------
>   block/blk-mq.h             |   3 +-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |   6 ++
>   include/linux/cpuhotplug.h |   1 +
>   9 files changed, 163 insertions(+), 29 deletions(-)
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>
> 


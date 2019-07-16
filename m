Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14DBC76188
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 06:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70152145D
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 06:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfGPGyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:54:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbfGPGya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 02:54:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F125F11D33B56478A3DF;
        Tue, 16 Jul 2019 14:54:27 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 16 Jul 2019
 14:54:26 +0800
Subject: Re: [RFC PATCH 0/7] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190712024726.1227-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c2c83d98-2012-13af-ab46-5a28303c0f87@huawei.com>
Date:   Tue, 16 Jul 2019 14:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190712024726.1227-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.223.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 12/07/2019 10:47, Ming Lei Ð´µÀ:
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

Hi Ming,

FWIW, to me this series looks reasonable.

So you have plans to post an updated "[PATCH 0/9] blk-mq/scsi: convert 
private reply queue into blk_mq hw queue" then?

All the best,
John

> 
> Ming Lei (7):
>    blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
>    blk-mq: add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ
>    blk-mq: stop to handle IO before hctx's all CPUs become offline
>    blk-mq: add callback of .free_request
>    SCSI: implement .free_request callback
>    blk-mq: re-submit IO in case that hctx is dead
>    blk-mq: handle requests dispatched from IO scheduler in case that hctx
>      is dead
> 
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |   2 +-
>   block/blk-mq-tag.h         |   2 +
>   block/blk-mq.c             | 147 ++++++++++++++++++++++++++++++++++---
>   block/blk-mq.h             |   3 +-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   drivers/scsi/scsi_lib.c    |  13 ++++
>   include/linux/blk-mq.h     |  12 +++
>   include/linux/cpuhotplug.h |   1 +
>   10 files changed, 170 insertions(+), 16 deletions(-)
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>
> 
> 



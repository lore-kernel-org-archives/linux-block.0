Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C5C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3394F2078E
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 10:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTKaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:30:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2061 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbgDTKaM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 06:30:12 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B59AC2F1A95C45EC8AA4;
        Mon, 20 Apr 2020 11:30:10 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.108) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 20 Apr
 2020 11:30:09 +0100
Subject: Re: [PATCH V7 0/9] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200418030925.31996-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7d2c6b84-6d7b-4270-e5eb-e78575918c21@huawei.com>
Date:   Mon, 20 Apr 2020 11:29:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200418030925.31996-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.108]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/04/2020 04:09, Ming Lei wrote:
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
> Thanks John Garry for running lots of tests on arm64 with this patchset
> and co-working on investigating all kinds of issues.
> 
> Please comment & review, thanks!
> 
> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug

This is pretty solid now. I get no SCSI timeouts with my test script (at 
the bottom). Thanks to Ming for this.

Tested-by: John Garry <john.garry@huawei.com>

> 
> V7:
> 	- fix updating .nr_active in get_driver_tag
> 	- add hctx->cpumask check in cpuhp handler
> 	- only drain requests which tag is >= 0
> 	- pass more aggressive cpuhotplug&io test
> 
> V6:
> 	- simplify getting driver tag, so that we can drain in-flight
> 	  requests correctly without using synchronize_rcu()
> 	- handle re-submission of flush & passthrough request correctly
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
> Ming Lei (9):
>    blk-mq: mark blk_mq_get_driver_tag as static
>    blk-mq: assign rq->tag in blk_mq_get_driver_tag
>    blk-mq: prepare for draining IO when hctx's all CPUs are offline
>    blk-mq: support rq filter callback when iterating rqs
>    blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>    block: add blk_end_flush_machinery
>    blk-mq: re-submit IO in case that hctx is inactive
>    blk-mq: handle requests dispatched from IO scheduler in case of
>      inactive hctx
>    block: deactivate hctx when the hctx is actually inactive
> 
>   block/blk-flush.c          | 143 +++++++++++---
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |  39 ++--
>   block/blk-mq-tag.h         |   4 +
>   block/blk-mq.c             | 384 ++++++++++++++++++++++++++++++-------
>   block/blk-mq.h             |  25 ++-
>   block/blk.h                |   9 +-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |   6 +
>   include/linux/cpuhotplug.h |   1 +
>   11 files changed, 495 insertions(+), 122 deletions(-)
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> 

./enable_all.sh #enable cpu0-63

for((i = 0; i < 100 ; i++))
do
   echo "Looping ... number $i"
   ./create_fio_task_cpu.sh 4k read 2048 1  & # run fio over all cpus 
for 5x SAS disks
   echo "short sleep, then disable"
   sleep 5
   ./disable_all.sh #disable cpu1-60
   echo "long sleep $i"
   sleep 50
   echo "long sleep over number $i"
   ./enable_all.sh
   sleep 3
done

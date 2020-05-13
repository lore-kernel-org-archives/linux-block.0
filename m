Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4611C2D0F9
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76D020673
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 07:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgEMHe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 03:34:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730353AbgEMHe4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 03:34:56 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 60E0559CC7C969C9A2C3;
        Wed, 13 May 2020 08:34:54 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.35) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 08:34:53 +0100
Subject: Re: [PATCH V11 00/12] blk-mq: improvement CPU hotplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2b4b0a75-c9c0-27de-77e8-85ada602b18f@huawei.com>
Date:   Wed, 13 May 2020 08:34:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.35]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/05/2020 04:47, Ming Lei wrote:
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
> Thanks Christoph's review on V7 & V8.
> 
> Please consider it for v5.8.
> 
> https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug
> 
> V11:
> 	- drop new callback from blk_mq_all_tag_busy_iter, add new helper
> 	of blk_mq_all_tag_iter (5/12), as suggested by Bart
> 	- fix request allocation hang in case of queue freeze(11/12), as
> 	reported by Bart
> 
> V10:
> 	- fix double bio complete in request resubmission(10/11)
> 	- add tested-by tag
> 
> V9:
> 	- add Reviewed-by tag
> 	- document more on memory barrier usage between getting driver tag
> 	and handling cpu offline(7/11)
> 	- small code cleanup as suggested by Chritoph(7/11)
> 	- rebase against for-5.8/block(1/11, 2/11)
> V8:
> 	- add patches to share code with blk_rq_prep_clone
> 	- code re-organization as suggested by Christoph, most of them are
> 	in 04/11, 10/11
> 	- add reviewed-by tag
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
> *** BLURB HERE ***

:)

So my tested-by tags have been dropped. I'll test again, since the 
changes are non-trivial.

Tip commit of 
https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug 
at this moment is b55e97a4

> 
> Ming Lei (12):
>    block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
>    block: add helper for copying request
>    blk-mq: mark blk_mq_get_driver_tag as static
>    blk-mq: assign rq->tag in blk_mq_get_driver_tag
>    blk-mq: add blk_mq_all_tag_iter
>    blk-mq: prepare for draining IO when hctx's all CPUs are offline
>    blk-mq: stop to handle IO and drain IO before hctx becomes inactive
>    block: add blk_end_flush_machinery
>    blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
>    block: add request allocation flag of BLK_MQ_REQ_FORCE
>    blk-mq: re-submit IO in case that hctx is inactive
>    block: deactivate hctx when the hctx is actually inactive
> 
>   block/blk-core.c           |  32 +++-
>   block/blk-flush.c          | 141 ++++++++++++---
>   block/blk-mq-debugfs.c     |   2 +
>   block/blk-mq-tag.c         |  33 +++-
>   block/blk-mq-tag.h         |   2 +
>   block/blk-mq.c             | 356 +++++++++++++++++++++++++++++--------
>   block/blk-mq.h             |  22 ++-
>   block/blk.h                |  11 +-
>   drivers/block/loop.c       |   2 +-
>   drivers/md/dm-rq.c         |   2 +-
>   include/linux/blk-mq.h     |  14 ++
>   include/linux/cpuhotplug.h |   1 +
>   12 files changed, 494 insertions(+), 124 deletions(-)
> 


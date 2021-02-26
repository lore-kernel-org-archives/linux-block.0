Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB8FC433DB
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 03:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB7164EE3
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 03:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBZDwG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Feb 2021 22:52:06 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3452 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZDwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Feb 2021 22:52:05 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dmwdk1CVgz5WVw;
        Fri, 26 Feb 2021 11:49:46 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 11:51:22 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 11:51:17 +0800
Subject: Re: [PATCH V8 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "Christoph Hellwig" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20201020085555.1554255-1-ming.lei@redhat.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com>
Date:   Fri, 26 Feb 2021 11:51:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201020085555.1554255-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

About nvme_stop_queues need long times for large number namespaces,
If work with multipath and one path fails, It cause wait long times
to fail over to retry, and the more namespaces the longer the time.
This has a great impact on delay-sensitive services.
there are two options to fix it:
1. Use percpu instead of SRCU. Ming's patchset.
2. Use tagset quiesce interface with SRCU. Sagi's patchset.
The two patchsets are still pending.

It is a serious bug, I expect that we can revisit the solution.
Maybe we don't have the best option, but we need to choose a relatively
acceptable option.

Can we fix the bug for non-blocking queues(which used by fc&rdma) first?

Sagi & Ming, what do you think?
Thank you.

On 2020/10/20 16:55, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> V8:
> 	- rebase on latest linus tree, only there is small fuzz change on 2/4
> 
> V7:
> 	- base on latest for-5.10/block, only there is small change on 2/4
> 
> V6:
> 	- base on for-5.10/block directly, instead of being against on patchset of
> 	'percpu_ref & block: reduce memory footprint of percpu_ref in fast path',
> 	because these patches don't depend on that patchset.
> 
> V5:
> 	- warn once in case that driver unquiesces its queue being
> 	  quiesce and not done, only patch 2 is modified
> 
> V4:
> 	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
> 	avoiding duplicated quiesce action
> 	- pass blktests(block, nvme)
> 
> V3:
> 	- add tagset quiesce interface
> 	- apply tagset quiesce interface for NVMe
> 	- pass blktests(block, nvme)
> 
> V2:
> 	- add .mq_quiesce_lock
> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> 	- trivial patch style change
> 
> 
> Ming Lei (3):
>    block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
>    blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
>    blk-mq: add tagset quiesce interface
> 
> Sagi Grimberg (1):
>    nvme: use blk_mq_[un]quiesce_tagset
> 
>   block/blk-core.c         |  13 +++
>   block/blk-mq-sysfs.c     |   2 -
>   block/blk-mq.c           | 182 +++++++++++++++++++++++++--------------
>   block/blk-sysfs.c        |   6 +-
>   block/blk.h              |   2 +
>   drivers/nvme/host/core.c |  19 ++--
>   include/linux/blk-mq.h   |  10 +--
>   include/linux/blkdev.h   |   4 +
>   8 files changed, 154 insertions(+), 84 deletions(-)
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> 

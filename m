Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD3C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D96F613BE
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhDFIDJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:03:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2760 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbhDFIDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:03:05 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF0Fj3ft0z686lQ;
        Tue,  6 Apr 2021 15:55:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:02:50 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 09:02:50 +0100
Subject: Re: [PATCH v5 0/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210405002834.32339-1-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a4ffb3f0-414d-ba7b-db49-1660faa37873@huawei.com>
Date:   Tue, 6 Apr 2021 09:00:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210405002834.32339-1-bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/04/2021 01:28, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series fixes the race between iterating over requests and
> freeing requests that has been reported by multiple different users over
> the past two years. Please consider this patch series for kernel v5.13.
> 
> Thank you,
> 
> Bart.
> 
> Changes between v4 and v5:
> - Addressed Khazhy's review comments. Note: the changes that have been made
>    in v5 only change behavior in case CONFIG_PROVE_RCU=y.
> 
> Changes between v3 and v4:
> - Fixed support for tag sets shared across hardware queues.
> - Renamed blk_mq_wait_for_tag_readers() into blk_mq_wait_for_tag_iter().
> - Removed the fourth argument of blk_mq_queue_tag_busy_iter() again.
> 

Hi Bart,

> Changes between v2 and v3:
> - Converted the single v2 patch into a series of three patches.
> - Switched from SRCU to a combination of RCU and semaphores.
> 

But can you mention why we made to changes from v3 onwards (versus v2)?

The v2 patch just used SRCU as the sync mechanism, and the impression I 
got from Jens was that the marginal performance drop was tolerable. And 
the issues it tries to address seem to be solved. So why change? Maybe 
my impression of the performance drop being acceptable was wrong.

Thanks,
John

Ps. I have been on vacation for some time, so could not support this work.

> Changes between v1 and v2:
> - Reformatted patch description.
> - Added Tested-by/Reviewed-by tags.
> - Changed srcu_barrier() calls into synchronize_srcu() calls.
> 
> Bart Van Assche (3):
>    blk-mq: Move the elevator_exit() definition
>    blk-mq: Introduce atomic variants of the tag iteration functions
>    blk-mq: Fix a race between iterating over requests and freeing
>      requests
> 
>   block/blk-core.c          | 34 ++++++++++++++++-
>   block/blk-mq-tag.c        | 79 ++++++++++++++++++++++++++++++++++-----
>   block/blk-mq-tag.h        |  6 ++-
>   block/blk-mq.c            | 23 +++++++++---
>   block/blk-mq.h            |  1 +
>   block/blk.h               | 11 +-----
>   block/elevator.c          |  9 +++++
>   drivers/scsi/hosts.c      | 16 ++++----
>   drivers/scsi/ufs/ufshcd.c |  4 +-
>   include/linux/blk-mq.h    |  2 +
>   10 files changed, 149 insertions(+), 36 deletions(-)
> 
> .
> 


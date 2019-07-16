Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F5BC76191
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 02:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA852080A
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 02:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfGPCxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 22:53:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730712AbfGPCxJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 22:53:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C4F12D142B9E642D0495;
        Tue, 16 Jul 2019 10:53:06 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 16 Jul 2019
 10:53:01 +0800
Subject: Re: [RFC PATCH 2/7] blk-mq: add blk-mq flag of
 BLK_MQ_F_NO_MANAGED_IRQ
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190712024726.1227-1-ming.lei@redhat.com>
 <20190712024726.1227-3-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ce954a60-5a7a-a13d-b999-6f973a440d22@huawei.com>
Date:   Tue, 16 Jul 2019 10:53:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190712024726.1227-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.223.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 12/07/2019 10:47, Ming Lei Ð´µÀ:
> We will stop hw queue and wait for completion of in-flight requests
> when one hctx is becoming dead in the following patch. This way may
> cause dead-lock for some stacking blk-mq drivers, such as dm-rq and
> loop.
> 
> Add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ and mark it for dm-rq and
> loop, so we needn't to wait for completion of in-flight requests of
> dm-rq & loop, then the potential dead-lock can be avoided.

Wouldn't it make more sense to have the flag name be like 
BLK_MQ_F_DONT_DRAIN_STOPPED_HCTX?

I did not think that blk-mq is specifically concerned with managed 
interrupts, but only their indirect effect.

> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 1 +
>   drivers/block/loop.c   | 2 +-
>   drivers/md/dm-rq.c     | 2 +-
>   include/linux/blk-mq.h | 1 +
>   4 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index af40a02c46ee..24fff8c90942 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -240,6 +240,7 @@ static const char *const hctx_flag_name[] = {
>   	HCTX_FLAG_NAME(TAG_SHARED),
>   	HCTX_FLAG_NAME(BLOCKING),
>   	HCTX_FLAG_NAME(NO_SCHED),
> +	HCTX_FLAG_NAME(NO_MANAGED_IRQ),
>   };
>   #undef HCTX_FLAG_NAME
>   
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 44c9985f352a..199d76e8bf46 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1986,7 +1986,7 @@ static int loop_add(struct loop_device **l, int i)
>   	lo->tag_set.queue_depth = 128;
>   	lo->tag_set.numa_node = NUMA_NO_NODE;
>   	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
> -	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;

nit: at this point in the series you're setting a flag which is never 
checked.

>   	lo->tag_set.driver_data = lo;
>   
>   	err = blk_mq_alloc_tag_set(&lo->tag_set);
> diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> index 5f7063f05ae0..f7fbef2d3cd7 100644
> --- a/drivers/md/dm-rq.c
> +++ b/drivers/md/dm-rq.c
> @@ -546,7 +546,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
>   	md->tag_set->ops = &dm_mq_ops;
>   	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
>   	md->tag_set->numa_node = md->numa_node_id;
> -	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
> +	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
>   	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
>   	md->tag_set->driver_data = md;
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 3a731c3c0762..911cdc6479dc 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -219,6 +219,7 @@ struct blk_mq_ops {
>   enum {
>   	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
>   	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> +	BLK_MQ_F_NO_MANAGED_IRQ	= 1 << 2,
>   	BLK_MQ_F_BLOCKING	= 1 << 5,
>   	BLK_MQ_F_NO_SCHED	= 1 << 6,
>   	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> 



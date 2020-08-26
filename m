Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E045C433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 07:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F7420767
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 07:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgHZHva (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:51:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgHZHv3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 03:51:29 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id CD272D5685962F19D9EB;
        Wed, 26 Aug 2020 15:51:26 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 26 Aug 2020 15:51:26 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 26
 Aug 2020 15:51:26 +0800
Subject: Re: [PATCH V2 1/2] blk-mq: serialize queue quiesce and unquiesce by
 mutex
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20200825141734.115879-1-ming.lei@redhat.com>
 <20200825141734.115879-2-ming.lei@redhat.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <751a63a2-9185-ba27-e84a-91b7cdd33ee7@huawei.com>
Date:   Wed, 26 Aug 2020 15:51:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200825141734.115879-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It doesn't matter. Because the reentry of quiesce&unquiesce queue is not
safe, must be avoided by other mechanism. otherwise, exceptions may
occur. Introduce mq_quiesce_lock looks saving possible synchronization
waits, but it should not happen. If really happen, we need fix it.

On 2020/8/25 22:17, Ming Lei wrote:
> Add .mq_quiesce_mutext to request queue, so that queue quiesce and
> unquiesce can be serialized. Meantime we can avoid unnecessary
> synchronize_rcu() in case that queue has been quiesced already.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> ---
>   block/blk-core.c       |  2 ++
>   block/blk-mq.c         | 11 +++++++++++
>   include/linux/blkdev.h |  2 ++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d9d632639bd1..ffc57df70064 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -561,6 +561,8 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	init_waitqueue_head(&q->mq_freeze_wq);
>   	mutex_init(&q->mq_freeze_lock);
>   
> +	mutex_init(&q->mq_quiesce_lock);
> +
>   	/*
>   	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
>   	 * See blk_register_queue() for details.
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b3d2785eefe9..817e016ef886 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -224,6 +224,11 @@ void blk_mq_quiesce_queue(struct request_queue *q)
>   	unsigned int i;
>   	bool rcu = false;
>   
> +	mutex_lock(&q->mq_quiesce_lock);
> +
> +	if (blk_queue_quiesced(q))
> +		goto exit;
> +
>   	blk_mq_quiesce_queue_nowait(q);
>   
>   	queue_for_each_hw_ctx(q, hctx, i) {
> @@ -234,6 +239,8 @@ void blk_mq_quiesce_queue(struct request_queue *q)
>   	}
>   	if (rcu)
>   		synchronize_rcu();
> + exit:
> +	mutex_unlock(&q->mq_quiesce_lock);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>   
> @@ -246,10 +253,14 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>    */
>   void blk_mq_unquiesce_queue(struct request_queue *q)
>   {
> +	mutex_lock(&q->mq_quiesce_lock);
> +
>   	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>   
>   	/* dispatch requests which are inserted during quiescing */
>   	blk_mq_run_hw_queues(q, true);
> +
> +	mutex_unlock(&q->mq_quiesce_lock);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d8dba550ecac..5ed03066b33e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -569,6 +569,8 @@ struct request_queue {
>   	 */
>   	struct mutex		mq_freeze_lock;
>   
> +	struct mutex		mq_quiesce_lock;
> +
>   	struct blk_mq_tag_set	*tag_set;
>   	struct list_head	tag_set_list;
>   	struct bio_set		bio_split;
> 

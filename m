Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF5BC4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 02:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJUCtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJUCtp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:49:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1D2E699
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:49:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtpj53WtmzVj14;
        Fri, 21 Oct 2022 10:44:57 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:49:36 +0800
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <068e599b-cfba-6af3-8cf6-b5ed88cd49e7@huawei.com>
Date:   Fri, 21 Oct 2022 10:49:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an
> interface to quiesce all the queues on a given tagset. This interface is
> useful because it can speedup the quiesce by doing it in parallel.
> 
> Because some queues should not need to be quiesced(e.g. nvme connect_q)
> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
> tagset quiesce interface to skip the queue.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: simplify for the per-tag_set srcu_struct]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c         | 25 +++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   include/linux/blkdev.h |  3 +++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cf8f9f9a96c35..b0d2dd56bfdf2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -313,6 +313,31 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>   
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (!blk_queue_skip_tagset_quiesce(q))
> +			blk_mq_quiesce_queue_nowait(q);
> +	}
> +	blk_mq_wait_quiesce_done(set);
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
> +
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		blk_mq_unquiesce_queue(q);
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> +
>   void blk_mq_wake_waiters(struct request_queue *q)
>   {
>   	struct blk_mq_hw_ctx *hctx;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index dfd565c4fb84e..35747949f7739 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -882,6 +882,8 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>   void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>   void blk_mq_quiesce_queue(struct request_queue *q);
>   void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
>   void blk_mq_unquiesce_queue(struct request_queue *q);
>   void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
>   void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b15b6a011c028..854b4745cdd1f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -571,6 +571,7 @@ struct request_queue {
>   #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>   #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>   #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> +#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
>   
>   #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
>   				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
> @@ -610,6 +611,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>   #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
>   #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>   #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
> +#define blk_queue_skip_tagset_quiesce(q) \
> +	test_bit(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, &(q)->queue_flags)
>   
>   extern void blk_set_pm_only(struct request_queue *q);
>   extern void blk_clear_pm_only(struct request_queue *q);
> 

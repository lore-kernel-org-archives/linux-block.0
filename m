Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B1C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 15:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiCCPVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiCCPVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 10:21:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DBD19142A
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 07:20:56 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8ZQz07tSz67y8D;
        Thu,  3 Mar 2022 23:19:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 16:20:53 +0100
Received: from [10.47.84.129] (10.47.84.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Mar
 2022 15:20:52 +0000
Message-ID: <e5e7684c-9749-33c8-3d53-85eaa01a754a@huawei.com>
Date:   Thu, 3 Mar 2022 15:20:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V2 3/6] blk-mq: reconfigure poll after queue map is
 changed
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>
References: <20220302121407.1361401-1-ming.lei@redhat.com>
 <20220302121407.1361401-4-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220302121407.1361401-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.129]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/03/2022 12:14, Ming Lei wrote:
> queue map can be changed when updating nr_hw_queues, so we need to
> reconfigure queue's poll capability. Add one helper for doing this job.

nvme_mpath_alloc_disk() seems to have similar code to this helper, so 
maybe we can reuse this helper function there (obviously it would need 
to made public)

> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Regardless of comment:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   block/blk-mq.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 64fddb36c93c..57ae9df0f4dc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4010,6 +4010,17 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>   	mutex_unlock(&q->sysfs_lock);
>   }
>   
> +static void blk_mq_update_poll_flag(struct request_queue *q)
> +{
> +	struct blk_mq_tag_set *set = q->tag_set;
> +
> +	if (set->nr_maps > HCTX_TYPE_POLL &&
> +	    set->map[HCTX_TYPE_POLL].nr_queues)
> +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> +}
> +
>   int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   		struct request_queue *q)
>   {
> @@ -4044,9 +4055,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   	q->tag_set = set;
>   
>   	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
> -	if (set->nr_maps > HCTX_TYPE_POLL &&
> -	    set->map[HCTX_TYPE_POLL].nr_queues)
> -		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +	blk_mq_update_poll_flag(q);
>   
>   	INIT_DELAYED_WORK(&q->requeue_work, blk_mq_requeue_work);
>   	INIT_LIST_HEAD(&q->requeue_list);
> @@ -4512,6 +4521,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	blk_mq_update_queue_map(set);
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_realloc_hw_ctxs(set, q);
> +		blk_mq_update_poll_flag(q);
>   		if (q->nr_hw_queues != set->nr_hw_queues) {
>   			int i = prev_nr_hw_queues;
>   


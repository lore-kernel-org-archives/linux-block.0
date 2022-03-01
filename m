Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE086C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiCATUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiCATUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 14:20:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE1152E20
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 11:19:48 -0800 (PST)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K7Rqg4fMhz67ww1;
        Wed,  2 Mar 2022 03:18:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 20:19:45 +0100
Received: from [10.47.80.134] (10.47.80.134) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Mar
 2022 19:19:44 +0000
Message-ID: <45adf246-176a-b4a5-d973-4c885c37d821@huawei.com>
Date:   Tue, 1 Mar 2022 19:19:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-2-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220228090430.1064267-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.134]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/02/2022 09:04, Ming Lei wrote:
> The current code always uses default queue map and hw queue index
> for figuring out the numa node for hw queue, this way isn't correct
> because blk-mq supports three queue maps, and the correct queue map
> should be used for the specified hw queue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Hi Ming,

Just some small comments to consider if you need to respin.

Thanks,
John

>   block/blk-mq.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a05ce7725031..931add81813b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3107,15 +3107,41 @@ void blk_mq_free_rq_map(struct blk_mq_tags *tags)
>   	blk_mq_free_tags(tags);
>   }
>   
> +static int 

enum hctx_type?

> hctx_idx_to_type(struct blk_mq_tag_set *set,
> +		unsigned int hctx_idx)
> +{
> +	int j;

super nit: normally use i

> +
> +	for (j = 0; j < set->nr_maps; j++) {
> +		unsigned int start =  set->map[j].queue_offset;

nit: double whitespace intentional?

> +		unsigned int end = start + set->map[j].nr_queues;
> +
> +		if (hctx_idx >= start && hctx_idx < end)
> +			break;
> +	}
> +
> +	if (j >= set->nr_maps)
> +		j = HCTX_TYPE_DEFAULT;
> +
> +	return j;
> +}
> +
> +static int blk_mq_get_hctx_node(struct blk_mq_tag_set *set,
> +		unsigned int hctx_idx)
> +{
> +	int type = hctx_idx_to_type(set, hctx_idx);
> +
> +	return blk_mq_hw_queue_to_node(&set->map[type], hctx_idx);
> +}
> +
>   static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>   					       unsigned int hctx_idx,
>   					       unsigned int nr_tags,
>   					       unsigned int reserved_tags)
>   {
>   	struct blk_mq_tags *tags;
> -	int node;
> +	int node = blk_mq_get_hctx_node(set, hctx_idx);

nit: the code originally had reverse firtree ordering, which I suppose 
is not by mistake

>   
> -	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
>   	if (node == NUMA_NO_NODE)
>   		node = set->numa_node;
>   
> @@ -3165,9 +3191,8 @@ static int blk_mq_alloc_rqs(struct blk_mq_tag_set *set,
>   {
>   	unsigned int i, j, entries_per_page, max_order = 4;
>   	size_t rq_size, left;
> -	int node;
> +	int node = blk_mq_get_hctx_node(set, hctx_idx);

and here

>   
> -	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
>   	if (node == NUMA_NO_NODE)
>   		node = set->numa_node;
>   
> @@ -3941,10 +3966,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>   	/* protect against switching io scheduler  */
>   	mutex_lock(&q->sysfs_lock);
>   	for (i = 0; i < set->nr_hw_queues; i++) {
> -		int node;
> +		int node = blk_mq_get_hctx_node(set, i);
>   		struct blk_mq_hw_ctx *hctx;
>   
> -		node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], i);
>   		/*
>   		 * If the hw queue has been mapped to another numa node,
>   		 * we need to realloc the hctx. If allocation fails, fallback


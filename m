Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876BC433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2872074D
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 08:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHYI6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:58:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbgHYI6P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 04:58:15 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9BFDDC72BE6F3FAB2564;
        Tue, 25 Aug 2020 09:58:13 +0100 (IST)
Received: from [127.0.0.1] (10.47.8.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 25 Aug
 2020 09:58:12 +0100
Subject: Re: [PATCH 2/5] blk-mq: add helper of blk_mq_get_hw_queue_node
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
 <20200820180335.3109216-3-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f9b37b2e-2e18-99ea-ed3f-b5c857338694@huawei.com>
Date:   Tue, 25 Aug 2020 09:55:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200820180335.3109216-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.13]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/08/2020 19:03, Ming Lei wrote:
> Add helper of blk_mq_get_hw_queue_node for retrieve hw queue's numa
> node.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f9da2d803c18..5019d21e7ff8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2263,6 +2263,18 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_submit_bio); /* only for request based dm */
>   
> +static int blk_mq_get_hw_queue_node(struct blk_mq_tag_set *set,
> +		unsigned int hctx_idx)
> +{
> +	int node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT],
> +			hctx_idx);

Hi Ming,

Did you consider if we can consolidate all of this to 
blk_mq_hw_queue_to_node(), by passing the set there also (since we 
always use HCTX_TYPE_DEFAULT)? Or is that just exceeding remit of 
blk_mq_hw_queue_to_node()?

I don't think it would affect the other user of 
blk_mq_hw_queue_to_node(), being blk_mq_realloc_hw_ctxs().

But current change looks ok also.

Thanks

> +
> +	if (node == NUMA_NO_NODE)
> +		node = set->numa_node;
> +
> +	return node;
> +}
> +
>   void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>   		     unsigned int hctx_idx)
>   {
> @@ -2309,11 +2321,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>   					unsigned int reserved_tags)
>   {
>   	struct blk_mq_tags *tags;
> -	int node;
> -
> -	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
> -	if (node == NUMA_NO_NODE)
> -		node = set->numa_node;
> +	int node = blk_mq_get_hw_queue_node(set, hctx_idx);
>   
>   	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
>   				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
> @@ -2367,11 +2375,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>   {
>   	unsigned int i, j, entries_per_page;
>   	size_t rq_size, left;
> -	int node;
> -
> -	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
> -	if (node == NUMA_NO_NODE)
> -		node = set->numa_node;
> +	int node = blk_mq_get_hw_queue_node(set, hctx_idx);
>   
>   	INIT_LIST_HEAD(&tags->page_list);
>   
> 


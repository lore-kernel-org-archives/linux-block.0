Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33500 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcISRsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 13:48:52 -0400
Received: by mail-pf0-f173.google.com with SMTP id 21so42452190pfy.0
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 10:48:51 -0700 (PDT)
Date: Mon, 19 Sep 2016 10:48:49 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/14] blk-mq: Do not limit number of queues to
 'nr_cpu_ids' in allocations
Message-ID: <20160919174849.GA21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <9bb584d504bc2f8ef9d66822e68f082ee9a74ded.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9bb584d504bc2f8ef9d66822e68f082ee9a74ded.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:14AM +0200, Alexander Gordeev wrote:
> Currently maximum number of used hardware queues is limited to
> number of CPUs in the system. However, using 'nr_cpu_ids' as
> the limit for (de-)allocations of data structures instead of
> existing data structures' counters (a) worsens readability and
> (b) leads to unused memory when number of hardware queues is
> less than number of CPUs.
> 
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  block/blk-mq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 276ec7b..2c77b68 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2054,8 +2054,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	if (!q->queue_ctx)
>  		goto err_exit;
>  
> -	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
> -						GFP_KERNEL, set->numa_node);
> +	q->queue_hw_ctx = kzalloc_node(set->nr_hw_queues *
> +			sizeof(*(q->queue_hw_ctx)), GFP_KERNEL, set->numa_node);
>  	if (!q->queue_hw_ctx)
>  		goto err_percpu;
>  
> @@ -2319,7 +2319,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>  	if (set->nr_hw_queues > nr_cpu_ids)
>  		set->nr_hw_queues = nr_cpu_ids;
>  
> -	set->tags = kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
> +	set->tags = kzalloc_node(set->nr_hw_queues * sizeof(*set->tags),
>  				 GFP_KERNEL, set->numa_node);
>  	if (!set->tags)
>  		return -ENOMEM;
> @@ -2360,7 +2360,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  {
>  	int i;
>  
> -	for (i = 0; i < nr_cpu_ids; i++) {
> +	for (i = 0; i < set->nr_hw_queues; i++) {
>  		if (set->tags[i])
>  			blk_mq_free_rq_map(set, set->tags[i], i);
>  	}

I don't think this is safe since we might increase the number of
hardware queues (blk_mq_update_nr_hw_queues()).

-- 
Omar

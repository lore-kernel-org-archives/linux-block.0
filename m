Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0A8C4CEC7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 01:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394542067B
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 01:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfIPBt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 21:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfIPBt3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 21:49:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C879E3DE0B;
        Mon, 16 Sep 2019 01:49:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D6B260BF3;
        Mon, 16 Sep 2019 01:49:21 +0000 (UTC)
Date:   Mon, 16 Sep 2019 09:49:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] blk-mq: Avoid memory reclaim when allocating request
 map
Message-ID: <20190916014915.GB5162@ming.t460p>
References: <20190915122656.11376-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915122656.11376-1-xiubli@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 16 Sep 2019 01:49:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 15, 2019 at 05:56:56PM +0530, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> For some storage drivers, such as the nbd, when there has new socket
> connections added, it will update the hardware queue number by calling
> blk_mq_update_nr_hw_queues(), in which it will freeze all the queues
> first. And then tries to do the hardware queue updating stuff.
> 
> But int blk_mq_alloc_rq_map()-->blk_mq_init_tags(), when allocating
> memory for tags, it may cause the mm do the memories direct reclaiming,
> since the queues has been freezed, so if needs to flush the page cache
> to disk, it will stuck in generic_make_request()-->blk_queue_enter() by
> waiting the queues to be unfreezed and then cause deadlock here.
> 
> Since the memory size requested here is a small one, which will make
> it not that easy to happen with a large size, but in theory this could
> happen when the OS is running in pressure and out of memory.
> 
> Gabriel Krisman Bertazi has hit the similar issue by fixing it in
> commit 36e1f3d10786 ("blk-mq: Avoid memory reclaim when remapping
> queues"), but might forget this part.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> CC: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
> ---
>  block/blk-mq-tag.c | 5 +++--
>  block/blk-mq-tag.h | 5 ++++-
>  block/blk-mq.c     | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 008388e82b5c..04ee0e4c3fa1 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -462,7 +462,8 @@ static struct blk_mq_tags *blk_mq_init_bitmap_tags(struct blk_mq_tags *tags,
>  
>  struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>  				     unsigned int reserved_tags,
> -				     int node, int alloc_policy)
> +				     int node, int alloc_policy,
> +				     gfp_t flags)
>  {
>  	struct blk_mq_tags *tags;
>  
> @@ -471,7 +472,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
>  		return NULL;
>  	}
>  
> -	tags = kzalloc_node(sizeof(*tags), GFP_KERNEL, node);
> +	tags = kzalloc_node(sizeof(*tags), flags, node);
>  	if (!tags)
>  		return NULL;
>  
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 61deab0b5a5a..296e0bc97126 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -22,7 +22,10 @@ struct blk_mq_tags {
>  };
>  
>  
> -extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int reserved_tags, int node, int alloc_policy);
> +extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
> +					    unsigned int reserved_tags,
> +					    int node, int alloc_policy,
> +					    gfp_t flags);
>  extern void blk_mq_free_tags(struct blk_mq_tags *tags);
>  
>  extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 240416057f28..9c52e4dfe132 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2090,7 +2090,8 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
>  		node = set->numa_node;
>  
>  	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
> -				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
> +				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags),
> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);

Now, there are three uses on 'GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY',
and code gets cleaner if you make it as one const variable in
blk_mq_alloc_rq_map.

Otherwise, looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32808 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbcISSeg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 14:34:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id 21so42810073pfy.0
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 11:34:36 -0700 (PDT)
Date: Mon, 19 Sep 2016 11:34:29 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/14] blk-mq: Fix a potential NULL pointer assignment to
 hctx tags
Message-ID: <20160919183429.GD21803@vader>
References: <cover.1474183901.git.agordeev@redhat.com>
 <6eacfdd163d2c1a80f8b8280e480d94056896e2b.1474183901.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6eacfdd163d2c1a80f8b8280e480d94056896e2b.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Sep 18, 2016 at 09:37:12AM +0200, Alexander Gordeev wrote:
> If number of used hardware queues is dynamically decreased
> then tags corresponding to the newly unused queues are freed.
> 
> If previously unused hardware queues are then reused again
> they will start referring the previously freed tags.
> 
> CC: linux-block@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  block/blk-mq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 66505af7..7fa58fe 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1995,6 +1995,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  
>  		if (hctxs[i])
>  			continue;
> +		if (!set->tags[i])
> +			break;
>  
>  		node = blk_mq_hw_queue_to_node(q->mq_map, i);
>  		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),

In blk_mq_map_swqueue(), we have:

		/* unmapped hw queue can be remapped after CPU topo changed */
		if (!set->tags[i])
			set->tags[i] = blk_mq_init_rq_map(set, i);
		hctx->tags = set->tags[i];
		WARN_ON(!hctx->tags);

blk_mq_map_swqueue() is called from blk_mq_queue_reinit(), which we call
from blk_mq_update_nr_hw_queues(). Is that not enough? This
initialization/resizing is a bit of a twisty maze and it's hard to
convince myself that it's all correct, so cleanup here is probably
valuable.

-- 
Omar

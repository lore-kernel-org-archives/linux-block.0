Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA44C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjEWHUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjEWHT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:19:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED037130
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:18:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5172667373; Tue, 23 May 2023 09:18:35 +0200 (CEST)
Date:   Tue, 23 May 2023 09:18:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O
 scheduler
Message-ID: <20230523071835.GB8758@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522183845.354920-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 11:38:37AM -0700, Bart Van Assche wrote:
> Send requeued requests to the I/O scheduler such that the I/O scheduler
> can control the order in which requests are dispatched.
> 
> This patch reworks commit aef1897cd36d ("blk-mq: insert rq with DONTPREP
> to hctx dispatch list when requeue").

But you need to explain why it is safe.  I think it is because you add
DONTPREP to RQF_NOMERGE_FLAGS, but that really belongs into the commit
log.

> +	list_for_each_entry_safe(rq, next, &requeue_list, queuelist) {
> +		if (!(rq->rq_flags & RQF_DONTPREP)) {
>  			list_del_init(&rq->queuelist);
>  			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
>  		}
>  	}
>  
> +	while (!list_empty(&requeue_list)) {
> +		rq = list_entry(requeue_list.next, struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +		blk_mq_insert_request(rq, 0);

So now both started and unstarted requests go through
blk_mq_insert_request, and thus potentially the I/O scheduler, but
RQF_DONTPREP request that are by definition further along in processing
are inserted at the tail, while !RQF_DONTPREP ones get inserted at head.

This feels wrong, and we probably need to sort out why and how we are
doing head insertation on a requeue first.

> @@ -2064,14 +2060,28 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  		bool no_tag = prep == PREP_DISPATCH_NO_TAG &&
>  			((hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) ||
>  			blk_mq_is_shared_tags(hctx->flags));
> +		LIST_HEAD(for_sched);
> +		struct request *next;
>  
>  		if (nr_budgets)
>  			blk_mq_release_budgets(q, list);
>  
>  		spin_lock(&hctx->lock);
> +		list_for_each_entry_safe(rq, next, list, queuelist)
> +			if (rq->rq_flags & RQF_USE_SCHED)
> +				list_move_tail(&rq->queuelist, &for_sched);
>  		list_splice_tail_init(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
>  
> +		if (q->elevator) {
> +			if (q->elevator->type->ops.requeue_request)
> +				list_for_each_entry(rq, &for_sched, queuelist)
> +					q->elevator->type->ops.
> +						requeue_request(rq);
> +			q->elevator->type->ops.insert_requests(hctx, &for_sched,
> +							BLK_MQ_INSERT_AT_HEAD);
> +		}
> +

None of this is explained in the commit log, please elaborate on the
rationale for it.  Also:

 - this code block really belongs into a helper
 - calling ->requeue_request in a loop before calling ->insert_requests
   feels wrong  A BLK_MQ_INSERT_REQUEUE flag feels like the better
   interface here.

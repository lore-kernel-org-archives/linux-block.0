Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D4C7EE23
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 07:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjERHMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjERHMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 03:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE3185
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684393896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcfWLHY3dwR2vZCCiUU6blYP0g108sWCe1o68Yn/33s=;
        b=ia2kJhcxl2EEOWaVFLb2D32iD7Oh4isvTSxijEGtDkFuSMbhihz3cGH5LM7qm6Zb65muB1
        shXQdyz42X0wcio5rowqErWmIyfrvbk42e3JsHX7Xu3IbbUUh+OhX2Xj4XLKPsk+vsnAWz
        poVeiEdKly892Hz4EXnSf7vDatvTg3s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-ObXNKMp0PuaCjNJ0Tgd15A-1; Thu, 18 May 2023 03:11:35 -0400
X-MC-Unique: ObXNKMp0PuaCjNJ0Tgd15A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C589329ABA09;
        Thu, 18 May 2023 07:11:34 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD4E863F5F;
        Thu, 18 May 2023 07:11:20 +0000 (UTC)
Date:   Thu, 18 May 2023 15:11:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Message-ID: <ZGXPkFOWOuoLWglR@ovpn-8-21.pek2.redhat.com>
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518053101.760632-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 07:31:00AM +0200, Christoph Hellwig wrote:
> RQF_ELVPRIV is set for all non-flush requests that have RQF_ELV set.
> Expand this condition in the two users of the flag and remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-debugfs.c | 1 -
>  block/blk-mq-sched.h   | 4 ++--
>  block/blk-mq.c         | 6 ++----
>  include/linux/blk-mq.h | 2 --
>  4 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index d23a8554ec4aeb..588b7048342bee 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -248,7 +248,6 @@ static const char *const rqf_name[] = {
>  	RQF_NAME(DONTPREP),
>  	RQF_NAME(FAILED),
>  	RQF_NAME(QUIET),
> -	RQF_NAME(ELVPRIV),
>  	RQF_NAME(IO_STAT),
>  	RQF_NAME(PM),
>  	RQF_NAME(HASHED),
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 7c3cbad17f3052..4d8d2cd3b47396 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -58,11 +58,11 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
>  
>  static inline void blk_mq_sched_requeue_request(struct request *rq)
>  {
> -	if (rq->rq_flags & RQF_ELV) {
> +	if ((rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags)) {
>  		struct request_queue *q = rq->q;
>  		struct elevator_queue *e = q->elevator;
>  
> -		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
> +		if (e->type->ops.requeue_request)
>  			e->type->ops.requeue_request(rq);

The above actually changes current behavior since RQF_ELVPRIV is only set
iff the following condition is true:

	(rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
		e->type->ops.prepare_request.

>  	}
>  }
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8b7e4daaa5b70d..7470c6636dc4f7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -393,10 +393,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>  		RB_CLEAR_NODE(&rq->rb_node);
>  
>  		if (!op_is_flush(data->cmd_flags) &&
> -		    e->type->ops.prepare_request) {
> +		    e->type->ops.prepare_request)
>  			e->type->ops.prepare_request(rq);
> -			rq->rq_flags |= RQF_ELVPRIV;
> -		}
>  	}
>  
>  	return rq;
> @@ -696,7 +694,7 @@ void blk_mq_free_request(struct request *rq)
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
> -	if ((rq->rq_flags & RQF_ELVPRIV) &&
> +	if ((rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
>  	    q->elevator->type->ops.finish_request)
>  		q->elevator->type->ops.finish_request(rq);

Same with above.

Thanks,
Ming


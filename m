Return-Path: <SRS0=+tUj=CP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47DEC43461
	for <linux-block@archiver.kernel.org>; Sun,  6 Sep 2020 02:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688C020DD4
	for <linux-block@archiver.kernel.org>; Sun,  6 Sep 2020 02:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJhZ8MHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgIFCUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 22:20:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728409AbgIFCT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Sep 2020 22:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599358798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwgA9Jj7sGgW+dDyq44/6RsTApt4e/K2QTwvjlVIbYc=;
        b=DJhZ8MHTSDsivjdJhYBb1W/8Lz/EK3o66cLwpO2abcL+1NawWx/8Vf85tXB4puXElGN4m+
        Godqbcza+5T2ei1y2MoBka9V+7KhIfYfLpTWsFBBfEbgH5vWt8xvocsuNIqS2+2g3Gpg+1
        o3x7NgbIgMcg9nwcZOMGjhFUnsbmUTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Fr-uZJAPNIiTQqMmz1syWA-1; Sat, 05 Sep 2020 22:19:56 -0400
X-MC-Unique: Fr-uZJAPNIiTQqMmz1syWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D4F1DDEA;
        Sun,  6 Sep 2020 02:19:54 +0000 (UTC)
Received: from T590 (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0D010013C4;
        Sun,  6 Sep 2020 02:19:47 +0000 (UTC)
Date:   Sun, 6 Sep 2020 10:19:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, bvanassche@acm.org,
        hch@lst.de, yi.zhang@huawei.com
Subject: Re: [PATCH v2] blk-mq: call commit_rqs while list empty but error
 happen
Message-ID: <20200906021943.GA894392@T590>
References: <20200905112556.1735962-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905112556.1735962-1-yangerkun@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 05, 2020 at 07:25:56PM +0800, yangerkun wrote:
> Blk-mq should call commit_rqs once 'bd.last != true' and no more
> request will come(so virtscsi can kick the virtqueue, e.g.). We already
> do that in 'blk_mq_dispatch_rq_list/blk_mq_try_issue_list_directly' while
> list not empty and 'queued > 0'. However, we can seen the same scene
> once the last request in list call queue_rq and return error like
> BLK_STS_IOERR which will not requeue the request, and lead that list
> empty but need call commit_rqs too(Or the request for virtscsi will stay
> timeout until other request kick virtqueue).

It is really one corner case: driver has seen ->last already, so it
should have handled this case in theory.

However, for scsi, .commit_rqs is called by LLD, and request is failed
before calling .queuecommand by scsi middle layer, so causes this trouble.

NVMe has similar issue too.

> 
> We found this problem by do fsstress test with offline/online virtscsi
> device repeat quickly.
> 
> Fixes: d666ba98f849 ("blk-mq: add mq_ops->commit_rqs()")
> Reported-by: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  block/blk-mq.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> v1->v2: delete the comment
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b3d2785eefe9..cdced4aca2e8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1412,6 +1412,11 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  
>  	hctx->dispatched[queued_to_index(queued)]++;
>  
> +	/* If we didn't flush the entire list, we could have told the driver
> +	 * there was more coming, but that turned out to be a lie.
> +	 */
> +	if ((!list_empty(list) || errors) && q->mq_ops->commit_rqs && queued)
> +		q->mq_ops->commit_rqs(hctx);
>  	/*
>  	 * Any items that need requeuing? Stuff them into hctx->dispatch,
>  	 * that is where we will continue on next queue run.
> @@ -1425,14 +1430,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>  
>  		blk_mq_release_budgets(q, nr_budgets);
>  
> -		/*
> -		 * If we didn't flush the entire list, we could have told
> -		 * the driver there was more coming, but that turned out to
> -		 * be a lie.
> -		 */
> -		if (q->mq_ops->commit_rqs && queued)
> -			q->mq_ops->commit_rqs(hctx);
> -
>  		spin_lock(&hctx->lock);
>  		list_splice_tail_init(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
> @@ -2079,6 +2076,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  		struct list_head *list)
>  {
>  	int queued = 0;
> +	int errors = 0;
>  
>  	while (!list_empty(list)) {
>  		blk_status_t ret;
> @@ -2095,6 +2093,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				break;
>  			}
>  			blk_mq_end_request(rq, ret);
> +			errors++;
>  		} else
>  			queued++;
>  	}
> @@ -2104,7 +2103,8 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  	 * the driver there was more coming, but that turned out to
>  	 * be a lie.
>  	 */
> -	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs && queued)
> +	if ((!list_empty(list) || errors) &&
> +	     hctx->queue->mq_ops->commit_rqs && queued)
>  		hctx->queue->mq_ops->commit_rqs(hctx);
>  }

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


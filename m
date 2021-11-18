Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 00:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B59C61A3D
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 00:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbhKRAWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241886AbhKRAVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 19:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637194724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UL+2dE0OlHkgZEkkhKjdYarwwZE4Qa1s71CnLN6UxnQ=;
        b=G/wTQD2NGIp1KvV8sQE2ouViJ7Yr6HLbNciPQemHwSH461+F8dBU7Ac7/a7peXZlN9IPvD
        ydWmN7qaMJaJmNU1ehv8vrCLewVnwHFjOCD5gojdM6xXuVo4WDaNDZWphKFwPBG2ga4PRN
        PEecCWDGyU6RL+2pHy2RpOdkbMkYqcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-ncdPaadiOxKWMuZqkwvATg-1; Wed, 17 Nov 2021 19:18:43 -0500
X-MC-Unique: ncdPaadiOxKWMuZqkwvATg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79279DF8A6;
        Thu, 18 Nov 2021 00:18:42 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 448A060C81;
        Thu, 18 Nov 2021 00:18:34 +0000 (UTC)
Date:   Thu, 18 Nov 2021 08:18:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        hch@infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <YZWb1TiNLBtdQrt6@T590>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
 <20211117204101.GA3295649@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117204101.GA3295649@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 12:41:01PM -0800, Keith Busch wrote:
> On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
> > If we have a list of requests in our plug list, send it to the driver in
> > one go, if possible. The driver must set mq_ops->queue_rqs() to support
> > this, if not the usual one-by-one path is used.
> 
> It looks like we still need to sync with the request_queue quiesce flag.

I think this approach is good.

> Something like the following (untested) on top of this patch should do
> it:
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 688ebf6a7a7b..447d0b77375d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -263,6 +263,9 @@ void blk_mq_wait_quiesce_done(struct request_queue *q)
>  	unsigned int i;
>  	bool rcu = false;
>  
> +	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
> +		synchronize_srcu(q->srcu);
> +
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (hctx->flags & BLK_MQ_F_BLOCKING)
>  			synchronize_srcu(hctx->srcu);
> @@ -2201,6 +2204,25 @@ static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
>  	*queued = 0;
>  }
>  
> +static void queue_lock(struct request_queue *q, int *srcu_idx)
> +	__acquires(q->srcu)
> +{
> +	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING)) {
> +		*srcu_idx = 0;
> +		rcu_read_lock();
> +	} else
> +		*srcu_idx = srcu_read_lock(q->srcu);
> +}
> +
> +static void queue_unlock(struct request_queue *q, int srcu_idx)
> +	__releases(q->srcu)
> +{
> +	if (!(q->tag_set->flags & BLK_MQ_F_BLOCKING))
> +		rcu_read_unlock();
> +	else
> +		srcu_read_unlock(q->srcu, srcu_idx);
> +}
> +
>  static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>  {
>  	struct blk_mq_hw_ctx *hctx = NULL;
> @@ -2216,7 +2238,14 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
>  	 */
>  	rq = rq_list_peek(&plug->mq_list);
>  	if (rq->q->mq_ops->queue_rqs) {
> -		rq->q->mq_ops->queue_rqs(&plug->mq_list);
> +		struct request_queue *q = rq->q;
> +		int srcu_idx;
> +
> +		queue_lock(q, &srcu_idx);
> +		if (!blk_queue_quiesced(q))
> +			q->mq_ops->queue_rqs(&plug->mq_list);
> +		queue_unlock(q, srcu_idx);
> +
>  		if (rq_list_empty(plug->mq_list))
>  			return;
>  	}
> @@ -3727,6 +3756,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
>  
>  	q->tag_set = set;
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		init_srcu_struct(q->srcu);
>  
>  	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
>  	if (set->nr_maps > HCTX_TYPE_POLL &&
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bd4370baccca..ae7591dc9cbb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -373,6 +373,8 @@ struct request_queue {
>  	 * devices that do not have multiple independent access ranges.
>  	 */
>  	struct blk_independent_access_ranges *ia_ranges;
> +
> +	struct srcu_struct	srcu[];

Basically it is same with my previous post[1], but the above patch doesn't
handle request queue allocation/freeing correctly in case of BLK_MQ_F_BLOCKING.

[1] https://lore.kernel.org/linux-block/20211103160018.3764976-1-ming.lei@redhat.com/


Thanks,
Ming


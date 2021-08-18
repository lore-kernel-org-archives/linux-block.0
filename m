Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA1C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 00:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F08A61053
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 00:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhHRAxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 20:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237071AbhHRAxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 20:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629247990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlpWao7vU3JW787/tdi8ZHrj116Lw/4JmcqJlEJe7xY=;
        b=S20DlWRQ0zmnI+j7KvQxUQTkCaYwCofl7QjGWlJTIf9xJQyFj7FhsrCQeUJuupfGwiBlbD
        2Yf9WV7agqfWdSWAQiMjeiM3RTawng2oEo0Azkquikmwd5yAHvoiBQsLILyxNTM32xUDDB
        lh8kI2EmL65ax+f7GDcO9GC0U1GXNAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-OQKfPFW7OvaMR3DEyJhmbg-1; Tue, 17 Aug 2021 20:53:06 -0400
X-MC-Unique: OQKfPFW7OvaMR3DEyJhmbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4CD18C8C00;
        Wed, 18 Aug 2021 00:53:05 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA3BC19D9D;
        Wed, 18 Aug 2021 00:52:56 +0000 (UTC)
Date:   Wed, 18 Aug 2021 08:52:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC] blk_mq: clear rq mapping in driver tags before
 freeing rqs in sched tags
Message-ID: <YRxZ44tu8o1MPruT@T590>
References: <20210817022306.1622027-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817022306.1622027-1-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 17, 2021 at 10:23:06AM +0800, Yu Kuai wrote:
> If ioscheduler is not none, hctx->tags->rq[tag] will point to
> hctx->sched_tags->static_rq[internel_tag] in blk_mq_get_driver_tag().
> However, static_rq of sched_tags might be freed through switching
> elevator or increasing nr_requests. Thus leave a window for some drivers
> to get the freed request through blk_mq_tag_to_rq(tags, tag).

I believe I have explained that it is bug of driver which has knowledge
if the passed tag is valid or not. We are clear that driver need to cover
race between normal completion and timeout/error handling.

> 
> It's difficult to fix this uaf from driver side, I'm thinking about

So far not see any analysis on why the uaf is triggered, care to
investigate the reason?

> following solution:
> 
> a. clear rq mapping in driver tags before freeing rqs in sched tags

We have done that already, see blk_mq_free_rqs().

> b. provide a new interface to replace blk_mq_tag_to_rq(), the new
> interface will make sure it won't return freed rq.

b) in your previous patch can't avoid uaf:

https://lore.kernel.org/linux-block/YRHa%2FkeJ4pHP3hnL@T590/

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-sched.c | 10 +++++++++-
>  block/blk-mq.c       | 13 +++++++++++--
>  block/blk-mq.h       |  2 ++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 0f006cabfd91..9f11f17b8380 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -662,8 +662,16 @@ void blk_mq_sched_free_requests(struct request_queue *q)
>  	int i;
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->sched_tags)
> +		if (hctx->sched_tags) {
> +			/*
> +			 * We are about to free requests in 'sched_tags[]',
> +			 * however, 'tags[]' may still point to these requests.
> +			 * Thus we need to clear rq mapping in 'tags[]' before
> +			 * freeing requests in sched_tags[].
> +			 */
> +			blk_mq_clear_rq_mapping(q->tag_set, hctx->tags, i);
>  			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);

blk_mq_clear_rq_mapping() has been called in blk_mq_free_rqs()
for clearing the request reference.

In theory, we only need to clear it in case of real io sched, but
so far we do it for both io sched and none.

> +		}
>  	}
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d185be64c85f..b1e30464f87f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2314,8 +2314,8 @@ static size_t order_to_size(unsigned int order)
>  }
>  
>  /* called before freeing request pool in @tags */
> -static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
> -		struct blk_mq_tags *tags, unsigned int hctx_idx)
> +void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
> +			     struct blk_mq_tags *tags, unsigned int hctx_idx)
>  {
>  	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
>  	struct page *page;
> @@ -3632,6 +3632,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  			if (!ret && blk_mq_is_sbitmap_shared(set->flags))
>  				blk_mq_tag_resize_shared_sbitmap(set, nr);
>  		} else {
> +			/*
> +			 * We are about to free requests in 'sched_tags[]',
> +			 * however, 'tags[]' may still point to these requests.
> +			 * Thus we need to clear rq mapping in 'tags[]' before
> +			 * freeing requests in sched_tags[].
> +			 */
> +			if (nr > hctx->sched_tags->nr_tags)
> +				blk_mq_clear_rq_mapping(set, hctx->tags, i);
> +
>  			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
>  							nr, true);

The request reference has been cleared too in blk_mq_tag_update_depth():

	blk_mq_tag_update_depth
		blk_mq_free_rqs
			blk_mq_clear_rq_mapping


Thanks, 
Ming


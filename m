Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6DC433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 07:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BED661157
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 07:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhEGHbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 03:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235341AbhEGHbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 May 2021 03:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620372650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jT+Z3Xs7+Befb9ZFNwNI4ZrrBQQmO2XpPLA2/uirisE=;
        b=SZBebTDKFZkqmVTDooAZ1PpPdVwkVr3YvqZUgOqqU31A/85RITgNxYvfkGpDwWP4jVbJux
        yjFJ2bXXhQvyEcfZCqPfZJaduN9Z/XRrP26P0O4pZRW1+e8fDioKp0koSHOZfm/UqLxCzZ
        vlnNjesEjyqDDpeXKHPm7vT7gKlWN+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-Tcn6T8I7N0-7Gg2WstqaxQ-1; Fri, 07 May 2021 03:30:47 -0400
X-MC-Unique: Tcn6T8I7N0-7Gg2WstqaxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A5CE1936B61;
        Fri,  7 May 2021 07:30:46 +0000 (UTC)
Received: from T590 (ovpn-13-197.pek2.redhat.com [10.72.13.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 104B95D6AB;
        Fri,  7 May 2021 07:30:38 +0000 (UTC)
Date:   Fri, 7 May 2021 15:30:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YJTsmo2aleNakUUU@T590>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org>
 <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <YJPxYXCZ2j1r1my1@T590>
 <YJTk02/xqiO4Oy3n@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJTk02/xqiO4Oy3n@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 07, 2021 at 07:57:23AM +0100, Christoph Hellwig wrote:
> On Thu, May 06, 2021 at 09:38:41PM +0800, Ming Lei wrote:
> > > So.  Even a different LUN shares the same tagset.  So I can see the
> > > need for the cmpxchg (please document it!), but I don't see the need
> > > for the complex iteration.  All the rqs are freed in one single loop,
> > > so we can just iterate through them sequentially.
> > 
> > That is exactly what the patch is doing, requests are stored in page
> > list, so check if one request(covered in page list) reference in
> > drv_tags->rq[i] exists, if yes, we clear the request reference.
> > 
> > The code is actually sort of self-document: before we free requests,
> > clear the reference in hostwide drv->rqs[].
> 
> What the patch does it to do a completely pointless nested loop.
> Instead of just looping through all requests which is simple and fast
> it loops through each page, and then does another loop inside that,
> just increasing complexity and runtime.  We should at least do something
> like the incremental patch below instead which is simpler, faster and
> easier to understand:

The pages to be freed may be from scheduler tags(set->sched_tags), which
belongs to one request queue being shutdown, but set->tags->rqs[] is
shared by all request queues in the host, and it can be actively assigned
from other LUN/request queue.

> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c1b28e09a27e..598fe82cfbcf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2311,29 +2311,20 @@ static size_t order_to_size(unsigned int order)
>  	return (size_t)PAGE_SIZE << order;
>  }
>  
> -/* called before freeing request pool in @tags */
> +/* ensure that blk_mq_find_and_get_req can't find the tags any more */
>  static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
>  		struct blk_mq_tags *tags, unsigned int hctx_idx)
>  {
>  	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
> -	struct page *page;
>  	unsigned long flags;
> +	int i;
>  
>  	spin_lock_irqsave(&drv_tags->lock, flags);
> -	list_for_each_entry(page, &tags->page_list, lru) {
> -		unsigned long start = (unsigned long)page_address(page);
> -		unsigned long end = start + order_to_size(page->private);
> -		int i;
> +	for (i = 0; i < set->queue_depth; i++) {
> +		struct request *rq = drv_tags->rqs[i];
>  
> -		for (i = 0; i < set->queue_depth; i++) {
> -			struct request *rq = drv_tags->rqs[i];
> -			unsigned long rq_addr = (unsigned long)rq;
> -
> -			if (rq_addr >= start && rq_addr < end) {
> -				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> -				cmpxchg(&drv_tags->rqs[i], rq, NULL);
> -			}
> -		}
> +		WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
> +		cmpxchg(&drv_tags->rqs[i], rq, NULL);

set->tags->rqs[] is just one dynamic mapping between host-wide driver tag and
request which may be allocated from sched tags which is per-request-queue,
and set->tags->rqs[] is host wide.

What if the request pointed by 'rq' is just assigned from another active LUN's
sched tags?

What we need to do is to make sure every reference to being freed request is
cleared, that is all.

Thanks,
Ming


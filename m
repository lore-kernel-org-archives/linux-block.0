Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B5C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 02:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7C161051
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 02:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhHRCqM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 22:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234302AbhHRCqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 22:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629254737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Ly4hMgmcduWmjk7R138XN1c7rishTtsrNhm8UdX1fs=;
        b=RV43urOQo8sisR/Uf6Dh5Gi8kAFD0qUKWkdKt9I3WB9guU/uBLQG/ACqeD1hiWG9SUe3Vt
        XSiiIAtV2ythBZJcpp5g5pa7nqnUPCxoorMluBuByZjuBLBGcfP0VFAQ/a/xmGvQ1ELQU5
        oASA7FMTCOK7qw9KKYKNVjTVbMaN7R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-ErqW5xKFOrGx03r8uvmf8Q-1; Tue, 17 Aug 2021 22:45:36 -0400
X-MC-Unique: ErqW5xKFOrGx03r8uvmf8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 090EA801AC5;
        Wed, 18 Aug 2021 02:45:35 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A317D5D9CA;
        Wed, 18 Aug 2021 02:45:25 +0000 (UTC)
Date:   Wed, 18 Aug 2021 10:45:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC] blk_mq: clear rq mapping in driver tags before
 freeing rqs in sched tags
Message-ID: <YRx0QE8T4RJONlA8@T590>
References: <20210817022306.1622027-1-yukuai3@huawei.com>
 <YRxZ44tu8o1MPruT@T590>
 <11ef6a06-4b6f-44d0-af79-f96e16456b55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ef6a06-4b6f-44d0-af79-f96e16456b55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 10:02:09AM +0800, yukuai (C) wrote:
> On 2021/08/18 8:52, Ming Lei wrote:
> > On Tue, Aug 17, 2021 at 10:23:06AM +0800, Yu Kuai wrote:
> > > If ioscheduler is not none, hctx->tags->rq[tag] will point to
> > > hctx->sched_tags->static_rq[internel_tag] in blk_mq_get_driver_tag().
> > > However, static_rq of sched_tags might be freed through switching
> > > elevator or increasing nr_requests. Thus leave a window for some drivers
> > > to get the freed request through blk_mq_tag_to_rq(tags, tag).
> > 
> > I believe I have explained that it is bug of driver which has knowledge
> > if the passed tag is valid or not. We are clear that driver need to cover
> > race between normal completion and timeout/error handling.
> > 
> > > 
> > > It's difficult to fix this uaf from driver side, I'm thinking about
> > 
> > So far not see any analysis on why the uaf is triggered, care to
> > investigate the reason?
> 
> Hi, Ming
> 
> I'm sorry if I didn't explian the uaf clearly.
> 
> 1) At first, a normal io is submitted and completed with scheduler:
> 
> internel_tag = blk_mq_get_tag -> get tag from sched_tags
>  blk_mq_rq_ctx_init
>   sched_tags->rq[internel_tag] = sched_tag->static_rq[internel_tag]
> ...
> blk_mq_get_driver_tag
>  __blk_mq_get_driver_tag -> get tag from tags
>  tags->rq[tag] = sched_tag->static_rq[internel_tag]
> 
> So, both tags->rq[tag] and sched_tags->rq[internel_tag] are pointing
> to the request: sched_tags->static_rq[internal_tag].
> 
> 2) Then, if the sched_tags->static_rq is freed:
> 
> blk_mq_sched_free_requests
>  blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i)
>   blk_mq_clear_rq_mapping(set, tags, hctx_idx);
>    -> sched_tags->rq[internel_tag] is set to null here

Please take a look at blk_mq_clear_rq_mapping():

	//drv_tags points to set->tags[] which is shared in host wide
	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
	...

	//tags points to sched_tags
	list_for_each_entry(page, &tags->page_list, lru) {
		unsigned long start = (unsigned long)page_address(page);
		unsigned long end = start + order_to_size(page->private);
		int i;

		/* clear drv_tags->rq[i] in case it is from this sched tags*/
		for (i = 0; i < set->queue_depth; i++) {
			struct request *rq = drv_tags->rqs[i];
			unsigned long rq_addr = (unsigned long)rq;

			if (rq_addr >= start && rq_addr < end) {
				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
				cmpxchg(&drv_tags->rqs[i], rq, NULL);
			}
		}
	}

So we do clear tags->rq[] instead of sched_tag->rq[].

> 
> After switching elevator, tags->rq[tag] still point to the request
> that is just freed.

No.

> 
> 3) nbd server send a reply with random tag directly:
> 
> recv_work
>  nbd_read_stat
>   blk_mq_tag_to_rq(tags, tag)
>    rq = tags->rq[tag] -> rq is freed
> 
> Usually, nbd will get tag and send a request to server first, and then
> handle the reply. However, if the request is skipped, such uaf problem
> can be triggered.

When or how is such reply with random tag replied to nbd client? Is it
possible for nbd client to detect such un-expected/bad situation?
What if blk_mq_tag_to_rq() is just called before/when we clear tags->rq[]?

> 
> > 
> > The request reference has been cleared too in blk_mq_tag_update_depth():
> > 
> > 	blk_mq_tag_update_depth
> > 		blk_mq_free_rqs
> > 			blk_mq_clear_rq_mapping
> > 
> 
> What I'm trying to do is to clear rq mapping in both
> hctx->sched_tags->rq and hctx->tags->rq when sched_tags->static_rq
> is freed. However, I forgot about the case when tags is shared in
> multiple device. Thus what this patch does is clearly wrong...
> 
> So, what do you think about adding a new interface to iterate the
> request in tags->rq[], find what is pointing to the
> sched_tags->static_rq[], and use cmpxchg() to clear them?

See above, we already clear tags->rq[] if the rq is from to-be-freed
sched_tags.


Thanks,
Ming


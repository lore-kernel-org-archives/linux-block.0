Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08196C433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E175160FBF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKLQWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:22:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhKLQWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 11:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636733953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZYjW7WPYavrJsWWLgfKBZpau5KITBTJ4xvBsIhS428=;
        b=WsvkN1X0c/YLO6SpaO+RuOpd03/IAAznLKgD9gpg6gphBInJ0unBsGlOKzwYkjfRPaoHit
        JhxYJO9WWZFbUOTXqvbQX8zC7H2/Tw0P38WqCWwLF3clZcLaCRGrbUVmTzmqK3eKzewgkH
        LLbbXPiF3S6J9GrtWLrDJiNim76PDqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-_r3UDGG1NKKCZ-te21Du9w-1; Fri, 12 Nov 2021 11:19:10 -0500
X-MC-Unique: _r3UDGG1NKKCZ-te21Du9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04E115720;
        Fri, 12 Nov 2021 16:19:08 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C05B960622;
        Fri, 12 Nov 2021 16:17:18 +0000 (UTC)
Date:   Sat, 13 Nov 2021 00:17:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
Message-ID: <YY6ThZtM7oBEunRe@T590>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de>
 <YY4nv5eQUTOF5Wfv@T590>
 <20211112084441.GA32120@lst.de>
 <YY5iUwZ2TVtfqfXN@T590>
 <8c04076d-6264-07c2-aa97-948211d5bc7f@kernel.dk>
 <YY6Qux6ZIIjNyc4b@T590>
 <2b3a62dc-2f7d-0517-eaf5-2b1f60a60c9d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3a62dc-2f7d-0517-eaf5-2b1f60a60c9d@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 12, 2021 at 09:08:39AM -0700, Jens Axboe wrote:
> On 11/12/21 9:05 AM, Ming Lei wrote:
> > On Fri, Nov 12, 2021 at 08:47:01AM -0700, Jens Axboe wrote:
> >> On 11/12/21 5:47 AM, Ming Lei wrote:
> >>> On Fri, Nov 12, 2021 at 09:44:41AM +0100, Christoph Hellwig wrote:
> >>>> On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
> >>>>>> can only be used for reads, and no fua can be set if the preallocating
> >>>>>> I/O didn't use fua, etc.
> >>>>>>
> >>>>>> What are the pitfalls of just chanigng cmd_flags?
> >>>>>
> >>>>> Then we need to check cmd_flags carefully, such as hctx->type has to
> >>>>> be same, flush & passthrough flags has to be same, that said all
> >>>>> ->cmd_flags used for allocating rqs have to be same with the following
> >>>>> bio->bi_opf.
> >>>>>
> >>>>> In usual cases, I guess all IOs submitted from same plug batch should be
> >>>>> same type. If not, we can switch to change cmd_flags.
> >>>>
> >>>> Jens: is this a limit fitting into your use cases?
> >>>>
> >>>> I guess as a quick fix this rejecting different flags is probably the
> >>>> best we can do for now, but I suspect we'll want to eventually relax
> >>>> them.
> >>>
> >>> rw mixed workload will be affected, so I think we need to switch to
> >>> change cmd_flags, how about the following patch?
> >>>
> >>> From 9ab77b7adee768272944c20b7cffc8abdb85a35b Mon Sep 17 00:00:00 2001
> >>> From: Ming Lei <ming.lei@redhat.com>
> >>> Date: Fri, 12 Nov 2021 08:14:38 +0800
> >>> Subject: [PATCH] blk-mq: fix filesystem I/O request allocation
> >>>
> >>> submit_bio_checks() may update bio->bi_opf, so we have to initialize
> >>> blk_mq_alloc_data.cmd_flags with bio->bi_opf after submit_bio_checks()
> >>> returns when allocating new request.
> >>>
> >>> In case of using cached request, fallback to allocate new request if
> >>> cached rq isn't compatible with the incoming bio, otherwise change
> >>> rq->cmd_flags with incoming bio->bi_opf.
> >>>
> >>> Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
> >>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>> Cc: Christoph Hellwig <hch@lst.de>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/blk-mq.c | 39 ++++++++++++++++++++++++++++++---------
> >>>  block/blk-mq.h | 26 +++++++++++++++-----------
> >>>  2 files changed, 45 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index f511db395c7f..3ab34c4f20da 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -2521,12 +2521,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
> >>>  	};
> >>>  	struct request *rq;
> >>>  
> >>> -	if (unlikely(bio_queue_enter(bio)))
> >>> -		return NULL;
> >>> -	if (unlikely(!submit_bio_checks(bio)))
> >>> -		goto put_exit;
> >>>  	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
> >>> -		goto put_exit;
> >>> +		return NULL;
> >>>  
> >>>  	rq_qos_throttle(q, bio);
> >>>  
> >>> @@ -2543,19 +2539,32 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
> >>>  	rq_qos_cleanup(q, bio);
> >>>  	if (bio->bi_opf & REQ_NOWAIT)
> >>>  		bio_wouldblock_error(bio);
> >>> -put_exit:
> >>> -	blk_queue_exit(q);
> >>> +
> >>>  	return NULL;
> >>>  }
> >>>  
> >>> +static inline bool blk_mq_can_use_cached_rq(struct request *rq,
> >>> +		struct bio *bio)
> >>> +{
> >>> +	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
> >>> +		return false;
> >>> +
> >>> +	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
> >>> +		return false;
> >>> +
> >>> +	return true;
> >>
> >> I think we should just check if hctx is the same, that should be enough.
> >> We don't need to match the type, just disallow if hw queue has changed.
> > 
> > But bio doesn't have hw queue. Figuring out exact hw queue seems
> > necessary and needs more cpu cycles than getting hctx type.
> 
> Thinking about it, if opf and request_queue matches, that should be
> enough.

I think that is same with hctx->type check: POLLED & OP needs to be
same between the request and bio, and op_is_flush(), or could you
explain how to run the exact check on opf?


Thanks,
Ming


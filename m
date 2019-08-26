Return-Path: <SRS0=sRwj=WW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A3C3A5A1
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C377420673
	for <linux-block@archiver.kernel.org>; Mon, 26 Aug 2019 02:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfHZCLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfHZCLx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Aug 2019 22:11:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67875308FC22;
        Mon, 26 Aug 2019 02:11:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2631600C4;
        Mon, 26 Aug 2019 02:11:44 +0000 (UTC)
Date:   Mon, 26 Aug 2019 10:11:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V2 3/6] blk-mq: don't hold q->sysfs_lock in
 blk_mq_map_swqueue
Message-ID: <20190826021138.GA25756@ming.t460p>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-4-ming.lei@redhat.com>
 <3a48b5cb-0618-598c-3087-c6c939b6353b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a48b5cb-0618-598c-3087-c6c939b6353b@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 26 Aug 2019 02:11:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 21, 2019 at 08:53:52AM -0700, Bart Van Assche wrote:
> On 8/21/19 2:15 AM, Ming Lei wrote:
> > blk_mq_map_swqueue() is called from blk_mq_init_allocated_queue()
> > and blk_mq_update_nr_hw_queues(). For the former caller, the kobject
> > isn't exposed to userspace yet. For the latter caller, sysfs/debugfs
> > is un-registered before updating nr_hw_queues.
> > 
> > On the other hand, commit 2f8f1336a48b ("blk-mq: always free hctx after
> > request queue is freed") moves freeing hctx into queue's release
> > handler, so there won't be race with queue release path too.
> > 
> > So don't hold q->sysfs_lock in blk_mq_map_swqueue().
> > 
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Cc: Mike Snitzer <snitzer@redhat.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq.c | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 6968de9d7402..b0ee0cac737f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2456,11 +2456,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >   	struct blk_mq_ctx *ctx;
> >   	struct blk_mq_tag_set *set = q->tag_set;
> > -	/*
> > -	 * Avoid others reading imcomplete hctx->cpumask through sysfs
> > -	 */
> > -	mutex_lock(&q->sysfs_lock);
> > -
> >   	queue_for_each_hw_ctx(q, hctx, i) {
> >   		cpumask_clear(hctx->cpumask);
> >   		hctx->nr_ctx = 0;
> > @@ -2521,8 +2516,6 @@ static void blk_mq_map_swqueue(struct request_queue *q)
> >   					HCTX_TYPE_DEFAULT, i);
> >   	}
> > -	mutex_unlock(&q->sysfs_lock);
> > -
> >   	queue_for_each_hw_ctx(q, hctx, i) {
> >   		/*
> >   		 * If no software queues are mapped to this hardware queue,
> > 
> 
> How about adding WARN_ON_ONCE(test_bit(QUEUE_FLAG_REGISTERED,
> &q->queue_flags)) ?

q->kobject isn't un-registered before updating nr_hw_queues, and only
hctx->kobj is un-registered, so we can't add the warn here.


Thanks,
Ming

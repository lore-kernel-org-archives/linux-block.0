Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6AFC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F6B207F5
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 18:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgFCSMH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:12:07 -0400
Received: from verein.lst.de ([213.95.11.211]:51702 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCSMH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 14:12:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C2B3F68B05; Wed,  3 Jun 2020 20:12:03 +0200 (CEST)
Date:   Wed, 3 Jun 2020 20:12:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200603181203.GA2032@lst.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com> <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603133608.GA2149752@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 03, 2020 at 09:36:08PM +0800, Ming Lei wrote:
> > +bool __blk_mq_get_driver_tag(struct request *rq)
> > +{
> > +	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
> > +	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
> > +	bool shared = blk_mq_tag_busy(rq->mq_hctx);
> 
> Not necessary to add 'shared' which is just used once.

blk_mq_tag_busy also increments active_queues, and the existing code
does that before various early returns.  To keep the behavior as-is
the call to blk_mq_tag_busy can't be moved around.

> > +	int tag;
> > +
> > +	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
> > +		bt = &rq->mq_hctx->tags->breserved_tags;
> 
> Too many rq->mq_hctx->tags, you can add one local variable to store it.

Really just three of them.  And with a local variable confusing it with
rq->mq_hctx->sched_tags becomes much easier.

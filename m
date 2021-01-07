Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C16C433E9
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C817F23340
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 11:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbhAGLS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:18:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:50124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGLS5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jan 2021 06:18:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BFA6B278;
        Thu,  7 Jan 2021 11:18:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ECC0C1E0872; Thu,  7 Jan 2021 12:18:15 +0100 (CET)
Date:   Thu, 7 Jan 2021 12:18:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-mq: Improve performance of non-mq IO schedulers
 with multiple HW queues
Message-ID: <20210107111815.GB12990@quack2.suse.cz>
References: <20210106102428.551-1-jack@suse.cz>
 <20210106102428.551-3-jack@suse.cz>
 <20210107061918.GA3897511@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107061918.GA3897511@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 07-01-21 14:19:18, Ming Lei wrote:
> On Wed, Jan 06, 2021 at 11:24:28AM +0100, Jan Kara wrote:
> > +/* Check if there are requests queued in hctx lists. */
> > +static bool blk_mq_hctx_has_queued_rq(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	return !list_empty_careful(&hctx->dispatch) ||
> > +		sbitmap_any_bit_set(&hctx->ctx_map);
> > +}
> > +
> 
> blk_mq_hctx_mark_pending() is only called in case of none scheduler, so
> looks not necessary to check hctx->ctx_map in blk_mq_hctx_has_queued_rq()
> which is supposed to be used when real io scheduler is attached to MQ queue.

Yes, I know. I just wanted to make the code less fragile... In particular I
was somewhat uneasy that we'd rely on the implicit behavior that
blk_mq_get_sqsched_hctx() can return non-NULL only if sbitmap_any_bit_set()
is not needed. But maybe we could structure the code like:

	sq_hctx = NULL;
	if (blk_mq_has_sqsched(q))
		sq_hctx = blk_mq_get_sq_hctx(q);
	queue_for_each_hw_ctx(q, hctx, i) {
		...
		if (!sq_hctx || sq_hctx == hctx ||
		    !list_empty_careful(&hctx->dispatch))
			... run ...
	}

Because then it is kind of obvious that sq_hctx is set only if there's IO
scheduler for the queue and thus ctx_map is unused. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

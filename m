Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF5EC77B7D
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 20:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244989AbjEOUWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 16:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjEOUWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 16:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED41C1
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 13:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F98363243
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 20:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6F5C433EF;
        Mon, 15 May 2023 20:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684182141;
        bh=DYW3hPcEU8eOL16P0aDxIhYto92OxpMyuRnnVBRcnMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLJVj/VnUotJYxcEVZhdRcCuDWjG8UoYSfH8qYaG5TN1cU74STujDPaSW/oW6p5H2
         /S3JyhYA43d5QgEG+AGLNcPkLPQtHpxr9K+QkQyg6SH8TpAq5R7chQ84rH/z8Do3um
         A+ooq859B/2uuU2eqP+oM83Ki/PnmN/aZlwPxX1IIu4w92yQbObU6CsXl4KKDzWg7I
         8Lc/zJFSpj0umvo8wtQJw1Q607vXtabMMXWyRuvlto8uZCq1uCLZZdkPyyA8+TJ3/i
         CaucBzKO3HR6ei5HmLEa1bq2DPeSmFDBjrPV9QRbLq1xsqbdn3WDuXGrDUluQip/j1
         J+xism2WUqzKQ==
Date:   Mon, 15 May 2023 14:22:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGKUehOEnKThjFpR@kbusch-mbp>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 08:52:38AM -0700, Bart Van Assche wrote:
> On 5/15/23 07:46, Ming Lei wrote:
> > @@ -48,7 +53,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
> >   static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> >   {
> > -	if (rq->rq_flags & RQF_ELV) {
> > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> >   		struct elevator_queue *e = rq->q->elevator;
> >   		if (e->type->ops.completed_request)
> > @@ -58,7 +63,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> >   static inline void blk_mq_sched_requeue_request(struct request *rq)
> >   {
> > -	if (rq->rq_flags & RQF_ELV) {
> > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> >   		struct request_queue *q = rq->q;
> >   		struct elevator_queue *e = q->elevator;
> 
> Has it been considered not to set RQF_ELV for passthrough requests instead
> of making the above changes?

That sounds like a good idea. It changes more behavior than what Ming is
targeting here, but after looking through each use for RQF_ELV, I think
not having that set really is the right thing to do in all cases for
passthrough requests.

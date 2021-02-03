Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A073AC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5983D64F72
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhBCLon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:44:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:55194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234486AbhBCLnv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 06:43:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47B8FAD26;
        Wed,  3 Feb 2021 11:43:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 071551E14B6; Wed,  3 Feb 2021 12:43:09 +0100 (CET)
Date:   Wed, 3 Feb 2021 12:43:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and
 woken in dispatch list
Message-ID: <20210203114308.GB7094@quack2.suse.cz>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-3-paolo.valente@linaro.org>
 <36ecc71d-ef51-c667-74f8-d8f289e2f7db@kernel.dk>
 <A5A6D401-D774-4D9E-A68B-08D46368653E@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5A6D401-D774-4D9E-A68B-08D46368653E@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 28-01-21 18:54:05, Paolo Valente wrote:
> 
> 
> > Il giorno 26 gen 2021, alle ore 17:18, Jens Axboe <axboe@kernel.dk> ha scritto:
> > 
> > On 1/26/21 3:50 AM, Paolo Valente wrote:
> >> Consider a new I/O request that arrives for a bfq_queue bfqq. If, when
> >> this happens, the only active bfq_queues are bfqq and either its waker
> >> bfq_queue or one of its woken bfq_queues, then there is no point in
> >> queueing this new I/O request in bfqq for service. In fact, the
> >> in-service queue and bfqq agree on serving this new I/O request as
> >> soon as possible. So this commit puts this new I/O request directly
> >> into the dispatch list.
> >> 
> >> Tested-by: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> >> ---
> >> block/bfq-iosched.c | 17 ++++++++++++++++-
> >> 1 file changed, 16 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> >> index a83149407336..e5b83910fbe0 100644
> >> --- a/block/bfq-iosched.c
> >> +++ b/block/bfq-iosched.c
> >> @@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
> >> 
> >> 	spin_lock_irq(&bfqd->lock);
> >> 	bfqq = bfq_init_rq(rq);
> >> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
> >> +
> >> +	/*
> >> +	 * Additional case for putting rq directly into the dispatch
> >> +	 * queue: the only active bfq_queues are bfqq and either its
> >> +	 * waker bfq_queue or one of its woken bfq_queues. In this
> >> +	 * case, there is no point in queueing rq in bfqq for
> >> +	 * service. In fact, the in-service queue and bfqq agree on
> >> +	 * serving this new I/O request as soon as possible.
> >> +	 */
> >> +	if (!bfqq ||
> >> +	    (bfqq != bfqd->in_service_queue &&
> >> +	     bfqd->in_service_queue != NULL &&
> >> +	     bfq_tot_busy_queues(bfqd) == 1 + bfq_bfqq_busy(bfqq) &&
> >> +	     (bfqq->waker_bfqq == bfqd->in_service_queue ||
> >> +	      bfqd->in_service_queue->waker_bfqq == bfqq)) ||
> >> +	    at_head || blk_rq_is_passthrough(rq)) {
> >> 		if (at_head)
> >> 			list_add(&rq->queuelist, &bfqd->dispatch);
> >> 		else
> >> 
> > 
> > This is unreadable... Just seems like you are piling heuristics in to
> > catch some case, and it's neither readable nor clean.
> > 
> 
> Yeah, these comments inappropriately assume that the reader knows the
> waker mechanism in depth.  And they do not stress at all how important
> this improvement is.
> 
> I'll do my best to improve these comments.
> 
> To try to do a better job, let me also explain the matter early here.
> Maybe you or others can give me some early feedback (or just tell me
> to proceed).
> 
> This change is one of the main improvements that boosted
> throughput in Jan's tests.  Here is the rationale:
> - consider a bfq_queue, say Q1, detected as a waker of another
>   bfq_queue, say Q2
> - by definition of a waker, Q1 blocks the I/O of Q2, i.e., some I/O of
>   of Q1 needs to be completed for new I/O of Q1 to arrive.  A notable
					       ^^ Q2?

>   example is journald
> - so, Q1 and Q2 are in any respect two cooperating processes: if the
>   service of Q1's I/O is delayed, Q2 can only suffer from it.
>   Conversely, if Q2's I/O is delayed, the purpose of Q1 is just defeated.

What do you exactly mean by this last sentence?

> - as a consequence if some I/O of Q1/Q2 arrives while Q2/Q1 is the
>   only queue in service, there is absolutely no point in delaying the
>   service of such an I/O.  The only possible result is a throughput
>   loss, detected by Jan's test

If we are idling at that moment waiting for more IO from in service queue,
I agree. But that doesn't seem to be part of your condition above?

> - so, when the above condition holds, the most effective and efficient
>   action is to put the new I/O directly in the dispatch list
> - as an additional restriction, Q1 and Q2 must be the only busy queues
>   for this commit to put the I/O of Q2/Q1 in the dispatch list.  This is
>   necessary, because, if also other queues are waiting for service, then
>   putting new I/O directly in the dispatch list may evidently cause a
>   violation of service guarantees for the other queues

This last restriction is not ideal for cases like jbd2 thread since it may
still lead to pointless idling but I understand that without some
restriction like this several waking threads could just starve other ones.
So I guess it's fine for now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

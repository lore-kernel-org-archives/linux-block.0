Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4962C74A35
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B1B208C4
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FV/5h0s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGJUfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:35:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJUfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g53p1XW5kDOlX+GJyMiMQr37L/DBPvbm74BNpx02pAc=; b=FV/5h0s8NgLiIUbH+/f2540gf
        lfsM4q9pJ/eHxfvLqgBQvXXJcAch8FxYM/z2R/qnONYTO4MAKd1WL3vAPHOQXy5F9ccD9oEGS50C7
        GUS6+EjSeAsEt319iXYZeZDRRlBP3LpPNNhn22gz/5ZixF1dFd6UrFk4L6ExXHeJYfNQEDTxQXiZy
        4+CIfLULORtxMl+SY2IUTO9tFjopCIn5OEbp+UYuxlWBUfVR7sumBDqG9JG9YCjcTzJjK6TUloA+S
        oQz+ambfPPXs5IShif7TJUZW/mpKgvo1gzaCvEPVNsGPyEYzA5poZ1ZHmDJuzxhRjWqmv9NxKEAB4
        2zyMOaw3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlJJ9-00048H-Bw; Wed, 10 Jul 2019 20:35:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4C75201247E6; Wed, 10 Jul 2019 22:35:16 +0200 (CEST)
Date:   Wed, 10 Jul 2019 22:35:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/2] wait: add wq_has_multiple_sleepers helper
Message-ID: <20190710203516.GL3419@hirez.programming.kicks-ass.net>
References: <20190710195227.92322-1-josef@toxicpanda.com>
 <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe73e4e-9270-46ac-16d7-39a40485fe53@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 10, 2019 at 02:23:23PM -0600, Jens Axboe wrote:
> On 7/10/19 1:52 PM, Josef Bacik wrote:
> > rq-qos sits in the io path so we want to take locks as sparingly as
> > possible.  To accomplish this we try not to take the waitqueue head lock
> > unless we are sure we need to go to sleep, and we have an optimization
> > to make sure that we don't starve out existing waiters.  Since we check
> > if there are existing waiters locklessly we need to be able to update
> > our view of the waitqueue list after we've added ourselves to the
> > waitqueue.  Accomplish this by adding this helper to see if there are
> > more than two waiters on the waitqueue.
> > 
> > Suggested-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   include/linux/wait.h | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/include/linux/wait.h b/include/linux/wait.h
> > index b6f77cf60dd7..89c41a7b3046 100644
> > --- a/include/linux/wait.h
> > +++ b/include/linux/wait.h
> > @@ -126,6 +126,27 @@ static inline int waitqueue_active(struct wait_queue_head *wq_head)
> >   	return !list_empty(&wq_head->head);
> >   }
> >   
> > +/**
> > + * wq_has_multiple_sleepers - check if there are multiple waiting prcesses
> > + * @wq_head: wait queue head
> > + *
> > + * Returns true of wq_head has multiple waiting processes.
> > + *
> > + * Please refer to the comment for waitqueue_active.
> > + */
> > +static inline bool wq_has_multiple_sleepers(struct wait_queue_head *wq_head)
> > +{
> > +	/*
> > +	 * We need to be sure we are in sync with the
> > +	 * add_wait_queue modifications to the wait queue.
> > +	 *
> > +	 * This memory barrier should be paired with one on the
> > +	 * waiting side.
> > +	 */
> > +	smp_mb();
> > +	return !list_is_singular(&wq_head->head);
> > +}
> > +
> >   /**
> >    * wq_has_sleeper - check if there are any waiting processes
> >    * @wq_head: wait queue head
> 
> This (and 2/2) looks good to me, better than v1 for sure. Peter/Ingo,
> are you OK with adding this new helper? For reference, this (and the
> next patch) replace the alternative, which is an open-coding of
> prepare_to_wait():
> 
> https://lore.kernel.org/linux-block/20190710190514.86911-1-josef@toxicpanda.com/

Yet another approach would be to have prepare_to_wait*() return this
state, but I think this is ok.

The smp_mb() is superfluous -- in your specific case -- since
preprare_to_wait*() already does one through set_current_state().

So you could do without it, I think.


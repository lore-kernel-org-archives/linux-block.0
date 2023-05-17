Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7812C7EE22
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 03:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjEQD1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjEQD1d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 23:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C6134
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684294005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YW21jshCLIf6oU+mp9gXDvVkIXWNzY2JEwg5reGbUWk=;
        b=bn3aoUC0d/s/qM0TrR+ijADnmD8PCbJWX/vs0X8piat1MPCEwSDrfsL45wQyxHVXJlxOkK
        Mz15Rb4rIDENFAl/Nko5shkO7YaMHMlDu1aj+pf/XnipAXV7pEbhc4Yk6gZFFJDAX1yqXc
        gxYG/UDc+iL5JUd0isOJDvLVL2lAxDI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-QEt8dFvbNvinqRBVo-8iFg-1; Tue, 16 May 2023 23:26:41 -0400
X-MC-Unique: QEt8dFvbNvinqRBVo-8iFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 644FB1C060D4;
        Wed, 17 May 2023 03:26:41 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AD0C15BA0;
        Wed, 17 May 2023 03:26:37 +0000 (UTC)
Date:   Wed, 17 May 2023 11:26:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ming.lei@redhat.com
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGRJaLSx6hToubQ7@ovpn-8-19.pek2.redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
 <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
 <ZGOXkhzPplCfK6kc@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGOXkhzPplCfK6kc@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 08:47:46AM -0600, Keith Busch wrote:
> On Tue, May 16, 2023 at 09:20:55AM +0800, Ming Lei wrote:
> > On Mon, May 15, 2023 at 02:22:18PM -0600, Keith Busch wrote:
> > > On Mon, May 15, 2023 at 08:52:38AM -0700, Bart Van Assche wrote:
> > > > On 5/15/23 07:46, Ming Lei wrote:
> > > > > @@ -48,7 +53,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
> > > > >   static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> > > > >   {
> > > > > -	if (rq->rq_flags & RQF_ELV) {
> > > > > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> > > > >   		struct elevator_queue *e = rq->q->elevator;
> > > > >   		if (e->type->ops.completed_request)
> > > > > @@ -58,7 +63,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> > > > >   static inline void blk_mq_sched_requeue_request(struct request *rq)
> > > > >   {
> > > > > -	if (rq->rq_flags & RQF_ELV) {
> > > > > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> > > > >   		struct request_queue *q = rq->q;
> > > > >   		struct elevator_queue *e = q->elevator;
> > > > 
> > > > Has it been considered not to set RQF_ELV for passthrough requests instead
> > > > of making the above changes?
> > > 
> > > That sounds like a good idea. It changes more behavior than what Ming is
> > > targeting here, but after looking through each use for RQF_ELV, I think
> > > not having that set really is the right thing to do in all cases for
> > > passthrough requests.
> > 
> > I did consider that approach. But:
> > 
> > - RQF_ELV actually means that the request & its tag is allocated from sched tags.
> > 
> > - if RQF_ELV is cleared for passthrough request, request may be
> >   allocated from sched tags(normal IO) and driver tags(passthrough) at the same time.
> >   This way may cause other problem, such as, breaking blk_mq_hctx_has_requests().
> >   Meantime it becomes not likely to optimize tags resource utilization in future,
> >   at least for single LUN/NS, no need to keep sched tags & driver tags
> >   in memory at the same time.
> 
> Isn't that similar to multiple namespaces where some use elevator and
> others use 'none'? They're all contenting for the same shared driver
> tags with racing 'has_requests()'.

It is similar, but not same.

So far, for each single request queue, we never support to allocate
request/tag from both sched tags and driver tags at the same.

If we clear RQF_ELV simply for pt request, at least:

1) blk_mq_hctx_has_requests() is broken since this function only checks
sched tags in case of q->elevator

2) q->nr_requests may not be respected any more in case of q->elevator

> And the passthrough case is special with users of that interface taking
> on a greater responsibility and generally want the kernel out of the
> way. I don't think anyone would purposefully run a tag intense workload
> through that engine at the same time as using a generic one with the
> scheduler. It definitely should still work, but it doesn't need to be
> fair, right?

I guess it may work, but question is that what we can get from this kind
of big change? And I think this approach may be one following work if it is
proved as useful.


Thanks,
Ming


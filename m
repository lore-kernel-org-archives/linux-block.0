Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CFC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 01:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEPBVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEPBVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 21:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA8E7A
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684200070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97z9uGMqVveITayR8uM1V9nIhitiNIePFD6gcCDa2w0=;
        b=aRFRk2dG5J+BZAT6NknAkkDB+QgQdvrXbslnitnNNXgeFI5wCG+xISQ9qFpHP9uhHG0Naq
        2Sj4Y64upmA99AysmSWDTqT7UQcdkQIhNCjfm5Tc7gvfY47q3ccyZSGuPyI0Cq17Vf/0PA
        PwAR7FwYczNyt2JPpQntUFSFM9ZleQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-Oc8-OxXYOLWJ6zkKR_DRug-1; Mon, 15 May 2023 21:21:07 -0400
X-MC-Unique: Oc8-OxXYOLWJ6zkKR_DRug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0171688646F;
        Tue, 16 May 2023 01:21:07 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F701121314;
        Tue, 16 May 2023 01:21:00 +0000 (UTC)
Date:   Tue, 16 May 2023 09:20:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ming.lei@redhat.com
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com>
References: <20230515144601.52811-1-ming.lei@redhat.com>
 <20230515144601.52811-3-ming.lei@redhat.com>
 <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org>
 <ZGKUehOEnKThjFpR@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKUehOEnKThjFpR@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 02:22:18PM -0600, Keith Busch wrote:
> On Mon, May 15, 2023 at 08:52:38AM -0700, Bart Van Assche wrote:
> > On 5/15/23 07:46, Ming Lei wrote:
> > > @@ -48,7 +53,7 @@ blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
> > >   static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> > >   {
> > > -	if (rq->rq_flags & RQF_ELV) {
> > > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> > >   		struct elevator_queue *e = rq->q->elevator;
> > >   		if (e->type->ops.completed_request)
> > > @@ -58,7 +63,7 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
> > >   static inline void blk_mq_sched_requeue_request(struct request *rq)
> > >   {
> > > -	if (rq->rq_flags & RQF_ELV) {
> > > +	if ((rq->rq_flags & RQF_ELV) && !blk_mq_bypass_sched(rq->cmd_flags)) {
> > >   		struct request_queue *q = rq->q;
> > >   		struct elevator_queue *e = q->elevator;
> > 
> > Has it been considered not to set RQF_ELV for passthrough requests instead
> > of making the above changes?
> 
> That sounds like a good idea. It changes more behavior than what Ming is
> targeting here, but after looking through each use for RQF_ELV, I think
> not having that set really is the right thing to do in all cases for
> passthrough requests.

I did consider that approach. But:

- RQF_ELV actually means that the request & its tag is allocated from sched tags.

- if RQF_ELV is cleared for passthrough request, request may be
  allocated from sched tags(normal IO) and driver tags(passthrough) at the same time.
  This way may cause other problem, such as, breaking blk_mq_hctx_has_requests().
  Meantime it becomes not likely to optimize tags resource utilization in future,
  at least for single LUN/NS, no need to keep sched tags & driver tags
  in memory at the same time.


Thanks,
Ming


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792BC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A7064E20
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 08:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhCSItF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234215AbhCSIs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 04:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616143737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EzfG6Okq8cbKKVAIMAgpy2oQ67uh4c8LEcVFP5ZN6as=;
        b=iPpYdSDdFywM1qfkndZfV8reb3qIu89/gMyP6if0w3eYg+c4ZYu3FPjwj4Uw6bwH/UXXzh
        NplIMGkf+Z7sNnCbDrdbBAHW/FB6zIga+xQEINaQYdSr76BoMSwopOX0qWPWPouNjO6zRq
        MI4tiG7Tt/N8H7S0zxDX0cpg2JEf/80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-qiV3Oj-PMSmWGoGVkf8CtQ-1; Fri, 19 Mar 2021 04:48:53 -0400
X-MC-Unique: qiV3Oj-PMSmWGoGVkf8CtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 549AA81744F;
        Fri, 19 Mar 2021 08:48:52 +0000 (UTC)
Received: from T590 (ovpn-13-148.pek2.redhat.com [10.72.13.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC155C1D1;
        Fri, 19 Mar 2021 08:48:39 +0000 (UTC)
Date:   Fri, 19 Mar 2021 16:48:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [RFC PATCH V2 05/13] block: add req flag of REQ_TAG
Message-ID: <YFRlYw0efpq/PfMu@T590>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-6-ming.lei@redhat.com>
 <50e454b9-2027-cf38-0be7-a4ecfdd54027@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e454b9-2027-cf38-0be7-a4ecfdd54027@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 03:59:06PM +0800, JeffleXu wrote:
> 
> 
> On 3/19/21 12:48 AM, Ming Lei wrote:
> > Add one req flag REQ_TAG which will be used in the following patch for
> > supporting bio based IO polling.
> > 
> > Exactly this flag can help us to do:
> > 
> > 1) request flag is cloned in bio_fast_clone(), so if we mark one FS bio
> > as REQ_TAG, all bios cloned from this FS bio will be marked as REQ_TAG.
> > 
> > 2)create per-task io polling context if the bio based queue supports polling
> > and the submitted bio is HIPRI. This per-task io polling context will be
> > created during submit_bio() before marking this HIPRI bio as REQ_TAG. Then
> > we can avoid to create such io polling context if one cloned bio with REQ_TAG
> > is submitted from another kernel context.
> > 
> > 3) for supporting bio based io polling, we need to poll IOs from all
> > underlying queues of bio device/driver, this way help us to recognize which
> > IOs need to polled in bio based style, which will be implemented in next
> > patch.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c          | 29 +++++++++++++++++++++++++++--
> >  include/linux/blk_types.h |  4 ++++
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 0b00c21cbefb..efc7a61a84b4 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -840,11 +840,30 @@ static inline bool blk_queue_support_bio_poll(struct request_queue *q)
> >  static inline void blk_bio_poll_preprocess(struct request_queue *q,
> >  		struct bio *bio)
> >  {
> > +	bool mq;
> > +
> >  	if (!(bio->bi_opf & REQ_HIPRI))
> >  		return;
> >  
> > -	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
> > +	/*
> > +	 * Can't support bio based IO poll without per-task poll queue
> > +	 *
> > +	 * Now we have created per-task io poll context, and mark this
> > +	 * bio as REQ_TAG, so: 1) if any cloned bio from this bio is
> > +	 * submitted from another kernel context, we won't create bio
> > +	 * poll context for it, so that bio will be completed by IRQ;
> > +	 * 2) If such bio is submitted from current context, we will
> > +	 * complete it via blk_poll(); 3) If driver knows that one
> > +	 * underlying bio allocated from driver is for FS bio, meantime
> > +	 * it is submitted in current context, driver can mark such bio
> > +	 * as REQ_TAG manually, so the bio can be completed via blk_poll
> > +	 * too.
> > +	 */
> 
> Sorry I can't understand case 3, could you please further explain it? If

I meant driver may allocate bio and submit it in current context, and this
allocated bio is for completing FS hipri bio too. So far, HIPRI won't be
set for this bio, but driver may mark this bio as HIPRI and TAG, so this
created bio can be polled.

> 'driver marks such bio as REQ_TAG manually', then per-task io poll
> context won't be created, and thus REQ_HIPRI will be cleared, in which
> case the bio will be completed by IRQ. How could it be completed by
> blk_poll()?

The io poll context is created when FS HIPRI bio on based queue(DM) is
submitted, at that time, bio based driver's ->submit_bio isn't called
yet. So when bio driver's ->submit_bio() allocates new bios and submits
them in current context, if driver marks this bio as HIPRI and TAG, they
can be polled too.

> 
> 
> > +	mq = queue_is_mq(q);
> > +	if (!blk_queue_poll(q) || (!mq && !blk_get_bio_poll_ctx()))
> >  		bio->bi_opf &= ~REQ_HIPRI;
> 
> 
> 
> 
> If the use cases are mixed, saying one kernel context may submit IO with
> and without REQ_TAG at the meantime (though I don't know if this
> situation exists), then the above code may not work as we expect.

Poll context shouldn't be created for kernel context.

So far, this patch won't cover bios submitted from kernel context, and
for any bios submitted from kernel context, their HIPRI will be cleared.

> 
> For example, dm-XXX will return DM_MAPIO_SUBMITTED and actually submits
> the cloned bio (with REQ_TAG) with internal kernel threads. Besides,
> dm-XXX will also allocate bio (without REQ_TAG) of itself for metadata
> logging or something. When submitting bios (without REQ_TAG), per-task

But HIPRI won't be set for this allocated bio.

> io poll context will be allocated. Later when submitting cloned bios
> (with REQ_TAG), the poll context already exists and thus REQ_HIPRI is
> kept for these bios and they are submitted to polling hw queues.

Originally I planed to add new helper of submit_poll_bio() for current
HIPRI uses, and only create poll context in this code path, this way can
decouple REQ_TAG a bit. But looks it is enough to re-use REQ_TAG for this
purpose. If not, it can be quite easy to address issue wrt. creating poll
context.


Thanks, 
Ming


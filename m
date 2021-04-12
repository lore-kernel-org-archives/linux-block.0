Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004FC433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BC561249
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhDLKiP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237219AbhDLKiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 06:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618223876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJaC9Tv4FQ16V7YCWGtMDnQud+2HqURFE3LCjFaikWw=;
        b=ZFOnrqtluB1SP7pO0gCTOJhhHpR0OZ+4enPJ6zBqoxR5MpgPXKV1uYk8lO2r9TgdM04npx
        3axsFz9SYqsbcxEi2CtZPGb/qYj08WmHhr9BWk0RBf6VYm5Uzmne9ioMFtIBmpXPaZBQmr
        LnsW7s58STwiNZ9scNIfdX/54zeCwaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-T6ILtFIGMW-GJWidXC0IkQ-1; Mon, 12 Apr 2021 06:37:55 -0400
X-MC-Unique: T6ILtFIGMW-GJWidXC0IkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C69E91270;
        Mon, 12 Apr 2021 10:37:54 +0000 (UTC)
Received: from T590 (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 127776A04E;
        Mon, 12 Apr 2021 10:37:38 +0000 (UTC)
Date:   Mon, 12 Apr 2021 18:37:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 08/12] block: use per-task poll context to implement
 bio based io polling
Message-ID: <YHQi7rZ5StWUpX/r@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-9-ming.lei@redhat.com>
 <20210412101659.GA993044@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412101659.GA993044@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 11:16:59AM +0100, Christoph Hellwig wrote:
> > +static int blk_bio_poll_io(struct io_context *submit_ioc,
> > +		struct io_context *poll_ioc)
> 
> Givem that poll_ioc is always current->io_context there is no
> need to pass it.

Yeah, it is true.

> 
> > +	struct blk_bio_poll_ctx *poll_ctx = poll_ioc ?
> > +		poll_ioc->data : NULL;
> 
> and it really should not be NULL here, should it?

Yeah, it is NULL just in case of memory allocation failure.

> 
> > +static int __blk_bio_poll(blk_qc_t cookie)
> > +{
> > +	struct io_context *poll_ioc = current->io_context;
> > +	pid_t pid;
> > +	struct task_struct *submit_task;
> > +	int ret;
> > +
> > +	pid = (pid_t)cookie;
> > +
> > +	/* io poll often share io submission context */
> > +	if (likely(current->pid == pid && blk_bio_ioc_valid(current)))
> > +		return blk_bio_poll_io(poll_ioc, poll_ioc);
> > +
> > +	submit_task = find_get_task_by_vpid(pid);
> > +	if (likely(blk_bio_ioc_valid(submit_task)))
> > +		ret = blk_bio_poll_io(submit_task->io_context, poll_ioc);
> > +	else
> > +		ret = 0;
> > +	if (likely(submit_task))
> > +		put_task_struct(submit_task);
> 
> Wouldn't it make more sense to just store the submitting context
> in the bio, even if that uses more space?  Having to call

But where to store the submitting context in bio? pid is 32bit and we can
pass it from submit_bio() perfectly, then avoid to add anything to bio.

If we save the submitting context in bio, we still have to handle task
exit related race, not see any benefit.

So far bio is ~128byte with typical setting, and people usually hate to
add more stuff into bio.

> find_get_task_by_vpid in the poll context seems rather problematic.

Why? We already handle submit context early exit.

> 
> Note that this requires doing the refacoring to get rid of the separate
> blk_qc_t passed up the stack I asked for earlier, but hiding all these
> details seems like a really useful change anyway.

That is hard to do because of race between submission and completion:

1) HIPRI could be cleared because of bio splitting, so we can't do that
for this kind of bio

2) we have to make sure that the bio won't be completed when storing
cookie into this bio. BIO_END_BY_POLL is added in this patch for bio
based polling. You mean we may cover all normal blk-mq polling via
BIO_END_BY_POLL?



Thanks,
Ming


Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6DDC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F412053B
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASbtdgQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgD1IbH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:31:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26819 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726573AbgD1IbH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588062665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ab99XoYEuOIY8Thb6anQeIWlSiAjUkSTV+mHr2LK9cI=;
        b=ASbtdgQ54U1wVqTSaHMl6fTE6V0jpDsXKWVd/sa7ITCYTljqXt5g+Rf5b86FV4Uk3n/D/s
        WRAP7bnNQN9GTRMBttQ+PyvY5NcCwpEhv1HgjDsoUeaN+LFJ89zHAct/ckNdpQpYmgIq9Q
        zuqJw0yT/Vw126Ni+BG1bGLdwdZiJ0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-1f53pnNVOj6tjT76cU32AA-1; Tue, 28 Apr 2020 04:31:01 -0400
X-MC-Unique: 1f53pnNVOj6tjT76cU32AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C65800D24;
        Tue, 28 Apr 2020 08:30:59 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDC6B1001920;
        Tue, 28 Apr 2020 08:30:52 +0000 (UTC)
Date:   Tue, 28 Apr 2020 16:30:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding
 task hung in sync IO
Message-ID: <20200428083047.GA624552@T590>
References: <20200428074657.645441-1-ming.lei@redhat.com>
 <20200428074657.645441-2-ming.lei@redhat.com>
 <71710192-1262-6f08-e38b-565ec6a32858@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71710192-1262-6f08-e38b-565ec6a32858@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 10:05:36AM +0200, Hannes Reinecke wrote:
> On 4/28/20 9:46 AM, Ming Lei wrote:
> > Add helper of blk_default_io_timeout(), so that the two current users
> > can benefit from it.
> > 
> > Also direct IO users will use it in the following patch, so define the
> > helper in public header.
> > 
> > Cc: Salman Qazi <sqazi@google.com>
> > Cc: Jesse Barnes <jsbarnes@google.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/bio.c            |  9 +++------
> >   block/blk-exec.c       |  8 +++-----
> >   include/linux/blkdev.h | 10 ++++++++++
> >   3 files changed, 16 insertions(+), 11 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 21cbaa6a1c20..f67afa159de7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1069,18 +1069,15 @@ static void submit_bio_wait_endio(struct bio *bio)
> >   int submit_bio_wait(struct bio *bio)
> >   {
> >   	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> > -	unsigned long hang_check;
> > +	unsigned long timeout = blk_default_io_timeout();
> >   	bio->bi_private = &done;
> >   	bio->bi_end_io = submit_bio_wait_endio;
> >   	bio->bi_opf |= REQ_SYNC;
> >   	submit_bio(bio);
> > -	/* Prevent hang_check timer from firing at us during very long I/O */
> > -	hang_check = sysctl_hung_task_timeout_secs;
> > -	if (hang_check)
> > -		while (!wait_for_completion_io_timeout(&done,
> > -					hang_check * (HZ/2)))
> > +	if (timeout)
> > +		while (!wait_for_completion_io_timeout(&done, timeout))
> >   			;
> >   	else
> >   		wait_for_completion_io(&done);
> > diff --git a/block/blk-exec.c b/block/blk-exec.c
> > index e20a852ae432..17b5cf07e1a3 100644
> > --- a/block/blk-exec.c
> > +++ b/block/blk-exec.c
> > @@ -80,15 +80,13 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
> >   		   struct request *rq, int at_head)
> >   {
> >   	DECLARE_COMPLETION_ONSTACK(wait);
> > -	unsigned long hang_check;
> > +	unsigned long timeout = blk_default_io_timeout();
> >   	rq->end_io_data = &wait;
> >   	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
> > -	/* Prevent hang_check timer from firing at us during very long I/O */
> > -	hang_check = sysctl_hung_task_timeout_secs;
> > -	if (hang_check)
> > -		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
> > +	if (timeout)
> > +		while (!wait_for_completion_io_timeout(&wait, timeout));
> >   	else
> >   		wait_for_completion_io(&wait);
> >   }
> This probably just shows my ignorance, but why don't we check for
> rq->timeout here?
> I do see that not all requests have a timeout, but what about those who
> have?

Here the IO means IO from upper layer(FS, user space, ...), and this
kind of IO isn't same with block layer's IO request which is splitted
from upper layer's bio.

So we can't apply the rq->timeout directly, especially we want to avoid
the task hung on the sync IO from upper layer.

Thanks,
Ming


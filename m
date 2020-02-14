Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04D2C352A3
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 00:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901E62187F
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 00:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOPZJgj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgBNAZ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:25:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41157 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727604AbgBNAZ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 19:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581639959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOuyJfMfPTaKw6DAz8xXan7RlS4xgiXwLj+Ny+dnSmo=;
        b=eOPZJgj7UL+o3Tm51Dl4XlWWzJ5xfwZAxsOvzy/bvlWyAnJFgWwxaRF1wkYojceV/hXJEl
        /QWQjQUxyumi/R0R/BgiaZokRt3ZAY/6840fwvlSYmpdSbW55KUme8KuLQMOSozB0TLO0H
        XiP/IQBCaHsNGsRMHoqYzz3J7iElU7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-BM4H64XGMuWV1aBsm-tH9A-1; Thu, 13 Feb 2020 19:25:51 -0500
X-MC-Unique: BM4H64XGMuWV1aBsm-tH9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507FE1851FC2;
        Fri, 14 Feb 2020 00:25:49 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA18219C70;
        Fri, 14 Feb 2020 00:25:42 +0000 (UTC)
Date:   Fri, 14 Feb 2020 08:25:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
Message-ID: <20200214002538.GA4907@ming.t460p>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p>
 <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 13, 2020 at 11:21:37AM -0800, Salman Qazi wrote:
> On Thu, Feb 13, 2020 at 9:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2/13/20 12:26 AM, Ming Lei wrote:
> > > The approach used in blk_execute_rq() can be borrowed for workaround the
> > > issue, such as:
> > >
> > > diff --git a/block/bio.c b/block/bio.c
> > > index 94d697217887..c9ce19a86de7 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/cgroup.h>
> > >   #include <linux/blk-cgroup.h>
> > >   #include <linux/highmem.h>
> > > +#include <linux/sched/sysctl.h>
> > >
> > >   #include <trace/events/block.h>
> > >   #include "blk.h"
> > > @@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
> > >   int submit_bio_wait(struct bio *bio)
> > >   {
> > >       DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> > > +     unsigned long hang_check;
> > >
> > >       bio->bi_private = &done;
> > >       bio->bi_end_io = submit_bio_wait_endio;
> > >       bio->bi_opf |= REQ_SYNC;
> > >       submit_bio(bio);
> > > -     wait_for_completion_io(&done);
> > > +
> > > +     /* Prevent hang_check timer from firing at us during very long I/O */
> > > +     hang_check = sysctl_hung_task_timeout_secs;
> > > +     if (hang_check)
> > > +             while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> > > +     else
> > > +             wait_for_completion_io(&done);
> > >
> > >       return blk_status_to_errno(bio->bi_status);
> > >   }
> >
> > Instead of suppressing the hung task complaints, has it been considered
> > to use the bio splitting mechanism to make discard bios smaller? Block
> > drivers may set a limit by calling blk_queue_max_discard_segments().
> >  From block/blk-settings.c:
> >
> > /**
> >   * blk_queue_max_discard_segments - set max segments for discard
> >   * requests
> >   * @q:  the request queue for the device
> >   * @max_segments:  max number of segments
> >   *
> >   * Description:
> >   *    Enables a low level driver to set an upper limit on the number of
> >   *    segments in a discard request.
> >   **/
> > void blk_queue_max_discard_segments(struct request_queue *q,
> >                 unsigned short max_segments)
> > {
> >         q->limits.max_discard_segments = max_segments;
> > }
> > EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
> >
> 
> AFAICT, This is not actually sufficient, because the issuer of the bio
> is waiting for the entire bio, regardless of how it is split later.

Right.

> But, also there isn't a good mapping between the size of the secure
> discard and how long it will take.  If given the geometry of a flash
> device, it is not hard to construct a scenario where a relatively
> small secure discard (few thousand sectors) will take a very long time
> (multiple seconds).

It isn't strange to see such implementation, and I also see discard
request timeout.

> 
> Having said that, I don't like neutering the hung task timer either.

But it does fix the hung warning, doesn't it?

thanks,
Ming


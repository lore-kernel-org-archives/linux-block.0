Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEB5C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EC220693
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5QPUO8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgENBR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 21:17:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENBR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589419044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cs0v5GF6uAqTceIr1iKMVj/3sReM3zCfYpAM8pXdGi4=;
        b=E5QPUO8hGHHc65A9oEvdpGOgMmCZhw5Z826V7rjn9OuTb6ZQxJen1d9+/3BbQiXqchFqej
        MUcugcMT1TUBP+t9ZfIflBfXPagWdv5e9fUjTZkf9qLOKxG7guylHElvb/kgy5rkm0Ai1x
        JcYo/wncI6LzaZ4kFBgWUEMnuDoIL1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402--S2xhneFPmSocP2k16k2Pw-1; Wed, 13 May 2020 21:17:22 -0400
X-MC-Unique: -S2xhneFPmSocP2k16k2Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA69107B7C3;
        Thu, 14 May 2020 01:17:21 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 859BB60C05;
        Thu, 14 May 2020 01:17:14 +0000 (UTC)
Date:   Thu, 14 May 2020 09:17:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2] block: add blk_io_schedule() for avoiding task hung
 in sync dio
Message-ID: <20200514011710.GF2073570@T590>
References: <20200503015422.1123994-1-ming.lei@redhat.com>
 <20200514011110.GA79384@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514011110.GA79384@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 01:11:10AM +0000, Satya Tangirala wrote:
> On Sun, May 03, 2020 at 09:54:22AM +0800, Ming Lei wrote:
> > Sync dio could be big, or may take long time in discard or in case of
> > IO failure.
> > 
> > We have prevented task hung in submit_bio_wait() and blk_execute_rq(),
> > so apply the same trick for prevent task hung from happening in sync dio.
> > 
> > Add helper of blk_io_schedule() and use io_schedule_timeout() to prevent
> > task hung warning.
> > 
> > Cc: Salman Qazi <sqazi@google.com>
> > Cc: Jesse Barnes <jsbarnes@google.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- drop helper of blk_default_io_timeout()
> > 
> > 
> >  fs/block_dev.c         |  4 ++--
> >  fs/direct-io.c         |  2 +-
> >  fs/iomap/direct-io.c   |  2 +-
> >  include/linux/blkdev.h | 12 ++++++++++++
> >  4 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 5eb30a474f6d..3b396f8c967c 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -256,7 +256,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
> >  			break;
> >  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> >  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> > -			io_schedule();
> > +			blk_io_schedule();
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> >  
> > @@ -450,7 +450,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
> >  
> >  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> >  		    !blk_poll(bdev_get_queue(bdev), qc, true))
> > -			io_schedule();
> > +			blk_io_schedule();
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> >  
> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index 00b4d15bb811..6d5370eac2a8 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -500,7 +500,7 @@ static struct bio *dio_await_one(struct dio *dio)
> >  		spin_unlock_irqrestore(&dio->bio_lock, flags);
> >  		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
> >  		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
> > -			io_schedule();
> > +			blk_io_schedule();
> >  		/* wake up sets us TASK_RUNNING */
> >  		spin_lock_irqsave(&dio->bio_lock, flags);
> >  		dio->waiter = NULL;
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 20dde5aadcdd..fd3bd06fabb6 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -561,7 +561,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  			    !dio->submit.last_queue ||
> >  			    !blk_poll(dio->submit.last_queue,
> >  					 dio->submit.cookie, true))
> > -				io_schedule();
> > +				blk_io_schedule();
> >  		}
> >  		__set_current_state(TASK_RUNNING);
> >  	}
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index f00bd4042295..222eb5f32279 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -27,6 +27,7 @@
> >  #include <linux/percpu-refcount.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/blkzoned.h>
> > +#include <linux/sched/sysctl.h>
> >  
> >  struct module;
> >  struct scsi_ioctl_command;
> > @@ -1827,4 +1828,15 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
> >  		wake_up_process(waiter);
> >  }
> >  
> > +static inline void blk_io_schedule(void)
> > +{
> > +	/* Prevent hang_check timer from firing at us during very long I/O */
> > +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
> > +
> > +	if (timeout)
> > +		io_schedule_timeout(timeout);
> > +	else
> > +		io_schedule();
> > +}
> > +
> >  #endif
> This won't compile without CONFIG_BLOCK, since this patch includes

Thanks for the report.

> linux/sched/sysctl.h only inside the #ifdef CONFIG_BLOCK, while blk_io_schedule
> is declared outside the #ifdef CONFIG_BLOCK, but references
> sysctl_hung_task_timeout_secs defined in linux/sched/sysctl.h. Afaict, the
> function isn't needed without CONFIG_BLOCK, so maybe we should move the
> function into the #ifdef CONFIG_BLOCK too?

Given io_schedule() is always available, I'd suggest to move
"#include <linux/sched/sysctl.h>" out of '#ifdef CONFIG_BLOCK', does the
following patch fixes the issue?

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5360696d85ff..bf99a723673b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/sysctl.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -27,7 +28,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/sched/sysctl.h>
 
 struct module;
 struct scsi_ioctl_command;

thanks,
Ming


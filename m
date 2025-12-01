Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93D1917F1
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764558282; cv=none; b=af7Y7oNSqcWM779rcCe05urD4gUHfnJF2lc4faLUBwQxXdWTA3wsagfcJRkDkdr5aeA1OY6LcFhjaGaNlhb/QOwo/lNM1xX6aQwoYxv4b3ZUwHUCG/GkGX2X5Sj2+JkhFwE6XAVU1M9+Ief8Yhy34sa5FYy8XBePjw99+bOTJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764558282; c=relaxed/simple;
	bh=82TQz7BpisGdgCQ5LbzZc3uxrJs2It9EUmWn0mPWO1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq1/+aUypW7Z5ztMPaUIyhUvmg9zDhOqP7EWolNyZKecuesTo7uQdQl5C3bC8BXEI7oU7goqX+e9S4KUyBfBMgNfZx1cGRaaKUnvFOlodjPcVc258zNoDco+cEGD9La22aeeZyx7k9ZJAL/R/pRnILqmPttQnPCAEzoD3oeOqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GO5d6oKk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GO5d6oKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764558278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbQthsR/1ur/34Ya3Fg/bq2vJkt9LYT4D2EV/lNYgy8=;
	b=GO5d6oKkzlnBVB36kGFwf9NxMXZxuTYIdDC1Xk5dNavAM2dZDxuB2MMztvkcUvN9zWhjXF
	iSUzUC++buIVc/F5siYBzccjQYpculbEC4jUdtBJM7QCut9mjH3y0XGNxjGfPyNxnm24de
	O8PZmPqgm8WPcpF28DkSsxbdHfvEDHc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-I7kvaYQCOeex_L1xw_3yrg-1; Sun,
 30 Nov 2025 22:04:35 -0500
X-MC-Unique: I7kvaYQCOeex_L1xw_3yrg-1
X-Mimecast-MFC-AGG-ID: I7kvaYQCOeex_L1xw_3yrg_1764558274
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87AD21800359;
	Mon,  1 Dec 2025 03:04:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4143030001B9;
	Mon,  1 Dec 2025 03:04:27 +0000 (UTC)
Date: Mon, 1 Dec 2025 11:04:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 12/27] ublk: add io events fifo structure
Message-ID: <aS0FtmO5LhltDG5-@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-13-ming.lei@redhat.com>
 <CADUfDZrfo7RzNZ7hGxOwK9fTWrwA4JEunahZQPvfO3EXT=1cTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrfo7RzNZ7hGxOwK9fTWrwA4JEunahZQPvfO3EXT=1cTQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Nov 30, 2025 at 08:53:03AM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 5:59 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add ublk io events fifo structure and prepare for supporting command
> > batch, which will use io_uring multishot uring_cmd for fetching one
> > batch of io commands each time.
> >
> > One nice feature of kfifo is to allow multiple producer vs single
> > consumer. We just need lock the producer side, meantime the single
> > consumer can be lockless.
> >
> > The producer is actually from ublk_queue_rq() or ublk_queue_rqs(), so
> > lock contention can be eased by setting proper blk-mq nr_queues.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 65 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index ea992366af5b..6ff284243630 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/task_work.h>
> >  #include <linux/namei.h>
> >  #include <linux/kref.h>
> > +#include <linux/kfifo.h>
> >  #include <uapi/linux/ublk_cmd.h>
> >
> >  #define UBLK_MINORS            (1U << MINORBITS)
> > @@ -217,6 +218,22 @@ struct ublk_queue {
> >         bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
> >         spinlock_t              cancel_lock;
> >         struct ublk_device *dev;
> > +
> > +       /*
> > +        * Inflight ublk request tag is saved in this fifo
> > +        *
> > +        * There are multiple writer from ublk_queue_rq() or ublk_queue_rqs(),
> > +        * so lock is required for storing request tag to fifo
> > +        *
> > +        * Make sure just one reader for fetching request from task work
> > +        * function to ublk server, so no need to grab the lock in reader
> > +        * side.
> 
> Can you clarify that this is only used for batch mode?

Yes.

> 
> > +        */
> > +       struct {
> > +               DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > +               spinlock_t evts_lock;
> > +       }____cacheline_aligned_in_smp;
> > +
> >         struct ublk_io ios[] __counted_by(q_depth);
> >  };
> >
> > @@ -282,6 +299,32 @@ static inline void ublk_io_unlock(struct ublk_io *io)
> >         spin_unlock(&io->lock);
> >  }
> >
> > +/* Initialize the queue */
> 
> "queue" -> "events queue"? Otherwise, it sounds like it's referring to
> struct ublk_queue.

OK.

> 
> > +static inline int ublk_io_evts_init(struct ublk_queue *q, unsigned int size,
> > +                                   int numa_node)
> > +{
> > +       spin_lock_init(&q->evts_lock);
> > +       return kfifo_alloc_node(&q->evts_fifo, size, GFP_KERNEL, numa_node);
> > +}
> > +
> > +/* Check if queue is empty */
> > +static inline bool ublk_io_evts_empty(const struct ublk_queue *q)
> > +{
> > +       return kfifo_is_empty(&q->evts_fifo);
> > +}
> > +
> > +/* Check if queue is full */
> > +static inline bool ublk_io_evts_full(const struct ublk_queue *q)
> 
> Function is unused?

Yes, will remove it.

> 
> > +{
> > +       return kfifo_is_full(&q->evts_fifo);
> > +}
> > +
> > +static inline void ublk_io_evts_deinit(struct ublk_queue *q)
> > +{
> > +       WARN_ON_ONCE(!kfifo_is_empty(&q->evts_fifo));
> > +       kfifo_free(&q->evts_fifo);
> > +}
> > +
> >  static inline struct ublksrv_io_desc *
> >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> >  {
> > @@ -3038,6 +3081,9 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
> >         if (ubq->io_cmd_buf)
> >                 free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
> >
> > +       if (ublk_dev_support_batch_io(ub))
> > +               ublk_io_evts_deinit(ubq);
> > +
> >         kvfree(ubq);
> >         ub->queues[q_id] = NULL;
> >  }
> > @@ -3062,7 +3108,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
> >         struct ublk_queue *ubq;
> >         struct page *page;
> >         int numa_node;
> > -       int size, i;
> > +       int size, i, ret = -ENOMEM;
> >
> >         /* Determine NUMA node based on queue's CPU affinity */
> >         numa_node = ublk_get_queue_numa_node(ub, q_id);
> > @@ -3081,18 +3127,27 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
> >
> >         /* Allocate I/O command buffer on local NUMA node */
> >         page = alloc_pages_node(numa_node, gfp_flags, get_order(size));
> > -       if (!page) {
> > -               kvfree(ubq);
> > -               return -ENOMEM;
> > -       }
> > +       if (!page)
> > +               goto fail_nomem;
> >         ubq->io_cmd_buf = page_address(page);
> >
> >         for (i = 0; i < ubq->q_depth; i++)
> >                 spin_lock_init(&ubq->ios[i].lock);
> >
> > +       if (ublk_dev_support_batch_io(ub)) {
> > +               ret = ublk_io_evts_init(ubq, ubq->q_depth, numa_node);
> > +               if (ret)
> > +                       goto fail;
> > +       }
> >         ub->queues[q_id] = ubq;
> >         ubq->dev = ub;
> > +
> >         return 0;
> > +fail:
> > +       ublk_deinit_queue(ub, q_id);
> 
> This is a no-op since ub->queues[q_id] hasn't been assigned yet?

Good catch, __ublk_deinit_queue(ub, ubq) can be added for solving the
failure handling.


Thanks,
Ming


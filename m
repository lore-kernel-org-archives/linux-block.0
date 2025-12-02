Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47307147C9B
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638841; cv=none; b=sQEEPkuOQz7UQJfl94VS6SQQYvAoS1nWfL+gxXPVDDZ9S//4v8b+riaOw0c3eLiJKAF0emUbCQMViLw0k5xxXlr9jrrvgAvBTtonPay9oWCpTykIbV+I/hvq+aWWm1wppUdvd1rhgtsnhKL5aVNyQTCLwG2+g+lSzWYYVQpJBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638841; c=relaxed/simple;
	bh=zVJ8efvrC7VMBVKJ5IAcDTyEslOp7et3LibdUYII89c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDeeEKC8XcFSyrUcbvg0Uizlp9VErkkV7Vc9SeJUvIWds7wkcH7ScpgZEIzUsUzNhXxbW+WSnmooIRXk6sxbtV1CQvdCQapcPR0CJYMuVWI9sueMRTAZhw/Rx6xkXNk2MiO6cbjH7vRxP3EKeLskVlfAMv3aSqgVJRd5snnxVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcEAymPc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcEAymPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764638838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxPu1h2ab+AsPsxmlrq73AoO9lgtz3ihb31y0rcaIKc=;
	b=gcEAymPcXJzM9EOfg30dNi5/pOTBKooqxawh62Mb+Sx1LR7QeERXjA7PnRyf4KMBzEHerN
	v0M63bfBkEE2Zs1BYwLAGH7BpimZUuyDdkuk5yBaidmkUPA2Z9UaSg0CB6BnFWYqbO8WLY
	S9lF2+87rjXPxU04RngtCCsg/XZS9ZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-Rw7sGbyDMveHT38xfsmlHg-1; Mon,
 01 Dec 2025 20:27:14 -0500
X-MC-Unique: Rw7sGbyDMveHT38xfsmlHg-1
X-Mimecast-MFC-AGG-ID: Rw7sGbyDMveHT38xfsmlHg_1764638833
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D35D1800561;
	Tue,  2 Dec 2025 01:27:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24D8330001A4;
	Tue,  2 Dec 2025 01:27:07 +0000 (UTC)
Date: Tue, 2 Dec 2025 09:27:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O
 processing
Message-ID: <aS5AZjizRDt7ql3T@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-15-ming.lei@redhat.com>
 <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
 <aS1i4RoP_mJXQiXk@fedora>
 <CADUfDZo0N22fp5+Si8eBE5SgRkCMsMa1VDTiLO_+zLWfUOVc9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo0N22fp5+Si8eBE5SgRkCMsMa1VDTiLO_+zLWfUOVc9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Dec 01, 2025 at 09:51:59AM -0800, Caleb Sander Mateos wrote:
> On Mon, Dec 1, 2025 at 1:42 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Sun, Nov 30, 2025 at 09:55:47PM -0800, Caleb Sander Mateos wrote:
> > > On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch processing
> > > > of I/O requests. This multishot uring_cmd allows the ublk server to fetch
> > > > multiple I/O commands in a single operation, significantly reducing
> > > > submission overhead compared to individual FETCH_REQ* commands.
> > > >
> > > > Key Design Features:
> > > >
> > > > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/O
> > > >    commands, with the batch size limited by the provided buffer length.
> > > >
> > > > 2. Dynamic Load Balancing: Multiple fetch commands can be submitted
> > > >    simultaneously, but only one is active at any time. This enables
> > > >    efficient load distribution across multiple server task contexts.
> > > >
> > > > 3. Implicit State Management: The implementation uses three key variables
> > > >    to track state:
> > > >    - evts_fifo: Queue of request tags awaiting processing
> > > >    - fcmd_head: List of available fetch commands
> > > >    - active_fcmd: Currently active fetch command (NULL = none active)
> > > >
> > > >    States are derived implicitly:
> > > >    - IDLE: No fetch commands available
> > > >    - READY: Fetch commands available, none active
> > > >    - ACTIVE: One fetch command processing events
> > > >
> > > > 4. Lockless Reader Optimization: The active fetch command can read from
> > > >    evts_fifo without locking (single reader guarantee), while writers
> > > >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memory
> > > >    barrier pairing plays key role for the single lockless reader
> > > >    optimization.
> > > >
> > > > Implementation Details:
> > > >
> > > > - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
> > > > - __ublk_pick_active_fcmd() selects an available fetch command when
> > > >   events arrive and no command is currently active
> > >
> > > What is __ublk_pick_active_fcmd()? I don't see a function with that name.
> >
> > It is renamed as __ublk_acquire_fcmd(), and its counter pair is
> > __ublk_release_fcmd().
> 
> Okay, update the commit message then?
> 
> >
> > >
> > > > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
> > > >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > > > - State transitions are coordinated via evts_lock to maintain consistency
> > > >
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c      | 412 +++++++++++++++++++++++++++++++---
> > > >  include/uapi/linux/ublk_cmd.h |   7 +
> > > >  2 files changed, 388 insertions(+), 31 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index cc9c92d97349..2e5e392c939e 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -93,6 +93,7 @@
> > > >
> > > >  /* ublk batch fetch uring_cmd */
> > > >  struct ublk_batch_fcmd {
> > > > +       struct list_head node;
> > > >         struct io_uring_cmd *cmd;
> > > >         unsigned short buf_group;
> > > >  };
> > > > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> > > >          */
> > > >         struct ublk_queue *ubq;
> > > >
> > > > -       u16 tag;
> > > > +       union {
> > > > +               u16 tag;
> > > > +               struct ublk_batch_fcmd *fcmd; /* batch io only */
> > > > +       };
> > > >  };
> > > >
> > > >  struct ublk_batch_io_data {
> > > > @@ -229,18 +233,36 @@ struct ublk_queue {
> > > >         struct ublk_device *dev;
> > > >
> > > >         /*
> > > > -        * Inflight ublk request tag is saved in this fifo
> > > > +        * Batch I/O State Management:
> > > > +        *
> > > > +        * The batch I/O system uses implicit state management based on the
> > > > +        * combination of three key variables below.
> > > > +        *
> > > > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > > > +        *   No fetch commands available, events queue in evts_fifo
> > > > +        *
> > > > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > > > +        *   Fetch commands available but none processing events
> > > >          *
> > > > -        * There are multiple writer from ublk_queue_rq() or ublk_queue_rqs(),
> > > > -        * so lock is required for storing request tag to fifo
> > > > +        * - ACTIVE: active_fcmd
> > > > +        *   One fetch command actively processing events from evts_fifo
> > > >          *
> > > > -        * Make sure just one reader for fetching request from task work
> > > > -        * function to ublk server, so no need to grab the lock in reader
> > > > -        * side.
> > > > +        * Key Invariants:
> > > > +        * - At most one active_fcmd at any time (single reader)
> > > > +        * - active_fcmd is always from fcmd_head list when non-NULL
> > > > +        * - evts_fifo can be read locklessly by the single active reader
> > > > +        * - All state transitions require evts_lock protection
> > > > +        * - Multiple writers to evts_fifo require lock protection
> > > >          */
> > > >         struct {
> > > >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > > >                 spinlock_t evts_lock;
> > > > +
> > > > +               /* List of fetch commands available to process events */
> > > > +               struct list_head fcmd_head;
> > > > +
> > > > +               /* Currently active fetch command (NULL = none active) */
> > > > +               struct ublk_batch_fcmd  *active_fcmd;
> > > >         }____cacheline_aligned_in_smp;
> > > >
> > > >         struct ublk_io ios[] __counted_by(q_depth);
> > > > @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> > > >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> > > >                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
> > > >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > +                               struct ublk_batch_io_data *data,
> > > > +                               struct ublk_batch_fcmd *fcmd);
> > > >
> > > >  static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
> > > >  {
> > > >         return false;
> > > >  }
> > > >
> > > > +static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> > > > +{
> > > > +       return false;
> > > > +}
> > > > +
> > > >  static inline void ublk_io_lock(struct ublk_io *io)
> > > >  {
> > > >         spin_lock(&io->lock);
> > > > @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wait until one idr is freed */
> > > >
> > > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > > >
> > > > +static struct ublk_batch_fcmd *
> > > > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > > > +{
> > > > +       struct ublk_batch_fcmd *fcmd = kzalloc(sizeof(*fcmd), GFP_NOIO);
> > >
> > > An allocation in the I/O path seems unfortunate. Is there not room to
> > > store the struct ublk_batch_fcmd in the io_uring_cmd pdu?
> >
> > It is allocated once for one mshot request, which covers many IOs.
> >
> > It can't be held in uring_cmd pdu, but the allocation can be optimized in
> > future. Not a big deal in enablement stage.
> 
> Okay, seems fine to optimize it in the future.
> 
> >
> > > > +
> > > > +       if (fcmd) {
> > > > +               fcmd->cmd = cmd;
> > > > +               fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
> > >
> > > Is it necessary to store sample this here just to pass it back to the
> > > io_uring layer? Wouldn't the io_uring layer already have access to it
> > > in struct io_kiocb's buf_index field?
> >
> > ->buf_group is used by io_uring_cmd_buffer_select(), and this way also
> > follows ->buf_index uses in both io_uring/net.c and io_uring/rw.c.
> >
> >
> > io_ring_buffer_select(), so we can't reuse req->buf_index here.
> 
> But io_uring/net.c and io_uring/rw.c both retrieve the buf_group value
> from req->buf_index instead of the SQE, for example:
> if (req->flags & REQ_F_BUFFER_SELECT)
>         sr->buf_group = req->buf_index;
> 
> Seems like it would make sense to do the same for
> UBLK_U_IO_FETCH_IO_CMDS. That also saves one pointer dereference here.

IMO we shouldn't encourage driver to access `io_kiocb`, however, cmd->sqe
is exposed to driver explicitly.

> 
> >
> > >
> > > > +       }
> > > > +       return fcmd;
> > > > +}
> > > > +
> > > > +static void ublk_batch_free_fcmd(struct ublk_batch_fcmd *fcmd)
> > > > +{
> > > > +       kfree(fcmd);
> > > > +}
> > > > +
> > > > +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> > > > +{
> > > > +       WRITE_ONCE(ubq->active_fcmd, NULL);
> > > > +}
> > > >
> > > > -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
> > > > +/*
> > > > + * Nothing can move on, so clear ->active_fcmd, and the caller should stop
> > > > + * dispatching
> > > > + */
> > > > +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> > > > +                                       const struct ublk_batch_io_data *data,
> > > >                                         struct ublk_batch_fcmd *fcmd,
> > > >                                         int res)
> > > >  {
> > > > +       spin_lock(&ubq->evts_lock);
> > > > +       list_del(&fcmd->node);
> > > > +       WARN_ON_ONCE(fcmd != ubq->active_fcmd);
> > > > +       __ublk_release_fcmd(ubq);
> > > > +       spin_unlock(&ubq->evts_lock);
> > > > +
> > > >         io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > > > -       fcmd->cmd = NULL;
> > > > +       ublk_batch_free_fcmd(fcmd);
> > > >  }
> > > >
> > > >  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> > > > @@ -1491,6 +1553,8 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> > > >         bool needs_filter;
> > > >         int ret;
> > > >
> > > > +       WARN_ON_ONCE(data->cmd != fcmd->cmd);
> > > > +
> > > >         sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
> > > >                                          data->issue_flags);
> > > >         if (sel.val < 0)
> > > > @@ -1548,23 +1612,94 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> > > >         return ret;
> > > >  }
> > > >
> > > > -static __maybe_unused int
> > > > -ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > -                   const struct ublk_batch_io_data *data,
> > > > -                   struct ublk_batch_fcmd *fcmd)
> > > > +static struct ublk_batch_fcmd *__ublk_acquire_fcmd(
> > > > +               struct ublk_queue *ubq)
> > > > +{
> > > > +       struct ublk_batch_fcmd *fcmd;
> > > > +
> > > > +       lockdep_assert_held(&ubq->evts_lock);
> > > > +
> > > > +       /*
> > > > +        * Ordering updating ubq->evts_fifo and checking ubq->active_fcmd.
> > > > +        *
> > > > +        * The pair is the smp_mb() in ublk_batch_dispatch().
> > > > +        *
> > > > +        * If ubq->active_fcmd is observed as non-NULL, the new added tags
> > > > +        * can be visisible in ublk_batch_dispatch() with the barrier pairing.
> > > > +        */
> > > > +       smp_mb();
> > > > +       if (READ_ONCE(ubq->active_fcmd)) {
> > > > +               fcmd = NULL;
> > > > +       } else {
> > > > +               fcmd = list_first_entry_or_null(&ubq->fcmd_head,
> > > > +                               struct ublk_batch_fcmd, node);
> > > > +               WRITE_ONCE(ubq->active_fcmd, fcmd);
> > > > +       }
> > > > +       return fcmd;
> > > > +}
> > > > +
> > > > +static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
> > > > +                          unsigned int issue_flags)
> > > > +{
> > > > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > > > +       struct ublk_batch_fcmd *fcmd = pdu->fcmd;
> > > > +       struct ublk_batch_io_data data = {
> > > > +               .ub = pdu->ubq->dev,
> > > > +               .cmd = fcmd->cmd,
> > > > +               .issue_flags = issue_flags,
> > > > +       };
> > > > +
> > > > +       WARN_ON_ONCE(pdu->ubq->active_fcmd != fcmd);
> > > > +
> > > > +       ublk_batch_dispatch(pdu->ubq, &data, fcmd);
> > > > +}
> > > > +
> > > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > +                               struct ublk_batch_io_data *data,
> > > > +                               struct ublk_batch_fcmd *fcmd)
> > > >  {
> > > > +       struct ublk_batch_fcmd *new_fcmd;
> > >
> > > Is the new_fcmd variable necessary? Can fcmd be reused instead?
> > >
> > > > +       void *handle;
> > > > +       bool empty;
> > > >         int ret = 0;
> > > >
> > > > +again:
> > > >         while (!ublk_io_evts_empty(ubq)) {
> > > >                 ret = __ublk_batch_dispatch(ubq, data, fcmd);
> > > >                 if (ret <= 0)
> > > >                         break;
> > > >         }
> > > >
> > > > -       if (ret < 0)
> > > > -               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> > > > +       if (ret < 0) {
> > > > +               ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
> > > > +               return;
> > > > +       }
> > > >
> > > > -       return ret;
> > > > +       handle = io_uring_cmd_ctx_handle(fcmd->cmd);
> > > > +       __ublk_release_fcmd(ubq);
> > > > +       /*
> > > > +        * Order clearing ubq->active_fcmd from __ublk_release_fcmd() and
> > > > +        * checking ubq->evts_fifo.
> > > > +        *
> > > > +        * The pair is the smp_mb() in __ublk_acquire_fcmd().
> > > > +        */
> > > > +       smp_mb();
> > > > +       empty = ublk_io_evts_empty(ubq);
> > > > +       if (likely(empty))
> > >
> > > nit: empty variable seems unnecessary
> > >
> > > > +               return;
> > > > +
> > > > +       spin_lock(&ubq->evts_lock);
> > > > +       new_fcmd = __ublk_acquire_fcmd(ubq);
> > > > +       spin_unlock(&ubq->evts_lock);
> > > > +
> > > > +       if (!new_fcmd)
> > > > +               return;
> > > > +       if (handle == io_uring_cmd_ctx_handle(new_fcmd->cmd)) {
> > >
> > > This check seems to be meant to decide whether the new and old
> > > UBLK_U_IO_FETCH_IO_CMDS commands can execute in the same task work?
> >
> > Actually not.
> >
> > > But belonging to the same io_uring context doesn't necessarily mean
> > > that the same task issued them. It seems like it would be safer to
> > > always dispatch new_fcmd->cmd to task work.
> >
> > What matters is just that ctx->uring_lock & issue_flag matches from ublk
> > viewpoint, so it is safe to do so.
> 
> Okay, that makes sense.
> 
> >
> > However, given it is hit in slow path, so starting new dispatch
> > is easier.
> 
> Yeah, I'd agree it makes sense to keep the unexpected path code
> simpler. There may also be fairness concerns from looping indefinitely
> here if the evts_fifo continues to be nonempty, so dispatching to task
> work seems safer.

Fair enough.

Thanks,
Ming


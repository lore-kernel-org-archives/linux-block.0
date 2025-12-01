Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5230147A
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582138; cv=none; b=OwkcOiTnSnYCRX+SZMgjuBWWZN0WK+jsHyszv4oVoSwrOWpJsm/QPvduuzDHAtPkSH/57+NNHwvGMrFP1rl6+3TkVFzaa+WpC+qoV56ePzeZJq7ajCvRt3MvtFgdGK0ytU1+BZyfU3+kkQSMPN329m+egPAYnw3ofE72mNo1/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582138; c=relaxed/simple;
	bh=qbBYf37UhHjmia4DEok4Q4bOjCek/bdZJaIXf0U8CuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMDroWE0A63Sbgrb31mlbiuQ3KyeGAgb86iirUqug0/tAjswXt0eGi7DlX7O0qi5AjZzrgNp/HJOCHU4DcIkGsY9bRUkYmFCsX6FJ8TE90PSxpSUmHAgNx+FJrKPoMCbp3UCKF2TLlYykjDB2DZ7QK445fl7UwlnNW5lLbcxVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C516lQp4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C516lQp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764582134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBWjvwFSSvXwVb2B1b5M+TBWV3hxW2ZKtOJcMYKQ91c=;
	b=C516lQp4WV7VqPI+K10vUBsdAXVPAFXhRX8PE9JO1h4IwkJVEnwwAZIrXGRrAVL4TKBRKq
	gJm7rVyMf0mYyltQXw0mQSXnG+d3fum8C7xVeqPPCJag/AxEItlK1TMzcloUTCHJxjDGJc
	cW/K3yUge/azXzPPEzGmvQVEXSwZX20=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-sFPUo5PNPhyVanxgIGqh6g-1; Mon,
 01 Dec 2025 04:42:09 -0500
X-MC-Unique: sFPUo5PNPhyVanxgIGqh6g-1
X-Mimecast-MFC-AGG-ID: sFPUo5PNPhyVanxgIGqh6g_1764582128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCEE31955E77;
	Mon,  1 Dec 2025 09:42:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94080180047F;
	Mon,  1 Dec 2025 09:42:00 +0000 (UTC)
Date: Mon, 1 Dec 2025 17:41:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O
 processing
Message-ID: <aS1i4RoP_mJXQiXk@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-15-ming.lei@redhat.com>
 <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Nov 30, 2025 at 09:55:47PM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch processing
> > of I/O requests. This multishot uring_cmd allows the ublk server to fetch
> > multiple I/O commands in a single operation, significantly reducing
> > submission overhead compared to individual FETCH_REQ* commands.
> >
> > Key Design Features:
> >
> > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/O
> >    commands, with the batch size limited by the provided buffer length.
> >
> > 2. Dynamic Load Balancing: Multiple fetch commands can be submitted
> >    simultaneously, but only one is active at any time. This enables
> >    efficient load distribution across multiple server task contexts.
> >
> > 3. Implicit State Management: The implementation uses three key variables
> >    to track state:
> >    - evts_fifo: Queue of request tags awaiting processing
> >    - fcmd_head: List of available fetch commands
> >    - active_fcmd: Currently active fetch command (NULL = none active)
> >
> >    States are derived implicitly:
> >    - IDLE: No fetch commands available
> >    - READY: Fetch commands available, none active
> >    - ACTIVE: One fetch command processing events
> >
> > 4. Lockless Reader Optimization: The active fetch command can read from
> >    evts_fifo without locking (single reader guarantee), while writers
> >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memory
> >    barrier pairing plays key role for the single lockless reader
> >    optimization.
> >
> > Implementation Details:
> >
> > - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
> > - __ublk_pick_active_fcmd() selects an available fetch command when
> >   events arrive and no command is currently active
> 
> What is __ublk_pick_active_fcmd()? I don't see a function with that name.

It is renamed as __ublk_acquire_fcmd(), and its counter pair is
__ublk_release_fcmd().

> 
> > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
> >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > - State transitions are coordinated via evts_lock to maintain consistency
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 412 +++++++++++++++++++++++++++++++---
> >  include/uapi/linux/ublk_cmd.h |   7 +
> >  2 files changed, 388 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index cc9c92d97349..2e5e392c939e 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -93,6 +93,7 @@
> >
> >  /* ublk batch fetch uring_cmd */
> >  struct ublk_batch_fcmd {
> > +       struct list_head node;
> >         struct io_uring_cmd *cmd;
> >         unsigned short buf_group;
> >  };
> > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> >          */
> >         struct ublk_queue *ubq;
> >
> > -       u16 tag;
> > +       union {
> > +               u16 tag;
> > +               struct ublk_batch_fcmd *fcmd; /* batch io only */
> > +       };
> >  };
> >
> >  struct ublk_batch_io_data {
> > @@ -229,18 +233,36 @@ struct ublk_queue {
> >         struct ublk_device *dev;
> >
> >         /*
> > -        * Inflight ublk request tag is saved in this fifo
> > +        * Batch I/O State Management:
> > +        *
> > +        * The batch I/O system uses implicit state management based on the
> > +        * combination of three key variables below.
> > +        *
> > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > +        *   No fetch commands available, events queue in evts_fifo
> > +        *
> > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > +        *   Fetch commands available but none processing events
> >          *
> > -        * There are multiple writer from ublk_queue_rq() or ublk_queue_rqs(),
> > -        * so lock is required for storing request tag to fifo
> > +        * - ACTIVE: active_fcmd
> > +        *   One fetch command actively processing events from evts_fifo
> >          *
> > -        * Make sure just one reader for fetching request from task work
> > -        * function to ublk server, so no need to grab the lock in reader
> > -        * side.
> > +        * Key Invariants:
> > +        * - At most one active_fcmd at any time (single reader)
> > +        * - active_fcmd is always from fcmd_head list when non-NULL
> > +        * - evts_fifo can be read locklessly by the single active reader
> > +        * - All state transitions require evts_lock protection
> > +        * - Multiple writers to evts_fifo require lock protection
> >          */
> >         struct {
> >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> >                 spinlock_t evts_lock;
> > +
> > +               /* List of fetch commands available to process events */
> > +               struct list_head fcmd_head;
> > +
> > +               /* Currently active fetch command (NULL = none active) */
> > +               struct ublk_batch_fcmd  *active_fcmd;
> >         }____cacheline_aligned_in_smp;
> >
> >         struct ublk_io ios[] __counted_by(q_depth);
> > @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> >                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
> >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > +                               struct ublk_batch_io_data *data,
> > +                               struct ublk_batch_fcmd *fcmd);
> >
> >  static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
> >  {
> >         return false;
> >  }
> >
> > +static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline void ublk_io_lock(struct ublk_io *io)
> >  {
> >         spin_lock(&io->lock);
> > @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wait until one idr is freed */
> >
> >  static DEFINE_MUTEX(ublk_ctl_mutex);
> >
> > +static struct ublk_batch_fcmd *
> > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > +{
> > +       struct ublk_batch_fcmd *fcmd = kzalloc(sizeof(*fcmd), GFP_NOIO);
> 
> An allocation in the I/O path seems unfortunate. Is there not room to
> store the struct ublk_batch_fcmd in the io_uring_cmd pdu?

It is allocated once for one mshot request, which covers many IOs.

It can't be held in uring_cmd pdu, but the allocation can be optimized in
future. Not a big deal in enablement stage.

> > +
> > +       if (fcmd) {
> > +               fcmd->cmd = cmd;
> > +               fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
> 
> Is it necessary to store sample this here just to pass it back to the
> io_uring layer? Wouldn't the io_uring layer already have access to it
> in struct io_kiocb's buf_index field?

->buf_group is used by io_uring_cmd_buffer_select(), and this way also
follows ->buf_index uses in both io_uring/net.c and io_uring/rw.c.

More importantly req->buf_index is used in io_uring/kbuf.c internally, see
io_ring_buffer_select(), so we can't reuse req->buf_index here.

> 
> > +       }
> > +       return fcmd;
> > +}
> > +
> > +static void ublk_batch_free_fcmd(struct ublk_batch_fcmd *fcmd)
> > +{
> > +       kfree(fcmd);
> > +}
> > +
> > +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> > +{
> > +       WRITE_ONCE(ubq->active_fcmd, NULL);
> > +}
> >
> > -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
> > +/*
> > + * Nothing can move on, so clear ->active_fcmd, and the caller should stop
> > + * dispatching
> > + */
> > +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> > +                                       const struct ublk_batch_io_data *data,
> >                                         struct ublk_batch_fcmd *fcmd,
> >                                         int res)
> >  {
> > +       spin_lock(&ubq->evts_lock);
> > +       list_del(&fcmd->node);
> > +       WARN_ON_ONCE(fcmd != ubq->active_fcmd);
> > +       __ublk_release_fcmd(ubq);
> > +       spin_unlock(&ubq->evts_lock);
> > +
> >         io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > -       fcmd->cmd = NULL;
> > +       ublk_batch_free_fcmd(fcmd);
> >  }
> >
> >  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> > @@ -1491,6 +1553,8 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> >         bool needs_filter;
> >         int ret;
> >
> > +       WARN_ON_ONCE(data->cmd != fcmd->cmd);
> > +
> >         sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
> >                                          data->issue_flags);
> >         if (sel.val < 0)
> > @@ -1548,23 +1612,94 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> >         return ret;
> >  }
> >
> > -static __maybe_unused int
> > -ublk_batch_dispatch(struct ublk_queue *ubq,
> > -                   const struct ublk_batch_io_data *data,
> > -                   struct ublk_batch_fcmd *fcmd)
> > +static struct ublk_batch_fcmd *__ublk_acquire_fcmd(
> > +               struct ublk_queue *ubq)
> > +{
> > +       struct ublk_batch_fcmd *fcmd;
> > +
> > +       lockdep_assert_held(&ubq->evts_lock);
> > +
> > +       /*
> > +        * Ordering updating ubq->evts_fifo and checking ubq->active_fcmd.
> > +        *
> > +        * The pair is the smp_mb() in ublk_batch_dispatch().
> > +        *
> > +        * If ubq->active_fcmd is observed as non-NULL, the new added tags
> > +        * can be visisible in ublk_batch_dispatch() with the barrier pairing.
> > +        */
> > +       smp_mb();
> > +       if (READ_ONCE(ubq->active_fcmd)) {
> > +               fcmd = NULL;
> > +       } else {
> > +               fcmd = list_first_entry_or_null(&ubq->fcmd_head,
> > +                               struct ublk_batch_fcmd, node);
> > +               WRITE_ONCE(ubq->active_fcmd, fcmd);
> > +       }
> > +       return fcmd;
> > +}
> > +
> > +static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
> > +                          unsigned int issue_flags)
> > +{
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +       struct ublk_batch_fcmd *fcmd = pdu->fcmd;
> > +       struct ublk_batch_io_data data = {
> > +               .ub = pdu->ubq->dev,
> > +               .cmd = fcmd->cmd,
> > +               .issue_flags = issue_flags,
> > +       };
> > +
> > +       WARN_ON_ONCE(pdu->ubq->active_fcmd != fcmd);
> > +
> > +       ublk_batch_dispatch(pdu->ubq, &data, fcmd);
> > +}
> > +
> > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > +                               struct ublk_batch_io_data *data,
> > +                               struct ublk_batch_fcmd *fcmd)
> >  {
> > +       struct ublk_batch_fcmd *new_fcmd;
> 
> Is the new_fcmd variable necessary? Can fcmd be reused instead?
> 
> > +       void *handle;
> > +       bool empty;
> >         int ret = 0;
> >
> > +again:
> >         while (!ublk_io_evts_empty(ubq)) {
> >                 ret = __ublk_batch_dispatch(ubq, data, fcmd);
> >                 if (ret <= 0)
> >                         break;
> >         }
> >
> > -       if (ret < 0)
> > -               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> > +       if (ret < 0) {
> > +               ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
> > +               return;
> > +       }
> >
> > -       return ret;
> > +       handle = io_uring_cmd_ctx_handle(fcmd->cmd);
> > +       __ublk_release_fcmd(ubq);
> > +       /*
> > +        * Order clearing ubq->active_fcmd from __ublk_release_fcmd() and
> > +        * checking ubq->evts_fifo.
> > +        *
> > +        * The pair is the smp_mb() in __ublk_acquire_fcmd().
> > +        */
> > +       smp_mb();
> > +       empty = ublk_io_evts_empty(ubq);
> > +       if (likely(empty))
> 
> nit: empty variable seems unnecessary
> 
> > +               return;
> > +
> > +       spin_lock(&ubq->evts_lock);
> > +       new_fcmd = __ublk_acquire_fcmd(ubq);
> > +       spin_unlock(&ubq->evts_lock);
> > +
> > +       if (!new_fcmd)
> > +               return;
> > +       if (handle == io_uring_cmd_ctx_handle(new_fcmd->cmd)) {
> 
> This check seems to be meant to decide whether the new and old
> UBLK_U_IO_FETCH_IO_CMDS commands can execute in the same task work?

Actually not.

> But belonging to the same io_uring context doesn't necessarily mean
> that the same task issued them. It seems like it would be safer to
> always dispatch new_fcmd->cmd to task work.

What matters is just that ctx->uring_lock & issue_flag matches from ublk
viewpoint, so it is safe to do so.

However, given it is hit in slow path, so starting new dispatch
is easier.

> 
> > +               data->cmd = new_fcmd->cmd;
> > +               fcmd = new_fcmd;
> > +               goto again;
> > +       }
> > +       io_uring_cmd_complete_in_task(new_fcmd->cmd, ublk_batch_tw_cb);
> >  }
> >
> >  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> > @@ -1576,13 +1711,27 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> >         ublk_dispatch_req(ubq, pdu->req, issue_flags);
> >  }
> >
> > -static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > +static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq, bool last)
> >  {
> > -       struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
> > -       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +       if (ublk_support_batch_io(ubq)) {
> > +               unsigned short tag = rq->tag;
> > +               struct ublk_batch_fcmd *fcmd = NULL;
> >
> > -       pdu->req = rq;
> > -       io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
> > +               spin_lock(&ubq->evts_lock);
> > +               kfifo_put(&ubq->evts_fifo, tag);
> > +               if (last)
> > +                       fcmd = __ublk_acquire_fcmd(ubq);
> > +               spin_unlock(&ubq->evts_lock);
> > +
> > +               if (fcmd)
> > +                       io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
> > +       } else {
> > +               struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
> > +               struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +
> > +               pdu->req = rq;
> > +               io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
> > +       }
> >  }
> >
> >  static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> > @@ -1600,14 +1749,44 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> >         } while (rq);
> >  }
> >
> > -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> > +static void ublk_batch_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> >  {
> > -       struct io_uring_cmd *cmd = io->cmd;
> > -       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +       unsigned short tags[MAX_NR_TAG];
> > +       struct ublk_batch_fcmd *fcmd;
> > +       struct request *rq;
> > +       unsigned cnt = 0;
> > +
> > +       spin_lock(&ubq->evts_lock);
> > +       rq_list_for_each(l, rq) {
> > +               tags[cnt++] = (unsigned short)rq->tag;
> > +               if (cnt >= MAX_NR_TAG) {
> > +                       kfifo_in(&ubq->evts_fifo, tags, cnt);
> > +                       cnt = 0;
> > +               }
> > +       }
> > +       if (cnt)
> > +               kfifo_in(&ubq->evts_fifo, tags, cnt);
> > +       fcmd = __ublk_acquire_fcmd(ubq);
> > +       spin_unlock(&ubq->evts_lock);
> >
> > -       pdu->req_list = rq_list_peek(l);
> >         rq_list_init(l);
> > -       io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
> > +       if (fcmd)
> > +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
> > +}
> > +
> > +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct ublk_io *io,
> > +                               struct rq_list *l, bool batch)
> > +{
> > +       if (batch) {
> > +               ublk_batch_queue_cmd_list(ubq, l);
> > +       } else {
> > +               struct io_uring_cmd *cmd = io->cmd;
> > +               struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +
> > +               pdu->req_list = rq_list_peek(l);
> > +               rq_list_init(l);
> > +               io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
> > +       }
> >  }
> >
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > @@ -1686,7 +1865,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> >                 return BLK_STS_OK;
> >         }
> >
> > -       ublk_queue_cmd(ubq, rq);
> > +       ublk_queue_cmd(ubq, rq, bd->last);
> >         return BLK_STS_OK;
> >  }
> >
> > @@ -1698,11 +1877,25 @@ static inline bool ublk_belong_to_same_batch(const struct ublk_io *io,
> >                 (io->task == io2->task);
> >  }
> >
> > -static void ublk_queue_rqs(struct rq_list *rqlist)
> > +static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > +{
> > +       struct ublk_queue *ubq = hctx->driver_data;
> > +       struct ublk_batch_fcmd *fcmd;
> > +
> > +       spin_lock(&ubq->evts_lock);
> > +       fcmd = __ublk_acquire_fcmd(ubq);
> > +       spin_unlock(&ubq->evts_lock);
> > +
> > +       if (fcmd)
> > +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
> > +}
> > +
> > +static void __ublk_queue_rqs(struct rq_list *rqlist, bool batch)
> >  {
> >         struct rq_list requeue_list = { };
> >         struct rq_list submit_list = { };
> >         struct ublk_io *io = NULL;
> > +       struct ublk_queue *ubq = NULL;
> >         struct request *req;
> >
> >         while ((req = rq_list_pop(rqlist))) {
> > @@ -1716,16 +1909,27 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
> >
> >                 if (io && !ublk_belong_to_same_batch(io, this_io) &&
> >                                 !rq_list_empty(&submit_list))
> > -                       ublk_queue_cmd_list(io, &submit_list);
> > +                       ublk_queue_cmd_list(ubq, io, &submit_list, batch);
> 
> This seems to assume that all the requests belong to the same
> ublk_queue, which isn't required

Here, it is required for BATCH_IO, which needs new __ublk_queue_rqs()
implementation now.

Nice catch!

> 
> >                 io = this_io;
> > +               ubq = this_q;
> >                 rq_list_add_tail(&submit_list, req);
> >         }
> >
> >         if (!rq_list_empty(&submit_list))
> > -               ublk_queue_cmd_list(io, &submit_list);
> > +               ublk_queue_cmd_list(ubq, io, &submit_list, batch);
> 
> Same here
> 
> >         *rqlist = requeue_list;
> >  }
> >
> > +static void ublk_queue_rqs(struct rq_list *rqlist)
> > +{
> > +       __ublk_queue_rqs(rqlist, false);
> > +}
> > +
> > +static void ublk_batch_queue_rqs(struct rq_list *rqlist)
> > +{
> > +       __ublk_queue_rqs(rqlist, true);
> > +}
> > +
> >  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> >                 unsigned int hctx_idx)
> >  {
> > @@ -1743,6 +1947,14 @@ static const struct blk_mq_ops ublk_mq_ops = {
> >         .timeout        = ublk_timeout,
> >  };
> >
> > +static const struct blk_mq_ops ublk_batch_mq_ops = {
> > +       .commit_rqs     = ublk_commit_rqs,
> > +       .queue_rq       = ublk_queue_rq,
> > +       .queue_rqs      = ublk_batch_queue_rqs,
> > +       .init_hctx      = ublk_init_hctx,
> > +       .timeout        = ublk_timeout,
> > +};
> > +
> >  static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> >  {
> >         int i;
> > @@ -2120,6 +2332,56 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
> >                 io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
> >  }
> >
> > +static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
> > +                                 struct ublk_batch_fcmd *fcmd,
> > +                                 unsigned int issue_flags)
> > +{
> > +       bool done;
> > +
> > +       spin_lock(&ubq->evts_lock);
> > +       done = (ubq->active_fcmd != fcmd);
> 
> Needs to use READ_ONCE() since __ublk_release_fcmd() can be called
> without holding evts_lock?

OK.

> 
> > +       if (done)
> > +               list_del(&fcmd->node);
> > +       spin_unlock(&ubq->evts_lock);
> > +
> > +       if (done) {
> > +               io_uring_cmd_done(fcmd->cmd, UBLK_IO_RES_ABORT, issue_flags);
> > +               ublk_batch_free_fcmd(fcmd);
> > +       }
> > +}
> > +
> > +static void ublk_batch_cancel_queue(struct ublk_queue *ubq)
> > +{
> > +       LIST_HEAD(fcmd_list);
> > +
> > +       spin_lock(&ubq->evts_lock);
> > +       ubq->force_abort = true;
> > +       list_splice_init(&ubq->fcmd_head, &fcmd_list);
> > +       if (ubq->active_fcmd)
> > +               list_move(&ubq->active_fcmd->node, &ubq->fcmd_head);
> 
> Similarly, needs READ_ONCE()?

OK.

But this one may not be necessary, since now everything is just quiesced,
and the lockless code path won't hit any more.

> 
> > +       spin_unlock(&ubq->evts_lock);
> > +
> > +       while (!list_empty(&fcmd_list)) {
> > +               struct ublk_batch_fcmd *fcmd = list_first_entry(&fcmd_list,
> > +                               struct ublk_batch_fcmd, node);
> > +
> > +               ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED);
> > +       }
> > +}
> > +
> > +static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
> > +                                unsigned int issue_flags)
> > +{
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +       struct ublk_batch_fcmd *fcmd = pdu->fcmd;
> > +       struct ublk_queue *ubq = pdu->ubq;
> > +
> > +       if (!ubq->canceling)
> 
> Is it not racy to access ubq->canceling without any lock held?

OK, will switch to call ublk_start_cancel() unconditionally.

> 
> > +               ublk_start_cancel(ubq->dev);
> > +
> > +       ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
> > +}
> > +
> >  /*
> >   * The ublk char device won't be closed when calling cancel fn, so both
> >   * ublk device and queue are guaranteed to be live
> > @@ -2171,6 +2433,11 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
> >  {
> >         int i;
> >
> > +       if (ublk_support_batch_io(ubq)) {
> > +               ublk_batch_cancel_queue(ubq);
> > +               return;
> > +       }
> > +
> >         for (i = 0; i < ubq->q_depth; i++)
> >                 ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
> >  }
> > @@ -3091,6 +3358,74 @@ static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
> >         return ublk_check_batch_cmd_flags(uc);
> >  }
> >
> > +static int ublk_batch_attach(struct ublk_queue *ubq,
> > +                            struct ublk_batch_io_data *data,
> > +                            struct ublk_batch_fcmd *fcmd)
> > +{
> > +       struct ublk_batch_fcmd *new_fcmd = NULL;
> > +       bool free = false;
> > +
> > +       spin_lock(&ubq->evts_lock);
> > +       if (unlikely(ubq->force_abort || ubq->canceling)) {
> > +               free = true;
> > +       } else {
> > +               list_add_tail(&fcmd->node, &ubq->fcmd_head);
> > +               new_fcmd = __ublk_acquire_fcmd(ubq);
> > +       }
> > +       spin_unlock(&ubq->evts_lock);
> > +
> > +       /*
> > +        * If the two fetch commands are originated from same io_ring_ctx,
> > +        * run batch dispatch directly. Otherwise, schedule task work for
> > +        * doing it.
> > +        */
> > +       if (new_fcmd && io_uring_cmd_ctx_handle(new_fcmd->cmd) ==
> > +                       io_uring_cmd_ctx_handle(fcmd->cmd)) {
> > +               data->cmd = new_fcmd->cmd;
> > +               ublk_batch_dispatch(ubq, data, new_fcmd);
> > +       } else if (new_fcmd) {
> > +               io_uring_cmd_complete_in_task(new_fcmd->cmd,
> > +                               ublk_batch_tw_cb);
> > +       }
> 
> Return early if (!new_fcmd) to reduce indentation?
> 
> > +
> > +       if (free) {
> > +               ublk_batch_free_fcmd(fcmd);
> > +               return -ENODEV;
> > +       }
> 
> Move the if (free) check directly after spin_unlock(&ubq->evts_lock)?

Yeah, this is better.

> 
> > +       return -EIOCBQUEUED;
> 
> > +}
> > +
> > +static int ublk_handle_batch_fetch_cmd(struct ublk_batch_io_data *data)
> > +{
> > +       struct ublk_queue *ubq = ublk_get_queue(data->ub, data->header.q_id);
> > +       struct ublk_batch_fcmd *fcmd = ublk_batch_alloc_fcmd(data->cmd);
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(data->cmd);
> > +
> > +       if (!fcmd)
> > +               return -ENOMEM;
> > +
> > +       pdu->ubq = ubq;
> > +       pdu->fcmd = fcmd;
> > +       io_uring_cmd_mark_cancelable(data->cmd, data->issue_flags);
> > +
> > +       return ublk_batch_attach(ubq, data, fcmd);
> > +}
> > +
> > +static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
> > +                                        const struct ublk_batch_io *uc)
> > +{
> > +       if (!(data->cmd->flags & IORING_URING_CMD_MULTISHOT))
> > +               return -EINVAL;
> > +
> > +       if (uc->elem_bytes != sizeof(__u16))
> > +               return -EINVAL;
> > +
> > +       if (uc->flags != 0)
> > +               return -E2BIG;
> > +
> > +       return 0;
> > +}
> > +
> >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >                                        unsigned int issue_flags)
> >  {
> > @@ -3113,6 +3448,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> >         if (data.header.q_id >= ub->dev_info.nr_hw_queues)
> >                 goto out;
> >
> > +       if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
> > +               ublk_batch_cancel_fn(cmd, issue_flags);
> > +               return 0;
> > +       }
> 
> Move this to the top of the function before the other logic that's not
> necessary in the cancel case?

Yeah, looks better.


Thanks,
Ming


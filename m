Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8A221FB4
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663292; cv=none; b=TC7W6+zS0JRP7E/GF5nBklSqLCh9/VswV8kFkoziLWihwkLuXjx5bOEKmbvZHobpi7UXRDFYvpxlY0ZElE85/DUuvmUBpaxLc2vzyrYquLhmgGkKeyet7m0WHKAtyTURHk5yu4lKW1t2IoB9E1cgixFKOH5tFLqxEq/2EUp5CRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663292; c=relaxed/simple;
	bh=6bPfFGYEpIBBdAOUVc05TVdQl/PLkWZc0KU4TT+Pp50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSyPkRhK/IpnN/WFPQPtLBUMUo9efcUOH46QtDIIZ2McYFoFKGbq4xDqJeHivoxOv+SXXX7K4wohuMd9kwdusa6NxRmWqQ9oAWWVvgj7sa+phTHDu0A2v/zt39ym9cXeZoxZk9qk5sZHe+DgrsofTUJmecBsEkimZQ5cpiFpdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccXnHBJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccXnHBJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764663289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql38+fpnogM91ZVtxTpB9vpWkIK9Wk3eVB/XiwaqyJM=;
	b=ccXnHBJFVHT7hZfUao7+Sme87vqnJt87OXD3XwI8HEA/0/6LsK2NlRPhlsA2lZr5BJlTDB
	qNrHti6BVrB5A66RzkRXT8KFxXJEU8WqLTPMhyVQAgdSzhFNq6PG+urQh8JwjLpSfe0F0O
	LjRvShzlGCxHJORBeIp+A1Htd+f4G80=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-qz_jy1CvOf-AXP1vahJGfQ-1; Tue,
 02 Dec 2025 03:14:48 -0500
X-MC-Unique: qz_jy1CvOf-AXP1vahJGfQ-1
X-Mimecast-MFC-AGG-ID: qz_jy1CvOf-AXP1vahJGfQ_1764663286
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F51D195605C;
	Tue,  2 Dec 2025 08:14:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D575195608E;
	Tue,  2 Dec 2025 08:14:40 +0000 (UTC)
Date: Tue, 2 Dec 2025 16:14:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O
 processing
Message-ID: <aS6f68KVuyRxZitY@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-15-ming.lei@redhat.com>
 <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
 <aS1i4RoP_mJXQiXk@fedora>
 <CADUfDZo0N22fp5+Si8eBE5SgRkCMsMa1VDTiLO_+zLWfUOVc9g@mail.gmail.com>
 <aS5AZjizRDt7ql3T@fedora>
 <CADUfDZomo+Jz5oiQkU99+RZhxDqAjdt8B1tg_gj-O7thzqVbhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZomo+Jz5oiQkU99+RZhxDqAjdt8B1tg_gj-O7thzqVbhw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 01, 2025 at 05:39:29PM -0800, Caleb Sander Mateos wrote:
> On Mon, Dec 1, 2025 at 5:27 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Mon, Dec 01, 2025 at 09:51:59AM -0800, Caleb Sander Mateos wrote:
> > > On Mon, Dec 1, 2025 at 1:42 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Sun, Nov 30, 2025 at 09:55:47PM -0800, Caleb Sander Mateos wrote:
> > > > > On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > > >
> > > > > > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch processing
> > > > > > of I/O requests. This multishot uring_cmd allows the ublk server to fetch
> > > > > > multiple I/O commands in a single operation, significantly reducing
> > > > > > submission overhead compared to individual FETCH_REQ* commands.
> > > > > >
> > > > > > Key Design Features:
> > > > > >
> > > > > > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/O
> > > > > >    commands, with the batch size limited by the provided buffer length.
> > > > > >
> > > > > > 2. Dynamic Load Balancing: Multiple fetch commands can be submitted
> > > > > >    simultaneously, but only one is active at any time. This enables
> > > > > >    efficient load distribution across multiple server task contexts.
> > > > > >
> > > > > > 3. Implicit State Management: The implementation uses three key variables
> > > > > >    to track state:
> > > > > >    - evts_fifo: Queue of request tags awaiting processing
> > > > > >    - fcmd_head: List of available fetch commands
> > > > > >    - active_fcmd: Currently active fetch command (NULL = none active)
> > > > > >
> > > > > >    States are derived implicitly:
> > > > > >    - IDLE: No fetch commands available
> > > > > >    - READY: Fetch commands available, none active
> > > > > >    - ACTIVE: One fetch command processing events
> > > > > >
> > > > > > 4. Lockless Reader Optimization: The active fetch command can read from
> > > > > >    evts_fifo without locking (single reader guarantee), while writers
> > > > > >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memory
> > > > > >    barrier pairing plays key role for the single lockless reader
> > > > > >    optimization.
> > > > > >
> > > > > > Implementation Details:
> > > > > >
> > > > > > - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
> > > > > > - __ublk_pick_active_fcmd() selects an available fetch command when
> > > > > >   events arrive and no command is currently active
> > > > >
> > > > > What is __ublk_pick_active_fcmd()? I don't see a function with that name.
> > > >
> > > > It is renamed as __ublk_acquire_fcmd(), and its counter pair is
> > > > __ublk_release_fcmd().
> > >
> > > Okay, update the commit message then?
> > >
> > > >
> > > > >
> > > > > > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
> > > > > >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > > > > > - State transitions are coordinated via evts_lock to maintain consistency
> > > > > >
> > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > ---
> > > > > >  drivers/block/ublk_drv.c      | 412 +++++++++++++++++++++++++++++++---
> > > > > >  include/uapi/linux/ublk_cmd.h |   7 +
> > > > > >  2 files changed, 388 insertions(+), 31 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > > index cc9c92d97349..2e5e392c939e 100644
> > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > @@ -93,6 +93,7 @@
> > > > > >
> > > > > >  /* ublk batch fetch uring_cmd */
> > > > > >  struct ublk_batch_fcmd {
> > > > > > +       struct list_head node;
> > > > > >         struct io_uring_cmd *cmd;
> > > > > >         unsigned short buf_group;
> > > > > >  };
> > > > > > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> > > > > >          */
> > > > > >         struct ublk_queue *ubq;
> > > > > >
> > > > > > -       u16 tag;
> > > > > > +       union {
> > > > > > +               u16 tag;
> > > > > > +               struct ublk_batch_fcmd *fcmd; /* batch io only */
> > > > > > +       };
> > > > > >  };
> > > > > >
> > > > > >  struct ublk_batch_io_data {
> > > > > > @@ -229,18 +233,36 @@ struct ublk_queue {
> > > > > >         struct ublk_device *dev;
> > > > > >
> > > > > >         /*
> > > > > > -        * Inflight ublk request tag is saved in this fifo
> > > > > > +        * Batch I/O State Management:
> > > > > > +        *
> > > > > > +        * The batch I/O system uses implicit state management based on the
> > > > > > +        * combination of three key variables below.
> > > > > > +        *
> > > > > > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > > > > > +        *   No fetch commands available, events queue in evts_fifo
> > > > > > +        *
> > > > > > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > > > > > +        *   Fetch commands available but none processing events
> > > > > >          *
> > > > > > -        * There are multiple writer from ublk_queue_rq() or ublk_queue_rqs(),
> > > > > > -        * so lock is required for storing request tag to fifo
> > > > > > +        * - ACTIVE: active_fcmd
> > > > > > +        *   One fetch command actively processing events from evts_fifo
> > > > > >          *
> > > > > > -        * Make sure just one reader for fetching request from task work
> > > > > > -        * function to ublk server, so no need to grab the lock in reader
> > > > > > -        * side.
> > > > > > +        * Key Invariants:
> > > > > > +        * - At most one active_fcmd at any time (single reader)
> > > > > > +        * - active_fcmd is always from fcmd_head list when non-NULL
> > > > > > +        * - evts_fifo can be read locklessly by the single active reader
> > > > > > +        * - All state transitions require evts_lock protection
> > > > > > +        * - Multiple writers to evts_fifo require lock protection
> > > > > >          */
> > > > > >         struct {
> > > > > >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > > > > >                 spinlock_t evts_lock;
> > > > > > +
> > > > > > +               /* List of fetch commands available to process events */
> > > > > > +               struct list_head fcmd_head;
> > > > > > +
> > > > > > +               /* Currently active fetch command (NULL = none active) */
> > > > > > +               struct ublk_batch_fcmd  *active_fcmd;
> > > > > >         }____cacheline_aligned_in_smp;
> > > > > >
> > > > > >         struct ublk_io ios[] __counted_by(q_depth);
> > > > > > @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> > > > > >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> > > > > >                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
> > > > > >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > > > > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > > > +                               struct ublk_batch_io_data *data,
> > > > > > +                               struct ublk_batch_fcmd *fcmd);
> > > > > >
> > > > > >  static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
> > > > > >  {
> > > > > >         return false;
> > > > > >  }
> > > > > >
> > > > > > +static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> > > > > > +{
> > > > > > +       return false;
> > > > > > +}
> > > > > > +
> > > > > >  static inline void ublk_io_lock(struct ublk_io *io)
> > > > > >  {
> > > > > >         spin_lock(&io->lock);
> > > > > > @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wait until one idr is freed */
> > > > > >
> > > > > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > > > > >
> > > > > > +static struct ublk_batch_fcmd *
> > > > > > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > > > > > +{
> > > > > > +       struct ublk_batch_fcmd *fcmd = kzalloc(sizeof(*fcmd), GFP_NOIO);
> > > > >
> > > > > An allocation in the I/O path seems unfortunate. Is there not room to
> > > > > store the struct ublk_batch_fcmd in the io_uring_cmd pdu?
> > > >
> > > > It is allocated once for one mshot request, which covers many IOs.
> > > >
> > > > It can't be held in uring_cmd pdu, but the allocation can be optimized in
> > > > future. Not a big deal in enablement stage.
> > >
> > > Okay, seems fine to optimize it in the future.
> > >
> > > >
> > > > > > +
> > > > > > +       if (fcmd) {
> > > > > > +               fcmd->cmd = cmd;
> > > > > > +               fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
> > > > >
> > > > > Is it necessary to store sample this here just to pass it back to the
> > > > > io_uring layer? Wouldn't the io_uring layer already have access to it
> > > > > in struct io_kiocb's buf_index field?
> > > >
> > > > ->buf_group is used by io_uring_cmd_buffer_select(), and this way also
> > > > follows ->buf_index uses in both io_uring/net.c and io_uring/rw.c.
> > > >
> > > >
> > > > io_ring_buffer_select(), so we can't reuse req->buf_index here.
> > >
> > > But io_uring/net.c and io_uring/rw.c both retrieve the buf_group value
> > > from req->buf_index instead of the SQE, for example:
> > > if (req->flags & REQ_F_BUFFER_SELECT)
> > >         sr->buf_group = req->buf_index;
> > >
> > > Seems like it would make sense to do the same for
> > > UBLK_U_IO_FETCH_IO_CMDS. That also saves one pointer dereference here.
> >
> > IMO we shouldn't encourage driver to access `io_kiocb`, however, cmd->sqe
> > is exposed to driver explicitly.
> 
> Right, but we can add a helper in include/linux/io_uring/cmd.h to
> encapsulate accessing the io_kiocb field.

OK, however I'd suggest to do it as one followup optimization for avoiding
cross-tree change.


Thanks,
Ming


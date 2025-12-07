Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7F296BCD
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765115832; cv=none; b=pPOdxa3iCaVqtsHh3uMg/SAUOTMzA9P/1r9YMTuYJovrGZTXwPCIEsCOvyo3M8TmLZsgR5IZbO3Q0qgli4y4Gup3fIik0ZYYo3GOK/8LSNr48VMOfNYUlmA8DoNmN0HrEaviOpH1v850TcjXjWTgEcBy4ioEKlk+4C3P4IbRp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765115832; c=relaxed/simple;
	bh=y7PTEBvhLaHJbEIQJzyGeV7BXq0Bv8Ur8/j/wITalRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frlRPQkJZ2yKDCSOBHwFw6nKOzLNrFZWGqBD+x0Zy4Yrt6L7TdOgNJz8uKTY94JBgDp8BRtupANxDKtmiGZ365JVIQynpbXo+MyeLXK6/aNMhzqWqnByoPRoK97RE+Q3t4wCRujlmI6bFxJYJf+OSCRvFLKgWAxRMyaCv3i7V0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9YYzPwo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9YYzPwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765115827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A99idZCr9U8i8bqQEtozqJQ49zYEOQQDbs1/GN250m8=;
	b=C9YYzPwoC3yYR4fJKYwGBn+zPxBn9TZX2Kmu2abxcaUaMhs4fB0D/osfTmAd5aHRHzjM0r
	dbz7W4HvSeRAOIwdMZkRz5PVTJl/whb3lNebu00Xjon1jgVGKt3RjneMuhwWwXG8BACJ6p
	+7AZxHMplkdE0/xoLoC8OKCd5Onv1us=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-hFncI4mgPTas9AGeEY_4iA-1; Sun,
 07 Dec 2025 08:57:04 -0500
X-MC-Unique: hFncI4mgPTas9AGeEY_4iA-1
X-Mimecast-MFC-AGG-ID: hFncI4mgPTas9AGeEY_4iA_1765115823
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CADD91956080;
	Sun,  7 Dec 2025 13:57:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A78FB1800357;
	Sun,  7 Dec 2025 13:56:56 +0000 (UTC)
Date: Sun, 7 Dec 2025 21:56:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V5 08/21] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O
 processing
Message-ID: <aTWHn9Jw2RuXdD8A@fedora>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
 <20251202121917.1412280-9-ming.lei@redhat.com>
 <CADUfDZpJu+wQWWq2-GJm+ZN-wX3dcb_AYQhJ9ikwGjMEPCqh+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpJu+wQWWq2-GJm+ZN-wX3dcb_AYQhJ9ikwGjMEPCqh+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Dec 06, 2025 at 11:38:39PM -0800, Caleb Sander Mateos wrote:
> On Tue, Dec 2, 2025 at 4:21 AM Ming Lei <ming.lei@redhat.com> wrote:
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
> > - __ublk_acquire_fcmd() selects an available fetch command when
> >   events arrive and no command is currently active
> > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
> >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > - State transitions are coordinated via evts_lock to maintain consistency
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 392 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |   7 +
> >  2 files changed, 391 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 05bf9786751f..de6ce0e17b1b 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -93,6 +93,7 @@
> >
> >  /* ublk batch fetch uring_cmd */
> >  struct ublk_batch_fetch_cmd {
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
> > +               struct ublk_batch_fetch_cmd *fcmd; /* batch io only */
> > +       };
> >  };
> >
> >  struct ublk_batch_io_data {
> > @@ -239,10 +243,37 @@ struct ublk_queue {
> >          * Make sure just one reader for fetching request from task work
> >          * function to ublk server, so no need to grab the lock in reader
> >          * side.
> > +        *
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
> > +        *
> > +        * - ACTIVE: active_fcmd
> > +        *   One fetch command actively processing events from evts_fifo
> > +        *
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
> > +               struct ublk_batch_fetch_cmd  *active_fcmd;
> >         }____cacheline_aligned_in_smp;
> >
> >         struct ublk_io ios[] __counted_by(q_depth);
> > @@ -294,12 +325,20 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> >                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
> >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > +                               const struct ublk_batch_io_data *data,
> > +                               struct ublk_batch_fetch_cmd *fcmd);
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
> > @@ -620,13 +659,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wait until one idr is freed */
> >
> >  static DEFINE_MUTEX(ublk_ctl_mutex);
> >
> > +static struct ublk_batch_fetch_cmd *
> > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > +{
> > +       struct ublk_batch_fetch_cmd *fcmd = kzalloc(sizeof(*fcmd), GFP_NOIO);
> >
> > -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
> > +       if (fcmd) {
> > +               fcmd->cmd = cmd;
> > +               fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
> > +       }
> > +       return fcmd;
> > +}
> > +
> > +static void ublk_batch_free_fcmd(struct ublk_batch_fetch_cmd *fcmd)
> > +{
> > +       kfree(fcmd);
> > +}
> > +
> > +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> > +{
> > +       WRITE_ONCE(ubq->active_fcmd, NULL);
> > +}
> > +
> > +/*
> > + * Nothing can move on, so clear ->active_fcmd, and the caller should stop
> > + * dispatching
> > + */
> > +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> > +                                       const struct ublk_batch_io_data *data,
> >                                         struct ublk_batch_fetch_cmd *fcmd,
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
> >  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fcmd,
> > @@ -1489,6 +1560,8 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> >         bool needs_filter;
> >         int ret;
> >
> > +       WARN_ON_ONCE(data->cmd != fcmd->cmd);
> > +
> >         sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
> >                                          data->issue_flags);
> >         if (sel.val < 0)
> > @@ -1552,21 +1625,92 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> >         return ret;
> >  }
> >
> > -static __maybe_unused void
> 
> Drop the __maybe_unused in the previous commit that introduced it?

Yes, it can't be avoided, because the previous commit just adds this
helpers without caller. Otherwise putting the two into one can become too big.


Thanks,
Ming


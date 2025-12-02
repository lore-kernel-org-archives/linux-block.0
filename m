Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853036BB5B
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639585; cv=none; b=oydgxfzDGo9sL+E/lrQ+SLKPrCZaiw2nW27MY7C+Ojheqe3sTiNP/28QTAuLQhe2es28fbXnZWhP3KGCnIX7sn31ah1QLLKIKBdjEqm4VquytW08nl+aodcl6zh3VeqLIFOwBQnzAjAul6w4OvBYYYBxlw0djLYDKurdCmld4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639585; c=relaxed/simple;
	bh=yJr3Uo3rxALvRgxeuJtqqq60bhVX6v/Id9mAWt+1cEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKz2HXRgnTRMx+HKDXTK7w1CBsWrpPP1VpweSm1nn/hhV1PEr7UDaO37zKlixq/gAylFBFjlfIMCICpT7QJIERaA1J6H846e7l3gcT7WX17zNgva/jMkoSp6udwpLOwnvYJ/hYhEKbCBpJsD4E6XxafUXfTUI2UgJvS1dbTxiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C1aeWPGA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C1aeWPGA"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso333265a12.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 17:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764639582; x=1765244382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyXnbQ+UyZK6UbooR+UxvfZjSKFHrCLXQt5/t74fhz8=;
        b=C1aeWPGArwz/JLoqSNYUg3JlumCyp7IB/W1OuEfBDca5EDZNjLzXJ+8TJU+eaow3y/
         xbLwGlN4TwJvXnk/R18hgYsv6ePqRptaEbRPW/168eInBuS5BcYs874A4XjUbHFXGv9+
         54xhLnQidSLWRC1qXaxAFj0XrUHi9RtVcZe2LbzZOLcu1X3M8dGN1n2XzlK6enewABuo
         c0G5YBnyf4ZdU6EUH1DMSYnDbzBnn9S0ZVZjx9wK1j+GicqVgE37quqdAshxs5LuIvHL
         jkJSpGZQF/NokFLyuFPB52upngICG7TDcS46Yczf4w8K48BZWQc8y6Wh66P2Ksi++7Ad
         eckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764639582; x=1765244382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WyXnbQ+UyZK6UbooR+UxvfZjSKFHrCLXQt5/t74fhz8=;
        b=pNYMWEqFCQfqDsOcqmcwz9LGsSzMwWlVAyvPAMXBJT+pyWCJVyFbp1q0yla96Ksw/7
         vnawVQBIOuFWkPd1raMhfVlayY8cTXEHYXGlLzK2qbx+6ol919IJgwq1r9UfM34n/EnS
         WTekWfA31nvYMwiDpTuA4k7mxyLn7AS8v8qZAnBfkw739Fl8AKGfHdEkll8Gt8895Lji
         WQ4WothgkQ4/hfij/FOmTD0fQdkJMbtS7JSiuyPcbMyM0e5R4rsH6nYXHZCSzkxk8Fsx
         v8pou9jvGwU7LNXKso9wnz+1Mmo+IUwFBTPvrEZ8QicawpZTV4asgUI7n+lLHe1fR7kl
         oLqA==
X-Forwarded-Encrypted: i=1; AJvYcCWh+n+XAgEkPgQzn4X2J8C4QnJ4BMoQbxNOcIYzY1EjI3ui7tQUVPeY/LDZH7NkJ5uuXUOINmQeiQtKxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrS2FQYoik8I+uoIQ7s5gScJWcT6NGfixoCXfJxg5SGhjbCsVe
	wqX17QnT6DLKxpV69gNqQVFDXftld+Ce3gn1AKrSmykDNpazBTPCeVb1f8w6ZnKhZn6XG2iKZgJ
	TU9jQ+yvIDSYvP6mqcA/mYNa62TRV1MXd5M1Ci8hfTw==
X-Gm-Gg: ASbGncuNZhUCWCXJl8SwMYM1RE/LjMjKabbb/2Es80Iq5aBT0P7DaSR0KWMokBmxq4D
	/TvHuZZTmG6hZTC5pFJpICVSG2sWUrb9710Cv6RUNRoljyQ3/xMX73FlEyNVIhrRpgTRR+xpVKa
	vyANOEZZ/KfU6h1jnsFQZog/VqE8mHUJoQMA2Zf2aDoqreDvSIVHR3bpapa9gfxLc3HPQtKKgO+
	rcmO/c1eRdH90eMqWi4Tvv8GA50hfx6dmUqbT6ob4f1cmbVuDPx5lE6kyuewx1jmOl6bqDS68Mc
	bd49yx4=
X-Google-Smtp-Source: AGHT+IEQm4vPGict/H//yXw5dxm2GDfJZUMdNO7oDwzwrXh092zYxQA9pGl08InnvJEmW3mkBoo/O7nPNwuILQxTZ2U=
X-Received: by 2002:a05:7022:c8c:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11c9d709e67mr19005553c88.1.1764639581551; Mon, 01 Dec 2025
 17:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-15-ming.lei@redhat.com>
 <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
 <aS1i4RoP_mJXQiXk@fedora> <CADUfDZo0N22fp5+Si8eBE5SgRkCMsMa1VDTiLO_+zLWfUOVc9g@mail.gmail.com>
 <aS5AZjizRDt7ql3T@fedora>
In-Reply-To: <aS5AZjizRDt7ql3T@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 17:39:29 -0800
X-Gm-Features: AWmQ_bn4kbTR9ixmDvwVDkVbqUwvZ5wQ4GDXYqh2w8o4BBInw1wnnYZ4BHkxcRg
Message-ID: <CADUfDZomo+Jz5oiQkU99+RZhxDqAjdt8B1tg_gj-O7thzqVbhw@mail.gmail.com>
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Dec 01, 2025 at 09:51:59AM -0800, Caleb Sander Mateos wrote:
> > On Mon, Dec 1, 2025 at 1:42=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Sun, Nov 30, 2025 at 09:55:47PM -0800, Caleb Sander Mateos wrote:
> > > > On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch pro=
cessing
> > > > > of I/O requests. This multishot uring_cmd allows the ublk server =
to fetch
> > > > > multiple I/O commands in a single operation, significantly reduci=
ng
> > > > > submission overhead compared to individual FETCH_REQ* commands.
> > > > >
> > > > > Key Design Features:
> > > > >
> > > > > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch man=
y I/O
> > > > >    commands, with the batch size limited by the provided buffer l=
ength.
> > > > >
> > > > > 2. Dynamic Load Balancing: Multiple fetch commands can be submitt=
ed
> > > > >    simultaneously, but only one is active at any time. This enabl=
es
> > > > >    efficient load distribution across multiple server task contex=
ts.
> > > > >
> > > > > 3. Implicit State Management: The implementation uses three key v=
ariables
> > > > >    to track state:
> > > > >    - evts_fifo: Queue of request tags awaiting processing
> > > > >    - fcmd_head: List of available fetch commands
> > > > >    - active_fcmd: Currently active fetch command (NULL =3D none a=
ctive)
> > > > >
> > > > >    States are derived implicitly:
> > > > >    - IDLE: No fetch commands available
> > > > >    - READY: Fetch commands available, none active
> > > > >    - ACTIVE: One fetch command processing events
> > > > >
> > > > > 4. Lockless Reader Optimization: The active fetch command can rea=
d from
> > > > >    evts_fifo without locking (single reader guarantee), while wri=
ters
> > > > >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The m=
emory
> > > > >    barrier pairing plays key role for the single lockless reader
> > > > >    optimization.
> > > > >
> > > > > Implementation Details:
> > > > >
> > > > > - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_=
fifo
> > > > > - __ublk_pick_active_fcmd() selects an available fetch command wh=
en
> > > > >   events arrive and no command is currently active
> > > >
> > > > What is __ublk_pick_active_fcmd()? I don't see a function with that=
 name.
> > >
> > > It is renamed as __ublk_acquire_fcmd(), and its counter pair is
> > > __ublk_release_fcmd().
> >
> > Okay, update the commit message then?
> >
> > >
> > > >
> > > > > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch co=
mmand's
> > > > >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > > > > - State transitions are coordinated via evts_lock to maintain con=
sistency
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 412 ++++++++++++++++++++++++++++=
+++---
> > > > >  include/uapi/linux/ublk_cmd.h |   7 +
> > > > >  2 files changed, 388 insertions(+), 31 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index cc9c92d97349..2e5e392c939e 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -93,6 +93,7 @@
> > > > >
> > > > >  /* ublk batch fetch uring_cmd */
> > > > >  struct ublk_batch_fcmd {
> > > > > +       struct list_head node;
> > > > >         struct io_uring_cmd *cmd;
> > > > >         unsigned short buf_group;
> > > > >  };
> > > > > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> > > > >          */
> > > > >         struct ublk_queue *ubq;
> > > > >
> > > > > -       u16 tag;
> > > > > +       union {
> > > > > +               u16 tag;
> > > > > +               struct ublk_batch_fcmd *fcmd; /* batch io only */
> > > > > +       };
> > > > >  };
> > > > >
> > > > >  struct ublk_batch_io_data {
> > > > > @@ -229,18 +233,36 @@ struct ublk_queue {
> > > > >         struct ublk_device *dev;
> > > > >
> > > > >         /*
> > > > > -        * Inflight ublk request tag is saved in this fifo
> > > > > +        * Batch I/O State Management:
> > > > > +        *
> > > > > +        * The batch I/O system uses implicit state management ba=
sed on the
> > > > > +        * combination of three key variables below.
> > > > > +        *
> > > > > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > > > > +        *   No fetch commands available, events queue in evts_fi=
fo
> > > > > +        *
> > > > > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > > > > +        *   Fetch commands available but none processing events
> > > > >          *
> > > > > -        * There are multiple writer from ublk_queue_rq() or ublk=
_queue_rqs(),
> > > > > -        * so lock is required for storing request tag to fifo
> > > > > +        * - ACTIVE: active_fcmd
> > > > > +        *   One fetch command actively processing events from ev=
ts_fifo
> > > > >          *
> > > > > -        * Make sure just one reader for fetching request from ta=
sk work
> > > > > -        * function to ublk server, so no need to grab the lock i=
n reader
> > > > > -        * side.
> > > > > +        * Key Invariants:
> > > > > +        * - At most one active_fcmd at any time (single reader)
> > > > > +        * - active_fcmd is always from fcmd_head list when non-N=
ULL
> > > > > +        * - evts_fifo can be read locklessly by the single activ=
e reader
> > > > > +        * - All state transitions require evts_lock protection
> > > > > +        * - Multiple writers to evts_fifo require lock protectio=
n
> > > > >          */
> > > > >         struct {
> > > > >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > > > >                 spinlock_t evts_lock;
> > > > > +
> > > > > +               /* List of fetch commands available to process ev=
ents */
> > > > > +               struct list_head fcmd_head;
> > > > > +
> > > > > +               /* Currently active fetch command (NULL =3D none =
active) */
> > > > > +               struct ublk_batch_fcmd  *active_fcmd;
> > > > >         }____cacheline_aligned_in_smp;
> > > > >
> > > > >         struct ublk_io ios[] __counted_by(q_depth);
> > > > > @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ublk_de=
vice *ub, struct ublk_queue *ubq);
> > > > >  static inline struct request *__ublk_check_and_get_req(struct ub=
lk_device *ub,
> > > > >                 u16 q_id, u16 tag, struct ublk_io *io, size_t off=
set);
> > > > >  static inline unsigned int ublk_req_build_flags(struct request *=
req);
> > > > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > > +                               struct ublk_batch_io_data *data,
> > > > > +                               struct ublk_batch_fcmd *fcmd);
> > > > >
> > > > >  static inline bool ublk_dev_support_batch_io(const struct ublk_d=
evice *ub)
> > > > >  {
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +static inline bool ublk_support_batch_io(const struct ublk_queue=
 *ubq)
> > > > > +{
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >  static inline void ublk_io_lock(struct ublk_io *io)
> > > > >  {
> > > > >         spin_lock(&io->lock);
> > > > > @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;     /=
* wait until one idr is freed */
> > > > >
> > > > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > > > >
> > > > > +static struct ublk_batch_fcmd *
> > > > > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > > > > +{
> > > > > +       struct ublk_batch_fcmd *fcmd =3D kzalloc(sizeof(*fcmd), G=
FP_NOIO);
> > > >
> > > > An allocation in the I/O path seems unfortunate. Is there not room =
to
> > > > store the struct ublk_batch_fcmd in the io_uring_cmd pdu?
> > >
> > > It is allocated once for one mshot request, which covers many IOs.
> > >
> > > It can't be held in uring_cmd pdu, but the allocation can be optimize=
d in
> > > future. Not a big deal in enablement stage.
> >
> > Okay, seems fine to optimize it in the future.
> >
> > >
> > > > > +
> > > > > +       if (fcmd) {
> > > > > +               fcmd->cmd =3D cmd;
> > > > > +               fcmd->buf_group =3D READ_ONCE(cmd->sqe->buf_index=
);
> > > >
> > > > Is it necessary to store sample this here just to pass it back to t=
he
> > > > io_uring layer? Wouldn't the io_uring layer already have access to =
it
> > > > in struct io_kiocb's buf_index field?
> > >
> > > ->buf_group is used by io_uring_cmd_buffer_select(), and this way als=
o
> > > follows ->buf_index uses in both io_uring/net.c and io_uring/rw.c.
> > >
> > >
> > > io_ring_buffer_select(), so we can't reuse req->buf_index here.
> >
> > But io_uring/net.c and io_uring/rw.c both retrieve the buf_group value
> > from req->buf_index instead of the SQE, for example:
> > if (req->flags & REQ_F_BUFFER_SELECT)
> >         sr->buf_group =3D req->buf_index;
> >
> > Seems like it would make sense to do the same for
> > UBLK_U_IO_FETCH_IO_CMDS. That also saves one pointer dereference here.
>
> IMO we shouldn't encourage driver to access `io_kiocb`, however, cmd->sqe
> is exposed to driver explicitly.

Right, but we can add a helper in include/linux/io_uring/cmd.h to
encapsulate accessing the io_kiocb field.

Best,
Caleb

>
> >
> > >
> > > >
> > > > > +       }
> > > > > +       return fcmd;
> > > > > +}
> > > > > +
> > > > > +static void ublk_batch_free_fcmd(struct ublk_batch_fcmd *fcmd)
> > > > > +{
> > > > > +       kfree(fcmd);
> > > > > +}
> > > > > +
> > > > > +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> > > > > +{
> > > > > +       WRITE_ONCE(ubq->active_fcmd, NULL);
> > > > > +}
> > > > >
> > > > > -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_=
io_data *data,
> > > > > +/*
> > > > > + * Nothing can move on, so clear ->active_fcmd, and the caller s=
hould stop
> > > > > + * dispatching
> > > > > + */
> > > > > +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> > > > > +                                       const struct ublk_batch_i=
o_data *data,
> > > > >                                         struct ublk_batch_fcmd *f=
cmd,
> > > > >                                         int res)
> > > > >  {
> > > > > +       spin_lock(&ubq->evts_lock);
> > > > > +       list_del(&fcmd->node);
> > > > > +       WARN_ON_ONCE(fcmd !=3D ubq->active_fcmd);
> > > > > +       __ublk_release_fcmd(ubq);
> > > > > +       spin_unlock(&ubq->evts_lock);
> > > > > +
> > > > >         io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > > > > -       fcmd->cmd =3D NULL;
> > > > > +       ublk_batch_free_fcmd(fcmd);
> > > > >  }
> > > > >
> > > > >  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcm=
d,
> > > > > @@ -1491,6 +1553,8 @@ static int __ublk_batch_dispatch(struct ubl=
k_queue *ubq,
> > > > >         bool needs_filter;
> > > > >         int ret;
> > > > >
> > > > > +       WARN_ON_ONCE(data->cmd !=3D fcmd->cmd);
> > > > > +
> > > > >         sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_g=
roup, &len,
> > > > >                                          data->issue_flags);
> > > > >         if (sel.val < 0)
> > > > > @@ -1548,23 +1612,94 @@ static int __ublk_batch_dispatch(struct u=
blk_queue *ubq,
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > -static __maybe_unused int
> > > > > -ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > > -                   const struct ublk_batch_io_data *data,
> > > > > -                   struct ublk_batch_fcmd *fcmd)
> > > > > +static struct ublk_batch_fcmd *__ublk_acquire_fcmd(
> > > > > +               struct ublk_queue *ubq)
> > > > > +{
> > > > > +       struct ublk_batch_fcmd *fcmd;
> > > > > +
> > > > > +       lockdep_assert_held(&ubq->evts_lock);
> > > > > +
> > > > > +       /*
> > > > > +        * Ordering updating ubq->evts_fifo and checking ubq->act=
ive_fcmd.
> > > > > +        *
> > > > > +        * The pair is the smp_mb() in ublk_batch_dispatch().
> > > > > +        *
> > > > > +        * If ubq->active_fcmd is observed as non-NULL, the new a=
dded tags
> > > > > +        * can be visisible in ublk_batch_dispatch() with the bar=
rier pairing.
> > > > > +        */
> > > > > +       smp_mb();
> > > > > +       if (READ_ONCE(ubq->active_fcmd)) {
> > > > > +               fcmd =3D NULL;
> > > > > +       } else {
> > > > > +               fcmd =3D list_first_entry_or_null(&ubq->fcmd_head=
,
> > > > > +                               struct ublk_batch_fcmd, node);
> > > > > +               WRITE_ONCE(ubq->active_fcmd, fcmd);
> > > > > +       }
> > > > > +       return fcmd;
> > > > > +}
> > > > > +
> > > > > +static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
> > > > > +                          unsigned int issue_flags)
> > > > > +{
> > > > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu=
(cmd);
> > > > > +       struct ublk_batch_fcmd *fcmd =3D pdu->fcmd;
> > > > > +       struct ublk_batch_io_data data =3D {
> > > > > +               .ub =3D pdu->ubq->dev,
> > > > > +               .cmd =3D fcmd->cmd,
> > > > > +               .issue_flags =3D issue_flags,
> > > > > +       };
> > > > > +
> > > > > +       WARN_ON_ONCE(pdu->ubq->active_fcmd !=3D fcmd);
> > > > > +
> > > > > +       ublk_batch_dispatch(pdu->ubq, &data, fcmd);
> > > > > +}
> > > > > +
> > > > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > > +                               struct ublk_batch_io_data *data,
> > > > > +                               struct ublk_batch_fcmd *fcmd)
> > > > >  {
> > > > > +       struct ublk_batch_fcmd *new_fcmd;
> > > >
> > > > Is the new_fcmd variable necessary? Can fcmd be reused instead?
> > > >
> > > > > +       void *handle;
> > > > > +       bool empty;
> > > > >         int ret =3D 0;
> > > > >
> > > > > +again:
> > > > >         while (!ublk_io_evts_empty(ubq)) {
> > > > >                 ret =3D __ublk_batch_dispatch(ubq, data, fcmd);
> > > > >                 if (ret <=3D 0)
> > > > >                         break;
> > > > >         }
> > > > >
> > > > > -       if (ret < 0)
> > > > > -               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> > > > > +       if (ret < 0) {
> > > > > +               ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret)=
;
> > > > > +               return;
> > > > > +       }
> > > > >
> > > > > -       return ret;
> > > > > +       handle =3D io_uring_cmd_ctx_handle(fcmd->cmd);
> > > > > +       __ublk_release_fcmd(ubq);
> > > > > +       /*
> > > > > +        * Order clearing ubq->active_fcmd from __ublk_release_fc=
md() and
> > > > > +        * checking ubq->evts_fifo.
> > > > > +        *
> > > > > +        * The pair is the smp_mb() in __ublk_acquire_fcmd().
> > > > > +        */
> > > > > +       smp_mb();
> > > > > +       empty =3D ublk_io_evts_empty(ubq);
> > > > > +       if (likely(empty))
> > > >
> > > > nit: empty variable seems unnecessary
> > > >
> > > > > +               return;
> > > > > +
> > > > > +       spin_lock(&ubq->evts_lock);
> > > > > +       new_fcmd =3D __ublk_acquire_fcmd(ubq);
> > > > > +       spin_unlock(&ubq->evts_lock);
> > > > > +
> > > > > +       if (!new_fcmd)
> > > > > +               return;
> > > > > +       if (handle =3D=3D io_uring_cmd_ctx_handle(new_fcmd->cmd))=
 {
> > > >
> > > > This check seems to be meant to decide whether the new and old
> > > > UBLK_U_IO_FETCH_IO_CMDS commands can execute in the same task work?
> > >
> > > Actually not.
> > >
> > > > But belonging to the same io_uring context doesn't necessarily mean
> > > > that the same task issued them. It seems like it would be safer to
> > > > always dispatch new_fcmd->cmd to task work.
> > >
> > > What matters is just that ctx->uring_lock & issue_flag matches from u=
blk
> > > viewpoint, so it is safe to do so.
> >
> > Okay, that makes sense.
> >
> > >
> > > However, given it is hit in slow path, so starting new dispatch
> > > is easier.
> >
> > Yeah, I'd agree it makes sense to keep the unexpected path code
> > simpler. There may also be fairness concerns from looping indefinitely
> > here if the evts_fifo continues to be nonempty, so dispatching to task
> > work seems safer.
>
> Fair enough.
>
> Thanks,
> Ming
>

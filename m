Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2730EF7B
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611536; cv=none; b=IMPNrbxWVV00RSoyhm2SC7HaCyxd9OypG95+kEj7iKropjI9AX4S104VBrmMTQ8PJEy/BVRKz4Op8EvWqmMBY72LAB67IbRnJEpbOSEIdxRbrieI2FIFaF/ZfKYl7vB8NyPGgH2sGsJ7JG+foZpUyCmzFE3PeWpl6vLpZGVRTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611536; c=relaxed/simple;
	bh=ArgN3v83Ugd58VNvT2fvsNepIT20p/2xsc8QEhOCnf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRyYtaO5hIhr7U0xwoD42OEI7rB3XsiXQZvUFnrEd7+G41erGrwv6+L5pBr9VygmKBp16FjB/YCZxf3tLIcqkRXJUEIiZzIURK9V1hCfjWYWZhTQs94USi9T7zw/63vsx4wTcZVJP/zsvANwYYHjWt46E+Ylc9uho/S7Ya+5A0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FtztDyuF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FtztDyuF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-299e43c1adbso6200635ad.3
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764611532; x=1765216332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bW9YU+qfUMOVCHSoJoTNwY0x0FkR3yKPDQWoSaQ1go=;
        b=FtztDyuFt6WBcZbIfctdFTIC+Uiz0ThPW+JuAI6jgW/H3WhdSe8clclYPUrqWcr0IX
         Kv4hwKar5rKU8x8XxkqO1diGpTE/Z+OK8tsMdo5nVvWgwy6rtA2jzO/9jofLLATJsqoU
         UqWdQkvM3hh4OvJSIeXQAM9LXmiSZ4SzGkBS6O13tH9xIesoqyoIQPhAIbhHmhQSsDJ3
         rNnC/0GG48YWTz8zHtAQgCdVRKXF600QDwOfz/LaFqvM2xq1nQnpJoOUXh/B5MWdidqx
         ciOWVYUCVHtaRaAF0T25/j8X7yMXiTvYtyCaTIodwWJ4V/gVy65XJRXJPqW/t6R1rtm/
         DFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611532; x=1765216332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bW9YU+qfUMOVCHSoJoTNwY0x0FkR3yKPDQWoSaQ1go=;
        b=DWcwBzw0Cj1L6P/y2plRfbcqhKISU1FrkEsoU2FgFHmhxWL6Z9d2iBO3t3exCQOmtS
         nXxTjZHtSenr4YHBB4GywIPpRikEuIPbL7H5MBFlR/oa+KMvFlmIC4hzNaksNaQzO9ab
         TXF5D3RchxYH6oUWJn3bBQ+3IFzR2YGUdeQUjQp0y5C6g/Ka3dlpNxpeuaS0y45QRfaQ
         W2wJuNtA4oWvhM1/nm/hl/ML7fRwzhAkw4ylObgZTfAwGeI9MOg236iVMzx7bdF9141p
         OS4hpo29PYFVoBXWgB9lTwDNeCY4KkN+D7goBT7/Tr9WhqVwub85ezr6NIw9fS8c0UY5
         z/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXZvM4pZjYuHTJOnrjG+HJM4Ox1FZFDvBK5SRhHaRM7qqWKT07xkQlN7I0S/lryoQhtlcJGa5G2bqTnCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAh96cOwupGXhiEIUzKqcRW/QLSFp6nupO02Jf98xH8xQBBPsv
	moSofbcYYd1MUDi0ga2RdKT3dQ5OIpBQgYieaecSkCBUEHiDRfQFxTNUBMMkyzO3tKMT+jW0cxN
	DwU4xAjS7RwTYsFmtiDUyw5kSkJ89lB2ctVEChKWRA5+sIIgrhxoHTuVy4w==
X-Gm-Gg: ASbGncvZM/4pEtiXxkKdmvd89Nk10//ghcI7849oCiU9owVVh1cAmqsuLlT7YTzereW
	22X1Du+qE1mvHGH14EFDYHvQKpCTD4HrGAI2+ePaA+BJEr847Hlzy7Sa5zK57Er2+TrmUArqzfF
	mUziQ5EHLmOlyVeq1GJGhDeUA86gbZpcQl049k1hdrlL8FTkhjgpgDr7QnWvk9trbQiexOmQrSA
	PgJXqCaW7ju5PSKR4/CKm3g53Sdq/xOn3m2kIZSPLquaQO1WOJhGrynn+z4V2Wz7f5V6ktfZl/y
	fh7wtVU=
X-Google-Smtp-Source: AGHT+IH2PFo5MQXhkaKf81Aep5LEEFoukD/XaSq/85n4P7glR5W5qa9x5FPp0zyIXuY+fSvQXk+LWradZh55k6BFdJM=
X-Received: by 2002:a05:7301:1906:b0:2a4:3593:5fc9 with SMTP id
 5a478bee46e88-2a7192a30bfmr24246720eec.3.1764611531736; Mon, 01 Dec 2025
 09:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-15-ming.lei@redhat.com>
 <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com> <aS1i4RoP_mJXQiXk@fedora>
In-Reply-To: <aS1i4RoP_mJXQiXk@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 09:51:59 -0800
X-Gm-Features: AWmQ_bnn0qrnhJaM83nDXS_4CTVJ4clhw7bNggjfB0krTnMQ4bpJoeJeYIX7uLg
Message-ID: <CADUfDZo0N22fp5+Si8eBE5SgRkCMsMa1VDTiLO_+zLWfUOVc9g@mail.gmail.com>
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 1:42=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Sun, Nov 30, 2025 at 09:55:47PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch process=
ing
> > > of I/O requests. This multishot uring_cmd allows the ublk server to f=
etch
> > > multiple I/O commands in a single operation, significantly reducing
> > > submission overhead compared to individual FETCH_REQ* commands.
> > >
> > > Key Design Features:
> > >
> > > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/=
O
> > >    commands, with the batch size limited by the provided buffer lengt=
h.
> > >
> > > 2. Dynamic Load Balancing: Multiple fetch commands can be submitted
> > >    simultaneously, but only one is active at any time. This enables
> > >    efficient load distribution across multiple server task contexts.
> > >
> > > 3. Implicit State Management: The implementation uses three key varia=
bles
> > >    to track state:
> > >    - evts_fifo: Queue of request tags awaiting processing
> > >    - fcmd_head: List of available fetch commands
> > >    - active_fcmd: Currently active fetch command (NULL =3D none activ=
e)
> > >
> > >    States are derived implicitly:
> > >    - IDLE: No fetch commands available
> > >    - READY: Fetch commands available, none active
> > >    - ACTIVE: One fetch command processing events
> > >
> > > 4. Lockless Reader Optimization: The active fetch command can read fr=
om
> > >    evts_fifo without locking (single reader guarantee), while writers
> > >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memor=
y
> > >    barrier pairing plays key role for the single lockless reader
> > >    optimization.
> > >
> > > Implementation Details:
> > >
> > > - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
> > > - __ublk_pick_active_fcmd() selects an available fetch command when
> > >   events arrive and no command is currently active
> >
> > What is __ublk_pick_active_fcmd()? I don't see a function with that nam=
e.
>
> It is renamed as __ublk_acquire_fcmd(), and its counter pair is
> __ublk_release_fcmd().

Okay, update the commit message then?

>
> >
> > > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch comman=
d's
> > >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > > - State transitions are coordinated via evts_lock to maintain consist=
ency
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 412 +++++++++++++++++++++++++++++++-=
--
> > >  include/uapi/linux/ublk_cmd.h |   7 +
> > >  2 files changed, 388 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index cc9c92d97349..2e5e392c939e 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -93,6 +93,7 @@
> > >
> > >  /* ublk batch fetch uring_cmd */
> > >  struct ublk_batch_fcmd {
> > > +       struct list_head node;
> > >         struct io_uring_cmd *cmd;
> > >         unsigned short buf_group;
> > >  };
> > > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> > >          */
> > >         struct ublk_queue *ubq;
> > >
> > > -       u16 tag;
> > > +       union {
> > > +               u16 tag;
> > > +               struct ublk_batch_fcmd *fcmd; /* batch io only */
> > > +       };
> > >  };
> > >
> > >  struct ublk_batch_io_data {
> > > @@ -229,18 +233,36 @@ struct ublk_queue {
> > >         struct ublk_device *dev;
> > >
> > >         /*
> > > -        * Inflight ublk request tag is saved in this fifo
> > > +        * Batch I/O State Management:
> > > +        *
> > > +        * The batch I/O system uses implicit state management based =
on the
> > > +        * combination of three key variables below.
> > > +        *
> > > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > > +        *   No fetch commands available, events queue in evts_fifo
> > > +        *
> > > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > > +        *   Fetch commands available but none processing events
> > >          *
> > > -        * There are multiple writer from ublk_queue_rq() or ublk_que=
ue_rqs(),
> > > -        * so lock is required for storing request tag to fifo
> > > +        * - ACTIVE: active_fcmd
> > > +        *   One fetch command actively processing events from evts_f=
ifo
> > >          *
> > > -        * Make sure just one reader for fetching request from task w=
ork
> > > -        * function to ublk server, so no need to grab the lock in re=
ader
> > > -        * side.
> > > +        * Key Invariants:
> > > +        * - At most one active_fcmd at any time (single reader)
> > > +        * - active_fcmd is always from fcmd_head list when non-NULL
> > > +        * - evts_fifo can be read locklessly by the single active re=
ader
> > > +        * - All state transitions require evts_lock protection
> > > +        * - Multiple writers to evts_fifo require lock protection
> > >          */
> > >         struct {
> > >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > >                 spinlock_t evts_lock;
> > > +
> > > +               /* List of fetch commands available to process events=
 */
> > > +               struct list_head fcmd_head;
> > > +
> > > +               /* Currently active fetch command (NULL =3D none acti=
ve) */
> > > +               struct ublk_batch_fcmd  *active_fcmd;
> > >         }____cacheline_aligned_in_smp;
> > >
> > >         struct ublk_io ios[] __counted_by(q_depth);
> > > @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ublk_device=
 *ub, struct ublk_queue *ubq);
> > >  static inline struct request *__ublk_check_and_get_req(struct ublk_d=
evice *ub,
> > >                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset)=
;
> > >  static inline unsigned int ublk_req_build_flags(struct request *req)=
;
> > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > +                               struct ublk_batch_io_data *data,
> > > +                               struct ublk_batch_fcmd *fcmd);
> > >
> > >  static inline bool ublk_dev_support_batch_io(const struct ublk_devic=
e *ub)
> > >  {
> > >         return false;
> > >  }
> > >
> > > +static inline bool ublk_support_batch_io(const struct ublk_queue *ub=
q)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > >  static inline void ublk_io_lock(struct ublk_io *io)
> > >  {
> > >         spin_lock(&io->lock);
> > > @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wa=
it until one idr is freed */
> > >
> > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > >
> > > +static struct ublk_batch_fcmd *
> > > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > > +{
> > > +       struct ublk_batch_fcmd *fcmd =3D kzalloc(sizeof(*fcmd), GFP_N=
OIO);
> >
> > An allocation in the I/O path seems unfortunate. Is there not room to
> > store the struct ublk_batch_fcmd in the io_uring_cmd pdu?
>
> It is allocated once for one mshot request, which covers many IOs.
>
> It can't be held in uring_cmd pdu, but the allocation can be optimized in
> future. Not a big deal in enablement stage.

Okay, seems fine to optimize it in the future.

>
> > > +
> > > +       if (fcmd) {
> > > +               fcmd->cmd =3D cmd;
> > > +               fcmd->buf_group =3D READ_ONCE(cmd->sqe->buf_index);
> >
> > Is it necessary to store sample this here just to pass it back to the
> > io_uring layer? Wouldn't the io_uring layer already have access to it
> > in struct io_kiocb's buf_index field?
>
> ->buf_group is used by io_uring_cmd_buffer_select(), and this way also
> follows ->buf_index uses in both io_uring/net.c and io_uring/rw.c.
>
>
> io_ring_buffer_select(), so we can't reuse req->buf_index here.

But io_uring/net.c and io_uring/rw.c both retrieve the buf_group value
from req->buf_index instead of the SQE, for example:
if (req->flags & REQ_F_BUFFER_SELECT)
        sr->buf_group =3D req->buf_index;

Seems like it would make sense to do the same for
UBLK_U_IO_FETCH_IO_CMDS. That also saves one pointer dereference here.

>
> >
> > > +       }
> > > +       return fcmd;
> > > +}
> > > +
> > > +static void ublk_batch_free_fcmd(struct ublk_batch_fcmd *fcmd)
> > > +{
> > > +       kfree(fcmd);
> > > +}
> > > +
> > > +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> > > +{
> > > +       WRITE_ONCE(ubq->active_fcmd, NULL);
> > > +}
> > >
> > > -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_d=
ata *data,
> > > +/*
> > > + * Nothing can move on, so clear ->active_fcmd, and the caller shoul=
d stop
> > > + * dispatching
> > > + */
> > > +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> > > +                                       const struct ublk_batch_io_da=
ta *data,
> > >                                         struct ublk_batch_fcmd *fcmd,
> > >                                         int res)
> > >  {
> > > +       spin_lock(&ubq->evts_lock);
> > > +       list_del(&fcmd->node);
> > > +       WARN_ON_ONCE(fcmd !=3D ubq->active_fcmd);
> > > +       __ublk_release_fcmd(ubq);
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > >         io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > > -       fcmd->cmd =3D NULL;
> > > +       ublk_batch_free_fcmd(fcmd);
> > >  }
> > >
> > >  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> > > @@ -1491,6 +1553,8 @@ static int __ublk_batch_dispatch(struct ublk_qu=
eue *ubq,
> > >         bool needs_filter;
> > >         int ret;
> > >
> > > +       WARN_ON_ONCE(data->cmd !=3D fcmd->cmd);
> > > +
> > >         sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group=
, &len,
> > >                                          data->issue_flags);
> > >         if (sel.val < 0)
> > > @@ -1548,23 +1612,94 @@ static int __ublk_batch_dispatch(struct ublk_=
queue *ubq,
> > >         return ret;
> > >  }
> > >
> > > -static __maybe_unused int
> > > -ublk_batch_dispatch(struct ublk_queue *ubq,
> > > -                   const struct ublk_batch_io_data *data,
> > > -                   struct ublk_batch_fcmd *fcmd)
> > > +static struct ublk_batch_fcmd *__ublk_acquire_fcmd(
> > > +               struct ublk_queue *ubq)
> > > +{
> > > +       struct ublk_batch_fcmd *fcmd;
> > > +
> > > +       lockdep_assert_held(&ubq->evts_lock);
> > > +
> > > +       /*
> > > +        * Ordering updating ubq->evts_fifo and checking ubq->active_=
fcmd.
> > > +        *
> > > +        * The pair is the smp_mb() in ublk_batch_dispatch().
> > > +        *
> > > +        * If ubq->active_fcmd is observed as non-NULL, the new added=
 tags
> > > +        * can be visisible in ublk_batch_dispatch() with the barrier=
 pairing.
> > > +        */
> > > +       smp_mb();
> > > +       if (READ_ONCE(ubq->active_fcmd)) {
> > > +               fcmd =3D NULL;
> > > +       } else {
> > > +               fcmd =3D list_first_entry_or_null(&ubq->fcmd_head,
> > > +                               struct ublk_batch_fcmd, node);
> > > +               WRITE_ONCE(ubq->active_fcmd, fcmd);
> > > +       }
> > > +       return fcmd;
> > > +}
> > > +
> > > +static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
> > > +                          unsigned int issue_flags)
> > > +{
> > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd=
);
> > > +       struct ublk_batch_fcmd *fcmd =3D pdu->fcmd;
> > > +       struct ublk_batch_io_data data =3D {
> > > +               .ub =3D pdu->ubq->dev,
> > > +               .cmd =3D fcmd->cmd,
> > > +               .issue_flags =3D issue_flags,
> > > +       };
> > > +
> > > +       WARN_ON_ONCE(pdu->ubq->active_fcmd !=3D fcmd);
> > > +
> > > +       ublk_batch_dispatch(pdu->ubq, &data, fcmd);
> > > +}
> > > +
> > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > +                               struct ublk_batch_io_data *data,
> > > +                               struct ublk_batch_fcmd *fcmd)
> > >  {
> > > +       struct ublk_batch_fcmd *new_fcmd;
> >
> > Is the new_fcmd variable necessary? Can fcmd be reused instead?
> >
> > > +       void *handle;
> > > +       bool empty;
> > >         int ret =3D 0;
> > >
> > > +again:
> > >         while (!ublk_io_evts_empty(ubq)) {
> > >                 ret =3D __ublk_batch_dispatch(ubq, data, fcmd);
> > >                 if (ret <=3D 0)
> > >                         break;
> > >         }
> > >
> > > -       if (ret < 0)
> > > -               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> > > +       if (ret < 0) {
> > > +               ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
> > > +               return;
> > > +       }
> > >
> > > -       return ret;
> > > +       handle =3D io_uring_cmd_ctx_handle(fcmd->cmd);
> > > +       __ublk_release_fcmd(ubq);
> > > +       /*
> > > +        * Order clearing ubq->active_fcmd from __ublk_release_fcmd()=
 and
> > > +        * checking ubq->evts_fifo.
> > > +        *
> > > +        * The pair is the smp_mb() in __ublk_acquire_fcmd().
> > > +        */
> > > +       smp_mb();
> > > +       empty =3D ublk_io_evts_empty(ubq);
> > > +       if (likely(empty))
> >
> > nit: empty variable seems unnecessary
> >
> > > +               return;
> > > +
> > > +       spin_lock(&ubq->evts_lock);
> > > +       new_fcmd =3D __ublk_acquire_fcmd(ubq);
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > > +       if (!new_fcmd)
> > > +               return;
> > > +       if (handle =3D=3D io_uring_cmd_ctx_handle(new_fcmd->cmd)) {
> >
> > This check seems to be meant to decide whether the new and old
> > UBLK_U_IO_FETCH_IO_CMDS commands can execute in the same task work?
>
> Actually not.
>
> > But belonging to the same io_uring context doesn't necessarily mean
> > that the same task issued them. It seems like it would be safer to
> > always dispatch new_fcmd->cmd to task work.
>
> What matters is just that ctx->uring_lock & issue_flag matches from ublk
> viewpoint, so it is safe to do so.

Okay, that makes sense.

>
> However, given it is hit in slow path, so starting new dispatch
> is easier.

Yeah, I'd agree it makes sense to keep the unexpected path code
simpler. There may also be fairness concerns from looping indefinitely
here if the evts_fifo continues to be nonempty, so dispatching to task
work seems safer.

>
> >
> > > +               data->cmd =3D new_fcmd->cmd;
> > > +               fcmd =3D new_fcmd;
> > > +               goto again;
> > > +       }
> > > +       io_uring_cmd_complete_in_task(new_fcmd->cmd, ublk_batch_tw_cb=
);
> > >  }
> > >
> > >  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> > > @@ -1576,13 +1711,27 @@ static void ublk_cmd_tw_cb(struct io_uring_cm=
d *cmd,
> > >         ublk_dispatch_req(ubq, pdu->req, issue_flags);
> > >  }
> > >
> > > -static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *r=
q)
> > > +static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *r=
q, bool last)
> > >  {
> > > -       struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
> > > -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd=
);
> > > +       if (ublk_support_batch_io(ubq)) {
> > > +               unsigned short tag =3D rq->tag;
> > > +               struct ublk_batch_fcmd *fcmd =3D NULL;
> > >
> > > -       pdu->req =3D rq;
> > > -       io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
> > > +               spin_lock(&ubq->evts_lock);
> > > +               kfifo_put(&ubq->evts_fifo, tag);
> > > +               if (last)
> > > +                       fcmd =3D __ublk_acquire_fcmd(ubq);
> > > +               spin_unlock(&ubq->evts_lock);
> > > +
> > > +               if (fcmd)
> > > +                       io_uring_cmd_complete_in_task(fcmd->cmd, ublk=
_batch_tw_cb);
> > > +       } else {
> > > +               struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
> > > +               struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd=
_pdu(cmd);
> > > +
> > > +               pdu->req =3D rq;
> > > +               io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
> > > +       }
> > >  }
> > >
> > >  static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> > > @@ -1600,14 +1749,44 @@ static void ublk_cmd_list_tw_cb(struct io_uri=
ng_cmd *cmd,
> > >         } while (rq);
> > >  }
> > >
> > > -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *=
l)
> > > +static void ublk_batch_queue_cmd_list(struct ublk_queue *ubq, struct=
 rq_list *l)
> > >  {
> > > -       struct io_uring_cmd *cmd =3D io->cmd;
> > > -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd=
);
> > > +       unsigned short tags[MAX_NR_TAG];
> > > +       struct ublk_batch_fcmd *fcmd;
> > > +       struct request *rq;
> > > +       unsigned cnt =3D 0;
> > > +
> > > +       spin_lock(&ubq->evts_lock);
> > > +       rq_list_for_each(l, rq) {
> > > +               tags[cnt++] =3D (unsigned short)rq->tag;
> > > +               if (cnt >=3D MAX_NR_TAG) {
> > > +                       kfifo_in(&ubq->evts_fifo, tags, cnt);
> > > +                       cnt =3D 0;
> > > +               }
> > > +       }
> > > +       if (cnt)
> > > +               kfifo_in(&ubq->evts_fifo, tags, cnt);
> > > +       fcmd =3D __ublk_acquire_fcmd(ubq);
> > > +       spin_unlock(&ubq->evts_lock);
> > >
> > > -       pdu->req_list =3D rq_list_peek(l);
> > >         rq_list_init(l);
> > > -       io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
> > > +       if (fcmd)
> > > +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_t=
w_cb);
> > > +}
> > > +
> > > +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct ublk_=
io *io,
> > > +                               struct rq_list *l, bool batch)
> > > +{
> > > +       if (batch) {
> > > +               ublk_batch_queue_cmd_list(ubq, l);
> > > +       } else {
> > > +               struct io_uring_cmd *cmd =3D io->cmd;
> > > +               struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd=
_pdu(cmd);
> > > +
> > > +               pdu->req_list =3D rq_list_peek(l);
> > > +               rq_list_init(l);
> > > +               io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_c=
b);
> > > +       }
> > >  }
> > >
> > >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > @@ -1686,7 +1865,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq=
_hw_ctx *hctx,
> > >                 return BLK_STS_OK;
> > >         }
> > >
> > > -       ublk_queue_cmd(ubq, rq);
> > > +       ublk_queue_cmd(ubq, rq, bd->last);
> > >         return BLK_STS_OK;
> > >  }
> > >
> > > @@ -1698,11 +1877,25 @@ static inline bool ublk_belong_to_same_batch(=
const struct ublk_io *io,
> > >                 (io->task =3D=3D io2->task);
> > >  }
> > >
> > > -static void ublk_queue_rqs(struct rq_list *rqlist)
> > > +static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > > +{
> > > +       struct ublk_queue *ubq =3D hctx->driver_data;
> > > +       struct ublk_batch_fcmd *fcmd;
> > > +
> > > +       spin_lock(&ubq->evts_lock);
> > > +       fcmd =3D __ublk_acquire_fcmd(ubq);
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > > +       if (fcmd)
> > > +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_t=
w_cb);
> > > +}
> > > +
> > > +static void __ublk_queue_rqs(struct rq_list *rqlist, bool batch)
> > >  {
> > >         struct rq_list requeue_list =3D { };
> > >         struct rq_list submit_list =3D { };
> > >         struct ublk_io *io =3D NULL;
> > > +       struct ublk_queue *ubq =3D NULL;
> > >         struct request *req;
> > >
> > >         while ((req =3D rq_list_pop(rqlist))) {
> > > @@ -1716,16 +1909,27 @@ static void ublk_queue_rqs(struct rq_list *rq=
list)
> > >
> > >                 if (io && !ublk_belong_to_same_batch(io, this_io) &&
> > >                                 !rq_list_empty(&submit_list))
> > > -                       ublk_queue_cmd_list(io, &submit_list);
> > > +                       ublk_queue_cmd_list(ubq, io, &submit_list, ba=
tch);
> >
> > This seems to assume that all the requests belong to the same
> > ublk_queue, which isn't required
>
> Here, it is required for BATCH_IO, which needs new __ublk_queue_rqs()
> implementation now.
>
> Nice catch!
>
> >
> > >                 io =3D this_io;
> > > +               ubq =3D this_q;
> > >                 rq_list_add_tail(&submit_list, req);
> > >         }
> > >
> > >         if (!rq_list_empty(&submit_list))
> > > -               ublk_queue_cmd_list(io, &submit_list);
> > > +               ublk_queue_cmd_list(ubq, io, &submit_list, batch);
> >
> > Same here
> >
> > >         *rqlist =3D requeue_list;
> > >  }
> > >
> > > +static void ublk_queue_rqs(struct rq_list *rqlist)
> > > +{
> > > +       __ublk_queue_rqs(rqlist, false);
> > > +}
> > > +
> > > +static void ublk_batch_queue_rqs(struct rq_list *rqlist)
> > > +{
> > > +       __ublk_queue_rqs(rqlist, true);
> > > +}
> > > +
> > >  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_d=
ata,
> > >                 unsigned int hctx_idx)
> > >  {
> > > @@ -1743,6 +1947,14 @@ static const struct blk_mq_ops ublk_mq_ops =3D=
 {
> > >         .timeout        =3D ublk_timeout,
> > >  };
> > >
> > > +static const struct blk_mq_ops ublk_batch_mq_ops =3D {
> > > +       .commit_rqs     =3D ublk_commit_rqs,
> > > +       .queue_rq       =3D ublk_queue_rq,
> > > +       .queue_rqs      =3D ublk_batch_queue_rqs,
> > > +       .init_hctx      =3D ublk_init_hctx,
> > > +       .timeout        =3D ublk_timeout,
> > > +};
> > > +
> > >  static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_qu=
eue *ubq)
> > >  {
> > >         int i;
> > > @@ -2120,6 +2332,56 @@ static void ublk_cancel_cmd(struct ublk_queue =
*ubq, unsigned tag,
> > >                 io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_f=
lags);
> > >  }
> > >
> > > +static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
> > > +                                 struct ublk_batch_fcmd *fcmd,
> > > +                                 unsigned int issue_flags)
> > > +{
> > > +       bool done;
> > > +
> > > +       spin_lock(&ubq->evts_lock);
> > > +       done =3D (ubq->active_fcmd !=3D fcmd);
> >
> > Needs to use READ_ONCE() since __ublk_release_fcmd() can be called
> > without holding evts_lock?
>
> OK.
>
> >
> > > +       if (done)
> > > +               list_del(&fcmd->node);
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > > +       if (done) {
> > > +               io_uring_cmd_done(fcmd->cmd, UBLK_IO_RES_ABORT, issue=
_flags);
> > > +               ublk_batch_free_fcmd(fcmd);
> > > +       }
> > > +}
> > > +
> > > +static void ublk_batch_cancel_queue(struct ublk_queue *ubq)
> > > +{
> > > +       LIST_HEAD(fcmd_list);
> > > +
> > > +       spin_lock(&ubq->evts_lock);
> > > +       ubq->force_abort =3D true;
> > > +       list_splice_init(&ubq->fcmd_head, &fcmd_list);
> > > +       if (ubq->active_fcmd)
> > > +               list_move(&ubq->active_fcmd->node, &ubq->fcmd_head);
> >
> > Similarly, needs READ_ONCE()?
>
> OK.
>
> But this one may not be necessary, since now everything is just quiesced,
> and the lockless code path won't hit any more.

Good point. I think a comment to that effect would be helpful.

Best,
Caleb

>
> >
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > > +       while (!list_empty(&fcmd_list)) {
> > > +               struct ublk_batch_fcmd *fcmd =3D list_first_entry(&fc=
md_list,
> > > +                               struct ublk_batch_fcmd, node);
> > > +
> > > +               ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED)=
;
> > > +       }
> > > +}
> > > +
> > > +static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
> > > +                                unsigned int issue_flags)
> > > +{
> > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd=
);
> > > +       struct ublk_batch_fcmd *fcmd =3D pdu->fcmd;
> > > +       struct ublk_queue *ubq =3D pdu->ubq;
> > > +
> > > +       if (!ubq->canceling)
> >
> > Is it not racy to access ubq->canceling without any lock held?
>
> OK, will switch to call ublk_start_cancel() unconditionally.
>
> >
> > > +               ublk_start_cancel(ubq->dev);
> > > +
> > > +       ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
> > > +}
> > > +
> > >  /*
> > >   * The ublk char device won't be closed when calling cancel fn, so b=
oth
> > >   * ublk device and queue are guaranteed to be live
> > > @@ -2171,6 +2433,11 @@ static void ublk_cancel_queue(struct ublk_queu=
e *ubq)
> > >  {
> > >         int i;
> > >
> > > +       if (ublk_support_batch_io(ubq)) {
> > > +               ublk_batch_cancel_queue(ubq);
> > > +               return;
> > > +       }
> > > +
> > >         for (i =3D 0; i < ubq->q_depth; i++)
> > >                 ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
> > >  }
> > > @@ -3091,6 +3358,74 @@ static int ublk_check_batch_cmd(const struct u=
blk_batch_io_data *data)
> > >         return ublk_check_batch_cmd_flags(uc);
> > >  }
> > >
> > > +static int ublk_batch_attach(struct ublk_queue *ubq,
> > > +                            struct ublk_batch_io_data *data,
> > > +                            struct ublk_batch_fcmd *fcmd)
> > > +{
> > > +       struct ublk_batch_fcmd *new_fcmd =3D NULL;
> > > +       bool free =3D false;
> > > +
> > > +       spin_lock(&ubq->evts_lock);
> > > +       if (unlikely(ubq->force_abort || ubq->canceling)) {
> > > +               free =3D true;
> > > +       } else {
> > > +               list_add_tail(&fcmd->node, &ubq->fcmd_head);
> > > +               new_fcmd =3D __ublk_acquire_fcmd(ubq);
> > > +       }
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > > +       /*
> > > +        * If the two fetch commands are originated from same io_ring=
_ctx,
> > > +        * run batch dispatch directly. Otherwise, schedule task work=
 for
> > > +        * doing it.
> > > +        */
> > > +       if (new_fcmd && io_uring_cmd_ctx_handle(new_fcmd->cmd) =3D=3D
> > > +                       io_uring_cmd_ctx_handle(fcmd->cmd)) {
> > > +               data->cmd =3D new_fcmd->cmd;
> > > +               ublk_batch_dispatch(ubq, data, new_fcmd);
> > > +       } else if (new_fcmd) {
> > > +               io_uring_cmd_complete_in_task(new_fcmd->cmd,
> > > +                               ublk_batch_tw_cb);
> > > +       }
> >
> > Return early if (!new_fcmd) to reduce indentation?
> >
> > > +
> > > +       if (free) {
> > > +               ublk_batch_free_fcmd(fcmd);
> > > +               return -ENODEV;
> > > +       }
> >
> > Move the if (free) check directly after spin_unlock(&ubq->evts_lock)?
>
> Yeah, this is better.
>
> >
> > > +       return -EIOCBQUEUED;
> >
> > > +}
> > > +
> > > +static int ublk_handle_batch_fetch_cmd(struct ublk_batch_io_data *da=
ta)
> > > +{
> > > +       struct ublk_queue *ubq =3D ublk_get_queue(data->ub, data->hea=
der.q_id);
> > > +       struct ublk_batch_fcmd *fcmd =3D ublk_batch_alloc_fcmd(data->=
cmd);
> > > +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(dat=
a->cmd);
> > > +
> > > +       if (!fcmd)
> > > +               return -ENOMEM;
> > > +
> > > +       pdu->ubq =3D ubq;
> > > +       pdu->fcmd =3D fcmd;
> > > +       io_uring_cmd_mark_cancelable(data->cmd, data->issue_flags);
> > > +
> > > +       return ublk_batch_attach(ubq, data, fcmd);
> > > +}
> > > +
> > > +static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *=
data,
> > > +                                        const struct ublk_batch_io *=
uc)
> > > +{
> > > +       if (!(data->cmd->flags & IORING_URING_CMD_MULTISHOT))
> > > +               return -EINVAL;
> > > +
> > > +       if (uc->elem_bytes !=3D sizeof(__u16))
> > > +               return -EINVAL;
> > > +
> > > +       if (uc->flags !=3D 0)
> > > +               return -E2BIG;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
> > >                                        unsigned int issue_flags)
> > >  {
> > > @@ -3113,6 +3448,11 @@ static int ublk_ch_batch_io_uring_cmd(struct i=
o_uring_cmd *cmd,
> > >         if (data.header.q_id >=3D ub->dev_info.nr_hw_queues)
> > >                 goto out;
> > >
> > > +       if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
> > > +               ublk_batch_cancel_fn(cmd, issue_flags);
> > > +               return 0;
> > > +       }
> >
> > Move this to the top of the function before the other logic that's not
> > necessary in the cancel case?
>
> Yeah, looks better.
>
>
> Thanks,
> Ming
>

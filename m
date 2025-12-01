Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D31EB19B
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764568561; cv=none; b=O0SDu/EI3s2CshuL0T2JOjX3BSyDPoLJI0PxfEWzp/+KmHA/hqd5TNEDaO4cviW+EWymWZHXHo7/Uk8Lt58FYz0PStbg25ZGm9muQfs6DGjVlUDNRI2QXDeKWU1tbaZ5n6NT1+zp4+02+7hd5dzxSpIYfjeo9ICWDW5+1rZABwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764568561; c=relaxed/simple;
	bh=ILbFDzBg0dKSScQMILvGGHg/Pgh4SxH5iXx1xUkB27g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGzFviR7EWxC6h4Zyjkr+e3E14fYCIwoPsLt/4HCB565PmSK+iT4wwT9ECFGwoq0pyRyqVOEtpzHNz01/ZA0j8FP853U3Ww4eK5tqbPxL5i10SYGOMA/dCB3Ftn9LvZFPMEZTxdeKpTCT8R9OxbXeBxWzRVL3/mNBrYnL8m6MhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HFh6TVIe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HFh6TVIe"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8ba3c8ca1so497047b3a.2
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 21:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764568559; x=1765173359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEXWta/JVG3Yt5uOdVI7psrZmhkfeHDk/SCZ/2eEEGM=;
        b=HFh6TVIeHaepMMm64sgY6yBFN0Hmg2wt7RGxTxKdVTxGfApxtRAQ25wfIJskBBX5L1
         TG23UvuSmpj4Muu9yTMX21Cpl4CB/JUI+mxLVRDf4n53aj6fgP5/kwQhWvgA2oHbpXOZ
         TNvleK2qUHtP3Wtfgj5cFJSfigGHB95otC6XOzaJTV8uuL241YD7RdIeHjeMNhzKgl3+
         qBElWiloJxQfXM6Ru2rxZE+LDcRH6j3kUTwWB1tvAs+CdJ8Bkw3wT5WlGUFMy0VIAqV/
         yo62JXrakkYie4HPlHKNJXI/bVg+Xku1IKE1oLeH5mbLfvsPL32kupMQznJNiG718Zve
         I/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764568559; x=1765173359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEXWta/JVG3Yt5uOdVI7psrZmhkfeHDk/SCZ/2eEEGM=;
        b=CkHh8gxEKO1HcncUz/QGVMTjh2ri+2mNaF1OX3ZAo6+vBZCEpdz/8c51fHV725zhLz
         MVMxOXq3+FNTtPS91m0tnrj31aUSLOOWKqNN+Wq1ldNzBZfIxC58iAaTaL3ZFkevJSWp
         Rw7eB5CENixta04Ks9k14h7q+QqfYMT3zHmRFc9uEaI1licaQsnBjU5brazhK/zwjPmS
         cGYcV9OE42Ix4fycVHDfiDwNh03eIAXftNtsJaYdCAQgnUGwVFZOIbUm+x7Wihnf1ztT
         GM2ZlfGk7RRyOeYQNzmDHQsprcMIIc+1lNfkEq3xqhdSEzyvIOp6mGbc7ocoZyuIO2bU
         GroQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyAm2lSevSqhDJNg+rURtmjoz8ZWgUeIF0B+63n0Q2f1O68eiMbEXfY5beSQSbp3wtF4ZGeSld26qtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfj3LuvuTdpR/beBFG55SkQDNmXeg/1Uy1U5UUC1EjbBDbL/rJ
	AbZS7wGgWC/N2uuEo7wrfcXnsYZDKu5AeXIb7XP+joHoWwf76Yj1rN4nor/4O/QFlRLyukOZhaZ
	NiUmGV2pHbatlXWQUb108T8PdPDKitK+NcnrDf45zaQ==
X-Gm-Gg: ASbGncvC5rLjWvaexH3MT9GVtUnO3dRz5iaPQKCTV/Ssla7714iQmg1nIcHpFvhPplk
	9mCTRxJpCnI6ljFeLEgOsIQ8RzTanc+olWuCN0PDFA68gv49QwdozomsRyg5r+76zdY1VUAKfBP
	EaQ/A4zJCJDuVMNOLco8j96eegwDqqQidH96cheZZG2SxpHf1Ney9Pdpx4uxVmlPH+jp789Q1L1
	HIBHKyaZVxvErNdLahTOjMYTkjL6L0y0YMYi0Lixlua2oajU1RpZYc0PCkEkEoLMDVj3Zlp
X-Google-Smtp-Source: AGHT+IGee0pkNqzXE6f9QvwYA6p1rYdCHzf2lrdoIPqsbPJQ5cB/WJF5/Ndd60YJ0l6I5PMH8zf73xUXh1HMiov6Lxc=
X-Received: by 2002:a05:7022:429e:b0:119:e56b:46b9 with SMTP id
 a92af1059eb24-11c9f3806d4mr22629641c88.3.1764568558467; Sun, 30 Nov 2025
 21:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-15-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-15-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 30 Nov 2025 21:55:47 -0800
X-Gm-Features: AWmQ_bmlhBwC3eJ6imG7Y_H2uVEmpHPSQzHg6S2Csk7EceoqQzoDXX_-kzHYZP4
Message-ID: <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch processing
> of I/O requests. This multishot uring_cmd allows the ublk server to fetch
> multiple I/O commands in a single operation, significantly reducing
> submission overhead compared to individual FETCH_REQ* commands.
>
> Key Design Features:
>
> 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/O
>    commands, with the batch size limited by the provided buffer length.
>
> 2. Dynamic Load Balancing: Multiple fetch commands can be submitted
>    simultaneously, but only one is active at any time. This enables
>    efficient load distribution across multiple server task contexts.
>
> 3. Implicit State Management: The implementation uses three key variables
>    to track state:
>    - evts_fifo: Queue of request tags awaiting processing
>    - fcmd_head: List of available fetch commands
>    - active_fcmd: Currently active fetch command (NULL =3D none active)
>
>    States are derived implicitly:
>    - IDLE: No fetch commands available
>    - READY: Fetch commands available, none active
>    - ACTIVE: One fetch command processing events
>
> 4. Lockless Reader Optimization: The active fetch command can read from
>    evts_fifo without locking (single reader guarantee), while writers
>    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memory
>    barrier pairing plays key role for the single lockless reader
>    optimization.
>
> Implementation Details:
>
> - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
> - __ublk_pick_active_fcmd() selects an available fetch command when
>   events arrive and no command is currently active

What is __ublk_pick_active_fcmd()? I don't see a function with that name.

> - ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
>   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> - State transitions are coordinated via evts_lock to maintain consistency
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 412 +++++++++++++++++++++++++++++++---
>  include/uapi/linux/ublk_cmd.h |   7 +
>  2 files changed, 388 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cc9c92d97349..2e5e392c939e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -93,6 +93,7 @@
>
>  /* ublk batch fetch uring_cmd */
>  struct ublk_batch_fcmd {
> +       struct list_head node;
>         struct io_uring_cmd *cmd;
>         unsigned short buf_group;
>  };
> @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
>          */
>         struct ublk_queue *ubq;
>
> -       u16 tag;
> +       union {
> +               u16 tag;
> +               struct ublk_batch_fcmd *fcmd; /* batch io only */
> +       };
>  };
>
>  struct ublk_batch_io_data {
> @@ -229,18 +233,36 @@ struct ublk_queue {
>         struct ublk_device *dev;
>
>         /*
> -        * Inflight ublk request tag is saved in this fifo
> +        * Batch I/O State Management:
> +        *
> +        * The batch I/O system uses implicit state management based on t=
he
> +        * combination of three key variables below.
> +        *
> +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> +        *   No fetch commands available, events queue in evts_fifo
> +        *
> +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> +        *   Fetch commands available but none processing events
>          *
> -        * There are multiple writer from ublk_queue_rq() or ublk_queue_r=
qs(),
> -        * so lock is required for storing request tag to fifo
> +        * - ACTIVE: active_fcmd
> +        *   One fetch command actively processing events from evts_fifo
>          *
> -        * Make sure just one reader for fetching request from task work
> -        * function to ublk server, so no need to grab the lock in reader
> -        * side.
> +        * Key Invariants:
> +        * - At most one active_fcmd at any time (single reader)
> +        * - active_fcmd is always from fcmd_head list when non-NULL
> +        * - evts_fifo can be read locklessly by the single active reader
> +        * - All state transitions require evts_lock protection
> +        * - Multiple writers to evts_fifo require lock protection
>          */
>         struct {
>                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
>                 spinlock_t evts_lock;
> +
> +               /* List of fetch commands available to process events */
> +               struct list_head fcmd_head;
> +
> +               /* Currently active fetch command (NULL =3D none active) =
*/
> +               struct ublk_batch_fcmd  *active_fcmd;
>         }____cacheline_aligned_in_smp;
>
>         struct ublk_io ios[] __counted_by(q_depth);
> @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ublk_device *ub=
, struct ublk_queue *ubq);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
>                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
> +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> +                               struct ublk_batch_io_data *data,
> +                               struct ublk_batch_fcmd *fcmd);
>
>  static inline bool ublk_dev_support_batch_io(const struct ublk_device *u=
b)
>  {
>         return false;
>  }
>
> +static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
> +{
> +       return false;
> +}
> +
>  static inline void ublk_io_lock(struct ublk_io *io)
>  {
>         spin_lock(&io->lock);
> @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wait u=
ntil one idr is freed */
>
>  static DEFINE_MUTEX(ublk_ctl_mutex);
>
> +static struct ublk_batch_fcmd *
> +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> +{
> +       struct ublk_batch_fcmd *fcmd =3D kzalloc(sizeof(*fcmd), GFP_NOIO)=
;

An allocation in the I/O path seems unfortunate. Is there not room to
store the struct ublk_batch_fcmd in the io_uring_cmd pdu?
> +
> +       if (fcmd) {
> +               fcmd->cmd =3D cmd;
> +               fcmd->buf_group =3D READ_ONCE(cmd->sqe->buf_index);

Is it necessary to store sample this here just to pass it back to the
io_uring layer? Wouldn't the io_uring layer already have access to it
in struct io_kiocb's buf_index field?

> +       }
> +       return fcmd;
> +}
> +
> +static void ublk_batch_free_fcmd(struct ublk_batch_fcmd *fcmd)
> +{
> +       kfree(fcmd);
> +}
> +
> +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> +{
> +       WRITE_ONCE(ubq->active_fcmd, NULL);
> +}
>
> -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data =
*data,
> +/*
> + * Nothing can move on, so clear ->active_fcmd, and the caller should st=
op
> + * dispatching
> + */
> +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> +                                       const struct ublk_batch_io_data *=
data,
>                                         struct ublk_batch_fcmd *fcmd,
>                                         int res)
>  {
> +       spin_lock(&ubq->evts_lock);
> +       list_del(&fcmd->node);
> +       WARN_ON_ONCE(fcmd !=3D ubq->active_fcmd);
> +       __ublk_release_fcmd(ubq);
> +       spin_unlock(&ubq->evts_lock);
> +
>         io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> -       fcmd->cmd =3D NULL;
> +       ublk_batch_free_fcmd(fcmd);
>  }
>
>  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> @@ -1491,6 +1553,8 @@ static int __ublk_batch_dispatch(struct ublk_queue =
*ubq,
>         bool needs_filter;
>         int ret;
>
> +       WARN_ON_ONCE(data->cmd !=3D fcmd->cmd);
> +
>         sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &l=
en,
>                                          data->issue_flags);
>         if (sel.val < 0)
> @@ -1548,23 +1612,94 @@ static int __ublk_batch_dispatch(struct ublk_queu=
e *ubq,
>         return ret;
>  }
>
> -static __maybe_unused int
> -ublk_batch_dispatch(struct ublk_queue *ubq,
> -                   const struct ublk_batch_io_data *data,
> -                   struct ublk_batch_fcmd *fcmd)
> +static struct ublk_batch_fcmd *__ublk_acquire_fcmd(
> +               struct ublk_queue *ubq)
> +{
> +       struct ublk_batch_fcmd *fcmd;
> +
> +       lockdep_assert_held(&ubq->evts_lock);
> +
> +       /*
> +        * Ordering updating ubq->evts_fifo and checking ubq->active_fcmd=
.
> +        *
> +        * The pair is the smp_mb() in ublk_batch_dispatch().
> +        *
> +        * If ubq->active_fcmd is observed as non-NULL, the new added tag=
s
> +        * can be visisible in ublk_batch_dispatch() with the barrier pai=
ring.
> +        */
> +       smp_mb();
> +       if (READ_ONCE(ubq->active_fcmd)) {
> +               fcmd =3D NULL;
> +       } else {
> +               fcmd =3D list_first_entry_or_null(&ubq->fcmd_head,
> +                               struct ublk_batch_fcmd, node);
> +               WRITE_ONCE(ubq->active_fcmd, fcmd);
> +       }
> +       return fcmd;
> +}
> +
> +static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
> +                          unsigned int issue_flags)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       struct ublk_batch_fcmd *fcmd =3D pdu->fcmd;
> +       struct ublk_batch_io_data data =3D {
> +               .ub =3D pdu->ubq->dev,
> +               .cmd =3D fcmd->cmd,
> +               .issue_flags =3D issue_flags,
> +       };
> +
> +       WARN_ON_ONCE(pdu->ubq->active_fcmd !=3D fcmd);
> +
> +       ublk_batch_dispatch(pdu->ubq, &data, fcmd);
> +}
> +
> +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> +                               struct ublk_batch_io_data *data,
> +                               struct ublk_batch_fcmd *fcmd)
>  {
> +       struct ublk_batch_fcmd *new_fcmd;

Is the new_fcmd variable necessary? Can fcmd be reused instead?

> +       void *handle;
> +       bool empty;
>         int ret =3D 0;
>
> +again:
>         while (!ublk_io_evts_empty(ubq)) {
>                 ret =3D __ublk_batch_dispatch(ubq, data, fcmd);
>                 if (ret <=3D 0)
>                         break;
>         }
>
> -       if (ret < 0)
> -               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> +       if (ret < 0) {
> +               ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
> +               return;
> +       }
>
> -       return ret;
> +       handle =3D io_uring_cmd_ctx_handle(fcmd->cmd);
> +       __ublk_release_fcmd(ubq);
> +       /*
> +        * Order clearing ubq->active_fcmd from __ublk_release_fcmd() and
> +        * checking ubq->evts_fifo.
> +        *
> +        * The pair is the smp_mb() in __ublk_acquire_fcmd().
> +        */
> +       smp_mb();
> +       empty =3D ublk_io_evts_empty(ubq);
> +       if (likely(empty))

nit: empty variable seems unnecessary

> +               return;
> +
> +       spin_lock(&ubq->evts_lock);
> +       new_fcmd =3D __ublk_acquire_fcmd(ubq);
> +       spin_unlock(&ubq->evts_lock);
> +
> +       if (!new_fcmd)
> +               return;
> +       if (handle =3D=3D io_uring_cmd_ctx_handle(new_fcmd->cmd)) {

This check seems to be meant to decide whether the new and old
UBLK_U_IO_FETCH_IO_CMDS commands can execute in the same task work?
But belonging to the same io_uring context doesn't necessarily mean
that the same task issued them. It seems like it would be safer to
always dispatch new_fcmd->cmd to task work.

> +               data->cmd =3D new_fcmd->cmd;
> +               fcmd =3D new_fcmd;
> +               goto again;
> +       }
> +       io_uring_cmd_complete_in_task(new_fcmd->cmd, ublk_batch_tw_cb);
>  }
>
>  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> @@ -1576,13 +1711,27 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *c=
md,
>         ublk_dispatch_req(ubq, pdu->req, issue_flags);
>  }
>
> -static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> +static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq, b=
ool last)
>  {
> -       struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
> -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       if (ublk_support_batch_io(ubq)) {
> +               unsigned short tag =3D rq->tag;
> +               struct ublk_batch_fcmd *fcmd =3D NULL;
>
> -       pdu->req =3D rq;
> -       io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
> +               spin_lock(&ubq->evts_lock);
> +               kfifo_put(&ubq->evts_fifo, tag);
> +               if (last)
> +                       fcmd =3D __ublk_acquire_fcmd(ubq);
> +               spin_unlock(&ubq->evts_lock);
> +
> +               if (fcmd)
> +                       io_uring_cmd_complete_in_task(fcmd->cmd, ublk_bat=
ch_tw_cb);
> +       } else {
> +               struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
> +               struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu=
(cmd);
> +
> +               pdu->req =3D rq;
> +               io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
> +       }
>  }
>
>  static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> @@ -1600,14 +1749,44 @@ static void ublk_cmd_list_tw_cb(struct io_uring_c=
md *cmd,
>         } while (rq);
>  }
>
> -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> +static void ublk_batch_queue_cmd_list(struct ublk_queue *ubq, struct rq_=
list *l)
>  {
> -       struct io_uring_cmd *cmd =3D io->cmd;
> -       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       unsigned short tags[MAX_NR_TAG];
> +       struct ublk_batch_fcmd *fcmd;
> +       struct request *rq;
> +       unsigned cnt =3D 0;
> +
> +       spin_lock(&ubq->evts_lock);
> +       rq_list_for_each(l, rq) {
> +               tags[cnt++] =3D (unsigned short)rq->tag;
> +               if (cnt >=3D MAX_NR_TAG) {
> +                       kfifo_in(&ubq->evts_fifo, tags, cnt);
> +                       cnt =3D 0;
> +               }
> +       }
> +       if (cnt)
> +               kfifo_in(&ubq->evts_fifo, tags, cnt);
> +       fcmd =3D __ublk_acquire_fcmd(ubq);
> +       spin_unlock(&ubq->evts_lock);
>
> -       pdu->req_list =3D rq_list_peek(l);
>         rq_list_init(l);
> -       io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
> +       if (fcmd)
> +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb=
);
> +}
> +
> +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct ublk_io *=
io,
> +                               struct rq_list *l, bool batch)
> +{
> +       if (batch) {
> +               ublk_batch_queue_cmd_list(ubq, l);
> +       } else {
> +               struct io_uring_cmd *cmd =3D io->cmd;
> +               struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu=
(cmd);
> +
> +               pdu->req_list =3D rq_list_peek(l);
> +               rq_list_init(l);
> +               io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
> +       }
>  }
>
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> @@ -1686,7 +1865,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_=
ctx *hctx,
>                 return BLK_STS_OK;
>         }
>
> -       ublk_queue_cmd(ubq, rq);
> +       ublk_queue_cmd(ubq, rq, bd->last);
>         return BLK_STS_OK;
>  }
>
> @@ -1698,11 +1877,25 @@ static inline bool ublk_belong_to_same_batch(cons=
t struct ublk_io *io,
>                 (io->task =3D=3D io2->task);
>  }
>
> -static void ublk_queue_rqs(struct rq_list *rqlist)
> +static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +       struct ublk_queue *ubq =3D hctx->driver_data;
> +       struct ublk_batch_fcmd *fcmd;
> +
> +       spin_lock(&ubq->evts_lock);
> +       fcmd =3D __ublk_acquire_fcmd(ubq);
> +       spin_unlock(&ubq->evts_lock);
> +
> +       if (fcmd)
> +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb=
);
> +}
> +
> +static void __ublk_queue_rqs(struct rq_list *rqlist, bool batch)
>  {
>         struct rq_list requeue_list =3D { };
>         struct rq_list submit_list =3D { };
>         struct ublk_io *io =3D NULL;
> +       struct ublk_queue *ubq =3D NULL;
>         struct request *req;
>
>         while ((req =3D rq_list_pop(rqlist))) {
> @@ -1716,16 +1909,27 @@ static void ublk_queue_rqs(struct rq_list *rqlist=
)
>
>                 if (io && !ublk_belong_to_same_batch(io, this_io) &&
>                                 !rq_list_empty(&submit_list))
> -                       ublk_queue_cmd_list(io, &submit_list);
> +                       ublk_queue_cmd_list(ubq, io, &submit_list, batch)=
;

This seems to assume that all the requests belong to the same
ublk_queue, which isn't required

>                 io =3D this_io;
> +               ubq =3D this_q;
>                 rq_list_add_tail(&submit_list, req);
>         }
>
>         if (!rq_list_empty(&submit_list))
> -               ublk_queue_cmd_list(io, &submit_list);
> +               ublk_queue_cmd_list(ubq, io, &submit_list, batch);

Same here

>         *rqlist =3D requeue_list;
>  }
>
> +static void ublk_queue_rqs(struct rq_list *rqlist)
> +{
> +       __ublk_queue_rqs(rqlist, false);
> +}
> +
> +static void ublk_batch_queue_rqs(struct rq_list *rqlist)
> +{
> +       __ublk_queue_rqs(rqlist, true);
> +}
> +
>  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
>                 unsigned int hctx_idx)
>  {
> @@ -1743,6 +1947,14 @@ static const struct blk_mq_ops ublk_mq_ops =3D {
>         .timeout        =3D ublk_timeout,
>  };
>
> +static const struct blk_mq_ops ublk_batch_mq_ops =3D {
> +       .commit_rqs     =3D ublk_commit_rqs,
> +       .queue_rq       =3D ublk_queue_rq,
> +       .queue_rqs      =3D ublk_batch_queue_rqs,
> +       .init_hctx      =3D ublk_init_hctx,
> +       .timeout        =3D ublk_timeout,
> +};
> +
>  static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue =
*ubq)
>  {
>         int i;
> @@ -2120,6 +2332,56 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq=
, unsigned tag,
>                 io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags=
);
>  }
>
> +static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
> +                                 struct ublk_batch_fcmd *fcmd,
> +                                 unsigned int issue_flags)
> +{
> +       bool done;
> +
> +       spin_lock(&ubq->evts_lock);
> +       done =3D (ubq->active_fcmd !=3D fcmd);

Needs to use READ_ONCE() since __ublk_release_fcmd() can be called
without holding evts_lock?

> +       if (done)
> +               list_del(&fcmd->node);
> +       spin_unlock(&ubq->evts_lock);
> +
> +       if (done) {
> +               io_uring_cmd_done(fcmd->cmd, UBLK_IO_RES_ABORT, issue_fla=
gs);
> +               ublk_batch_free_fcmd(fcmd);
> +       }
> +}
> +
> +static void ublk_batch_cancel_queue(struct ublk_queue *ubq)
> +{
> +       LIST_HEAD(fcmd_list);
> +
> +       spin_lock(&ubq->evts_lock);
> +       ubq->force_abort =3D true;
> +       list_splice_init(&ubq->fcmd_head, &fcmd_list);
> +       if (ubq->active_fcmd)
> +               list_move(&ubq->active_fcmd->node, &ubq->fcmd_head);

Similarly, needs READ_ONCE()?

> +       spin_unlock(&ubq->evts_lock);
> +
> +       while (!list_empty(&fcmd_list)) {
> +               struct ublk_batch_fcmd *fcmd =3D list_first_entry(&fcmd_l=
ist,
> +                               struct ublk_batch_fcmd, node);
> +
> +               ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED);
> +       }
> +}
> +
> +static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
> +                                unsigned int issue_flags)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       struct ublk_batch_fcmd *fcmd =3D pdu->fcmd;
> +       struct ublk_queue *ubq =3D pdu->ubq;
> +
> +       if (!ubq->canceling)

Is it not racy to access ubq->canceling without any lock held?

> +               ublk_start_cancel(ubq->dev);
> +
> +       ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
> +}
> +
>  /*
>   * The ublk char device won't be closed when calling cancel fn, so both
>   * ublk device and queue are guaranteed to be live
> @@ -2171,6 +2433,11 @@ static void ublk_cancel_queue(struct ublk_queue *u=
bq)
>  {
>         int i;
>
> +       if (ublk_support_batch_io(ubq)) {
> +               ublk_batch_cancel_queue(ubq);
> +               return;
> +       }
> +
>         for (i =3D 0; i < ubq->q_depth; i++)
>                 ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
>  }
> @@ -3091,6 +3358,74 @@ static int ublk_check_batch_cmd(const struct ublk_=
batch_io_data *data)
>         return ublk_check_batch_cmd_flags(uc);
>  }
>
> +static int ublk_batch_attach(struct ublk_queue *ubq,
> +                            struct ublk_batch_io_data *data,
> +                            struct ublk_batch_fcmd *fcmd)
> +{
> +       struct ublk_batch_fcmd *new_fcmd =3D NULL;
> +       bool free =3D false;
> +
> +       spin_lock(&ubq->evts_lock);
> +       if (unlikely(ubq->force_abort || ubq->canceling)) {
> +               free =3D true;
> +       } else {
> +               list_add_tail(&fcmd->node, &ubq->fcmd_head);
> +               new_fcmd =3D __ublk_acquire_fcmd(ubq);
> +       }
> +       spin_unlock(&ubq->evts_lock);
> +
> +       /*
> +        * If the two fetch commands are originated from same io_ring_ctx=
,
> +        * run batch dispatch directly. Otherwise, schedule task work for
> +        * doing it.
> +        */
> +       if (new_fcmd && io_uring_cmd_ctx_handle(new_fcmd->cmd) =3D=3D
> +                       io_uring_cmd_ctx_handle(fcmd->cmd)) {
> +               data->cmd =3D new_fcmd->cmd;
> +               ublk_batch_dispatch(ubq, data, new_fcmd);
> +       } else if (new_fcmd) {
> +               io_uring_cmd_complete_in_task(new_fcmd->cmd,
> +                               ublk_batch_tw_cb);
> +       }

Return early if (!new_fcmd) to reduce indentation?

> +
> +       if (free) {
> +               ublk_batch_free_fcmd(fcmd);
> +               return -ENODEV;
> +       }

Move the if (free) check directly after spin_unlock(&ubq->evts_lock)?

> +       return -EIOCBQUEUED;

> +}
> +
> +static int ublk_handle_batch_fetch_cmd(struct ublk_batch_io_data *data)
> +{
> +       struct ublk_queue *ubq =3D ublk_get_queue(data->ub, data->header.=
q_id);
> +       struct ublk_batch_fcmd *fcmd =3D ublk_batch_alloc_fcmd(data->cmd)=
;
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(data->c=
md);
> +
> +       if (!fcmd)
> +               return -ENOMEM;
> +
> +       pdu->ubq =3D ubq;
> +       pdu->fcmd =3D fcmd;
> +       io_uring_cmd_mark_cancelable(data->cmd, data->issue_flags);
> +
> +       return ublk_batch_attach(ubq, data, fcmd);
> +}
> +
> +static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data=
,
> +                                        const struct ublk_batch_io *uc)
> +{
> +       if (!(data->cmd->flags & IORING_URING_CMD_MULTISHOT))
> +               return -EINVAL;
> +
> +       if (uc->elem_bytes !=3D sizeof(__u16))
> +               return -EINVAL;
> +
> +       if (uc->flags !=3D 0)
> +               return -E2BIG;
> +
> +       return 0;
> +}
> +
>  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
>                                        unsigned int issue_flags)
>  {
> @@ -3113,6 +3448,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
ing_cmd *cmd,
>         if (data.header.q_id >=3D ub->dev_info.nr_hw_queues)
>                 goto out;
>
> +       if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
> +               ublk_batch_cancel_fn(cmd, issue_flags);
> +               return 0;
> +       }

Move this to the top of the function before the other logic that's not
necessary in the cancel case?

Best,
Caleb

> +
>         switch (cmd_op) {
>         case UBLK_U_IO_PREP_IO_CMDS:
>                 ret =3D ublk_check_batch_cmd(&data);
> @@ -3126,6 +3466,12 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
ing_cmd *cmd,
>                         goto out;
>                 ret =3D ublk_handle_batch_commit_cmd(&data);
>                 break;
> +       case UBLK_U_IO_FETCH_IO_CMDS:
> +               ret =3D ublk_validate_batch_fetch_cmd(&data, uc);
> +               if (ret)
> +                       goto out;
> +               ret =3D ublk_handle_batch_fetch_cmd(&data);
> +               break;
>         default:
>                 ret =3D -EOPNOTSUPP;
>         }
> @@ -3327,6 +3673,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>                 ret =3D ublk_io_evts_init(ubq, ubq->q_depth, numa_node);
>                 if (ret)
>                         goto fail;
> +               INIT_LIST_HEAD(&ubq->fcmd_head);
>         }
>         ub->queues[q_id] =3D ubq;
>         ubq->dev =3D ub;
> @@ -3451,7 +3798,10 @@ static void ublk_align_max_io_size(struct ublk_dev=
ice *ub)
>
>  static int ublk_add_tag_set(struct ublk_device *ub)
>  {
> -       ub->tag_set.ops =3D &ublk_mq_ops;
> +       if (ublk_dev_support_batch_io(ub))
> +               ub->tag_set.ops =3D &ublk_batch_mq_ops;
> +       else
> +               ub->tag_set.ops =3D &ublk_mq_ops;
>         ub->tag_set.nr_hw_queues =3D ub->dev_info.nr_hw_queues;
>         ub->tag_set.queue_depth =3D ub->dev_info.queue_depth;
>         ub->tag_set.numa_node =3D NUMA_NO_NODE;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 295ec8f34173..cd894c1d188e 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -120,6 +120,13 @@
>  #define        UBLK_U_IO_COMMIT_IO_CMDS        \
>         _IOWR('u', 0x26, struct ublk_batch_io)
>
> +/*
> + * Fetch io commands to provided buffer in multishot style,
> + * `IORING_URING_CMD_MULTISHOT` is required for this command.
> + */
> +#define        UBLK_U_IO_FETCH_IO_CMDS         \
> +       _IOWR('u', 0x27, struct ublk_batch_io)
> +
>  /* only ABORT means that no re-fetch */
>  #define UBLK_IO_RES_OK                 0
>  #define UBLK_IO_RES_NEED_GET_DATA      1
> --
> 2.47.0
>

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046D283FF0
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765093134; cv=none; b=CNomxeWl3JzVw7ZqFBx/UFgVwwuVc9GlEiUATUOUo6LJAqmNv+Yv/eOoybou4FjQ0P/OeoWTxY+ln4b09C48QbMiRfNmwwW4qED5R04NAATAe/jkzYKESZs85SP4TTK9vRc4iufaD8dInjXgnwAlhQ+IVsKWlhHowqAnfLvk/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765093134; c=relaxed/simple;
	bh=oy+ATMMuIlnSqQZW41nvwD5+QfSo09rIgj7KyCKAzuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+XOSrFob6XrarPPUbN9VCBTv+3Txd8Pe0GLalprHl6ZndlZcdn3ru4BM9HYNkUM3VoTKzzqKZt1yHIiXvH4QmvHA9OQzQ+LfYvYc2VD3z14Nbdiq4r8RSjjvtiImRS/XZYplbAfvHsG6GvL9B+NMlL0HRbSpQKUCAJNmLY458w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c4rghvhq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c4rghvhq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e2736308so5228455ad.1
        for <linux-block@vger.kernel.org>; Sat, 06 Dec 2025 23:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765093131; x=1765697931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5afjizVU+oF37qqn9YDjCGAr9AcGmz9gjOtabyFDJ8=;
        b=c4rghvhqfnZQ63Fmk9mH0beYSEx0hr3LB+MULMOvIL5Eqmw3ShIz3kkCtBmz8Hpa2V
         AXcoIPShzOfYN9VGyryR+0v2W0zZrNSaZai0aK4lcky7fmIIH4JxItE7ZMx8+WaQ/MjS
         fQFN66AOr8Bmob9sakrdyzs/WmSVmHSIxXvbJIggWhnAD5WHcODyuwOmvHiBoZXpAmTe
         sbcTxHiyo22XP6KRaOqLgZGSdHv/9+028JJOexpWU/khQyuwqxMIzjsQATSxK+5WKtj1
         gwoue8Hn7pK25D72o9hKt8WPPxiEOWDGurcLpZnP8uvWgQRcr2bhXtoP0e66YG1iCrMD
         dm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765093131; x=1765697931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5afjizVU+oF37qqn9YDjCGAr9AcGmz9gjOtabyFDJ8=;
        b=YOyq61tP9FF+WgTg+Oo6vgnyxXjYufmcDMlK1gZQZme2/Zn+PZZrtD2vsQ6VpjflAA
         A5alhfS/aqEqTS9Hv10wkmU3k7TAz5faiRU++ZwxoYDGHdseYG1OmYU6S9Lpk4L3RbT7
         CUgaDiasyBc/VZbELhGSxhIYAg7g34Y2ORhcjY6zrhioG3YoBkh20LH/cC2QwO/PMfwS
         ypNmf2A75F0+Hq3MYfvgHZwQhOyBUPijr9qImJnzgrlYc0wL/pBRq/UpTUCl9NFKCu2r
         VNcitrUu6bFSFVD3a1HQEUW+mPd8vtQOPoMaAHnBFWWywt6/84bYyUz1qQZDOegP6vzD
         Zsmg==
X-Forwarded-Encrypted: i=1; AJvYcCUgDnIEWItdv7zHi4ewUTlW+tk29uH7+FYTA0Gg4fNth/5jHvpmeUZFWtxoqMOJ2W0YODmwFyajbKAGEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQDRGf8/09lhbnb8INf781DWvRGcsIZ6tYBkLHBXRr7VH7fJP
	An7xEpNkcpwzwOSgkRwz24Jj5bwL6VN1TUcob35R2L2JGXT6MSN6xLpt8qj525ln/cJIO9Dqeul
	aboYt8qBVVvNyvkwUMmIIvFg3/TGoZ85jSUz1PHhXyA==
X-Gm-Gg: ASbGncsmdU5JXh0d+S9Wydq3FYBKDho9uzgG5DNBVF+6wU3bb3LgznexyqW9VSbzlkf
	3olcqnZdjQsIwTqVO9xExwQUR+ZSJ8NIIf8zxl5vFppnNkdT9IIJ8QOfKSS3UB652guJdCQzeWs
	Imvy9/EejnvDTTJhmwzE4hACpnRu8UvNg9UGVImWqr9R2F4ZR+KR/Es3dH0KuYJMRRs64hUVIMf
	8UngKN7nxf/IAIkh/6cvGWxO7aknQrDZM82wZR2U5W9rlm7KbcvLWoHa/AxM2fzMnjZyjxU
X-Google-Smtp-Source: AGHT+IF+usBocMv9RVCT8nsEvFADKzt3DuT2brmVABbBuDvmHemRRtcY7XmiwrBoyrbFFbUUda60dIyq4ETM1hhxaYE=
X-Received: by 2002:a05:7022:e16:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11e03e9450bmr1524194c88.7.1765093130814; Sat, 06 Dec 2025
 23:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-9-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-9-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 6 Dec 2025 23:38:39 -0800
X-Gm-Features: AQt7F2rCOhuWjWKNd2Jr-f8nXtejdSnbGrZnT3AL5A1mnFSR2OdZ85IH3jj5DMI
Message-ID: <CADUfDZpJu+wQWWq2-GJm+ZN-wX3dcb_AYQhJ9ikwGjMEPCqh+w@mail.gmail.com>
Subject: Re: [PATCH V5 08/21] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:21=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
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
> - __ublk_acquire_fcmd() selects an available fetch command when
>   events arrive and no command is currently active
> - ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
>   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> - State transitions are coordinated via evts_lock to maintain consistency
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 392 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |   7 +
>  2 files changed, 391 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 05bf9786751f..de6ce0e17b1b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -93,6 +93,7 @@
>
>  /* ublk batch fetch uring_cmd */
>  struct ublk_batch_fetch_cmd {
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
> +               struct ublk_batch_fetch_cmd *fcmd; /* batch io only */
> +       };
>  };
>
>  struct ublk_batch_io_data {
> @@ -239,10 +243,37 @@ struct ublk_queue {
>          * Make sure just one reader for fetching request from task work
>          * function to ublk server, so no need to grab the lock in reader
>          * side.
> +        *
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
> +        *
> +        * - ACTIVE: active_fcmd
> +        *   One fetch command actively processing events from evts_fifo
> +        *
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
> +               struct ublk_batch_fetch_cmd  *active_fcmd;
>         }____cacheline_aligned_in_smp;
>
>         struct ublk_io ios[] __counted_by(q_depth);
> @@ -294,12 +325,20 @@ static void ublk_abort_queue(struct ublk_device *ub=
, struct ublk_queue *ubq);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
>                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
> +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> +                               const struct ublk_batch_io_data *data,
> +                               struct ublk_batch_fetch_cmd *fcmd);
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
> @@ -620,13 +659,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wait u=
ntil one idr is freed */
>
>  static DEFINE_MUTEX(ublk_ctl_mutex);
>
> +static struct ublk_batch_fetch_cmd *
> +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> +{
> +       struct ublk_batch_fetch_cmd *fcmd =3D kzalloc(sizeof(*fcmd), GFP_=
NOIO);
>
> -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data =
*data,
> +       if (fcmd) {
> +               fcmd->cmd =3D cmd;
> +               fcmd->buf_group =3D READ_ONCE(cmd->sqe->buf_index);
> +       }
> +       return fcmd;
> +}
> +
> +static void ublk_batch_free_fcmd(struct ublk_batch_fetch_cmd *fcmd)
> +{
> +       kfree(fcmd);
> +}
> +
> +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> +{
> +       WRITE_ONCE(ubq->active_fcmd, NULL);
> +}
> +
> +/*
> + * Nothing can move on, so clear ->active_fcmd, and the caller should st=
op
> + * dispatching
> + */
> +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> +                                       const struct ublk_batch_io_data *=
data,
>                                         struct ublk_batch_fetch_cmd *fcmd=
,
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
>  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fcmd,
> @@ -1489,6 +1560,8 @@ static int __ublk_batch_dispatch(struct ublk_queue =
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
> @@ -1552,21 +1625,92 @@ static int __ublk_batch_dispatch(struct ublk_queu=
e *ubq,
>         return ret;
>  }
>
> -static __maybe_unused void

Drop the __maybe_unused in the previous commit that introduced it?

> +static struct ublk_batch_fetch_cmd *__ublk_acquire_fcmd(
> +               struct ublk_queue *ubq)
> +{
> +       struct ublk_batch_fetch_cmd *fcmd;
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
> +                               struct ublk_batch_fetch_cmd, node);
> +               WRITE_ONCE(ubq->active_fcmd, fcmd);
> +       }
> +       return fcmd;
> +}
> +
> +static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
> +                          unsigned int issue_flags)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       struct ublk_batch_fetch_cmd *fcmd =3D pdu->fcmd;
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
> +static void
>  ublk_batch_dispatch(struct ublk_queue *ubq,
>                     const struct ublk_batch_io_data *data,
>                     struct ublk_batch_fetch_cmd *fcmd)
>  {
> +       struct ublk_batch_fetch_cmd *new_fcmd;
> +       unsigned tried =3D 0;
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
> +
> +       __ublk_release_fcmd(ubq);
> +       /*
> +        * Order clearing ubq->active_fcmd from __ublk_release_fcmd() and
> +        * checking ubq->evts_fifo.
> +        *
> +        * The pair is the smp_mb() in __ublk_acquire_fcmd().
> +        */
> +       smp_mb();
> +       if (likely(ublk_io_evts_empty(ubq)))
> +               return;
> +
> +       spin_lock(&ubq->evts_lock);
> +       new_fcmd =3D __ublk_acquire_fcmd(ubq);
> +       spin_unlock(&ubq->evts_lock);
> +
> +       if (!new_fcmd)
> +               return;
> +
> +       /* Avoid lockup by allowing to handle at most 32 batches */
> +       if (new_fcmd =3D=3D fcmd && tried++ < 32)
> +               goto again;
> +
> +       io_uring_cmd_complete_in_task(new_fcmd->cmd, ublk_batch_tw_cb);
>  }
>
>  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> @@ -1578,6 +1722,21 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cm=
d,
>         ublk_dispatch_req(ubq, pdu->req, issue_flags);
>  }
>
> +static void ublk_batch_queue_cmd(struct ublk_queue *ubq, struct request =
*rq, bool last)
> +{
> +       unsigned short tag =3D rq->tag;
> +       struct ublk_batch_fetch_cmd *fcmd =3D NULL;
> +
> +       spin_lock(&ubq->evts_lock);
> +       kfifo_put(&ubq->evts_fifo, tag);
> +       if (last)
> +               fcmd =3D __ublk_acquire_fcmd(ubq);
> +       spin_unlock(&ubq->evts_lock);
> +
> +       if (fcmd)
> +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb=
);
> +}
> +
>  static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  {
>         struct io_uring_cmd *cmd =3D ubq->ios[rq->tag].cmd;
> @@ -1688,7 +1847,10 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>                 return BLK_STS_OK;
>         }
>
> -       ublk_queue_cmd(ubq, rq);
> +       if (ublk_support_batch_io(ubq))
> +               ublk_batch_queue_cmd(ubq, rq, bd->last);
> +       else
> +               ublk_queue_cmd(ubq, rq);

Since there's a separate struct blk_mq_ops for batch mode, would it
make sense to have separate ->queue_rq() implementations to avoid this
branch?

>         return BLK_STS_OK;
>  }
>
> @@ -1700,6 +1862,19 @@ static inline bool ublk_belong_to_same_batch(const=
 struct ublk_io *io,
>                 (io->task =3D=3D io2->task);
>  }
>
> +static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +       struct ublk_queue *ubq =3D hctx->driver_data;
> +       struct ublk_batch_fetch_cmd *fcmd;
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
>  static void ublk_queue_rqs(struct rq_list *rqlist)
>  {
>         struct rq_list requeue_list =3D { };
> @@ -1728,6 +1903,57 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
>         *rqlist =3D requeue_list;
>  }
>
> +static void ublk_batch_queue_cmd_list(struct ublk_queue *ubq, struct rq_=
list *l)
> +{
> +       unsigned short tags[MAX_NR_TAG];
> +       struct ublk_batch_fetch_cmd *fcmd;
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
> +
> +       rq_list_init(l);
> +       if (fcmd)
> +               io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb=
);
> +}
> +
> +static void ublk_batch_queue_rqs(struct rq_list *rqlist)
> +{
> +       struct rq_list requeue_list =3D { };
> +       struct rq_list submit_list =3D { };
> +       struct ublk_queue *ubq =3D NULL;
> +       struct request *req;
> +
> +       while ((req =3D rq_list_pop(rqlist))) {
> +               struct ublk_queue *this_q =3D req->mq_hctx->driver_data;
> +
> +               if (ublk_prep_req(this_q, req, true) !=3D BLK_STS_OK) {
> +                       rq_list_add_tail(&requeue_list, req);
> +                       continue;
> +               }
> +
> +               if (ubq && this_q !=3D ubq && !rq_list_empty(&submit_list=
))
> +                       ublk_batch_queue_cmd_list(ubq, &submit_list);
> +               ubq =3D this_q;
> +               rq_list_add_tail(&submit_list, req);
> +       }
> +
> +       if (!rq_list_empty(&submit_list))
> +               ublk_batch_queue_cmd_list(ubq, &submit_list);
> +       *rqlist =3D requeue_list;
> +}
> +
>  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
>                 unsigned int hctx_idx)
>  {
> @@ -1745,6 +1971,14 @@ static const struct blk_mq_ops ublk_mq_ops =3D {
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
> @@ -2122,6 +2356,56 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq=
, unsigned tag,
>                 io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags=
);
>  }
>
> +static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
> +                                 struct ublk_batch_fetch_cmd *fcmd,
> +                                 unsigned int issue_flags)
> +{
> +       bool done;
> +
> +       spin_lock(&ubq->evts_lock);
> +       done =3D (READ_ONCE(ubq->active_fcmd) !=3D fcmd);
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
> +       struct ublk_batch_fetch_cmd *fcmd;
> +       LIST_HEAD(fcmd_list);
> +
> +       spin_lock(&ubq->evts_lock);
> +       ubq->force_abort =3D true;
> +       list_splice_init(&ubq->fcmd_head, &fcmd_list);
> +       fcmd =3D READ_ONCE(ubq->active_fcmd);
> +       if (fcmd)
> +               list_move(&fcmd->node, &ubq->fcmd_head);
> +       spin_unlock(&ubq->evts_lock);
> +
> +       while (!list_empty(&fcmd_list)) {
> +               fcmd =3D list_first_entry(&fcmd_list,
> +                               struct ublk_batch_fetch_cmd, node);
> +               ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED);

This could skip the spin-locked section in ublk_batch_cancel_cmd()
since the fcmd has already been removed from ubq->fcmd_head. It just
needs to call io_uring_cmd_done() and ublk_batch_free_fcmd(). That
could be split into a separate helper if you want.

> +       }
> +}
> +
> +static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
> +                                unsigned int issue_flags)
> +{
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(cmd);
> +       struct ublk_batch_fetch_cmd *fcmd =3D pdu->fcmd;
> +       struct ublk_queue *ubq =3D pdu->ubq;
> +
> +       ublk_start_cancel(ubq->dev);
> +
> +       ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
> +}
> +
>  /*
>   * The ublk char device won't be closed when calling cancel fn, so both
>   * ublk device and queue are guaranteed to be live
> @@ -2173,6 +2457,11 @@ static void ublk_cancel_queue(struct ublk_queue *u=
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
> @@ -3079,6 +3368,78 @@ static int ublk_check_batch_cmd(const struct ublk_=
batch_io_data *data)
>         return ublk_check_batch_cmd_flags(uc);
>  }
>
> +static int ublk_batch_attach(struct ublk_queue *ubq,
> +                            struct ublk_batch_io_data *data,
> +                            struct ublk_batch_fetch_cmd *fcmd)
> +{
> +       struct ublk_batch_fetch_cmd *new_fcmd =3D NULL;
> +       bool free =3D false;
> +       struct ublk_uring_cmd_pdu *pdu =3D ublk_get_uring_cmd_pdu(data->c=
md);
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
> +       if (unlikely(free)) {
> +               ublk_batch_free_fcmd(fcmd);
> +               return -ENODEV;
> +       }
> +
> +       pdu->ubq =3D ubq;
> +       pdu->fcmd =3D fcmd;
> +       io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
> +
> +       if (!new_fcmd)
> +               goto out;
> +
> +       /*
> +        * If the two fetch commands are originated from same io_ring_ctx=
,
> +        * run batch dispatch directly. Otherwise, schedule task work for
> +        * doing it.
> +        */
> +       if (io_uring_cmd_ctx_handle(new_fcmd->cmd) =3D=3D
> +                       io_uring_cmd_ctx_handle(fcmd->cmd)) {
> +               data->cmd =3D new_fcmd->cmd;
> +               ublk_batch_dispatch(ubq, data, new_fcmd);
> +       } else {
> +               io_uring_cmd_complete_in_task(new_fcmd->cmd,
> +                               ublk_batch_tw_cb);
> +       }
> +out:
> +       return -EIOCBQUEUED;
> +}
> +
> +static int ublk_handle_batch_fetch_cmd(struct ublk_batch_io_data *data)
> +{
> +       struct ublk_queue *ubq =3D ublk_get_queue(data->ub, data->header.=
q_id);
> +       struct ublk_batch_fetch_cmd *fcmd =3D ublk_batch_alloc_fcmd(data-=
>cmd);
> +
> +       if (!fcmd)
> +               return -ENOMEM;
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

elem_bytes isn't used for UBLK_U_IO_FETCH_IO_CMDS, does it really make
sense to validate it?

> +
> +       if (uc->flags !=3D 0)
> +               return -E2BIG;

Why not EINVAL?

But other than these small things,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +
> +       return 0;
> +}
> +
>  static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
>                                        unsigned int issue_flags)
>  {
> @@ -3098,6 +3459,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
ing_cmd *cmd,
>         u32 cmd_op =3D cmd->cmd_op;
>         int ret =3D -EINVAL;
>
> +       if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
> +               ublk_batch_cancel_fn(cmd, issue_flags);
> +               return 0;
> +       }
> +
>         if (data.header.q_id >=3D ub->dev_info.nr_hw_queues)
>                 goto out;
>
> @@ -3114,6 +3480,12 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
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
> @@ -3323,6 +3695,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>                 ret =3D ublk_io_evts_init(ubq, ubq->q_depth, numa_node);
>                 if (ret)
>                         goto fail;
> +               INIT_LIST_HEAD(&ubq->fcmd_head);
>         }
>         ub->queues[q_id] =3D ubq;
>         ubq->dev =3D ub;
> @@ -3445,7 +3818,10 @@ static void ublk_align_max_io_size(struct ublk_dev=
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

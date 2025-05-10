Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13C215F48
	for <linux-block@vger.kernel.org>; Sat, 10 May 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746921297; cv=none; b=QpOAAYH+tP/nVQe1S2N5p7HlnsLHnHAZaxx2/qYq+pffv8UCT8vIpT/1wAEBQMwYYDLcK2cYt9y6/9EZG/Hm0hBfkh1kYO7aZRtAonALTw7hKAXZq7fASJGFwlBMUCQ5VzbaLqwlK0Z+BtO9EcVle6hQuyPK3UasvZAlKv33lAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746921297; c=relaxed/simple;
	bh=/K4c5srAXrC9cven71kF61vZPe4gp7Kk+WOLXMdPmJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7JmMDNwtD+tjAR5QCI1+5yNbp7RqZ9SDWfOVIFtUyzNrQkPLRa0hihW+ZhR8T2ej6Z+hq6Lwf1HJgAvtVShUhnuNhQ+kyxAej3DGVmhzU0D4vwPQPtLuB/2aAlaQrJSxCEoaI+XKQjCaM7qv0XQULhLtRJwQPm71ost//uM5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dwGWMq2O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dwGWMq2O"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7423ee0e42dso378336b3a.2
        for <linux-block@vger.kernel.org>; Sat, 10 May 2025 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746921293; x=1747526093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgdO+RnO0QbgYy1R8qZSv8GpyxXDHdg5hRpYml/yHSs=;
        b=dwGWMq2OJ21iZ3wCeDVnHOKQtLBDjK/v4TbUuJEeLdrxClbPSozKRIN/kB4AwyEGEL
         MyUAtevT0CDz835YmYRO2Fg1VHkTie+JDISrHUQosG1+x8bQnsakGrWlkEv6AJe103LB
         0yTOP7RooiKCLIrjauF1B9hUqphvNbJ3sAQ5g5jQAo1N1sd4vnhElLviIJDZH7k8mx6H
         JEMkAReg9WHj8BQzFE40Tqglt+O4hpl5qrmFYNVQE2GApwP9kSF9bxDjtPa+0hVgdfFZ
         b1+TDjLCaHiJ9lVwhktoBfJT21uQugXeFyycu++KtIhkBa7SuMsdWfH4lMUJqcgWQtXs
         DlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746921293; x=1747526093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgdO+RnO0QbgYy1R8qZSv8GpyxXDHdg5hRpYml/yHSs=;
        b=GYIMGoprCcAgV66LDB4xXM2C97u0msGsvPi50fb5erhWxfz9zhgOjADoLnTV4L+y1a
         vXqtoMtTs7qiBhUVU5FD2Fd0A4ADACokI7LsQ+HiKl3j1AlG2kGQCXf2AOWO86r+eOot
         +pHyFi3PdeNPZNYIDBVgfkuCEFss6oeq74V54iICi/2WcXv41evlnGgGEDd9SbAqa/62
         ETj5qISVNbcKxMSLzKqLTC7cPsp883dKUjl0EC467H4REn0qBNhZSnn1aKkUuaUwpfuW
         ADkm2YxDFG70p7c/WaxY7ZewXZYTTQC4iHTYBu9jJM6jMcbq46vgklLtoKh7HGsvIyd7
         2g3g==
X-Forwarded-Encrypted: i=1; AJvYcCWyND9oUlA2qe7fGvlAhilDHzdgiv822j+MUjqQZlsb0T6xmR0TPYA5vVgrCw1jJUY9buotAfmuCB19EA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDQaU4cbERBfPYNld6I47ErFFp2FFYVHBd4mE4xf1K+d+EUxX
	4GaFDIalJJwU0Ek5nkLLzCfqYmfYsOUVC4Jma5AQiczQ0hUn/mUr3Vp1wfLZVpYKtVTLzyGFbNh
	CEaHfbDYJjTcPmSQ2BbnC4bHQcFn6qUwFOcNcHw==
X-Gm-Gg: ASbGncvT6CHwqbQQIOPSKpWKthFPlCNWUez+DzVGLLJA+ZI4n6rAByPNREXax43fT1P
	QG48+h9JDsuS5BJSWqBgQv+oaipH6HY1TL7YdpuyPUD2ZAddoko+24//TAP0cv3kgE6H+TLfkzQ
	WeVNnURRNX7Cxm2+qQpF28CWfP+onduMw=
X-Google-Smtp-Source: AGHT+IF8fmRGCL2aQDg3l1qGynEUMNgcmSEa4G6CgJPJJQ2MtMa1l0SE37yCMgtYWV7fhJhT5UameEGy6Z2v3i72ET0=
X-Received: by 2002:a17:902:ebcc:b0:224:1785:8044 with SMTP id
 d9443c01a7336-22fc8b378d5mr45075335ad.4.1746921293370; Sat, 10 May 2025
 16:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-1-a2a298783c01@purestorage.com> <aB12n00oLKp2Db6p@fedora>
In-Reply-To: <aB12n00oLKp2Db6p@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 10 May 2025 16:54:42 -0700
X-Gm-Features: AX0GCFsWSuP9jtidt1Pj5kLu24rpBNP-31Ph1iARFPUIva8AcfxfEPkMeEzIj1o
Message-ID: <CADUfDZpvi4PSHMb-W+hq63AV+cWSaKmHqz52SZ5LOy2nzJdafQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] ublk: have a per-io daemon instead of a per-queue daemon
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 8:29=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Wed, May 07, 2025 at 03:49:35PM -0600, Uday Shankar wrote:
> > Currently, ublk_drv associates to each hardware queue (hctx) a unique
> > task (called the queue's ubq_daemon) which is allowed to issue
> > COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> > to do so, the command fails immediately with EINVAL. When considered
> > together with the block layer architecture, the result is that for each
> > CPU C on the system, there is a unique ublk server thread which is
> > allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> > performance under imbalanced load generation. For an extreme example,
> > suppose all the load is generated on CPUs mapping to a single ublk
> > server thread. Then that thread may be fully utilized and become the
> > bottleneck in the system, while other ublk server threads are totally
> > idle.
> >
> > This issue can also be addressed directly in the ublk server without
> > kernel support by having threads dequeue I/Os and pass them around to
> > ensure even load. But this solution requires inter-thread communication
> > at least twice for each I/O (submission and completion), which is
> > generally a bad pattern for performance. The problem gets even worse
> > with zero copy, as more inter-thread communication would be required to
> > have the buffer register/unregister calls to come from the correct
> > thread.
> >
> > Therefore, address this issue in ublk_drv by allowing each I/O to have
> > its own daemon task. Two I/Os in the same queue are now allowed to be
> > serviced by different daemon tasks - this was not possible before.
> > Imbalanced load can then be balanced across all ublk server threads as
> > follows:
> >
> > - specifying the new UBLK_F_RR_TAGS flag when creating the ublk device,
> >   to ensure round-robin tag allocation
> > - having the ublk server threads issue FETCH_REQs in a round-robin
> >   manner. As a small toy example, consider a system with a single ublk
> >   device having 2 queues, each of depth 4. A ublk server having 4
> >   threads could issue its FETCH_REQs against this device as follows
> >   (where each entry is the qid,tag pair that the FETCH_REQ targets):
> >
> >   ublk server thread: T0      T1      T2      T3
> >                       0,0     0,1     0,2     0,3
> >                       1,3     1,0     1,1     1,2
> >
> > The combination of these two changes allow a ublk server to balance
> > load. For example, suppose a program quickly issues 4 I/Os concurrently=
.
> > Before this change, all 4 I/Os would have had to be serviced by the sam=
e
> > thread, and that thread may become a bottleneck. With this change, thos=
e
> > 4 I/Os would get tags 0-3 for the same queue, and would thus spread out
> > evenly over all the ublk server threads. Peak bandwidth in CPU-limited
> > workloads under imbalanced load thus will increase.
> >
> > The UBLK_F_RR_TAGS flag is also added as a feature, so that ublk server=
s
> > can essentially test for the presence of this patch and tailor their
> > behavior accordingly.
> >
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 82 ++++++++++++++++++++++-------------=
--------
> >  include/uapi/linux/ublk_cmd.h |  8 +++++
> >  2 files changed, 50 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index cb612151e9a1de7630c49a2b78d278e005d52856..ff5beab32220ea96a1e15ab=
26c02f4883a6c3d6e 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -66,7 +66,8 @@
> >               | UBLK_F_USER_COPY \
> >               | UBLK_F_ZONED \
> >               | UBLK_F_USER_RECOVERY_FAIL_IO \
> > -             | UBLK_F_UPDATE_SIZE)
> > +             | UBLK_F_UPDATE_SIZE \
> > +             | UBLK_F_RR_TAGS)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >               | UBLK_F_USER_RECOVERY_REISSUE \
> > @@ -148,6 +149,8 @@ struct ublk_io {
> >               /* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
> >               struct request *req;
> >       };
> > +
> > +     struct task_struct *task;
> >  };
> >
> >  struct ublk_queue {
> > @@ -155,11 +158,9 @@ struct ublk_queue {
> >       int q_depth;
> >
> >       unsigned long flags;
> > -     struct task_struct      *ubq_daemon;
> >       struct ublksrv_io_desc *io_cmd_buf;
> >
> >       bool force_abort;
> > -     bool timeout;
> >       bool canceling;
> >       bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
> >       unsigned short nr_io_ready;     /* how many ios setup */
> > @@ -1069,11 +1070,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_ge=
t_uring_cmd_pdu(
> >       return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
> >  }
> >
> > -static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> > -{
> > -     return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
> > -}
> > -
> >  /* todo: handle partial completion */
> >  static inline void __ublk_complete_rq(struct request *req)
> >  {
> > @@ -1207,13 +1203,13 @@ static void ublk_dispatch_req(struct ublk_queue=
 *ubq,
> >       /*
> >        * Task is exiting if either:
> >        *
> > -      * (1) current !=3D ubq_daemon.
> > +      * (1) current !=3D io->task.
> >        * io_uring_cmd_complete_in_task() tries to run task_work
> > -      * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> > +      * in a workqueue if cmd's task is PF_EXITING.
> >        *
> >        * (2) current->flags & PF_EXITING.
> >        */
> > -     if (unlikely(current !=3D ubq->ubq_daemon || current->flags & PF_=
EXITING)) {
> > +     if (unlikely(current !=3D io->task || current->flags & PF_EXITING=
)) {
> >               __ublk_abort_rq(ubq, req);
> >               return;
> >       }
> > @@ -1286,13 +1282,10 @@ static void ublk_queue_cmd_list(struct ublk_que=
ue *ubq, struct rq_list *l)
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >       struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> > +     struct ublk_io *io =3D &ubq->ios[rq->tag];
> >
> >       if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > -             if (!ubq->timeout) {
> > -                     send_sig(SIGKILL, ubq->ubq_daemon, 0);
> > -                     ubq->timeout =3D true;
> > -             }
> > -
> > +             send_sig(SIGKILL, io->task, 0);
> >               return BLK_EH_DONE;
> >       }
> >
> > @@ -1405,17 +1398,6 @@ static void ublk_queue_reinit(struct ublk_device=
 *ub, struct ublk_queue *ubq)
> >       /* All old ioucmds have to be completed */
> >       ubq->nr_io_ready =3D 0;
> >
> > -     /*
> > -      * old daemon is PF_EXITING, put it now
> > -      *
> > -      * It could be NULL in case of closing one quisced device.
> > -      */
> > -     if (ubq->ubq_daemon)
> > -             put_task_struct(ubq->ubq_daemon);
> > -     /* We have to reset it to NULL, otherwise ub won't accept new FET=
CH_REQ */
> > -     ubq->ubq_daemon =3D NULL;
> > -     ubq->timeout =3D false;
> > -
> >       for (i =3D 0; i < ubq->q_depth; i++) {
> >               struct ublk_io *io =3D &ubq->ios[i];
> >
> > @@ -1426,6 +1408,17 @@ static void ublk_queue_reinit(struct ublk_device=
 *ub, struct ublk_queue *ubq)
> >               io->flags &=3D UBLK_IO_FLAG_CANCELED;
> >               io->cmd =3D NULL;
> >               io->addr =3D 0;
> > +
> > +             /*
> > +              * old task is PF_EXITING, put it now
> > +              *
> > +              * It could be NULL in case of closing one quiesced
> > +              * device.
> > +              */
> > +             if (io->task) {
> > +                     put_task_struct(io->task);
> > +                     io->task =3D NULL;
> > +             }
> >       }
> >  }
> >
> > @@ -1447,7 +1440,7 @@ static void ublk_reset_ch_dev(struct ublk_device =
*ub)
> >       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++)
> >               ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> >
> > -     /* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_b=
uf */
> > +     /* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
> >       ub->mm =3D NULL;
> >       ub->nr_queues_ready =3D 0;
> >       ub->nr_privileged_daemon =3D 0;
> > @@ -1722,7 +1715,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_ur=
ing_cmd *cmd,
> >               return;
> >
> >       task =3D io_uring_cmd_get_task(cmd);
> > -     if (WARN_ON_ONCE(task && task !=3D ubq->ubq_daemon))
> > +     if (WARN_ON_ONCE(task && task !=3D ubq->ios[pdu->tag].task))
> >               return;
> >
> >       if (!ubq->canceling)
> > @@ -1861,8 +1854,6 @@ static void ublk_mark_io_ready(struct ublk_device=
 *ub, struct ublk_queue *ubq)
> >  {
> >       ubq->nr_io_ready++;
> >       if (ublk_queue_ready(ubq)) {
> > -             ubq->ubq_daemon =3D current;
> > -             get_task_struct(ubq->ubq_daemon);
> >               ub->nr_queues_ready++;
> >
> >               if (capable(CAP_SYS_ADMIN))
> > @@ -1995,6 +1986,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, s=
truct ublk_queue *ubq,
> >       }
> >
> >       ublk_fill_io_cmd(io, cmd, buf_addr);
> > +     WRITE_ONCE(io->task, get_task_struct(current));
> >       ublk_mark_io_ready(ub, ubq);
> >  out:
> >       mutex_unlock(&ub->mutex);
> > @@ -2062,6 +2054,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
> >                              const struct ublksrv_io_cmd *ub_cmd)
> >  {
> >       struct ublk_device *ub =3D cmd->file->private_data;
> > +     struct task_struct *task;
> >       struct ublk_queue *ubq;
> >       struct ublk_io *io;
> >       u32 cmd_op =3D cmd->cmd_op;
> > @@ -2076,13 +2069,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> >               goto out;
> >
> >       ubq =3D ublk_get_queue(ub, ub_cmd->q_id);
> > -     if (ubq->ubq_daemon && ubq->ubq_daemon !=3D current)
> > -             goto out;
> >
> >       if (tag >=3D ubq->q_depth)
> >               goto out;
> >
> >       io =3D &ubq->ios[tag];
> > +     task =3D READ_ONCE(io->task);
> > +     if (task && task !=3D current)
> > +             goto out;
> >
> >       /* there is pending io cmd, something must be wrong */
> >       if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> > @@ -2332,9 +2326,15 @@ static void ublk_deinit_queue(struct ublk_device=
 *ub, int q_id)
> >  {
> >       int size =3D ublk_queue_cmd_buf_size(ub, q_id);
> >       struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> > +     struct ublk_io *io;
> > +     int i;
> > +
> > +     for (i =3D 0; i < ubq->q_depth; i++) {
> > +             io =3D &ubq->ios[i];
> > +             if (io->task)
> > +                     put_task_struct(io->task);
> > +     }
> >
> > -     if (ubq->ubq_daemon)
> > -             put_task_struct(ubq->ubq_daemon);
> >       if (ubq->io_cmd_buf)
> >               free_pages((unsigned long)ubq->io_cmd_buf, get_order(size=
));
> >  }
> > @@ -2487,6 +2487,8 @@ static int ublk_add_tag_set(struct ublk_device *u=
b)
> >       ub->tag_set.numa_node =3D NUMA_NO_NODE;
> >       ub->tag_set.cmd_size =3D sizeof(struct ublk_rq_data);
> >       ub->tag_set.driver_data =3D ub;
> > +     if (ub->dev_info.flags & UBLK_F_RR_TAGS)
> > +             ub->tag_set.flags |=3D BLK_MQ_F_TAG_RR;
> >       return blk_mq_alloc_tag_set(&ub->tag_set);
> >  }
> >
> > @@ -3062,14 +3064,14 @@ static int ublk_ctrl_end_recovery(struct ublk_d=
evice *ub,
> >       int ublksrv_pid =3D (int)header->data[0];
> >       int ret =3D -EINVAL;
> >
> > -     pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev =
id %d...\n",
> > -                     __func__, ub->dev_info.nr_hw_queues, header->dev_=
id);
> > -     /* wait until new ubq_daemon sending all FETCH_REQ */
> > +     pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func=
__,
> > +              header->dev_id);
> > +
> >       if (wait_for_completion_interruptible(&ub->completion))
> >               return -EINTR;
> >
> > -     pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n"=
,
> > -                     __func__, ub->dev_info.nr_hw_queues, header->dev_=
id);
> > +     pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
> > +              header->dev_id);
> >
> >       mutex_lock(&ub->mutex);
> >       if (ublk_nosrv_should_stop_dev(ub))
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cm=
d.h
> > index be5c6c6b16e098838a2bf790e588b79656defdda..3ba8f26d60bc70ade95b4f4=
d5990157af2bd5b2e 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -219,6 +219,14 @@
> >   */
> >  #define UBLK_F_UPDATE_SIZE            (1ULL << 10)
> >
> > +/*
> > + * Force tags to be allocated round-robin on each queue. If ublk serve=
r
> > + * threads also issue FETCH_REQs against the queues in a round-robin
> > + * manner, load can be balanced across all threads even if it is issue=
d
> > + * to the queues in an imbalanced way.
> > + */
> > +#define UBLK_F_RR_TAGS (1ULL << 11)
>
> Please make UBLK_F_RR_TAGS as one standalone patch, which is also helpful
> for evaluating round-robin performance, and doesn't have to be used by
> per-io task.

I don't think UBLK_F_RR_TAGS has to be set in order to use per-io
tasks. But I agree it's a bit odd to check for per-io task support via
the UBLK_F_RR_TAGS feature flag. Using a separate feature flag to
report per-io task support would seem clearer to me.

Best,
Caleb

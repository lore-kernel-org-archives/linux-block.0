Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A8217F2E
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831573; cv=none; b=Pw2s6TAHOihNtg25PA7cepCMkSNAFDV1oD3ZmeiZc0NCulsU7hPGCJ5InN4zCI3e5LxaXBw6ZSbNZPF+uJ/fFOsXakhdty0Pcy9dk9aMGXU8QtpVtKH1Q2ZqmI3npfQdXRJV9eiJHNhP31Lx/7zOzZgZPY8TZmL/Sbo7QE0ibaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831573; c=relaxed/simple;
	bh=ZlW7/Hwz68Ay2/tTvNYYRRkRnPt3zgMs2f2vYm7Uy4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoN1HvnMUDxeni7ZG+Vran9BMTLJfTVLljVPadKDOVqEHVgXqteOdOfqPVxgYnwoiWlXwixEYqNow4CDw55j08w3fypmd4qmbpWkdW6MzbF2oq/PywHrCdVJhIMZZSFEqySkGt1qwmSF8qWtFMzy8s2IZNt+0w0O0MZAIcVYFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eKGBpmpl; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eKGBpmpl"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-8616987c261so210633039f.3
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744831569; x=1745436369; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J2DtzzV6zkuODmWsPD3oKHQFrqSelzUOvjsGWTH2l7w=;
        b=eKGBpmplkfxl7PumIop/Zn38sMpHm2cBaJx2e2g7KRrOD2apCzNulyd5JvtZdGid16
         gamM3L2sEVgt5u6HZ7RdP2i5Bw7q75Ti6C3aQhOIYDOwTq8gVi/gxeMbohTBAipQvTTB
         l97VfF7Dno8+W9kPjEfjHTSBlgYB80LxmsIMbn+1mRiE4M8Id+Q1P0HB6to1Hrm52bIt
         y8cg90F2CL7J0TN/aEikWC3GCwGUTOF84tB4dHOdHP6uDcMetY6xRK0ak+f+3h1DELHc
         Sb39LvliETRw+X82x1GSbUH6/jBewN9T75A8ZLH+Sf5/UxRkcu0Aw2oG8TMoazdmXOg/
         9mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744831569; x=1745436369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2DtzzV6zkuODmWsPD3oKHQFrqSelzUOvjsGWTH2l7w=;
        b=UCRpsugcuwjSOv7nzVCpgPAwnk3+QDgew/RU1wj0HlgN9jnO9YrF+XsSj03ZGCdEWr
         Lk4NNctjIjDKsqr2dJ827u51wzsAn5psK0+2WhpqNdi0jX99CK2Hre34Ura0h2kynVR0
         hWmRUTYSBpsBWQ12nhbL8qKWcgQQ3kIx20wCh/iZtAw3RERXMZ3VsLa7r7bKl4jLvsNH
         fIpIC0UcrEl2NcfMTiUkFaa5k855u8iyEDlZae+frecGgZc7p/ULxRXkXdGRqKe+bd45
         /fAOpdc8vKq4NXn23eW/TQDjPO2nh8hO0YSj9QwPvTqLgNB+Oh4Jkgk9zgpJgPw+Zsfo
         3RyA==
X-Forwarded-Encrypted: i=1; AJvYcCVWLSZbBHv7eeAYrJdOzbQiAFj4A6ZK6Du/wCbmNkMLENqDrb+6uPux7ywstlX2aDzKRxjhjWC/Fov3ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDuHYPXQpofpDUBEZdeUwMIfyp7Jv2NehsA1Fi6D0yUT65Lhy1
	UW8PBCCOSx3AsKXO2pRJGfjHpRuHLdEFK3wQ9cCdCXdp1wnID3fjtUpzMKiN5b6qZojF6VDdrXU
	tNNFg8vAJoXt+31cPL4WGPQ5FPHbcnEBQc6js6ntv3GBD5NEP
X-Gm-Gg: ASbGncsDeCAszRBxYV0lPgDng6ySfMzNJzZ40EvfmxWyhtOizvmnwJyJNaZ2YiIpNIb
	pf6wPWtpTdl9zg+7OQVYIvNnYumfo9NHvfvca9D2LyNQqEW/8l97hsZ04wYBhfTw8AaxEeOC8Vy
	zz7moLLYYCf61LEbch1NLeF+4CtvwoVVTpvxBJ6daukMpCI4ldS7zrNf/Bi9T/5qlk4lZAlU2rG
	kHtzT1W1igpBlQDrTyYkiP9hDxk7S/XNtyH8D4oiObpxsxxZg3ubFB6luYVbKnaDOBpQJbg25CF
	QBJhynfNBCQK/Cxyt+IuftYpb4kj5Ig=
X-Google-Smtp-Source: AGHT+IGfetfEEsJY4iygOtTOVLBZexx/Kqod0n6T/FPxJF+hm71yYSPzZYncW7uyzPY4ZiRBBoJnDpNwgNEk
X-Received: by 2002:a05:6602:3e90:b0:85b:601d:dfb3 with SMTP id ca18e2360f4ac-861c5092c8bmr370434739f.5.1744831568783;
        Wed, 16 Apr 2025 12:26:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-8616543bbbdsm57149739f.16.2025.04.16.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:26:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DB35E34035E;
	Wed, 16 Apr 2025 13:26:07 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D212EE40318; Wed, 16 Apr 2025 13:26:07 -0600 (MDT)
Date: Wed, 16 Apr 2025 13:26:07 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ublk: require unique task per io instead of
 unique task per hctx
Message-ID: <aAAET5OyD76Qdx7B@dev-ushankar.dev.purestorage.com>
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
 <20250415-ublk_task_per_io-v4-1-54210b91a46f@purestorage.com>
 <CADUfDZq+0H6nZ1vtw-URN_FbbU-Vkp8sXK_HKZpoXegAsT9_Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq+0H6nZ1vtw-URN_FbbU-Vkp8sXK_HKZpoXegAsT9_Pg@mail.gmail.com>

On Wed, Apr 16, 2025 at 11:48:45AM -0700, Caleb Sander Mateos wrote:
> On Tue, Apr 15, 2025 at 6:00 PM Uday Shankar <ushankar@purestorage.com> wrote:
> >
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
> > Therefore, address this issue in ublk_drv by requiring a unique task per
> > I/O instead of per queue/hctx. Imbalanced load can then be balanced
> > across all ublk server threads by having threads issue FETCH_REQs in a
> > round-robin manner. As a small toy example, consider a system with a
> > single ublk device having 2 queues, each of queue depth 4. A ublk server
> > having 4 threads could issue its FETCH_REQs against this device as
> > follows (where each entry is the qid,tag pair that the FETCH_REQ
> > targets):
> >
> > poller thread:  T0      T1      T2      T3
> >                 0,0     0,1     0,2     0,3
> >                 1,3     1,0     1,1     1,2
> >
> > Since tags appear to be allocated in sequential chunks, this setup
> > provides a rough approximation to distributing I/Os round-robin across
> > all ublk server threads, while letting I/Os stay fully thread-local.
> >
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 75 ++++++++++++++++++++++--------------------------
> >  1 file changed, 34 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index cdb1543fa4a9817aa2ca2fca66720f589cf222be..9a0d2547512fc8119460739230599d48d2c2a306 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -150,6 +150,7 @@ struct ublk_io {
> >         int res;
> >
> >         struct io_uring_cmd *cmd;
> > +       struct task_struct *task;
> >  };
> >
> >  struct ublk_queue {
> > @@ -157,11 +158,9 @@ struct ublk_queue {
> >         int q_depth;
> >
> >         unsigned long flags;
> > -       struct task_struct      *ubq_daemon;
> >         struct ublksrv_io_desc *io_cmd_buf;
> >
> >         bool force_abort;
> > -       bool timeout;
> >         bool canceling;
> >         bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
> >         unsigned short nr_io_ready;     /* how many ios setup */
> > @@ -1072,11 +1071,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
> >         return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
> >  }
> >
> > -static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> > -{
> > -       return ubq->ubq_daemon->flags & PF_EXITING;
> > -}
> > -
> >  /* todo: handle partial completion */
> >  static inline void __ublk_complete_rq(struct request *req)
> >  {
> > @@ -1224,13 +1218,13 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
> >         /*
> >          * Task is exiting if either:
> >          *
> > -        * (1) current != ubq_daemon.
> > +        * (1) current != io->task.
> >          * io_uring_cmd_complete_in_task() tries to run task_work
> > -        * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> > +        * in a workqueue if cmd's task is PF_EXITING.
> >          *
> >          * (2) current->flags & PF_EXITING.
> >          */
> > -       if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> > +       if (unlikely(current != io->task || current->flags & PF_EXITING)) {
> >                 __ublk_abort_rq(ubq, req);
> >                 return;
> >         }
> > @@ -1336,23 +1330,20 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >         struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > +       struct ublk_io *io = &ubq->ios[rq->tag];
> >         unsigned int nr_inflight = 0;
> >         int i;
> >
> >         if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > -               if (!ubq->timeout) {
> > -                       send_sig(SIGKILL, ubq->ubq_daemon, 0);
> > -                       ubq->timeout = true;
> > -               }
> > -
> > +               send_sig(SIGKILL, io->task, 0);
> >                 return BLK_EH_DONE;
> >         }
> >
> > -       if (!ubq_daemon_is_dying(ubq))
> > +       if (!(io->task->flags & PF_EXITING))
> >                 return BLK_EH_RESET_TIMER;
> >
> >         for (i = 0; i < ubq->q_depth; i++) {
> > -               struct ublk_io *io = &ubq->ios[i];
> > +               io = &ubq->ios[i];
> >
> >                 if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> >                         nr_inflight++;
> > @@ -1552,8 +1543,8 @@ static void ublk_commit_completion(struct ublk_device *ub,
> >  }
> >
> >  /*
> > - * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
> > - * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
> > + * Called from io task context via cancel fn, meantime quiesce ublk
> > + * blk-mq queue, so we are called exclusively with blk-mq and io task
> >   * context, so everything is serialized.
> >   */
> >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
> > @@ -1669,13 +1660,13 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
> >                 return;
> >
> >         task = io_uring_cmd_get_task(cmd);
> > -       if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
> > +       io = &ubq->ios[pdu->tag];
> > +       if (WARN_ON_ONCE(task && task != io->task))
> >                 return;
> >
> >         ub = ubq->dev;
> >         need_schedule = ublk_abort_requests(ub, ubq);
> >
> > -       io = &ubq->ios[pdu->tag];
> >         WARN_ON_ONCE(io->cmd != cmd);
> >         ublk_cancel_cmd(ubq, io, issue_flags);
> >
> > @@ -1836,8 +1827,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> >         mutex_lock(&ub->mutex);
> >         ubq->nr_io_ready++;
> >         if (ublk_queue_ready(ubq)) {
> > -               ubq->ubq_daemon = current;
> > -               get_task_struct(ubq->ubq_daemon);
> >                 ub->nr_queues_ready++;
> >
> >                 if (capable(CAP_SYS_ADMIN))
> > @@ -1952,14 +1941,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> >         if (!ubq || ub_cmd->q_id != ubq->q_id)
> >                 goto out;
> >
> > -       if (ubq->ubq_daemon && ubq->ubq_daemon != current)
> > -               goto out;
> > -
> >         if (tag >= ubq->q_depth)
> >                 goto out;
> >
> >         io = &ubq->ios[tag];
> >
> > +       if (io->task && io->task != current)
> > +               goto out;
> > +
> >         /* there is pending io cmd, something must be wrong */
> >         if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> >                 ret = -EBUSY;
> > @@ -2012,6 +2001,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
> >
> >                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> >                 ublk_mark_io_ready(ub, ubq);
> > +               io->task = get_task_struct(current);
> 
> Should io->task be set before ublk_mark_io_ready()? I worry that once
> the ublk device is marked ready, it may be assumed that io->task is
> constant.

Not sure if we're dependent on that assumption anywhere, but it does
make sense. I'll move it.

I also think we might need to set atomically here, and read atomically
at the top of __ublk_ch_uring_cmd, as I can't see anything preventing
those accesses from being concurrent.


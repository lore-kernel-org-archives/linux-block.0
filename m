Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651E21A42F
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829340; cv=none; b=csaMKcFUiZKYQCHAg+9k8EH/sRsz0ld8L6IAXZRz0jVwk7Fv/eZdm4UXQsPAYeYApNFGCSicO8g3z5C7kzCoR3V0nnKOhklJK1fb+Rs8Q2/fWoAOs7Ro41GXh9XylCXt6sdvKhhItlSN1gDpGeeCMdwSz1FVpKDiGckGjuqkq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829340; c=relaxed/simple;
	bh=swZ2/+U9s97+QP7k4GYijUDwadBOlimnF3l63On3VPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tI1hL+ClaBEK4XbcW6Wq6YG2xBSC8om8sAVQZmgMw/PG0XAJiAKkdpiRXCxKgZ4Xr4vb4v+DN+R/X3Qmk7ZlStmwc9pwKcAoouXCbw9lzuXSfvA2q1peFlZph9XNk+HlRcOZwJjeTJ9/DMBkRPQMHoLQ5d6qlIK0LsqoaDNBTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M+LWkuz/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M+LWkuz/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240d930f13so7835ad.3
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744829337; x=1745434137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UglhmPML1X99OFbBAeAYEJX5nIbzR7pKq76VJUpaLYU=;
        b=M+LWkuz/ff82qvT30OrVprEtSIOeyeU7dssLueTGi4pKU/j0jbumZVgi3AR0uRjKzg
         AnDc4j0pfwrjn+z1ugw9BSQrWOj4vyyz3bKDbcDt2Gw2Fh6UGKeyg1f77RhRkhH95Vsd
         m/s/qEzpBrumpimMSu5KcxyNexjucd+UafLpYI4Q9tuFSoEO6HjzX3d1NDDYHKdlP/+c
         iOGdtPC5ihMdkVBZykuwpFXyHiQS4TcjYh3uMLk2VjLP2frDpsxGZ19BaFHZnN8GMXjB
         TAQlmk4RjdmUye8APySAREHjUupcL+ccsUCYfMT65unV4Aq7b2yMI0b4cGm5aNbgF535
         +UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829337; x=1745434137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UglhmPML1X99OFbBAeAYEJX5nIbzR7pKq76VJUpaLYU=;
        b=WKZUbJiCE34kk7W3rnkLTR5mteeYfiGB9TTz8nQvwAWkVfUADNbZ38/V8bg6m3IT/e
         GszJ8eGUQU/KWhJYALbiAomwxu9wyj+w/4bAAmFHMiWp6QuYDbdEIiR5nzq1hwnl8n+r
         QaetdVpPZvWlzBYQ79N0Snz1JhoEBU+FkdMKhxKZTwNUx6rBfGz67IRZDM2FAEhLvW5K
         q1k1g7pFegoJVF5eMkb3hAb55GpOXtjtgWyAmxx/jl6AK5oxCnqKf3T5gCSCNvxMLjs/
         ljOsp163SpEx+STNDh+Oq2UNXIGTYID+FhO3LEJ06Qol80VNojzCswFC6TdvJxAmwHmN
         F1bw==
X-Forwarded-Encrypted: i=1; AJvYcCX+WYJjCnpKg3/ir5MD3g4r9xEYKGedo1hK+UE0QpILB77UgrXMOsAaMgZJzL/086og1jD/yvUuLX/ARQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymhp91v5cVM6UpCi4F7OmNcerD6V5PBfRyDa6dUb29Ja9Kv2/e
	/g85y8uuMgEG7bOV/EZFAV6zy+VhgKyg/8D8YJJOpK+vrCg357UAq3tREmBVFMLG0+w/2B0QGAa
	BSuYriAgASUPWDqZgyXtFsZOYpLMwI3X+UiLBTQ==
X-Gm-Gg: ASbGncu/HIOtP0luWzTDJvZGxBF+3D3GxBAmJARIpCLkTQX3VXv/41FNZTAhr3QhfRh
	NTYYclkWAC/tilAa9r9eBL2oAExdBpllSWb4CNElJIJI0dSS+NgHsC2yTZPgIvEnJ4VGi7ggyFr
	TielKnYwE4VkEEKqpu8t3HSbcj
X-Google-Smtp-Source: AGHT+IGxe3EfJ00obVKPlNZy019oL4dMsaKdXUjT/UbWlhqE9/zKu3fGZ5tTg0LIAgYiUxiXMRxi20YI2qBtaRImnG4=
X-Received: by 2002:a17:903:11c8:b0:223:4b53:7349 with SMTP id
 d9443c01a7336-22c3fa8ce06mr5231335ad.11.1744829336961; Wed, 16 Apr 2025
 11:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com> <20250415-ublk_task_per_io-v4-1-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-1-54210b91a46f@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 16 Apr 2025 11:48:45 -0700
X-Gm-Features: ATxdqUGLO4dlyHgTPoOb7G44rAU55QwvbNVAc2KXEsyXZInUyW17T7x5LC5tC6o
Message-ID: <CADUfDZq+0H6nZ1vtw-URN_FbbU-Vkp8sXK_HKZpoXegAsT9_Pg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ublk: require unique task per io instead of unique
 task per hctx
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:00=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
>
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.
>
> Therefore, address this issue in ublk_drv by requiring a unique task per
> I/O instead of per queue/hctx. Imbalanced load can then be balanced
> across all ublk server threads by having threads issue FETCH_REQs in a
> round-robin manner. As a small toy example, consider a system with a
> single ublk device having 2 queues, each of queue depth 4. A ublk server
> having 4 threads could issue its FETCH_REQs against this device as
> follows (where each entry is the qid,tag pair that the FETCH_REQ
> targets):
>
> poller thread:  T0      T1      T2      T3
>                 0,0     0,1     0,2     0,3
>                 1,3     1,0     1,1     1,2
>
> Since tags appear to be allocated in sequential chunks, this setup
> provides a rough approximation to distributing I/Os round-robin across
> all ublk server threads, while letting I/Os stay fully thread-local.
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 75 ++++++++++++++++++++++--------------------=
------
>  1 file changed, 34 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9817aa2ca2fca66720f589cf222be..9a0d2547512fc811946073923=
0599d48d2c2a306 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -150,6 +150,7 @@ struct ublk_io {
>         int res;
>
>         struct io_uring_cmd *cmd;
> +       struct task_struct *task;
>  };
>
>  struct ublk_queue {
> @@ -157,11 +158,9 @@ struct ublk_queue {
>         int q_depth;
>
>         unsigned long flags;
> -       struct task_struct      *ubq_daemon;
>         struct ublksrv_io_desc *io_cmd_buf;
>
>         bool force_abort;
> -       bool timeout;
>         bool canceling;
>         bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
>         unsigned short nr_io_ready;     /* how many ios setup */
> @@ -1072,11 +1071,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_=
uring_cmd_pdu(
>         return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>  }
>
> -static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> -{
> -       return ubq->ubq_daemon->flags & PF_EXITING;
> -}
> -
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req)
>  {
> @@ -1224,13 +1218,13 @@ static void ublk_dispatch_req(struct ublk_queue *=
ubq,
>         /*
>          * Task is exiting if either:
>          *
> -        * (1) current !=3D ubq_daemon.
> +        * (1) current !=3D io->task.
>          * io_uring_cmd_complete_in_task() tries to run task_work
> -        * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> +        * in a workqueue if cmd's task is PF_EXITING.
>          *
>          * (2) current->flags & PF_EXITING.
>          */
> -       if (unlikely(current !=3D ubq->ubq_daemon || current->flags & PF_=
EXITING)) {
> +       if (unlikely(current !=3D io->task || current->flags & PF_EXITING=
)) {
>                 __ublk_abort_rq(ubq, req);
>                 return;
>         }
> @@ -1336,23 +1330,20 @@ static void ublk_queue_cmd_list(struct ublk_queue=
 *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>         struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
> +       struct ublk_io *io =3D &ubq->ios[rq->tag];
>         unsigned int nr_inflight =3D 0;
>         int i;
>
>         if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> -               if (!ubq->timeout) {
> -                       send_sig(SIGKILL, ubq->ubq_daemon, 0);
> -                       ubq->timeout =3D true;
> -               }
> -
> +               send_sig(SIGKILL, io->task, 0);
>                 return BLK_EH_DONE;
>         }
>
> -       if (!ubq_daemon_is_dying(ubq))
> +       if (!(io->task->flags & PF_EXITING))
>                 return BLK_EH_RESET_TIMER;
>
>         for (i =3D 0; i < ubq->q_depth; i++) {
> -               struct ublk_io *io =3D &ubq->ios[i];
> +               io =3D &ubq->ios[i];
>
>                 if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
>                         nr_inflight++;
> @@ -1552,8 +1543,8 @@ static void ublk_commit_completion(struct ublk_devi=
ce *ub,
>  }
>
>  /*
> - * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
> - * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
> + * Called from io task context via cancel fn, meantime quiesce ublk
> + * blk-mq queue, so we are called exclusively with blk-mq and io task
>   * context, so everything is serialized.
>   */
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *=
ubq)
> @@ -1669,13 +1660,13 @@ static void ublk_uring_cmd_cancel_fn(struct io_ur=
ing_cmd *cmd,
>                 return;
>
>         task =3D io_uring_cmd_get_task(cmd);
> -       if (WARN_ON_ONCE(task && task !=3D ubq->ubq_daemon))
> +       io =3D &ubq->ios[pdu->tag];
> +       if (WARN_ON_ONCE(task && task !=3D io->task))
>                 return;
>
>         ub =3D ubq->dev;
>         need_schedule =3D ublk_abort_requests(ub, ubq);
>
> -       io =3D &ubq->ios[pdu->tag];
>         WARN_ON_ONCE(io->cmd !=3D cmd);
>         ublk_cancel_cmd(ubq, io, issue_flags);
>
> @@ -1836,8 +1827,6 @@ static void ublk_mark_io_ready(struct ublk_device *=
ub, struct ublk_queue *ubq)
>         mutex_lock(&ub->mutex);
>         ubq->nr_io_ready++;
>         if (ublk_queue_ready(ubq)) {
> -               ubq->ubq_daemon =3D current;
> -               get_task_struct(ubq->ubq_daemon);
>                 ub->nr_queues_ready++;
>
>                 if (capable(CAP_SYS_ADMIN))
> @@ -1952,14 +1941,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>         if (!ubq || ub_cmd->q_id !=3D ubq->q_id)
>                 goto out;
>
> -       if (ubq->ubq_daemon && ubq->ubq_daemon !=3D current)
> -               goto out;
> -
>         if (tag >=3D ubq->q_depth)
>                 goto out;
>
>         io =3D &ubq->ios[tag];
>
> +       if (io->task && io->task !=3D current)
> +               goto out;
> +
>         /* there is pending io cmd, something must be wrong */
>         if (io->flags & UBLK_IO_FLAG_ACTIVE) {
>                 ret =3D -EBUSY;
> @@ -2012,6 +2001,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>
>                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>                 ublk_mark_io_ready(ub, ubq);
> +               io->task =3D get_task_struct(current);

Should io->task be set before ublk_mark_io_ready()? I worry that once
the ublk device is marked ready, it may be assumed that io->task is
constant.

Best,
Caleb

Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C314A04
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744168599; cv=none; b=EV6z23/xo9tu51OzPGc/U/fKsXjN7sxaScHxt8bPKRWRmci0OUsTM+iX/UQh2WiBAZoSmqzSY7M2Hb2N+prwtU0NrvewhHfcV9wrt1ztBb65GCuvpw3XXZWaalvN7rjmmI8gXdJ0qz4dhNymTVGawxezJstSz82d6o4aNnb0Lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744168599; c=relaxed/simple;
	bh=JOTS8BnSy3NY5eDMbOnbqzyaAWGgusKQJbBKqOWE8iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=einuJ3F/iY2G7Zhe6Qa/a6IHQZVhjhU5O6V2yGrQxVY0YRDqYmwoyqMttETGXaMFi+QpxIHh3H6A26GNLgLjbJkFIaqYTRmAabZQJE7KrM8uCJp6OpdhUL5yUdGrR4FJjEd4zfV61uGd9KdEj001CECt7LJ7NQpTOXkoLpbPo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X7p1VeV0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X7p1VeV0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51b57ea41so588821a12.2
        for <linux-block@vger.kernel.org>; Tue, 08 Apr 2025 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744168597; x=1744773397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7lanBtnebtdPdb1o6h6pgi9BSofCUk/apk3Q3n+gJw=;
        b=X7p1VeV0jGJjGYLxHRUSwWvCXQNP70XofPoXigdDjIQi3o4yh0Mjufs98mqElHi47F
         QIuCW+EX1FsYjWikhL3xIwU0SJy1cPxNOKWA3gd9CeBDKgYd3hnPG74db28kX6HBwB9r
         djDj2Wx4qTQ5w4r7VmD616yBVS0x+wghBuQpFXOlMtM+WwyKkMY4AHAheqiXJKF8GKBV
         lffxn/ghd/YYO2l3cplTizqtba1KcnZ2/EA9p620XrcokVvC4bb/KzBix8HvPJXhmCOY
         H8yWFk3zLdz1ARwfM5nwXnra/9RBElaFWujgaRfk4CUCaTsOulhU0RKHvu1MfvtNWUVN
         6vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744168597; x=1744773397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7lanBtnebtdPdb1o6h6pgi9BSofCUk/apk3Q3n+gJw=;
        b=rVYHnTBKUsTFohTJCXTXGnLrdxxYKIC0Yz5A4mwa2jCWP038Cp/q5Qt+IW9yr3AyYZ
         00hJkGRV1stDYoIlCELVWhZ9XWLiFVtQrxS05oBXDtvybqvOXV8UMed+uFOMqrGC+D6M
         dKxvqo3QtH9aKzTbdDp/CeRPvokjXgsTceBcSNoqtiW6Da7GdY9756DqG9LBXRzobQra
         BUK239v3LcQY2pN91LPG9RvLHe17hGSk8AR3OlASBFVI75ZJ8+VqpxzNCfqj5s+vizpS
         TYEpIklcU8Uc0UYLsL3hVOwfe+Y8iWelq4r9BDMF5HiaS58S9TtSrgebAC7FjPva5qkM
         xjuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc7b9PRCr8R9xdC8YSl3bG1Hkq4d4LUNtiB+XOJx1PTr5sYAZx4dfioqDe54yNYXFhdHDZnr8qE9I14Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YycunuiVsM6rE0IjJ+TbcXAWJ/Ql10ZFs5HLI+QUhlhCI+unoNE
	ohIY6WV9uAfXR0mqdtkm5ru5bXkFMwQVyZoaWJdTgIOZH/CKUea33fpYyG/xM1LJjKFN4wTMzLi
	XaLlolT/uaQv156RzdgqE6A/YVE91g7qU0WFXLw==
X-Gm-Gg: ASbGncvJcNWPkDrLMs1of/M9qCgazegq/rP3KoOs5kAWxDsBrpT1lYePUhK8sEmKnjj
	sxGY97j9dxMQOz0HEHhn1jqu9i8O4y5mfwF7J0obhSoSqzwQXVgz1yHKJEnqYJzVYe9idXhSda0
	20TV5mokY67a8BOSpfmT6mT9W3
X-Google-Smtp-Source: AGHT+IGMXugf6rLzvcW/F285Y4NjLaRh5Iz82YMIfJlcmuXHu8GA0a12cjNfscsqv7avahvAvtKxCphp/EqLAa/IDIw=
X-Received: by 2002:a17:90b:4d04:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-306dba68a6cmr787236a91.0.1744168596706; Tue, 08 Apr 2025
 20:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com> <20250408-ublk_task_per_io-v2-1-b97877e6fd50@purestorage.com>
In-Reply-To: <20250408-ublk_task_per_io-v2-1-b97877e6fd50@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Apr 2025 20:16:25 -0700
X-Gm-Features: ATxdqUG4NcnbgpWENdrxpVnnkV2LPrates14IyBFzhzGmRQgOYikL_Za8eofzxM
Message-ID: <CADUfDZrEvT+bfTH=en4zjAexP3v0Nk5Zxk8BphfVV6E5-xdfLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ublk: properly serialize all FETCH_REQs
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 6:42=E2=80=AFPM Uday Shankar <ushankar@purestorage.c=
om> wrote:
>
> Most uring_cmds issued against ublk character devices are serialized
> because each command affects only one queue, and there is an early check
> which only allows a single task (the queue's ubq_daemon) to issue
> uring_cmds against that queue. However, this mechanism does not work for
> FETCH_REQs, since they are expected before ubq_daemon is set. Since
> FETCH_REQs are only used at initialization and not in the fast path,
> serialize them using the per-ublk-device mutex. This fixes a number of
> data races that were previously possible if a badly behaved ublk server
> decided to issue multiple FETCH_REQs against the same qid/tag
> concurrently.
>
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..5535073ccd23dfbbd25830c17=
22c360146b95662 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1809,8 +1809,8 @@ static void ublk_nosrv_work(struct work_struct *wor=
k)
>
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue=
 *ubq)
> +       __must_hold(&ub->mutex)
>  {
> -       mutex_lock(&ub->mutex);
>         ubq->nr_io_ready++;
>         if (ublk_queue_ready(ubq)) {
>                 ubq->ubq_daemon =3D current;
> @@ -1822,7 +1822,6 @@ static void ublk_mark_io_ready(struct ublk_device *=
ub, struct ublk_queue *ubq)
>         }
>         if (ub->nr_queues_ready =3D=3D ub->dev_info.nr_hw_queues)
>                 complete_all(&ub->completion);
> -       mutex_unlock(&ub->mutex);
>  }
>
>  static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> @@ -1962,17 +1961,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>         case UBLK_IO_UNREGISTER_IO_BUF:
>                 return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_fl=
ags);
>         case UBLK_IO_FETCH_REQ:
> +               mutex_lock(&ub->mutex);

I think this may need to be even earlier. Currently the io->flags &
UBLK_IO_FLAG_ACTIVE check happens before the mutex is acquired. Which
means buggy/malicious threads may concurrently try to initialize the
same ublk_io. ublk_mark_io_ready() would then increment nr_io_ready
multiple times for the same ublk_io, causing the ublk_queue to be
declared ready before all its ublk_ios have been initialized. An
alternative to acquiring the mutex before checking io->flags &
UBLK_IO_FLAG_ACTIVE would be to check it again after acquiring the
mutex.

Best,
Caleb

>                 /* UBLK_IO_FETCH_REQ is only allowed before queue is setu=
p */
>                 if (ublk_queue_ready(ubq)) {
>                         ret =3D -EBUSY;
> -                       goto out;
> +                       goto out_unlock;
>                 }
>                 /*
>                  * The io is being handled by server, so COMMIT_RQ is exp=
ected
>                  * instead of FETCH_REQ
>                  */
>                 if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
> -                       goto out;
> +                       goto out_unlock;
>
>                 if (ublk_need_map_io(ubq)) {
>                         /*
> @@ -1980,15 +1980,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>                          * DATA is not enabled
>                          */
>                         if (!ub_cmd->addr && !ublk_need_get_data(ubq))
> -                               goto out;
> +                               goto out_unlock;
>                 } else if (ub_cmd->addr) {
>                         /* User copy requires addr to be unset */
>                         ret =3D -EINVAL;
> -                       goto out;
> +                       goto out_unlock;
>                 }
>
>                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>                 ublk_mark_io_ready(ub, ubq);
> +               mutex_unlock(&ub->mutex);
>                 break;
>         case UBLK_IO_COMMIT_AND_FETCH_REQ:
>                 req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], =
tag);
> @@ -2028,7 +2029,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         ublk_prep_cancel(cmd, issue_flags, ubq, tag);
>         return -EIOCBQUEUED;
>
> - out:
> +out_unlock:
> +       mutex_unlock(&ub->mutex);
> +out:
>         pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
>                         __func__, cmd_op, tag, ret, io->flags);
>         return ret;
>
> --
> 2.34.1
>

Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63908214A97
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387268; cv=none; b=TVLubCGjdivJ1JrI5+K0ic4PGwNDDJi4vG8M1ZoNYDNMBLktqCBkzpzVXAT3uomRnmHkE1iLZiyTWimkJJ8CCYVkfCPkwJleW0YbCV2iFzjDTSk5tWmtsjvewiQ/pVwjVzlbicKeFJgQuHCDcF+G/NlAkWBSnqpsKbMPjuMyi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387268; c=relaxed/simple;
	bh=sHWsHYI9wc6yifZXMESnN9eYVDNwfzleJ6UZfqv3pi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yfbn9iBzgmx8ng4WQyJ67GiXAJhd/59Rh5+GMj5suwQ2dZNymSiSMs+PGmL0psSe0mwVaQZOIpRXcfHNoOiZJNdnMRnkqKqABo35ZxK+m2P2rwA8ED06/dNnKKVBBb6cNEuOiMcNnDS9ZSHBEmVKxx1wbc5iALGOzXm2XL3hh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=H45Tl87u; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="H45Tl87u"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff73032ac0so293526a91.3
        for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744387264; x=1744992064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61s6j26nM6XIw3ksNhIbr071Uj0MEE8Pa7OJpC2DoWc=;
        b=H45Tl87udczcRAJYW4b5RoX8OBR0DtjKd/PFkMhtii5H4s+pA72cpvjuoEwljyJzSc
         +M/33L515XYC9QGLj8zN8t69RkuAXUJv0qNnSiTP2V4JD1zVydxlcPfNLSbhAOqguPM0
         h2j4c8SzUEw9udAF+/M4jgg0uQvOHOvHROBE7XWrFSP/oIQOMfiDpKfdcFoLFf2890sV
         oOihKCZEQ/tXR5lp78q1eXbPnUBcwvziy+KaSvsxTlVyhuBLbjEVtgEOrFEkf8Qmty8G
         /sxwihlM8dxfmiZZgJMUghBeqnJe53rV1bhPzgOD9vM2uwZjxhdpBtBdRtE044/XluWm
         w2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744387264; x=1744992064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61s6j26nM6XIw3ksNhIbr071Uj0MEE8Pa7OJpC2DoWc=;
        b=J0UCdNHBIpVCORJb0CoOPOmqHd9Cl6zX+8KSycL8pfQ+OiDibMV3VLooR7Kq6b/pVA
         DQQdiZ8NdsyC6KFSyKL4TgW32wMwFjuENADnovQctlZRQrH5FVPumj/0t8vdFiXczxGs
         mub2M9u9QN/cDjg9f+caWLAAgmjMVO6BYWzFr3ARnUNbnHBcAxgBV9R9cRMxuk9Y4sVd
         TvdcY/A0Fop1/pKWAmdEwQt30Dw3KJw6aRIB5RyAFVZU+Bfo2qHXNjBN6/Avy3j5NTPr
         4TXOpKzzcC9i1lwe6gaC4URbSy1hOOM92vPoSixpu40p8UFncDqVrjPOyS9QtLTiciQd
         S/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXiTx9e1KdVMmfOncjeq8NpU1swlxZuuE5hHAZI/xtTLx4O/aapTUOhe36kPBAiyoyi+/K7i407bN2idg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHO61vdYjV9AnWM6K/FaWwP8C3Y/uu4WisHSoSR7VPEsfggsdv
	EjM8SzKA+LSnpWcov6lG/bC+vcvi7ACCAQqj5XMO1EyYRSgLVemxBHo37sS7UH/ZdSxGZJ5yD1I
	pV9Xh77TbcZC7OXfdRlUNjA+aBPes5qJI87eqmg==
X-Gm-Gg: ASbGncud7YbcXTo763r+4NOFpm7wj+VnpzcCBHYksmgwyIIn2Fb6s9l/XXWowoStJu6
	df8BjKV6o8E6owZIiA0M407MJQ4NBRoGRYlA+kH614RSZvRjUiNh0vui8nnZa/QIwK62k7MvYt9
	Y00OZDvWxt8c31+wSm+uwnZq2mthMqB0I=
X-Google-Smtp-Source: AGHT+IFYpymN/nWbb7xCSuUlYiLgvAkA61TOBKft4OptDzylTBlYSbwYyOvnfiVCN1loyKh1r0eEWyoUYcZ82cqPVZc=
X-Received: by 2002:a17:90b:4d04:b0:305:5f20:b28c with SMTP id
 98e67ed59e1d1-308237c95b7mr1867875a91.5.1744387262982; Fri, 11 Apr 2025
 09:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com> <20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com>
In-Reply-To: <20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Apr 2025 09:00:50 -0700
X-Gm-Features: ATxdqUFtooeZfbODI6HbJfhaMnLRQmWKWgXd-mt6MNwZzajwyXqVqBbq_ndUZG4
Message-ID: <CADUfDZpx-864GAObyLoigwn0=pZ+ZHWzsM6ZpX+-0Pc1Z-unZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ublk: properly serialize all FETCH_REQs
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 5:18=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
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
>  drivers/block/ublk_drv.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..812789f58704cece9b661713c=
d0107807c789531 100644
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
> @@ -1962,17 +1961,25 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
>         case UBLK_IO_UNREGISTER_IO_BUF:
>                 return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_fl=
ags);
>         case UBLK_IO_FETCH_REQ:
> +               mutex_lock(&ub->mutex);
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
> +
> +               /*
> +                * Check again (with mutex held) that the I/O is not
> +                * active - if so, someone may have already fetched it
> +                */
> +               if (io->flags & UBLK_IO_FLAG_ACTIVE)
> +                       goto out_unlock;

The 2 checks of io->flags could probably be combined into a single if
(io->flags & (UBLK_IO_FLAG_ACTIVE | UBLK_IO_FLAG_OWNED_BY_SRV)).

And I agree with Ming, it would be nice to split the UBLK_IO_FETCH_REQ
handling into a separate function, especially now that the mutex needs
to be acquired for the duration of its handling.

Best,
Caleb

>
>                 if (ublk_need_map_io(ubq)) {
>                         /*
> @@ -1980,15 +1987,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
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
> @@ -2028,7 +2036,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
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

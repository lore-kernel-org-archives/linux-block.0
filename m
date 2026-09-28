Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040324F3EA8
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613980; cv=pass; b=nT1QpPrdj75VtjXSltpn/O2XMX1XugEsj7MpaUmEMUXiI/U8qTuT7AGJVie24EQUc1Hs2HDbagPEHGp9FlrcKaCN/jzaMVzE5QG6nrV3zEtWh4x6xoAOaeYQBc+oc8xNsQvHDJIULKKpkkKTw0kdkgR/CgMRAmOoYnbZARS0ea4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613980; c=relaxed/simple;
	bh=B74UBb276nD/8iUECibtxJNeQU0pVKwKpT61VpN43I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUKgLeAabUjNEkBc/yoy2amYdM2qk1S2K35Gu09gml7a+1iy8/o1RFNj7CyX5K1Rer59CVOgxTKNYqtAsW9SOlo8SHsgKUnMzcXYXvV7D7+BTvFI/i6c2cgAK0oacQcbV4iEVS8NebsulPER3NQKWh1pn2m+BvZ5R9ZNydy5A3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KgW7jgoM; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KgW7jgoM"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-801cb343a92so489088a34.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790613977; cv=none;
        d=google.com; s=arc-20260327;
        b=CSguVi/ws0GebyFF4j2ucZ+LaW6tVy+bAhFjciiUZuTbzqCUi1B/w4Il/E86il7DbF
         rsjamZg/ljKC/yRX0NDA1afev01gUT36ubmoT6k7WOnG7Vz+6VJuwNYMG2y0oJ95oEmB
         aj42vkNJyqi3KkdVRsp3+4H5tz+amDRQjaMDnHWNuNs/vis+WyOg1V+pIFr7uM82E6Dk
         kjAom7wj3N6Kvh1oQnUcvdhG5VaFpDzeSWctUccZx5twFjU3OnvVTyCy04PR7Qj7VZ0H
         NCn/Ne/aENrdbpRLwaCKLnxbOZu/AudnaHmDix8hslwAXihhcAcnmDfElIqhxfxs/u5R
         j16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6MxcGWKPwlSfZ6XYjmwewQi2AoWWoplu0F5a8GFLTk=;
        fh=fkUzYRkBNQEZm0ABliu1pYQudp5hFoX6wlYoYYHmy0s=;
        b=IjlV10xZ836PZgSX7c8PdZC8a8ulDxMS45B9/9BUIzHe40PDQf/ArmFedxYK9p7Gy1
         810WJ6ut9/ow68OcOss53AdWNMGB8ZyLyYowA23cZAlP7eyAwQr0OCZa3DJxXx68CtgV
         4761wu9GtHgeG3zCRfUwkXrmbn4fB7QU9m3d5lP0+UGAr8wcU3cWWmN9kJcg4bQveMdK
         KS879g4Wmxq7NZUwC5+z/xmE8LqtlPX25GUstiyGdMKSqVGnWSu9KdMNzME2OZ5Noy4l
         m9oi+sXOUBCbyD671Ab76tan75P8p8q7vZFXM5ii34qU/6RjTFbJWlorHATYwUAF8qSZ
         3sxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790613977; x=1791218777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f6MxcGWKPwlSfZ6XYjmwewQi2AoWWoplu0F5a8GFLTk=;
        b=KgW7jgoM5zz6tgYQBRqbmbDEGiF1aXW35IF4IQ9+pwZpdHSdXJk2L89d1KdfF5OXJ5
         c3mbhYIy+gpVg4iSzrGcN7u93mcZN2R1SEtO/EnzYUrmlTnQzuHHlFqDxFckUGymuWrp
         dfOn+kkvHwlqaP9WWUGAK00DJi/QOw4NxrfDuFY49ZuKp3missCWjTRUpvCOQ45vv5qU
         CDWdqYa5YqUOfEqmjuHuPA/siUjpjNalykuakR/QLklOHCpUn+g1YAlye4FnGqq/o4wu
         n0az1+cv4NYDVdJGvmL0nO1O5VbR8AZCwl6aJiCNh9YlUx9frCkO0VXm6OikAwvF8mTa
         S71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613977; x=1791218777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6MxcGWKPwlSfZ6XYjmwewQi2AoWWoplu0F5a8GFLTk=;
        b=MVrqKJZAubp/2fFibV7WbcUExXNBoCFZGB6zpAzjBLo2VP9pZZManrFHQNF/HvMVVl
         JlxOJBsUZv9BqFXagQPBzRgxV1IrPW9+xgSR3Ast7IavUrzsJYsAb1bYCFdoqNzlTYTd
         jYqEfdyaaSEQXJPEi1Ve63W8BTxLO2aXvH7nVQTwbhzBLi70ZQIES2+SLIim8WV5RBkH
         B2x/bP+OP5Fp0DQZE55qYr/e+14alKyyU2C8/tZBP+7JxKl70XPP+R08Dnxl95hl3Ij4
         gRalOG2CBQhtZ0iUVzDKGWExWPlFi07bXiQOpTmK15ANBgmvKoL+QqCuFgMK5sV1wxgi
         hJeg==
X-Forwarded-Encrypted: i=1; AKwUvByUctvd3l96if8mJwHbSXuNlD4vI2orhPQu0FCITGy8f47aVK7A6D17vSfMzEN4J5cUvrzhDVj+v9IogQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lK92vMsG2n9QnSocoYtCdtthpcmNJYtPLlaKC3AiR+6uDCg01S
	QDqZGxAwel9oTVtWczOzGwdvY2cXYdgvGpK//uhuxN4h2aTNV9ejl79NXR14DabIT8jFtuvJA4O
	qlmShaq47mF67BHOX9fHp2PEzdaTsQpOLkgWbbmvSCA==
X-Gm-Gg: AYBFou1nwiYIw+Sxh/3b6cEQal6jCAAJyt5jKsMFnduCcjFkkpdudqlHXLpe28HUSGQ
	O3adOn/hhjYD4Ys0AB1K2IuJ52tHQ4l+cQaKvNHsbqhJo70rzdo6Q1H8VErieUgUa6U3PkbZIF8
	Q1iQMRr9QT1S3V0v4eW0JSZzUInvtKFMG1rKSviI9V9J1vzZdDa2VV6ejgmSV7D6WwpCR4TuIum
	dCZ7Isd9R9AroGEYTBB9iTec1WO886TpPMeoBx3PJFR3R54SEWPe48F5+qAcuwbddndYWHCLLQc
	uq3uJ077qEBP0KsGA0wP67tqblzvS+F1r7GnA8W9GFZYZnaaG5sm8/E=
X-Received: by 2002:a05:6870:174b:b0:47c:e496:7b37 with SMTP id
 586e51a60fabf-49304c03782mr14185148fac.0.1790613976466; Mon, 28 Sep 2026
 09:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com> <20260928-b4-ublk-cancel-stop-v1-1-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-1-4a4360232a46@toxicpanda.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Sep 2026 09:46:04 -0700
X-Gm-Features: AclHuK-atp-GyZJe4TIVhfWYQuo52M71kqTHzd7P4K8sn93o8izgsy4uwMLRvC8
Message-ID: <CADUfDZpg0O89whqqCD4tASkS1KxV6b7xWn9mH8TTPQPo6KSFFg@mail.gmail.com>
Subject: Re: [PATCH 1/9] ublk: keep queue canceling over canceled commands
To: Josef Bacik <josef@toxicpanda.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:02=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> ublk_queue_rq() dispatches a request to a NULL io->cmd and the kernel
> oopses when a queue got ready over commands which were canceled after
> being fetched. ublk_mark_io_ready() clears the queue's ->canceling once
> q_depth commands got fetched, and that count does not go down when a
> fetched command is canceled:
>
>     task A                          task B
>     FETCH part of the queue
>     exits, its commands get
>     canceled
>     ublk_uring_cmd_cancel_fn()
>       queues marked canceling
>       io->cmd =3D NULL, command done
>                                     FETCH the rest of the queue
>                                     ublk_mark_io_ready()
>                                       queue is ready
>                                       ->canceling =3D false
>
> During recovery the disk is attached at that point. Before the first
> start START_DEV adds it afterwards.
>
> The UBLK_IO_FLAG_CANCELED left from an earlier round is dropped after
> the command is published, and ublk_cancel_dev() does not hold
> ub->mutex, so a cancel coming in between loses its flag again.
>
> A UBLK_F_BATCH_IO queue has no per-io flag for this, but STOP_DEV and
> QUIESCE_DEV set its ->force_abort when they cancel its fetch commands,
> so key on that for such a queue. ->force_abort is only cleared once the
> queue is ready again, by ublk_queue_reset_io_flags() after this check
> has read it, so one left set by the quiesce of a server which is gone
> would keep the queue of the next server canceling. Clear it in
> ublk_ch_release_work_fn() once the old server is gone, under ub->mutex
> since ublk_stop_dev_unlocked() sets the flag under that mutex and needs
> it set until del_gendisk() returns. From then on until the queue is
> ready again, requests for a UBLK_F_USER_RECOVERY device are requeued
> through ->canceling instead of failed through ->force_abort, as they
> are on a queue without UBLK_F_BATCH_IO.
>
> Fix by keeping ->canceling at the ready transition while a command of
> the queue carries UBLK_IO_FLAG_CANCELED, or while ->force_abort is set
> on a UBLK_F_BATCH_IO queue, and by dropping the stale flag and
> publishing a fetched command in one cancel_lock section.
>
> Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  drivers/block/ublk_drv.c | 59 +++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e7162e..183de080e008 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2603,6 +2603,16 @@ static void ublk_ch_release_work_fn(struct work_st=
ruct *work)
>                 }
>         }
>  unlock:
> +       /*
> +        * A ->force_abort left set here was set against the server which=
 is
> +        * gone, clear it so that ublk_queue_reset_io_flags() does not co=
unt
> +        * it against the next one, whose requests ->canceling holds back
> +        * until its queues are ready.  Do it under ub->mutex, under whic=
h
> +        * ublk_stop_dev_unlocked() sets the flag and relies on it until
> +        * del_gendisk() returns.
> +        */
> +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++)
> +               WRITE_ONCE(ublk_get_queue(ub, i)->force_abort, false);

I think this has already been done in
https://lore.kernel.org/linux-block/20260821103047.369522-2-yangxiuwei@kyli=
nos.cn/

>         mutex_unlock(&ub->mutex);
>         ublk_put_disk(disk);
>
> @@ -3015,27 +3025,44 @@ static void ublk_stop_dev(struct ublk_device *ub)
>         ublk_cancel_dev(ub);
>  }
>
> -static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *=
io)
> +static bool ublk_queue_has_canceled_io(const struct ublk_queue *ubq)
> +       __must_hold(&ubq->cancel_lock)
>  {
> -       /* UBLK_IO_FLAG_CANCELED can be cleared now */
> -       spin_lock(&ubq->cancel_lock);
> -       io->flags &=3D ~UBLK_IO_FLAG_CANCELED;
> -       spin_unlock(&ubq->cancel_lock);
> +       u16 i;
> +
> +       /*
> +        * The ios of a UBLK_F_BATCH_IO queue are not canceled one by one=
,
> +        * canceling the queue sets ->force_abort instead.
> +        * ublk_ch_release_work_fn() clears the flag when a server goes a=
way,
> +        * so one seen here was not left behind by an earlier server.
> +        */
> +       if (ublk_support_batch_io(ubq))
> +               return READ_ONCE(ubq->force_abort);
> +
> +       for (i =3D 0; i < ubq->q_depth; i++) {
> +               if (ubq->ios[i].flags & UBLK_IO_FLAG_CANCELED)
> +                       return true;
> +       }
> +       return false;
>  }
>
>  /* reset per-queue io flags */
>  static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
>  {
>         spin_lock(&ubq->cancel_lock);
> -       ubq->canceling =3D false;
> +       /*
> +        * A command canceled after being fetched is still counted as rea=
dy
> +        * but can't take requests, so the queue has to stay canceling.
> +        */
> +       if (!ublk_queue_has_canceled_io(ubq))
> +               ubq->canceling =3D false;
>         spin_unlock(&ubq->cancel_lock);
>         ubq->fail_io =3D false;
>         ubq->force_abort =3D false;
>  }
>
>  /* device can only be started after all IOs are ready */
> -static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
> -       struct ublk_io *io)
> +static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
>         __must_hold(&ub->mutex)
>  {
>         struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> @@ -3044,7 +3071,6 @@ static void ublk_mark_io_ready(struct ublk_device *=
ub, u16 q_id,
>                 ub->unprivileged_daemons =3D true;
>
>         ubq->nr_io_ready++;
> -       ublk_reset_io_flags(ubq, io);
>
>         /* Check if this specific queue is now fully ready */
>         if (ublk_queue_ready(ubq)) {
> @@ -3269,6 +3295,8 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
>  static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
>                         struct ublk_io *io, u16 q_id)
>  {
> +       struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> +
>         /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
>         if (ublk_dev_ready(ub))
>                 return -EBUSY;
> @@ -3279,7 +3307,16 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, =
struct ublk_device *ub,
>
>         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
>
> +       /*
> +        * ublk_cancel_dev() runs without ub->mutex, publish the command =
under
> +        * cancel_lock so that a cancel either misses the io or finds it =
whole,
> +        * and drop a stale UBLK_IO_FLAG_CANCELED in the same section fir=
st so
> +        * that one set from now on stays.
> +        */
> +       spin_lock(&ubq->cancel_lock);
> +       io->flags &=3D ~UBLK_IO_FLAG_CANCELED;
>         ublk_fill_io_cmd(io, cmd);
> +       spin_unlock(&ubq->cancel_lock);

And this looks like it may also duplicate
https://lore.kernel.org/linux-block/20260508123746.242018-1-tom.leiming@gma=
il.com/

Best,
Caleb

>
>         if (ublk_dev_support_batch_io(ub))
>                 WRITE_ONCE(io->task, NULL);
> @@ -3306,7 +3343,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, str=
uct ublk_device *ub,
>                 ret =3D __ublk_fetch(cmd, ub, io, q_id);
>         if (!ret) {
>                 ublk_apply_io_buf(ub, io, cmd, buf_addr, &auto_buf, NULL)=
;
> -               ublk_mark_io_ready(ub, q_id, io);
> +               ublk_mark_io_ready(ub, q_id);
>         }
>         mutex_unlock(&ub->mutex);
>         return ret;
> @@ -3723,7 +3760,7 @@ static int ublk_batch_prep_io(struct ublk_queue *ub=
q,
>         ublk_io_unlock(io);
>
>         if (!ret)
> -               ublk_mark_io_ready(data->ub, ubq->q_id, io);
> +               ublk_mark_io_ready(data->ub, ubq->q_id);
>
>         return ret;
>  }
>
> --
> 2.55.0
>

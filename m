Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3837F739
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323644; cv=pass; b=eUBzt+WjFC7OgG1iE9WukyqDvlqIHcRTDkxHLGCCZSQdjHLC66FX7f4EOjMjuItG0qpAqH7eLEmnQK3usaR1IfNUwFVcx2Si5Ygw4hfou5CIvufOeZXe+bkSo5Ysg3b/v48QTX7kfT0miXG8t/ACGnmER4U1PNPrXQFMnT7wN3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323644; c=relaxed/simple;
	bh=uFrWq/GnZ+0BN8hgez5OTpgDYzvPxX6CIqb83cbQaeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRtHnQYxpRGMKPjN+6q49G+sZsXgnPL+7RRKF4YcAMGvijevP0Op000tvuG+rD++Y+DDbiJbVmt1BwKS0CdO2cVJ/MzjSVu6wRo+hNVFlTo3W6vZaIQqX9FK7s9kXGUt69FIkeZ7WDXQnNgs+3iIQZPWRYyhVbqqiqjrfWbO9ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c4JM1FTc; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c4JM1FTc"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-8233aaac5ceso148071a34.3
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 14:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791323641; cv=none;
        d=google.com; s=arc-20260327;
        b=ZnVmsvJ7/2sMWYKdavhU7MR/JgLpKyBSSfWqwdsDYpHCe3fWh6BDwIgAoagfogxAC3
         rYCUPcFqh09LhHE1vdHda2WIvI/7lmDZAo1ZsAi7zCduo35bIN6FMInRgEoENN3yakE1
         T0wuQ7hYxI+0L2OedrRqcphwbnY6aHzAOn1Wj/L8t1ai1XjM2RmdIaVPU/FnrNAV2+lD
         d+qQNBQHExhGKcvZmnivC+8wPiWHTu9Lo/sVlT7gP79EqmjRAP193dcjQZkPi5FllW9S
         Y6nTXqvree26fj6o20uTWazO3pbojN9BoN/D3meq9b9tNx4m25uSA5EdB1aGBTOXRtwO
         L4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7h5s1lZiDGwQlyFqHQMWRUoVdODCZpSc99KbT1eXaE=;
        fh=ubqH496AAM+hNyqaVZ8m/+oSs1sk3vdTdwLUVEkzMxE=;
        b=FyC1xZwqkrZE+Jp+oDCOxlDVxlXlrjq2RTX5QElLgUhS/3togRdb8eeU9QHsbe8+y5
         AyOLp26BONRHUctYuUXoCcUtD8U4yEPlNpVygwu0IhOZTosYBFcdurnLFBuIjOivXI37
         2F+qZ/VGBmwkQs3Z9Vbem6tSgNoVh1eEekx1i16/xinq+va413QUNyTBXAXDWQsXATJl
         2EaRo1aGLduFvmJeVsiGzoKDjkottTH4E5Gl9kttbdU5coTWBroZBSdhPgbthDf1DryP
         xH/0lXTeTp9OcZNP+77WgoZ1hyi6sDM07TPRmgLq7wJdvVwMLyq1LBzIrrV6+0a2AN2x
         h6PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1791323641; x=1791928441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7h5s1lZiDGwQlyFqHQMWRUoVdODCZpSc99KbT1eXaE=;
        b=c4JM1FTcjF88RKD0Vf4Zn2RaTUbaV5/fzVFZ+RsIOu/sdoRc21lOfmcO4YoRwVjotZ
         GGzDE5sDJ09xCfYDfuMntfZkNFGjxTvKxZUcUzEW2bPz2SblP4rspg8P5o+xAJ5j6j9X
         ZsuGpzn2zy7vmcsQtstzPJUFE/BJMcBIPg5Yln63sRkIwIWxuPzDyxEvDlPHxI+pl3H2
         rQ5ZxJf24zDbzYmxdn+z9i/hjooHj9PG//YDeUPjXowKot/fDF1tt8FsOS8guTXEANCR
         N90z+da+JTbcj7z7ZFw4TA9G8pK8EGBXKOkpPKLfBCAfQH6M0QBVSWFVgo7TDKSexOIm
         aoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791323641; x=1791928441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7h5s1lZiDGwQlyFqHQMWRUoVdODCZpSc99KbT1eXaE=;
        b=NHca3cyK/BZA2eH0FGWEjlwAcvpR3tktmsMzSrn2E+dzAo6eiWM8kuCsdGWwnJ2HUW
         IRfx+MaMWYCJbocAcZC9t5X96xtFRIHNXTcC7yyKo8QmbR9mdAsS+lnq2wjtvy/gygGs
         /VD+ccrRi1WBilbMpleJc9csZgWkVGXTNhk5W9pi2scrYuFkwyXQ/jQJTze/eBzNaSI7
         cRCWXxCN269CLAlOqd5uC/1S9l0qu7E8AcazYgod5/81t44KNADkJpzo78OgrbXg2VbC
         4M9AGyzzh2tyDJncYCGLr2Z/GrRZljJCOY8kdXlvjVSzDFvdNY60YrEqpAddPM6ZXoUs
         iDdg==
X-Forwarded-Encrypted: i=1; AKwUvBwN91Rw0zu13J43KiiGI85/K4qbEu8aaLpoUUDDsy+ABBlT1myQXqBEIYWDh7UQizSMywpCoHtetktMRA==@vger.kernel.org
X-Gm-Message-State: AFuF++k7o/mKRscYcBsGHwH65qHQVzrN4D767+DYM3EpMTutlwgvspCS
	fSH1wZ4HhO0SH7Y73OU9tS50meSRZS7WysSOSYo/vJGroXAVT8GMqVB+tINI0TPn5ns4OfLXcb5
	IpJJa9wDwP3Z8MCnEmASvot/t7rEodf1Fqee5iXmc2Q==
X-Gm-Gg: AYBFou1veuj0i08y3YjIZrALtHm93svfU6bYqAF8leXDqEaNXPjVL7//xqnErHbYFYc
	4jxVZ4FXo5cq7F9de0ZdBRne0ut8JOcnOBnnyPrOXSdWykhwd2Ek3wmLfpay9VuRqT7cGOGVs+U
	R+P8HLjnKWIxSpknsDvfpkycjBf9b5LW7jQdQvRrph+WaOkS7yHzDlOdNsHKeIkZiiMWDSzaM/A
	Ia/5MNZuvNr8wkCvZg3izfRHCA37yXjgcxqF3k2T+k63qo0yHxg4Ms6fxCcX9CnvV1kIctrqYRg
	GWh1uEVCtBy/gEMaiKV/zeTMwk1iTIl4N/9d9AwQhesJJU5P6fXixhs=
X-Received: by 2002:a05:6808:690a:b0:4f4:ad37:ced3 with SMTP id
 5614622812f47-4fc479b19efmr913651b6e.3.1791323640551; Tue, 06 Oct 2026
 14:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006190348.85094-1-yoav@nvidia.com> <20261006190348.85094-2-yoav@nvidia.com>
In-Reply-To: <20261006190348.85094-2-yoav@nvidia.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Oct 2026 14:53:47 -0700
X-Gm-Features: AclHuK-AxsGpipdi8xQypNAGhytCd25yVsFCryUauXR68cUDXsyEOlHaDwHi3sc
Message-ID: <CADUfDZrX7v+0-Zxv7AwoJBH-e0ohLcAgm_dvPoDpGv2jZfN2XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ublk: honor rq_affinity on request completion
To: Yoav Cohen <yoav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	jholzman@nvidia.com, omril@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:04=E2=80=AFPM Yoav Cohen <yoav@nvidia.com> wrote:
>
> ublk ends successfully completed requests inline on the server thread
> that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
> redirects completion back to the submitting CPU, unlike NVMe, SCSI,
> virtio-blk, loop, nbd and rnbd.
>
> Route completion through blk_mq_complete_request_remote(), with a new
> ->complete() callback, ublk_end_rq(). This covers every completion
> outcome -- reads, writes, flush/discard, errors, and the zero-copy/
> user-copy/auto-buf-reg/shmem-zc paths that skip the copy-back step --
> not just the classic-copy-mode successful-read case, since
> ublk_end_rq() re-derives which of those __ublk_complete_rq() took from
> @req and @io state rather than assuming one.
>
> Gate it behind a new UBLK_F_SUPPORT_RQ_AFFINITY flag that a server
> must request at ADD_DEV time; servers that don't ask for it keep
> today's always-local completion unchanged. Add ublk_support_rq_affinity()
> alongside the existing ublk_support_*() helpers, and check it before
> calling blk_mq_complete_request_remote() at both call sites.
>
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 98 +++++++++++++++++++++++++++--------
>  include/uapi/linux/ublk_cmd.h |  8 +++
>  2 files changed, 84 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e7162e..b94293296b73 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -90,7 +90,8 @@
>                 | UBLK_F_BATCH_IO \
>                 | UBLK_F_NO_AUTO_PART_SCAN \
>                 | UBLK_F_SHMEM_ZC \
> -               | UBLK_F_IO_DESC_SIZE)
> +               | UBLK_F_IO_DESC_SIZE \
> +               | UBLK_F_SUPPORT_RQ_AFFINITY)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -452,6 +453,11 @@ static inline bool ublk_support_user_copy(const stru=
ct ublk_queue *ubq)
>         return ubq->flags & UBLK_F_USER_COPY;
>  }
>
> +static inline bool ublk_support_rq_affinity(const struct ublk_queue *ubq=
)
> +{
> +       return ubq->flags & UBLK_F_SUPPORT_RQ_AFFINITY;
> +}
> +
>  static inline bool ublk_dev_support_user_copy(const struct ublk_device *=
ub)
>  {
>         return ub->dev_info.flags & UBLK_F_USER_COPY;
> @@ -1468,6 +1474,14 @@ static inline bool ublk_need_unmap_req(const struc=
t request *req)
>                (req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_=
OP_DRV_IN);
>  }
>
> +/* Whether __ublk_complete_rq() takes the copy-back/partial-completion p=
ath */
> +static inline bool ublk_rq_need_unmap(const struct ublk_queue *ubq,
> +                                     struct request *req)
> +{
> +       return ublk_need_map_io(ubq) && ublk_need_unmap_req(req) &&
> +              !ublk_iod_is_shmem_zc(ubq, req->tag);
> +}
> +
>  static unsigned int ublk_map_io(const struct request *req,
>                                 const struct ublk_io *io)
>  {
> @@ -1549,13 +1563,62 @@ static void ublk_end_request(struct request *req,=
 blk_status_t error)
>         local_bh_enable();
>  }
>
> +/*
> + * Update @req with its result and requeue it if it was only partially
> + * completed. Returns true if @req was requeued, in which case the calle=
r
> + * must not touch it any further.
> + *
> + * Run bio->bi_end_io() with softirqs disabled. If the final fput happen=
s
> + * off this path, then that will prevent ublk's blkdev_release() from
> + * being called on current's task work, see fput() implementation.
> + *
> + * This matters for the caller completing @req locally on the ublk
> + * server's own thread: it may already be holding disk->open_mutex, e.g.
> + * reading the partition table from bdev_open(), and an fput() running
> + * inline there could deadlock on it. Preferably we would not be doing
> + * IO with a mutex held that is also used for release, but this
> + * work-around will suffice for now. A caller reached instead via
> + * blk_mq_complete_request_remote()'s softirq/IPI redirect never runs on
> + * that thread, so it isn't exposed to this hazard, but disabling
> + * softirqs here is harmless for it too.
> + */
> +static inline bool ublk_update_and_requeue(struct request *req,
> +                                          struct ublk_io *io)
> +{
> +       bool requeue;
> +
> +       local_bh_disable();
> +       requeue =3D blk_update_request(req, BLK_STS_OK, io->res);
> +       local_bh_enable();
> +       if (requeue)
> +               blk_mq_requeue_request(req, true);
> +       return requeue;
> +}
> +
> +static void ublk_end_rq(struct request *req)
> +{
> +       struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> +       struct ublk_io *io =3D &ubq->ios[req->tag];
> +
> +       /* matches the two outcomes __ublk_complete_rq() may have redirec=
ted */
> +       if (io->res >=3D 0 && ublk_rq_need_unmap(ubq, req)) {
> +               if (!ublk_update_and_requeue(req, io) &&
> +                   likely(!blk_should_fake_timeout(req->q)))
> +                       __blk_mq_end_request(req, BLK_STS_OK);
> +               return;
> +       }
> +
> +       ublk_end_request(req, io->res < 0 ? errno_to_blk_status(io->res) =
:
> +                                           BLK_STS_OK);
> +}
> +
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req, struct ublk_i=
o *io,
>                                       bool need_map, struct io_comp_batch=
 *iob)
>  {
> +       struct ublk_queue *ubq =3D req->mq_hctx->driver_data;

mq_hctx->driver_data and ubq->flags are likely to both be cache misses
on a ublk server thread servicing many queues. req->mq_hctx is
probably a hit as it's in the same cache line as req->cmd_flags
accessed just before in ublk_ch_uring_cmd_local() for the req_op(req)
=3D=3D REQ_OP_ZONE_APPEND check. It would be nice to avoid these
additional dereferences, can we prevent queue_rq_affinity_store() from
setting rq_affinity to a value other than 0 if
UBLK_F_SUPPORT_RQ_AFFINITY isn't enabled? Perhaps indicated via a new
BLK_FEAT_SUPPORTS_RQ_AFFINITY flag in struct queue_limits's features
field?

Best,
Caleb

>         unsigned int unmapped_bytes;
>         blk_status_t res =3D BLK_STS_OK;
> -       bool requeue;
>
>         /* failed read IO if nothing is read */
>         if (!io->res && req_op(req) =3D=3D REQ_OP_READ)
> @@ -1568,7 +1631,7 @@ static inline void __ublk_complete_rq(struct reques=
t *req, struct ublk_io *io,
>
>         /* shmem zero copy: no data to unmap, pages already shared */
>         if (!need_map || !ublk_need_unmap_req(req) ||
> -           ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
> +           ublk_iod_is_shmem_zc(ubq, req->tag))
>                 goto exit;
>
>         /* for READ request, writing data in iod->addr to rq buffers */
> @@ -1582,31 +1645,18 @@ static inline void __ublk_complete_rq(struct requ=
est *req, struct ublk_io *io,
>         if (unlikely(unmapped_bytes < io->res)) {
>                 if (unlikely(!unmapped_bytes)) {
>                         res =3D BLK_STS_IOERR;
> +                       io->res =3D -EIO;
>                         goto exit;
>                 }
>
>                 io->res =3D unmapped_bytes;
>         }
>
> -       /*
> -        * Run bio->bi_end_io() with softirqs disabled. If the final fput
> -        * happens off this path, then that will prevent ublk's blkdev_re=
lease()
> -        * from being called on current's task work, see fput() implement=
ation.
> -        *
> -        * Otherwise, ublk server may not provide forward progress in cas=
e of
> -        * reading the partition table from bdev_open() with disk->open_m=
utex
> -        * held, and causes dead lock as we could already be holding
> -        * disk->open_mutex here.
> -        *
> -        * Preferably we would not be doing IO with a mutex held that is =
also
> -        * used for release, but this work-around will suffice for now.
> -        */
> -       local_bh_disable();
> -       requeue =3D blk_update_request(req, BLK_STS_OK, io->res);
> -       local_bh_enable();
> -       if (requeue)
> -               blk_mq_requeue_request(req, true);
> -       else if (likely(!blk_should_fake_timeout(req->q))) {
> +       if (ublk_support_rq_affinity(ubq) && blk_mq_complete_request_remo=
te(req))
> +               return;
> +
> +       if (!ublk_update_and_requeue(req, io) &&
> +           likely(!blk_should_fake_timeout(req->q))) {
>                 if (blk_mq_add_to_batch(req, iob, false, blk_mq_end_reque=
st_batch))
>                         return;
>                 __blk_mq_end_request(req, BLK_STS_OK);
> @@ -1614,6 +1664,8 @@ static inline void __ublk_complete_rq(struct reques=
t *req, struct ublk_io *io,
>
>         return;
>  exit:
> +       if (ublk_support_rq_affinity(ubq) && blk_mq_complete_request_remo=
te(req))
> +               return;
>         ublk_end_request(req, res);
>  }
>
> @@ -2347,6 +2399,7 @@ static const struct blk_mq_ops ublk_mq_ops =3D {
>         .queue_rqs      =3D ublk_queue_rqs,
>         .init_hctx      =3D ublk_init_hctx,
>         .timeout        =3D ublk_timeout,
> +       .complete       =3D ublk_end_rq,
>  };
>
>  static const struct blk_mq_ops ublk_batch_mq_ops =3D {
> @@ -2355,6 +2408,7 @@ static const struct blk_mq_ops ublk_batch_mq_ops =
=3D {
>         .queue_rqs      =3D ublk_batch_queue_rqs,
>         .init_hctx      =3D ublk_init_hctx,
>         .timeout        =3D ublk_timeout,
> +       .complete       =3D ublk_end_rq,
>  };
>
>  static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue =
*ubq)
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 33b25dd13965..47b5fba9519c 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -420,6 +420,14 @@ struct ublk_shmem_buf_reg {
>  /* ublksrv_io_desc size is specified by ublksrv_ctrl_dev_info's io_desc_=
size */
>  #define UBLK_F_IO_DESC_SIZE (1ULL << 20)
>
> +/*
> + * Request completion honors the block device's rq_affinity setting
> + * (/sys/block/ublkbN/queue/rq_affinity): the submitting CPU's completio=
n
> + * work can run there instead of always on the ublk server's CPU. Withou=
t
> + * this feature, rq_affinity has no effect on ublk devices.
> + */
> +#define UBLK_F_SUPPORT_RQ_AFFINITY (1ULL << 21)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.50.1 (Apple Git-155)
>

Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3242222CC
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520612; cv=none; b=BkVyGQhAfUCD60sWqLrcZ8mM6u/3bbWgIqsfTAUL3dyzCVGnYiUFPpdx7WNmC0sDq3nKSXSB91et3x49O66bi11+SHvRFQWaL1pSUZ7eemKpAagIVAurmHi9wtZNcfAzod1dwwf8K4py5dca9v60PNwax9pGDuc994GXs6nAfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520612; c=relaxed/simple;
	bh=XnlToCVLBVfALsAcph2BRoEEarLdcrBhPqOXn2yOKHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EADEA/rwwh4zDJT23AGt+gQu/yTi2ct1iwHR80NWzINOoVkbyEZDWvjNNTEsyR8Gh117FcuDwRgEwxf8PhWULG/cAk2aCn+/TcuMaj5kppRAof+73n3rt9hdMEY4qbECfKbiAVwQFNOqiDFVYYi/dVZv31f1YFNyynV61sf/BF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KtfUXBoh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KtfUXBoh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340bb45e37cso1112550a91.3
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 18:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763520610; x=1764125410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AKzwRi5oxkZsIkHfTk9+hP8CEAe1p3dwCSqzY+cWrU=;
        b=KtfUXBohCOoRYQwkTR/cVd32hFy8p4jijXKPpzpf8l+2MalbjvcJl49165y6RLp/VV
         homAUt0LG+BVqnxN30Lud99OONgAnQBJiFAtxe/V3fjq3BpYOLrZ5azw2Mobt7aUMiKa
         xksXT/ce0EFwwHycHCnaKmkk4ib0OWeigY2ZDltsR19gqJqq+CdKWr5G8s6HO+84gsV/
         D1+AxhURN1mDmzWQ3cx+lBPqeju6YP48pG7aBA7WoqOaJXduHTTF0M1Ce32uMga3m/tq
         fBDDYpL+sssxeMYhGJUhtR1BqZVmTYqM27FBWf/bbzU19IB9hS9lvU2kyL03Xqad5lGL
         Vlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520610; x=1764125410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9AKzwRi5oxkZsIkHfTk9+hP8CEAe1p3dwCSqzY+cWrU=;
        b=vQ5jisvt70h6esGAj2FkEo4Ot3BPbWJueo+1tiwk0vNZX9ITAGlj5IOyckR/GuhuJS
         ICCyLYNyvJL0nk6h9qccOqI9FsfApbzuZ32wZOwSTbXxvWWe5i1rWHezBmnPweBvpnqh
         tggyb7WZvSTYMdwe9W94SFc4ogrjGthFm7lg0a0pGRQvm0IN0zIb7a7+sOyqF/CpqODB
         UErT1EyXdupg0Sf+L7PWZPua6zqs3AwAzZppFx3fCsuNoPW75o/vPTdzQi0FSBtc8ovO
         /ol58btBxPEEN5LqdkbqRsOo598BDFOpwSQHUtfVSHXh0Y/nrWwU0oANIb8lOxjtQtTg
         lZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9AqPCQ3FsdarvuVK8mAiUklZdo9Mj/hIF3g9tXs9Xc2M3GgmNtnMKAw3Gq82OxRx2/9RX5VTbcr4taA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaigtZXcL3QPoY8Rr2MTF6uslF4Q2bB2yxqMImTKDO6+H0pn/
	OuZgnGdKBfLD+hPGbfMb3TSUA1Hz2LnfYHFWVYUH2bljARME9VsO+BNzobeUsWQnkPnpVgS9KeP
	zogV3zSfrGEQMDhfiGKwIj9YKZwANolpWyBvVDB5qfw==
X-Gm-Gg: ASbGncvOEmdTmTHO8EHjo05aT1KUuSqTtw7b8TmVp9ZXkSk9sfPwD7NH/V1lz0GL3/C
	QrU3zknHdD+QJTLp+9cPjtMgTheQ25OvAdz4qGPh+xDjUy5hxUKRwrGDz+B92Tr6ed6ew9biX1p
	jDoX3aQ4dsVNOo1kBLQIFD1pvHlxv+s03g4X9ZO56qBGXN1TiuUSpxyOPxL8tyWJ25cMsMSGqIn
	A9A1z9bJLndnwFIJwQdS5pyDjFnU4GIXHptUp/sRwCuHx9J1XqTHGmNguQS9yVQ8QuTZ8Ep71/H
	jZ7YRYzlp/mNAM2hFA==
X-Google-Smtp-Source: AGHT+IFhMLltjs9jjjMC/jey5TeCiv6uHHimRNzAyoNp/bV2JsNEbfMoLmUO3YYvIBMO5Yc4nMK5G9r3Zx59ueUNa/0=
X-Received: by 2002:a05:7022:2217:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11c79421cb9mr1753178c88.2.1763520609648; Tue, 18 Nov 2025
 18:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-11-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-11-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Nov 2025 18:49:57 -0800
X-Gm-Features: AWmQ_bn7UX0rX35NeET9RVppnWeTHvuapLQLaWlPctvCR0ZCMFhzpBsvbWaLvag
Message-ID: <CADUfDZr88twJJLTJ0bx-OP4Rz54hF9enuw=8vYkPuhzOab1rEQ@mail.gmail.com>
Subject: Re: [PATCH V3 10/27] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS command=
,
> which allows userspace to prepare a batch of I/O requests.
>
> The core of this change is the `ublk_walk_cmd_buf` function, which iterat=
es
> over the elements in the uring_cmd fixed buffer. For each element, it par=
ses
> the I/O details, finds the corresponding `ublk_io` structure, and prepare=
s it
> for future dispatch.
>
> Add per-io lock for protecting concurrent delivery and committing.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 205 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |   5 +
>  2 files changed, 209 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 5f9d7ec9daa4..84d838df18cb 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -117,6 +117,7 @@ struct ublk_batch_io_data {
>         struct ublk_device *ub;
>         struct io_uring_cmd *cmd;
>         struct ublk_batch_io header;
> +       unsigned int issue_flags;
>  };
>
>  /*
> @@ -201,6 +202,7 @@ struct ublk_io {
>         unsigned task_registered_buffers;
>
>         void *buf_ctx_handle;
> +       spinlock_t lock;
>  } ____cacheline_aligned_in_smp;
>
>  struct ublk_queue {
> @@ -270,6 +272,16 @@ static inline bool ublk_dev_support_batch_io(const s=
truct ublk_device *ub)
>         return false;
>  }
>
> +static inline void ublk_io_lock(struct ublk_io *io)
> +{
> +       spin_lock(&io->lock);
> +}
> +
> +static inline void ublk_io_unlock(struct ublk_io *io)
> +{
> +       spin_unlock(&io->lock);
> +}
> +
>  static inline struct ublksrv_io_desc *
>  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
>  {
> @@ -2531,6 +2543,183 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd, unsigned int issue_flags)
>         return ublk_ch_uring_cmd_local(cmd, issue_flags);
>  }
>
> +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
> +                                       const struct ublk_elem_header *el=
em)
> +{
> +       const void *buf =3D elem;
> +
> +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> +               return *(__u64 *)(buf + sizeof(*elem));
> +       return 0;
> +}
> +
> +static struct ublk_auto_buf_reg
> +ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> +                       const struct ublk_elem_header *elem)
> +{
> +       struct ublk_auto_buf_reg reg =3D {
> +               .index =3D elem->buf_index,
> +               .flags =3D (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FALLBAC=
K) ?
> +                       UBLK_AUTO_BUF_REG_FALLBACK : 0,
> +       };
> +
> +       return reg;
> +}
> +
> +/*
> + * 48 can hold any type of buffer element(8, 16 and 24 bytes) because
> + * it is the least common multiple(LCM) of 8, 16 and 24
> + */
> +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> +struct ublk_batch_io_iter {
> +       /* copy to this buffer from iterator first */
> +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> +       struct iov_iter iter;
> +       unsigned done, total;
> +       unsigned char elem_bytes;
> +};
> +
> +static inline int
> +__ublk_walk_cmd_buf(struct ublk_queue *ubq,
> +                   struct ublk_batch_io_iter *iter,
> +                   const struct ublk_batch_io_data *data,
> +                   unsigned bytes,
> +                   int (*cb)(struct ublk_queue *q,
> +                           const struct ublk_batch_io_data *data,
> +                           const struct ublk_elem_header *elem))
> +{
> +       int i, ret =3D 0;

unsigned i to avoid comparisons between signed and unsigned values?

> +
> +       for (i =3D 0; i < bytes; i +=3D iter->elem_bytes) {
> +               const struct ublk_elem_header *elem =3D
> +                       (const struct ublk_elem_header *)&iter->buf[i];
> +
> +               if (unlikely(elem->tag >=3D data->ub->dev_info.queue_dept=
h)) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               ret =3D cb(ubq, data, elem);
> +               if (unlikely(ret))
> +                       break;
> +       }
> +
> +       /* revert unhandled bytes in case of failure */
> +       if (ret)
> +               iov_iter_revert(&iter->iter, bytes - i);
> +
> +       iter->done +=3D i;
> +       return ret;
> +}
> +
> +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> +                            const struct ublk_batch_io_data *data,
> +                            int (*cb)(struct ublk_queue *q,
> +                                    const struct ublk_batch_io_data *dat=
a,
> +                                    const struct ublk_elem_header *elem)=
)
> +{
> +       struct ublk_queue *ubq =3D ublk_get_queue(data->ub, data->header.=
q_id);
> +       int ret =3D 0;
> +
> +       while (iter->done < iter->total) {
> +               unsigned int len =3D min(sizeof(iter->buf), iter->total -=
 iter->done);
> +
> +               ret =3D copy_from_iter(iter->buf, len, &iter->iter);

Would make more sense to store this as an unsigned value.

> +               if (ret !=3D len) {
> +                       pr_warn("ublk%d: read batch cmd buffer failed %u/=
%u\n",
> +                                       data->ub->dev_info.dev_id, ret, l=
en);
> +                       ret =3D -EINVAL;
> +                       break;

Just return -EINVAL?

> +               }
> +
> +               ret =3D __ublk_walk_cmd_buf(ubq, iter, data, len, cb);
> +               if (ret)
> +                       break;

Just return ret?

> +       }
> +       return ret;
> +}
> +
> +static int ublk_batch_unprep_io(struct ublk_queue *ubq,
> +                               const struct ublk_batch_io_data *data,
> +                               const struct ublk_elem_header *elem)
> +{
> +       struct ublk_io *io =3D &ubq->ios[elem->tag];
> +
> +       data->ub->nr_io_ready--;
> +       ublk_io_lock(io);
> +       io->flags =3D 0;
> +       ublk_io_unlock(io);
> +       return 0;
> +}
> +
> +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *iter,
> +                                      const struct ublk_batch_io_data *d=
ata)
> +{
> +       int ret;
> +
> +       if (!iter->done)
> +               return;
> +
> +       iov_iter_revert(&iter->iter, iter->done);
> +       iter->total =3D iter->done;
> +       iter->done =3D 0;
> +
> +       ret =3D ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
> +       WARN_ON_ONCE(ret);
> +}
> +
> +static int ublk_batch_prep_io(struct ublk_queue *ubq,
> +                             const struct ublk_batch_io_data *data,
> +                             const struct ublk_elem_header *elem)
> +{
> +       struct ublk_io *io =3D &ubq->ios[elem->tag];
> +       const struct ublk_batch_io *uc =3D &data->header;
> +       union ublk_io_buf buf =3D { 0 };
> +       int ret;
> +
> +       if (ublk_dev_support_auto_buf_reg(data->ub))
> +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, elem);
> +       else if (ublk_dev_need_map_io(data->ub)) {
> +               buf.addr =3D ublk_batch_buf_addr(uc, elem);
> +
> +               ret =3D ublk_check_fetch_buf(data->ub, buf.addr);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ublk_io_lock(io);
> +       ret =3D __ublk_fetch(data->cmd, data->ub, io);
> +       if (!ret)
> +               io->buf =3D buf;
> +       ublk_io_unlock(io);
> +
> +       return ret;
> +}
> +
> +static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *d=
ata)
> +{
> +       const struct ublk_batch_io *uc =3D &data->header;
> +       struct io_uring_cmd *cmd =3D data->cmd;
> +       struct ublk_batch_io_iter iter =3D {
> +               .total =3D uc->nr_elem * uc->elem_bytes,
> +               .elem_bytes =3D uc->elem_bytes,
> +       };
> +       int ret;
> +
> +       ret =3D io_uring_cmd_import_fixed(cmd->sqe->addr, iter.total,

sqe-> addr should be accessed with READ_ONCE() since it may point to
user-mapped memory.

> +                       WRITE, &iter.iter, cmd, data->issue_flags);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&data->ub->mutex);
> +       ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> +
> +       if (ret && iter.done)
> +               ublk_batch_revert_prep_cmd(&iter, data);

Mentioned this on V1 as well, but the iter.done check is duplicated in
ublk_batch_revert_prep_cmd().

Best,
Caleb

> +       mutex_unlock(&data->ub->mutex);
> +       return ret;
> +}
> +
>  static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
>  {
>         const u16 mask =3D UBLK_BATCH_F_HAS_BUF_ADDR | UBLK_BATCH_F_HAS_Z=
ONE_LBA;
> @@ -2609,6 +2798,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>                         .nr_elem =3D READ_ONCE(uc->nr_elem),
>                         .elem_bytes =3D READ_ONCE(uc->elem_bytes),
>                 },
> +               .issue_flags =3D issue_flags,
>         };
>         u32 cmd_op =3D cmd->cmd_op;
>         int ret =3D -EINVAL;
> @@ -2618,6 +2808,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
ing_cmd *cmd,
>
>         switch (cmd_op) {
>         case UBLK_U_IO_PREP_IO_CMDS:
> +               ret =3D ublk_check_batch_cmd(&data);
> +               if (ret)
> +                       goto out;
> +               ret =3D ublk_handle_batch_prep_cmd(&data);
> +               break;
>         case UBLK_U_IO_COMMIT_IO_CMDS:
>                 ret =3D ublk_check_batch_cmd(&data);
>                 if (ret)
> @@ -2792,7 +2987,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         struct ublk_queue *ubq;
>         struct page *page;
>         int numa_node;
> -       int size;
> +       int size, i;
>
>         /* Determine NUMA node based on queue's CPU affinity */
>         numa_node =3D ublk_get_queue_numa_node(ub, q_id);
> @@ -2817,6 +3012,9 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         }
>         ubq->io_cmd_buf =3D page_address(page);
>
> +       for (i =3D 0; i < ubq->q_depth; i++)
> +               spin_lock_init(&ubq->ios[i].lock);
> +
>         ub->queues[q_id] =3D ubq;
>         ubq->dev =3D ub;
>         return 0;
> @@ -3043,6 +3241,11 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>                 return -EINVAL;
>
>         mutex_lock(&ub->mutex);
> +       /* device may become not ready in case of F_BATCH */
> +       if (!ublk_dev_ready(ub)) {
> +               ret =3D -EINVAL;
> +               goto out_unlock;
> +       }
>         if (ub->dev_info.state =3D=3D UBLK_S_DEV_LIVE ||
>             test_bit(UB_STATE_USED, &ub->state)) {
>                 ret =3D -EEXIST;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 2ce5a496b622..c96c299057c3 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -102,6 +102,11 @@
>         _IOWR('u', 0x23, struct ublksrv_io_cmd)
>  #define        UBLK_U_IO_UNREGISTER_IO_BUF     \
>         _IOWR('u', 0x24, struct ublksrv_io_cmd)
> +
> +/*
> + * return 0 if the command is run successfully, otherwise failure code
> + * is returned
> + */
>  #define        UBLK_U_IO_PREP_IO_CMDS  \
>         _IOWR('u', 0x25, struct ublk_batch_io)
>  #define        UBLK_U_IO_COMMIT_IO_CMDS        \
> --
> 2.47.0
>

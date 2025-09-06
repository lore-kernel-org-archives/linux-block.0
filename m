Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEFA10E0
	for <linux-block@vger.kernel.org>; Sat,  6 Sep 2025 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757188137; cv=none; b=krwx1Cgd2Mn/dhu+eHgQpNIqFcpxHFNnTBPGW//zthkJ6ZB6kvEbkWOKG4iQw+1JaVL3vC5irJhVrv4L+7mPXAzRp9DDz2+hzq4gVW6Ff/qdDyoIrjUrzvybxomPR3+iMgf7lwuvn+PUfSuCwyTGpgZyn44QeUT7Wy6UgdewRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757188137; c=relaxed/simple;
	bh=zqzmSMtqrFeoSw/8Zcbxcs3VlsrPZ2shx8Qh3C2rz7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3r5WYp+dJFeaXx92Pr5bmy9sYxfomz8nfYufInjrHZDCkGPg4LysrkIJ4ROqaaFv/ReAU05dwT5SyPW6aAVFzEoDIBY6dE3mf1BPtXGiTlkSkSG1VJSqh9WBOCyi8ObuSFJWHk4H7DQalyY5O3iCtYe3zzzz97zmddg/0fQCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A1CGwDrw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A1CGwDrw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b157ba91bso6919745ad.3
        for <linux-block@vger.kernel.org>; Sat, 06 Sep 2025 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757188134; x=1757792934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxDliOWCiDTRaL3TxgQSsNhCs21HBURcRYAP0k3/idE=;
        b=A1CGwDrwUPfmJ0FgyZ5nbtaKa46uEBsKzqPa+kkR2dDwRtY9CR9zKyS0UZAg9rHOGa
         OH765ZXY4FRQ6LlKx+QJkggpWAoS0HSG9M0eI+NFJSo/mC740k7w0MUiuGMBxXF1QgM8
         bsqzc3uxHEaJtE7s5mD7wEb536m/Ic6TPTZyY++WyVPmmPl4Ea4Piwm0Buipd9jIiu8I
         h5H+Hnk41NL8JEl/F4tHi8SegbJXPA78n3qogPsIcPSrnAaZmzhQtxfGIPN/TfFSaan1
         LqZnLDlT+WLt5xYrBPCR/Idv8xpSAwPTrXiaQYwl6869t3QT4E1Vqufe60hpfnn6thBR
         W/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757188134; x=1757792934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxDliOWCiDTRaL3TxgQSsNhCs21HBURcRYAP0k3/idE=;
        b=RScoxdgoIrl99fv//jqJX7JgNZEB3Az4iK5H2l7uTLc0snEdB1TsnQULGtXoOOfvES
         13h5cTO9eA0aO/v/ytCLCzhM58JSM1lU3g+dCTxrCeO7t6irE0z08HCxBWrPpEfNa6Wc
         BwMp8GGt7oGw4fkrvt2tCldYrrM9VAuC/Q9qR1xXQR9TX+9CFin4wFGzxmq0teFvzcUm
         dx2KCH9aALsRocHp5yfuLpFxAatkH2JgswMaCssegT1e2Fs1Puln+b9szZbVdzx3gxuh
         FK5atKiqXPZ2qoi/8hdMUXr93UCb1hTttelTxvJwnIq9akkOUn/Doi4UIuh6kOqOdESg
         kGqg==
X-Forwarded-Encrypted: i=1; AJvYcCUOFBZvU1MQYsaMmBKvxun40j9yEmElde4aGHcHCrAxnHZr05gWcPoSNR+rufLsEXBLSy6RXqcq6qS+bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqaYs8+u8CseUNyYoMmlkm5Flxp2o+UcQ+aqAl8+wL5udu39YL
	5A+aRqnZkS8SIAEo661cR+Kaac9gzSGfj8WFw4gzUUASunJSHRMYMG5e2cy89NTpSuweleE3Edj
	imrDMTA/5g9w9BQzr4YhNxz+O12DQbzfJ5ySERhlUMw==
X-Gm-Gg: ASbGncumcDGT86kOLcMLc0R4Tt05fVw1DkWePrNlSMwj8SWMgYjwH63any8qm97m5rw
	qGoc2TaEcYgFGN8BakrUcDpJuBWI4CpoYIbqnDNGiUCVuv0WA3nKzovFKvItKn6Y9yWa/7oxTaP
	JReki9JgrkwMY1qrfHtB7WHg7pKS2QLxs+jpWBRJeiDdpjCTXOd6E7Ib08yNEDyuXVnsBGTdb+1
	Hkv6rtiI3ecKnOT6LC6CfM=
X-Google-Smtp-Source: AGHT+IEV0zJASXHWvy4M7DV1zpz+mAKUfeF/LPNzXJJsnvR6DehOO9OQ6LedGvnrqqicFU+R15kwKjNOOyPpi4xKtZE=
X-Received: by 2002:a17:90b:3e83:b0:32b:92d7:5cb2 with SMTP id
 98e67ed59e1d1-32d43ef7100mr2531550a91.1.1757188134230; Sat, 06 Sep 2025
 12:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-9-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-9-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 6 Sep 2025 12:48:41 -0700
X-Gm-Features: Ac12FXxshe1yj7q-YrOLrJAZzSxPIC8pV65dUiqNFhszNFK8lrJXQTbVwDkvkYQ
Message-ID: <CADUfDZr6QLHHaM=LJfRKXKGyE+2Emzhvkab53Yen1Cyinp21hg@mail.gmail.com>
Subject: Re: [PATCH 08/23] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
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
>  drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |   5 +
>  2 files changed, 195 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4da0dbbd7e16..a4bae3d1562a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -116,6 +116,10 @@ struct ublk_uring_cmd_pdu {
>  struct ublk_batch_io_data {
>         struct ublk_queue *ubq;
>         struct io_uring_cmd *cmd;
> +       unsigned int issue_flags;
> +
> +       /* set when walking the element buffer */
> +       const struct ublk_elem_header *elem;
>  };
>
>  /*
> @@ -200,6 +204,7 @@ struct ublk_io {
>         unsigned task_registered_buffers;
>
>         void *buf_ctx_handle;
> +       spinlock_t lock;

From our experience writing a high-throughput ublk server, the
spinlocks and mutexes in the kernel are some of the largest CPU
hotspots. We have spent a lot of effort working to avoid locking where
possible or shard data structures to reduce contention on the locks.
Even uncontended locks are still very expensive to acquire and release
on machines with many CPUs due to the cache coherency overhead. ublk's
per-io daemon architecture is great for performance by removing the
need for locks in the I/O path. I can't really see us adopting this
ublk batching feature; adding a spin_lock() + spin_unlock() to every
ublk commit operation is not worth the reduction in io_uring SQEs and
uring_cmds.

>  } ____cacheline_aligned_in_smp;
>
>  struct ublk_queue {
> @@ -276,6 +281,16 @@ static inline bool ublk_support_batch_io(const struc=
t ublk_queue *ubq)
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
> @@ -2538,6 +2553,171 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd, unsigned int issue_flags)
>         return ublk_ch_uring_cmd_local(cmd, issue_flags);
>  }
>
> +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
> +                                       const struct ublk_elem_header *el=
em)
> +{
> +       const void *buf =3D (const void *)elem;

Don't need an explicit cast in order to cast to void *.


> +
> +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> +               return *(__u64 *)(buf + sizeof(*elem));
> +       return -1;

Why -1 and not 0? ublk_check_fetch_buf() is expecting a 0 buf_addr to
indicate the lack

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
> +/* 48 can cover any type of buffer element(8, 16 and 24 bytes) */

"can cover" is a bit vague. Can you be explicit that the buffer size
needs to be a multiple of any possible buffer element size?

> +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> +struct ublk_batch_io_iter {
> +       /* copy to this buffer from iterator first */
> +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> +       struct iov_iter iter;
> +       unsigned done, total;
> +       unsigned char elem_bytes;
> +};
> +
> +static int __ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> +                               struct ublk_batch_io_data *data,
> +                               unsigned bytes,
> +                               int (*cb)(struct ublk_io *io,
> +                                       const struct ublk_batch_io_data *=
data))
> +{
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < bytes; i +=3D iter->elem_bytes) {
> +               const struct ublk_elem_header *elem =3D
> +                       (const struct ublk_elem_header *)&iter->buf[i];
> +               struct ublk_io *io;
> +
> +               if (unlikely(elem->tag >=3D data->ubq->q_depth)) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               io =3D &data->ubq->ios[elem->tag];
> +               data->elem =3D elem;
> +               ret =3D cb(io, data);

Why not just pas elem as a separate argument to the callback?

> +               if (unlikely(ret))
> +                       break;
> +       }
> +       iter->done +=3D i;
> +       return ret;
> +}
> +
> +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> +                            struct ublk_batch_io_data *data,
> +                            int (*cb)(struct ublk_io *io,
> +                                    const struct ublk_batch_io_data *dat=
a))
> +{
> +       int ret =3D 0;
> +
> +       while (iter->done < iter->total) {
> +               unsigned int len =3D min(sizeof(iter->buf), iter->total -=
 iter->done);
> +
> +               ret =3D copy_from_iter(iter->buf, len, &iter->iter);
> +               if (ret !=3D len) {

How would this be possible? The iterator comes from an io_uring
registered buffer with at least the requested length, so the user
addresses should have been validated when the buffer was registered.
Should this just be a WARN_ON()?

> +                       pr_warn("ublk%d: read batch cmd buffer failed %u/=
%u\n",
> +                                       data->ubq->dev->dev_info.dev_id, =
ret, len);
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               ret =3D __ublk_walk_cmd_buf(iter, data, len, cb);
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
> +static int ublk_batch_unprep_io(struct ublk_io *io,
> +                               const struct ublk_batch_io_data *data)
> +{
> +       if (ublk_queue_ready(data->ubq))
> +               data->ubq->dev->nr_queues_ready--;
> +
> +       ublk_io_lock(io);
> +       io->flags =3D 0;
> +       ublk_io_unlock(io);
> +       data->ubq->nr_io_ready--;
> +       return 0;

This "unprep" looks very subtle and fairly complicated. Is it really
necessary? What's wrong with leaving the I/Os that were successfully
prepped? It also looks racy to clear io->flags after the queue is
ready, as the io may already be in use by some I/O request.

> +}
> +
> +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *iter,
> +                                      struct ublk_batch_io_data *data)
> +{
> +       int ret;
> +
> +       if (!iter->done)
> +               return;
> +
> +       iov_iter_revert(&iter->iter, iter->done);

Shouldn't the iterator be reverted by the total number of bytes
copied, which may be more than iter->done?

> +       iter->total =3D iter->done;
> +       iter->done =3D 0;
> +
> +       ret =3D ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
> +       WARN_ON_ONCE(ret);
> +}
> +
> +static int ublk_batch_prep_io(struct ublk_io *io,
> +                             const struct ublk_batch_io_data *data)
> +{
> +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(data->cmd->sq=
e);
> +       union ublk_io_buf buf =3D { 0 };
> +       int ret;
> +
> +       if (ublk_support_auto_buf_reg(data->ubq))
> +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, data->elem);
> +       else if (ublk_need_map_io(data->ubq)) {
> +               buf.addr =3D ublk_batch_buf_addr(uc, data->elem);
> +
> +               ret =3D ublk_check_fetch_buf(data->ubq, buf.addr);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ublk_io_lock(io);
> +       ret =3D __ublk_fetch(data->cmd, data->ubq, io);
> +       if (!ret)
> +               io->buf =3D buf;
> +       ublk_io_unlock(io);
> +
> +       return ret;
> +}
> +
> +static int ublk_handle_batch_prep_cmd(struct ublk_batch_io_data *data)
> +{
> +       struct io_uring_cmd *cmd =3D data->cmd;
> +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(cmd->sqe);
> +       struct ublk_batch_io_iter iter =3D {
> +               .total =3D uc->nr_elem * uc->elem_bytes,
> +               .elem_bytes =3D uc->elem_bytes,
> +       };
> +       int ret;
> +
> +       ret =3D io_uring_cmd_import_fixed(cmd->sqe->addr, cmd->sqe->len,

Could iter.total be used in place of cmd->sqe->len? That way userspace
wouldn't have to specify a redundant value in the SQE len field.

> +                       WRITE, &iter.iter, cmd, data->issue_flags);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&data->ubq->dev->mutex);
> +       ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> +
> +       if (ret && iter.done)
> +               ublk_batch_revert_prep_cmd(&iter, data);

The iter.done check is duplicated in ublk_batch_revert_prep_cmd().

> +       mutex_unlock(&data->ubq->dev->mutex);
> +       return ret;
> +}
> +
>  static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
>  {
>         const unsigned short mask =3D UBLK_BATCH_F_HAS_BUF_ADDR |
> @@ -2609,6 +2789,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>         struct ublk_device *ub =3D cmd->file->private_data;
>         struct ublk_batch_io_data data =3D {
>                 .cmd =3D cmd,
> +               .issue_flags =3D issue_flags,
>         };
>         u32 cmd_op =3D cmd->cmd_op;
>         int ret =3D -EINVAL;
> @@ -2619,6 +2800,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
ing_cmd *cmd,
>
>         switch (cmd_op) {
>         case UBLK_U_IO_PREP_IO_CMDS:
> +               ret =3D ublk_check_batch_cmd(&data, uc);
> +               if (ret)
> +                       goto out;
> +               ret =3D ublk_handle_batch_prep_cmd(&data);
> +               break;
>         case UBLK_U_IO_COMMIT_IO_CMDS:
>                 ret =3D ublk_check_batch_cmd(&data, uc);
>                 if (ret)
> @@ -2780,7 +2966,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
>         gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
>         void *ptr;
> -       int size;
> +       int size, i;
>
>         spin_lock_init(&ubq->cancel_lock);
>         ubq->flags =3D ub->dev_info.flags;
> @@ -2792,6 +2978,9 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         if (!ptr)
>                 return -ENOMEM;
>
> +       for (i =3D 0; i < ubq->q_depth; i++)
> +               spin_lock_init(&ubq->ios[i].lock);
> +
>         ubq->io_cmd_buf =3D ptr;
>         ubq->dev =3D ub;
>         return 0;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 01d3af52cfb4..38c8cc10d694 100644
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

Not sure this is really necessary to comment, that's pretty standard
for syscalls and uring_cmds.

Best,
Caleb

>  #define        UBLK_U_IO_PREP_IO_CMDS  \
>         _IOWR('u', 0x25, struct ublk_batch_io)
>  #define        UBLK_U_IO_COMMIT_IO_CMDS        \
> --
> 2.47.0
>

Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCB18DB0D
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445634; cv=none; b=MV7ZZqaEa9QBbcT0sWk0qJTHqpB7XJ8l/GpEi/ywRjgg411pHMPuIzrklGXcMMcMzZa0jpTJ7lj8lOZOxjKBDTciTjalGAUv9YAgEWB3rPW+K6XSPx/UiLuVKeBb2ncKD/sKxSDQBu4aVzGTLu9AJcDqS9cS6JGdfmPNILFz7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445634; c=relaxed/simple;
	bh=6bsVq7UapP8Tp3I09+rmtPRnmyVRKZ4tfZztBiqXLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtGssOKOyQxKuCMDxw2HdB2fJegqG98ksjHprGyrvyl559H21cC0h4ye+z2x7xIkLxQQGQoeOMqswQ3AvbMgAANtGHNf0S1S4U7z1c9LPHn+i1kPJBKZCHxyUxZ0ocQWUlw1aLOuuV+c0TKhARlep0GAd9p3pF2KoQIFdfPhc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BixTnBoq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BixTnBoq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297f2c718a8so5135765ad.3
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764445632; x=1765050432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXf+3zVaD6MrAMV7tqcum5KrFpSbiIQrYcV4qYRTCi8=;
        b=BixTnBoqilNN1wVyxfbCb3fDbE08zNYsB0dLLGZsrvYd/mhgfOwO67W2FFBRdPfn1+
         eCYIMMQUwm0XMgns/nWfXPj30ybwr+IfiXjEKTIELgmAwl7CEfgIS67QZMJ30eXen4ra
         eiLFkYIyXlitsVq1+39L+n5d1ca+Gqs32E2v5aLb/Hse+4uBHG0RNHts0WdlP+406pTx
         0kxyzlx4qihuAqJB61x3glYXoSN67WL5Ugne1UhNHNjMOba7K62Cx8DWrGt96h1FC6+F
         uiVpwJBGKczxyOOmafpKTal421DQOTxdmPs3p1O3yZQQzV/dBju7+9P0rXsaMzNykW9P
         MPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445632; x=1765050432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXf+3zVaD6MrAMV7tqcum5KrFpSbiIQrYcV4qYRTCi8=;
        b=vO6YatzWj+FLqGwatOApXkmm4XWTJfWTuZt1QKDhv49mrNCc6b+v7xE90DyjZCd5yZ
         Q/jwDgb1rmHETv85Tl+S5jTpMFGhlyMnuRF3H6h0Nu4wxx62oU1CUDi+8pYbPJQ8zqKq
         dEYnss4rsgA+KvH+fsW/9YMWOmywOq5ymg7B5ObQDaXmrBY7lrYFcAOCYTMsP33broFT
         LiJVPn9D101mrsG2j6TMBuX48GyxKo0tCQqh9UPEHUXFARp0Zit1C2ntW4aUFOrvKzWN
         5thWvjEIPZg1WbSqSVf9NGfilGF20rV88Sc7IWBAklSJ+ABZtuGlvSz7QbaSHMIdB2uF
         gbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOJsCr2PY9cKsT4b4tx1RqzNCMdRCATYtO/Noz3aNq9z0Jy1B/W4XvPvNbuR5K+0q68N6+xt6bpp6XJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gJ4FUzi0/EQKHByayXxVkjg7N6Hk4WJgTBMY0JT6m9vo707v
	LqR+YfP2uRZWtGFiK8puW+QTeP9TYxI4Zt091l2pidmhy13+OH61y9bms4eX029bb7ugwVWSR0Z
	+pXsrjs2QnVDvf1ktIHwNhh1AhhM4k4twF5ePH8d6Bg==
X-Gm-Gg: ASbGnctuKnOH+7+3oELMMeTyAgYTl+Emn3nACQHBKB524MwuioWkB02tDamLkAQ7+YT
	gstDBGevs+t/RTNdJ+4O0Wlmu7T5seG/oXkE5VUUwSTqteKuHhn7lF6unJP/TYHL/hvPH2qos1q
	gvyXn54b+0JMmzV8zOVdMkyVjFEUewNDgwkiRCHdgP2yDFaBAnZL/qwgrFi6gWQhPXqlfLAKWSe
	1j7TuXmoKHzr88kVYwhFmFgjG/el0yMnmNBaN5abyPqsU4VUyuymtGcTegkBDyrGJV9cIVQ
X-Google-Smtp-Source: AGHT+IFjXRgS8Lm20MOd3i7zvnjg80qalr7SZpp7KcdQS1YkBES/inSn2iYd9/Dj98vceyjVrhqHlbnlczSvE15Rmxc=
X-Received: by 2002:a05:7022:429e:b0:119:e56b:46b9 with SMTP id
 a92af1059eb24-11c9f3806d4mr19781283c88.3.1764445631910; Sat, 29 Nov 2025
 11:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-11-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-11-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 29 Nov 2025 11:47:00 -0800
X-Gm-Features: AWmQ_bk8aVLGNzpqKQfy2TIdOj6qkwJm6vd79ROkO68ZQ8-MkkMDHMaCGAWv6a8
Message-ID: <CADUfDZqqV05adB=ERn=CiaXfrPq8J5m1avOM2dChyyxpByerhQ@mail.gmail.com>
Subject: Re: [PATCH V4 10/27] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:59=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
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
>  drivers/block/ublk_drv.c      | 193 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |   5 +
>  2 files changed, 197 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 21890947ceec..66c77daae955 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -117,6 +117,7 @@ struct ublk_batch_io_data {
>         struct ublk_device *ub;
>         struct io_uring_cmd *cmd;
>         struct ublk_batch_io header;
> +       unsigned int issue_flags;

This looks unused in this commit. Move it to the previous commit
introducing struct ublk_batch_io_data, or the next commit that uses
issue_flags?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

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
> @@ -2531,6 +2543,171 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd =
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
> +       void __user *uaddr;
> +       unsigned done, total;
> +       unsigned char elem_bytes;
> +       /* copy to this buffer from user space */
> +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
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
> +       unsigned int i;
> +       int ret =3D 0;
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
> +               if (copy_from_user(iter->buf, iter->uaddr + iter->done, l=
en)) {
> +                       pr_warn("ublk%d: read batch cmd buffer failed\n",
> +                                       data->ub->dev_info.dev_id);
> +                       return -EFAULT;
> +               }
> +
> +               ret =3D __ublk_walk_cmd_buf(ubq, iter, data, len, cb);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
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
> +       /* Re-process only what we've already processed, starting from be=
ginning */
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
> +               .uaddr =3D u64_to_user_ptr(READ_ONCE(cmd->sqe->addr)),
> +               .total =3D uc->nr_elem * uc->elem_bytes,
> +               .elem_bytes =3D uc->elem_bytes,
> +       };
> +       int ret;
> +
> +       mutex_lock(&data->ub->mutex);
> +       ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> +
> +       if (ret && iter.done)
> +               ublk_batch_revert_prep_cmd(&iter, data);
> +       mutex_unlock(&data->ub->mutex);
> +       return ret;
> +}
> +
>  static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc)
>  {
>         unsigned elem_bytes =3D sizeof(struct ublk_elem_header);
> @@ -2587,6 +2764,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uri=
ng_cmd *cmd,
>                         .nr_elem =3D READ_ONCE(uc->nr_elem),
>                         .elem_bytes =3D READ_ONCE(uc->elem_bytes),
>                 },
> +               .issue_flags =3D issue_flags,
>         };
>         u32 cmd_op =3D cmd->cmd_op;
>         int ret =3D -EINVAL;
> @@ -2596,6 +2774,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_ur=
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
> @@ -2770,7 +2953,7 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         struct ublk_queue *ubq;
>         struct page *page;
>         int numa_node;
> -       int size;
> +       int size, i;
>
>         /* Determine NUMA node based on queue's CPU affinity */
>         numa_node =3D ublk_get_queue_numa_node(ub, q_id);
> @@ -2795,6 +2978,9 @@ static int ublk_init_queue(struct ublk_device *ub, =
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
> @@ -3021,6 +3207,11 @@ static int ublk_ctrl_start_dev(struct ublk_device =
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

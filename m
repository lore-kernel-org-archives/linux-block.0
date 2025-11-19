Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484F327BE6
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568562; cv=none; b=h4K6CTAn4J9X9r9Lyctm0OSo7wZ53wKymT15WdFx57uOD2hOMa1yDr/127EgkihJ6sAjmx8nAm/aXRAJNx7PmBGNKpQSFJ1Y85Ksqssf4XU186AanpfReVm5g/XYFk1jbqngET4FufWYsGdeeImgaDCrXBZp6Q+z3d3na7sPYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568562; c=relaxed/simple;
	bh=ZL5Kwfw0Hh6Qiu0Rt/a7+svaBaGytf6KOU4bVOPpdr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfwEmgWVCq8RCwVob1lsQF3ir2XgqFPy8HYatyU8Ane6mYgS92At+fTajOEyO77oAqEGmL9JPnRq9B1MHtVJJRekodBTIrCCUiJy/RstJ/NFviwXC68WxFCZ5gby4Y1XDzWLCGj+x++mRYZpu3OzRme+u34HwlvspbiEsqoxlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TbX7Ema1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TbX7Ema1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b997ae045b7so367745a12.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763568556; x=1764173356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fWl30Gfi9Cgp3E+qa9I701bNHskvxh1uXsBtFIDzFQ=;
        b=TbX7Ema1znOS0ckdkrdvcwmXtLdZivgdTTtKw0UCllWshP+C0gcqPiRqof1wtEtHIj
         +fwBfg9rEG7a7P4rAk0KzBx7aHxs8xHO+WWWFJ8feYSuphaRMzxfK+Wf63W4iqjELPvj
         6Zjphyc6DuJohk4aR/t9oucd8smT7zXcN+YACr2tACvcdOQsFK+Cli6eDe+muXPjZCr0
         TlsOFAfKksNrPzKS0UgOCihltAiUYIXmG2DxjbxQzteW9sS+pCzUf7+mb35GgU3cf7ec
         ZXWGHbtMnvlwIEsagUgkwxXIKf4BLGJHbyzWBxz2735nXC5BFX0fIoDHZgSpYNwRjdR9
         vfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568556; x=1764173356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fWl30Gfi9Cgp3E+qa9I701bNHskvxh1uXsBtFIDzFQ=;
        b=GPqAMWYAMhRsx8ILozIErx/f5lq3TvM4RD1Mk0UZXbtuAZpNiSMe0rIn9R+Llijdsr
         c+C7Owdsgj8QFzowQTQTU5LuENInzWXkXdjABekh52Bwam9KOatZgACy8LlQomM3a5Xr
         SXZM7ZwVv5CShFgJxZTRLaa6PjJ5/LYtCY6TOVULhXeMjcIU+n0hafmXekGVj0DCdkUN
         HZOdB0Vb/PcJV2BftnNtfH6w2Mzuk8puWR9x5sfg1oyALZ38rD0AINN/USZgZdjEQETk
         2CNfLSyw8ceRzAWNN+XLtBIN9bsexKGJajoO74zh5BJzEdU0y/oQ6rTlC5S/Tmj730y5
         GySw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJrWJwj2DoRRK7uGYfM2TACVa74oCYMLp/++JeCjQ7VzxHh0h0Pooe69tl7fti+WezHy41r53hW0Dug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5eNXHUNO37K/00o5G5J490gQGc2DixXvKNDkVbp9qUbbWgwS
	MDV2AlQ+R2jKtto15wGT6UyIv2us3+CqVZACnMeLVm+JX75GR6BeT1ih0igA0/nvw61kTqGOa19
	04oJoMjStZh8+VP68nNJLZBTU+0VTeWjOoNTNzoi7vQ==
X-Gm-Gg: ASbGncuj3wYalDNcWnx+hjxHs5GyVfqP+qwaaOOlquKf2Ud2uH38kXo+tmLb7G3RXOR
	fo28dRXWLN040crUghMinJk1HWIrNYcntzX9Xran7lHzx0lyxwtTT4cMGjdLYbbACTONCZYwNr4
	CSi5pk8w/OyUwtga965xyu3aGeJM0aSbsRFj1/W2RYicy8cExvS+gTLRQnIN+oiPHNijhCtkI5W
	FuGAs/8GVjLy1y+tJNYuw3wAOHh0PenoWHgTu4u400uIvxmf+M6D22jrDFJC6eIg6swwlfo
X-Google-Smtp-Source: AGHT+IHabhM/4gQGjO5hwyc+8FwQ3BmYGXinLF8UdIhvlm8FUbMA8zuFk8+Z1srjWqFEOzTJnYhvrCc31AaXVPIEeYE=
X-Received: by 2002:a05:7022:310:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-11c796b9796mr2318902c88.4.1763568555349; Wed, 19 Nov 2025
 08:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-11-ming.lei@redhat.com>
 <CADUfDZr88twJJLTJ0bx-OP4Rz54hF9enuw=8vYkPuhzOab1rEQ@mail.gmail.com> <aR2UPxAROdH09mv-@fedora>
In-Reply-To: <aR2UPxAROdH09mv-@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 19 Nov 2025 08:09:02 -0800
X-Gm-Features: AWmQ_blIBscVEFTTUt4BCjhcVqOnQw3JrDXeCLbQr0Wyk2yfEPB7JiCHvsETSsE
Message-ID: <CADUfDZpdvBeEdCposm_F56MFzUHQovJu6YMDzuqZSPYkoLiqQw@mail.gmail.com>
Subject: Re: [PATCH V3 10/27] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:56=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Nov 18, 2025 at 06:49:57PM -0800, Caleb Sander Mateos wrote:
> > On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS com=
mand,
> > > which allows userspace to prepare a batch of I/O requests.
> > >
> > > The core of this change is the `ublk_walk_cmd_buf` function, which it=
erates
> > > over the elements in the uring_cmd fixed buffer. For each element, it=
 parses
> > > the I/O details, finds the corresponding `ublk_io` structure, and pre=
pares it
> > > for future dispatch.
> > >
> > > Add per-io lock for protecting concurrent delivery and committing.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 205 ++++++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/ublk_cmd.h |   5 +
> > >  2 files changed, 209 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 5f9d7ec9daa4..84d838df18cb 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -117,6 +117,7 @@ struct ublk_batch_io_data {
> > >         struct ublk_device *ub;
> > >         struct io_uring_cmd *cmd;
> > >         struct ublk_batch_io header;
> > > +       unsigned int issue_flags;
> > >  };
> > >
> > >  /*
> > > @@ -201,6 +202,7 @@ struct ublk_io {
> > >         unsigned task_registered_buffers;
> > >
> > >         void *buf_ctx_handle;
> > > +       spinlock_t lock;
> > >  } ____cacheline_aligned_in_smp;
> > >
> > >  struct ublk_queue {
> > > @@ -270,6 +272,16 @@ static inline bool ublk_dev_support_batch_io(con=
st struct ublk_device *ub)
> > >         return false;
> > >  }
> > >
> > > +static inline void ublk_io_lock(struct ublk_io *io)
> > > +{
> > > +       spin_lock(&io->lock);
> > > +}
> > > +
> > > +static inline void ublk_io_unlock(struct ublk_io *io)
> > > +{
> > > +       spin_unlock(&io->lock);
> > > +}
> > > +
> > >  static inline struct ublksrv_io_desc *
> > >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> > >  {
> > > @@ -2531,6 +2543,183 @@ static int ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd, unsigned int issue_flags)
> > >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> > >  }
> > >
> > > +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *=
uc,
> > > +                                       const struct ublk_elem_header=
 *elem)
> > > +{
> > > +       const void *buf =3D elem;
> > > +
> > > +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> > > +               return *(__u64 *)(buf + sizeof(*elem));
> > > +       return 0;
> > > +}
> > > +
> > > +static struct ublk_auto_buf_reg
> > > +ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> > > +                       const struct ublk_elem_header *elem)
> > > +{
> > > +       struct ublk_auto_buf_reg reg =3D {
> > > +               .index =3D elem->buf_index,
> > > +               .flags =3D (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FAL=
LBACK) ?
> > > +                       UBLK_AUTO_BUF_REG_FALLBACK : 0,
> > > +       };
> > > +
> > > +       return reg;
> > > +}
> > > +
> > > +/*
> > > + * 48 can hold any type of buffer element(8, 16 and 24 bytes) becaus=
e
> > > + * it is the least common multiple(LCM) of 8, 16 and 24
> > > + */
> > > +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> > > +struct ublk_batch_io_iter {
> > > +       /* copy to this buffer from iterator first */
> > > +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> > > +       struct iov_iter iter;
> > > +       unsigned done, total;
> > > +       unsigned char elem_bytes;
> > > +};
> > > +
> > > +static inline int
> > > +__ublk_walk_cmd_buf(struct ublk_queue *ubq,
> > > +                   struct ublk_batch_io_iter *iter,
> > > +                   const struct ublk_batch_io_data *data,
> > > +                   unsigned bytes,
> > > +                   int (*cb)(struct ublk_queue *q,
> > > +                           const struct ublk_batch_io_data *data,
> > > +                           const struct ublk_elem_header *elem))
> > > +{
> > > +       int i, ret =3D 0;
> >
> > unsigned i to avoid comparisons between signed and unsigned values?
>
> OK.
>
> >
> > > +
> > > +       for (i =3D 0; i < bytes; i +=3D iter->elem_bytes) {
> > > +               const struct ublk_elem_header *elem =3D
> > > +                       (const struct ublk_elem_header *)&iter->buf[i=
];
> > > +
> > > +               if (unlikely(elem->tag >=3D data->ub->dev_info.queue_=
depth)) {
> > > +                       ret =3D -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               ret =3D cb(ubq, data, elem);
> > > +               if (unlikely(ret))
> > > +                       break;
> > > +       }
> > > +
> > > +       /* revert unhandled bytes in case of failure */
> > > +       if (ret)
> > > +               iov_iter_revert(&iter->iter, bytes - i);
> > > +
> > > +       iter->done +=3D i;
> > > +       return ret;
> > > +}
> > > +
> > > +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > +                            const struct ublk_batch_io_data *data,
> > > +                            int (*cb)(struct ublk_queue *q,
> > > +                                    const struct ublk_batch_io_data =
*data,
> > > +                                    const struct ublk_elem_header *e=
lem))
> > > +{
> > > +       struct ublk_queue *ubq =3D ublk_get_queue(data->ub, data->hea=
der.q_id);
> > > +       int ret =3D 0;
> > > +
> > > +       while (iter->done < iter->total) {
> > > +               unsigned int len =3D min(sizeof(iter->buf), iter->tot=
al - iter->done);
> > > +
> > > +               ret =3D copy_from_iter(iter->buf, len, &iter->iter);
> >
> > Would make more sense to store this as an unsigned value.
>
> OK.
>
> BTW, it has been changed to plain copy_from_user() in my local version by
> dropping fixed buffer for commit/prep ios command.
>
> There is also one big bug fix in patch 'ublk: add batch I/O dispatch infr=
astructure',
>
> Do you prefer to continuing to review on V3 or the coming V4?
>
> If you prefer to V4, I can prepare and send it soon.

Either is fine. Sorry I have been getting to these patches in my spare
time, so not sure I'll have time to review the whole series. But I'll
try to take a look at the latest version as time allows.

Best,
Caleb

>
> >
> > > +               if (ret !=3D len) {
> > > +                       pr_warn("ublk%d: read batch cmd buffer failed=
 %u/%u\n",
> > > +                                       data->ub->dev_info.dev_id, re=
t, len);
> > > +                       ret =3D -EINVAL;
> > > +                       break;
> >
> > Just return -EINVAL?
> >
> > > +               }
> > > +
> > > +               ret =3D __ublk_walk_cmd_buf(ubq, iter, data, len, cb)=
;
> > > +               if (ret)
> > > +                       break;
> >
> > Just return ret?
> >
> > > +       }
> > > +       return ret;
> > > +}
> > > +
> > > +static int ublk_batch_unprep_io(struct ublk_queue *ubq,
> > > +                               const struct ublk_batch_io_data *data=
,
> > > +                               const struct ublk_elem_header *elem)
> > > +{
> > > +       struct ublk_io *io =3D &ubq->ios[elem->tag];
> > > +
> > > +       data->ub->nr_io_ready--;
> > > +       ublk_io_lock(io);
> > > +       io->flags =3D 0;
> > > +       ublk_io_unlock(io);
> > > +       return 0;
> > > +}
> > > +
> > > +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *it=
er,
> > > +                                      const struct ublk_batch_io_dat=
a *data)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (!iter->done)
> > > +               return;
> > > +
> > > +       iov_iter_revert(&iter->iter, iter->done);
> > > +       iter->total =3D iter->done;
> > > +       iter->done =3D 0;
> > > +
> > > +       ret =3D ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
> > > +       WARN_ON_ONCE(ret);
> > > +}
> > > +
> > > +static int ublk_batch_prep_io(struct ublk_queue *ubq,
> > > +                             const struct ublk_batch_io_data *data,
> > > +                             const struct ublk_elem_header *elem)
> > > +{
> > > +       struct ublk_io *io =3D &ubq->ios[elem->tag];
> > > +       const struct ublk_batch_io *uc =3D &data->header;
> > > +       union ublk_io_buf buf =3D { 0 };
> > > +       int ret;
> > > +
> > > +       if (ublk_dev_support_auto_buf_reg(data->ub))
> > > +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, elem);
> > > +       else if (ublk_dev_need_map_io(data->ub)) {
> > > +               buf.addr =3D ublk_batch_buf_addr(uc, elem);
> > > +
> > > +               ret =3D ublk_check_fetch_buf(data->ub, buf.addr);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       ublk_io_lock(io);
> > > +       ret =3D __ublk_fetch(data->cmd, data->ub, io);
> > > +       if (!ret)
> > > +               io->buf =3D buf;
> > > +       ublk_io_unlock(io);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_dat=
a *data)
> > > +{
> > > +       const struct ublk_batch_io *uc =3D &data->header;
> > > +       struct io_uring_cmd *cmd =3D data->cmd;
> > > +       struct ublk_batch_io_iter iter =3D {
> > > +               .total =3D uc->nr_elem * uc->elem_bytes,
> > > +               .elem_bytes =3D uc->elem_bytes,
> > > +       };
> > > +       int ret;
> > > +
> > > +       ret =3D io_uring_cmd_import_fixed(cmd->sqe->addr, iter.total,
> >
> > sqe-> addr should be accessed with READ_ONCE() since it may point to
> > user-mapped memory.
>
> OK.
>
> >
> > > +                       WRITE, &iter.iter, cmd, data->issue_flags);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       mutex_lock(&data->ub->mutex);
> > > +       ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> > > +
> > > +       if (ret && iter.done)
> > > +               ublk_batch_revert_prep_cmd(&iter, data);
> >
> > Mentioned this on V1 as well, but the iter.done check is duplicated in
> > ublk_batch_revert_prep_cmd().
>
> OK, will drop the check in ublk_batch_revert_prep_cmd().
>
> Thanks,
> Ming
>

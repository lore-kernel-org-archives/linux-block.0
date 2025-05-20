Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB81A83FB
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747762861; cv=none; b=T/sw5UIWxSOUJ9PTXbTapYbGnli81E55tqTc2/fLQdGLi5ebcui4x0VVSKRktL1km4BBidj87zD/8SoIU18mIIkdKvxJqz3hMNQjgJq4An35zz6RI3dgFfAEjOLeiqHs3ivIzvSzbsgNJPET+UY9YhadIJmv1jSzViv8cUZoytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747762861; c=relaxed/simple;
	bh=ihW/fZNkVicZgSiqSxJpJsBpVhQ+FI3eLBdjbJk6wZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3CYETdcH8G/Hl1z2q/JAOv+0htJQo6wumRX99q9EYa5JVuHRxMkTDoCTzufVfBA3MfXzYh4hF2mNnYB0KkrZC/aPLwui3yBCBVXU3GQgHOdwYxxWk37Ma7+XjtPg4AYXHfuZUN4B2ClJsNVfJRHCz9UZiyX9pdgQEyeZvDbAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DttSWUGG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DttSWUGG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231bfc4600bso6479745ad.1
        for <linux-block@vger.kernel.org>; Tue, 20 May 2025 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747762859; x=1748367659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQZfneMERonnCdkHkciy095rLpJoj9/urCyzMtc6Bio=;
        b=DttSWUGGc8aqLDiprcgTGK+KN/DERyytKLlAc1FA2ZDwpDISzEWTUo0tNyBTXzTcBT
         zW+QrSpS9ravRMSmLt443MtBtKjzUhNs5/E0UntVkMowMxFhDTJqikwEScI3kke1uap/
         8+Y0wsLTdBZgQGsOYWAEZ17jD6fMKTYe2/aaliM0gD6nhydxs55om3gr40LHo6QYBdct
         mWfG4sQ4AiQRpe5CSrKNLAcuSAP3CNmAwwVKiS0SAjRPKcsTQrBVlvxhACJ4Fc9HATzM
         Olv70B90bizEzYwcD0+uLToJq1DtYI/lk0bhUemLZXvF4h/k+ezs9JccDP0kw0B9doYo
         xRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747762859; x=1748367659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQZfneMERonnCdkHkciy095rLpJoj9/urCyzMtc6Bio=;
        b=gcYE4my86/HmQdf5iEIGJLqQGJGznPtQxDd5XnNhoPtL6HE5TFpVul9k4Nd/wx8mFD
         UYAOH5JdjQSB8uMsfhCyKuAILxdIC3QVZP9/TuXPy4ZRftjmbFWofgm2TE7iumPLDoof
         vlBdB/K8XqTUckMHxVgkh7Ti1XSTmkau/v5XwzeDoQhdSKtdJB4fYb88NTW6tqczlDIa
         nmeOq562zZj3C33ke1D9Og5CKI/6Y4NT688QUsEmpc24Fz/f09c7/N5dMHbDbykNCoio
         7lfgv+7t9pnQSwrejyrEseR5hhkJVVbXd/OlKeArSRv0pojZ9GVoANotsbXkdYH9tKes
         qOGA==
X-Forwarded-Encrypted: i=1; AJvYcCUgPNhITbEpguqhLvH8mKxKfIDH9W3i+ZklQzwnFnYF8JZupiroBM4LFNXlVtMPLBeaQ1/BegPLlKwLMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbW9K/laDpahXmIcKKjnY4hhrUR+7OQvZbMlWmI2clfpLCMRv
	/velexRIqvjeMgPD7SJvTWqa8hVFj1DEJyoBT5zc2/NtrSyk5ykQWmn7WsXGvKJNST1CzU+hTLd
	Muht4bbbN7s9wFzFRcwxQfR9G+3VGZutdemqzzTT2zg==
X-Gm-Gg: ASbGncsautPHgWx7vBgh44ByQmDpEdaplr4zMLoOa0RH2uvVUXHhllRDELgH4Hz1DZL
	2LFEBJm2/7C7VidoY/34X5YPA9aA255xJ713dcR6ALD8iENnbvaqaPo8UpQdRBaF/+PqhWydb1/
	iH/C9ERAWi8Zw2TRV5gOKLrB4TK4/UJ0w=
X-Google-Smtp-Source: AGHT+IGn3sjGepURGaLKQ/LHXn+ZGSng8T1kBFyii918j6kv9Excbm3d3IjByHgzSpIGaFhuBnyfPIh74lWklksXc6Q=
X-Received: by 2002:a17:902:cf07:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-231d437f0damr90559025ad.1.1747762858850; Tue, 20 May 2025
 10:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520045455.515691-1-ming.lei@redhat.com> <20250520045455.515691-5-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 20 May 2025 10:40:36 -0700
X-Gm-Features: AX0GCFtsKwlS0jH2tvSBPPbEc_ZTVOasWvDFeDpTPnKEvJe5vxUIPXXGsfOMxKE
Message-ID: <CADUfDZo1OhVDwc2Pw6HsiDdYTLnZ0XYAdp4kEYnkwHGzLYFm-g@mail.gmail.com>
Subject: Re: [PATCH V5 4/6] ublk: support UBLK_AUTO_BUF_REG_FALLBACK
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 9:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> For UBLK_F_AUTO_BUF_REG, buffer is registered to uring_cmd context
> automatically with the provided buffer index. User may provide one wrong
> buffer index, or the specified buffer is registered by application alread=
y.
>
> Add UBLK_AUTO_BUF_REG_FALLBACK for supporting to auto buffer registering
> fallback by completing the uring_cmd and telling ublk server the
> register failure via UBLK_AUTO_BUF_REG_FALLBACK, then ublk server still
> can register the buffer from userspace.
>
> So we can provide reliable way for supporting auto buffer register.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 16 ++++++++++++++
>  include/uapi/linux/ublk_cmd.h | 39 ++++++++++++++++++++++++++++++++---
>  2 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1aabc655652b..2474788ef263 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1182,6 +1182,16 @@ static inline void __ublk_abort_rq(struct ublk_que=
ue *ubq,
>                 blk_mq_end_request(rq, BLK_STS_IOERR);
>  }
>
> +static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_=
io *io)

struct ublk_io *io appears unused.

> +{
> +       const struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +
> +       iod->op_flags |=3D UBLK_IO_F_NEED_REG_BUF;
> +       refcount_set(&data->ref, 1);
> +}
> +
>  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>                               unsigned int issue_flags)
>  {
> @@ -1192,6 +1202,10 @@ static bool ublk_auto_buf_reg(struct request *req,=
 struct ublk_io *io,
>         ret =3D io_buffer_register_bvec(io->cmd, req, ublk_io_release,
>                                       pdu->buf.index, issue_flags);
>         if (ret) {
> +               if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
> +                       ublk_auto_buf_reg_fallback(req, io);
> +                       return true;
> +               }
>                 blk_mq_end_request(req, BLK_STS_IOERR);
>                 return false;
>         }
> @@ -1971,6 +1985,8 @@ static inline int ublk_set_auto_buf_reg(struct io_u=
ring_cmd *cmd)
>         if (pdu->buf.reserved0 || pdu->buf.reserved1)
>                 return -EINVAL;
>
> +       if (pdu->buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
> +               return -EINVAL;
>         return 0;
>  }
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index f6f516b1223b..c4b9942697fc 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -236,9 +236,16 @@
>   *
>   * - all reserved fields in `ublk_auto_buf_reg` need to be zeroed
>   *
> + * - pass flags from `ublk_auto_buf_reg.flags` if needed
> + *
>   * This way avoids extra cost from two uring_cmd, but also simplifies ba=
ckend
>   * implementation, such as, the dependency on IO_REGISTER_IO_BUF and
>   * IO_UNREGISTER_IO_BUF becomes not necessary.
> + *
> + * If wrong data or flags are provided, both IO_FETCH_REQ and
> + * IO_COMMIT_AND_FETCH_REQ are failed, for the latter, the ublk IO reque=
st
> + * won't be completed until new IO_COMMIT_AND_FETCH_REQ command is issue=
d
> + * successfully

This part of the comment belongs in the previous commit adding
UBLK_F_AUTO_BUF_REG, right? It doesn't seem specific to
UBLK_AUTO_BUF_REG_FALLBACK.

Otherwise,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>   */
>  #define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
>
> @@ -328,6 +335,17 @@ struct ublksrv_ctrl_dev_info {
>  #define                UBLK_IO_F_FUA                   (1U << 13)
>  #define                UBLK_IO_F_NOUNMAP               (1U << 15)
>  #define                UBLK_IO_F_SWAP                  (1U << 16)
> +/*
> + * For UBLK_F_AUTO_BUF_REG & UBLK_AUTO_BUF_REG_FALLBACK only.
> + *
> + * This flag is set if auto buffer register is failed & ublk server pass=
es
> + * UBLK_AUTO_BUF_REG_FALLBACK, and ublk server need to register buffer
> + * manually for handling the delivered IO command if this flag is observ=
ed
> + *
> + * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
> + * passed in.
> + */
> +#define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
>
>  /*
>   * io cmd is described by this structure, and stored in share memory, in=
dexed
> @@ -362,10 +380,23 @@ static inline __u32 ublksrv_get_flags(const struct =
ublksrv_io_desc *iod)
>         return iod->op_flags >> 8;
>  }
>
> +/*
> + * If this flag is set, fallback by completing the uring_cmd and setting
> + * `UBLK_IO_F_NEED_REG_BUF` in case of auto-buf-register failure;
> + * otherwise the client ublk request is failed silently
> + *
> + * If ublk server passes this flag, it has to check if UBLK_IO_F_NEED_RE=
G_BUF
> + * is set in `ublksrv_io_desc.op_flags`. If UBLK_IO_F_NEED_REG_BUF is se=
t,
> + * ublk server needs to register io buffer manually for handling IO comm=
and.
> + */
> +#define UBLK_AUTO_BUF_REG_FALLBACK     (1 << 0)
> +#define UBLK_AUTO_BUF_REG_F_MASK       UBLK_AUTO_BUF_REG_FALLBACK
> +
>  struct ublk_auto_buf_reg {
>         /* index for registering the delivered request buffer */
>         __u16  index;
> -       __u16   reserved0;
> +       __u8   flags;
> +       __u8   reserved0;
>
>         /*
>          * io_ring FD can be passed via the reserve field in future for
> @@ -379,6 +410,7 @@ struct ublk_auto_buf_reg {
>   * uring_cmd's sqe->addr:
>   *
>   *     - bit0 ~ bit15: buffer index
> + *     - bit16 ~ bit23: flags
>   *     - bit24 ~ bit31: reserved0
>   *     - bit32 ~ bit63: reserved1
>   */
> @@ -387,7 +419,8 @@ static inline struct ublk_auto_buf_reg ublk_sqe_addr_=
to_auto_buf_reg(
>  {
>         struct ublk_auto_buf_reg reg =3D {
>                 .index =3D sqe_addr & 0xffff,
> -               .reserved0 =3D (sqe_addr >> 16) & 0xffff,
> +               .flags =3D (sqe_addr >> 16) & 0xff,
> +               .reserved0 =3D (sqe_addr >> 24) & 0xff,
>                 .reserved1 =3D sqe_addr >> 32,
>         };
>
> @@ -397,7 +430,7 @@ static inline struct ublk_auto_buf_reg ublk_sqe_addr_=
to_auto_buf_reg(
>  static inline __u64
>  ublk_auto_buf_reg_to_sqe_addr(const struct ublk_auto_buf_reg *buf)
>  {
> -       __u64 addr =3D buf->index | (__u64)buf->reserved0 << 16 |
> +       __u64 addr =3D buf->index | (__u64)buf->flags << 16 | (__u64)buf-=
>reserved0 << 24 |
>                 (__u64)buf->reserved1 << 32;
>
>         return addr;
> --
> 2.47.0
>

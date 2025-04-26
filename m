Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7981A256E
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745699908; cv=none; b=dI3leAtGx2BvA+HexwMkLa/Z92NMRYF6+eWCv7T+Jr09WWQaS/JVOGUOUbbXPquqaq8miBo4Eo1hLkFUzsT+TFRQAmHfIJ+3AalBiFRr8wqwlNl19toJzGprDeuVsxq2BUviCD+lHwD9TrWIHhecYIdNSJPWEKNZJ92aleLp4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745699908; c=relaxed/simple;
	bh=n/Q9QrPbchMZIQFT8oAM9FwnCev9HVRf2nyKeA8cXMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVOuHr/vrSDnNi6s7ZQNKu6/DhX3XSrQLdKFebuRMChkxV5DSIRuEyfpZ7pU/lh3SH/czJt0efrahGIFpEpP58GPjPHH38/4wQtvmQvral8IysDKIeuTzbp28ea4YdL0EU3ppTr73rAKpjp/veN29PszosMJ0bRQJ8sR9Ion+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GFFOzeue; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GFFOzeue"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224172f32b3so8135935ad.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745699905; x=1746304705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX7vVKWCV+r2mMIt9OGHxlBn43WZ0r9Gc1fpJmpcQ3c=;
        b=GFFOzeueL7/OW+GcTAA46aaUlQ8J73VjmSvYgPMxyi98QUAbFGRvqlok59nabTXHrq
         UzymYVg06AplhH5iYUwRdX97lD3mIglO0IUUionv7PsXFebI4inIiiSSBOw7glcszXCB
         iJ4q8zn5zNMIA6/rw6roExfJlHac8oiZH8nwPRqWJM1JJNuOTV4VxBeUWO13dBoaFkxb
         FG/PpXmmRz+oHhN2JY0Lq2q0PG8zzUF+uFZFLQDPe0lKZRnO7i9zJqXNdRjL10LE3s3S
         B5YxHaKAzc1C0J9sgNRFPHoTlYmoiQVYiqaXaPRDIwJ9S6sqnPFEu0ree42sCOU9pmeC
         QdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745699905; x=1746304705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX7vVKWCV+r2mMIt9OGHxlBn43WZ0r9Gc1fpJmpcQ3c=;
        b=u1e8gzdKcbYx3O6EXr68erqIF9U4xZUEHYFZEwhMNyJA2lSm0DSsBuT4K1m7IP8RWr
         QNZXWGS6vjRmUtcgGEFc716iaZxedKb3R+uVzuGOeFHFwxU2Rx0itlY/M+umd1+Ju5IY
         /0AmxbawRjC7AMmOtpUyM3ZV0yvpEuE5/hJzo13jD/3j5F3r1SJTkyqONpMeiwtgi0OJ
         DX3fXbNMGwIKn4oER972GTaRI878izW4a80JFCWYSxIZwv9HvL9m5R0ZZcT9F9ybf639
         4HBr/Tq3HB5pWDmi7JvDW7G20JS4R97ivn4FkRT8gugw+N1q2HQhY5Mz1PyNRQdjxdH+
         V53w==
X-Forwarded-Encrypted: i=1; AJvYcCVA0ALCuaQkUZGUaCEw/6PoU6pnCFqyDFtcIVzwE8QxF5+PkY621cjIc5jxekbSIrcc9oDBT8kEU81ibw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5pIKSGubI+SIYH4ZGZUNRXhuHU8xotH07mGWmI1IWQ4YWZep
	V8m33WDWQxmmLezsDMsT5XMsKcv4B2qJsdb7+3jZRgX6fviyKwDRNmILs3z+KoEXd1fxoEO8yiL
	giGAGXhRDUqkb3blb7VHcUN+uQDuKdlLQC/aIdyda1NJzJCGTvv384g==
X-Gm-Gg: ASbGnctQ1Xbh1okGQamDg3cClCTddk7BusPpXIZkZlcdMdACnox2Bp3Bbhx3cBH9P+v
	7ilHjMLGRF2FBb/isXrGPfLUnIEAUJRz968aHzPFF8kAu3R9Y7VY26yLbDCCQ0EQwhQ7XIbc78C
	ZK1oZDYPtF15IqAdiFO9Lt
X-Google-Smtp-Source: AGHT+IF3dGKD2RxpfCE8lvA8FGcDin5T3ir1M7TyAeIBuPLqZH3J51wkDxkIrdbzmygGTJ2RMlkTfsfpSmsOWtu+630=
X-Received: by 2002:a17:903:2f44:b0:22c:36d1:7a4d with SMTP id
 d9443c01a7336-22dbf73b95bmr36332375ad.14.1745699905475; Sat, 26 Apr 2025
 13:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426094111.1292637-1-ming.lei@redhat.com> <20250426094111.1292637-3-ming.lei@redhat.com>
In-Reply-To: <20250426094111.1292637-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 26 Apr 2025 13:38:14 -0700
X-Gm-Features: ATxdqUGnTH5VZg6KtJiBNf-tAV-uWk6eRywW1AWF0ChQszzsdagZPOkE94DQWF8
Message-ID: <CADUfDZrF71gPfCghE+wNyLXTmtAUprMfpo1XtP1C7kxx-=eP+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] ublk: enhance check for register/unregister io buffer command
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 2:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> register/unregister io buffer easily, so check it before calling
> starting to register/un-register io buffer.
>
> Also only allow io buffer register/unregister uring_cmd in case of
> UBLK_F_SUPPORT_ZERO_COPY.

Indeed, both these checks make sense. (Hopefully there aren't any
applications depending on the ability to use ublk zero-copy without
setting the flag.) I too was thinking of adding the
UBLK_IO_FLAG_OWNED_BY_SRV check because it could allow the
kref_get_unless_zero() to be replaced with the cheaper kref_get(). I
think the checks could be split into 2 separate commits, but up to
you.

>
> Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 40f971a66d3e..347790b3a633 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -609,6 +609,11 @@ static void ublk_apply_params(struct ublk_device *ub=
)
>                 ublk_dev_param_zoned_apply(ub);
>  }
>
> +static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> +{
> +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> +}
> +
>  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
>  {
>         return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)=
;
> @@ -1950,9 +1955,16 @@ static int ublk_register_io_buf(struct io_uring_cm=
d *cmd,
>                                 unsigned int index, unsigned int issue_fl=
ags)
>  {
>         struct ublk_device *ub =3D cmd->file->private_data;
> +       struct ublk_io *io =3D &ubq->ios[tag];

I thought you had mentioned in
https://lore.kernel.org/linux-block/aAmYJxaV1-yWEMRo@fedora/ wanting
to the ability to offload the ublk zero-copy buffer registration to a
thread other than ubq_daemon. Are you still planning to do that, or
does the "auto-register" feature supplant the need for that? Accessing
the ublk_io here only seems safe when on the ubq_daemon thread.

>         struct request *req;
>         int ret;
>
> +       if (!ublk_support_zero_copy(ubq))
> +               return -EINVAL;
> +
> +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +               return -EINVAL;

Every opcode except UBLK_IO_FETCH_REQ now checks io->flags &
UBLK_IO_FLAG_OWNED_BY_SRV. Maybe it would make sense to lift the check
up to __ublk_ch_uring_cmd() to avoid duplicating it?

Best,
Caleb

> +
>         req =3D __ublk_check_and_get_req(ub, ubq, tag, 0);
>         if (!req)
>                 return -EINVAL;
> @@ -1968,8 +1980,17 @@ static int ublk_register_io_buf(struct io_uring_cm=
d *cmd,
>  }
>
>  static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> +                                 struct ublk_queue *ubq, unsigned int ta=
g,
>                                   unsigned int index, unsigned int issue_=
flags)
>  {
> +       struct ublk_io *io =3D &ubq->ios[tag];
> +
> +       if (!ublk_support_zero_copy(ubq))
> +               return -EINVAL;
> +
> +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +               return -EINVAL;
> +
>         return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>
> @@ -2073,7 +2094,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         case UBLK_IO_REGISTER_IO_BUF:
>                 return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, =
issue_flags);
>         case UBLK_IO_UNREGISTER_IO_BUF:
> -               return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_fl=
ags);
> +               return ublk_unregister_io_buf(cmd, ubq, tag, ub_cmd->addr=
, issue_flags);
>         case UBLK_IO_FETCH_REQ:
>                 ret =3D ublk_fetch(cmd, ubq, io, ub_cmd->addr);
>                 if (ret)
> --
> 2.47.0
>

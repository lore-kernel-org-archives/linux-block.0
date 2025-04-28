Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E50269CFA
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857702; cv=none; b=cVWGs76PZeg5Gt01OTfJZds6set0rfwh1DTh/kfsxM81tUDjJ2Ls74XhpQVBMgO9xAgD4QO1SqE2KFbzmH1rm7hn2a5lWQXHk9T5EC5ldetgjLJBrl/NBge4M4ePDfeHlBDAdX5sTB1lYOSThk6qD4nGUtc1RRsZF3hL7f8JYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857702; c=relaxed/simple;
	bh=oTmKzQs4zGtr+NnKp/4jtvvyqrWuVASADGL1/tjb3/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwsTxUut/XK0NSPKDH9lpwCoeqjbmFiWbZA8Vvb2a4NOak6MUCAmbDMuvYNLM9zptyBbTV0F25VYXli9CVn07JT/AsB7U/mRmyy6t0FtXKT8vPq3k6eewOMG9840IbuxcbivgrU1ayVUaoBp5P21ekROQcPuK44LtW0eGqYIqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EIrudrD1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EIrudrD1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b07698318ebso411383a12.2
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745857699; x=1746462499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YwMcrYC+AixntR3YlL0ho6gKfNiSV7cUBQGIfo+DnQ=;
        b=EIrudrD1RObGr0iohvMkWXm1868pL5As0qTGLrfj9O3ILuuZCZum9kpS0zTxMFaiLv
         tfkifQ4HzRKB3TGR5hSlUh26fLwfUoOdFPCDNH8MBhZbi8K/grhwzy9SxdGUCkW91QZH
         tFzcnFgR/JdtihvCVe8X9X3MElpSlxvQbVwNu5uE+lf7lLIYJRFHoczjEu5QhS/ya0DN
         WBUOFKQ9FQFq+dJSBX0ufj8P1XR0UiwKhSLW/WOvOKYk58qfrFt4EArENYkEmz+ohcZE
         SZaQBn8IVdPtDHBMTnWWve7oUMt27ocInQ/BvUCHa7980G7zqVWe2cQl/p4yTo807hH5
         pdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857699; x=1746462499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YwMcrYC+AixntR3YlL0ho6gKfNiSV7cUBQGIfo+DnQ=;
        b=UF13I098oi+7xKxSwqHOTdfOVhEGefdOac0z7psB+1fipf9AlzCbaJVDvoEHV5OcoW
         MZm1iXEfcmzB5SXva4iTwPW4TcyJnZkC+XfEVX6mKFPAHS4iUrznV6IH+Q+KFwk5wCpZ
         l7WHJENOsBureoHyrYqoxJ6k7MbFy9B7VoT77O5MSAssClQt7pOY+vH7hkMfgqKmqeT7
         CEs1JMVUX1L3n+kCwhNZq3Qa6CKgJLn+iTeAW42NT9rWqwaTwvpOQyCp5h8Hoprpzl9s
         MUjWC2TizImb2Tb7TiWQ8jj4aurMvET1lR0+3m9nwlWVRz2JrQHSBfIf+o1MfDRteA/D
         P7yA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5Tdd7q1df2bvILsT8vvuahPlziXHyjb//a9Gi6HKArz+uDo7LScVbCeiToyKEmmR4uuMpGITzkYLvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHh9wX7ddqwlh6pJwnZgO/UHGMlJYzpPGXae13j0RBMwgmVmys
	nmewWnhl4QzGKDykAs13PNlJlkH5PsUXJUqlttFDfQIx9FiUBvial83b9P0zt6f7BJi8a4sG1wu
	w60QPAAIPKdFGRkFHh93HtFIwSnyI7QYF4pf/0A==
X-Gm-Gg: ASbGnctAFsA1entvtq6LG8+fYR8BvbTxFyqQW5hdY1zbEaBe1Sie2DsZLLroL8vb5EF
	DwKVDiInYIMCEYXxZR+c7hvuV+tbpzTgscyHC9klwj8MdkztCVnXY6+lF5tAPiO0npF+w/QkHmN
	Z/2TXKwaRdw+8vuCUNETLPkA==
X-Google-Smtp-Source: AGHT+IFRDQMLtLvD2Z/D7LpxK+C7lDxUBXO8yqqPEQpFwndjKLXYXvpBaLyNL/cKG/rkT2eku01sfEjS4M8ffNbhZLU=
X-Received: by 2002:a17:90b:4a05:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-309f7e9e312mr6960939a91.5.1745857699182; Mon, 28 Apr 2025
 09:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427134932.1480893-1-ming.lei@redhat.com> <20250427134932.1480893-4-ming.lei@redhat.com>
In-Reply-To: <20250427134932.1480893-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 09:28:07 -0700
X-Gm-Features: ATxdqUGfv2Wo7w5ugrwoi52JkBn0qMYgnWViWv5llhUqVFY-wJv6gBmaQdMB63s
Message-ID: <CADUfDZrVOUE+Wweaz0pg9qfSB5Ye8FHuf-FmDjO2VOz0GU-cNg@mail.gmail.com>
Subject: Re: [PATCH v6.15 3/3] ublk: enhance check for register/unregister io
 buffer command
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 6:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> register/unregister io buffer easily, so check it before calling
> starting to register/un-register io buffer.
>
> Also only allow io buffer register/unregister uring_cmd in case of
> UBLK_F_SUPPORT_ZERO_COPY.
>
> Also mark argument 'ublk_queue *' of ublk_register_io_buf as const.
>
> Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0a3a3c64316d..c624d8f653ae 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -201,7 +201,7 @@ struct ublk_params_header {
>  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *=
ubq);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
> -               struct ublk_queue *ubq, int tag, size_t offset);
> +               const struct ublk_queue *ubq, int tag, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
>  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ub=
q,
>                                                    int tag);
> @@ -1949,13 +1949,20 @@ static void ublk_io_release(void *priv)
>  }
>
>  static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> -                               struct ublk_queue *ubq, unsigned int tag,
> +                               const struct ublk_queue *ubq, unsigned in=
t tag,
>                                 unsigned int index, unsigned int issue_fl=
ags)
>  {
>         struct ublk_device *ub =3D cmd->file->private_data;
> +       const struct ublk_io *io =3D &ubq->ios[tag];
>         struct request *req;
>         int ret;
>
> +       if (!ublk_support_zero_copy(ubq))
> +               return -EINVAL;
> +
> +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +               return -EINVAL;

I would still prefer to see this common UBLK_IO_FLAG_OWNED_BY_SRV
check moved to __ublk_ch_uring_cmd() along with the existing flag
checks. Something like this:

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a183aa7648c3..79ef2580ddcc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2055,6 +2055,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *=
cmd,
                goto out;
        }

+       /* only FETCH_REQ is allowed if io is not OWNED_BY_SRV */
+       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) &&
+           _IOC_NR(cmd_op) !=3D UBLK_IO_FETCH_REQ)
+               goto out;
+
        /*
         * ensure that the user issues UBLK_IO_NEED_GET_DATA
         * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
@@ -2080,10 +2085,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *=
cmd,
                break;
        case UBLK_IO_COMMIT_AND_FETCH_REQ:
                req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], ta=
g);
-
-               if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-                       goto out;
-
                if (ublk_need_map_io(ubq)) {
                        /*
                         * COMMIT_AND_FETCH_REQ has to provide IO buffer if
@@ -2105,8 +2106,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *c=
md,
                ublk_commit_completion(ub, ub_cmd);
                break;
        case UBLK_IO_NEED_GET_DATA:
-               if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
-                       goto out;
                ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
                req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], ta=
g);
                ublk_dispatch_req(ubq, req, issue_flags);


> +
>         req =3D __ublk_check_and_get_req(ub, ubq, tag, 0);
>         if (!req)
>                 return -EINVAL;
> @@ -1971,8 +1978,17 @@ static int ublk_register_io_buf(struct io_uring_cm=
d *cmd,
>  }
>
>  static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> +                                 const struct ublk_queue *ubq, unsigned =
int tag,
>                                   unsigned int index, unsigned int issue_=
flags)
>  {
> +       const struct ublk_io *io =3D &ubq->ios[tag];
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
> @@ -2076,7 +2092,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
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
> @@ -2128,7 +2144,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>  }
>
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
> -               struct ublk_queue *ubq, int tag, size_t offset)
> +               const struct ublk_queue *ubq, int tag, size_t offset)
>  {
>         struct request *req;
>
> --
> 2.47.0
>

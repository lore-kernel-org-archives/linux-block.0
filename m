Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A7199FAB
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184022; cv=none; b=DDWUGRUMlgDrDsvlQz+cPr7YqO9K9+WM8rHWuxP33PD8r3jNY99hzgMTMopX3B6oRrH3Ku6GqoDarzRm1pSedn9Ecer+rUT7W/GW7eAyyJReW7sF15S+95OqGq21U+F6PsELTdcLsiD6DInFpj504dSUMusACPeZ+10V8rhq8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184022; c=relaxed/simple;
	bh=1mcMStJp0AQZs7RPwMYyfauI3G12YeydXotX5ez3XqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoKFVbRHckZCrH2jhJNOEMaMQosZicd/qTXPJQjNmDGtCFt3TneBkaC/VR2DY4WXRL+6eyRRUyCXyRmR9OJK69VN+hmk9+8DtswBa2fPg1TUkMTaeJ/mqaiW3SprSdvXg2IUmL1HdZOd9NKG5kVWxaTqmhSuaIrsBK4rekV9deA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RIWUzAUr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RIWUzAUr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24687bbe3aaso5004185ad.2
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756184019; x=1756788819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iCmlUFmconG8X3i6AdRjMJoD3k+ZEcRfHl4ByUZa0Y=;
        b=RIWUzAUrkNlu8NwIIT+JXUbtusQFvrqT0LyN/kG6ONpOYN9eQzCl/zBmkxS1qjXt2S
         7/yrQHouX/jE/spYVwfs0RzkdyO7LoiMcYwvAUYLYmYK3oI/bt2izf1k/S2GAXwa2rgo
         LMsrdC/lJ/e4W+HB7DDSYNNPlW5UM9aCK6Jbx5goDctRqaZWLWo38uPdMzERrv4FicvS
         /Tx9+YpjCpxZs+36fSpyLNPOCacyOFWQU2hYxvJz5MgwWRKbMUROZjbAn/M8xxox/gSp
         liO0SKEuuZfvzH2tsQbi3LLjAFNNdjU9ozKiO3lw2Y8lv2HNZTCFwxriCdT8bAfGcuba
         qqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756184019; x=1756788819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iCmlUFmconG8X3i6AdRjMJoD3k+ZEcRfHl4ByUZa0Y=;
        b=oDDssctdzhAEjC0q/yqmEBulrqh2guTBqCaCNltK9gK5l8/OR1ie3O7XhAE5B4TOPP
         aMig7S094Bv8cKQwtV25kViyYbkWEVehhimcorGygmICNWGz6doVz9Qko9dUSIrzBM7F
         biDOmc5qkIqAnJkqbbqNPfEukaM0jVEPwXLghbRPuBlv+4QgfkAjhOd3m+va3XNVcBJR
         wBUtiSdSAqb+6GKy++i/G1tJq2vKJt8c5N1JAhD93EJwiuKR41JuBrag9RSLc1hqr6Wb
         B+mCoSfUpy3DxUMabrESQqcpGZuI6aOX4FavkNshqT4BRkZ1flUMuep8EO7x1u21/yXv
         sOhg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8WWTmQOwVtuCrhZZrW5jxI50XNWFfcjUfpj0b0kFAFU8AaiuRZCQyzXBBxFEKOC43+q/q9NGteXeSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz301QMFsiGgzenc/fmNsE5522ArSP2IgDdwg3EBl2Y/B43v51g
	XZnBjpb8Uv63qHwmBPMiOTgTV8E1rn1pG0k767KiYMydRVOCVo09Y3JciHybuKuEZNd/J8bdtvS
	Zr5z1H7o7lh/gIoR4TfKBMJV8bHdZgkMojKGVwvIscQ==
X-Gm-Gg: ASbGncvTJOEt7c8CxzWsqkFxrjKvxg3FhFF5540H7Uqvw4wjosX8IJ73aK9QImndQu9
	6Nf7Hpcik+gJIUbKPFpq1VmkmpRX30JSpcvxo6yfktuz/zW0JCGe1rkR/Cc2RoLyHuxQVCgR1Hs
	nRrJNeyzpxnHyOkMtjeMS3qpPluqFLSa2gcsKEwYasaVNrul2o9+5jiUl9FO0fAhsEAVNVUHtet
	pIZf+SinF3dTrjxnzjC1GECNxl+rg==
X-Google-Smtp-Source: AGHT+IEgTVIMoK3KKR1r2C6vbvj7rXMosn2wNRPx8rSnhE3z3pbRj7hqQj8bAjoh9WQGjA3FNt7auhOrVNqFyPElTZA=
X-Received: by 2002:a17:902:e78f:b0:240:4d65:508f with SMTP id
 d9443c01a7336-2462ef99564mr86025465ad.6.1756184018767; Mon, 25 Aug 2025
 21:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825124827.2391820-1-ming.lei@redhat.com> <20250825124827.2391820-3-ming.lei@redhat.com>
In-Reply-To: <20250825124827.2391820-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 25 Aug 2025 21:53:27 -0700
X-Gm-Features: Ac12FXwArBAJgmt2IJQDKpn1qRH4jS6Rvm59XeQrcu8leZVq7wX4v7VBPpebves
Message-ID: <CADUfDZrZLiD9r7AK+83HLgi-tXGvzNX_fasvwQ2_-wm6EVPifQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] ublk selftests: add --no_ublk_fixed_fd for not
 using registered ublk char device
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add a new command line option --no_ublk_fixed_fd that excludes the ublk
> control device (/dev/ublkcN) from io_uring's registered files array.
> When this option is used, only backing files are registered starting
> from index 1, while the ublk control device is accessed using its raw
> file descriptor.
>
> Add ublk_get_registered_fd() helper function that returns the appropriate
> file descriptor for use with io_uring operations, taking ublk_queue *
> parameter instead of ublk_thread * for better performance.
>
> Key optimizations implemented:
> - Cache UBLKS_Q_NO_UBLK_FIXED_FD flag in ublk_queue.flags to avoid
>   reading dev->no_ublk_fixed_fd in fast path
> - Cache ublk char device fd in ublk_queue.ublk_fd for fast access
> - Update ublk_get_registered_fd() to use ublk_queue * parameter
> - Update io_uring_prep_buf_register/unregister() to use ublk_queue *
> - Replace ublk_device * access with ublk_queue * access in fast paths
>
> This improves performance by:
> - Eliminating device structure traversal in hot paths
> - Better cache locality with queue-local data access
> - Reduced indirection for flag and fd lookups

Are you saying that performance is better when using the raw
/dev/ublkcN fd instead of an io_uring registered file? That would be
really surprising to me, since the whole point of io_uring file
registration is to avoid the file reference counting in the I/O path.

Best,
Caleb

>
> The helper handles both modes:
> - Normal mode: Returns registered file indices directly
> - --no_ublk_fixed_fd mode: Returns raw FD for ublk device (index 0)
>   and adjusted indices for backing files (index 1 becomes 0, etc.)
>
> Also pass --no_ublk_fixed_fd to test_stress_04.sh for covering
> plain ublk char device mode.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/file_backed.c    | 10 ++--
>  tools/testing/selftests/ublk/kublk.c          | 38 ++++++++++++---
>  tools/testing/selftests/ublk/kublk.h          | 46 +++++++++++++------
>  tools/testing/selftests/ublk/null.c           |  4 +-
>  tools/testing/selftests/ublk/stripe.c         |  4 +-
>  .../testing/selftests/ublk/test_stress_04.sh  |  6 +--
>  6 files changed, 75 insertions(+), 33 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/s=
elftests/ublk/file_backed.c
> index 2d93ac860bd5..cd9fe69ecce2 100644
> --- a/tools/testing/selftests/ublk/file_backed.c
> +++ b/tools/testing/selftests/ublk/file_backed.c
> @@ -20,7 +20,7 @@ static int loop_queue_flush_io(struct ublk_thread *t, s=
truct ublk_queue *q,
>         struct io_uring_sqe *sqe[1];
>
>         ublk_io_alloc_sqes(t, sqe, 1);
> -       io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
> +       io_uring_prep_fsync(sqe[0], ublk_get_registered_fd(q, 1) /*fds[1]=
*/, IORING_FSYNC_DATASYNC);
>         io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
>         /* bit63 marks us as tgt io */
>         sqe[0]->user_data =3D build_user_data(tag, ublk_op, 0, q->q_id, 1=
);
> @@ -42,7 +42,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, =
struct ublk_queue *q,
>                 if (!sqe[0])
>                         return -ENOMEM;
>
> -               io_uring_prep_rw(op, sqe[0], 1 /*fds[1]*/,
> +               io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 1)=
 /*fds[1]*/,
>                                 addr,
>                                 iod->nr_sectors << 9,
>                                 iod->start_sector << 9);
> @@ -56,19 +56,19 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t=
, struct ublk_queue *q,
>
>         ublk_io_alloc_sqes(t, sqe, 3);
>
> -       io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q=
, tag)->buf_index);
> +       io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q=
, tag)->buf_index);
>         sqe[0]->flags |=3D IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
>         sqe[0]->user_data =3D build_user_data(tag,
>                         ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
>
> -       io_uring_prep_rw(op, sqe[1], 1 /*fds[1]*/, 0,
> +       io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1=
]*/, 0,
>                 iod->nr_sectors << 9,
>                 iod->start_sector << 9);
>         sqe[1]->buf_index =3D tag;
>         sqe[1]->flags |=3D IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
>         sqe[1]->user_data =3D build_user_data(tag, ublk_op, 0, q->q_id, 1=
);
>
> -       io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io=
(q, tag)->buf_index);
> +       io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io=
(q, tag)->buf_index);
>         sqe[2]->user_data =3D build_user_data(tag, ublk_cmd_op_nr(sqe[2]-=
>cmd_op), 0, q->q_id, 1);
>
>         return 2;
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index 95188065b2e9..ede1725f32bb 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -432,7 +432,7 @@ static void ublk_thread_deinit(struct ublk_thread *t)
>         }
>  }
>
> -static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
> +static int ublk_queue_init(struct ublk_queue *q, unsigned long long extr=
a_flags)
>  {
>         struct ublk_dev *dev =3D q->dev;
>         int depth =3D dev->dev_info.queue_depth;
> @@ -446,6 +446,9 @@ static int ublk_queue_init(struct ublk_queue *q, unsi=
gned extra_flags)
>         q->flags =3D dev->dev_info.flags;
>         q->flags |=3D extra_flags;
>
> +       /* Cache fd in queue for fast path access */
> +       q->ublk_fd =3D dev->fds[0];
> +
>         cmd_buf_size =3D ublk_queue_cmd_buf_sz(q);
>         off =3D UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf=
_sz();
>         q->io_cmd_buf =3D mmap(0, cmd_buf_size, PROT_READ,
> @@ -481,9 +484,10 @@ static int ublk_queue_init(struct ublk_queue *q, uns=
igned extra_flags)
>         return -ENOMEM;
>  }
>
> -static int ublk_thread_init(struct ublk_thread *t)
> +static int ublk_thread_init(struct ublk_thread *t, unsigned long long ex=
tra_flags)
>  {
>         struct ublk_dev *dev =3D t->dev;
> +       unsigned long long flags =3D dev->dev_info.flags | extra_flags;
>         int ring_depth =3D dev->tgt.sq_depth, cq_depth =3D dev->tgt.cq_de=
pth;
>         int ret;
>
> @@ -512,7 +516,17 @@ static int ublk_thread_init(struct ublk_thread *t)
>
>         io_uring_register_ring_fd(&t->ring);
>
> -       ret =3D io_uring_register_files(&t->ring, dev->fds, dev->nr_fds);
> +       if (flags & UBLKS_Q_NO_UBLK_FIXED_FD) {
> +               /* Register only backing files starting from index 1, exc=
lude ublk control device */
> +               if (dev->nr_fds > 1) {
> +                       ret =3D io_uring_register_files(&t->ring, &dev->f=
ds[1], dev->nr_fds - 1);
> +               } else {
> +                       /* No backing files to register, skip file regist=
ration */
> +                       ret =3D 0;
> +               }
> +       } else {
> +               ret =3D io_uring_register_files(&t->ring, dev->fds, dev->=
nr_fds);
> +       }
>         if (ret) {
>                 ublk_err("ublk dev %d thread %d register files failed %d\=
n",
>                                 t->dev->dev_info.dev_id, t->idx, ret);
> @@ -626,9 +640,12 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct =
ublk_io *io)
>
>         /* These fields should be written once, never change */
>         ublk_set_sqe_cmd_op(sqe[0], cmd_op);
> -       sqe[0]->fd              =3D 0;    /* dev->fds[0] */
> +       sqe[0]->fd      =3D ublk_get_registered_fd(q, 0); /* dev->fds[0] =
*/
>         sqe[0]->opcode  =3D IORING_OP_URING_CMD;
> -       sqe[0]->flags   =3D IOSQE_FIXED_FILE;
> +       if (q->flags & UBLKS_Q_NO_UBLK_FIXED_FD)
> +               sqe[0]->flags   =3D 0;  /* Use raw FD, not fixed file */
> +       else
> +               sqe[0]->flags   =3D IOSQE_FIXED_FILE;
>         sqe[0]->rw_flags        =3D 0;
>         cmd->tag        =3D io->tag;
>         cmd->q_id       =3D q->q_id;
> @@ -832,6 +849,7 @@ struct ublk_thread_info {
>         unsigned                idx;
>         sem_t                   *ready;
>         cpu_set_t               *affinity;
> +       unsigned long long      extra_flags;
>  };
>
>  static void *ublk_io_handler_fn(void *data)
> @@ -844,7 +862,7 @@ static void *ublk_io_handler_fn(void *data)
>         t->dev =3D info->dev;
>         t->idx =3D info->idx;
>
> -       ret =3D ublk_thread_init(t);
> +       ret =3D ublk_thread_init(t, info->extra_flags);
>         if (ret) {
>                 ublk_err("ublk dev %d thread %u init failed\n",
>                                 dev_id, t->idx);
> @@ -934,6 +952,8 @@ static int ublk_start_daemon(const struct dev_ctx *ct=
x, struct ublk_dev *dev)
>
>         if (ctx->auto_zc_fallback)
>                 extra_flags =3D UBLKS_Q_AUTO_BUF_REG_FALLBACK;
> +       if (ctx->no_ublk_fixed_fd)
> +               extra_flags |=3D UBLKS_Q_NO_UBLK_FIXED_FD;
>
>         for (i =3D 0; i < dinfo->nr_hw_queues; i++) {
>                 dev->q[i].dev =3D dev;
> @@ -951,6 +971,7 @@ static int ublk_start_daemon(const struct dev_ctx *ct=
x, struct ublk_dev *dev)
>                 tinfo[i].dev =3D dev;
>                 tinfo[i].idx =3D i;
>                 tinfo[i].ready =3D &ready;
> +               tinfo[i].extra_flags =3D extra_flags;
>
>                 /*
>                  * If threads are not tied 1:1 to queues, setting thread
> @@ -1471,7 +1492,7 @@ static void __cmd_create_help(char *exe, bool recov=
ery)
>         printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [=
-d depth] [-n dev_id]\n",
>                         exe, recovery ? "recover" : "add");
>         printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fa=
llback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
> -       printf("\t[-e 0|1 ] [-i 0|1]\n");
> +       printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
>         printf("\t[--nthreads threads] [--per_io_tasks]\n");
>         printf("\t[target options] [backfile1] [backfile2] ...\n");
>         printf("\tdefault: nr_queues=3D2(max 32), depth=3D128(max 1024), =
dev_id=3D-1(auto allocation)\n");
> @@ -1534,6 +1555,7 @@ int main(int argc, char *argv[])
>                 { "size",               1,      NULL, 's'},
>                 { "nthreads",           1,      NULL,  0 },
>                 { "per_io_tasks",       0,      NULL,  0 },
> +               { "no_ublk_fixed_fd",   0,      NULL,  0 },
>                 { 0, 0, 0, 0 }
>         };
>         const struct ublk_tgt_ops *ops =3D NULL;
> @@ -1613,6 +1635,8 @@ int main(int argc, char *argv[])
>                                 ctx.nthreads =3D strtol(optarg, NULL, 10)=
;
>                         if (!strcmp(longopts[option_idx].name, "per_io_ta=
sks"))
>                                 ctx.per_io_tasks =3D 1;
> +                       if (!strcmp(longopts[option_idx].name, "no_ublk_f=
ixed_fd"))
> +                               ctx.no_ublk_fixed_fd =3D 1;
>                         break;
>                 case '?':
>                         /*
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftes=
ts/ublk/kublk.h
> index 219233f8a053..9d5bbf559659 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -77,6 +77,7 @@ struct dev_ctx {
>         unsigned int    recovery:1;
>         unsigned int    auto_zc_fallback:1;
>         unsigned int    per_io_tasks:1;
> +       unsigned int    no_ublk_fixed_fd:1;
>
>         int _evtfd;
>         int _shmid;
> @@ -166,7 +167,9 @@ struct ublk_queue {
>
>  /* borrow one bit of ublk uapi flags, which may never be used */
>  #define UBLKS_Q_AUTO_BUF_REG_FALLBACK  (1ULL << 63)
> +#define UBLKS_Q_NO_UBLK_FIXED_FD       (1ULL << 62)
>         __u64 flags;
> +       int ublk_fd;    /* cached ublk char device fd */
>         struct ublk_io ios[UBLK_QUEUE_DEPTH];
>  };
>
> @@ -273,34 +276,48 @@ static inline int ublk_io_alloc_sqes(struct ublk_th=
read *t,
>         return nr_sqes;
>  }
>
> -static inline void io_uring_prep_buf_register(struct io_uring_sqe *sqe,
> -               int dev_fd, int tag, int q_id, __u64 index)
> +static inline int ublk_get_registered_fd(struct ublk_queue *q, int fd_in=
dex)
> +{
> +       if (q->flags & UBLKS_Q_NO_UBLK_FIXED_FD) {
> +               if (fd_index =3D=3D 0)
> +                       /* Return the raw ublk FD for index 0 */
> +                       return q->ublk_fd;
> +               /* Adjust index for backing files (index 1 becomes 0, etc=
.) */
> +               return fd_index - 1;
> +       }
> +       return fd_index;
> +}
> +
> +static inline void __io_uring_prep_buf_reg_unreg(struct io_uring_sqe *sq=
e,
> +               struct ublk_queue *q, int tag, int q_id, __u64 index)
>  {
>         struct ublksrv_io_cmd *cmd =3D (struct ublksrv_io_cmd *)sqe->cmd;
> +       int dev_fd =3D ublk_get_registered_fd(q, 0);
>
>         io_uring_prep_read(sqe, dev_fd, 0, 0, 0);
>         sqe->opcode             =3D IORING_OP_URING_CMD;
> -       sqe->flags              |=3D IOSQE_FIXED_FILE;
> -       sqe->cmd_op             =3D UBLK_U_IO_REGISTER_IO_BUF;
> +       if (q->flags & UBLKS_Q_NO_UBLK_FIXED_FD)
> +               sqe->flags      &=3D ~IOSQE_FIXED_FILE;
> +       else
> +               sqe->flags      |=3D IOSQE_FIXED_FILE;
>
>         cmd->tag                =3D tag;
>         cmd->addr               =3D index;
>         cmd->q_id               =3D q_id;
>  }
>
> -static inline void io_uring_prep_buf_unregister(struct io_uring_sqe *sqe=
,
> -               int dev_fd, int tag, int q_id, __u64 index)
> +static inline void io_uring_prep_buf_register(struct io_uring_sqe *sqe,
> +               struct ublk_queue *q, int tag, int q_id, __u64 index)
>  {
> -       struct ublksrv_io_cmd *cmd =3D (struct ublksrv_io_cmd *)sqe->cmd;
> +       __io_uring_prep_buf_reg_unreg(sqe, q, tag, q_id, index);
> +       sqe->cmd_op             =3D UBLK_U_IO_REGISTER_IO_BUF;
> +}
>
> -       io_uring_prep_read(sqe, dev_fd, 0, 0, 0);
> -       sqe->opcode             =3D IORING_OP_URING_CMD;
> -       sqe->flags              |=3D IOSQE_FIXED_FILE;
> +static inline void io_uring_prep_buf_unregister(struct io_uring_sqe *sqe=
,
> +               struct ublk_queue *q, int tag, int q_id, __u64 index)
> +{
> +       __io_uring_prep_buf_reg_unreg(sqe, q, tag, q_id, index);
>         sqe->cmd_op             =3D UBLK_U_IO_UNREGISTER_IO_BUF;
> -
> -       cmd->tag                =3D tag;
> -       cmd->addr               =3D index;
> -       cmd->q_id               =3D q_id;
>  }
>
>  static inline void *ublk_get_sqe_cmd(const struct io_uring_sqe *sqe)
> @@ -396,6 +413,7 @@ static inline int ublk_queue_no_buf(const struct ublk=
_queue *q)
>         return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
>  }
>
> +
>  extern const struct ublk_tgt_ops null_tgt_ops;
>  extern const struct ublk_tgt_ops loop_tgt_ops;
>  extern const struct ublk_tgt_ops stripe_tgt_ops;
> diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftest=
s/ublk/null.c
> index f0e0003a4860..280043f6b689 100644
> --- a/tools/testing/selftests/ublk/null.c
> +++ b/tools/testing/selftests/ublk/null.c
> @@ -63,7 +63,7 @@ static int null_queue_zc_io(struct ublk_thread *t, stru=
ct ublk_queue *q,
>
>         ublk_io_alloc_sqes(t, sqe, 3);
>
> -       io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q=
, tag)->buf_index);
> +       io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q=
, tag)->buf_index);
>         sqe[0]->user_data =3D build_user_data(tag,
>                         ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
>         sqe[0]->flags |=3D IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
> @@ -71,7 +71,7 @@ static int null_queue_zc_io(struct ublk_thread *t, stru=
ct ublk_queue *q,
>         __setup_nop_io(tag, iod, sqe[1], q->q_id);
>         sqe[1]->flags |=3D IOSQE_IO_HARDLINK;
>
> -       io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io=
(q, tag)->buf_index);
> +       io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io=
(q, tag)->buf_index);
>         sqe[2]->user_data =3D build_user_data(tag, ublk_cmd_op_nr(sqe[2]-=
>cmd_op), 0, q->q_id, 1);
>
>         // buf register is marked as IOSQE_CQE_SKIP_SUCCESS
> diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selfte=
sts/ublk/stripe.c
> index 1fb9b7cc281b..791fa8dc1651 100644
> --- a/tools/testing/selftests/ublk/stripe.c
> +++ b/tools/testing/selftests/ublk/stripe.c
> @@ -142,7 +142,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread =
*t, struct ublk_queue *q,
>         ublk_io_alloc_sqes(t, sqe, s->nr + extra);
>
>         if (zc) {
> -               io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, io->b=
uf_index);
> +               io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->b=
uf_index);
>                 sqe[0]->flags |=3D IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARD=
LINK;
>                 sqe[0]->user_data =3D build_user_data(tag,
>                         ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
> @@ -168,7 +168,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread =
*t, struct ublk_queue *q,
>         if (zc) {
>                 struct io_uring_sqe *unreg =3D sqe[s->nr + 1];
>
> -               io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, io->=
buf_index);
> +               io_uring_prep_buf_unregister(unreg, q, tag, q->q_id, io->=
buf_index);
>                 unreg->user_data =3D build_user_data(
>                         tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1=
);
>         }
> diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testi=
ng/selftests/ublk/test_stress_04.sh
> index 40d1437ca298..3f901db4d09d 100755
> --- a/tools/testing/selftests/ublk/test_stress_04.sh
> +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> @@ -28,14 +28,14 @@ _create_backfile 0 256M
>  _create_backfile 1 128M
>  _create_backfile 2 128M
>
> -ublk_io_and_kill_daemon 8G -t null -q 4 -z &
> -ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
> +ublk_io_and_kill_daemon 8G -t null -q 4 -z --no_ublk_fixed_fd &
> +ublk_io_and_kill_daemon 256M -t loop -q 4 -z --no_ublk_fixed_fd "${UBLK_=
BACKFILES[0]}" &
>  ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "$=
{UBLK_BACKFILES[2]}" &
>
>  if _have_feature "AUTO_BUF_REG"; then
>         ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
>         ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKF=
ILES[0]}" &
> -       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc "${UBLK_BAC=
KFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_f=
ixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
>         ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fa=
llback &
>  fi
>
> --
> 2.47.0
>

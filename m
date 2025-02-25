Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC89DF59
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517078; cv=none; b=bk2z7580FeQfnxNRQ877Uwzbk3OpWVqpvN78EYF+JbVrsrZLLtxciQJUtKtyZEhTgC3bk67QtwRX+nkUW8dN8TADEmwtKrAaks000GSorhsF4UbEsbY/nLibtDHq6WMVPKSC8umY77M7SMXR7V6ctM4qjQBiTjexnx/FX0DKBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517078; c=relaxed/simple;
	bh=e3U+V3slQkQM1APHEBHGomDgYJ0NHRFZeNVpcdMrQ3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ou4WvRYJQPxzw2agBzK3KDx1jNn4RVpVh/0cJSt1e7B6yflV30cVMYiww/nusz7seTUxS6MtZw1QW57VELzlAFKYmotfLi3hdw720BAM8suLFPfBduvfBL7kYzv7zW14LQomRqai6CmEqIjiQY6yqw2EpyGk+6Ujvoyx6sDKRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BfqYLwYH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BfqYLwYH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2217875d103so14087365ad.3
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740517075; x=1741121875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHZNcg/WMbbrRsFYz36M2enAdsO8ptGc27RX8BteDAA=;
        b=BfqYLwYHA7ZtHgeJtlnBtaSPWocYY5wv3XtJaNTAajzMrwmLGJP4aIcN96Zv1GJI5A
         PJfhLJr0myzhIoRqgkBPP+DMHNCYGWvQvvJqopXpmdBrYEN6SDmxS01Dj4K2wpUP5lBY
         du7V/a3kGXlfYXeoLqedU2viWdyA2jbzbkZVZdZW13R1KLo7vFMC989aZfdxifyI0ShE
         HRrSI/pLQ3de5uRwfzIFSZsR+yY/QL4Fkw7x2d1dgYCt4l+CtuNamApd/xq8UIJ3OaiA
         Ui/ibpDNXsJpnEMZYnV5+mZKSaigmDxr7EsLx3W/od0y7gBVvaC2GU3Qpo115LTGH43T
         ArPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517075; x=1741121875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHZNcg/WMbbrRsFYz36M2enAdsO8ptGc27RX8BteDAA=;
        b=xBP8+v35vvzJPuvhLZNmeA2F2bwBvScgDV0R4lagIt/WZVhxXiFDNnFh13xD+aaK9M
         tT+RfFBkx5KPVJGgMqraFD2dKWETXgmPaM2qU6JPlf/45QmcTsJ/foJ0BLDJM1LeJQnS
         P6moyfG3476HI+FVMzdhhVEDaXFeR4W+rFMzoIZnvSji1eQMnjBEUsIwaA7YqP45f+P1
         Rg6KeyUYGAXxBfrhBylBJCtBx+8X9FS5rkEyercS5pnCPcMki4/0b51umRzk1dUQmSbW
         AFHnTbO15v9gJC9OMJYMeU/8G+CGgScxSIpvg0vcqFa3qJeqWX/E2WjOk1fPv0p5grLR
         HtBA==
X-Forwarded-Encrypted: i=1; AJvYcCU/nLL6DBc3tN8Saz5+9fldpqRVjxBLyECKjxYzdOUV1yc/RvX9K4kh5bmOtzl7LkO4sekIVEnUC2n/pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHDpBhE89MVcjz3k0s450EnMH6LPJn0kyWOsBTKxb0aoO13XP
	XzFN+jkUJeWw1Dgy4UKFmT8s04I5WSylZYMPQx9ofDKZ9Ae4eNqVbCfn0Q/fZVKghcbiSW3PlFN
	uWH9Mui6rxGylHirtGF28kH5Rv/9K1ERTZmiXAA==
X-Gm-Gg: ASbGncsv9vKUtL9QP+dM15BJxuUYjI9vt6rDu8Fp+dROxZPQIRFEwAPEojo88HOVNse
	DZ1WkacB4DaSi/rCFF9Xu//NXj4jqSvlMs4FAHT8ztADJvAJmMpXEVLNvFtDJUWGcEf/sFX1kxm
	yC5WlgRw==
X-Google-Smtp-Source: AGHT+IEvl7Rbnw+MGCz/Xhk8BLVEt78A3UgPSnk9wui9lNrV1yyMexiSx+Zejs/NWimd4xtrQP2t9J1NwhZcJLHQ/2w=
X-Received: by 2002:a17:903:22c6:b0:21f:f02:4154 with SMTP id
 d9443c01a7336-2219ffe0dbdmr117632525ad.11.1740517075306; Tue, 25 Feb 2025
 12:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224213116.3509093-1-kbusch@meta.com> <20250224213116.3509093-7-kbusch@meta.com>
In-Reply-To: <20250224213116.3509093-7-kbusch@meta.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 25 Feb 2025 12:57:43 -0800
X-Gm-Features: AWEUYZksu09QLGDJ9WeB5CJKmzyIaYiXkrNuGlrhy-URKy1Og8zI5S0cyuayx1c
Message-ID: <CADUfDZqmVX6Vn9euU0v9AvYGdU6BPtR7vEDBgss_8Hiv7WHuZw@mail.gmail.com>
Subject: Re: [PATCHv5 06/11] io_uring/rw: move fixed buffer import to issue path
To: Keith Busch <kbusch@meta.com>
Cc: ming.lei@redhat.com, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, bernd@bsbernd.com, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:31=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Registered buffers may depend on a linked command, which makes the prep
> path too early to import. Move to the issue path when the node is
> actually needed like all the other users of fixed buffers.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  io_uring/opdef.c |  8 ++++----
>  io_uring/rw.c    | 43 ++++++++++++++++++++++++++-----------------
>  io_uring/rw.h    |  4 ++--
>  3 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index 9344534780a02..5369ae33b5ad9 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -104,8 +104,8 @@ const struct io_issue_def io_issue_defs[] =3D {
>                 .iopoll                 =3D 1,
>                 .iopoll_queue           =3D 1,
>                 .async_size             =3D sizeof(struct io_async_rw),
> -               .prep                   =3D io_prep_read_fixed,
> -               .issue                  =3D io_read,
> +               .prep                   =3D io_prep_read,
> +               .issue                  =3D io_read_fixed,
>         },
>         [IORING_OP_WRITE_FIXED] =3D {
>                 .needs_file             =3D 1,
> @@ -118,8 +118,8 @@ const struct io_issue_def io_issue_defs[] =3D {
>                 .iopoll                 =3D 1,
>                 .iopoll_queue           =3D 1,
>                 .async_size             =3D sizeof(struct io_async_rw),
> -               .prep                   =3D io_prep_write_fixed,
> -               .issue                  =3D io_write,
> +               .prep                   =3D io_prep_write,
> +               .issue                  =3D io_write_fixed,
>         },
>         [IORING_OP_POLL_ADD] =3D {
>                 .needs_file             =3D 1,
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index db24bcd4c6335..5f37fa48fdd9b 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -348,33 +348,20 @@ int io_prep_writev(struct io_kiocb *req, const stru=
ct io_uring_sqe *sqe)
>         return io_prep_rwv(req, sqe, ITER_SOURCE);
>  }
>
> -static int io_prep_rw_fixed(struct io_kiocb *req, const struct io_uring_=
sqe *sqe,
> -                           int ddir)
> +static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_fla=
gs, int ddir)
>  {
>         struct io_rw *rw =3D io_kiocb_to_cmd(req, struct io_rw);
> -       struct io_async_rw *io;
> +       struct io_async_rw *io =3D req->async_data;
>         int ret;
>
> -       ret =3D io_prep_rw(req, sqe, ddir, false);
> -       if (unlikely(ret))
> -               return ret;
> +       if (io->bytes_done)
> +               return 0;
>
> -       io =3D req->async_data;
>         ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir=
, 0);

Shouldn't this be passing issue_flags here?

Best,
Caleb



>         iov_iter_save_state(&io->iter, &io->iter_state);
>         return ret;
>  }
>
> -int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *=
sqe)
> -{
> -       return io_prep_rw_fixed(req, sqe, ITER_DEST);
> -}
> -
> -int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe =
*sqe)
> -{
> -       return io_prep_rw_fixed(req, sqe, ITER_SOURCE);
> -}
> -
>  /*
>   * Multishot read is prepared just like a normal read/write request, onl=
y
>   * difference is that we set the MULTISHOT flag.
> @@ -1138,6 +1125,28 @@ int io_write(struct io_kiocb *req, unsigned int is=
sue_flags)
>         }
>  }
>
> +int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +       int ret;
> +
> +       ret =3D io_init_rw_fixed(req, issue_flags, ITER_DEST);
> +       if (ret)
> +               return ret;
> +
> +       return io_read(req, issue_flags);
> +}
> +
> +int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +       int ret;
> +
> +       ret =3D io_init_rw_fixed(req, issue_flags, ITER_SOURCE);
> +       if (ret)
> +               return ret;
> +
> +       return io_write(req, issue_flags);
> +}
> +
>  void io_rw_fail(struct io_kiocb *req)
>  {
>         int res;
> diff --git a/io_uring/rw.h b/io_uring/rw.h
> index a45e0c71b59d6..42a491d277273 100644
> --- a/io_uring/rw.h
> +++ b/io_uring/rw.h
> @@ -30,14 +30,14 @@ struct io_async_rw {
>         );
>  };
>
> -int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *=
sqe);
> -int io_prep_write_fixed(struct io_kiocb *req, const struct io_uring_sqe =
*sqe);
>  int io_prep_readv(struct io_kiocb *req, const struct io_uring_sqe *sqe);
>  int io_prep_writev(struct io_kiocb *req, const struct io_uring_sqe *sqe)=
;
>  int io_prep_read(struct io_kiocb *req, const struct io_uring_sqe *sqe);
>  int io_prep_write(struct io_kiocb *req, const struct io_uring_sqe *sqe);
>  int io_read(struct io_kiocb *req, unsigned int issue_flags);
>  int io_write(struct io_kiocb *req, unsigned int issue_flags);
> +int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags);
> +int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags);
>  void io_readv_writev_cleanup(struct io_kiocb *req);
>  void io_rw_fail(struct io_kiocb *req);
>  void io_req_rw_complete(struct io_kiocb *req, io_tw_token_t tw);
> --
> 2.43.5
>

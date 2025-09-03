Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442932036ED
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874579; cv=none; b=HvkT0xgnQ+qladCl4zqpZqTUJGQD1OT6c7lxjtuBWYvr3aUHX/pWi0uhgWZRWcfKWUegvHTNb+2J41F0MM4SlnZkuO65QSoPOGmlUojqPAI6WnN8NwzZYs9V01KBc8CZrArenwb5ZPhklUOWcyuXJgsh/ZF2Tg2mMYrb/ypeJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874579; c=relaxed/simple;
	bh=YoRVqqzHdH1ymhsDnHNc9Z2dTM1oNCT9Z7kdpfC+JN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBGUhdSwBZ1DVLL344whPUS2e9DdyYBvbqrAxgApeIE73PRXHL7lZR4uf3ppUaY8qy0Tb81PvsXF/av0/D3ZRyCtrd/TYeG2LadY/hLhUFUNEjloPMB600eTMeXT2Mmxx2Rkn89xNm/E/jvPPLaaPKtvrh9ckz+EKeJfh1ft7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=feVrwYnZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="feVrwYnZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0413cda0dbso63857966b.1
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756874575; x=1757479375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvvWS4ZNRj8Ogw1qmZ5IEtWa1eUP7gAqtQcjN2md2+0=;
        b=feVrwYnZRbXwygQk3MSdyt6A1qhLmMu4qQ35Rk821BvfhQvXFmjus+zsGELAEOFaBC
         Yqnh2652we2yUbli6p2oM3ol9cVCSsUY6kSzamILJmuwx4q1Leod8CeT9+1ZYP+r/J9g
         yRG4lNuwP/PzPrIXwZGGvvWgrIyG+OLbSfvqsmK40pn5tfXnv9rAUT4VS39kndw9SGX8
         xKSO0OFi2mPBjs8s+pliZyRjGhJOBemkWOd673sJATqR3ke5Tl1Vh2t4IwuMIFPRFPVj
         f85S4DO/gXIJuRgbDH9itGepy+/yiEIoYCYWnGfAZ5nKXwI/WieQIaGk3A6jY0LHgI75
         g6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756874575; x=1757479375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvvWS4ZNRj8Ogw1qmZ5IEtWa1eUP7gAqtQcjN2md2+0=;
        b=o5sGwkA3Xr+f8yOhNg8y9p46LG9JBORMTvF/+3IXI7syNnoHgP7He3RDTMcHjS//fp
         UsMmtr202HOvZ1KbeRxUydOvJ0890+EnTKmmxgfqb6MrGV+c7fNPCcSfacDUXEKcraEZ
         TWjWAZ/d2eHRrhTrytoSKVFDtDiYhDNOBt8uS6GA8laRhWTNJvASIe38k46ccSJ35gzl
         LKmzSrjgn7ZYqkENQwXvf/aaghYOqPHJlEGuEaABrFxf3zBJmVN9IerhvoK9/wz++frI
         V8Uhzzc0HVERcWqUpeCuu5BahgsuRcuYw6FqHpZsKFamMaJNBRrfEAxKc+k3ivqTUib9
         aJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVo5Xh0vWYGXOMbFLI+wzbnoreBc/1ltmb+MrJQxwFRETGPWUzYpQEi/6n4sIwi1UF69thj73qNZJm6TA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqu5wi3OPQzkXrMrhRH67gRLa4rpa6MGsRNZ4pNJFSoghdjDGY
	RRxRMtGUMrWMpf0DiguJhNvqtA4US8hshV52DjUvtFIXpgjFJiGxWQSR5qm/i+aiLXEBM8WFEqE
	L7CF+o4HrXGm01v9Y1TFRM1zOIOwrLXSdrER+VuaB1A==
X-Gm-Gg: ASbGncvnhsW6puPupPNFAGtQDQbBcPiEI1vjVQYyUIkVaUzyEWlACmB8XGszjAUO/Z6
	9WDh2uBwSOlargkQKF/ccMvLMNAz2RrFSbx2couFeaIEgDPIOoscTustcWxMrv8bHWZrEV8al9X
	GOF4Ev2ee+fy/9oCtSb4lXuMq3oojPRN5+nN190tJvzTfSDt+zKRvG6dFi3tE8v1FLtqr61lpeI
	Ih8fqeI+cRb
X-Google-Smtp-Source: AGHT+IFF/gMLpXp+WX+DZ6RGdS+YKYxIizDzTJbUXSYfB20QW9HzhZ80mUBwcZ1IwfiSu6M0s+CJdDGjj/6wqlnNwAA=
X-Received: by 2002:a05:6402:524e:b0:61e:a890:aee6 with SMTP id
 4fb4d7f45d1cf-61ea890afa7mr3959167a12.7.1756874575491; Tue, 02 Sep 2025
 21:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-5-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Sep 2025 21:42:37 -0700
X-Gm-Features: Ac12FXzwkMT0UYGMDdcOPA3OQtfvVihpadzdcdMCeaMoV-vfYo0DhOCWB1nuCcM
Message-ID: <CADUfDZrBPyPRbRmiYRXU945zG6w9pFF-4Rvu8B1rJ1WBO3tHaw@mail.gmail.com>
Subject: Re: [PATCH 04/23] ublk: add helper of __ublk_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Add helper __ublk_fetch() for the coming batch io feature.
>
> Meantime move ublk_config_io_buf() out of __ublk_fetch() because batch
> io has new interface for configuring buffer.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e53f623b0efe..f265795a8d57 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2206,18 +2206,12 @@ static int ublk_check_fetch_buf(const struct ublk=
_queue *ubq, __u64 buf_addr)
>         return 0;
>  }
>
> -static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> -                     struct ublk_io *io, __u64 buf_addr)
> +static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq=
,
> +                       struct ublk_io *io)
>  {
>         struct ublk_device *ub =3D ubq->dev;
>         int ret =3D 0;
>
> -       /*
> -        * When handling FETCH command for setting up ublk uring queue,
> -        * ub->mutex is the innermost lock, and we won't block for handli=
ng
> -        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> -        */
> -       mutex_lock(&ub->mutex);
>         /* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
>         if (ublk_queue_ready(ubq)) {
>                 ret =3D -EBUSY;
> @@ -2233,13 +2227,28 @@ static int ublk_fetch(struct io_uring_cmd *cmd, s=
truct ublk_queue *ubq,
>         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
>
>         ublk_fill_io_cmd(io, cmd);
> -       ret =3D ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
> -       if (ret)
> -               goto out;
>
>         WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub, ubq);
>  out:
> +       return ret;

If the out: section no longer releases any resources, can we replace
the "goto out" with just "return ret"?

> +}
> +
> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
> +                     struct ublk_io *io, __u64 buf_addr)
> +{
> +       struct ublk_device *ub =3D ubq->dev;
> +       int ret;
> +
> +       /*
> +        * When handling FETCH command for setting up ublk uring queue,
> +        * ub->mutex is the innermost lock, and we won't block for handli=
ng
> +        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> +        */
> +       mutex_lock(&ub->mutex);
> +       ret =3D ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
> +       if (!ret)
> +               ret =3D __ublk_fetch(cmd, ubq, io);

How come the order of operations was switched here? ublk_fetch()
previously checked ublk_queue_ready(ubq) and io->flags &
UBLK_IO_FLAG_ACTIVE first, which seems necessary to prevent
overwriting a ublk_io that has already been fetched.

Best,
Caleb


>         mutex_unlock(&ub->mutex);
>         return ret;
>  }
> --
> 2.47.0
>

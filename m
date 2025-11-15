Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F261917ED
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763184129; cv=none; b=uyAliiSrxVPevO5fh1fxnta3YJivyzZ9Ind6Wu85MT2BrMMDF3vn2IQ5QxS2eAcWB5Ro7JUvpPME6ApzJJTisqBa/KyBguAOn5Dr7tuHd6jdrawTytBdobjjIjDdYyWxo5cPKJI/kV15Q1fSkf/YVzioaIR8ly6dAxA/w5uca28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763184129; c=relaxed/simple;
	bh=hS8k7F06rNFYeFYiwRKOi1PexhqnkJ454vS3YhFeac0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMF94jLOazZ3nTNpG3Ce56UJnmvIrC/UsVVZP41OmB07Zr7DfksF0ZxOaTUkfuNr0tnaQ63UDvMgx96V4n/SLZBtUUIpHBNYJvAgTwMUdKPuGdeQLNWB7v9dAXpVUKr29tRVB98ZkGbbUHHFT78vK4MEPPZ5n+3gmq+tskV9QEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=APGqgDn9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="APGqgDn9"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436b2dbff6so476481a91.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 21:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763184125; x=1763788925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBsSHM7fT5y2x+EC8z9NX3RtxGBGTsFbqWHWZXRPamM=;
        b=APGqgDn9y0M+Vh8CmLk8yOyl0JO4Ys/kzkZ6KCHKmZoJFcCPIDpDeA4v0ajqbBKNwG
         JOamYykp0fFbLZgtz4H9ZT28pfPLPFYdZJtZSU3CW1190TbjwFtQeYXTcp0NcSLJHuBW
         iPvXWeCaxA9Q2jsXtT2Y5FWjhKDswvw9S26vA2o4Oo2a/Ygsk0Ex542FeMq2PBqV/hfw
         zsFUiMfUimRgrs/JPA5wVOuKjF380qnw31PCmX0Fd0H/ckghRfLWh95TKNdGw2B+vwS9
         4iIJL7eblwDCfhSNXNr58cxecJh2l7uNcfCcqj67RnNyBOa1dW7m7bxC7zmmARzAErsX
         0sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763184125; x=1763788925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBsSHM7fT5y2x+EC8z9NX3RtxGBGTsFbqWHWZXRPamM=;
        b=RqEUW7zFs5S0JCbN6Lyi4oEEKOsNMSHR1wt9YqckhVsPdQvlHJ+F3UyHszgGUzlHDw
         hU94RzBl+WPSTY2Sj9zBMe0/gxR2kb9jwUsFXaPIvPlZVMsbbbGx9fXG+lXvxNbwuiPb
         R0LvvCb9cnkrjuLHypC4OK77LWsLlNaW0MMihyWsWjlmTn7Qhn36IhQNqh4WavDXSTij
         W/JLFv8yxuFWeRwO5xGTzPaFI5PuhTISr52zJSpTF6Vyo3zk64aUndtZemOyc6acMRKh
         zygt060Hm4JwVwEGE7o2evKResLT1dMbjrP01L//PDTPF4pPc7o6mwiCVCbM6J7bTLRo
         gYyw==
X-Forwarded-Encrypted: i=1; AJvYcCVPT/3je+0uPO3a8ecfrvzw4jdVe5bPpZPgagYJztTuANtrjwwGihxQEcD9s1yAotmRMj3wKT88exuioA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTDh9gaaZuJEQMAc/579CUymhNJT7sq4RpTsYxoCl/aNYKPV2
	UXj0BxesztY2lPtLgup9kCcWsjdc83A6vEMt7F7axDOuxmvlE6aRCoaqNl6GMnlhA9uhCQ2mN2F
	F0PjnkJ4uDIK6mTtikaT/Gfe7Pr/sKRttOFaa9zkt3VdM4CPHkv5xmMq3yw==
X-Gm-Gg: ASbGncs7LUyBkWRC6hFpFuYiJbK20NvPJBBstfIq4p2frwUlK2we2b48GkTPaxJKliX
	0rm3cHEycdlAvU3SqMBXBdwshlFXw1KpsatMQOes0k76XLSZkbBp3KJVyeq42yg94RL1uuTFZs9
	sYhoAi17nrzmTwRcDekciNSG7xEiuzHjarWVu6fkf5F9eNENaYAz1mt8opjXbwvTiVsOgWxyAAF
	evJjVwfWbQSJbmsgJHvb0NScN2h2b8d033GKpo7nscoF5/koiokA/YKzYTy5UaclkB2rgdY
X-Google-Smtp-Source: AGHT+IG4IySd6Hhuns3wNF4GHvT+iudxqiH0YzW015eO7LFceeIxcB3T9bc9NcxM9sHK4ptkXR8Ml78JqqxOyCaLA0c=
X-Received: by 2002:a05:7022:61a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11b40b36d09mr1865035c88.0.1763184124704; Fri, 14 Nov 2025
 21:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-7-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-7-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 14 Nov 2025 21:21:53 -0800
X-Gm-Features: AWmQ_bkcipb0ogZca6jZYG0nrmRyz-Hz_7LhWZ6PCqJig3DZJ9x-d-D4Rn0U4n0
Message-ID: <CADUfDZoSiEjY0w7V1j09u1B=quJsizYKjOBQAGW61PcFtog7GA@mail.gmail.com>
Subject: Re: [PATCH V3 06/27] ublk: add helper of __ublk_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add helper __ublk_fetch() for refactoring ublk_fetch().
>
> Meantime move ublk_config_io_buf() out of __ublk_fetch() to make
> the code structure cleaner.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 46 +++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 5e83c1b2a69e..dd9c35758a46 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2234,39 +2234,41 @@ static int ublk_check_fetch_buf(const struct ublk=
_device *ub, __u64 buf_addr)
>         return 0;
>  }
>
> -static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> -                     struct ublk_io *io, __u64 buf_addr)
> +static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
> +                       struct ublk_io *io)
>  {
> -       int ret =3D 0;
> -
> -       /*
> -        * When handling FETCH command for setting up ublk uring queue,
> -        * ub->mutex is the innermost lock, and we won't block for handli=
ng
> -        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> -        */
> -       mutex_lock(&ub->mutex);
>         /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
> -       if (ublk_dev_ready(ub)) {
> -               ret =3D -EBUSY;
> -               goto out;
> -       }
> +       if (ublk_dev_ready(ub))
> +               return -EBUSY;
>
>         /* allow each command to be FETCHed at most once */
> -       if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> +       if (io->flags & UBLK_IO_FLAG_ACTIVE)
> +               return -EINVAL;
>
>         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
>
>         ublk_fill_io_cmd(io, cmd);
> -       ret =3D ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
> -       if (ret)
> -               goto out;
>
>         WRITE_ONCE(io->task, get_task_struct(current));
>         ublk_mark_io_ready(ub);
> -out:
> +
> +       return 0;
> +}
> +
> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> +                     struct ublk_io *io, __u64 buf_addr)
> +{
> +       int ret;
> +
> +       /*
> +        * When handling FETCH command for setting up ublk uring queue,
> +        * ub->mutex is the innermost lock, and we won't block for handli=
ng
> +        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> +        */
> +       mutex_lock(&ub->mutex);
> +       ret =3D __ublk_fetch(cmd, ub, io);
> +       if (!ret)
> +               ret =3D ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);

This changes ublk_config_io_buf() to be called *after*
ublk_mark_io_ready(). Is that safe? It seems like io->addr could be
read in ublk_setup_iod() as soon as the ublk device is marked as ready
for I/O.

Best,
Caleb

>         mutex_unlock(&ub->mutex);
>         return ret;
>  }
> --
> 2.47.0
>

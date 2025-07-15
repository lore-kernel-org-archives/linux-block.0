Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE5186294
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591054; cv=none; b=aRrP+JbLXSwMENzLLv3AFYRbnXiMI924ysf7l8vXg3A64Ly8YGK9YV0at0b1RGYg0XQD81QcdCo4nr1vM81fWIRsj53IvroIgnxXlTyzG9wVX1Qm3IB+HDjJ6fYTIMD72NEn2nDutz+zR4iUv97B9L7EZdPHtGGLI34MQ8D6jAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591054; c=relaxed/simple;
	bh=gKe1sUIbbK8jyT8s/CgfKFZw7kFTyXuXJdLg6LJefFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfvUq9eHf0kw98jbr5OmOcCjyoXBjm2W9KgvmfjLk9skyJMfhMUDA1KcZfgwngcdx0Sv+aEG8lYTcteMDgqgK76i6eGtVteMPOwIo3O8u6Cy6VYAgEZydCeRpgdSjPvpLRTLH7V5Y+lx4wi4miSPMAF3k+2BtGUYZvcNQzTKTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BaLuSxpX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BaLuSxpX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23e0de905a7so2042945ad.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752591051; x=1753195851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSlQRK8ycrrnU4Kvwso2bDai7Ru4c0aYIcLGfbDyDaU=;
        b=BaLuSxpXkU+3JRuceyMjZlFcACY1FPLuzPfJUHjCZvh1UT8kj7RVYHqUWKgN5ruh//
         d10EzPYATsYRYXurf+S3yXPO3eiO6BJz8pcM9M49Tx+vPcOsmuX5TaYWBgqiIbndqhaP
         20m9YtyWYVU0VDTqt0/NvLfLLRhTPpgCeh9W45PfK4uxjzWm05dvA1GxOZuuNluHjaT0
         3uV6fBVbmiNYF8jnhPjpQYTc95hZCzj802QrR1Ls7cdG9NNQwjZ2Tz7cwEQTynv9xWz0
         qWckOtWFyd4UG/MzgU7kYjod4pnWM5nlTWsUAltX97TYJJIkH4UIUvhDwUJPArO7jU0b
         9SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752591051; x=1753195851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSlQRK8ycrrnU4Kvwso2bDai7Ru4c0aYIcLGfbDyDaU=;
        b=wvV62ClNo31Rf4w8LKxbzFf4gLzP3HXIZrZHw6Hy7mGGjafldpQtZVVA4AuE5OCEVy
         7NdC/3ZKL8uyjqVU3GRuGnj/0vNq92cDphIsXr43chTV0vGITYaGKkVfsV1O+hncTA3G
         ZsSCZKaRfLUuwpUMjJMCO1BwJdrUilGRhm+kN6WwbIQmFfqeLY3w/3SLdOy3rgeQFCHC
         wBTekF/i6eqsBTLGsc5jggHbJe5PJvzxyRuLA/XczDirqmI7FgA238zgAO3ZZP7fvxPj
         zz/1GJ6pcYK6+hJJX1Evi3WxycX7hx77Bviz3dccRbaftpp+h1wZWUCUxRC7o0/Mw9Bt
         eF7g==
X-Forwarded-Encrypted: i=1; AJvYcCUKKecew98zM8GuMWIWEwwQiyWk1zx5C0XY9PmZuzVnmfDImdWbXmAA6oX0c+0ruvel5AtP2Z/60yJIsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwklXC0XBMRRcL0c2qSen9ZfdmM4wI+t8fdiJ6yvr8L03wQmkqn
	JG5FyfIn213H9qwdvCtySGZQksmLQjyDR3EJOdJwpnANqY7nd+b0a/eSK70ghD0QgHvh4v4IfYD
	HzKmucEPfFN+CwXef5Hh5dHvOx5s5rPIjbARh/Vt1rw==
X-Gm-Gg: ASbGnctZ2poMOS9OxZ1i7VSs0OQQmocv90Xr3e/5CXGze4GQ3S/zCVpJwNrmxQodOiM
	pSwpOAz7iLpkKeWLAF6+7yq2dRUv0o6WoA9t0EyZvEr5YiRlKudCwqkvmnfbBYdIeFKha/kG7f8
	UfmYcIu57/lVsV8DkUIrQpe3UouXAvh7boCnfDy3iagTRcP3qvM+UcjfUeqPs80leICdDQ+nuA9
	hAbMQ==
X-Google-Smtp-Source: AGHT+IFdd/0IF8sBQnp8JkfoyibCBx1s9uPakjHG7uI7L2nNF3vQ0W/LwA3JcJl0766D7hKoIk1lpMtioyYuwfn9/0s=
X-Received: by 2002:a17:903:1252:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-23e1e94013dmr12312615ad.8.1752591051124; Tue, 15 Jul 2025
 07:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713143415.2857561-1-ming.lei@redhat.com> <20250713143415.2857561-2-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 15 Jul 2025 10:50:39 -0400
X-Gm-Features: Ac12FXwqNY0WM26VWKw5_j9Cy_HDnLSNDjtQTFl9z01WOaBfkvC5tcUmH3EZ3nM
Message-ID: <CADUfDZrZ+SDQFC_-upFJNx2cj=xGuggvHMMubfWCaVGy_D4BjA@mail.gmail.com>
Subject: Re: [PATCH V3 01/17] ublk: validate ublk server pid
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 10:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> ublk server pid(the `tgid` of the process opening the ublk device) is sto=
red
> in `ublk_device->ublksrv_tgid`. This `tgid` is then checked against the
> `ublksrv_pid` in `ublk_ctrl_start_dev` and `ublk_ctrl_end_recovery`.
>
> This ensures that correct ublk server pid is stored in device info.
>
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver=
")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index a1a700c7e67a..2b894de29823 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -237,6 +237,7 @@ struct ublk_device {
>         unsigned int            nr_privileged_daemon;
>         struct mutex cancel_mutex;
>         bool canceling;
> +       pid_t   ublksrv_tgid;
>  };
>
>  /* header of ublk_params */
> @@ -1528,6 +1529,7 @@ static int ublk_ch_open(struct inode *inode, struct=
 file *filp)
>         if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
>                 return -EBUSY;
>         filp->private_data =3D ub;
> +       ub->ublksrv_tgid =3D current->tgid;
>         return 0;
>  }
>
> @@ -1542,6 +1544,7 @@ static void ublk_reset_ch_dev(struct ublk_device *u=
b)
>         ub->mm =3D NULL;
>         ub->nr_queues_ready =3D 0;
>         ub->nr_privileged_daemon =3D 0;
> +       ub->ublksrv_tgid =3D -1;

Should this be reset to 0? The next patch checks whether ublksrv_tgid
is 0 in ublk_timeout(). Also, the accesses to it should probably be
using {READ,WRITE}_ONCE() since ublk server open/close can happen
concurrently with ublk I/O timeout handling.

Best,
Caleb

>  }
>
>  static struct gendisk *ublk_get_disk(struct ublk_device *ub)
> @@ -2820,6 +2823,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *=
ub,
>         if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
>                 return -EINTR;
>
> +       if (ub->ublksrv_tgid !=3D ublksrv_pid)
> +               return -EINVAL;
> +
>         mutex_lock(&ub->mutex);
>         if (ub->dev_info.state =3D=3D UBLK_S_DEV_LIVE ||
>             test_bit(UB_STATE_USED, &ub->state)) {
> @@ -3321,6 +3327,9 @@ static int ublk_ctrl_end_recovery(struct ublk_devic=
e *ub,
>         pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
>                  header->dev_id);
>
> +       if (ub->ublksrv_tgid !=3D ublksrv_pid)
> +               return -EINVAL;
> +
>         mutex_lock(&ub->mutex);
>         if (ublk_nosrv_should_stop_dev(ub))
>                 goto out_unlock;
> --
> 2.47.0
>

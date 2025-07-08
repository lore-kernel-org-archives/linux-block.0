Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F8CA52
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977880; cv=none; b=kMHRhlxNEc9WHNSCy16C5wUJ1dQWe5fwHwGgqKBOHhpzJY1DKRDgElESnZFe98L9g9+IaBU06RY7PSinmBDBGSyI5b99+omtfoBgtFwJ3jFmoxQQj3MQqevozrtIoKYfCxXUmdrIfR4YI20W3rwCyUXZEbTrS2svqfpiipqOcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977880; c=relaxed/simple;
	bh=AGdnilHErE4WvOFyyPFWltUIwSTl+i9JZ94ZNPU1/Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm09djA2C0FY0HZAWybGZbmRmMqlbqhGpb/7wuJn9qVB7B+75Ix1YYBewDwJZAPNxkRevwwLl9LKU+Hb/stREcsSC9xh6msSEt1vKTA3NA0KATjsQgNZ3QrKb/Ldl6LZ3d/PosJY2msYZe5VliSSjVMiV4u2ho1hV2Gsqc5P8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SSagacsg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SSagacsg"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-312efc384fcso966363a91.3
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751977876; x=1752582676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADwjwyev8t6ODVTrzcGkPahRPOL0BA0wKbuxDTdYR5c=;
        b=SSagacsgRJiGOu4j9ukSnutfNv/1HSJ7e8DWTHm2HZEcVsirIcTa+PN67lN4VHsqp4
         681+oBfLsg86vIgA1V4t8DQ60rct19SBNBAOcoxhPd2KfzpXmVYwS1f1pOQ7tjDdA2aK
         6/1qpppsojAW687vXVm/3+0q4JJ7EJzr0Pp9ANhRKCgtzp8S06+J70IkDSGTvRNBUgHz
         caOsYrEqFL2nKD66wMyUnxXvwSqHgOlJq15pJ/VuGMBYnxCJagjtH9esCexbgu4EWIcT
         bEmI4o7PJZfdQ9TS9ezDGcOxsARs43N8hsmB8WVWCn/wAKGQDA1YZsbpOAkfoKp7OZUH
         sYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751977876; x=1752582676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADwjwyev8t6ODVTrzcGkPahRPOL0BA0wKbuxDTdYR5c=;
        b=mhAUqDg7d2zDCbKR7/UyFHFByCgs4bgWixGPE0YZJBDYLmZ0bQ0oFqvEOENppYOp9G
         mEu8AGjZ2RshlkhrBb7SQ/odInuuzAovy5GVXnILjRiApmwz8XHyrdACAvHNimCBtxOh
         ispOE/eShKlCrXHvfzjtRj0FToduRH08ZBnUKN83gfhUyweNjKEXp2H9r8RpyxE3RJ5E
         5fyA4wJL6Sgujp8olM38N7jBpH6qo2FoRz33/UXkzo/V1dj3xcGmWmIOmY1uZFFz7JgH
         JWxB0gxvmJ1aEwmtG8SBXO8XaR5E0hi0LID7AnXEhXCMX4Q6vSaPFqtwO1AjqHkSyZca
         pgXw==
X-Forwarded-Encrypted: i=1; AJvYcCUP1idp6du7emsNwAQCQEIXGkgKknWcuyJedgbl7daHAgfH/NT9TnBh3ec1L2JlBL61IsLajm/WPPrqhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvA4656VJJucN6eb65G8AJBrW6kV0niyHd8f9bGnESha2YQt1
	6oCHkSqG/0ED1f3U7cGk398hwJdbs35Jh3Ws05GRp2xz9zxNEXQfxzROVlIqXmO8WjOJ326h51Y
	I41TTfzHGhYPpesPZ5k997XXuB6r8NdwJ3D1QwON2CQ==
X-Gm-Gg: ASbGncvkGXYxzIRdhDz8PTT60zj6AChogzjx/+A6whFkPtppc37euyMA4/8SuhGFEoF
	DOcPJGP+CDXlHxpcyspiqsVn+EEK5dmh10xGPYBjfmBMHIZq/WNvUvXF7/51N5FtyHrsurrp0Xe
	DNun/Xioe4ZL0FlS0S0rWxoXcU8JbNxNikzauvpwqmc7zB
X-Google-Smtp-Source: AGHT+IFIyA/qH2A8huTe1guXPdLxrGns+s1VQh8PJC28jVrsz5fEw/soDJ2QJKbKWgAMxBlwMmKwGUnMDBG+bLFj/UU=
X-Received: by 2002:a17:90b:4d8e:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-31aac44a30amr8466896a91.2.1751977876177; Tue, 08 Jul 2025
 05:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-8-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-8-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 8 Jul 2025 08:31:05 -0400
X-Gm-Features: Ac12FXxsuNX74PZUIP2d5c5PJ3TYEgK_Kg_aaR7hSK6zuTRZEe7jKQ47wagb4Pg
Message-ID: <CADUfDZrY0H4w1PNjGiSvE0jr4dGu=UjC3nq+6ejze7kut22KLw@mail.gmail.com>
Subject: Re: [PATCH 07/16] ublk: add helper ublk_check_fetch_buf()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add helper ublk_check_fetch_buf() for checking buffer only.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

The commit message seems a bit sparse. How about something like:
Add a helper ublk_check_fetch_buf() to validate UBLK_IO_FETCH_REQ's
addr. This doesn't require access to the ublk_io, so it can be done
before taking the ublk_device mutex.

> ---
>  drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6d3aa08eef22..7fd2fa493d6a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2146,6 +2146,22 @@ static int ublk_unregister_io_buf(struct io_uring_=
cmd *cmd,
>         return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>
> +static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_=
addr)
> +{
> +       if (ublk_need_map_io(ubq)) {
> +               /*
> +                * FETCH_RQ has to provide IO buffer if NEED GET
> +                * DATA is not enabled
> +                */
> +               if (!buf_addr && !ublk_need_get_data(ubq))
> +                       return -EINVAL;
> +       } else if (buf_addr) {
> +               /* User copy requires addr to be unset */
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
>                       struct ublk_io *io, __u64 buf_addr)
>  {
> @@ -2172,19 +2188,6 @@ static int ublk_fetch(struct io_uring_cmd *cmd, st=
ruct ublk_queue *ubq,
>
>         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
>
> -       if (ublk_need_map_io(ubq)) {
> -               /*
> -                * FETCH_RQ has to provide IO buffer if NEED GET
> -                * DATA is not enabled
> -                */
> -               if (!buf_addr && !ublk_need_get_data(ubq))
> -                       goto out;

Was it a bug that this didn't set ret =3D -EINVAL before jumping to out?
Looks like ublk_fetch() would incorrectly skip initializing the
ublk_io and return 0 in this case. So probably this needs a Fixes tag.
Looks like the bug was introduced by the code movement in b69b8edfb27d
("ublk: properly serialize all FETCH_REQs").

Other than that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> -       } else if (buf_addr) {
> -               /* User copy requires addr to be unset */
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> -
>         ublk_fill_io_cmd(io, cmd, 0);
>         ret =3D ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
>         if (ret)
> @@ -2297,6 +2300,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>         io =3D &ubq->ios[tag];
>         /* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->t=
ask */
>         if (unlikely(_IOC_NR(cmd_op) =3D=3D UBLK_IO_FETCH_REQ)) {
> +               ret =3D ublk_check_fetch_buf(ubq, ub_cmd->addr);
> +               if (ret)
> +                       goto out;
>                 ret =3D ublk_fetch(cmd, ubq, io, ub_cmd->addr);
>                 if (ret)
>                         goto out;
> --
> 2.47.0
>
